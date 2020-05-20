From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 00/15] virtio-mem: paravirtualized memory
Date: Wed, 20 May 2020 09:56:48 +0200
Message-ID: <d7f18e6b-84e7-47d1-88d6-c73b5dcd8315@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
 <2603F9B2-17D0-4A05-A82B-2D3B9671A96E@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7388-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <2603F9B2-17D0-4A05-A82B-2D3B9671A96E@linux.alibaba.com>
Content-Language: en-US
To: teawater <teawaterz@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux>
List-Id: virtualization@lists.linuxfoundation.org

On 20.05.20 07:25, teawater wrote:
> Hi David,
> 
> Thanks for your work.
> I tried this version with cloud-hypervisor master.  It worked very well.
> 
> Best,
> Hui

Hi Hui,

thanks for testing!

Cheers!

-- 
Thanks,

David / dhildenb
