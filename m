From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Fri, 24 Aug 2012 11:03:27 +0300
Message-ID: <20120824080327.GA7830__37251.8435739495$1345795381$gmane$org@redhat.com>
References: <20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823162504.GA1522@redhat.com>
	<20120823172844.GC10777@t510.redhat.com>
	<20120823233616.GB2775@redhat.com> <5036F111.4040607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5036F111.4040607@redhat.com>
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
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 23, 2012 at 11:12:17PM -0400, Rik van Riel wrote:
> On 08/23/2012 07:36 PM, Michael S. Tsirkin wrote:
> 
> >--->
> >
> >virtio-balloon: replace page->lru list with page->private.
> >
> >The point is to free up page->lru for use by compaction.
> >Warning: completely untested, will provide tested version
> >if we agree on this direction.
> 
> A singly linked list is not going to work for page migration,
> which needs to get pages that might be in the middle of the
> balloon list.

For virtballoon_migratepage? Hmm I think you are right. I'll
need to think it over but if we can think of no other way
to avoid ther need to handle isolation in virtio,
we'll just have to use the original plan and add
balloon core to mm.

> -- 
> All rights reversed
