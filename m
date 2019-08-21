From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/balloon_compaction: suppress allocation warnings
Date: Wed, 21 Aug 2019 18:05:54 +0200
Message-ID: <ba01ec8c-19c3-847c-a315-2f70f4b1fe31__8566.56872654042$1566403568$gmane$org@redhat.com>
References: <20190820091646.29642-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190820091646.29642-1-namit@vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 20.08.19 11:16, Nadav Amit wrote:
> There is no reason to print warnings when balloon page allocation fails,
> as they are expected and can be handled gracefully.  Since VMware
> balloon now uses balloon-compaction infrastructure, and suppressed these
> warnings before, it is also beneficial to suppress these warnings to
> keep the same behavior that the balloon had before.

I am not sure if that's a good idea. The allocation warnings are usually
the only trace of "the user/admin did something bad because he/she tried
to inflate the balloon to an unsafe value". Believe me, I processed a
couple of such bugreports related to virtio-balloon and the warning were
very helpful for that.

> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  mm/balloon_compaction.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 798275a51887..26de020aae7b 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -124,7 +124,8 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>  struct page *balloon_page_alloc(void)
>  {
>  	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> -				       __GFP_NOMEMALLOC | __GFP_NORETRY);
> +				       __GFP_NOMEMALLOC | __GFP_NORETRY |
> +				       __GFP_NOWARN);
>  	return page;
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_alloc);
> 


-- 

Thanks,

David / dhildenb
