From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] ptr_ring: Add barriers to fix NULL-pointer exception
Date: Wed, 6 Dec 2017 17:57:25 +0200
Message-ID: <20171206175023-mutt-send-email-mst@kernel.org>
References: <1512554261-5030-1-git-send-email-george.cherian@cavium.com>
	<20171206153349-mutt-send-email-mst@kernel.org>
	<BN3PR0701MB1702F47F81C945950E284DE0F9320@BN3PR0701MB1702.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0701MB1702F47F81C945950E284DE0F9320@BN3PR0701MB1702.namprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Cherian, George" <George.Cherian@cavium.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 06, 2017 at 02:08:54PM +0000, Cherian, George wrote:
> > @@ -275,6 +281,13 @@ static inline void *__ptr_ring_consume(struct ptr_ring
> *r)
> > if (ptr)
> > __ptr_ring_discard_one(r);
> >
> > + /*
> > + * This barrier is necessary in order to prevent race condition with
> > + * with __ptr_ring_produce(). Make sure all the elements of ptr is
> > + * in sync with the earlier writes which was done prior to pushing
> > + * it to ring
> > + */
> > + rmb();
> > return ptr;
> > }
> 
> You are trying to synchronise two CPUs so non-smp barriers make no
> sense. wmb/rmb are for synchronising with MMIO.
> 
> What happens when CONFIG_SMP is not set. smp_wmb/rmb becomes compiler barriers
> (atleast for arm64).

And that is because all read and writes always appear in order when done
from the same CPU.

In case of reads, we do not need a barrier at all (except on dec alpha)
because a read through a pointer can't bypass a read of a pointer.

> I guess that is not what we need.

Maybe, but I don't yet see why not.

> An SMP barrier cannot
> replace a mandatory barrier, but a mandatory barrier can replace an SMP
> barrier.

This does imply that you can always replace a weak barrier with a strong
one, but does not mean you should.

> I will try out your patch too and update the results.
> But I would need couple of days time. Sorry for the delay.

Thanks for the testing.

-- 
MST
