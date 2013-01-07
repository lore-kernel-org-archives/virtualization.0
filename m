From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
	page table PGD, PUD, PMD and PTE
Date: Mon, 7 Jan 2013 13:52:11 +0100
Message-ID: <20130107125211.GB2927@host-192-168-1-59.local.net-space.pl>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<50E55ECF02000078000B2A13@nat28.tlf.novell.com>
	<20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
	<50E70D8002000078000B336D@nat28.tlf.novell.com>
	<20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
	<50EAA7F402000078000B34C3@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50EAA7F402000078000B34C3@nat28.tlf.novell.com>
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

On Mon, Jan 07, 2013 at 09:48:20AM +0000, Jan Beulich wrote:
> >>> On 04.01.13 at 18:25, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > Right, so where is virtual mapping of control page established?
> > I could not find relevant code in SLES kernel which does that.
>
> In the hypervisor (xen/arch/x86/machine_kexec.c:machine_kexec_load()).
> xen/arch/x86/machine_kexec.c:machine_kexec() then simply uses
> image->page_list[1].

This (xen/arch/x86/machine_kexec.c:machine_kexec_load()) maps relevant
page (allocated earlier by dom0) in hypervisor fixmap area. However,
it does not make relevant mapping in transition page table which
leads to crash when %cr3 is switched from Xen page table to
transition page table.

Daniel
