From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v2
Date: Wed, 10 Oct 2012 10:27:16 +0800
Message-ID: <5074DD04.7000809@redhat.com>
References: <1349769918-8611-1-git-send-email-asias@redhat.com>
	<20121009173937.GA28399@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121009173937.GA28399@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Christoph!

On 10/10/2012 01:39 AM, Christoph Hellwig wrote:
>> +static int vhost_blk_req_submit(struct vhost_blk_req *req, struct file *file)
>> +{
>> +
>> +	struct inode *inode = file->f_mapping->host;
>> +	struct block_device *bdev = inode->i_bdev;
>> +	int ret;
> 
> Please just pass the block_device directly instead of a file struct.

vhost_blk_req_submit() can be used to handle file based image later.
Using the file interface will work for both cases.

I do need a check in vhost_blk_set_backend() to tell if the user passed
file is a raw device file for now.

>> +
>> +	ret = vhost_blk_bio_make(req, bdev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	vhost_blk_bio_send(req);
>> +
>> +	return ret;
>> +}
> 
> Then again how simple the this function is it probably should just go
> away entirely.

No, vhost_blk_req_submit() is used for both read and write ops. It makes
no sense to write the code twice. Plus, this function might be complexer
when the file based image support is added.

>> +	set_fs(USER_DS);
> 
> What do we actually need the set_fs for here?

See this commit: d7ffde35e31a81100d2d0d2c4013cbf527bb32ea

>> +
>> +static inline void vhost_blk_stop(struct vhost_blk *blk, struct file **file)
>> +{
>> +
>> +	*file = vhost_blk_stop_vq(blk, &blk->vq);
>> +}
> 
> What is the point of this helper?  Also I can't see anyone actually
> using the returned struct file.

It is used in both vhost_blk_reset_owner() and vhost_blk_release(). The
returned struct file is used for fput(). We have similar helper in
vhost_net: vhost_net_stop().


>> +	case VIRTIO_BLK_T_FLUSH:
>> +		ret = vfs_fsync(file, 1);
>> +		status = ret < 0 ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
>> +		if (!vhost_blk_set_status(req, status))
>> +			vhost_add_used_and_signal(&blk->dev, vq, head, ret);
>> +		break;
> 
> Sending a fsync here is actually wrong in two different ways:
> 
>  a) it operates at the filesystem level instead of bio level
>  b) it's a blocking operation
> 
> It should instead send a REQ_FLUSH bio using the same submission scheme
> as the read/write requests.

Will fix this.

Thanks for the review!

-- 
Asias
