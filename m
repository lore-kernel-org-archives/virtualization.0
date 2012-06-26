From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 26 Jun 2012 14:20:55 +0100
Message-ID: <20120626132055.GI8103__28287.0045434267$1340716869$gmane$org@csn.ul.ie>
References: <cover.1340665087.git.aquini@redhat.com>
	<7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
	<4FE9B677.8040409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FE9B677.8040409@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2012 at 09:17:43AM -0400, Rik van Riel wrote:
> On 06/25/2012 07:25 PM, Rafael Aquini wrote:
> >This patch introduces helper functions that teach compaction and migration bits
> >how to cope with pages which are part of a guest memory balloon, in order to
> >make them movable by memory compaction procedures.
> >
> >Signed-off-by: Rafael Aquini<aquini@redhat.com>
> 
> The function fill_balloon in drivers/virtio/virtio_balloon.c
> should probably add __GFP_MOVABLE to the gfp mask for alloc_pages,
> to keep the pageblock where balloon pages are allocated marked
> as movable.
> 

You're right, but patch 3 is already doing that at the same time the
migration primitives are introduced. It does mean the full series has to
be applied to do anything but I think it's bisect safe.

-- 
Mel Gorman
SUSE Labs
