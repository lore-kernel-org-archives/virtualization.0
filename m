From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: Fix build error due to improper use 'select'
Date: Fri, 19 Jun 2020 13:49:10 +0200
Message-ID: <d03c88ea-200d-54ab-d7f3-f3e5b7a0a9dd@redhat.com>
References: <20200619080333.194753-1-chenweilong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200619080333.194753-1-chenweilong@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Weilong Chen <chenweilong@huawei.com>, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, lizefan@huawei.com
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 19.06.20 10:03, Weilong Chen wrote:
> As noted in:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
> "select should be used with care. select will force a symbol to a
> value without visiting the dependencies."

Right, rings a bell.

> Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
> Otherwise it will cause an error:
> https://bugzilla.kernel.org/show_bug.cgi?id=208245

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
>  drivers/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..5c92e4a50882 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -85,7 +85,7 @@ config VIRTIO_MEM
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG_SPARSE
>  	depends on MEMORY_HOTREMOVE
> -	select CONTIG_ALLOC
> +	depends on CONTIG_ALLOC
>  	help
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
> 


-- 
Thanks,

David / dhildenb
