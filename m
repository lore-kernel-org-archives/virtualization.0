From: Amit Shah <amit.shah@redhat.com>
Subject: virtio-serial: A guest <-> host interface for simple communication
Date: Tue, 23 Jun 2009 18:12:31 +0530
Message-ID: <1245760953-32139-1-git-send-email-amit.shah__35754.9960296184$1245761038$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Hello,

Here are two patches. One implements a virtio-serial device in qemu
and the other is the driver for a guest kernel.

While working on a vmchannel interface that is needed for communication
between guest userspace and host userspace, I saw that most of the
interface can be abstracted out as a "serial" device with "ports".

Some requirements for a vmchannel are listed at this page:
http://kvm.et.redhat.com/page/VMchannel_Requirements

A few sample uses for a vmchannel are to share the host and guest
clipboards (to allow copy/paste between a host and a guest), to
lock the screen of the guest session when the vnc viewer is closed,
to find out which applications are installed on a guest OS even when
the guest is powered down (using virt-inspector) and so on.

At this time, the qemu device is more complete than the guest driver
is. However, I'd like you to review both the patches for inclusion.

Thanks,
		Amit.
