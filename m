From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Thu, 6 Feb 2020 10:05:43 +0100
Message-ID: <a5dc8a7c-7384-5efa-e251-1cd9a240e73a@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200206013724-mutt-send-email-mst@kernel.org>
 <51955928-5a4b-c922-ee34-6e94b6cdd385@redhat.com>
 <20200206034916-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206034916-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

>> commit bf50e69f63d21091e525185c3ae761412be0ba72
>> Author: Dave Hansen <dave@linux.vnet.ibm.com>
>> Date:   Thu Apr 7 10:43:25 2011 -0700
>>
>>     virtio balloon: kill tell-host-first logic
>>
>>     The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
>>     feature bit.  Whenever the bit is set, the guest kernel must
>>     always tell the host before we free pages back to the allocator.
>>     Without this feature, we might free a page (and have another
>>     user touch it) while the hypervisor is unprepared for it.
>>
>>     But, if the bit is _not_ set, we are under no obligation to
>>     reverse the order; we're under no obligation to do _anything_.
>>     As of now, qemu-kvm defines the bit, but doesn't set it.
> 
> Well this is not what the spec says in the end.

I didn't check the spec, maybe I should do that :)

> To continue that commit message:
> 
>     This patch makes the "tell host first" logic the only case.  This
>     should make everybody happy, and reduce the amount of untested or
>     untestable code in the kernel.

Yeah, but this comment explains that the current deflate is only in
place, because it makes the code simpler (to support both cases). Of
course, doing the deflate might result in performance improvements.
(e.g., MADV_WILLNEED)

> 
> you can try proposing the change to the virtio TC, see what do others
> think.

We can just drop the comment from this patch for now. The tell_host host
not be an issue AFAIKS.

-- 
Thanks,

David / dhildenb
