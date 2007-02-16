From: "Christian Limpach" <Christian.Limpach@xensource.com>
Subject: RE: [patch 14/21] Xen-paravirt: Add XEN config options
	and disableunsupported config options.
Date: Fri, 16 Feb 2007 02:00:39 -0800
Message-ID: <BBC437B5B077FF46935BA1D8C9A2172A01EBEBF4@exch2.ad.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ian Pratt <Ian.Pratt@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Andrew Morton wrote:
> > On Thu, 15 Feb 2007 22:14:45 -0800 Dan Hecht=20
> <dhecht@vmware.com> wrote:
> >
> >  =20
> >>>  config PREEMPT
> >>>  	bool "Preemptible Kernel (Low-Latency Desktop)"
> >>> +	depends on !XEN
> >>>  	help
> >>>  	  This option reduces the latency of the kernel by making
> >>>  	  all kernel code (that is not executing in a critical section)
> >>>
> >>>      =20
> >
> > Oh, so that's why it doesn't break when CONFIG_PREEMPT=3Dy. =20
> In which case
> > that preempt_disable() I spotted is wrong-and-unneeded.
> >
> > Why doesn't Xen work with preemption??
> >  =20
>=20
> I've forgotten the details.  Ian?  Keir?  Steven?  Maybe it=20
> can be done.

With CONFIG_PREEMPT, we can have preempted threads reference machine
addresses across save/restore.  After restore, these machine addresses
will be incorrect.

    Christian
