From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/3] virtio-balloon: replace the coarse-grained
	balloon_lock
Date: Tue, 24 Oct 2017 09:46:25 +0800
Message-ID: <59EE9B71.6030008__10066.3750003607$1508809488$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>	<1508500466-21165-2-git-send-email-wei.w.wang@intel.com>	<201710221420.FHG17654.OOMFQSFJVFHLtO@I-love.SAKURA.ne.jp>	<59EC7FF5.6070906@intel.com>
	<201710222050.GIF35945.FHOMQFOVSFLtOJ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201710222050.GIF35945.FHOMQFOVSFLtOJ@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/22/2017 07:50 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>>>> @@ -162,20 +160,20 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>>>>    			msleep(200);
>>>>    			break;
>>>>    		}
>>>> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>>>> -		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>>>> +		set_page_pfns(vb, pfns + num_pfns, page);
>>>>    		if (!virtio_has_feature(vb->vdev,
>>>>    					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>>>    			adjust_managed_page_count(page, -1);
>>>>    	}
>>>>    
>>>> -	num_allocated_pages = vb->num_pfns;
>>>> +	mutex_lock(&vb->inflate_lock);
>>>>    	/* Did we get any? */
>>>> -	if (vb->num_pfns != 0)
>>>> -		tell_host(vb, vb->inflate_vq);
>>>> -	mutex_unlock(&vb->balloon_lock);
>>>> +	if (num_pfns != 0)
>>>> +		tell_host(vb, vb->inflate_vq, pfns, num_pfns);
>>>> +	mutex_unlock(&vb->inflate_lock);
>>>> +	atomic64_add(num_pfns, &vb->num_pages);
>>> Isn't this addition too late? If leak_balloon() is called due to
>>> out_of_memory(), it will fail to find up to dated vb->num_pages value.
>> Not really. I think the old way of implementation above:
>> "vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE"
>> isn't quite accurate, because "vb->num_page" should reflect the number of
>> pages that have already been inflated, which means those pages have
>> already been given to the host via "tell_host()".
>>
>> If we update "vb->num_page" earlier before tell_host(), then it will
>> include the pages
>> that haven't been given to the host, which I think shouldn't be counted
>> as inflated pages.
>>
>> On the other hand, OOM will use leak_balloon() to release the pages that
>> should
>> have already been inflated.
> But leak_balloon() finds max inflated pages from vb->num_pages, doesn't it?
>
>>>>    
>>>>    	/* We can only do one array worth at a time. */
>>>> -	num = min(num, ARRAY_SIZE(vb->pfns));
>>>> +	num = min_t(size_t, num, VIRTIO_BALLOON_ARRAY_PFNS_MAX);
>>>>    
>>>> -	mutex_lock(&vb->balloon_lock);
>>>>    	/* We can't release more pages than taken */
>>>> -	num = min(num, (size_t)vb->num_pages);
>>>> -	for (vb->num_pfns = 0; vb->num_pfns < num;
>>>> -	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
>>>> +	num = min_t(size_t, num, atomic64_read(&vb->num_pages));
>>>> +	for (num_pfns = 0; num_pfns < num;
>>>> +	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
>>>>    		page = balloon_page_dequeue(vb_dev_info);
>>> If balloon_page_dequeue() can be concurrently called by both host's request
>>> and guest's OOM event, is (!dequeued_page) test in balloon_page_dequeue() safe?
>>
>> I'm not sure about the question. The "dequeue_page" is a local variable
>> in the function, why would it be unsafe for two invocations (the shared
>> b_dev_info->pages are operated under a lock)?
> I'm not MM person nor virtio person. I'm commenting from point of view of
> safe programming. My question is, isn't there possibility of hitting
>
> 	if (unlikely(list_empty(&b_dev_info->pages) &&
> 		     !b_dev_info->isolated_pages))
> 		BUG();
>
> when things run concurrently.

Thanks for the comments. I'm not 100% confident about all the possible 
corner cases here at present
(e.g. why is the b_dev_info->page_lock released and re-gained in 
balloon_page_dequeue()), and
Michael has given a preference of the solution, so I plan not to stick 
with this one.

Best,
Wei
