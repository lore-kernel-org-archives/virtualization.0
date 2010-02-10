From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirt compile failure with gcc33
Date: Wed, 10 Feb 2010 13:08:58 -0800
Message-ID: <4B73206A.2030406@zytor.com>
References: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr>
	<4B72FD09.1020202@goop.org>
	<alpine.LSU.2.01.1002102019430.6708@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LSU.2.01.1002102019430.6708@obet.zrqbmnf.qr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 02/10/2010 11:20 AM, Jan Engelhardt wrote:
> On Wednesday 2010-02-10 19:38, Jeremy Fitzhardinge wrote:
> 
>> On 02/10/2010 10:13 AM, Jan Engelhardt wrote:
>>> As I was compile-testing 2.6.33-rc with gcc-3.3,
>>> binutils-2.19.51-10.26.4.x86_64, I observed a failure when
>>> CONFIG_PARAVIRT is turned on:
>>>   
>>
>> Yeah, there's a gcc bug of some kind there, and its very hard to see how to
>> work around it.  When we last discussed this, I think we were close to deciding
>> to obsolete gcc 3.3.
>>
>> HPA, do you remember?
> 
> In fact, there's such a big bug in there that I'll get a runaway 
> allocation later on when kvm.o is to be compiled. This is getting fun,
> but I am absolutely fine with obsoleting 3.x  :)

I have heard of some people using 3.4, but I'm not sure if anyone cares
for current kernels and for x86, in particular.  Some other
architectures might still be stuck on 3.x.

For x86 in particular 3.x support is becoming more of a headache than a
help.

	-hpa
