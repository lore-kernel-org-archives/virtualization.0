From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 23 Jul 2018 18:30:46 +0800
Message-ID: <5B55AE56.5030404__8134.27011385119$1532341474$gmane$org@intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
	<1532075585-39067-3-git-send-email-wei.w.wang@intel.com>
	<20180722174125-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180722174125-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/22/2018 10:48 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 04:33:02PM +0800, Wei Wang wrote:
>>   
>> +static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>> +						  struct shrink_control *sc)
>> +{
>> +	unsigned long pages_to_free = balloon_pages_to_shrink,
>> +		      pages_freed = 0;
>> +	struct virtio_balloon *vb = container_of(shrinker,
>> +					struct virtio_balloon, shrinker);
>> +
>> +	/*
>> +	 * One invocation of leak_balloon can deflate at most
>> +	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>> +	 * multiple times to deflate pages till reaching
>> +	 * balloon_pages_to_shrink pages.
>> +	 */
>> +	while (vb->num_pages && pages_to_free) {
>> +		pages_to_free = balloon_pages_to_shrink - pages_freed;
>> +		pages_freed += leak_balloon(vb, pages_to_free);
>> +	}
>> +	update_balloon_size(vb);
> Are you sure that this is never called if count returned 0?

Yes. Please see do_shrink_slab, it just returns if count is 0.

>
>> +
>> +	return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
>> +}
>> +
>> +static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>> +						   struct shrink_control *sc)
>> +{
>> +	struct virtio_balloon *vb = container_of(shrinker,
>> +					struct virtio_balloon, shrinker);
>> +
>> +	/*
>> +	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to handle the
>> +	 * case when shrinker needs to be invoked to relieve memory pressure.
>> +	 */
>> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>> +		return 0;
> So why not skip notifier registration when deflate on oom
> is clear?

Sounds good, thanks.


>   	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>   #endif
> +	err = virtio_balloon_register_shrinker(vb);
> +	if (err)
> +		goto out_del_vqs;
>   
> So we can get scans before device is ready. Leak will fail
> then. Why not register later after device is ready?

Probably no.

- it would be better not to set device ready when register_shrinker failed.
- When the device isn't ready, ballooning won't happen, that is, 
vb->num_pages will be 0, which results in shrinker_count=0 and 
shrinker_scan won't be called.

So I think it would be better to have shrinker registered before 
device_ready.

Best,
Wei
