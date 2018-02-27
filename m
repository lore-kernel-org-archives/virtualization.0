From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [v2 1/1] xen, mm: Allow deferred page initialization for xen pv
	domains
Date: Tue, 27 Feb 2018 07:59:22 +0100
Message-ID: <20180227065922.u6y7bcx3pwyags2u@gmail.com>
References: <20180226160112.24724-1-pasha.tatashin@oracle.com>
	<20180226160112.24724-2-pasha.tatashin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180226160112.24724-2-pasha.tatashin@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: mhocko@suse.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, steven.sistare@oracle.com, hpa@zytor.com, dan.j.williams@intel.com, bhe@redhat.com, x86@kernel.org, akataria@vmware.com, daniel.m.jordan@oracle.com, mingo@redhat.com, xen-devel@lists.xenproject.org, bp@suse.de, minipli@googlemail.com, jinb.park7@gmail.com, luto@kernel.org, boris.ostrovsky@oracle.com, vbabka@suse.cz, jgross@suse.com, labbott@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, zhang.jia@linux.alibaba.com, hannes@cmpxchg.org, akpm@linux-foundation.org, mgorman@techsingularity.net, kirill.shutemov@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org


* Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> Juergen Gross noticed that commit
> f7f99100d8d ("mm: stop zeroing memory during allocation in vmemmap")
> broke XEN PV domains when deferred struct page initialization is enabled.
> 
> This is because the xen's PagePinned() flag is getting erased from struct
> pages when they are initialized later in boot.
> 
> Juergen fixed this problem by disabling deferred pages on xen pv domains.
> It is desirable, however, to have this feature available as it reduces boot
> time. This fix re-enables the feature for pv-dmains, and fixes the problem
> the following way:
> 
> The fix is to delay setting PagePinned flag until struct pages for all
> allocated memory are initialized, i.e. until after free_all_bootmem().
> 
> A new x86_init.hyper op init_after_bootmem() is called to let xen know
> that boot allocator is done, and hence struct pages for all the allocated
> memory are now initialized. If deferred page initialization is enabled, the
> rest of struct pages are going to be initialized later in boot once
> page_alloc_init_late() is called.
> 
> xen_after_bootmem() walks page table's pages and marks them pinned.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/include/asm/x86_init.h |  2 ++
>  arch/x86/kernel/x86_init.c      |  1 +
>  arch/x86/mm/init_32.c           |  1 +
>  arch/x86/mm/init_64.c           |  1 +
>  arch/x86/xen/mmu_pv.c           | 38 ++++++++++++++++++++++++++------------
>  mm/page_alloc.c                 |  4 ----
>  6 files changed, 31 insertions(+), 16 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
