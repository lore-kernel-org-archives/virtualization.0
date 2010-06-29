From: Chetan Loke <chetanloke@gmail.com>
Subject: Hypervisor detection from within a Linux VM
Date: Tue, 29 Jun 2010 17:25:10 -0400
Message-ID: <AANLkTinl3ighc51F5V4YP7fuOSscAA_qcynYMtM5j5wk__41573.5623254024$1278005294$gmane$org@mail.gmail.com>
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, chetanloke@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hello,


Requirement:
I have the need to support my apps(running on a Linux VM) on different
*nix hypervisors(ESX/Xen etc). I need to know on which hypervisor my
app is running. I read the CPUID usage thread -
http://thread.gmane.org/gmane.comp.emulators.kvm.devel/22643 but to be
honest in the end I looked at
http://lxr.linux.no/#linux+v2.6.34/arch/x86/kernel/cpu/vmware.c#L88
The vmware_platform() detection code is straight forward.

Current-hack:
As a quick hack we just grep lspci for VMware's pci-ids.

Solution:
I can write a bare minimal driver, check the cpu-id as VMware's
balloon driver does and then emit a proc/sysfs node. The setup
packages and the apps can then check for this node-string.I'm
currently working on ESX and I am hoping that this thin-driver will
work.

Question:
Q1)Is it possible to get this functionality as part of the stock
kernel or is that a bad idea? I suspect there could be other
users/apps who would need to know what *nix hypervisor(or a
non-virtualized environment) they are
running on?
Q2)If this is not the right approach then can someone please suggest
another approach?

Regards
Chetan Loke
