From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: put last_used and last_avail index into ring itself.
Date: Fri, 7 May 2010 12:35:39 +0930
Message-ID: <201005071235.40590.rusty__2379.69078957594$1273201653$gmane$org@rustcorp.com.au>
References: <cover.1257349249.git.mst@redhat.com>
	<201005061022.13815.rusty@rustcorp.com.au>
	<20100506062755.GC8363@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506062755.GC8363@redhat.com>
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

On Thu, 6 May 2010 03:57:55 pm Michael S. Tsirkin wrote:
> On Thu, May 06, 2010 at 10:22:12AM +0930, Rusty Russell wrote:
> > On Wed, 5 May 2010 03:52:36 am Michael S. Tsirkin wrote:
> > > What do you think?
> > 
> > I think everyone is settled on 128 byte cache lines for the forseeable
> > future, so it's not really an issue.
> 
> You mean with 64 bit descriptors we will be bouncing a cache line
> between host and guest, anyway?

I'm confused by this entire thread.

Descriptors are 16 bytes.  They are at the start, so presumably aligned to
cache boundaries.

Available ring follows that at 2 bytes per entry, so it's also packed nicely
into cachelines.

Then there's padding to page boundary.  That puts us on a cacheline again
for the used ring; also 2 bytes per entry.

I don't see how any change in layout could be more cache friendly?
Rusty.
