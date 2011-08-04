From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [Xen-devel] Re: linux-next: Tree for July 25 (xen)
Date: Thu, 04 Aug 2011 16:53:59 -0700
Message-ID: <4E3B3117.5050308__49417.3612831675$1312502085$gmane$org@xenotime.net>
References: <20110725162542.39ea8d8cbd51604523635c1a@canb.auug.org.au>
	<20110725144629.b752bf14.rdunlap@xenotime.net>
	<20110804193534.GB12729@elte.hu>
	<20110804195539.GA11198@dumpdata.com>
	<20110804131516.c4da6595.rdunlap@xenotime.net>
	<20110804223259.GB4370@dumpdata.com>
	<20110804224020.GA21492@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110804224020.GA21492@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 08/04/11 15:40, Konrad Rzeszutek Wilk wrote:
> On Thu, Aug 04, 2011 at 06:32:59PM -0400, Konrad Rzeszutek Wilk wrote:
>>>>> These build failures are still triggering upstream:
>>>>>
>>>>>  arch/x86/xen/trace.c:44:2: error: array index in initializer not of =
integer type
>>>>>  arch/x86/xen/trace.c:44:2: error: (near initialization for =91xen_hy=
percall_names=92)
>>>>>  arch/x86/xen/trace.c:45:1: error: =91__HYPERVISOR_arch_4=92 undeclar=
ed here (not in a function)
>>>>>  arch/x86/xen/trace.c:45:2: error: array index in initializer not of =
integer type
>>>>>  arch/x86/xen/trace.c:45:2: error: (near initialization for =91xen_hy=
percall_names=92)
>>>>
>>>> Oh, that I haven't seen. Can you send me the .config for that please.
>>>
>>> You can't be trying very hard then.  I see lots of these (but no,
>>
>> Ah, I am getting it now. Thanks for reporting it.
> =

> This should do the trick:

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.


> diff --git a/arch/x86/xen/trace.c b/arch/x86/xen/trace.c
> index 734beba..520022d 100644
> --- a/arch/x86/xen/trace.c
> +++ b/arch/x86/xen/trace.c
> @@ -1,4 +1,5 @@
>  #include <linux/ftrace.h>
> +#include <xen/interface/xen.h>
>  =

>  #define N(x)	[__HYPERVISOR_##x] =3D "("#x")"
>  static const char *xen_hypercall_names[] =3D {


-- =

~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
