From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v11 7/7] mm: add vm event counters for balloon pages
	compaction
Date: Sun, 11 Nov 2012 17:22:07 -0200
Message-ID: <20121111192206.GB4290__22477.855863008$1352661769$gmane$org@x61.redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
	<8dde7996f3e36a5efbe569afe1aadfc84355e79e.1352256088.git.aquini@redhat.com>
	<20121110155538.GC13846@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121110155538.GC13846@redhat.com>
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

On Sat, Nov 10, 2012 at 05:55:38PM +0200, Michael S. Tsirkin wrote:
> >  	mutex_unlock(&vb->balloon_lock);
> > +	balloon_event_count(COMPACTBALLOONMIGRATED);
> >  
> >  	return MIGRATEPAGE_BALLOON_SUCCESS;
> >  }
> 
> Looks like any ballon would need to do this.
> Can this  chunk go into caller instead?
>

Good catch. It's done, already (v12 just hit the wild).

Thanks!
-- Rafael
