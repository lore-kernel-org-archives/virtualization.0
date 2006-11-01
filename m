From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/7] paravirtualization: Allow selected bug checks to
	be	skipped by paravirt kernels
Date: Wed, 01 Nov 2006 15:58:15 -0800
Message-ID: <45493497.1040707@goop.org>
References: <20061029024504.760769000@sous-sol.org>	<20061029024607.401333000@sous-sol.org>	<200610290831.21062.ak@suse.de>	<1162178936.9802.34.camel@localhost.localdomain>	<20061030231132.GA98768@muc.de>	<1162376827.23462.5.camel@localhost.localdomain>	<1162376894.23462.7.camel@localhost.localdomain>	<1162376981.23462.10.camel@localhost.localdomain>	<1162377043.23462.12.camel@localhost.localdomain>
	<20061101152946.14f95f79.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061101152946.14f95f79.akpm@osdl.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:30:43 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>   =

>> --- a/include/asm-i386/bugs.h
>> +++ b/include/asm-i386/bugs.h
>> @@ -21,6 +21,7 @@
>>  #include <asm/processor.h>
>>  #include <asm/i387.h>
>>  #include <asm/msr.h>
>> +#include <asm/paravirt.h>
>>     =

>
> In many other places you have
>
> #ifdef CONFIG_PARAVIRT
> #include <asm/paravirt.h>
> ...
>
> But not here.
>
> Making <asm/paravirt.h> invulnerable would be the more typical approach.
CONFIG_PARAVIRT is not being used to guard asm/paravirt.h from multiple =

inclusion.  In places where it is being used to guard #include =

<asm/paravirt.h>, the idea is that asm/paravirt.h defines various =

inlines/macros which would otherwise be defined in the header.  So, for =

example, asm/desc.h would normally define load_gdt() in the =

!CONFIG_PARAVIRT case, but asm/paravirt.h defines it when =

CONFIG_PARAVIRT is enabled. =


In this case, asm/paravirt.h included because we need the definition for =

paravirt_enabled(), not because it is replacing any of bugs.h's definitions.

    J
