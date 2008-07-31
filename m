From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 10:08:45 +0100
Message-ID: <20080731090845.GH23888@redhat.com>
References: <48910C99.10606@goop.org>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-users-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <48910C99.10606@goop.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-users@lists.xensource.com>
List-Help: <mailto:xen-users-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=subscribe>
Sender: xen-users-bounces@lists.xensource.com
Errors-To: xen-users-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 30, 2008 at 05:51:37PM -0700, Jeremy Fitzhardinge wrote:
> Now that Xen can directly boot a bzImage format kernel, distros have a
> lot of flexibilty in how they package Xen.  A single grub.conf entry can
> be used to boot either a native kernel (via normal grub), or a
> paravirtualized Xen kernel (via pygrub), without modification.
> 
> Fedora 9's kernel-xen package has been based on the mainline kernel from
> the outset, but it is still packaged as a separate kernel.  kernel-xen
> has been dropped from rawhide (what will become Fedora 10), and all Xen
> support - both 32 and 64 bit - has been rolled into the main kernel
> package.

An important thing to note is that support in Xen userspace to boot
from a bzImage is fairly new - so if you have any existing Xen based
products/distros you should check that it has bzImage support if you
want to be guarenteed able to boot mainline kernels.  We're pushing
updates to existing Fedora/RHEL Xen userspace RPMs to enable bzImage 
support. 

IIRC the primary changeset you'll need from xen-unstable is this one:

  changeset:   17332:db943e8d1051
  user:        Keir Fraser <keir.fraser@citrix.com>
  date:        Tue Apr 01 10:09:33 2008 +0100
  files:       tools/libxc/Makefile tools/libxc/xc_dom_bzimageloader.c tools/libxc/xc_dom_elfloader.c
  description:
  x86: Support loading Linux bzImage v2.08 and up.

  The latest -mm kernel (2.6.25-rc3-mm1) contains v2.08 of the Linux
  bzImage format which embeds an ELF file in place of the raw payload
  allowing it to be extracted and used by the Xen domain builder.

  It is expected that this functionality will be put forward for 2.6.26.

  Signed-off-by : Ian Campbell <ijc@hellion.org.uk>


Regards,
Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
