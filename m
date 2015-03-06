From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Fri, 6 Mar 2015 17:47:54 +0100
Message-ID: <20150306164754.GD25035__20661.4777948291$1425660499$gmane$org@wotan.suse.de>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F5B3DA.70203@samsung.com> <20150303141650.GA30332@l.oracle.com>
	<54F5D56C.6020803@samsung.com> <20150303160231.GA3518@l.oracle.com>
	<54F71861.9050702@samsung.com>
	<CAB=NE6WxNfxsqnv9MBpoL1=umdNReUCbM_dnxROjeY9J1Q-U_Q@mail.gmail.com>
	<20150306160249.GA8510@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150306160249.GA8510@l.oracle.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 06, 2015 at 11:02:50AM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 04, 2015 at 05:47:03PM -0800, Luis R. Rodriguez wrote:
> > On Wed, Mar 4, 2015 at 6:36 AM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> > > On 03/03/2015 07:02 PM, Konrad Rzeszutek Wilk wrote:
> > >> If it is like that - then just using what had to be implemented
> > >> for the stack protection as a template ought to pave most of the
> > >> work?
> > >
> > > Probably. I think I could make this work.
> > > However, I won't be able to work on this until the end of the next week.
> > 
> > While a solution is likely possible here I'd like for us to notice how
> > two features have gone now under our nose for Xen on v4.0 which have
> > issues. Proactive maintainer reviews would detect these issues but we
> > can't bet on these, and testing is just as reactive and slow. I'm
> 
> Hmm, I see you saying 'Proactive maintainer review would detect' these
> but that assumes that the maintainer would even be copied on these patches?
> 
> None of the Xen maintainers were copied on this.

That is a damn shame. More on this below.

> And while we all strive to be pro-active I have to remind you maintainers
> are usually swamped.

Right, I expected this, its why I in no way am saying its the roles
which would cause this.

> > hinting we keep our eyes out for an architectural solution that would
> > avoid these issues. Don't ask me what that is just yet...
> 
> Keep in mind that a lot of these issues get resolved during merge window
> thanks to the resiliancy of Boris monitoring these tests with an sharp eye!

If this is about testing then its reactive. Its still great work but reactive
is never better than a proactive engineering solution.

> After all that is what merge windows are - things break during them.

Sure. What was highlighting, and now with a bit different emphasis, is the
fragile nature of using different entry points for both PV Xen and bare metal
x86_64 init, as well as other things involved with Xen which require careful
surgery and analysis. I was alluding to the possibility of seeing if we can
somehow draw up a solution to make it rather hard for these sorts of issues
to creep up again and for Xen to reactively correct them, with what you point
out that even the Xen maintainers were not copied on these patches it makes
this a bit more of an important issue otherwise we're going to be in the same
situation for v4.1, v4.2 and so on.

If I had a technical solution to this problem I'd propose it but I don't,
I'm just flagging it right now and hope we can come up with one.

 Luis
