From: Amit Shah <amit.shah@qumranet.com>
Subject: PV DMA for PCI passthrough devices for KVM
Date: Tue, 29 Apr 2008 13:37:28 +0300
Message-ID: <1209465451-3758-1-git-send-email-amit.shah__2569.74683511562$1209465626$gmane$org@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: chrisw@redhat.com, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org


This patchset implements PVDMA for handling DMA requests from
devices assigned to the guest from the host machine.

They're also available from

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.git pvdma

These patches are based on my pci-passthrough tree, which is available
from

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.git

and the userspace from

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm-userspace.git

The first and the third patch in this series is needed on the guest (with some
bits from the 2nd as well). The 2nd patch is meant for the host kernel.

Amit.
