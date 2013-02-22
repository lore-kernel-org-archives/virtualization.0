From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 13:23:21 -0500
Message-ID: <20130222182321.GA11311@phenom.dumpdata.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<20130222172403.GA17056@phenom.dumpdata.com>
	<CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAE9FiQUe86t2Me4uF=oCz5VGqa8AJYrGQHhPA=w_9OP5OSWN=w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, linux-pm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@j>
List-Id: virtualization@lists.linuxfoundation.org

> > [    0.000000] DMI: MSI MS-7680/H61M-P23 (MS-7680), BIOS V17.0 03/14/2011
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > [    0.000000] No AGP bridge found
> > [    0.000000] e820: last_pfn = 0x23fe00 max_arch_pfn = 0x400000000
> > [    0.000000] e820: lacanning 1 areas for low memory corruption
> > [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
> > [    0.000000] reserving inaccessible SNB gfx pages
> > [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> > [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x1f2000000-0x1f20c3fff]
> > [    0.000000]  [mem 0x1f2000000-0x1f20c3fff] page 4k
> > [    0.000000] BRK [0x01cd2000, 0x01cd2fff] PGTABLE
> > [    0.000000] BRK [0x01cd3000, 0x01cd3fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x1f0000000-0x1f1ffffff]
> > [    0.000000]  [mem 0x1f0000000-0x1f1ffffff] page 4k
> > [    0.000000] BRK [0x01cd4000, 0x01cd4fff] PGTABLE
> > [    0.000000] BRK [0x01cd5000, 0x01cd5fff] PGTABLE
> > [    0.000000] BRK [0x01cd6000, 0x01cd6fff] PGTABLE
> > [    0.000000] init_memory_mapping: [mem 0x180000000-0x1efffffff]
> > [    0.000000]  [mem 0x180000000-0x1efffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
> > [    0.000000]  [mem 0x00100000-0x1fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
> > [    0.000000]  [mem 0x20200000-0x3fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x40200000-0xbad7ffff]
> > [    0.000000]  [mem 0x40200000-0xbad7ffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0xbadf4000-0xbadf5fff]
> > [    0.000000]  [mem 0xbadf4000-0xbadf5fff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0xbae7f000-0xbaffffff]
> > [    0.000000]  [mem 0xbae7f000-0xbaffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x100000000-0x17fffffff]
> > [    0.000000]  [mem 0x100000000-0x17fffffff] page 4k
> > [    0.000000] init_memory_mapping: [mem 0x1f20c4000-0x23fdfffff]
> > [    0.000000]  [mem 0x1f20c4000-0x23fdfffff] page 4k
> 
> so init_memory_mapping are all done.

Not so.
> 
> > (XEN) d0:v0: unhandled page fault (ec=0000)
> > (XEN) Pagetable walk from ffffea000005b2d0:
> > (XEN)  L4[0x1d4] = 0000000000000000 ffffffffffffffff
> > (XEN) domain_crash_sync called from entry.S
> > (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
> > (XEN) ----[ Xen-4.1.5-pre  x86_64  debug=y  Tainted:    C ]----
> > (XEN) CPU:    0
> > (XEN) RIP:    e033:[<ffffffff8103feba>]
> > (XEN) RFLAGS: 0000000000000206   EM: 1   CONTEXT: pv guest
> > (XEN) rax: ffffea0000000000   rbx: 0000000001a0c000   rcx: 0000000080000000
> > (XEN) rdx: 000000000005b2a0   rsi: 0000000001a0c000   rdi: 0000000000000000
> > (XEN) rbp: ffffffff81a01dd8   rsp: ffffffff81a01d90   r8:  0000000000000000
> > (XEN) r9:  0000000010000001   r10: 0000000000000005   r11: 0000000000100000
> > (XEN) r12: 0000000000000000   r13: 0000020000000000   r14: 0000000000000000
> > (XEN) r15: 0000000000100000   cr0: 000000008005003b   cr4: 00000000000026f0
> > (XEN) cr3: 0000000221a0c000   cr2: ffffea000005b2d0
> > (XEN) ds: 0000   es: 0000   fs: 0000   gs: 0000   ss: e02b   cs: e033
> > (XEN) Guest stack trace from rsp=ffffffff81a01d90:
> > (XEN)    0000000080000000 0000000000100000 0000000000000000 ffffffff8103feba
> > (XEN)    000000010000e030 0000000000010006 ffffffff81a01dd8 000000000000e02b
> > (XEN)    0000000000000000 ffffffff81a01e08 ffffffff81042d27 000000023fe00000
> > (XEN)    00000001f20c4000 0000020000000000 00000001acac7000 ffffffff81a01e48
> > (XEN)    ffffffff81ad2d21 0000000000000000 0000000000000028 0000000040004000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01ed8
> > (XEN)    ffffffff81ac293f ffffffff81b46900 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 ffffffff81a01f00 ffffffff8165fbd1 ffffffff00000010
> > (XEN)    ffffffff81a01ee8 ffffffff81a01ea8 0000000000000000 ffffffff81a01ec8
> > (XEN)    ffffffffffffffff ffffffff81b46900 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 ffffffff81a01f28 ffffffff81abcd62 ffffffff96062000
> > (XEN)    ffffffff81cc6000 ffffffff81ccd000 ffffffff81b4f2e0 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 ffffffff81a01f38
> > (XEN)    ffffffff81abc5f7 ffffffff81a01ff8 ffffffff81abf0c7 0300000100000032
> > (XEN)    0000000000000005 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > (XEN)    0000000000000000 819822831fc9cbf5 000206a700100800 0000000000000001
> > (XEN)    0000000000000000 0000000000000000 0f00000060c0c748 ccccccccccccc305
> > (XEN) Domain 0 crashed: rebooting machine in 5 seconds.
> > (XEN) Resetting with ACPI MEMORY or I/O RESET_REG.
> 
> can we get kernel trace instead?

If you look at the initial one I had posted:

> >> Call Trace:
> >>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
> >>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a
> >>   [<ffffffff81042d27>] xen_write_cr3+0x77
> >>   [<ffffffff81ad2d21>] init_mem_mapping+0x1f9
> >>   [<ffffffff81ac293f>] setup_arch+0x742
> >>   [<ffffffff81666d71>] printk+0x48
> >>   [<ffffffff81abcd62>] start_kernel+0x90
> >>   [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b
> >>   [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a
> >>   [<ffffffff81abf0c7>] xen_start_kernel+0x564

The EIP matches with what this stack strace has. So we are still in
init_mem_mapping.
