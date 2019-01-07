From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/3] virtio_balloon: remove the unnecessary
	0-initialization
Date: Mon, 7 Jan 2019 15:07:38 +0100
Message-ID: <20190107150738.03bdcf27.cohuck__46815.0689652704$1546869943$gmane$org@redhat.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
	<1546844466-38079-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546844466-38079-4-git-send-email-wei.w.wang@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon,  7 Jan 2019 15:01:06 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> We've changed to kzalloc the vb struct, so no need to 0-initialize
> this field one more time.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e33dc8e..f19061b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
> -		vb->num_free_page_blocks = 0;
>  		spin_lock_init(&vb->free_page_list_lock);
>  		INIT_LIST_HEAD(&vb->free_page_list);
>  		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
