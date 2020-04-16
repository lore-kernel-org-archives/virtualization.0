From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 12/70] x86/boot/compressed/64: Add IDT Infrastructure
Date: Thu, 16 Apr 2020 15:30:45 +0200
Message-ID: <20200416133045.GA4290@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-13-joro@8bytes.org>
 <20200407022127.GA1048595@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200407022127.GA1048595@rani.riverdale.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Hi Arvind,

On Mon, Apr 06, 2020 at 10:21:27PM -0400, Arvind Sankar wrote:
> On Thu, Mar 19, 2020 at 10:13:09AM +0100, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > +/*
> > + * Reload GDT after relocation - The GDT at the non-relocated position
> > + * might be overwritten soon by the in-place decompression, so reload
> > + * GDT at the relocated address. The GDT is referenced by exception
> > + * handling and needs to be set up correctly.
> > + */
> > +	leaq	gdt(%rip), %rax
> > +	movq	%rax, gdt64+2(%rip)
> > +	lgdt	gdt64(%rip)
> > +
> >  /*
> >   * Clear BSS (stack is currently empty)
> >   */
> 
> Note that this is now done in mainline as of commit c98a76eabbb6e, just
> prior to jumping to .Lrelocated, so this can be dropped on the next
> rebase.

Thanks for the heads-up, I removed this hunk.

Regards,

	Joerg
