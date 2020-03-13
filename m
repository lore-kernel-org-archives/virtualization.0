From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 38/62] x86/sev-es: Handle instruction fetches from
 user-space
Date: Fri, 13 Mar 2020 10:12:21 +0100
Message-ID: <20200313091221.GA16378@suse.de>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-39-joro@8bytes.org>
 <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 12, 2020 at 01:42:48PM -0800, Andy Lutomirski wrote:
> I realize that this is a somewhat arbitrary point in the series to
> complain about this, but: the kernel already has infrastructure to
> decode and fix up an instruction-based exception.  See
> fixup_umip_exception().  Please refactor code so that you can share
> the same infrastructure rather than creating an entirely new thing.

Okay, but 'infrastructure' is a bold word for the call path down
fixup_umip_exception(). It uses the in-kernel instruction decoder, which
I already use in my patch-set. But I agree that some code in this
patch-set is duplicated and already present in the instruction decoder,
and that fixup_umip_exception() has more robust instruction decoding.

I factor the instruction decoding part out and make is usable for the
#VC handler too and remove the code that is already present in the
instruction decoder.

Regards,

	Joerg
