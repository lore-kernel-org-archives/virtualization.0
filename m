From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Tue, 10 Mar 2020 12:20:36 +0100
Message-ID: <cf819bce-0480-bef1-cfe4-367893795ed5@redhat.com>
References: <20200310103903.6014-1-david@redhat.com>
 <20200310070413-mutt-send-email-mst@kernel.org>
 <78427916-fc17-b081-6b1e-cbcb00d51752@redhat.com>
 <20200310071844-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310071844-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 10.03.20 12:19, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 12:12:50PM +0100, David Hildenbrand wrote:
>>>>  static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
>>>> @@ -971,7 +950,22 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>>>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>>>>  		spin_lock_init(&vb->free_page_list_lock);
>>>>  		INIT_LIST_HEAD(&vb->free_page_list);
>>>> +		/*
>>>> +		 * We're allowed to reuse any free pages, even if they are
>>>> +		 * still to be processed by the host.
>>>> +		 */
>>>> +		err = virtio_balloon_register_shrinker(vb);
>>>> +		if (err)
>>>> +			goto out_del_balloon_wq;
>>>>  	}
>>>> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
>>>> +		vb->oom_nb.notifier_call = virtio_balloon_oom_notify;
>>>> +		vb->oom_nb.priority = VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
>>>> +		err = register_oom_notifier(&vb->oom_nb);
>>>> +		if (err < 0)
>>>> +			goto out_unregister_shrinker;
>>>> +	}
>>>> +
>>>
>>>
>>> Let's decide whether we want an empty line after }, or not, and stick to
>>> it. I prefer an empty line but no biggie as long as we are consistent.
>>
>> Can add one.
>>
>>>
>>>>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>>>>  		/* Start with poison val of 0 representing general init */
>>>>  		__u32 poison_val = 0;
>>>> @@ -986,15 +980,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>>>  		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
>>>>  			      poison_val, &poison_val);
>>>>  	}
>>>> -	/*
>>>> -	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
>>>> -	 * shrinker needs to be registered to relieve memory pressure.
>>>> -	 */
>>>> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
>>>> -		err = virtio_balloon_register_shrinker(vb);
>>>> -		if (err)
>>>> -			goto out_del_balloon_wq;
>>>> -	}
>>>>  
>>>>  	vb->pr_dev_info.report = virtballoon_free_page_report;
>>>>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
>>>> @@ -1003,12 +988,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>>>  		capacity = virtqueue_get_vring_size(vb->reporting_vq);
>>>>  		if (capacity < PAGE_REPORTING_CAPACITY) {
>>>>  			err = -ENOSPC;
>>>> -			goto out_unregister_shrinker;
>>>> +			goto out_unregister_oom;
>>>>  		}
>>>>  
>>>>  		err = page_reporting_register(&vb->pr_dev_info);
>>>>  		if (err)
>>>> -			goto out_unregister_shrinker;
>>>> +			goto out_unregister_oom;
>>>>  	}
>>>>  
>>>>  	virtio_device_ready(vdev);
>>>> @@ -1017,8 +1002,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>>>  		virtballoon_changed(vdev);
>>>>  	return 0;
>>>>  
>>>> +out_unregister_oom:
>>>> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>>> +		unregister_oom_notifier(&vb->oom_nb);
>>>>  out_unregister_shrinker:
>>>> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>>> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>>>>  		virtio_balloon_unregister_shrinker(vb);
>>>
>>>
>>> What's with vdev versus vb->vdev here?
>>> I suggest we keep using vb->vdev to make the patch minimal if we can.
>>> Same elsewhere.
>>
>> As we touch this line either way, does it really make a difference? No
>> strong opinion. Can just do a vb->vdev and clean this up globally later.
>>
> 
> Let's just be consistent. I guess that means keep using vb->vdev
> everywhere.

It's already really inconsistent, so I'll use vb->vdev in this patch and
cleanup the other users later.

-- 
Thanks,

David / dhildenb
