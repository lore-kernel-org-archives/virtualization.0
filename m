From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Date: Mon, 04 Jan 2016 08:07:40 -0800
Message-ID: <1451923660.4334.83.camel__47896.5050112039$1451940958$gmane$org@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	<1451907395-15978-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451907395-15978-2-git-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, "Cc : Andy Whitcroft" <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> SMP-only barriers were missing in checkpatch.pl
> =

> Refactor code slightly to make adding more variants easier.
> =

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> =A0scripts/checkpatch.pl | 9 ++++++++-
> =A01 file changed, 8 insertions(+), 1 deletion(-)
> =

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2b3c228..0245bbe 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5116,7 +5116,14 @@ sub process {
> =A0			}
> =A0		}
> =A0# check for memory barriers without a comment.
> -		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_=
wmb|smp_read_barrier_depends)\(/) {
> +
> +		my @barriers =3D ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> +		my @smp_barriers =3D ('smp_store_release', 'smp_load_acquire', 'smp_st=
ore_mb');
> +
> +		@smp_barriers =3D (@smp_barriers, map {"smp_" . $_} @barriers);

I think using map, which so far checkpatch doesn't use,
makes smp_barriers harder to understand and it'd be
better to enumerate them.

> +		my $all_barriers =3D join('|', (@barriers, @smp_barriers));
> +
> +		if ($line =3D~ /\b($all_barriers)\(/) {

It would be better to use /\b$all_barriers\s*\(/
as there's no reason for the capture and there
could be a space between the function and the
open parenthesis.


> =A0			if (!ctx_has_comment($first_line, $linenr)) {
> =A0				WARN("MEMORY_BARRIER",
> =A0				=A0=A0=A0=A0=A0"memory barrier without comment\n" . $herecurr);
