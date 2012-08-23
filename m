From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Thu, 23 Aug 2012 13:06:48 -0300
Message-ID: <20120823160647.GA10777__12349.8531095267$1345738057$gmane$org@t510.redhat.com>
References: <20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823152128.GA8975@t510.redhat.com>
	<20120823155401.GA28876@redhat.com> <50365443.1070104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50365443.1070104@redhat.com>
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 23, 2012 at 12:03:15PM -0400, Rik van Riel wrote:
> >
> >Not "longer" - apparently forever unless user resend the leak command.
> >It's wrong - it should
> >1. not tell host if nothing was done
> >2. after migration finished leak and tell host
> 
> Agreed.  If the balloon is told to leak N pages, and could
> not do so because those pages were locked, the balloon driver
> needs to retry (maybe waiting on a page lock?) and not signal
> completion until after the job has been completed.
> 
> Having the balloon driver wait on the page lock should be
> fine, because compaction does not hold the page lock for
> long.

And that is precisely what leak_balloon is doing. When it stumbles across a
locked page it gets rid of that leak round to give a shot for compaction to
finish its task.
