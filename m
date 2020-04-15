From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Wed, 15 Apr 2020 17:53:02 +0200
Message-ID: <20200415155302.GD21899@suse.de>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
 <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
Sender: kvm-owner@vger.kernel.org
To: Mike Stunes <mstunes@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Mike,

On Tue, Apr 14, 2020 at 07:03:44PM +0000, Mike Stunes wrote:
> set_memory_decrypted needs to check the return value. I see it
> consistently return ENOMEM. I've traced that back to split_large_page
> in arch/x86/mm/pat/set_memory.c.

I agree that the return code needs to be checked. But I wonder why this
happens. The split_large_page() function returns -ENOMEM when
alloc_pages() fails. Do you boot the guest with minal RAM assigned?

Regards,

	Joerg
