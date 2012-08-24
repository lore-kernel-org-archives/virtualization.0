From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon pages
	mobility
Date: Thu, 23 Aug 2012 23:12:17 -0400
Message-ID: <5036F111.4040607__32732.8212246814$1345777969$gmane$org@redhat.com>
References: <20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823162504.GA1522@redhat.com>
	<20120823172844.GC10777@t510.redhat.com>
	<20120823233616.GB2775@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120823233616.GB2775@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/23/2012 07:36 PM, Michael S. Tsirkin wrote:

> --->
>
> virtio-balloon: replace page->lru list with page->private.
>
> The point is to free up page->lru for use by compaction.
> Warning: completely untested, will provide tested version
> if we agree on this direction.

A singly linked list is not going to work for page migration,
which needs to get pages that might be in the middle of the
balloon list.

-- 
All rights reversed
