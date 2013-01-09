From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
	page table PGD, PUD, PMD and PTE
Date: Wed, 9 Jan 2013 19:42:53 +0100
Message-ID: <20130109184253.GA5150__26273.68262406$1357757089$gmane$org@host-192-168-1-59.local.net-space.pl>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<50E55ECF02000078000B2A13@nat28.tlf.novell.com>
	<20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
	<50E70D8002000078000B336D@nat28.tlf.novell.com>
	<20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
	<50EAA7F402000078000B34C3@nat28.tlf.novell.com>
	<20130107125211.GB2927@host-192-168-1-59.local.net-space.pl>
	<50EAD61602000078000B36A0@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50EAD61602000078000B36A0@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: hpa@zytor.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, maxim.uvarov@oracle.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 07, 2013 at 01:05:10PM +0000, Jan Beulich wrote:
> >>> On 07.01.13 at 13:52, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Mon, Jan 07, 2013 at 09:48:20AM +0000, Jan Beulich wrote:
> >> >>> On 04.01.13 at 18:25, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >> > Right, so where is virtual mapping of control page established?
> >> > I could not find relevant code in SLES kernel which does that.
> >>
> >> In the hypervisor (xen/arch/x86/machine_kexec.c:machine_kexec_load()).
> >> xen/arch/x86/machine_kexec.c:machine_kexec() then simply uses
> >> image->page_list[1].
> >
> > This (xen/arch/x86/machine_kexec.c:machine_kexec_load()) maps relevant
> > page (allocated earlier by dom0) in hypervisor fixmap area. However,
> > it does not make relevant mapping in transition page table which
> > leads to crash when %cr3 is switched from Xen page table to
> > transition page table.
>
> That indeed could explain _random_ failures - the fixmap entries
> get created with _PAGE_GLOBAL set, i.e. don't get flushed with
> the CR3 write unless CR4.PGE is clear.

This does not matter. As I stated earlier virtual mapping is wrong.
relocate_kernel() is mapped at its virtual address in Linux kernel
instead of control page at its virtual address in Xen hypervisor.
I tested SLES kernel once again. It does not work.

> And I don't see how your allocation of intermediate page tables
> would help: You wouldn't know where the mapping of the control
> page lives until you're actually in the early relocate_kernel code.

Right. Allocation itself is not a solution for this problem.
It should be acompanied by code which establishes transition
page table in relocate_kernel() (which is later copied
to control page, i.e. code of relocate_kernel()).

> Or was it that what distinguishes your cloned code from the
> native original?

No, my code is based on native original.
There are some implementation differences.

Daniel
