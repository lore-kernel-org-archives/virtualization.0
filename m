From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 3/5] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Tue, 21 Aug 2012 17:34:20 +0200
Message-ID: <1345563260.26596.0.camel__19477.8402722024$1345566127$gmane$org@twins>
References: <cover.1345519422.git.aquini@redhat.com>
	<c5f02c618c99b0da11240c1b504672de6f70a074.1345519422.git.aquini@redhat.com>
	<20120821144013.GA7784@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120821144013.GA7784@redhat.com>
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

On Tue, 2012-08-21 at 17:40 +0300, Michael S. Tsirkin wrote:
> > +     vb->balloon_status = BALLOON_REMOVAL;
> 
> This needs some kind of barrier.
> 
> >       kthread_stop(vb->thread); 

kthread_stop() implies an smp_wmb() [ because it needs to do a wakeup ].
