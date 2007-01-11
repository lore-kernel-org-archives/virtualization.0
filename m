From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: paravirt & xen & SMP
Date: Thu, 11 Jan 2007 15:13:04 -0800
Message-ID: <45A6C480.6040104@goop.org>
References: <45A504EE.5050409@suse.de> <45A534F1.90609@goop.org>
	<45A64CA7.80209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A64CA7.80209@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Well, after reading the code a bit more it seems the intention is to
> call the function in a row with others, have stuff queued up (in case
> lazy_mode =3D=3D PARAVIRT_LAZY_CPU is set) and update everything in one go
> then.  I don't think that makes sense for that function as it isn't
> performance-critical.  It is called on boot and cpu bringup (well, not
> yet) only, right?
>   =


Yes, that's right.  While its not performance critical in itself, the
idea was that if it were in a stream of other deferred cpu-state
updates, then it should happen in the appropriate order.   But in
practice this is mainly to make a context switch a single hypercall, so
the most important ones are stack-switch followed by 3x
update_descriptor (for TLS).

> We have a simliar issue for xen_write_gdt_entry() btw, it calls
> mc_flush() which doesn't work too.  I've fixed it that way:
>
> @@ -761,7 +762,13 @@ static asmlinkage void __init xen_start_
>         /* set up PDA descriptor */
>         pack_descriptor(&low, &high, (unsigned)&boot_pda,
> sizeof(boot_pda)-1,
>                         0x80 | DESCTYPE_S | 0x02, 0);
> +#if 0
>         xen_write_gdt_entry(cpu_gdt_table, GDT_ENTRY_PDA, low, high);
> +#else
> +       if (HYPERVISOR_update_descriptor(virt_to_machine(cpu_gdt_table +
> GDT_ENTRY_PDA).maddr,
> +                                        (u64)high << 32 | low))
> +               BUG();
> +#endif
>
>         /* set up %gs and init Xen parts of the PDA */
>         asm volatile("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
>
> [ gna, thunderbird isn't great for sending patches inline, you should
>   get the idea though ... ]
>   =


Yeah, that's ugly, but I guess it will do for now.

(You can inline patches without damage in thunderbird if you paste them
as "preformat")

    J
