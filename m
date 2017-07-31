From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 10:37:24 +0200
Message-ID: <20170731083724.GF15767__24706.1139242307$1501490255$gmane$org@dhcp22.suse.cz>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
	<20170731065508.GE13036@dhcp22.suse.cz>
	<597EDF3D.8020101@intel.com>
	<20170731075153.GD15767@dhcp22.suse.cz>
	<32d9c53d-5310-25a7-0348-a6cf362a5dcd@youruncloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <32d9c53d-5310-25a7-0348-a6cf362a5dcd@youruncloud.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ZhenweiPi <zhenwei.pi@youruncloud.com>
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon 31-07-17 16:23:26, ZhenweiPi wrote:
> On 07/31/2017 03:51 PM, Michal Hocko wrote:
> 
> >On Mon 31-07-17 15:41:49, Wei Wang wrote:
> >>>On 07/31/2017 02:55 PM, Michal Hocko wrote:
> >>>> >On Mon 31-07-17 12:13:33, Wei Wang wrote:
> >>>>> >>Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
> >>>>> >>shouldn't be given to the host ksmd to scan.
> >>>> >Could you point me where this MADV_DONTNEED is done, please?
> >>>
> >>>Sure. It's done in the hypervisor when the balloon pages are received.
> >>>
> >>>Please see line 40 at
> >>>https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c
> >And one more thing. I am not familiar with ksm much. But how is
> >MADV_DONTNEED even helping? This madvise is not sticky - aka it will
> >unmap the range without leaving any note behind. AFAICS the only way
> >to have vma scanned is to have VM_MERGEABLE and that is an opt in:
> >See Documentation/vm/ksm.txt
> >"
> >KSM only operates on those areas of address space which an application
> >has advised to be likely candidates for merging, by using the madvise(2)
> >system call: int madvise(addr, length, MADV_MERGEABLE).
> >"
> >
> >So what exactly is going on here? The original patch looks highly
> >suspicious as well. If somebody wants to make that memory mergable then
> >the user of that memory should zero them out.
> 
> Kernel starts a kthread named "ksmd". ksmd scans the VM_MERGEABLE
> memory, and merge the same pages.(same page means memcmp(page1,
> page2, PAGESIZE) == 0).
> 
> Guest can not use ballooned pages, and these pages will not be accessed
> in a long time. Kswapd on host will swap these pages out and get more
> free memory.
> 
> Rather than swapping, KSM has better performence.  Presently pages in
> the balloon device have random value,  they usually cannot be merged.
> So enqueue zero pages will resolve this problem.
> 
> Because MADV_DONTNEED depends on host os capability and hypervisor capability,
> I prefer to enqueue zero pages to balloon device and made this patch.

So why exactly are we zeroying pages (and pay some cost for that) in
guest when we do not know what host actually does with them?
-- 
Michal Hocko
SUSE Labs
