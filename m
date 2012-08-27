From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v9 0/5] make balloon pages movable by compaction
Date: Mon, 27 Aug 2012 17:22:32 -0300
Message-ID: <20120827202231.GB6517__15713.0473795862$1346098993$gmane$org@t510.redhat.com>
References: <cover.1345869378.git.aquini@redhat.com>
	<20120826075840.GE19551@redhat.com> <503A3565.2060004@redhat.com>
	<20120826154423.GA15478@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120826154423.GA15478@redhat.com>
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

On Sun, Aug 26, 2012 at 06:44:23PM +0300, Michael S. Tsirkin wrote:
> 
> I am simply asking how was this patchset tested.
> It would be nice to have this info in commit log.
> Since this is an optimization patch it is strange
> to see one with no numbers at all.
> For example, you probably run some workload and
> played with the balloon, and then saw less huge pages
> without the patch and more with?
> Please put this info in the cover letter.

Will do it, for sure. As soon as we get closer to an agreement on how the code
has to behave and looks like. I'll use Mel's mmtests bench suite for that.

Cheers!
