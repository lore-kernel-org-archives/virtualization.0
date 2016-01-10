From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/3] checkpatch: check for __smp outside barrier.h
Date: Sun, 10 Jan 2016 07:08:39 -0800
Message-ID: <1452438519.7773.23.camel__14989.0572218739$1452476659$gmane$org@perches.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
	<1452427000-4520-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1452427000-4520-3-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Whitcroft <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.orgAndrew Cooper <an>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2016-01-10 at 13:57 +0200, Michael S. Tsirkin wrote:
> Introduction of __smp barriers cleans up a bunch of duplicate code, but
> it gives people an additional handle onto a "new" set of barriers - just
> because they're prefixed with __* unfortunately doesn't stop anyone from
> using it (as happened with other arch stuff before.)
> =

> Add a checkpatch test so it will trigger a warning.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5141,6 +5141,16 @@ sub process {
> =A0			}
> =A0		}
> =A0
> +		my $underscore_smp_barriers =3D qr{__smp_($smp_barriers)}x;

another unnecessary capture group

> +
> +		if ($realfile !~ m@^include/asm-generic/@ &&
> +		=A0=A0=A0=A0$realfile !~ m@/barrier\.h$@ &&
> +		=A0=A0=A0=A0$line =3D~ m/\b($underscore_smp_barriers)\s*\(/ &&
> +		=A0=A0=A0=A0$line !~ m/^.\s*\#\s*define\s+($underscore_smp_barriers)\s=
*\(/) {
> +			WARN("MEMORY_BARRIER",
> +			=A0=A0=A0=A0=A0"__smp memory barriers shouldn't be used outside barri=
er.h and asm-generic\n" . $herecurr);
> +		}
> +
> =A0# check for waitqueue_active without a comment.
> =A0		if ($line =3D~ /\bwaitqueue_active\s*\(/) {
> =A0			if (!ctx_has_comment($first_line, $linenr)) {
