From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v25 2/2] virtio-balloon:
	VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 26 Jan 2018 09:40:44 +0800
Message-ID: <5A6A871C.6040408__36930.0066413873$1516930601$gmane$org@intel.com>
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
	<1516871646-22741-3-git-send-email-wei.w.wang@intel.com>
	<20180125154708-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180125154708-mutt-send-email-mst@kernel.org>
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

On 01/25/2018 09:49 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 25, 2018 at 05:14:06PM +0800, Wei Wang wrote:
>> +
>> +static void report_free_page_func(struct work_struct *work)
>> +{
>> +	struct virtio_balloon *vb;
>> +	int ret;
>> +
>> +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
>> +
>> +	/* Start by sending the received cmd id to host with an outbuf */
>> +	ret = send_cmd_id(vb, vb->cmd_id_received);
>> +	if (unlikely(ret))
>> +		goto err;
>> +
>> +	ret = walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> +	if (unlikely(ret < 0))
>> +		goto err;
>> +
>> +	/* End by sending a stop id to host with an outbuf */
>> +	ret = send_cmd_id(vb, VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID);
>> +	if (likely(!ret))
>> +		return;
>> +err:
>> +	dev_err(&vb->vdev->dev, "%s failure: free page vq is broken\n",
>> +		__func__);
>> +}
>> +
> So that's very simple, but it only works well if the whole
> free list fits in the queue or host processes the queue faster
> than the guest. What if it doesn't?

This is the case that the virtqueue gets full, and I think we've agreed 
that this is an optimization feature and losing some hints to report 
isn't important, right?

Actually, in the tests, there is no chance to see the ring is full. If 
we check the host patches that were shared before, the device side 
operation is quite simple, it just clears the related bits from the 
bitmap, and then continues to take entries from the virtqueue till the 
virtqueue gets empty.


> If we had restartability you could just drop the lock
> and wait for a vq interrupt to make more progress, which
> would be better I think.
>

Restartability means that caller needs to record the state where it was 
when it stopped last time. The controversy is that the free list is not 
static once the lock is dropped, so everything is dynamically changing, 
including the state that was recorded. The method we are using is more 
prudent, IMHO. How about taking the fundamental solution, and seek to 
improve incrementally in the future?


Best,
Wei
