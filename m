From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 0/5] make balloon pages movable by compaction
Date: Tue, 25 Sep 2012 03:17:25 +0200
Message-ID: <20120925011725.GB22893__9925.46418351612$1348535780$gmane$org@redhat.com>
References: <cover.1347897793.git.aquini@redhat.com>
	<20120917151531.e9ac59f2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120917151531.e9ac59f2.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 17, 2012 at 03:15:31PM -0700, Andrew Morton wrote:
> How can a patchset reach v10 and have zero Reviewed-by's?

I think the problem is, this adds an API between mm and balloon
device that is pretty complex: consider that previously we literally
only used alloc_page, __free_page and page->lru field.

So you end up with a problem: mm bits don't do anything
by themselves so mm people aren't very interested and
don't know about virtio anyway, while
we virtio device driver people lack a clue about compaction.

Having said that I think I'm getting my head about some of the issues so
I commented and the patchset is hopefully getting there.

-- 
MST
