From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/3] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Wed, 18 Jul 2012 15:49:08 -0700
Message-ID: <20120718154908.14704344.akpm@linux-foundation.org>
References: <cover.1342485774.git.aquini@redhat.com>
	<050e06731e0489867ed804387509e36d072507ec.1342485774.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <050e06731e0489867ed804387509e36d072507ec.1342485774.git.aquini@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 17 Jul 2012 13:50:42 -0300
Rafael Aquini <aquini@redhat.com> wrote:

> Besides making balloon pages movable at allocation time and introducing
> the necessary primitives to perform balloon page migration/compaction,
> this patch also introduces the following locking scheme to provide the
> proper synchronization and protection for struct virtio_balloon elements
> against concurrent accesses due to parallel operations introduced by
> memory compaction / page migration.
>  - balloon_lock (mutex) : synchronizes the access demand to elements of
> 			  struct virtio_balloon and its queue operations;
>  - pages_lock (spinlock): special protection to balloon pages list against
> 			  concurrent list handling operations;
> 
> ...
>
> +	balloon_mapping->a_ops = &virtio_balloon_aops;
> +	balloon_mapping->backing_dev_info = (void *)vb;

hoo boy.  We're making page->mapping->backing_dev_info point at a
struct which does not have type `struct backing_dev_info'.  And then we
are exposing that page to core MM functions.  So we're hoping that core
MM will never walk down page->mapping->backing_dev_info and explode.

That's nasty, hacky and fragile.
