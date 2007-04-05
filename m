From: Zachary Amsden <zach@vmware.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Wed, 04 Apr 2007 22:17:48 -0700
Message-ID: <4614867C.4060506@vmware.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46144FA6.1000802@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> It's not *quite* that easy.  The assembly code around this is pretty =

> extensive, because it has to stand on its head in order to present the =

> proper register image.
>   =


Having just stood on my head for 55 breaths, might I suggest we =

implement a binary equivalent CPUID paravirt-ops wrapper; then the =

assembly code can just call CPUID and we can redefine it to call to a =

stub, which makes the pv-ops CPUID call, the puts the outputs back in =

the proper registers.

The VMI ROM CPUID is binary identical in register format with the native =

instruction, so it need not do a headstand.  For the others,

ENTRY(paravirt_raw_cpuid)
    pushl %edx
    pushl %ecx
    pushl %ebx
    pushl %eax
    mov %esp, %eax    /* pointer for eax in/out */
    leal 4(%esp), %edx /* pointer for ebx in/out */
    leal 8(%esp), %ecx /* pointer for ecx in/out */
    leal 12(%esp), %ebx /* pointer for edx in/out */
    pushl %ebx  /* arg 4 passed on stack */
    call *(paravirt_ops+pv_offset_CPUID)
    addl $4, %esp
    popl %eax
    popl %ebx
    popl %ecx
    popl %edx
    ret

Should do the right thing.  In any case, thanks for the heads up.

Zach
