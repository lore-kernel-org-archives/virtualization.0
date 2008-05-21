From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 3/4] kvm/host: fix paravirt clocksource to
 be	compatible with xen.
Date: Wed, 21 May 2008 18:24:34 +0300
Message-ID: <48343EB2.9090301@qumranet.com>
References: <1210247315-20472-1-git-send-email-kraxel@redhat.com>	<1210247315-20472-4-git-send-email-kraxel@redhat.com>	<48294B5B.8020706@qumranet.com> <482D3C00.80707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <482D3C00.80707@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
>   
>>> +static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
>>> +{
>>> +    uint32_t quotient, remainder;
>>> +
>>> +    __asm__ ( "divl %4"
>>> +          : "=a" (quotient), "=d" (remainder)
>>> +          : "0" (0), "1" (dividend), "r" (divisor) );
>>> +    return quotient;   
>>> +}
>>>   
>>>       
>> do_div()?
>>     
>
> No, this one does something else.  Already tried to get rid of that one
> before ;)
>
>   

Ah yes, it calculates (dividend << 32) / divisor.

-- 
error compiling committee.c: too many arguments to function

