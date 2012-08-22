From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Wed, 22 Aug 2012 03:06:51 +0300
Message-ID: <20120822000651.GH9027__165.436967700039$1345593974$gmane$org@redhat.com>
References: <cover.1345519422.git.aquini@redhat.com>
	<e24f3073ef539985dea52943dcb84762213a0857.1345519422.git.aquini@redhat.com>
	<20120821135223.GA7117@redhat.com>
	<20120821175502.GC12294@t510.redhat.com>
	<20120821191612.GA9027@redhat.com>
	<20120821193438.GE12294@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120821193438.GE12294@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2012 at 04:34:39PM -0300, Rafael Aquini wrote:
> On Tue, Aug 21, 2012 at 10:16:12PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Aug 21, 2012 at 02:55:03PM -0300, Rafael Aquini wrote:
> > > On Tue, Aug 21, 2012 at 04:52:23PM +0300, Michael S. Tsirkin wrote:
> > > > > + * address_space_operations utilized methods for ballooned pages:
> > > > > + *   .migratepage    - used to perform balloon's page migration (as is)
> > > > > + *   .launder_page   - used to isolate a page from balloon's page list
> > > > > + *   .freepage       - used to reinsert an isolated page to balloon's page list
> > > > > + */
> > > > 
> > > > It would be a good idea to document the assumptions here.
> > > > Looks like .launder_page and .freepage are called in rcu critical
> > > > section.
> > > > But migratepage isn't - why is that safe?
> > > > 
> > > 
> > > The migratepage callback for virtio_balloon can sleep, and IIUC we cannot sleep
> > > within a RCU critical section. 
> > > 
> > > Also, The migratepage callback is called at inner migration's circle function
> > > move_to_new_page(), and I don't think embedding it in a RCU critical section
> > > would be a good idea, for the same understanding aforementioned.
> > 
> > Yes but this means it is still exposed to the module unloading
> > races that RCU was supposed to fix.
> > So need to either rework that code so it won't sleep
> > or switch to some other synchronization.
> >
> Can you refactor tell_host() to not sleep? Or, can I get rid of calling it at
> virtballoon_migratepage()? If 'no' is the answer for both questions, that's the
> way that code has to remain, even if we find a way around to hack the
> migratepage callback and have it embedded into a RCU crit section.
> 
> That's why I believe once the balloon driver is commanded to unload, we must
> flag virtballoon_migratepage to skip it's work. By doing this, the thread
> performing memory compaction will have to recur to the 'putback' path which is
> RCU protected. (IMHO).
> 
> As the module will not uload utill it leaks all pages on its list, that unload
> race you pointed before will be covered.


It can not be: nothing callback does can prevent it from
running after module unload: you must have some synchronization
in the calling code.

-- 
MST
