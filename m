From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: Re: [Xen-devel] State of Xen in upstream Linux
Date: Fri, 1 Aug 2008 09:34:53 +0100
Message-ID: <20080801083453.GB23993@redhat.com>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-users-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-users@lists.xensource.com>
List-Help: <mailto:xen-users-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=subscribe>
Sender: xen-users-bounces@lists.xensource.com
Errors-To: xen-users-bounces@lists.xensource.com
To: Grant McWilliams <grantmasterflash@gmail.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 31, 2008 at 10:54:38AM -0700, Grant McWilliams wrote:
> >
> >
> > > Fedora 9's kernel-xen package has been based on the mainline kernel from
> > > the outset, but it is still packaged as a separate kernel.  kernel-xen
> > > has been dropped from rawhide (what will become Fedora 10), and all Xen
> > > support - both 32 and 64 bit - has been rolled into the main kernel
> > > package.
> >
> 
> Does this mean in the future all Fedora kernels will be Xen kernels? Is this
> wise? If I try to run VirtualBox on a Xen kernel the machine will reboot. If
> the Vbox module is loaded at runtime it will reboot forever. Yes, I know
> it's a Vbox issue but what about KVM. Can we run KVM on a Xen kernel?

The way paravirt_ops works is that the single kernel image has built in
support for a number of hypervisors, as well as, bare metal. When it boots
one of the first things the kernel does it probe to find what its running
on. It then switches in the various Xen, KVM or VMWare specific functions
as required for that platform, or continues running as bare metal. The
Fedora kernels have Xen, KVM and VMI support enabled by default now as
of Fedora 10 (VMI is 32-bit only). Basically it should 'just work' and
do the right thing out of the box.

VirtualBox is using out of tree kernel modules so all bets are off as to
whether it works on any particular kernel. If virtualbox is important to
you, then encourage their developers to get the functionality they need
into the mainline kernel because that's the only way it'll be supportable
long term. We can't guarentee that it won't break in a future Fedora 
kernel update as long as it is out of tree.

Regards,
Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
