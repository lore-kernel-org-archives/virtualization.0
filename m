From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 17/26] Xen-paravirt_ops: Add nosegneg capability to the
	vsyscall page notes
Date: Fri, 16 Mar 2007 10:15:52 +0100
Message-ID: <20070316091552.GH23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232528.407996939@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070301232528.407996939@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


i've Cc:-ed Roland and Ulrich, who should make the call on this one.

* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add the "nosegneg" fake capabilty to the vsyscall page notes. This is
> used by the runtime linker to select a glibc version which then
> disables negative-offset accesses to the thread-local segment via
> %gs. These accesses require emulation in Xen (because segments are
> truncated to protect the hypervisor address space) and avoiding them
> provides a measurable performance boost.
>
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Acked-by: Zachary Amsden <zach@vmware.com>
> =

> ---
>  arch/i386/kernel/vsyscall-note.S |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/kernel/vsyscall-note.S
> +++ b/arch/i386/kernel/vsyscall-note.S
> @@ -23,3 +24,31 @@ 3:	.balign 4;		/* pad out section */			 =

>  	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
>  	.long LINUX_VERSION_CODE
>  	ASM_ELF_NOTE_END
> +
> +#ifdef CONFIG_XEN
> +/*
> + * Add a special note telling glibc's dynamic linker a fake hardware
> + * flavor that it will use to choose the search path for libraries in the
> + * same way it uses real hardware capabilities like "mmx".
> + * We supply "nosegneg" as the fake capability, to indicate that we
> + * do not like negative offsets in instructions using segment overrides,
> + * since we implement those inefficiently.  This makes it possible to
> + * install libraries optimized to avoid those access patterns in somepla=
ce
> + * like /lib/i686/tls/nosegneg.  Note that an /etc/ld.so.conf.d/file
> + * corresponding to the bits here is needed to make ldconfig work right.
> + * It should contain:
> + *	hwcap 0 nosegneg
> + * to match the mapping of bit to name that we give here.
> + */
> +#define NOTE_KERNELCAP_BEGIN(ncaps, mask) \
> +	ASM_ELF_NOTE_BEGIN(".note.kernelcap", "a", "GNU", 2) \
> +	.long ncaps, mask
> +#define NOTE_KERNELCAP(bit, name) \
> +	.byte bit; .asciz name
> +#define NOTE_KERNELCAP_END ASM_ELF_NOTE_END
> +
> +NOTE_KERNELCAP_BEGIN(1, 1)
> +NOTE_KERNELCAP(1, "nosegneg")
> +NOTE_KERNELCAP_END
> +#endif
> +
> =

> -- =

> =

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
