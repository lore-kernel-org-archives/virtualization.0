From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 2/2] x86/vdso: Add VCLOCK_HVCLOCK vDSO clock read
	method
Date: Wed, 8 Feb 2017 18:52:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702081849050.3536__10034.2680038468$1486579203$gmane$org@nanos>
References: <20170208170744.7632-1-vkuznets@redhat.com>
	<20170208170744.7632-3-vkuznets@redhat.com>
	<CALCETrU48en_Zki88eXZEcU7QFf0u9sVAT_qgY0TyzoWkP2-6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrU48en_Zki88eXZEcU7QFf0u9sVAT_qgY0TyzoWkP2-6g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 8 Feb 2017, Andy Lutomirski wrote:
> > +#ifdef CONFIG_HYPERV_CLOCK
> > +/* (a * b) >> 64 implementation */
> > +static inline u64 mul64x64_hi(u64 a, u64 b)
> > +{
> > +       u64 a_lo, a_hi, b_lo, b_hi, p1, p2;
> > +
> > +       a_lo = (u32)a;
> > +       a_hi = a >> 32;
> > +       b_lo = (u32)b;
> > +       b_hi = b >> 32;
> > +       p1 = a_lo * b_hi;
> > +       p2 = a_hi * b_lo;
> > +
> > +       return a_hi * b_hi + (p1 >> 32) + (p2 >> 32) +
> > +               ((((a_lo * b_lo) >> 32) + (u32)p1 + (u32)p2) >> 32);
> > +
> > +}
> 
> Unless GCC is waaay more clever than I think, this is hugely
> suboptimal on 64-bit.  x86 can do this in a single instruction, and
> gcc can express it cleanly using __uint128_t.  I wouldn't be terribly
> surprised if the 32-bit generated code was fine, too.

We already have that: mul_u64_u64_shr() which can be replaced by an arch
specific implementation. Nobody bothered to do that for x86 yet, but we
definitely don't want to open code it another time

Thanks,

	tglx
