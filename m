From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v1 09/19] zsmalloc: keep max_object in size_class
Date: Tue, 15 Mar 2016 15:41:26 +0900
Message-ID: <20160315064126.GA2808__33023.9249663011$1458024067$gmane$org@bbox>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-10-git-send-email-minchan@kernel.org>
	<20160315062824.GE1464@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160315062824.GE1464@swordfish>
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
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2016 at 03:28:24PM +0900, Sergey Senozhatsky wrote:
> On (03/11/16 16:30), Minchan Kim wrote:
> > Every zspage in a size_class has same number of max objects so
> > we could move it to a size_class.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/zsmalloc.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index b4fb11831acb..ca663c82c1fc 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -32,8 +32,6 @@
> >   *	page->freelist: points to the first free object in zspage.
> >   *		Free objects are linked together using in-place
> >   *		metadata.
> > - *	page->objects: maximum number of objects we can store in this
> > - *		zspage (class->zspage_order * PAGE_SIZE / class->size)
> >   *	page->lru: links together first pages of various zspages.
> >   *		Basically forming list of zspages in a fullness group.
> >   *	page->mapping: class index and fullness group of the zspage
> > @@ -211,6 +209,7 @@ struct size_class {
> >  	 * of ZS_ALIGN.
> >  	 */
> >  	int size;
> > +	int objs_per_zspage;
> >  	unsigned int index;
> 
> struct page ->objects "comes for free". now we don't use it, instead
> every size_class grows by 4 bytes? is there any reason for this?

It is union with _mapcount and it is used by checking non-lru movable
page in this patchset.
> 
> 	-ss
