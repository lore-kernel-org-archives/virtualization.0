From: Juergen Gross <jgross@suse.com>
Subject: Re: [v2 1/1] xen, mm: Allow deferred page initialization for xen pv
	domains
Date: Tue, 27 Feb 2018 08:44:44 +0100
Message-ID: <927f2a94-2ece-53f7-3be8-532f3be77dd4@suse.com>
References: <20180226160112.24724-1-pasha.tatashin@oracle.com>
	<20180226160112.24724-2-pasha.tatashin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180226160112.24724-2-pasha.tatashin@oracle.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, akataria@vmware.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, boris.ostrovsky@oracle.com, akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, luto@kernel.org, labbott@redhat.com, kirill.shutemov@linux.intel.com, bp@suse.de, minipli@googlemail.com, jinb.park7@gmail.com, dan.j.williams@intel.com, bhe@redhat.com, zhang.jia@linux.alibaba.com, mgorman@techsingularity.net, hannes@cmpxchg.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On 26/02/18 17:01, Pavel Tatashin wrote:
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

Verified to work on a system where the original issue caused a crash.

Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Juergen Gross <jgross@suse.com>


Juergen
