From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 4/5] mm: support reporting free page blocks
Date: Fri, 04 Aug 2017 16:55:22 +0800
Message-ID: <5984367A.3030809__13950.8158354603$1501836769$gmane$org@intel.com>
References: <59830897.2060203@intel.com>
	<20170803112831.GN12521@dhcp22.suse.cz>
	<5983130E.2070806@intel.com>
	<20170803124106.GR12521@dhcp22.suse.cz>
	<59832265.1040805@intel.com>
	<20170803135047.GV12521@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F73928C971@shsmsx102.ccr.corp.intel.com>
	<20170804000043-mutt-send-email-mst@kernel.org>
	<20170804075337.GC26029@dhcp22.suse.cz>
	<59842D1C.5020608@intel.com>
	<20170804082423.GG26029@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170804082423.GG26029@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 08/04/2017 04:24 PM, Michal Hocko wrote:
>
>> For our use case, the callback just puts the reported page
>> block to the ring, then returns. If the ring is full as the host
>> is busy, then I think it should skip this one, and just return.
>> Because:
>>      A. This is an optimization feature, losing a couple of free
>>           pages to report isn't that important;
>>      B. In reality, I think it's uncommon to see this ring getting
>>          full (I didn't observe ring full in the tests), since the host
>>          (consumer) is notified to take out the page block right
>>          after it is added.
> I thought you only updated a pre allocated bitmat... Anyway, I cannot
> comment on this part much as I am not familiar with your usecase.
>   

Actually the bitmap is in the hypervisor (host). The callback puts the
(pfn,size) on a ring which is shared with the hypervisor, then the
hypervisor takes that info from the ring and updates that bitmap.


Best,
Wei
