From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH] virtio_blk: decrement index when blockdevice is removed
Date: Tue, 05 Apr 2011 07:08:12 +0200
Message-ID: <4D9AA3BC.6030907__28147.4101510414$1302114643$gmane$org@fusionio.com>
References: <1969774563.659835.1301978981017.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1969774563.659835.1301978981017.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Takuma Umeya <tumeya@redhat.com>
Cc: john cooper <john.cooper@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 2011-04-05 06:49, Takuma Umeya wrote:
> When virtio block device is removed, index does not get decremented. When 
> another virtio disk is attached it uses the next device letter to the 
> one that is suppose to be available. 
> 
> Signed-off-by: Takuma Umeya <tumeya@redhat.com>
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6ecf89c..730e7af 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -489,6 +489,7 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>         mempool_destroy(vblk->pool);
>         vdev->config->del_vqs(vdev);
>         kfree(vblk);
> +       index--;
>  }
>  
>  static const struct virtio_device_id id_table[] = {

What happens when you delete a device that isn't the last one?

-- 
Jens Axboe
