From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 0/19] desc_struct integration
Date: Wed, 12 Dec 2007 17:05:28 -0200
Message-ID: <476030F8.6090605__14826.5806180008$1197486505$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<20071212172019.GA11258@elte.hu> <20071212181111.GA23306@elte.hu>
	<20071212182057.GA26515@elte.hu> <476027F9.8020006@redhat.com>
	<20071212183327.GA30636@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071212183327.GA30636@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
> 
>> Ingo Molnar wrote:
>>> * Ingo Molnar <mingo@elte.hu> wrote:
>>>
>>>>>> Ingo, in the absense of further complaints, could you please push to 
>>>>>> the x86 tree?
>>>>> yeah, i've added them.
>>>> the patches cause a spontaneous reboot on x86 64-bit, around the time 
>>>> when bootup hits user-space. It's due to one of the 25 patches from you 
>>>> today. Config attached.
>>> likely caused by this patch:
>>>
>>>   Subject: unify non-paravirt parts of desc.h
>>>
>>> _please_ be more careful when unifying. Do check the before/after vmlinux 
>>> - the binary size at least. And watch out for compiler warnings as well:
>>>
>>>  arch/x86/kernel/process_64.c: In function 'read_32bit_tls':
>>>  arch/x86/kernel/process_64.c:454: warning: passing argument 1 of 'get_desc_base' from incompatible pointer type
> 
>> I saw this warning, and this was fixed in the patch that follows. But 
>> yeah, I could have done a separate one, to avoid it. Do you have any 
>> other reason to believe this is the cause?
> 
> that is bisection-unfriendly - every patch has to work.
I know, and I'm sorry. I thought it was not that bad, by being just a 
warning due to a type cast. ;-)
(famous last words, I know)

>> My box booted fine with the changes, but I'm re-verifying, and will 
>> send and update soon.
> 
> please try the config i sent - does that boot fine on your box?
No, it doesn't. I'll bisect it, and send an updated series, with your 3 
concerns addressed.
