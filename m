From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 00/16] Support non-lru page migration
Date: Thu, 31 Mar 2016 09:57:34 +0900
Message-ID: <20160331005734.GC6736__46452.2059228786$1459385790$gmane$org@bbox>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<20160330161141.4332b189e7a4930e117d765b@linux-foundation.org>
	<20160331002932.GA1758@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160331002932.GA1758@swordfish>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 31, 2016 at 09:29:32AM +0900, Sergey Senozhatsky wrote:
> On (03/30/16 16:11), Andrew Morton wrote:
> [..]
> > > For details, please read description in
> > > "mm/compaction: support non-lru movable page migration".
> > 
> > OK, I grabbed all these.
> > 
> > I wonder about testing coverage during the -next period.  How many
> > people are likely to exercise these code paths in a serious way before
> > it all hits mainline?
> 
> I'm hammering the zsmalloc part.

Thanks, Sergey!
