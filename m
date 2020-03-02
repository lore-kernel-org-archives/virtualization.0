From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 01/11] ACPI: NUMA: export pxm_to_node
Date: Mon, 2 Mar 2020 15:03:09 +0100
Message-ID: <20200302140309.GM4380@dhcp22.suse.cz>
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200302134941.315212-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon 02-03-20 14:49:31, David Hildenbrand wrote:
> Will be needed by virtio-mem to identify the node from a pxm.

No objection to export the symbol. But it is almost always better to add
the export in the patch that actually uses it. The intention is much
more clear that way.

> Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com> # for the export

> ---
>  drivers/acpi/numa/srat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 47b4969d9b93..5be5a977da1b 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
>  		return NUMA_NO_NODE;
>  	return pxm_to_node_map[pxm];
>  }
> +EXPORT_SYMBOL(pxm_to_node);
>  
>  int node_to_pxm(int node)
>  {
> -- 
> 2.24.1
> 

-- 
Michal Hocko
SUSE Labs
