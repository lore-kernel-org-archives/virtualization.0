From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
Date: Wed, 26 Jun 2019 03:48:49 +0000
Message-ID: <28C3D489-54E4-4670-B726-21B09FA469EE@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
	<20190613064813.8102-5-namit@vmware.com>
	<CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com>
Content-Language: en-US
Content-ID: <E62AD8D44ED93F48AE881F9F9D2418DD@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, kvm list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, xen-devel <xen-devel@lists.xenproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Jun 25, 2019, at 8:36 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Wed, Jun 12, 2019 at 11:49 PM Nadav Amit <namit@vmware.com> wrote:
>> To improve TLB shootdown performance, flush the remote and local TLBs
>> concurrently. Introduce flush_tlb_multi() that does so. The current
>> flush_tlb_others() interface is kept, since paravirtual interfaces need
>> to be adapted first before it can be removed. This is left for future
>> work. In such PV environments, TLB flushes are not performed, at this
>> time, concurrently.
> 
> Would it be straightforward to have a default PV flush_tlb_multi()
> that uses flush_tlb_others() under the hood?

I prefer not to have a default PV implementation that should anyhow go away.

I can create unoptimized untested versions for Xen and Hyper-V, if you want.
