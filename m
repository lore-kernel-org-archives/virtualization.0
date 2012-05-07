From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3] virtio-blk: Fix hot-unplug race in remove method
Date: Mon, 07 May 2012 14:31:04 +0930
Message-ID: <87sjfcega7.fsf@rustcorp.com.au>
References: <1336120789-12076-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1336120789-12076-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  4 May 2012 16:39:49 +0800, Asias He <asias@redhat.com> wrote:
> If we reset the virtio-blk device before the requests already dispatched
> to the virtio-blk driver from the block layer are finised, we will stuck
> in blk_cleanup_queue() and the remove will fail.
> 
> blk_cleanup_queue() calls blk_drain_queue() to drain all requests queued
> before DEAD marking. However it will never success if the device is
> already stopped. We'll have q->in_flight[] > 0, so the drain will not
> finish.
> 
> How to reproduce the race:
> 1. hot-plug a virtio-blk device
> 2. keep reading/writing the device in guest
> 3. hot-unplug while the device is busy serving I/O
> 
> Test:
> ~1000 rounds of hot-plug/hot-unplug test passed with this patch.
> 
> Changes in v3:
> - Drop blk_abort_queue and blk_abort_request
> - Use __blk_end_request_all to complete request dispatched to driver
> 
> Changes in v2:
> - Drop req_in_flight
> - Use virtqueue_detach_unused_buf to get request dispatched to driver
> 
> Signed-off-by: Asias He <asias@redhat.com>

Thanks, applied.

Cheers,
Rusty.
