From: Chris Wright <chrisw@sous-sol.org>
Subject: [ANNOUNCE] paravirt_ops i686 Fedora rawhide kernel packages
Date: Tue, 1 May 2007 17:39:08 -0700
Message-ID: <20070502003908.GX2819__24100.7978599102$1178150269$gmane$org@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: fedora-xen@redhat.com, xen-users@lists.xensource.com
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If you are interested in trying the new paravirt_ops kernels, I've
created some packages and uploaded them to:

  http://et.redhat.com/~chrisw/paravirt_ops/

There you'll find a yum repo (see yum.README for details) and an
INSTALL file for getting started.  With this package you can use a
single kernel[1] for both native (w/out a hypervisor, or under a full
virt hypervisor), domU paravirt under Xen, and a VMI guest.  There is no
support for dom0 kernels ATM.  Running the kernel native is as simple as
installing and rebooting.  However, it requires some manual intervention
to get a domU started (see INSTALL for details).

thanks,
-chris

[1] It's not quite a single kernel.  It's two separate binaries built from
the identical vmlinux.  This is due to the Xen domain builder's inability
to boot a bzImage format kernel binary.  Fixing this is on the todo list.
