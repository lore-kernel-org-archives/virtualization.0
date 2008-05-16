From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] kvm/host: fix paravirt clocksource to
 be	compatible with xen.
Date: Fri, 16 May 2008 09:47:12 +0200
Message-ID: <482D3C00.80707@redhat.com>
References: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
	<1210247315-20472-4-git-send-email-kraxel@redhat.com>
	<48294B5B.8020706@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <48294B5B.8020706@qumranet.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>> +    struct timespec now,sys,boot;
> 
> Add spaces.

Done.

>> +#if 0
>> +    /* Hmm, getboottime() isn't exported to modules ... */
>> +    getboottime(&boot);
>> +#else
>> +    now = current_kernel_time();
>> +    ktime_get_ts(&sys);
>> +    boot = ns_to_timespec(timespec_to_ns(&now) - timespec_to_ns(&sys));
>> +#endif
>> +    wc.wc_sec = boot.tv_sec;
>> +    wc.wc_nsec = boot.tv_nsec;
> 
> Please drop the #if 0.

Done, and added a comment for the calculation.

>> +static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
>> +{
>> +    uint32_t quotient, remainder;
>> +
>> +    __asm__ ( "divl %4"
>> +          : "=a" (quotient), "=d" (remainder)
>> +          : "0" (0), "1" (dividend), "r" (divisor) );
>> +    return quotient;   
>> +}
>>   
> 
> do_div()?

No, this one does something else.  Already tried to get rid of that one
before ;)

> pr_debug() or something?

Done.

>> +        kvm_set_time_scale(tsc_khz, &vcpu->arch.hv_clock);
>>  
> What if the tsc frequency changes later on?  we need to adjust the
> multiplier, no?

We better do that, yes.

New patch series prepared and tested, will be posted in a moment ...

cheers,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
