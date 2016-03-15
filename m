From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 01/19] mm: use put_page to free page instead of
	putback_lru_page
Date: Tue, 15 Mar 2016 20:06:21 +0100
Message-ID: <56E85D2D.6050808__42044.276421848$1458068806$gmane$org@suse.cz>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
	<1457681423-26664-2-git-send-email-minchan@kernel.org>
	<56E67AE1.60700@suse.cz> <20160315011656.GD19514@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160315011656.GD19514@bbox>
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
Cc: jlayton@poochiereds.net, Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, koct9i@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 15.3.2016 2:16, Minchan Kim wrote:
> On Mon, Mar 14, 2016 at 09:48:33AM +0100, Vlastimil Babka wrote:
>> On 03/11/2016 08:30 AM, Minchan Kim wrote:
>>
>> Yeah, and compaction (perhaps also other migration users) has to
>> drain the lru pvec... Getting rid of this stuff is worth even by
>> itself.
> 
> Good note. Although we cannot remove lru pvec draining completely,
> at least, this patch removes a case which should drain pvec for
> returning freed page to buddy.

And this is in fact the only interesting case, right. The migrated page (at its
new target) doesn't concern compaction that much, that can go to lru pvec just
fine. But we do want the freed buddy pages to merge ASAP. I guess that's the
same for CMA, page isolation...
