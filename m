From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v7 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Mon, 13 Aug 2012 08:14:20 +0900
Message-ID: <20120812231420.GH21033__40133.7658557624$1344813158$gmane$org@bbox>
References: <cover.1344619987.git.aquini@redhat.com>
	<292b1b52e863a05b299f94bda69a61371011ac19.1344619987.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <292b1b52e863a05b299f94bda69a61371011ac19.1344619987.git.aquini@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 10, 2012 at 02:55:14PM -0300, Rafael Aquini wrote:
> Memory fragmentation introduced by ballooning might reduce significantly
> the number of 2MB contiguous memory blocks that can be used within a guest,
> thus imposing performance penalties associated with the reduced number of
> transparent huge pages that could be used by the guest workload.
> 
> This patch introduces the helper functions as well as the necessary changes
> to teach compaction and migration bits how to cope with pages which are
> part of a guest memory balloon, in order to make them movable by memory
> compaction procedures.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Minchan Kim <minchan@kernel.org>

-- 
Kind regards,
Minchan Kim
