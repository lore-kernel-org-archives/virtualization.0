From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/5] block: Introduce q->abort_queue_fn()
Date: Mon, 21 May 2012 08:42:13 -0700
Message-ID: <20120521154213.GB6549@google.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1337591313-26333-1-git-send-email-asias@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 21, 2012 at 05:08:29PM +0800, Asias He wrote:
> When user hot-unplug a disk which is busy serving I/O, __blk_run_queue
> might be unable to drain all the requests. As a result, the
> blk_drain_queue() would loop forever and blk_cleanup_queue would not
> return. So hot-unplug will fail.
> 
> This patch adds a callback in blk_drain_queue() for low lever driver to
> abort requests.
> 
> Currently, this is useful for virtio-blk to do cleanup in hot-unplug.

Why is this necessary?  virtio-blk should know that the device is gone
and fail in-flight / new commands.  That's what other drivers do.
What makes virtio-blk different?

Thanks.

-- 
tejun
