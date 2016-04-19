From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 11/16] zsmalloc: separate free_zspage from
	putback_zspage
Date: Tue, 19 Apr 2016 16:53:34 +0900
Message-ID: <20160419075334.GA537@swordfish>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-12-git-send-email-minchan@kernel.org>
	<20160418010408.GB5882@swordfish> <20160419075118.GD18448@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160419075118.GD18448@bbox>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, aquini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello Minchan,

On (04/19/16 16:51), Minchan Kim wrote:
[..]
> 
> I guess it is remained thing after I rebased to catch any mistake.
> But I'm heavily chainging this part.
> Please review next version instead of this after a few days. :)

ah, got it. thanks!

	-ss
