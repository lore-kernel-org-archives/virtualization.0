From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 3/4] kvm/host: fix paravirt clocksource to
	be	compatible with xen.
Date: Sun, 18 May 2008 09:05:19 +0300
Message-ID: <482FC71F.7000502@qumranet.com>
References: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
	<1210247315-20472-4-git-send-email-kraxel@redhat.com>
	<48294B5B.8020706@qumranet.com> <482D3C00.80707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482D3C00.80707@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
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

There is actually a simpler way of coding this:


   return  dividend / divisor;

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
