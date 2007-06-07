From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 0/3] Virtio draft II
Date: Thu, 07 Jun 2007 22:02:41 +1000
Message-ID: <1181217762.14054.192.camel__23634.3235047118$1181217892$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi again all,

	It turns out that networking really wants ordered requests, which the
previous patches didn't allow.  This patch changes it to a callback
mechanism; kudos to Avi.

	The downside is that locking is more complicated, and after a few dead
ends I implemented the simplest solution: the struct virtio_device
contains the spinlock to use, and it's held when your callbacks get
called.

Core changes:
1) struct virtio_device has a "lock" and "priv" fields (the latter for
the driver to use, esp from callbacks).
2) add_outbuf and add_inbuf take a cb function ptr and void *, rather
than a used pointer.
3) lengths of buffers must now fit in an unsigned int, not long.
4) the virtio_sync wrapper is gone.

Block driver changes (+30 lines)
1) Convert to callbacks not interrupt.
2) Ensure both outbuf & inbuf have been used up before finishing
request.  This avoids potential remote access to freed memory.

Net driver changes (+6 lines)
1) Convert to callbacks.
2) Store id in skb->cb, not array.
3) Remove NET_BUFS limit: we queue packets until virtio chokes.
4) Locking should now be correct, thanks mainly to virtio changes.

BTW, the lguest implementations (very rough) are in the lguest patch
repo for your viewing pleasure:

Implementation over dumb read/write interface:
http://lguest.ozlabs.org/patches/?file/tip/new-io-lguest-readwrite.patch
Implementation using descriptors (assuming host can access guest mem):
http://lguest.ozlabs.org/patches/?file/tip/new-io-lguest-desc.patch

Cheers,
Rusty.
