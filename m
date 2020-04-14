From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Tue, 14 Apr 2020 15:16:18 -0500
Message-ID: <27da7cf5-5ff4-a10c-a506-de77aeff8dd6@amd.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
 <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
 <09757a84-1d81-74d5-c425-cff241f02ab9@amd.com>
 <fbc91dfc-7851-c7d8-ccdb-16c014526801@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fbc91dfc-7851-c7d8-ccdb-16c014526801@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



On 4/14/20 3:12 PM, Dave Hansen wrote:
> On 4/14/20 1:04 PM, Tom Lendacky wrote:
>>> set_memory_decrypted needs to check the return value. I see it
>>> consistently return ENOMEM. I've traced that back to split_large_page
>>> in arch/x86/mm/pat/set_memory.c.
>>
>> At that point the guest won't be able to communicate with the
>> hypervisor, too. Maybe we should BUG() here to terminate further
>> processing?
> 
> Escalating an -ENOMEM into a crashed kernel seems a bit extreme.
> Granted, the guest may be in an unrecoverable state, but the host
> doesn't need to be too.
> 

The host wouldn't be. This only happens in a guest, so it would be just 
causing the guest kernel to panic early in the boot.

Thanks,
Tom
