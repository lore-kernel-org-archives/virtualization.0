From: Nick Desaulniers via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
Date: Mon, 7 Oct 2019 12:57:42 -0700
Message-ID: <CAKwvOd=hjxJYhU=C4wqkKKnLwuQjjL=wPAh6uBj-M8r8AtDdFA__7335.87026349909$1570478288$gmane$org@mail.gmail.com>
References: <20191007192129.104336-1-samitolvanen@google.com>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Kees Cook <keescook@chromium.org>, pv-drivers@vmware.com, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, clang-built-linux <clang-built-linux@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 7, 2019 at 12:21 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
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

Thanks Sami, this looks like it addresses:
Link: https://github.com/ClangBuiltLinux/linux/issues/734
Looks like GAS' testsuite has some cases where the second operand is
indeed implicitly %eax if unspecified. (This should still be fixed in
Clang).
Just to triple check that they're equivalent:
$ cat inl.s
  inl (%dx)
  inl (%dx), %eax
$ as inl.s
$ objdump -d a.out

a.out:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <.text>:
   0: ed                    in     (%dx),%eax
   1: ed                    in     (%dx),%eax

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)                           \
> -       __asm__("inl (%%dx)" :                                          \
> +       __asm__("inl (%%dx), %%eax" :                                   \
>                 "=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :            \
>                 "a"(VMWARE_HYPERVISOR_MAGIC),                           \
>                 "c"(VMWARE_CMD_##cmd),                                  \

-- 
Thanks,
~Nick Desaulniers
