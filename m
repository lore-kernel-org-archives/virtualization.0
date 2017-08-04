From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v13 4/5] mm: support reporting free page blocks
Date: Fri, 4 Aug 2017 10:24:23 +0200
Message-ID: <20170804082423.GG26029__11640.6761495911$1501835555$gmane$org@dhcp22.suse.cz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59842D1C.5020608@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 04-08-17 16:15:24, Wei Wang wrote:
> On 08/04/2017 03:53 PM, Michal Hocko wrote:
> >On Fri 04-08-17 00:02:01, Michael S. Tsirkin wrote:
> >>On Thu, Aug 03, 2017 at 03:20:09PM +0000, Wang, Wei W wrote:
> >>>On Thursday, August 3, 2017 9:51 PM, Michal Hocko:
> >>>>As I've said earlier. Start simple optimize incrementally with some numbers to
> >>>>justify a more subtle code.
> >>>>--
> >>>OK. Let's start with the simple implementation as you suggested.
> >>>
> >>>Best,
> >>>Wei
> >>The tricky part is when you need to drop the lock and
> >>then restart because the device is busy. Would it maybe
> >>make sense to rotate the list so that new head
> >>will consist of pages not yet sent to device?
> >No, I this should be strictly non-modifying API.
> 
> 
> Just get the context here for discussion:
> 
>     spin_lock_irqsave(&zone->lock, flags);
>     ...
>     visit(opaque2, pfn, 1<<order);
>     spin_unlock_irqrestore(&zone->lock, flags);
> 
> The concern is that the callback may cause the lock be
> taken too long.
> 
> 
> I think here we can have two options:
> - Option 1: Put a Note for the callback: the callback function
>     should not block and it should finish as soon as possible.
>     (when implementing an interrupt handler, we also have
>     such similar rules in mind, right?).

absolutely

> For our use case, the callback just puts the reported page
> block to the ring, then returns. If the ring is full as the host
> is busy, then I think it should skip this one, and just return.
> Because:
>     A. This is an optimization feature, losing a couple of free
>          pages to report isn't that important;
>     B. In reality, I think it's uncommon to see this ring getting
>         full (I didn't observe ring full in the tests), since the host
>         (consumer) is notified to take out the page block right
>         after it is added.

I thought you only updated a pre allocated bitmat... Anyway, I cannot
comment on this part much as I am not familiar with your usecase.
 
> - Option 2: Put the callback function outside the lock
>     What's input into the callback is just a pfn, and the callback
>     won't access the corresponding pages. So, I still think it won't
>     be an issue no matter what status of the pages is after they
>     are reported (even they doesn't exit due to hot-remove).

This would make the API implementation more complex and I am not yet
convinced we really need that.

-- 
Michal Hocko
SUSE Labs
