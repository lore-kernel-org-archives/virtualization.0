From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: drop unnecessary initialization
Date: Mon, 8 Jun 2020 08:44:30 +0200
Message-ID: <f3535274-296d-62b0-106a-29c52a554815@redhat.com>
References: <20200608054517.708167-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200608054517.708167-1-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, kernel test robot <lkp@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08.06.20 07:45, Michael S. Tsirkin wrote:
> rc is initialized to -ENIVAL but that's never used. Drop it.
> 
> Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149be..2f357142ea5e 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1768,7 +1768,7 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
>  static int virtio_mem_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_mem *vm;
> -	int rc = -EINVAL;
> +	int rc;
>  
>  	BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
>  	BUILD_BUG_ON(sizeof(struct virtio_mem_resp) != 10);
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
