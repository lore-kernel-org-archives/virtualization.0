From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v12 0/7] make balloon pages movable by compaction
Date: Sun, 11 Nov 2012 17:18:33 -0200
Message-ID: <20121111191832.GA4290__30468.2690337815$1352661544$gmane$org@x61.redhat.com>
References: <cover.1352656285.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1352656285.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Nov 11, 2012 at 05:01:13PM -0200, Rafael Aquini wrote:
> Change log:
> v12:
>  * Address last suggestions on sorting the barriers usage out      (Mel Gorman);
>  * Fix reported build breakages for CONFIG_BALLOON_COMPACTION=n (Andrew Morton);
>  * Enhance commentary on the locking scheme used for balloon page compaction;
>  * Move all the 'balloon vm_event counter' changes to PATCH 07;

Andrew, 

could you drop the earlier review (v11) and pick this submission (v12) instead,
please?


Aside: before submitting I rebased the series on -next-20121109, after reverting
the v11 commits, to make those clean-up hunks from PATCH 01 apply smoothly.

-- Rafael
