From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to
	transition page table PGD, PUD, PMD and PTE
Date: Fri, 04 Jan 2013 16:12:32 +0000
Message-ID: <50E70D8002000078000B336D@nat28.tlf.novell.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<50E55ECF02000078000B2A13@nat28.tlf.novell.com>
	<20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: hpa@zytor.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, maxim.uvarov@oracle.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

>>> On 04.01.13 at 16:15, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> On Thu, Jan 03, 2013 at 09:34:55AM +0000, Jan Beulich wrote:
>> >>> On 27.12.12 at 03:18, Daniel Kiper <daniel.kiper@oracle.com> wrote:
>> > Some implementations (e.g. Xen PVOPS) could not use part of identity page 
> table
>> > to construct transition page table. It means that they require separate 
> PUDs,
>> > PMDs and PTEs for virtual and physical (identity) mapping. To satisfy that
>> > requirement add extra pointer to PGD, PUD, PMD and PTE and align existing
>> > code.
>>
>> So you keep posting this despite it having got pointed out on each
>> earlier submission that this is unnecessary, proven by the fact that
>> the non-pvops Xen kernels can get away without it. Why?
> 
> Sorry but I forgot to reply for your email last time.
> 
> I am still not convinced. I have tested SUSE kernel itself and it does not 
> work.
> Maybe I missed something but... Please check 
> arch/x86/kernel/machine_kexec_64.c:init_transition_pgtable()
> 
> I can see:
> 
> vaddr = (unsigned long)relocate_kernel;
> 
> and later:
> 
> pgd += pgd_index(vaddr);
> ...

I think that mapping is simply irrelevant, as the code at
relocate_kernel gets copied to the control page and
invoked there (other than in the native case, where
relocate_kernel() gets invoked directly).

Jan

> It is wrong. relocate_kernel() virtual address in Xen is different
> than its virtual address in Linux Kernel. That is why transition
> page table could not be established in Linux Kernel and so on...
> How does this work in SUSE? I do not have an idea.
> 
> I am happy to fix that but whatever fix for it is
> I would like to be sure that it works.
> 
> Daniel
