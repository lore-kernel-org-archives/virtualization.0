From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RFD: virtio balloon API use (was Re: [PATCH 5 of 5] virtio: expose
	added descriptors immediately)
Date: Sun, 1 Jul 2012 12:20:51 +0300
Message-ID: <20120701092051.GA4515@redhat.com>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization <virtualization@lists.linux-foundation.org>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 06:12:53PM +1030, Rusty Russell wrote:
> A virtio driver does virtqueue_add_buf() multiple times before finally
> calling virtqueue_kick(); previously we only exposed the added buffers
> in the virtqueue_kick() call.  This means we don't need a memory
> barrier in virtqueue_add_buf(), but it reduces concurrency as the
> device (ie. host) can't see the buffers until the kick.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Looking at recent mm compaction patches made me look at locking
in balloon closely. And I noticed the referenced patch (commit
ee7cd8981e15bcb365fc762afe3fc47b8242f630 upstream) interacts strangely
with virtio balloon; balloon currently does:

static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
{
        struct scatterlist sg;

        sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);

        init_completion(&vb->acked);

        /* We should always be able to add one buffer to an empty queue. */
        if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
                BUG();
        virtqueue_kick(vq);

        /* When host has read buffer, this completes via balloon_ack */
        wait_for_completion(&vb->acked);
}


While vq callback does:

static void balloon_ack(struct virtqueue *vq)
{
        struct virtio_balloon *vb;
        unsigned int len;

        vb = virtqueue_get_buf(vq, &len);
        if (vb)
                complete(&vb->acked);
}


So virtqueue_get_buf might now run concurrently with virtqueue_kick.
I audited both and this seems safe in practice but I think
we need to either declare this legal at the API level
or add locking in driver.

Further, is there a guarantee that we never get
spurious callbacks? We currently check ring not empty
but esp for non shared MSI this might not be needed.
If a spurious callback triggers, virtqueue_get_buf can run
concurrently with virtqueue_add_buf which is known to be racy.
Again I think this is currently safe as no spurious callbacks in
practice but should we guarantee no spurious callbacks at the API level
or add locking in driver?

-- 
MST
