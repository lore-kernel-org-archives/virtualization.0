Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B43D5660
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159238; cv=none; b=OfhJTF975tjLD1HWkLeCmp9EBlPPt/5cy4J5yNO8b6WfNO2BmWmcPcgYfhYW6RQlsd/4EdK2+iMsn7JCFz9vSNv+glOOS4T5FmfBj8lmGVmctWxAzODtI4UT+BgFKTsbigjz3Z1J5BEZ8DPLXIsaRRq3t3r+O1CMMGe2YLIuOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159238; c=relaxed/simple;
	bh=tUkUtuM0iwoF48V+kmmrFj6UrIUbiOL6OKuDY0nxzMo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U3JdS+mkqff6lQnhJdEEgtoIkjuj7uX8uPumswRCV21HNcNvV1JYR+ltJec6UDtpizypKyNiJHKoeFLXwwHPXKPZ2R8gIgwCvqLsLjqkTeiE9YdnjGxUn7L3f3CtYoxAfE5Xo1egS3tmgrsudK+sh30xReu48E3NuvtWNuddkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CzeVxOzP; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CzeVxOzP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784159233; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=E+jTxuYizLncjKPUOfIu+VDSpBfHEPHpoWjqdQZRSN4=;
	b=CzeVxOzPS0VoYGunQhsAbuFIZpJna9mYQfZFklKAvRXgoU3okypUwCE+/P5c2GEevHVjPcSQ9JI/y3BDg+azglytsK0oh3jAAH3jz8JL+8X5eOJGSXnSEinrNFfnL5I+2Q0JqlOEH6uw7yUxE2ARiTt0tKXGKMfWb6wae7vZ2zM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7AYwoo_1784159232;
Received: from 30.134.110.188(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X7AYwoo_1784159232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jul 2026 07:47:12 +0800
Message-ID: <1741f70f-b023-40d1-a4ce-dbc567b18372@linux.alibaba.com>
Date: Thu, 16 Jul 2026 07:47:12 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-pmem: allocate flush bio from a driver-private
 bio_set
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Baokun Li <libaokun@linux.alibaba.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
In-Reply-To: <20260709124455.1547912-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gentle ping...

On 7/9/26 8:44 PM, Joseph Qi wrote:
> async_pmem_flush() allocates a child bio for the flush with GFP_ATOMIC.
> This runs from pmem_submit_bio(), a ->submit_bio callback that executes
> in a sleepable context, so there is no atomicity requirement here.
> 
> bio_alloc() only guarantees success when __GFP_DIRECT_RECLAIM is set,
> because that is what lets it fall back to the mempool reserve. With
> GFP_ATOMIC the reclaim bit is absent, so the allocation can fail and
> return -ENOMEM whenever the fast paths (percpu cache and slab) are
> exhausted, which is common right after boot. A flush is issued from
> filesystem writeback and must not fail on a transient allocation
> shortage, otherwise the device can appear unmountable:
> 
>   Buffer I/O error on dev pmem0, logical block 0, lost sync page write
> 
> Switch to GFP_NOIO so __GFP_DIRECT_RECLAIM is set and the allocation can
> make forward progress. However, bio_alloc() draws from the shared
> fs_bio_set, and the incoming bio being flushed may itself have come from
> fs_bio_set; allocating a second bio from the same set while submitting
> underneath ->submit_bio can deadlock the mempool. Add a driver-private
> bio_set for the flush and allocate from it via bio_alloc_bioset(), so
> the flush bio has an independent reserve.
> 
> With a dedicated mempool-backed bio_set and GFP_NOIO the allocation
> cannot fail, so drop the now-redundant NULL check.
> 
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  drivers/nvdimm/nd_virtio.c   | 11 ++++++-----
>  drivers/nvdimm/virtio_pmem.c | 11 ++++++++++-
>  drivers/nvdimm/virtio_pmem.h |  4 ++++
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 4176046627beb..b4bd21edf5c1c 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -110,17 +110,18 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> +	struct virtio_device *vdev = nd_region->provider_data;
> +	struct virtio_pmem *vpmem = vdev->priv;
> +
>  	/*
>  	 * Create child bio for asynchronous flush and chain with
>  	 * parent bio. Otherwise directly call nd_region flush.
>  	 */
>  	if (bio && bio->bi_iter.bi_sector != -1) {
> -		struct bio *child = bio_alloc(bio->bi_bdev, 0,
> -					      REQ_OP_WRITE | REQ_PREFLUSH,
> -					      GFP_ATOMIC);
> +		struct bio *child = bio_alloc_bioset(bio->bi_bdev, 0,
> +					REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO,
> +					&vpmem->flush_bio_set);
>  
> -		if (!child)
> -			return -ENOMEM;
>  		bio_clone_blkg_association(child, bio);
>  		child->bi_iter.bi_sector = -1;
>  		bio_chain(child, bio);
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 77b1966619059..136179506b478 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -65,12 +65,17 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  	}
>  
>  	mutex_init(&vpmem->flush_lock);
> +	err = bioset_init(&vpmem->flush_bio_set, BIO_POOL_SIZE, 0, 0);
> +	if (err) {
> +		dev_err(&vdev->dev, "failed to initialize flush bio_set\n");
> +		goto out_err;
> +	}
>  	vpmem->vdev = vdev;
>  	vdev->priv = vpmem;
>  	err = init_vq(vpmem);
>  	if (err) {
>  		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> -		goto out_err;
> +		goto out_bioset;
>  	}
>  
>  	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
> @@ -131,6 +136,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  	nvdimm_bus_unregister(vpmem->nvdimm_bus);
>  out_vq:
>  	vdev->config->del_vqs(vdev);
> +out_bioset:
> +	bioset_exit(&vpmem->flush_bio_set);
>  out_err:
>  	return err;
>  }
> @@ -138,10 +145,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  static void virtio_pmem_remove(struct virtio_device *vdev)
>  {
>  	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> +	struct virtio_pmem *vpmem = vdev->priv;
>  
>  	nvdimm_bus_unregister(nvdimm_bus);
>  	vdev->config->del_vqs(vdev);
>  	virtio_reset_device(vdev);
> +	bioset_exit(&vpmem->flush_bio_set);
>  }
>  
>  static int virtio_pmem_freeze(struct virtio_device *vdev)
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index f72cf17f9518f..4ff2076f75047 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -15,6 +15,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/bio.h>
>  
>  struct virtio_pmem_request {
>  	struct virtio_pmem_req req;
> @@ -39,6 +40,9 @@ struct virtio_pmem {
>  	/* Serialize flush requests to the device. */
>  	struct mutex flush_lock;
>  
> +	/* bio_set for allocating flush child bios */
> +	struct bio_set flush_bio_set;
> +
>  	/* nvdimm bus registers virtio pmem device */
>  	struct nvdimm_bus *nvdimm_bus;
>  	struct nvdimm_bus_descriptor nd_desc;

