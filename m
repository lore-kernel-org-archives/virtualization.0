From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 12:47:31 -0700
Message-ID: <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
References: <20200425191032.GK21900@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200425191032.GK21900@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org



> On Apr 25, 2020, at 12:10 PM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFOn Sat, Apr 25, 2020 at 11:15:35AM -0700, Andy Lutomirski wrote:
>> shift_ist is gross.  What's it for?  If it's not needed, I'd rather
>> not use it, and I eventually want to get rid of it for #DB as well.
>=20
> The #VC handler needs to be able to nest, there is no way around that
> for various reasons, the two most important ones are:
>=20
>    1. The #VC -> NMI -> #VC case. #VCs can happen in the NMI
>       handler, for example (but not exclusivly) for RDPMC.
>=20
>    2. In case of an error the #VC handler needs to print out error
>       information by calling one of the printk wrappers. Those will
>       end up doing IO to some console/serial port/whatever which
>       will also cause #VC exceptions to emulate the access to the
>       output devices.
>=20
> Using shift_ist is perfect for that, the only problem is the race
> condition with the NMI handler, as shift_ist does not work well with
> exceptions that can also trigger within the NMI handler. But I have
> taken care of that for #VC.
>=20

I assume the race you mean is:

#VC
Immediate NMI before IST gets shifted
#VC

Kaboom.

How are you dealing with this?  Ultimately, I think that NMI will need to tu=
rn off IST before engaging in any funny business. Let me ponder this a bit.

>=20
> Regards,
>=20
>    Joerg
>=20
