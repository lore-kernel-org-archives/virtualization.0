From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Wed, 19 Jul 2017 20:01:18 +0800
Message-ID: <596F4A0E.4010507__23326.2971313254$1500465535$gmane$org@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170719081311.GC26779@dhcp22.suse.cz>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, amit.shah@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 07/19/2017 04:13 PM, Michal Hocko wrote:
> On Tue 18-07-17 10:12:14, Wei Wang wrote:
> [...]
>> Probably I should have included the introduction of the usages in
>> the log. Hope it is not too later to explain here:
> Yes this should have been described in the cover.


OK, I will do it in the next version.


>   
>> Live migration needs to transfer the VM's memory from the source
>> machine to the destination round by round. For the 1st round, all the VM's
>> memory is transferred. From the 2nd round, only the pieces of memory
>> that were written by the guest (after the 1st round) are transferred. One
>> method that is popularly used by the hypervisor to track which part of
>> memory is written is to write-protect all the guest memory.
>>
>> This patch enables the optimization of the 1st round memory transfer -
>> the hypervisor can skip the transfer of guest unused pages in the 1st round.
> All you should need is the check for the page reference count, no?  I
> assume you do some sort of pfn walk and so you should be able to get an
> access to the struct page.


Not necessarily - the guest struct page is not seen by the hypervisor. The
hypervisor only gets those guest pfns which are hinted as unused. From the
hypervisor (host) point of view, a guest physical address corresponds to a
virtual address of a host process. So, once the hypervisor knows a guest
physical page is unsued, it knows that the corresponding virtual memory of
the process doesn't need to be transferred in the 1st round.


Best,
Wei
