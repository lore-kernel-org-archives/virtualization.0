From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Date: Mon, 04 Jan 2016 08:15:14 -0800
Message-ID: <1451924114.4334.85.camel__34547.1418848776$1451954136$gmane$org@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	<1451907395-15978-2-git-send-email-mst@redhat.com>
	<1451923660.4334.83.camel@perches.com>
	<20160104161123.GJ19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, "Cc
	: Andy Whitcroft" <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2016-01-04 at 16:11 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > > +
> > > +		if ($line =~ /\b($all_barriers)\(/) {
> > 
> > It would be better to use /\b$all_barriers\s*\(/
> > as there's no reason for the capture and there
> > could be a space between the function and the
> > open parenthesis.
> 
> I think you mean
> 
> 	/\b(?:$all_barriers)\s*\(/
> 
> as 'all_barriers' will be:
> 
> 	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb
> 
> and putting that into your suggestion results in:
> 
> 	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/
> 
> which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
> applies to smp_rmb.

right, thanks.
