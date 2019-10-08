From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
Date: Mon, 7 Oct 2019 17:44:14 -0700
Message-ID: <201910071743.1C48038A@keescook>
References: <20191007192129.104336-1-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191007192129.104336-1-samitolvanen@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 07, 2019 at 12:21:29PM -0700, Sami Tolvanen wrote:
> LLVM's assembler doesn't accept the short form inl (%%dx) instruction,
> but instead insists on the output register to be explicitly specified:
> 
>   <inline asm>:1:7: error: invalid operand for instruction
>           inl (%dx)
>              ^
>   LLVM ERROR: Error parsing inline asm
> 
> Use the full form of the instruction to fix the build.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/cpu/vmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 9735139cfdf8..46d732696c1c 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -49,7 +49,7 @@
>  #define VMWARE_CMD_VCPU_RESERVED 31
>  
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
> -	__asm__("inl (%%dx)" :						\
> +	__asm__("inl (%%dx), %%eax" :					\
>  		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
>  		"a"(VMWARE_HYPERVISOR_MAGIC),				\
>  		"c"(VMWARE_CMD_##cmd),					\
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
