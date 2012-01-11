From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH 2/4 v2] xen kconfig: relax
	INPUT_XEN_KBDDEV_FRONTEND deps
Date: Wed, 11 Jan 2012 11:29:20 -0500 (EST)
Message-ID: <7e004a73-b1ef-49f4-91e8-68fdf48c3ccb@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120111161130.GA18203@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111161130.GA18203@andromeda.dapyr.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, FlorianSchandinat@gmx.de, dmitry torokhov <dmitry.torokhov@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Mon, Jan 09, 2012 at 06:51:41PM +0100, Andrew Jones wrote:
> > PV-on-HVM guests may want to use the xen keyboard/mouse frontend,
> > but
> > they don't use the xen frame buffer frontend. For this case it
> > doesn't
> 
> Ok, but PV does?
> > make much sense for INPUT_XEN_KBDDEV_FRONTEND to depend on
> > XEN_FBDEV_FRONTEND. The opposite direction always makes more sense,
> > i.e.
> > if you're using xenfb, then you'll want xenkbd. Switch the
> > dependencies.
> 
> That sounds like it would be universal irregardless if it is
> PV or PVonHVM?

This patch makes it such that if you want to use both, then you must
select both. It also says that if you want FB, then you need the
KBD. However, if you only want the KBD then you're fine with just
that. So there isn't any risk of breaking configs designed to use
FB, because FB should be manually selected for those configs anyway.

Drew

> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  drivers/input/misc/Kconfig |    2 +-
> >  drivers/video/Kconfig      |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/misc/Kconfig
> > b/drivers/input/misc/Kconfig
> > index 22d875f..36c15bf 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -533,7 +533,7 @@ config INPUT_CMA3000_I2C
> >  
> >  config INPUT_XEN_KBDDEV_FRONTEND
> >  	tristate "Xen virtual keyboard and mouse support"
> > -	depends on XEN_FBDEV_FRONTEND
> > +	depends on XEN
> >  	default y
> >  	select XEN_XENBUS_FRONTEND
> >  	help
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index d83e967..3e38c2f 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -2263,7 +2263,7 @@ config FB_VIRTUAL
> >  
> >  config XEN_FBDEV_FRONTEND
> >  	tristate "Xen virtual frame buffer support"
> > -	depends on FB && XEN
> > +	depends on FB && XEN && INPUT_XEN_KBDDEV_FRONTEND
> >  	select FB_SYS_FILLRECT
> >  	select FB_SYS_COPYAREA
> >  	select FB_SYS_IMAGEBLIT
> > --
> > 1.7.7.5
> > 
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xensource.com
> > http://lists.xensource.com/xen-devel
> 
