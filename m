From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v10 0/5] make balloon pages movable by compaction
Date: Tue, 18 Sep 2012 10:15:59 +0930
Message-ID: <87boh4qhtk.fsf__49603.3032578$1347968540$gmane$org@rustcorp.com.au>
References: <cover.1347897793.git.aquini@redhat.com>
	<20120917151531.e9ac59f2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Mon, 17 Sep 2012 13:38:15 -0300
> Rafael Aquini <aquini@redhat.com> wrote:
>> Results for STRESS-HIGHALLOC benchmark, from Mel Gorman's mmtests suite,
>> running on a 4gB RAM KVM guest which was ballooning 1gB RAM in 256mB chunks,
>> at every minute (inflating/deflating), while test was running:
>
> How can a patchset reach v10 and have zero Reviewed-by's?

The virtio_balloon changes are fairly trivial compared to the mm parts,
and Michael Tsirkin provided feedback on the last round.

However, the real trick is figuring out what the locking rules are when
the mm core calls in to ask us about a page.  And that requires someone
who really knows the mm stuff.

> The patchset looks reasonable to me and your empirical results look
> good.  But I don't feel that I'm in a position to decide on its overall
> desirability, either in a standalone sense or in comparison to any
> alternative schemes which anyone has proposed.

It's definitely nice to have, though it's far more complicated than I
would have thought.

Cheers,
Rusty.
