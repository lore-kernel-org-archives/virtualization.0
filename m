From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: paravirt & xen & SMP
Date: Thu, 11 Jan 2007 15:41:43 +0100
Message-ID: <45A64CA7.80209@suse.de>
References: <45A504EE.5050409@suse.de> <45A534F1.90609@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A534F1.90609@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> Next question while looking at xen_load_gdt(): why does it use
>> multicalls in the first place?  Seems that function puts only one
>> hypercall into the multicall array, so there is no obvious point in
>> using multicalls ...
> =

> I think you're right; I probably converted it when I swept through and
> did the others without really thinking about the bootstrap consequences.

Well, after reading the code a bit more it seems the intention is to
call the function in a row with others, have stuff queued up (in case
lazy_mode =3D=3D PARAVIRT_LAZY_CPU is set) and update everything in one go
then.  I don't think that makes sense for that function as it isn't
performance-critical.  It is called on boot and cpu bringup (well, not
yet) only, right?

We have a simliar issue for xen_write_gdt_entry() btw, it calls
mc_flush() which doesn't work too.  I've fixed it that way:

@@ -761,7 +762,13 @@ static asmlinkage void __init xen_start_
        /* set up PDA descriptor */
        pack_descriptor(&low, &high, (unsigned)&boot_pda,
sizeof(boot_pda)-1,
                        0x80 | DESCTYPE_S | 0x02, 0);
+#if 0
        xen_write_gdt_entry(cpu_gdt_table, GDT_ENTRY_PDA, low, high);
+#else
+       if (HYPERVISOR_update_descriptor(virt_to_machine(cpu_gdt_table +
GDT_ENTRY_PDA).maddr,
+                                        (u64)high << 32 | low))
+               BUG();
+#endif

        /* set up %gs and init Xen parts of the PDA */
        asm volatile("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");

[ gna, thunderbird isn't great for sending patches inline, you should
  get the idea though ... ]

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
