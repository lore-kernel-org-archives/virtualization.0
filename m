From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 15:08:40 -0800
Message-ID: <455CEF78.8070607@vmware.com>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061116145313.d7b2240b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116145313.d7b2240b.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 19 Oct 2006 17:09:22 -0700
> Zachary Amsden <zach@vmware.com> wrote:
>
>   =

>> Add a way to disable the timer IRQ routing check via a boot option.  The
>> VMI timer code uses this to avoid triggering the pester Mingo code, which
>> probes for some very unusual and broken motherboard routings.  It fires
>> 100% of the time when using a paravirtual delay mechanism instead of
>> using a realtime delay, since there is no elapsed real time, and the 4 t=
imer
>> IRQs have not yet been delivered.
>>
>> In addition, it is entirely possible, though improbable, that this bug
>> could surface on real hardware which picks a particularly bad time to en=
ter
>> SMM mode, causing a long latency during one of the timer IRQs.
>>
>> While here, make check_timer be __init.
>>
>>     =

>
> Andi seems to have merged this patch but from somewhere I picked up a
> different version, below.
>
> I think the version I have is better.  Because the patch Andi has merged =
is
> cast in terms of "irq testing", which is broad.  But that's not what the
> patch does - the patch handles only timers.
>
> IOW, this:
>
>   =

>> +
>> +	noirqtest	[IA-32,APIC] Disables the code which tests for broken
>> +			timer IRQ sources.
>>     =

>
> is misleadingly named.  This:
>
> +       no_timer_check  [IA-32,X86_64,APIC] Disables the code which tests=
 for
> +                       broken timer IRQ sources.
> +
>
> is better, no?
>
> But right now, I'll settle for anything which usually compiles.
>
>   =


Yes, the name sucks.  There is no real reason to actually have a boot =

parameter at all once the paravirt / VMI patches are in, but I wanted =

something to be able to set timer_irq_really_works until then to avoid =

someone accidentally removing it.

Zach
