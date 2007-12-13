From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH] avoid ifdefs in desc.h,
	getting rid of pack_ldt and pack_tss
Date: Thu, 13 Dec 2007 19:40:31 -0200
Message-ID: <4761A6CF.10307__15704.5643813492$1197582361$gmane$org@redhat.com>
References: <11975561713425-git-send-email-gcosta@redhat.com>	
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>	
	<20071213212221.GA16747@elte.hu> <4761A385.1080301@zytor.com>
	<7b9198260712131337j6249c980q55306b676b361776@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7b9198260712131337j6249c980q55306b676b361776@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Spink <tspink@gmail.com>
Cc: ak@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, roland@redhat.com, ehabkost@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Tom Spink wrote:
> On Dec 13, 2007 9:26 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> Ingo Molnar wrote:
>>>> could we _please_ use basic tools as vmlinux size comparison and
>>>> objcompare when unifying, to make sure it's a 100% identity
>>>> conversion?
>>> case in point, the patch claims:
>>>
>>>>> No functional change is made.
>>> but vmlinux before/after size comparison shows:
>>>
>>>     text    data     bss     dec     hex filename
>>>  8802894 1224910 3526656 13554460         ced31c vmlinux.before
>>>  8803042 1224910 3526656 13554608         ced3b0 vmlinux.after
>>>
>> Well, "no functional changes" is not quite the same thing as "no object
>> code changes".
>>
>>         -hpa
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> I'm by far no expert on the subject, but after a quick eyes-debug,
> have you got the size and type parameters reversed here:
> 
> +       set_tssldt_descriptor(&tss, (unsigned long)addr,
>                IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1,
>                DESC_TSS);
> 
> Should DESC_TSS be the parameter before that big size equation?
> 
That's it. I made this mistake once, and fixed it. But I may have sent 
an older, and obviously wrong version of the patch. My fault.
