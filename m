From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v5 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Mon, 06 Aug 2012 15:06:49 -0400
Message-ID: <502015C9.2__42693.7724267647$1344280028$gmane$org@redhat.com>
References: <cover.1344259054.git.aquini@redhat.com>
	<212b5297df32cb4e3f60d5b76a8cb0629d328a4e.1344259054.git.aquini@redhat.com>
	<50200F1F.7060605@redhat.com>
	<20120806190053.GA3968@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120806190053.GA3968@t510.redhat.com>
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/06/2012 03:00 PM, Rafael Aquini wrote:
> On Mon, Aug 06, 2012 at 02:38:23PM -0400, Rik van Riel wrote:
>> On 08/06/2012 09:56 AM, Rafael Aquini wrote:
>>
>>> @@ -846,6 +861,21 @@ static int unmap_and_move(new_page_t get_new_page, unsigned long private,
>>>   			goto out;
>>>
>>>   	rc = __unmap_and_move(page, newpage, force, offlining, mode);
>>> +
>>> +	if (unlikely(is_balloon_page(newpage)&&
>>> +		     balloon_compaction_enabled())) {
>>
>> Could that be collapsed into one movable_balloon_page(newpage) function
>> call?
>>
> Keeping is_balloon_page() as is, and itroducing this new movable_balloon_page()
> function call, or just doing a plain rename, as Andrew has first suggested?

Just a plain rename would work.

> +static inline bool is_balloon_page(struct page *page)
> +{
> +	return (page->mapping && page->mapping == balloon_mapping);
> +}

As an aside, since you are only comparing page->mapping and
not dereferencing it, it can be simplified to just:

	return (page->mapping == balloon_mapping);



-- 
All rights reversed
