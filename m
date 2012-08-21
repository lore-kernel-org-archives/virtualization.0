From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Tue, 21 Aug 2012 17:16:06 +0200
Message-ID: <1345562166.23018.109.camel__7953.83628360486$1345564645$gmane$org@twins>
References: <cover.1345519422.git.aquini@redhat.com>
	<e24f3073ef539985dea52943dcb84762213a0857.1345519422.git.aquini@redhat.com>
	<20120821135223.GA7117@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120821135223.GA7117@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2012-08-21 at 16:52 +0300, Michael S. Tsirkin wrote:
> > +             rcu_read_lock();
> > +             mapping = rcu_dereference(page->mapping);
> > +             if (mapping_balloon(mapping))
> > +                     ret = true;
> > +             rcu_read_unlock();
> 
> This looks suspicious: you drop rcu_read_unlock
> so can't page switch from balloon to non balloon? 

RCU read lock is a non-exclusive lock, it cannot avoid anything like
that.
