From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86, paravirt: Fix bool return type for PVOP_CALL
Date: Thu, 8 Dec 2016 17:50:13 +0100
Message-ID: <20161208165013.GM3107@twins.programming.kicks-ass.net>
References: <20161208154213.952687487@infradead.org>
	<20161208154349.346057680@infradead.org>
	<474f05c8-8bca-f68f-6499-ce7b424ff984@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <474f05c8-8bca-f68f-6499-ce7b424ff984@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, x86@kernel.org, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, kernel test robot <xiaolong.ye@intel.com>, Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 09, 2016 at 12:40:35AM +0800, Pan Xinhui wrote:
> 
> hi, Peter
> 	I think I know the point.
> 
> then could we just let __eax rettype(here is bool), not unsigned long?
> I does not do tests for my thoughts.
> 
> @@ -461,7 +461,9 @@ int paravirt_disable_iospace(void);
>  #define PVOP_VCALL_ARGS                                                        \
>         unsigned long __eax = __eax, __edx = __edx, __ecx = __ecx;      \
>         register void *__sp asm("esp")
> -#define PVOP_CALL_ARGS                 PVOP_VCALL_ARGS
> +#define PVOP_CALL_ARGS 					\
> +       rettype __eax = __eax, __edx = __edx, __ecx = __ecx;    \
> +       register void *__sp asm("esp")

Doesn't work on i386 where eax is also an argument register.
