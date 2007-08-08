From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 13/25] [PATCH] turn msr.h functions into native versions
Date: Wed, 8 Aug 2007 11:19:50 -0300
Message-ID: <5d6222a80708080719k2e2723mdf82572624856246__29200.5814997994$1186583047$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468003673-git-send-email-gcosta@redhat.com>
	<11865468043920-git-send-email-gcosta@redhat.com>
	<200708081125.38481.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081125.38481.ak@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> On Wednesday 08 August 2007 06:19, Glauber de Oliveira Costa wrote:
>
> > +static __always_inline long long vget_cycles_sync(void)
>
> Why is there a copy of this function now? That seems wrong

Yeah, the other one is in i386 headers, so We probably wan't to leave
it there. One option is to move get_cycles_sync to x86_64 headers, and
then #ifdef just the offending part.

> > +             native_read_tscp(&p);
>
> The instruction is called rdtscp not read_tscp. Please follow that

Although the operation consists in reading tscp. I choose this to be
consistent with i386, but I have no special feelings about it. I'm
okay with changing it if you prefer.

> > +#define rdtsc(low, high)                     \
>
> This macro can be probably eliminated, no callers in kernel
>
>
Fine.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
