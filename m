From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/19] desc_struct integration
Date: Wed, 12 Dec 2007 19:33:27 +0100
Message-ID: <20071212183327.GA30636__15160.4390390732$1197484989$gmane$org@elte.hu>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<20071212172019.GA11258@elte.hu> <20071212181111.GA23306@elte.hu>
	<20071212182057.GA26515@elte.hu> <476027F9.8020006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <476027F9.8020006@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> Ingo Molnar wrote:
>> * Ingo Molnar <mingo@elte.hu> wrote:
>>
>>>>> Ingo, in the absense of further complaints, could you please push to 
>>>>> the x86 tree?
>>>> yeah, i've added them.
>>> the patches cause a spontaneous reboot on x86 64-bit, around the time 
>>> when bootup hits user-space. It's due to one of the 25 patches from you 
>>> today. Config attached.
>>
>> likely caused by this patch:
>>
>>   Subject: unify non-paravirt parts of desc.h
>>
>> _please_ be more careful when unifying. Do check the before/after vmlinux 
>> - the binary size at least. And watch out for compiler warnings as well:
>>
>>  arch/x86/kernel/process_64.c: In function 'read_32bit_tls':
>>  arch/x86/kernel/process_64.c:454: warning: passing argument 1 of 'get_desc_base' from incompatible pointer type

> I saw this warning, and this was fixed in the patch that follows. But 
> yeah, I could have done a separate one, to avoid it. Do you have any 
> other reason to believe this is the cause?

that is bisection-unfriendly - every patch has to work.

> My box booted fine with the changes, but I'm re-verifying, and will 
> send and update soon.

please try the config i sent - does that boot fine on your box?

	Ingo
