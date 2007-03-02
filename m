From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 12/26] Xen-paravirt_ops: Fix patch site
 clobbers to include return register
Date: Thu, 01 Mar 2007 16:52:57 -0800
Message-ID: <45E77569.9010602@vmware.com>
References: <20070301232443.195603797@goop.org>
	<20070301232527.755495278@goop.org>
	<45E7738D.5090607@vmware.com> <45E774AB.5090103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45E774AB.5090103@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Jeremy Fitzhardinge wrote:
>>     
>>> Fix a few clobbers to include the return register.  The clobbers set
>>> is the set of all registers modified (or may be modified) by the code
>>> snippet, regardless of whether it was deliberate or accidental.
>>>
>>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>>> Cc: Zachary Amsden <zach@vmware.com>
>>>
>>> ---
>>>  include/asm-i386/paravirt.h |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> ===================================================================
>>> --- a/include/asm-i386/paravirt.h
>>> +++ b/include/asm-i386/paravirt.h
>>> @@ -556,7 +556,7 @@ static inline unsigned long __raw_local_
>>>                         "popl %%edx; popl %%ecx")
>>>                   : "=a"(f): "m"(paravirt_ops.save_fl),
>>>                     paravirt_type(PARAVIRT_PATCH(save_fl)),
>>> -                   paravirt_clobber(CLBR_NONE)
>>> +                   paravirt_clobber(CLBR_EAX)
>>>                   : "memory", "cc");
>>>      return f;
>>>   
>>>       
>> Has this been tested on older gcc's?  I seem to recall them barfing
>> over things like this.
>>     
>
> Things like what?  Do you mean the %[foo] asm parameter syntax?  I think
> those versions are no longer supported - Arjan posted a patch a few days
> ago to convert a pile of asms to this form.  Or do you mean something else?
>   

I meant having an output in the clobber list, I didn't know we were 
dropping support for older versions already.

Zach
