From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 16:26:42 +0300
Message-ID: <20120717132642.GA10590__21794.7511272088$1342531605$gmane$org@redhat.com>
References: <50052276.2080906@redhat.com> <500527BA.9000001@redhat.com>
	<50052E7E.6020100@redhat.com>
	<CAJSP0QW0tPV3WASGOBRE4hL=8zzSFQ6T=bHbEwMAzmHR9wnwJg@mail.gmail.com>
	<20120717112645.GA9363@redhat.com>
	<CAJSP0QXPkrVvgA+1fhhwsB5J8oApOObK8D3fk_Lm0Bt3T+Wfuw@mail.gmail.com>
	<20120717115450.GA9796@redhat.com>
	<CAJSP0QXwGuUaD9piktOptJasdpci_fA90d=vV4m0SuORMvc2=Q@mail.gmail.com>
	<20120717124859.GA9883@redhat.com> <50056275.6000407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50056275.6000407@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 03:02:45PM +0200, Paolo Bonzini wrote:
> Il 17/07/2012 14:48, Michael S. Tsirkin ha scritto:
> > On Tue, Jul 17, 2012 at 01:03:39PM +0100, Stefan Hajnoczi wrote:
> >> On Tue, Jul 17, 2012 at 12:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> Knowing the answer to that is important before anyone can say whether
> >>>> this approach is good or not.
> >>>>
> >>>> Stefan
> >>>
> >>> Why is it?
> >>
> >> Because there might be a fix to kvmtool which closes the gap.  It
> >> would be embarassing if vhost-blk was pushed just because no one
> >> looked into what is actually going on.
> > 
> > Embarrasing to whom? Is someone working on an optimization that
> > makes the work in question redundant, with posting just around
> > the corner? Then maybe the thing to do is just wait a bit.
> 
> Of course there is work going on to make QEMU perform better.
> Not sure about lkvm.
> 
> >> And on the flipside, hard evidence of an overhead that cannot be
> >> resolved could be good reason to do more vhost devices in the future.
> > 
> > How can one have hard evidence of an overhead that cannot be resolved?
> 
> Since we do have two completely independent userspaces (lkvm and
> data-plane QEMU), you can build up some compelling evidence of an
> overhead that cannot be resolved in user space.

OK, so what you are saying benchmark against data-plane QEMU?
I agree actually. Asias, any data?

> >> Either way, it's useful to do this before going further.
> > 
> > I think each work should be discussed on its own merits.  Maybe
> > vhost-blk is just well written. So? What is your conclusion?
> 
> If it's just that vhost-blk is written well, my conclusion is that lkvm
> people should look into improving their virtio-blk userspace.  We take
> hints from each other all the time, for example virtio-scsi will have
> unlocked kick in 3.6.
> 
> Why can't vhost-* just get into staging, and we call it a day?
> 
> Paolo

staging is not a destination. Even if we put a driver in staging it
won't stay there indefinitely if qemu-kvm is not using it,
something that doesn't seem to be addressed for vhost-blk yet.

-- 
MST
