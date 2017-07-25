From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Tue, 25 Jul 2017 13:25:13 +0200
Message-ID: <20170725112513.GD26723__27202.9439489872$1500981924$gmane$org@dhcp22.suse.cz>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz>
	<596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59771010.6080108@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, amit.shah@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue 25-07-17 17:32:00, Wei Wang wrote:
> On 07/24/2017 05:00 PM, Michal Hocko wrote:
> >On Wed 19-07-17 20:01:18, Wei Wang wrote:
> >>On 07/19/2017 04:13 PM, Michal Hocko wrote:
> >[...
> >>>All you should need is the check for the page reference count, no?  I
> >>>assume you do some sort of pfn walk and so you should be able to get an
> >>>access to the struct page.
> >>Not necessarily - the guest struct page is not seen by the hypervisor. The
> >>hypervisor only gets those guest pfns which are hinted as unused. From the
> >>hypervisor (host) point of view, a guest physical address corresponds to a
> >>virtual address of a host process. So, once the hypervisor knows a guest
> >>physical page is unsued, it knows that the corresponding virtual memory of
> >>the process doesn't need to be transferred in the 1st round.
> >I am sorry, but I do not understand. Why cannot _guest_ simply check the
> >struct page ref count and send them to the hypervisor?
> 
> Were you suggesting the following?
> 1) get a free page block from the page list using the API;

No. Use a pfn walk, check the reference count and skip those pages which
have 0 ref count. I suspected that you need to do some sort of the pfn
walk anyway because you somehow have to evaluate a memory to migrate,
right?

> 2) if page->ref_count == 0, send it to the hypervisor

yes

> Btw, ref_count may also change at any time.
> 
> >Is there any
> >documentation which describes the workflow or code which would use your
> >new API?
> >
> 
> It's used in the balloon driver (patch 8). We don't have any docs yet, but
> I think the high level workflow is the two steps above.

I will have a look.
-- 
Michal Hocko
SUSE Labs
