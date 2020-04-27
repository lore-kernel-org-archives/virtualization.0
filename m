From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Mon, 27 Apr 2020 11:47:07 -0700
Message-ID: <45000aa0-a6d1-03c3-069b-0e9a07c0284d@intel.com>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
 <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
 <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com>
 <20200425124909.GO30814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200425124909.GO30814@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, joro@8bytes.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 4/25/20 5:49 AM, Joerg Roedel wrote:
>> That's a fun point because it means that the (untrusted) hypervisor can
>> cause endless faults.  I *guess* we have mitigation for this with our
>> stack guard pages, but it's still a bit nasty that the hypervisor can
>> arbitrarily land a guest in the double-fault handler.
>>
>> It just all seems a bit weak for the hypervisor to be considered
>> untrusted.  But, it's _certainly_ a steep in the right direction from SEV.
> Yeah, a malicious hypervisor can do bad things to an SEV-ES VM, but it
> can't easily steal its secrets from memory or registers. The #VC handler
> does its best to just crash the VM if unexpected hypervisor behavior is
> detected.

This is the kind of design information that would be very useful to
reviewers.  Will some of this information make it into the cover letter
eventually?  Or, Documentation/?

Also, for the security purists, an SEV-ES host is still trusted (in the
same TCB as the guest).  Truly guest-untrusted VMMs won't be available
until SEV-SNP, right?
