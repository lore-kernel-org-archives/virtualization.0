From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/4 v2] xen kconfig: relax INPUT_XEN_KBDDEV_FRONTEND deps
Date: Thu, 12 Jan 2012 05:59:36 -0500 (EST)
Message-ID: <16672c9d-d57d-44b4-8220-049a2d0e3a3f@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120111173009.GC4449@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111173009.GC4449@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, stefano stabellini <stefano.stabellini@eu.citrix.com>, dmitry.torokhov@gmail.com, FlorianSchandinat@gmx.de, virtualization@lists.linux-foundation.org, konrad@darnok.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Wed, Jan 11, 2012 at 05:36:39PM +0100, Andrew Jones wrote:
> > PV-on-HVM guests may want to use the xen keyboard/mouse frontend,
> > but
> > they don't use the xen frame buffer frontend. For this case it
> > doesn't
> > make much sense for INPUT_XEN_KBDDEV_FRONTEND to depend on
> > XEN_FBDEV_FRONTEND. The opposite direction always makes more sense,
> > i.e.
> 
> What is the disadvantege of keeping it as is?

If you don't want FB, but you do want KBD, then you're stuck with FB
anyway, even though it isn't necessary. Perhaps I'm the only one who
ever considering building a config without FB?

> 
> > if you're using xenfb, then you'll want xenkbd. Switch the
> > dependencies.
> > 
> You are missing the CC to the proper maintainer.
> 

I added them the last time you reminded me. See the following
message-ids for the thread where this patch was discussed and then
led to the V2 here.

20120109075911.GA4049@core.coreip.homeip.net
725950ad-d5cf-4ddb-9870-a5c8d75cfa51@zmail13.collab.prod.int.phx2.redhat.com
1326131501-9610-1-git-send-email-drjones@redhat.com

I've re-added them to this thread, since the multiple
posting/reposting must have lost them again.

> Also, did you test this with PV and PVonHVM guests?

Testing-wise you don't really need to do much more then
'make oldconfig'. FB doesn't work on pv-on-hvm, the mod wouldn't
even init if you tried as there's a

        if (!xen_pv_domain())
                return -ENODEV;

I have tested a pv-on-hvm guest after this patch with FB off though,
which worked. For PV guests using FB, they'll work the same, as you
wouldn't want to change your config.

Drew

> 
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
> 
