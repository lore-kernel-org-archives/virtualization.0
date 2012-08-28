From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v9 3/5] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Tue, 28 Aug 2012 15:05:39 -0300
Message-ID: <20120828180539.GB1750__36728.1528925107$1346177179$gmane$org@t510.redhat.com>
References: <cover.1345869378.git.aquini@redhat.com>
	<a1ceca79d95bc7de2a6b62a2e565b95286dbdf75.1345869378.git.aquini@redhat.com>
	<20120826074244.GC19551@redhat.com>
	<20120827194713.GA6517@t510.redhat.com>
	<20120828155410.GE2903@redhat.com>
	<20120828173713.GA1750@t510.redhat.com>
	<20120828175716.GA4595@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120828175716.GA4595@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 28, 2012 at 08:57:16PM +0300, Michael S. Tsirkin wrote:
> Sorry I do not understand what you are saying here. So find
> a different locking strategy.
> 
> For example something like:
> 
>          wait_event(vb->config_change,
> 		({ 
> 		   lock
> 		   if (target <= (num_pages - isolated_pages))
> 			   leak balloon
> 		   cond = target <= (num_pages - isolated_pages));
> 		   unlock;
> 		   cond;
> 		})
> 		)
> 
> seems to have no issues?

Ok, I see what you mean. I'll change it.
