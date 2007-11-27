From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 27 Nov 2007 17:14:04 +0000
Message-ID: <474C5E6C.76E4.0078.0@novell.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4744BB54.4040803@goop.org>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com><de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
	<474B15FC.4050901@goop.org>
	<474BE3D1.76E4.0078.0@novell.com><474BE3D1.76E4.0078.0@novell.com>
	<474C4D1D.9020700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <474C4D1D.9020700@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Juan Quintela <juan.quintela@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

>The oops and backtrace doesn't suggest it's an MSR write.  Does a crX

Oh, right, the MSR write is being ignored, not failed.

>write take the same path through the emulator as an MSR write?

No, the two operations take different paths.

Jan
