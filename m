From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 1/4] xen kconfig: keep XEN_XENBUS_FRONTEND
	builtin
Date: Thu, 12 Jan 2012 09:37:45 -0500
Message-ID: <20120112143745.GE7685@phenom.dumpdata.com>
References: <20120111172832.GB4449@phenom.dumpdata.com>
	<e37e8bec-f4ec-4420-81f0-da0ef90a6120@zmail13.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e37e8bec-f4ec-4420-81f0-da0ef90a6120@zmail13.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>, waldi@debian.org
Cc: konrad@darnok.org, jeremy@goop.org, xen-devel@lists.xensource.com, stefano stabellini <stefano.stabellini@eu.citrix.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 05:49:57AM -0500, Andrew Jones wrote:
> 
> 
> ----- Original Message -----
> > On Wed, Jan 11, 2012 at 05:36:38PM +0100, Andrew Jones wrote:
> > > When XEN_XENBUS_FRONTEND gets selected as a module it can lead to
> > > unbootable configs. If we need it, then we should just build it in.
> > 
> > Hm, don't the frontends by themsevles load this module? So if you
> > do 'modprobe xen-pcifront' it would load this automatically?
> > 
> 
> The problem is on boot, getting it there before we need xen-blkfront.
> I think it might solvable if you make sure your tooling pushes the
> xenbus module into your initrd. However we've had problems with

So it seems we also need patches for dracut and initramfs here?

Or is it possible to make the modules (fb) try to load xenbus frontend
automatically? Preferrably one would do this:

modprobe xen_fbfront
which would then automatically load xenbus_module, xen_kbdfront

Better yet if udev/kudzu figured out this automtically and loaded
the modules.

Is there a mechanism to automatically have udev do all of this loading?
Let CC the Debian maintainer on this converstation as he might have
some ideas in this.


> platform_pci being a module in the past, and if I'm not mistaken

Right, but that driver is not tied in with the frontends. It just
pokes at the ioport to disable QEMU HVM drivers.

> that was one of the motivators for building it in (5fbdc10395cd). I
> see this as a similar story.
> 
> Drew
> 
> > > 
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >  drivers/xen/Kconfig |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > index 8795480..1d24061 100644
> > > --- a/drivers/xen/Kconfig
> > > +++ b/drivers/xen/Kconfig
> > > @@ -118,7 +118,7 @@ config XEN_SYS_HYPERVISOR
> > >  	 but will have no xen contents.
> > >  
> > >  config XEN_XENBUS_FRONTEND
> > > -	tristate
> > > +	bool
> > >  
> > >  config XEN_GNTDEV
> > >  	tristate "userspace grant access device driver"
> > > --
> > > 1.7.7.5
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xensource.com
> > http://lists.xensource.com/xen-devel
> > 
