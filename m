From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Thu, 23 Aug 2012 10:06:07 -0300
Message-ID: <20120823130606.GB3746__43931.5108619214$1345727204$gmane$org@t510.redhat.com>
References: <20120821192357.GD12294@t510.redhat.com>
	<20120821193031.GC9027@redhat.com>
	<20120821204556.GF12294@t510.redhat.com>
	<20120822000741.GI9027@redhat.com>
	<20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120823123432.GA25659@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 23, 2012 at 03:34:32PM +0300, Michael S. Tsirkin wrote:
> > So, nothing has changed here.
> 
> Yes, your patch does change things:
> leak_balloon now might return without freeing any pages.
> In that case we will not be making any progress, and just
> spin, pinning CPU.

That's a transitory condition, that migh happen if leak_balloon() takes place
when compaction, or migration are under their way and it might only affects the
module unload case. Also it won't pin CPU because it keeps releasing the locks
it grabs, as it loops. So, we are locubrating about rarities, IMHO. 

> 
> >  
> > > > Just as before, same thing here. If you leaked less than required, balloon()
> > > > will keep calling leak_balloon() until the balloon target is reached. This
> > > > scheme was working before, and it will keep working after this patch.
> > > >
> > > 
> > > IIUC we never hit this path before.
> > >  
> > So, how does balloon() works then?
> > 
> 
> It gets a request to leak a given number of pages
> and executes it, then tells host that it is done.
> It never needs to spin busy-waiting on a CPU for this.
>

So, what this patch changes for the ordinary leak_balloon() case?

 
> Well busy wait pinning CPU is ugly.  Instead we should block thread and
> wake it up when done.  I don't mind how we fix it specifically.
>

I already told you that we do not do that by any mean introduced by this patch.
You're just being stubborn here. If those bits are broken, they were already
broken before I did come up with this proposal.
