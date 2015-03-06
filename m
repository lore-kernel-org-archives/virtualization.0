From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Fri, 6 Mar 2015 11:02:50 -0500
Message-ID: <20150306160249.GA8510@l.oracle.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F5B3DA.70203@samsung.com> <20150303141650.GA30332@l.oracle.com>
	<54F5D56C.6020803@samsung.com> <20150303160231.GA3518@l.oracle.com>
	<54F71861.9050702@samsung.com>
	<CAB=NE6WxNfxsqnv9MBpoL1=umdNReUCbM_dnxROjeY9J1Q-U_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAB=NE6WxNfxsqnv9MBpoL1=umdNReUCbM_dnxROjeY9J1Q-U_Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2015 at 05:47:03PM -0800, Luis R. Rodriguez wrote:
> On Wed, Mar 4, 2015 at 6:36 AM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> > On 03/03/2015 07:02 PM, Konrad Rzeszutek Wilk wrote:
> >> If it is like that - then just using what had to be implemented
> >> for the stack protection as a template ought to pave most of the
> >> work?
> >
> > Probably. I think I could make this work.
> > However, I won't be able to work on this until the end of the next week.
> 
> While a solution is likely possible here I'd like for us to notice how
> two features have gone now under our nose for Xen on v4.0 which have
> issues. Proactive maintainer reviews would detect these issues but we
> can't bet on these, and testing is just as reactive and slow. I'm

Hmm, I see you saying 'Proactive maintainer review would detect' these
but that assumes that the maintainer would even be copied on these patches?

None of the Xen maintainers were copied on this.

And while we all strive to be pro-active I have to remind you maintainers
are usually swamped.

> hinting we keep our eyes out for an architectural solution that would
> avoid these issues. Don't ask me what that is just yet...

Keep in mind that a lot of these issues get resolved during merge window
thanks to the resiliancy of Boris monitoring these tests with an sharp eye!

After all that is what merge windows are - things break during them.

> 
>  Luis
