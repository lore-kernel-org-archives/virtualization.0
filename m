From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Tue, 3 Mar 2015 09:16:50 -0500
Message-ID: <20150303141650.GA30332@l.oracle.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F5B3DA.70203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54F5B3DA.70203@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2015 at 04:15:06PM +0300, Andrey Ryabinin wrote:
> On 03/03/2015 12:40 PM, Luis R. Rodriguez wrote:
> > Andrey,
> > 
> > I believe that on Xen we should disable kasan, would like confirmation
> 
> I guess Xen guests won't work with kasan because Xen guests doesn't setup shadow
> (kasan_map_early_shadow() is not called in xen guests).
> 
> Disabling kasan for Xen in Kconfig is undesirable because that will disable kasan
> for allmodconfig and allyesconfig builds, but I don't see other option for now.

Was there an bug reported for this? It would be good to CC the maintainers
of Xen on that sort of thing.

Thanks!
.. snip..
> > [0] https://lkml.org/lkml/2015/2/23/328

If you look at the other x86 pulls - you will see that the authors
also missed enabling it on 32-bit kernels!

> > 
> >  Luis
> > 
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
