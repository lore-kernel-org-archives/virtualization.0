From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: highmem: export kmap_to_page for modules
Date: Mon, 22 Oct 2012 15:08:18 -0700
Message-ID: <20121022150818.0e64da3a.akpm@linux-foundation.org>
References: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Marc.Zyngier@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, ericvh@gmail.com, levinsasha928@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 19 Oct 2012 14:03:31 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Some virtio device drivers (9p) need to translate high virtual addresses
> to physical addresses, which are inserted into the virtqueue for
> processing by userspace.
> 
> This patch exports the kmap_to_page symbol, so that the affected drivers
> can be compiled as modules.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  mm/highmem.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index d517cd1..2a07f97 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -105,6 +105,7 @@ struct page *kmap_to_page(void *vaddr)
>  
>  	return virt_to_page(addr);
>  }
> +EXPORT_SYMBOL(kmap_to_page);
>  

Looks OK to me.  Would generally prefer that an exported-to-modules
symbol have some documentation, but I guess this one is obvious enough.

Rusty, please include this if you grab the rest of the series.
