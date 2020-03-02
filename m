From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 00/11] virtio-mem: paravirtualized memory
Date: Mon, 2 Mar 2020 19:41:21 +0100
Message-ID: <8de97b11-2eb5-8fe4-1867-ade57e5aee37@redhat.com>
References: <20200302134941.315212-1-david@redhat.com>
 <7f8a9225-99f2-b00d-241f-ef934395c667@redhat.com>
 <20200302182922.GT4380@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200302182922.GT4380@dhcp22.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan
List-Id: virtualization@lists.linuxfoundation.org

On 02.03.20 19:29, Michal Hocko wrote:
> On Mon 02-03-20 19:15:09, David Hildenbrand wrote:
> [...]
>> As requested by Michal, I will squash some patches.
> 
> Just to clarify. If I am the only one to care then do not bother.

Oh, I do bother about your review comments a lot :) And pulling out the
NID part from patch #2 makes a lot of sense (so I can properly squash
patch #1 into that). Looks much cleaner.

> Btw. I still have patch 6 on the todo list to review. I just didn't find
> time for it today.

Perfect, I'll definitely wait until I resend a v2 - thanks.

Cheers!

-- 
Thanks,

David / dhildenb
