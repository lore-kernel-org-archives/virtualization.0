From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Wed, 21 Jun 2017 15:41:30 +0300
Message-ID: <20170621153055-mutt-send-email-mst__39213.8583156795$1498048908$gmane$org@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
	<20170620212107-mutt-send-email-mst@kernel.org>
	<1497988260.20270.109.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1497988260.20270.109.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: aarcange@redhat.com, amit.shah@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, Nitesh Narayan Lal <nilal@redhat.com>, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 20, 2017 at 03:51:00PM -0400, Rik van Riel wrote:
> On Tue, 2017-06-20 at 21:26 +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 20, 2017 at 01:29:00PM -0400, Rik van Riel wrote:
> > > I agree with that.=A0=A0Let me go into some more detail of
> > > what Nitesh is implementing:
> > > =

> > > 1) In arch_free_page, the being-freed page is added
> > > =A0=A0=A0to a per-cpu set of freed pages.
> > > 2) Once that set is full, arch_free_pages goes into a
> > > =A0=A0=A0slow path, which:
> > > =A0=A0=A02a) Iterates over the set of freed pages, and
> > > =A0=A0=A02b) Checks whether they are still free, and
> > > =A0=A0=A02c) Adds the still free pages to a list that is
> > > =A0=A0=A0=A0=A0=A0=A0to be passed to the hypervisor, to be MADV_FREEd.
> > > =A0=A0=A02d) Makes that hypercall.
> > > =

> > > Meanwhile all arch_alloc_pages has to do is make sure it
> > > does not allocate a page while it is currently being
> > > MADV_FREEd on the hypervisor side.
> > > =

> > > The code Wei is working on looks like it could be=A0
> > > suitable for steps (2c) and (2d) above. Nitesh already
> > > has code for steps 1 through 2b.
> > =

> > So my question is this: Wei posted these numbers for balloon
> > inflation times:
> > inflating 7GB of an 8GB idle guest:
> > =

> > 	1) allocating pages (6.5%)
> > 	2) sending PFNs to host (68.3%)
> > 	3) address translation (6.1%)
> > 	4) madvise (19%)
> > =

> > 	It takes about 4126ms for the inflating process to complete.
> > =

> > It seems that this is an excessive amount of time to stay
> > under a lock. What are your estimates for Nitesh's work?
> =

> That depends on the batch size used for step
> (2c), and is something that we should be able
> to tune for decent performance.

I am not really sure how you intend to do this. Who will
drop and retake the lock? How do you make progress
instead of restarting from the beginning?
How do you combine multiple pages in a single s/g?

All these were issues that Wei's patches solved,
granted in a very limited manner (migration-specific)
but OTOH without a lot of tuning.


> What seems to matter is that things are batched.
> There are many ways to achieve that.

True, this is what the patches are trying to achieve.  So far this
approach was the 1st more or less workable way do achieve that,
previous ones got us nowhere.


> -- =

> All rights reversed
