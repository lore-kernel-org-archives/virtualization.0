From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v2
Date: Tue, 9 Oct 2012 13:39:37 -0400
Message-ID: <20121009173937.GA28399__5777.12975577942$1349808049$gmane$org@infradead.org>
References: <1349769918-8611-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1349769918-8611-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> +static int vhost_blk_req_submit(struct vhost_blk_req *req, struct file *file)
> +{
> +
> +	struct inode *inode = file->f_mapping->host;
> +	struct block_device *bdev = inode->i_bdev;
> +	int ret;

Please just pass the block_device directly instead of a file struct.

> +
> +	ret = vhost_blk_bio_make(req, bdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	vhost_blk_bio_send(req);
> +
> +	return ret;
> +}

Then again how simple the this function is it probably should just go
away entirely.

> +	set_fs(USER_DS);

What do we actually need the set_fs for here?

> +
> +static inline void vhost_blk_stop(struct vhost_blk *blk, struct file **file)
> +{
> +
> +	*file = vhost_blk_stop_vq(blk, &blk->vq);
> +}

What is the point of this helper?  Also I can't see anyone actually
using the returned struct file.

> +	case VIRTIO_BLK_T_FLUSH:
> +		ret = vfs_fsync(file, 1);
> +		status = ret < 0 ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
> +		if (!vhost_blk_set_status(req, status))
> +			vhost_add_used_and_signal(&blk->dev, vq, head, ret);
> +		break;

Sending a fsync here is actually wrong in two different ways:

 a) it operates at the filesystem level instead of bio level
 b) it's a blocking operation

It should instead send a REQ_FLUSH bio using the same submission scheme
as the read/write requests.
