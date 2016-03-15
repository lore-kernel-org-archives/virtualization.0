From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v1 19/19] zram: use __GFP_MOVABLE for memory allocation
Date: Tue, 15 Mar 2016 15:56:33 +0900
Message-ID: <20160315065633.GH1464__33821.6743352406$1458151262$gmane$org@swordfish>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-20-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457681423-26664-20-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On (03/11/16 16:30), Minchan Kim wrote:
[..]
> init
> Node 0, zone      DMA    208    120     51     41     11      0      0      0      0      0      0
> Node 0, zone    DMA32  16380  13777   9184   3805    789     54      3      0      0      0      0
> compaction
> Node 0, zone      DMA    132     82     40     39     16      2      1      0      0      0      0
> Node 0, zone    DMA32   5219   5526   4969   3455   1831    677    139     15      0      0      0
> 
> new:
> 
> init
> Node 0, zone      DMA    379    115     97     19      2      0      0      0      0      0      0
> Node 0, zone    DMA32  18891  16774  10862   3947    637     21      0      0      0      0      0
> compaction  1
> Node 0, zone      DMA    214     66     87     29     10      3      0      0      0      0      0
> Node 0, zone    DMA32   1612   3139   3154   2469   1745    990    384     94      7      0      0
> 
> As you can see, compaction made so many high-order pages. Yay!
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
