From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Date: Mon, 30 Mar 2020 10:16:59 +0200
Message-ID: <055ec03c-06e5-ef06-691d-7a19d8b2792a@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
 <20200329084128-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7004-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200329084128-mutt-send-email-mst@kernel.org>
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hanne>
List-Id: virtualization@lists.linuxfoundation.org

On 29.03.20 14:42, Michael S. Tsirkin wrote:
> On Wed, Mar 11, 2020 at 06:14:12PM +0100, David Hildenbrand wrote:
>> This series is based on latest linux-next. The patches are located at:
>>     https://github.com/davidhildenbrand/linux.git virtio-mem-v2
>>
>> I now have acks for all !virtio-mem changes. I'll be happy to get review
>> feedback, testing reports, etc. for the virtio-mem changes. If there are
>> no further comments, I guess this is good to go as a v1 soon.
> 
> I'd like to queue it for merge after the release. If you feel it's ready
> please ping me after the release to help make sure it didn't get
> dropped.  I see there were some reports about people having trouble
> using this, pls keep working on this meanwhile.
> 

Yes, will ping you. The cloud-hypervisor implementation has already been
merged. I'll be posting the initial QEMU version once the next release
is close.

Thanks!

> Thanks!


-- 
Thanks,

David / dhildenb
