From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 00/15] virtio-mem: paravirtualized memory
Date: Thu, 7 May 2020 13:23:19 +0200
Message-ID: <07b4f967-c589-fb00-61f4-38ba83be906d@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507064834-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7258-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200507064834-mutt-send-email-mst@kernel.org>
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hanne>
List-Id: virtualization@lists.linuxfoundation.org

On 07.05.20 12:48, Michael S. Tsirkin wrote:
> On Thu, May 07, 2020 at 12:31:04PM +0200, David Hildenbrand wrote:
>> This series is based on latest linux-next. The patches are located at:
>>     https://github.com/davidhildenbrand/linux.git virtio-mem-v3
>>
>> Patch #1 - #10 where contained in v2 and only contain minor modifications
>> (mostly smaller fixes). The remaining patches are new and contain smaller
>> optimizations.
> 
> 
> Looks like you lost some acks, in particular I'd like to preserve
> Andrew Morton's ack.

Yeah, seems like I only picked up Pankaj's acks. I can resend.


-- 
Thanks,

David / dhildenb
