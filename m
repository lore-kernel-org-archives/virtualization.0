From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Tue, 9 Jul 2013 22:01:50 +0200
Message-ID: <20130709200150.GB27579@pd.tnic>
References: <20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<51DBDAB802000078000E37C1@nat28.tlf.novell.com>
	<20130709144840.GF24897@phenom.dumpdata.com>
	<20130709150554.GA27579@pd.tnic>
	<20130709171909.GA25586@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130709171909.GA25586@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Jan Beulich <JBeulich@suse.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org, mingo@redhat.com, Matt Wilson <msw@amazon.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 09, 2013 at 01:19:09PM -0400, Konrad Rzeszutek Wilk wrote:
> My thinking is that what should be done to have some sense of history
> is that the patch in GRUB to not rely on kernel internals should be
> done. Then that git commit of that tree should be mentioned in this
> kernel patch.

That's absolutely backwards and you know it. The two things - the kernel
and grub2 - have a defined interface and it is the only way they should
interact. Everything else is a bug.

> I wouldn't want GRUB2 to have regressions and stop generating the
> proper menu options. That smells of userspace regressions and I am not
> too keen to have Linus point this out to me.

You keep repeating that...

Dear Konrad, we need to talk about what a userspace regression is. And
in that case, grepping through the kernel .config and suddenly not
finding a certain symbol is not. That's like objdump-ing vmlinux and
relying on something there.

The patch removing this symbol is not violating a defined interface to
userspace. So you can't claim we're breaking anything here.

> Once that is done we can follow up on this patch and perhaps also
> nicely convience the initial author of this patch to look at removing
> the CONFIG_XEN_DOM0 and replacing them with the two other CONFIG
> options that Jan and me have been discussing.

Yes, but please make sure there's a bug opened against grub2 which lets
them know that grepping kernel configs is doomed to break sooner or
later.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
