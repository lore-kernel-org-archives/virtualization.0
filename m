From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 15:48:59 +0300
Message-ID: <20120717124859.GA9883__5803.90647887743$1342529319$gmane$org@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
	<50052276.2080906@redhat.com> <500527BA.9000001@redhat.com>
	<50052E7E.6020100@redhat.com>
	<CAJSP0QW0tPV3WASGOBRE4hL=8zzSFQ6T=bHbEwMAzmHR9wnwJg@mail.gmail.com>
	<20120717112645.GA9363@redhat.com>
	<CAJSP0QXPkrVvgA+1fhhwsB5J8oApOObK8D3fk_Lm0Bt3T+Wfuw@mail.gmail.com>
	<20120717115450.GA9796@redhat.com>
	<CAJSP0QXwGuUaD9piktOptJasdpci_fA90d=vV4m0SuORMvc2=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJSP0QXwGuUaD9piktOptJasdpci_fA90d=vV4m0SuORMvc2=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 01:03:39PM +0100, Stefan Hajnoczi wrote:
> On Tue, Jul 17, 2012 at 12:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> Knowing the answer to that is important before anyone can say whether
> >> this approach is good or not.
> >>
> >> Stefan
> >
> > Why is it?
> 
> Because there might be a fix to kvmtool which closes the gap.  It
> would be embarassing if vhost-blk was pushed just because no one
> looked into what is actually going on.

Embarrasing to whom? Is someone working on an optimization that
makes the work in question redundant, with posting just around
the corner? Then maybe the thing to do is just wait a bit.

Or are there no specific plans even, just a vague "sometime
in the future someone might take Asias' patches and profile them see if
anything maybe sticks out"? Then maybe not making everyone
wait years for this will serve users better.

> And on the flipside, hard evidence of an overhead that cannot be
> resolved could be good reason to do more vhost devices in the future.

How can one have hard evidence of an overhead that cannot be resolved?
Any problem can be resolved in an infinite number of ways.

> Either way, it's useful to do this before going further.
> 
> Stefan

I think each work should be discussed on its own merits.  Maybe
vhost-blk is just well written. So? What is your conclusion?

-- 
MST
