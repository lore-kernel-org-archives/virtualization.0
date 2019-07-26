From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 4/9] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Fri, 26 Jul 2019 09:28:01 +0200
Message-ID: <3fc06d95-5f17-4642-cd91-49a0f70057c0__14187.4375332677$1564126117$gmane$org@suse.com>
References: <20190719005837.4150-1-namit@vmware.com>
	<20190719005837.4150-5-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190719005837.4150-5-namit@vmware.com>
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
To: Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 19.07.19 02:58, Nadav Amit wrote:
> To improve TLB shootdown performance, flush the remote and local TLBs
> concurrently. Introduce flush_tlb_multi() that does so. Introduce
> paravirtual versions of flush_tlb_multi() for KVM, Xen and hyper-v (Xen
> and hyper-v are only compile-tested).
> 
> While the updated smp infrastructure is capable of running a function on
> a single local core, it is not optimized for this case. The multiple
> function calls and the indirect branch introduce some overhead, and
> might make local TLB flushes slower than they were before the recent
> changes.
> 
> Before calling the SMP infrastructure, check if only a local TLB flush
> is needed to restore the lost performance in this common case. This
> requires to check mm_cpumask() one more time, but unless this mask is
> updated very frequently, this should impact performance negatively.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   arch/x86/hyperv/mmu.c                 | 10 +++---
>   arch/x86/include/asm/paravirt.h       |  6 ++--
>   arch/x86/include/asm/paravirt_types.h |  4 +--
>   arch/x86/include/asm/tlbflush.h       |  8 ++---
>   arch/x86/include/asm/trace/hyperv.h   |  2 +-
>   arch/x86/kernel/kvm.c                 | 11 +++++--
>   arch/x86/kernel/paravirt.c            |  2 +-
>   arch/x86/mm/tlb.c                     | 47 ++++++++++++++++++---------
>   arch/x86/xen/mmu_pv.c                 | 11 +++----
>   include/trace/events/xen.h            |  2 +-
>   10 files changed, 62 insertions(+), 41 deletions(-)

Xen and paravirt parts: Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
