From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: virtq questions
Date: Thu, 3 Oct 2019 15:45:15 -0400
Message-ID: <20191003194515.GA13783@redhat.com>
References: <CAJfpegsGNoT4NUai-=HHkqOrmjgMb=4TDk79EgxDBCd8fxCGZA@mail.gmail.com>
	<20191002132734.GA6972@redhat.com>
	<CAJfpegvJGTFiJh5MFRNQF8dQQo7KS5f0Ei7vEYOBTw4RzVtA2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJfpegvJGTFiJh5MFRNQF8dQQo7KS5f0Ei7vEYOBTw4RzVtA2w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 03, 2019 at 10:42:44AM +0200, Miklos Szeredi wrote:
> On Wed, Oct 2, 2019 at 3:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Oct 02, 2019 at 09:40:11AM +0200, Miklos Szeredi wrote:
> > > Looking at the ugly retry logic in virtiofs and have some questions.
> >
> > Hi Miklos,
> >
> > What are you thinking w.r.t cleanup of retry logic. As of now we put
> > requests in a list and retry later with the help of a worker.
> 
> Two things:
> 
>  - don't use a timeout for retrying
>  - try to preserve order of requests submitted vs. order of requests queued

Hi Miklos,

I understand first point but no the second one. Can you elaborate a bit
more that why it is important. Device does not provide any guarantees
that requests will be completed in order of submission. If that's the
case, then submitter can't assume any order in request completion anyway.

> 
> This is complicated by the fact that we call virtqueue_add_sgs() under
> spinlock, which is the reason GFP_ATOMIC is used.  However GFP_ATOMIC
> can easily fail and that means even if the "indirect_desc" feature is
> turned on a request may use several slots of the ring buffer for a
> single request.

Aha, you are referring to the case where indirect_desc feature is enabled
but memory allocation fails, so it falls back to using regular
descriptors.

> Worst case is that a request has lots of pages,
> resulting in total_sgs > vring.num, which is bad, because we'll get
> ENOSPC thinking that the operation needs to be retried once some
> pending requests are done, but that's not actually the case...

Got it. So if we always allocate memory for total_sgs (which could
be more than vring.num) and are in a position to wait for memory
allocation, then this problem will not be there.

Alternate solution probably is to query queue size in the beginning
and make sure number of pages attached to a request are less then 
that.

> 
> So my proposed solution is to turn fsvq->lock into a mutex; call
> virtqueue_add_sgs() with whatever gfp flags are used to allocate the
> request and add __GFP_NOFAIL for good measure.  This means that the
> request is guaranteed to use a single slot IF "indirect_desc" is on.
> And there should be some way to verify from the virtiofs code that
> this feature is indeed on, otherwise things can get messy (as noted
> above).

Sounds reasonable.

So if system is under memory pressure, currently we will fall back to
using pre-allocated descriptors instead of waiting for memory to become
free. IOW, virtio-fs can continue to make progress. But with GFP_NOFAIL
we will wait for memory to be allocated for indirect descriptor and
then make progress. It probably is fine, I am just thinking loud.

I noticed that all the virtio drivers currently seem to be using
GFP_ATOMIC. Interesting...

Anyway, it probably is worth trying it. It also solves the problem of
retrying as we will block for resources to be allocated and should
not get -ENOSPC or -ENOMEM.

BTW, I have few cleanup/improvement patches lined up internally to
use better method to wait for draining of request. Will post these
separately. They probably can go in next merge window.

Thanks
Vivek
