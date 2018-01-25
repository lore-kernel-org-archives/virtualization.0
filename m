From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v24 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 25 Jan 2018 11:32:05 +0800
Message-ID: <5A694FB5.5090803__18895.7246290103$1516850893$gmane$org@intel.com>
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com>
	<1516790562-37889-3-git-send-email-wei.w.wang@intel.com>
	<20180124183349-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180124183349-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/25/2018 01:15 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 24, 2018 at 06:42:42PM +0800, Wei Wang wrote:
> +
> +static void report_free_page_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb;
> +	unsigned long flags;
> +
> +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
> +
> +	/* Start by sending the obtained cmd id to the host with an outbuf */
> +	send_cmd_id(vb, &vb->start_cmd_id);
> +
> +	/*
> +	 * Set start_cmd_id to VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID to
> +	 * indicate a new request can be queued.
> +	 */
> +	spin_lock_irqsave(&vb->stop_update_lock, flags);
> +	vb->start_cmd_id = cpu_to_virtio32(vb->vdev,
> +				VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
> +	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> +
> +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
> Can you teach walk_free_mem_block to return the && of all
> return calls, so caller knows whether it completed?

There will be two cases that can cause walk_free_mem_block to return 
without completing:
1) host requests to stop in advance
2) vq->broken

How about letting walk_free_mem_block simply return the value returned 
by its callback (i.e. virtio_balloon_send_free_pages)?

For host requests to stop, it returns "1", and the above only bails out 
when walk_free_mem_block return a "< 0" value.

Best,
Wei
