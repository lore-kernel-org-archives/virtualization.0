From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Date: Thu, 11 Jun 2020 13:00:24 +0200
Message-ID: <13ad9edf-31a1-35ee-a0b0-6390c3a0b4d9@redhat.com>
References: <20200611093518.5737-1-david@redhat.com>
 <20200611060249-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7463-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200611060249-mutt-send-email-mst@kernel.org>
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

>> I'd like to have this patch in 5.8, with the initial merge of virtio-mem
>> if possible (so the user space representation of virtio-mem added memory
>> resources won't change anymore).
> 
> So my plan is to rebase on top of -rc1 and merge this for rc2 then.
> I don't like rebase on top of tip as the results are sometimes kind of
> random.

Right, I just wanted to get this out early so we can discuss how to proceed.

> And let's add a Fixes: tag as well, this way people will remember to
> pick this.
> Makes sense?

Yes, it's somehow a fix (for kexec). So

Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")

I can respin after -rc1 with the commit id fixed as noted by Pankaj.
Just let me know what you prefer.

Thanks!

-- 
Thanks,

David / dhildenb
