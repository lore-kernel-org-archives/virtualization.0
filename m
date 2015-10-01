From: "Thomas D." <whissi@whissi.de>
Subject: Re: req->nr_phys_segments > queue_max_segments (was Re: kernel BUG at
	drivers/block/virtio_blk.c:172!)
Date: Thu, 1 Oct 2015 13:58:55 +0200
Message-ID: <560D1FFF.1090700@whissi.de>
References: <560C87F6.4080708@whissi.de>
	<20151001114817-mutt-send-email-mst@redhat.com>
	<20151001101604.GA24150@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151001101604.GA24150@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Jens Axboe wrote:
> Looking at the specific virtio_blk case, it does seem that it is
> checking the segment count before mapping. Does the below fix the
> problem, or does the BUG_ON() still trigger?

Have I understood you correctly, that I should test your patch against
linux-4.1.8?



PS: I upgraded several other systems (they are using dm with LUKS too
but are all ext4, no XFS like this VM) to linux-4.1.9, too and they all
freezed while running (booting was never a problem like with the system
using XFS). Some of them were running for hours until they freezed, some
freezed just seconds after start up finished.

Because I haven't seen the BUG_ON on any of these systems before with
linux-4.1.8 I am not sure if this is the same problem (and the system
with XFS from where I showed you the trace seems to boot fine with
linux-4.1.9 but now freezes, too). Any idea how to debug the freeze?


PS2: On Google I found
http://oss.sgi.com/pipermail/xfs/2014-November/039105.html -- that's why
I am mentioning that I am using XFS (and except to the file system the
VM is identical with the other VMs which didn't show any problems until
linux-4.1.9). I cannot find the patch from
http://oss.sgi.com/pipermail/xfs/2014-November/039149.html in the kernel
mainline. Is it worth to check that direction, too or doesn't the trace
indicate any relationship?


Thanks!


-Thomas
