From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 14:40:16 -0700
Message-ID: <462D27C0.2020200@vmware.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>	<462B9BE6.6040302@goop.org>
	<462D1CBC.6050405@vmware.com>
	<m1mz0yvlmu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1mz0yvlmu.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
>> Yes, we still do late paravirtualization.  My point is that because of that, you
>> can't just link once and be done with it - you must relink the paravirt-ops
>> later, which is more complex than a one time pre-execution link.
>>     
>
> Then if it is causing problems and making the code more complex (and it sounds
> like it is) please let's get rid of late paravirtualization.
>
> arch/i386 is in bad enough shape with tons of unnecessary special cases.
> We don't need the paravirtualization support adding more.
>   

Late paravirtualization is not causing problems and making the code more 
complex, in fact it is making it simpler.  The fact that we don't need 
to intrude in the boot process at all, but can let the code run without 
inhibition and 100's of special hooks is saving a lot of complexity.  
Otherwise, we would need to dissect head.S even further with custom junk 
for VMI, including probing for ROMs and other things that are just 
naturally easier once you have basic kernel architecture like physical 
mapping, PAE-ness and memory management in place.  Paravirtualizing the 
init code to set both non-PAE and PAE ptes from non-PAE mode (see 
boot_ioremap.c) would be one such grotesque and unwarranted violation.

My point is that if we were to use a linker type approach, it needs to 
be done before the first instruction of the kernel (in particular, 
before the first cpuid ever gets run); this makes it tempting to do in 
some weird assembly goo in head.S, instead of doing it in proper C code 
that can be reused later on.  Doing it in C would be better coding 
practice, it just requires more effort to avoid taking shortcuts (to 
work around the non-C starting environment).

Zach
