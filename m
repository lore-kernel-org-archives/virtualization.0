From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: 9 Nov 2006 15:11:09 +0100
Message-ID: <20061109141109.GA63791@muc.de>
References: <1163034102.15681.6.camel@localhost.localdomain>
	<200611090812.37599.ak@suse.de>
	<20061108233904.e631c7c6.akpm@osdl.org>
	<20061109000939.7a48851f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Thu, 9 Nov 2006 15:11:09 +0100
Content-Disposition: inline
In-Reply-To: <20061109000939.7a48851f.akpm@osdl.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 09, 2006 at 12:09:39AM -0800, Andrew Morton wrote:
> On Wed, 8 Nov 2006 23:39:04 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> =

> > > Can you please resend the patchkit with these patches included?
> > > =

> > > (and any further changes folded in into the respective patches) =

> > > =

> > =

> > argh.
> > =

> > I'll do it.
> =

> OK, all done.
> =

> I kept prep-for-paravirt-be-careful-about-touching-bios.patch (below)
> separate, because it's dependent on
> x86_64-mm-i386-create-e820.c-to-handle-standard-io-mem-resources.patch.  =
It
> could be folded into one of the other patches I guess.
> =

> So I have:
> =

> paravirt-i386-header-and-stubs-for-paravirtualisation.patch
> paravirt-i386-patch-inline-replacements-for.patch
> paravirt-i386-more-generic-paravirtualization.patch
> paravirt-i386-allow-selected-bug-checks-to-be.patch
> paravirt-i386-allow-disabling-legacy-power.patch
> paravirt-i386-add-apic-accessors-to-paravirt-ops.patch
> paravirt-i386-add-mmu-virtualization-to.patch
> prep-for-paravirt-be-careful-about-touching-bios.patch

Thanks. Where can I get them?

-Andi
