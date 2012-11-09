From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v11 3/7] mm: introduce a common interface for balloon
	pages mobility
Date: Fri, 9 Nov 2012 16:23:27 +0000
Message-ID: <20121109162327.GT3886__6204.01759301803$1352478231$gmane$org@csn.ul.ie>
References: <cover.1352256081.git.aquini@redhat.com>
	<4ea10ef1eb1544e12524c8ca7df20cf621395463.1352256087.git.aquini@redhat.com>
	<20121109121133.GP3886@csn.ul.ie>
	<20121109145321.GB4308@optiplex.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121109145321.GB4308@optiplex.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 09, 2012 at 12:53:22PM -0200, Rafael Aquini wrote:
> > <SNIP>
> > If you get the barrier issue sorted out then feel free to add
> > 
> > Acked-by: Mel Gorman <mel@csn.ul.ie>
> > 
> 
> I believe we can drop the barriers stuff, as the locking scheme is now provinding
> enough protection against collisions between isolation page scanning and
> balloon_leak() page release (the major concern that has lead to the barriers
> originally)
> 
> I'll refactor this patch with no barriers and ensure a better commentary on the
> aforementioned locking scheme and resubmit, if it's OK to everyone
> 

Sounds good to me. When they are dropped again feel free to stick my ack
on for the compaction and migration parts. The virtio aspects are up to
someone else :)

-- 
Mel Gorman
SUSE Labs
