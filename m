From: Ryan Harper <ryanh@us.ibm.com>
Subject: Re: [PATCH] virtio_blk: decrement index when blockdevice is removed
Date: Wed, 6 Apr 2011 14:17:25 -0500
Message-ID: <20110406191725.GJ5445__11550.1845757992$1302117495$gmane$org@us.ibm.com>
References: <1099995365.641718.1301903899721.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<1969774563.659835.1301978981017.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: john cooper <john.cooper@redhat.com>, Jens Axboe <jaxboe@fusionio.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

* Takuma Umeya <tumeya@redhat.com> [2011-04-05 00:00]:
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

What about referencing /dev/disk/by-id  and using drive serial numbers?
How much do we care about re-using minor numbers?  IIRC, virtio-blk can
go out to vdxxx; that's a lot of disks or add/removes.

> 
>  static const struct virtio_device_id id_table[] = {
> 
> -- 
> Umeya, Takuma
> Technical Account Manager
> Red Hat GSS APAC
> +81.3.5798.8584 (direct)
> tumeya@redhat.com
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization

-- 
Ryan Harper
Software Engineer; Linux Technology Center
IBM Corp., Austin, Tx
ryanh@us.ibm.com
