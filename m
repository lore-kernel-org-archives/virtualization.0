From: Amit Shah <amit.shah@qumranet.com>
Subject: PCI Passthrough support for KVM
Date: Thu, 10 Apr 2008 14:39:17 +0530
Message-ID: <41536.9837232449$1207818742@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: kvm-devel@lists.sourceforge.net
Cc: chrisw@redhat.com, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patchset introduces PCI passthrough support for KVM.

This has been tested with an Ethernet device. The device is
seen in the guest and interrupts are generated. However, no
data transfer can take place unless pvdma or reserved-ram
is used. The patches for pvdma will be available shortly.

Sharing of interrupt line for the PCI device on the host side
will cause slowness (and / or some glitches). Also, proper
locking isn't in place yet. Single VMs exploiting this feature
run well though.

There also is a git repository for you to explore:

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.git
git-pull git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm-userspace.git

Comments, feedback welcome.

Amit.
