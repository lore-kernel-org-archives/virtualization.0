From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] x86_64 paravirt_ops port
Date: Mon, 8 Jan 2007 17:00:33 -0800
Message-ID: <20070109010033.GD19575@sequoia.sous-sol.org>
References: <20070108140826.GA1624@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070108140826.GA1624@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Glauber de Oliveira Costa (gcosta@redhat.com) wrote:
> I've been working on a port of paravirt_ops for the x86_64 architectures
> for a couple of days. Here's the result so far. I'm posting it soon for
> early cooments. The more, the better.

Thanks a lot for getting this started Glauber.  As Rusty mentioned,
we'll want to follow the no export paravirt_ops motion upstream
for x86_64 as well.

> Index: linux-2.6.19-quilt/arch/x86_64/kernel/entry.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-quilt.orig/arch/x86_64/kernel/entry.S
> +++ linux-2.6.19-quilt/arch/x86_64/kernel/entry.S
> @@ -1064,6 +1064,22 @@ KPROBE_ENTRY(int3)
>   	CFI_ENDPROC
>  KPROBE_END(int3)
>  =

> +#ifdef CONFIG_PARAVIRT
> +ENTRY(native_iret)
> +1:	iretq
> +.section __ex_table,"a"
> +	.align 8
> +	.quad 1b, bad_iret
> +.previous
> +ENDPROC(native_iret)
> +
> +ENTRY(native_irq_enable_sysexit)
> +	sti
> +	sysretq
> +ENDPROC(native_irq_enable_sysexit)

sysexit is legacy mode only

and I think we'll need a story for swapgs
