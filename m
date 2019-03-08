From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 22:43:12 -0500
Message-ID: <20190307224143-mutt-send-email-mst__46544.6358359017$1552016606$gmane$org@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191720.GF3835@redhat.com>
	<20190307211506-mutt-send-email-mst@kernel.org>
	<20190308025539.GA5562@redhat.com>
	<20190307221549-mutt-send-email-mst@kernel.org>
	<20190308034053.GB5562@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190308034053.GB5562@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2019 at 10:40:53PM -0500, Jerome Glisse wrote:
> On Thu, Mar 07, 2019 at 10:16:00PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 07, 2019 at 09:55:39PM -0500, Jerome Glisse wrote:
> > > On Thu, Mar 07, 2019 at 09:21:03PM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > > > > > It's because of all these issues that I preferred just accessing
> > > > > > userspace memory and handling faults. Unfortunately there does =
not
> > > > > > appear to exist an API that whitelists a specific driver along =
the lines
> > > > > > of "I checked this code for speculative info leaks, don't add b=
arriers
> > > > > > on data path please".
> > > > > =

> > > > > Maybe it would be better to explore adding such helper then remap=
ping
> > > > > page into kernel address space ?
> > > > =

> > > > I explored it a bit (see e.g. thread around: "__get_user slower than
> > > > get_user") and I can tell you it's not trivial given the issue is a=
round
> > > > security.  So in practice it does not seem fair to keep a significa=
nt
> > > > optimization out of kernel because *maybe* we can do it differently=
 even
> > > > better :)
> > > =

> > > Maybe a slightly different approach between this patchset and other
> > > copy user API would work here. What you want really is something like
> > > a temporary mlock on a range of memory so that it is safe for the
> > > kernel to access range of userspace virtual address ie page are
> > > present and with proper permission hence there can be no page fault
> > > while you are accessing thing from kernel context.
> > > =

> > > So you can have like a range structure and mmu notifier. When you
> > > lock the range you block mmu notifier to allow your code to work on
> > > the userspace VA safely. Once you are done you unlock and let the
> > > mmu notifier go on. It is pretty much exactly this patchset except
> > > that you remove all the kernel vmap code. A nice thing about that
> > > is that you do not need to worry about calling set page dirty it
> > > will already be handle by the userspace VA pte. It also use less
> > > memory than when you have kernel vmap.
> > > =

> > > This idea might be defeated by security feature where the kernel is
> > > running in its own address space without the userspace address
> > > space present.
> > =

> > Like smap?
> =

> Yes like smap but also other newer changes, with similar effect, since
> the spectre drama.
> =

> Cheers,
> J=E9r=F4me

Sorry do you mean meltdown and kpti?

-- =

MST
