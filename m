From: Amit Shah <amit.shah@redhat.com>
Subject: Multiple port support for virtio-console
Date: Thu,  3 Sep 2009 18:23:29 +0530
Message-ID: <1251982412-11870-1-git-send-email-amit.shah__49509.1503057212$1251982650$gmane$org@redhat.com>
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
To: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello all,

Here is a new iteration of the patch series that implements a
transport for guest and host communications.

I've tested for compatibility (old qemu & new kernel, new qemu & old
kernel, new qemu & new kernel) and it all works fine*.

There are a few items on my todo list but this works well.

New since last send:
- live migration support**
- write path in the guest driver can now be called from irq context

TODO:
- Convert all config writes to little endian in qemu / convert from
little endian to host endian in guest
- Address a few FIXMEs spread in the code
- Introduce a watermark to stop a rogue host process flooding guest
with data

Conditions:
* Heavy IO on an hvc port and a non-hvc port causes memory corruption
  each time, same place. It could be realted to locking but I doubt
  that. This still has to be sorted out

** qemu now caches buffers till a char device is opened or till an
   entire write request is not received in userspace. These buffers
   aren't yet migrated.

Please review.
	Amit
