From: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>
Subject: Re: [PATCH] i386: modified CONFIG_PHYSICAL_ALIGN
Date: Tue, 14 Aug 2007 17:59:45 +0900
Message-ID: <60C7DE5175F592ichiyanagi.yoshimi@lab.ntt.co.jp>
References: <5AC7DE0DDBA7B1ichiyanagi.yoshimi@lab.ntt.co.jp>
	<20070814032903.GB3903@bingen.suse.de>
	<1187061448.11093.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187061448.11093.63.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>
Cc: zippel@linux-m68k.org, moriai.satoshi@lab.ntt.co.jp, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Tue, 14 Aug 2007 13:17:28 +1000Rusty Russell <rusty@rustcorp.com.au> wrote
>On Tue, 2007-08-14 at 05:29 +0200, Andi Kleen wrote:
>> On Tue, Aug 14, 2007 at 09:55:50AM +0900, Yoshimi Ichiyanagi wrote:
>> 
>> How is this related to virtualization?
>> 
>> > The problem is, if you compile x86_64 kernel, the value of 
>> > CONFIG_PHYSICAL_ALIGN will be fixed, and the next time you compile i386 
>> > kernel, previous CONFIG_PHYSICAL_ALIGN value of x86_64(default: 2MB) will 
>> > be used by default.
>> 
>> 2/4MB is better for i386 too for PAE/non PAE because
>> it will use less TLB entries. I guess it's better to just change
>> the defaults.
>> 
>> Anyways, both values should work, or did you see 
>> failures?
>
>I had this problem too: Lguest assumes 1MB when loading bzImages, and
>the only time that gets changed is when building from an x86-64 config.
>I considered it purely an lguest issue.
>
>The correct fix is to have lguest run bzImages rather than trying to
>unpack them itself, but that requires a bootloader change, and the
>proposals to do that got lost in a flurry of far more ambitious patches.
>
>Jeremy would know the status of that work...
>Rusty.

I think following 2 ways to gets the physical address where kernel loads : 

1). Get the address from configuration file(i.e. .config) 
      such as CONFIG_PAGE_OFFSET
2). Get the address from the bzImage

In case 1), it's problem when configuration file(i.e. .config) does not 
exist.
In case 2), it's necessary to copy "struct setup_header" which is defined 
in the kernel header file. You can not include this kernel header file in 
lguest utility's source file, because it can not solve the symbol for 
kernel(i.e. #ifdef __KERNEL__). 

Which is good? do you have any idea?

Tue, 14 Aug 2007 05:29:03 +0200Andi Kleen <ak@suse.de> wrote :
>On Tue, Aug 14, 2007 at 09:55:50AM +0900, Yoshimi Ichiyanagi wrote:
>

>> The following patch will fix this problem. With this patch, either 
>> CONFIG_RELOCATABLE's option or CONFIG_EMNBEDDED's option is set "Y", 
>> you can configure the value of CONFIG_PHYSICAL_ALIGN.
>
>How does that change anything?
>
>iirc what you want cannot be really expressed in Kconfig :- what
>you would really want is a flag for the number that says
>"this came from a default value and user hasn't changed it"
>and then Kconfig knowing that if the new default is different
>change it to new default. But I'm not sure such complexity would be really
>a good idea. Probably it's not.

Take a look at CONFIG_PHYSICAL_START. 
I modified CONFIG_PHYSICAL_ALIGN's configuration to be similar to 
CONFIG_PHYSICAL_START's configuration.


--
Yoshimi Ichiyanagi
Open source software computing project, NTT Cyber Space Laboratories
