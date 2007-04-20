From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 2/5] Paravirt_ops patch bugs.patch
Date: Thu, 19 Apr 2007 22:09:15 -0700
Message-ID: <46284AFB.1000307@vmware.com>
References: <20070420015234.5D42EBFC@zach-dev2.vmware.com>
	<46284406.2080007@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46284406.2080007@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Failing to patch because not enough space is available for a call or jump
>> or because the site clobbers do not allow the target clobbers to fit is
>> a fatal error; it means the kernel can not be properly virtualized.
>>   
>>     
>
> No, that doesn't follow.  If the original site was:
>
> patchable_start:
>     push %eax
>     push %ecx
>     push %edx
>     call *paravirt_ops + thingy
>     pop
>     pop
>     pop
> patchable_end:
>
> then its perfectly OK to leave it as-is, even if the direct call's
> destination clobbers are mismatched.  If the patcher wants to generate a
> call to a C function in a context which can't deal with normal C calling
> conventions, then it needs to also patch in appropriate save/restores.
>   

The example is a bit misconstrued.  In this case, the clobbers for the 
patchable region are CLBR_ALL - so there is no possibility of mismatch 
because of expanded clobber list.  If the patchable region consisted of 
this, it would be bad:

    push %eax
    push %ecx
patchable_start:
    push %edx
    call *paravirt_ops + thingy
    pop
patchable_end: (note - site clobber EDX ok)
    pop
    pop


But, why would you do that?

Calls through paravirt_ops function pointers are C function calls.  Failing to provide a patchable region which can make a C function call is a BUG().

Zach
