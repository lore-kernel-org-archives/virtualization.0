From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
Date: Fri, 01 Sep 2006 08:04:06 -0700
Message-ID: <1157123046.28577.75.camel@localhost.localdomain>
References: <20060901111006.GE15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751348AbWIAPEV@vger.kernel.org>
In-Reply-To: <20060901111006.GE15684@skybase>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 13:10 +0200, Martin Schwidefsky wrote:
> +#if defined(CONFIG_PAGE_STATES)
> +
> +struct page * find_get_page_nodiscard(struct address_space *mapping,
> +				      unsigned long offset)
> +{
> +	struct page *page;
> +
> +	read_lock_irq(&mapping->tree_lock);
> +	page = radix_tree_lookup(&mapping->page_tree, offset);
> +	if (page)
> +		page_cache_get(page);
> +	read_unlock_irq(&mapping->tree_lock);
> +	return page;
> +}
> +
> +EXPORT_SYMBOL(find_get_page_nodiscard);
> +
> +#endif

Is it worth having another full copy of find_get_page()?  What about a
"nodiscard" argument?

-- Dave
