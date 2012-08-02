From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 4/4] virtio-blk: Add REQ_FLUSH and REQ_FUA support
	to bio path
Date: Thu, 2 Aug 2012 08:27:42 +0200
Message-ID: <20120802062742.GA23573@lst.de>
References: <1343888757-25723-1-git-send-email-asias@redhat.com>
	<1343888757-25723-5-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343888757-25723-5-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 02, 2012 at 02:25:56PM +0800, Asias He wrote:
> We need to support both REQ_FLUSH and REQ_FUA for bio based path since
> it does not get the sequencing of REQ_FUA into REQ_FLUSH that request
> based drivers can request.
> 
> REQ_FLUSH is emulated by:
> 1. Send VIRTIO_BLK_T_FLUSH to device
> 2. Wait until the flush is finished

There is no need to wait for the flush to finish if the REQ_FLUSH
request has no data payload.

Even if it has a payload waiting is highly suboptimal and it should
use a non-blocking sequencing like it is done in the request layer.

> 
> REQ_FUA is emulated by:
> 1. Send the actual write
> 2. Wait until the actual write is finished
> 3. Send VIRTIO_BLK_T_FLUSH to device
> 4. Wait until the flush is finished
> 5. Signal the end of the write to upper layer

The same comment about not blocking applies here as well.
