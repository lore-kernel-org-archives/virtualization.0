From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 0/4] make balloon pages movable by compaction
Date: Fri, 29 Jun 2012 14:46:25 -0300
Message-ID: <20120629174624.GC1774__37213.8728308075$1340992003$gmane$org@t510.redhat.com>
References: <cover.1340916058.git.aquini@redhat.com>
	<87r4syzqkn.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87r4syzqkn.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 29, 2012 at 02:01:52PM +0930, Rusty Russell wrote:
> On Thu, 28 Jun 2012 18:49:38 -0300, Rafael Aquini <aquini@redhat.com> wrote:
> > This patchset follows the main idea discussed at 2012 LSFMMS section:
> > "Ballooning for transparent huge pages" -- http://lwn.net/Articles/490114/
> > 
> > to introduce the required changes to the virtio_balloon driver, as well as
> > changes to the core compaction & migration bits, in order to allow
> > memory balloon pages become movable within a guest.
> > 
> > Rafael Aquini (4):
> >   mm: introduce compaction and migration for virtio ballooned pages
> >   virtio_balloon: handle concurrent accesses to virtio_balloon struct
> >     elements
> >   virtio_balloon: introduce migration primitives to balloon pages
> >   mm: add vm event counters for balloon pages compaction
> > 
> >  drivers/virtio/virtio_balloon.c |  142 +++++++++++++++++++++++++++++++++++----
> >  include/linux/mm.h              |   16 +++++
> >  include/linux/virtio_balloon.h  |    6 ++
> >  include/linux/vm_event_item.h   |    2 +
> >  mm/compaction.c                 |  111 ++++++++++++++++++++++++------
> >  mm/migrate.c                    |   32 ++++++++-
> >  mm/vmstat.c                     |    4 ++
> >  7 files changed, 280 insertions(+), 33 deletions(-)
> > 
> > 
> > V2: address Mel Gorman's review comments
> 
> If Mel is happy, I am happy.  Seems sensible that the virtio_baloon
> changes go in at the same time as the mm changes, so:
> 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks Rusty!

I'll be respinning a v3 to address some extra suggestions Mel did, so if you
have any concern that you'd like me to address, do not hesitate on letting me
know! 

Cheers!
Rafael
