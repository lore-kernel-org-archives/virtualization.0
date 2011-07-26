From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] Re: [PATCH 5/7] Xen: fix whitespaces, tabs coding
	style issue in drivers/xen/xenbus/xenbus_client.c
Date: Tue, 26 Jul 2011 17:31:38 +0100
Message-ID: <1311697898.24408.71.camel__29538.4913021282$1311698615$gmane$org@cthulhu.hellion.org.uk>
References: <1311679009-16659-1-git-send-email-ruslan@rpisarev.org.ua>
	<4E2EE8AC.1090703@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E2EE8AC.1090703@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "ruslanpisarev@gmail.com" <ruslanpisarev@gmail.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Ruslan Pisarev <ruslan@rpisarev.org.ua>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-07-26 at 12:17 -0400, Jeremy Fitzhardinge wrote:
> On 07/26/2011 04:16 AM, ruslanpisarev@gmail.com wrote:
> > @@ -43,15 +43,15 @@
> >  const char *xenbus_strstate(enum xenbus_state state)
> >  {
> >  	static const char *const name[] = {
> > -		[ XenbusStateUnknown      ] = "Unknown",
> > -		[ XenbusStateInitialising ] = "Initialising",
> > -		[ XenbusStateInitWait     ] = "InitWait",
> > -		[ XenbusStateInitialised  ] = "Initialised",
> > -		[ XenbusStateConnected    ] = "Connected",
> > -		[ XenbusStateClosing      ] = "Closing",
> > -		[ XenbusStateClosed	  ] = "Closed",
> > -		[XenbusStateReconfiguring] = "Reconfiguring",
> > -		[XenbusStateReconfigured] = "Reconfigured",
> > +		[XenbusStateUnknown] =		"Unknown",
> > +		[XenbusStateInitialising] =	"Initialising",
> > +		[XenbusStateInitWait] =		"InitWait",
> > +		[XenbusStateInitialised] =	"Initialised",
> > +		[XenbusStateConnected] =	"Connected",
> > +		[XenbusStateClosing] =		"Closing",
> > +		[XenbusStateClosed] =		"Closed",
> > +		[XenbusStateReconfiguring] =	"Reconfiguring",
> > +		[XenbusStateReconfigured] =	"Reconfigured",
> >  	};
> 
> Eh, I think this looks worse now.

Me too.

If we're going to change this to anything I'd suggest
#define N(x) [XenbusState#x] = ##x
...
         N(Connected),
         N(Closing),
...
#undef N

(modulo my never quite remembering the cpp stringification rules first
time)

Ian.
