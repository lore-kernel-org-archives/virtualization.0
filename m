From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 08/62] x86/boot/compressed/64: Add IDT Infrastructure
Date: Sat, 15 Feb 2020 13:32:48 +0100
Message-ID: <20200215123248.GF22063@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-9-joro@8bytes.org>
 <87k14p5557.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k14p5557.fsf@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 11:40:36AM -0800, Andi Kleen wrote:
> Joerg Roedel <joro@8bytes.org> writes:
> > +	addq    $8, %rsp
> > +
> > +	/*
> > +	 * Make sure we return to __KERNEL_CS - the CS selector on
> > +	 * the IRET frame might still be from an old BIOS GDT
> > +	 */
> > +	movq	$__KERNEL_CS, 8(%rsp)
> 
> This doesn't make sense. Either it's running on the correct CS
> before the exception or not. Likely there's some other problem
> here that you patched over with this hack.

It is actually a well-known situation and not some other problem. The
boot-code loaded a new GDT and IDT, but did not reload CS with a far
jump/ret/call. The CS value loaded is undefined and comes from the UEFI
BIOS. When an exception is raised, this old CS value is stored in the
IRET frame, and when IRET is executed the processor loads an undefined
CS value, which causes a triple fault with the current IDT setup.

The hack in this patch just fixes the IRET frame up so that it will
return to the correct CS. The reason for this hack was actually to safe
some instructions in the boot-path, because the space is limited there
between the defined offsets of the various entry points.

I removed this hack meanwhile and added a separate function which
reloads CS, DS, SS and ES and which is called from the boot-path, so
that there is no problem with the offsets.

Regards,

	Joerg
