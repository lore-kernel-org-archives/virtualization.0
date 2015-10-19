From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date: Mon, 19 Oct 2015 12:06:56 +0200
Message-ID: <7382069.z44JKC1I1I__21360.6426645585$1445249288$gmane$org@wuerfel>
References: <5082760.FgB9zHNfte@wuerfel> <5152101.mD2bWzUJ2V@wuerfel>
	<20151019093700.GC2092@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151019093700.GC2092@linux-mips.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Arun Sharma <asharma@fb.com>, Dave Airlie <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 19 October 2015 11:37:00 Ralf Baechle wrote:
> On Wed, Oct 07, 2015 at 01:23:07PM +0200, Arnd Bergmann wrote:
> 
> > > I haven't checked all architectures, but I assume what happens is that
> > > 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
> > > to provide three sets of functions.
> > 
> > scratch that, I just looked at all the architectures and found that it's
> > just completely arbitrary, even within one architecture you get a mix
> > of 'long' and 'long long', plus this gem from MIPS:
> > 
> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > 
> > which truncates the result to 32 bit.
> 
> Eh...  The result is 0/1 so nothing is truncated.  Alpha, MIPS,
> PARISC and PowerPC are using the same prototype and x86 only differs
> in the use of inline instead __inline__.  And anyway, that function on
> MIPS is only built for CONFIG_64BIT.

Ah, got it. Sorry about that.

> What's wrong on MIPS is the comment describing the function's return value
> which was changed by f24219b4e90cf70ec4a211b17fbabc725a0ddf3c (atomic: move
> atomic_add_unless to generic code) and I've queued up a patch to fix that
> since a few days.  I guess that was a cut and paste error from
> __atomic_add_unless which indeed does return the old value.

Thanks!

	Arnd
