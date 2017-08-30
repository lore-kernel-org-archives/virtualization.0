From: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH v2 1/7] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Wed, 30 Aug 2017 09:33:52 +0200
Message-ID: <a9eceaa9-65c8-1eb3-7a31-3e7a4800cf04__21626.3116607026$1504078455$gmane$org@suse.com>
References: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
	<1504007201-12904-2-git-send-email-yang.zhang.wz@gmail.com>
	<20170829135548.GG32175@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170829135548.GG32175@char.us.oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Yang Zhang <yang.zhang.wz@gmail.com>, xen-devel@lists.xensource.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, rkrcmar@redhat.com, kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, wanpeng.li@hotmail.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Chris Wright <chrisw@sous-sol.org>, Andy Lutomirski <luto@kernel.org>, dmatlack@google.com, tglx@linutronix.de, Quan Xu <quan.xu0@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 29/08/17 15:55, Konrad Rzeszutek Wilk wrote:
> On Tue, Aug 29, 2017 at 11:46:35AM +0000, Yang Zhang wrote:
>> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called in
>> idle path which will polling for a while before we enter the real idle
>> state.
>>
>> In virtualization, idle path includes several heavy operations
>> includes timer access(LAPIC timer or TSC deadline timer) which will hurt
>> performance especially for latency intensive workload like message
>> passing task. The cost is mainly come from the vmexit which is a
>> hardware context switch between VM and hypervisor. Our solution is to
>> poll for a while and do not enter real idle path if we can get the
>> schedule event during polling.
>>
>> Poll may cause the CPU waste so we adopt a smart polling mechanism to
>> reduce the useless poll.
>>
>> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
>> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
>> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> Cc: Alok Kataria <akataria@vmware.com>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
> 
> Adding xen-devel.
> 
> Juergen, we really should replace Jeremy's name with xen-devel or
> your name..

I wouldn't mind being added. What does Jeremy think of being removed?

> Wasn't there an patch by you that took some of the 
> mainternship over it?

I added include/linux/hypervisor.h to the PARAVIRT section and offered
to maintain it in case the PARAVIRT maintainers didn't want to.


Juergen
