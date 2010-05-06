From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: put last_used and last_avail index into ring itself.
Date: Thu, 6 May 2010 10:22:12 +0930
Message-ID: <201005061022.13815.rusty__3610.43410744077$1273107182$gmane$org@rustcorp.com.au>
References: <cover.1257349249.git.mst@redhat.com>
	<200911091647.29655.rusty@rustcorp.com.au>
	<20100504182236.GA14141@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504182236.GA14141@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 5 May 2010 03:52:36 am Michael S. Tsirkin wrote:
> > virtio: put last_used and last_avail index into ring itself.
> > 
> > Generally, the other end of the virtio ring doesn't need to see where
> > you're up to in consuming the ring.  However, to completely understand
> > what's going on from the outside, this information must be exposed.
> > For example, if you want to save and restore a virtio_ring, but you're
> > not the consumer because the kernel is using it directly.
> > 
> > Fortunately, we have room to expand: the ring is always a whole number
> > of pages and there's hundreds of bytes of padding after the avail ring
> > and the used ring, whatever the number of descriptors (which must be a
> > power of 2).
> > 
> > We add a feature bit so the guest can tell the host that it's writing
> > out the current value there, if it wants to use that.
> > 
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> I've been looking at this patch some more (more on why
> later), and I wonder: would it be better to add some
> alignment to the last used index address, so that
> if we later add more stuff at the tail, it all
> fits in a single cache line?

In theory, but not in practice.  We don't have many rings, so the
difference between 1 and 2 cache lines is not very much.

> We use a new feature bit anyway, so layout change should not be
> a problem.
> 
> Since I raised the question of caches: for used ring,
> the ring is not aligned to 64 bit, so on CPUs with 64 bit
> or larger cache lines, used entries will often cross
> cache line boundaries. Am I right and might it
> have been better to align ring entries to cache line boundaries?
> 
> What do you think?

I think everyone is settled on 128 byte cache lines for the forseeable
future, so it's not really an issue.

Cheers,
Rusty.
