From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 09 Feb 2007 03:13:53 -0800
Message-ID: <45CC5771.1070309@vmware.com>
References: <1171012296.2718.26.camel@localhost.localdomain>	 <1171012458.2718.30.camel@localhost.localdomain>	 <1171012693.2718.37.camel@localhost.localdomain>	 <1171012761.2718.40.camel@localhost.localdomain>	 <1171012827.2718.42.camel@localhost.localdomain>	 <20070209013518.e75d5036.akpm@linux-foundation.org> <1171018812.2718.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161187AbXBILNy@vger.kernel.org>
In-Reply-To: <1171018812.2718.66.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Fri, 2007-02-09 at 01:35 -0800, Andrew Morton wrote:
>   
>> On Fri, 09 Feb 2007 20:20:27 +1100 Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>>     
>>> +#define log(...)					\
>>> +	do {						\
>>> +		mm_segment_t oldfs = get_fs();		\
>>> +		char buf[100];				\
>>> +		sprintf(buf, "lguest:" __VA_ARGS__);	\
>>> +		set_fs(KERNEL_DS);			\
>>> +		sys_write(1, buf, strlen(buf));		\
>>> +		set_fs(oldfs);				\
>>> +	} while(0)
>>>       
>> Due to gcc shortcomings, each instance of this will chew an additional 100
>> bytes of stack.  Unless they fixed it recently.  Is a bit of a timebomb.  I
>> guess ksaprintf() could be used.
>>
>> It also looks a bit, umm, innovative.
>>     
>
> It's also unused 8)
>
> It's an extremely useful macro for doing grossly invasive logging of the
> guest.  I'll drop it if you prefer.
>   

Yes, it is a bit, umm, innovative.  If it is going to be kept, even if 
just for devel logging, you should disable interrupts around it.  
Changing segments is not a normal thing to do.

Zach
