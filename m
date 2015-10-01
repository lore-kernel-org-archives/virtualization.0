From: "Thomas D." <whissi@whissi.de>
Subject: Re: req->nr_phys_segments > queue_max_segments (was Re: kernel BUG at
	drivers/block/virtio_blk.c:172!)
Date: Thu, 1 Oct 2015 13:55:39 +0200
Message-ID: <560D1F3B.3000400@whissi.de>
References: <560C87F6.4080708@whissi.de>
	<20151001114817-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151001114817-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Michael S. Tsirkin wrote:
> To debug this,
> maybe you can print out sg_elems at init time and when this fails,
> to make sure some kind of memory corruption
> does not change sg_elems after initialization?

If that was addressed to me could you please tell me how to do that?


-Thomas
