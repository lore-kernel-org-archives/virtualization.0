From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
Date: Sun, 10 Jan 2016 21:13:38 +0200
Message-ID: <20160110191338.GA5063__34357.8448905193$1452453254$gmane$org@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
	<1452427000-4520-2-git-send-email-mst@redhat.com>
	<1452438425.7773.21.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452438425.7773.21.camel@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Whitcroft <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.orgAndrew Cooper <an>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 10, 2016 at 07:07:05AM -0800, Joe Perches wrote:
> On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> > SMP-only barriers were missing in checkpatch.pl
> > =

> > Refactor code slightly to make adding more variants easier.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5116,7 +5116,25 @@ sub process {
> > =A0			}
> > =A0		}
> > =A0# check for memory barriers without a comment.
> > -		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|sm=
p_wmb|smp_read_barrier_depends)\(/) {
> > +
> > +		my $barriers =3D qr{
> > +			mb|
> > +			rmb|
> > +			wmb|
> > +			read_barrier_depends
> > +		}x;
> > +		my $smp_barriers =3D qr{
> > +			store_release|
> > +			load_acquire|
> > +			store_mb|
> > +			($barriers)
> > +		}x;
> =

> If I use a variable called $smp_barriers, I'd expect
> it to actually be the smp_barriers, not to have to
> prefix it with smp_ before using it.
> =

> 		my $smp_barriers =3D qr{
> 			smp_store_release|
> 			smp_load_acquire|
> 			smp_store_mb|
> 			smp_read_barrier_depends
> 		}x;
> =

> or
> =

> 		my $smp_barriers =3D qr{
> 			smp_(?:store_release|load_acquire|store_mb|read_barrier_depends)
> 		}x;
> =


Yes but virt barriers (added in patch 3) are same things but prefixed
with virt_.  So we need the stems without smp_ prefix. If smp_barriers is
too confusing we'll just need to give them some other name.
How about:
my $smp_barrier_stems

?

> > +		my $all_barriers =3D qr{
> > +			$barriers|
> > +			smp_($smp_barriers)
> > +		}x;
> =

> And this shouldn't have a capture group.
> =

> 		my $all_barriers =3D qr{
> 			$barriers|
> 			$smp_barriers
> 		}x;		=

> > +
> > +		if ($line =3D~ /\b($all_barriers)\s*\(/) {
> =

> This doesn't need the capture group either (?:all_barriers)
> =

> > =A0			if (!ctx_has_comment($first_line, $linenr))
> > {
> > =A0				WARN("MEMORY_BARRIER",
> > =A0				=A0=A0=A0=A0=A0"memory barrier without
> > comment\n" . $herecurr);
