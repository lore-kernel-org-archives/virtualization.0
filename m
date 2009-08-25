From: Amit Shah <amit.shah@redhat.com>
Subject: Extending virtio_console to support multiple ports
Date: Tue, 25 Aug 2009 11:47:20 +0530
Message-ID: <1251181044-3696-1-git-send-email-amit.shah__44430.7456295521$1251181334$gmane$org@redhat.com>
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
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hello all,

Here is a new iteration of the patch series that implements a
transport for guest and host communications.

The code has been updated to reuse the virtio-console device instead
of creating a new virtio-serial device.

I've tested for compatibility (old qemu & new kernel, new qemu & old
kernel, new qemu & new kernel) and it all works fine.

There are a few items on my todo list but this works well.

New since last send:
- connect/disconnect notifications on connections to ports

TODO:
- Look at converting to a tty interface instead of the current char
interface
- Migration: save the extra state that's necessary
- Convert all config writes to little endian in qemu / convert from
little endian to host endian in guest
- Address a few FIXMEs spread in the code
- Introduce a watermark to stop a rogue host process flooding guest
with data
- Make connect/disconnect work for guest

Please review.
	Amit
