From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Thu, 23 Aug 2012 13:01:07 +0300
Message-ID: <20120823100107.GA17409__18056.7717216492$1345716044$gmane$org@redhat.com>
References: <20120821162432.GG2456@linux.vnet.ibm.com>
	<20120821172819.GA12294@t510.redhat.com>
	<20120821191330.GA8324@redhat.com>
	<20120821192357.GD12294@t510.redhat.com>
	<20120821193031.GC9027@redhat.com>
	<20120821204556.GF12294@t510.redhat.com>
	<20120822000741.GI9027@redhat.com>
	<20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120823021903.GA23660@x61.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2012 at 11:19:04PM -0300, Rafael Aquini wrote:
> On Wed, Aug 22, 2012 at 12:33:17PM +0300, Michael S. Tsirkin wrote:
> > Hmm, so this will busy wait which is unelegant.
> > We need some event IMO.
> 
> No, it does not busy wait. leak_balloon() is mutual exclusive with migration
> steps, so for the case we have one racing against the other, we really want
> leak_balloon() dropping the mutex temporarily to allow migration complete its
> work of refilling vb->pages list. Also, leak_balloon() calls tell_host(), which
> will potentially make it to schedule for each round of vb->pfns leak_balloon()
> will release.

tell_host might not even cause an exit to host. Even if it does
it does not involve guest scheduler.

> So, when remove_common() calls leak_balloon() looping on
> vb->num_pages, that won't become a tight loop. 
> The scheme was apparently working before this series, and it will remain working
> after it.

It seems that before we would always leak all requested memory
in one go. I can't tell why we have a while loop there at all.
Rusty, could you clarify please?

> 
> > Also, reading num_pages without a lock here
> > which seems wrong.
> 
> I'll protect it with vb->balloon_lock mutex. That will be consistent with the
> lock protection scheme this patch is introducing for struct virtio_balloon
> elements.
> 
> 
> > A similar concern applies to normal leaking
> > of the balloon: here we might leak less than
> > required, then wait for the next config change
> > event.
> 
> Just as before, same thing here. If you leaked less than required, balloon()
> will keep calling leak_balloon() until the balloon target is reached. This
> scheme was working before, and it will keep working after this patch.
>

IIUC we never hit this path before.
 
> > How about we signal config_change
> > event when pages are back to pages_list?
> 
> I really don't know what to tell you here, but, to me, it seems like an
> overcomplication that isn't directly entangled with this patch purposes.
> Besides, you cannot expect compation / migration happening and racing against
> leak_balloon() all the time to make them signal events to the later, so we might
> just be creating a wait-forever condition for leak_balloon(), IMHO.

So use wait_event or similar, check for existance of isolated pages.

> Cheers!
