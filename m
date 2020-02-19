From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH 23/62] x86/idt: Move IDT to data segment
Date: Wed, 19 Feb 2020 11:47:33 +0100
Message-ID: <64f1fa87-17c2-928b-06f5-17b6771fc753@suse.com>
References: <20200212115516.GE20066@8bytes.org>
 <EEAC8672-C98F-45D0-9F2D-0802516C3908@amacapital.net>
 <879ace44-cee3-98aa-0dff-549b69355096@suse.com>
 <20200219104213.GJ22063@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200219104213.GJ22063@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 19.02.20 11:42, Joerg Roedel wrote:
> Hi Jürgen,
> 
> On Wed, Feb 12, 2020 at 05:28:21PM +0100, Jürgen Groß wrote:
>> Xen-PV is clearing BSS as the very first action.
> 
> In the kernel image? Or in the ELF loader before jumping to the kernel
> image?

In the kernel image.

See arch/x86/xen/xen-head.S - startup_xen is the entry point of the
kernel.


Juergen
