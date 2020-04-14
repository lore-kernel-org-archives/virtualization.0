From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Tue, 14 Apr 2020 15:04:42 -0500
Message-ID: <09757a84-1d81-74d5-c425-cff241f02ab9@amd.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
 <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 4/14/20 2:03 PM, Mike Stunes wrote:
> On Mar 19, 2020, at 2:13 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> The runtime handler needs a GHCB per CPU. Set them up and map them
>> unencrypted.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>> arch/x86/include/asm/mem_encrypt.h |  2 ++
>> arch/x86/kernel/sev-es.c           | 28 +++++++++++++++++++++++++++-
>> arch/x86/kernel/traps.c            |  3 +++
>> 3 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
>> index c17980e8db78..4bf5286310a0 100644
>> --- a/arch/x86/kernel/sev-es.c
>> +++ b/arch/x86/kernel/sev-es.c
>> @@ -197,6 +203,26 @@ static bool __init sev_es_setup_ghcb(void)
>> 	return true;
>> }
>>
>> +void sev_es_init_ghcbs(void)
>> +{
>> +	int cpu;
>> +
>> +	if (!sev_es_active())
>> +		return;
>> +
>> +	/* Allocate GHCB pages */
>> +	ghcb_page = __alloc_percpu(sizeof(struct ghcb), PAGE_SIZE);
>> +
>> +	/* Initialize per-cpu GHCB pages */
>> +	for_each_possible_cpu(cpu) {
>> +		struct ghcb *ghcb = (struct ghcb *)per_cpu_ptr(ghcb_page, cpu);
>> +
>> +		set_memory_decrypted((unsigned long)ghcb,
>> +				     sizeof(*ghcb) >> PAGE_SHIFT);
>> +		memset(ghcb, 0, sizeof(*ghcb));
>> +	}
>> +}
>> +
> 
> set_memory_decrypted needs to check the return value. I see it
> consistently return ENOMEM. I've traced that back to split_large_page
> in arch/x86/mm/pat/set_memory.c.

At that point the guest won't be able to communicate with the hypervisor, 
too. Maybe we should BUG() here to terminate further processing?

Thanks,
Tom

> 
