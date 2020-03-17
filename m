From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 38/62] x86/sev-es: Handle instruction fetches from user-space
Date: Tue, 17 Mar 2020 14:34:22 -0700
Message-ID: <CALCETrX74dJEXd7OxZZ=2sPy8nOjqO5Lzjt04VrxP0TYgTXnUg@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-39-joro@8bytes.org>
 <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com> <20200313091221.GA16378@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200313091221.GA16378@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 13, 2020 at 2:12 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Wed, Feb 12, 2020 at 01:42:48PM -0800, Andy Lutomirski wrote:
> > I realize that this is a somewhat arbitrary point in the series to
> > complain about this, but: the kernel already has infrastructure to
> > decode and fix up an instruction-based exception.  See
> > fixup_umip_exception().  Please refactor code so that you can share
> > the same infrastructure rather than creating an entirely new thing.
>
> Okay, but 'infrastructure' is a bold word for the call path down
> fixup_umip_exception().

I won't argue with that.

> It uses the in-kernel instruction decoder, which
> I already use in my patch-set. But I agree that some code in this
> patch-set is duplicated and already present in the instruction decoder,
> and that fixup_umip_exception() has more robust instruction decoding.
>
> I factor the instruction decoding part out and make is usable for the
> #VC handler too and remove the code that is already present in the
> instruction decoder.

Thanks!

>
> Regards,
>
>         Joerg
>
