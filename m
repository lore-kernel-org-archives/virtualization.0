From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v24 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 25 Jan 2018 20:28:52 +0900
Message-ID: <17068749-d2c7-61bb-4637-a1aee5a0d0fb__48920.4440535561$1516881808$gmane$org@I-love.SAKURA.ne.jp>
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com>
	<1516790562-37889-3-git-send-email-wei.w.wang@intel.com>
	<20180124183349-mutt-send-email-mst@kernel.org>
	<5A694FB5.5090803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5A694FB5.5090803@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018/01/25 12:32, Wei Wang wrote:
> On 01/25/2018 01:15 AM, Michael S. Tsirkin wrote:
>> On Wed, Jan 24, 2018 at 06:42:42PM +0800, Wei Wang wrote:
>> +
>> +static void report_free_page_func(struct work_struct *work)
>> +{
>> +    struct virtio_balloon *vb;
>> +    unsigned long flags;
>> +
>> +    vb = container_of(work, struct virtio_balloon, report_free_page_work);
>> +
>> +    /* Start by sending the obtained cmd id to the host with an outbuf */
>> +    send_cmd_id(vb, &vb->start_cmd_id);
>> +
>> +    /*
>> +     * Set start_cmd_id to VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID to
>> +     * indicate a new request can be queued.
>> +     */
>> +    spin_lock_irqsave(&vb->stop_update_lock, flags);
>> +    vb->start_cmd_id = cpu_to_virtio32(vb->vdev,
>> +                VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
>> +    spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> +
>> +    walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> Can you teach walk_free_mem_block to return the && of all
>> return calls, so caller knows whether it completed?
> 
> There will be two cases that can cause walk_free_mem_block to return without completing:
> 1) host requests to stop in advance
> 2) vq->broken
> 
> How about letting walk_free_mem_block simply return the value returned by its callback (i.e. virtio_balloon_send_free_pages)?
> 
> For host requests to stop, it returns "1", and the above only bails out when walk_free_mem_block return a "< 0" value.

I feel that virtio_balloon_send_free_pages is doing too heavy things.

It can be called for many times with IRQ disabled. Number of times
it is called depends on amount of free pages (and fragmentation state).
Generally, more free pages, more calls.

Then, why don't you allocate some pages for holding all pfn values
and then call walk_free_mem_block() only for storing pfn values
and then send pfn values without disabling IRQ?
