From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with shrinker
Date: Tue, 24 Jul 2018 09:49:20 +0800
Message-ID: <5B5685A0.9040005__1011.51360800049$1532396587$gmane$org@intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
	<1532075585-39067-3-git-send-email-wei.w.wang@intel.com>
	<20180722174125-mutt-send-email-mst@kernel.org>
	<5B55AE56.5030404@intel.com>
	<20180723170826-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180723170826-mutt-send-email-mst@kernel.org>
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

On 07/23/2018 10:13 PM, Michael S. Tsirkin wrote:
>>>    	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>>>    #endif
>>> +	err = virtio_balloon_register_shrinker(vb);
>>> +	if (err)
>>> +		goto out_del_vqs;
>>> So we can get scans before device is ready. Leak will fail
>>> then. Why not register later after device is ready?
>> Probably no.
>>
>> - it would be better not to set device ready when register_shrinker failed.
> That's very rare so I won't be too worried.

Just a little confused with the point here. "very rare" means it still 
could happen (even it's a corner case), and if that happens, we got 
something wrong functionally. So it will be a bug if we change like 
that, right?

Still couldn't understand the reason of changing shrinker_register after 
device_ready (the original oom notifier was registered before setting 
device ready too)?
(I think the driver won't get shrinker_scan called if device isn't ready 
because of the reasons below)

>> - When the device isn't ready, ballooning won't happen, that is,
>> vb->num_pages will be 0, which results in shrinker_count=0 and shrinker_scan
>> won't be called.

Best,
Wei
