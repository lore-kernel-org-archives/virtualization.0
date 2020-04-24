From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Fri, 24 Apr 2020 16:27:32 -0500
Message-ID: <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Mike Stunes <mstunes@vmware.com>, joro@8bytes.org
Cc: dan.j.williams@intel.com, dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, jroedel@suse.de, jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, thellstrom@vmware.com, virtualization@lists.linux-foundation.org, x86@kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 4/24/20 4:24 PM, Dave Hansen wrote:
> On 4/24/20 2:03 PM, Mike Stunes wrote:
>> I needed to allow RDTSC(P) from userspace and in early boot in order to
>> get userspace started properly. Patch below.
>>
>> ---
>> SEV-ES guests will need to execute rdtsc and rdtscp from userspace and
>> during early boot. Move the rdtsc(p) #VC handler into common code and
>> extend the #VC handlers.
> 
> Do SEV-ES guests _always_ #VC on rdtsc(p)?

Only if the hypervisor is intercepting those instructions.

Thanks,
Tom

> 
