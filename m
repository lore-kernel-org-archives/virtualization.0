From: Christoph Hellwig <hch@lst.de>
Subject: Re: virt_blk BUG: sleeping function called from invalid context
Date: Sun, 29 Jun 2014 21:32:22 +0200
Message-ID: <20140629193222.GA7030__37857.3174508803$1404070790$gmane$org@lst.de>
References: <CA+5PVA4h2hQJLrAm4eEZ8oUgGiAjq2y5eAyBcJWxK_FiQXnuQg@mail.gmail.com>
	<20140629082637.GA23942@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140629082637.GA23942@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, Josh Boyer <jwboyer@fedoraproject.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Brian Lane <bcl@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 29, 2014 at 11:26:37AM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 27, 2014 at 07:57:38AM -0400, Josh Boyer wrote:
> > Hi All,
> > 
> > We've had a report[1] of the virt_blk driver causing a lot of spew
> > because it's calling a sleeping function from an invalid context.  The
> > backtrace is below.  This is with kernel v3.16-rc2-69-gd91d66e88ea9.
> 
> Hi Jens, pls see below - it looks like the call to blk_mq_end_io
> from IRQ context is causing the issue.
> IIUC you switched virtio to this from __blk_end_request_all in
> 
> commit 1cf7e9c68fe84248174e998922b39e508375e7c1
>     virtio_blk: blk-mq support
> 
> Is this always safe?
> I note that at least one other driver is doing this:
> drivers/block/mtip32xx/mtip32xx.c

Just like __blk_end_request_all blk_mq_end_io is supposed to be called
from irq context.  The problem is that the MD bio end_io handler is calling
a sleeping function.  Not sure if that's a bug in MD though given the
kernfs symbols in the all trace and the recent churn in that area.
