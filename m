From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 08:55:09 +0200
Message-ID: <20170731065508.GE13036__42189.5877844237$1501484122$gmane$org@dhcp22.suse.cz>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon 31-07-17 12:13:33, Wei Wang wrote:
> Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
> shouldn't be given to the host ksmd to scan.

Could you point me where this MADV_DONTNEED is done, please?

> Therefore, it is not
> necessary to zero ballooned pages, which is very time consuming when
> the page amount is large. The ongoing fast balloon tests show that the
> time to balloon 7G pages is increased from ~491ms to 2.8 seconds with
> __GFP_ZERO added. So, this patch removes the flag.

Please make it obvious that this is a revert of bb01b64cfab7
("mm/balloon_compaction.c: enqueue zero page to balloon device").

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  mm/balloon_compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 9075aa5..b06d9fe 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -24,7 +24,7 @@ struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info)
>  {
>  	unsigned long flags;
>  	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> -				__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_ZERO);
> +				       __GFP_NOMEMALLOC | __GFP_NORETRY);
>  	if (!page)
>  		return NULL;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
