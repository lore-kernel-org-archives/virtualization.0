From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] XEN: enlighten,
	use uninitialized_var(cx)
Date: Wed, 26 Aug 2009 10:27:15 -0700
Message-ID: <4A957073.10302@zytor.com>
References: <1251234044-6943-1-git-send-email-jirislaby@gmail.com>
	<20090826060925.GA6194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20090826060925.GA6194@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: xen-devel@lists.xensource.com, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, virtualization@lists.osdl.org, jeremy@xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On 08/25/2009 11:09 PM, Ingo Molnar wrote:
>>
>> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
>> index e90540a..5ab75e2 100644
>> --- a/arch/x86/xen/enlighten.c
>> +++ b/arch/x86/xen/enlighten.c
>> @@ -202,7 +202,7 @@ static void xen_cpuid(unsigned int *ax, unsigned int *bx,
>>  
>>  static __init void xen_init_cpuid_mask(void)
>>  {
>> -	unsigned int ax, bx, cx, dx;
>> +	unsigned int ax, bx, uninitialized_var(cx), dx;
> 
> Please dont use uninitialized_var(), it's an unreliable facility: if 
> this variable ever grows a real used-without-initialization bug in 
> the future, the compiler warning is turned off permanently. It's 
> rare but might happen. We are better off with initializing it to 
> zero.
> 

I hadn't seen this thread, but I pushed a patch to x86/urgent to do
exactly that while I was committing the Xen crash patch last night.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
