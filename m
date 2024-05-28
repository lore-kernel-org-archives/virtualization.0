Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10126EB64
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885609; cv=none; b=psqkUZ4/KizbI6P2U3bxGJuJPIAY+xs+USeW6z1TNaM9WwIsMhhKHq4Lq5SVDc65NVx9MVHfRzkKBFTz5TtTsTnSbysQVwaRkmQ4JjYXXahOjAQ3v3JeidL5XkLxFAGWftpOJaF1DmRZSnYFA9VUQxrX9W/KWiSlh0aZuW9zD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885609; c=relaxed/simple;
	bh=xe6x85zB0Ge/Xji2CNE8IhOMH+/VDGmdoVxE0YUv6fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myCqM6P1d6DP5AcyHIizsqp6febPt5T2ACHlFgMt/0WccuBVwcBv769pdoGNCiPkUsvPiPJAOeXj49h2xvdXVlu0MxN+8Pwl003oPWSAmshoeOGXGuziFkWwKSsia3p/8PngwYuDQqu7mf341ArEhZ704IqOCC/0IttKkuyUcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m7Ftw4yA; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m7Ftw4yA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716885604; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6Jnt0HsIxg4xcioI7WXcaT5Aaecf7OxxMvZ6nGdybF4=;
	b=m7Ftw4yAGEU35NLoyIIIjgAndhzhIGC98RFrDrP/1dsdzreLHWXqZ7vFh5TcWSobIGODEoMU0Q67VXjA+prPyCRrvUdaPg1GOeFcu6SOPnaKWuxrZZ7CuYYBBxFf6HaVnKmcHdafZzfIS4f7TYHfZ6Q6+4ipzIfJggeoTy5Zbgg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7P8Y0u_1716885601;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7P8Y0u_1716885601)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 16:40:03 +0800
Message-ID: <6798df13-4db3-4165-a6f7-d8a7201b7093@linux.alibaba.com>
Date: Tue, 28 May 2024 16:40:01 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-fs: limit number of request queues
To: Peter-Jan Gootzen <pgootzen@nvidia.com>, virtualization@lists.linux.dev,
 vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc: mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.comm,
 gurtovoy@nvidia.com, Yoray Zack <yorayz@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-2-pgootzen@nvidia.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240501153817.540855-2-pgootzen@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter-Jan,

Thanks for the amazing work! Glad to see it is upstreamed.  We are also
planning distribute virtiofs on DPU.

BTW I have some questions when reading the patch, appreciate if you
could give a hint.


On 5/1/24 11:38 PM, Peter-Jan Gootzen wrote:
> Virtio-fs devices might allocate significant resources to virtio queues
> such as CPU cores that busy poll on the queue. The device indicates how
> many request queues it can support and the driver should initialize the
> number of queues that they want to utilize.

I'm okay with truncating the num_request_queues to nr_cpu_ids if the
number of the available queues exceeds nr_cpu_ids, as generally 1:1
mapping between cpus and queues is enough and we can not make use more
queues in this case.

I just don't understand the above commit message as how this relates to
the resource footprint at the device side.  When the the number of the
queues actually used by the driver (e.g. nr_cpu_ids is 6) is less than
the amount (e.g. 8) that is advertised by the driver, will the device
side reclaim the resources allocated for the remaining unused queues?
The driver has no way notifying how many queues it actually utilizes.


> 
> In this patch we limit the number of initialized request queues to the
> number of CPUs, to limit the resource consumption on the device-side
> and to prepare for the upcoming multi-queue patch.
> 
> Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Suggested-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  fs/fuse/virtio_fs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 322af827a232..2745fa484dcb 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -751,6 +751,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> +	/* Truncate nr of request queues to nr_cpu_id */
> +	fs->num_request_queues = min_t(unsigned int, fs->num_request_queues,
> +					nr_cpu_ids);
>  	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
>  	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>  	if (!fs->vqs)

-- 
Thanks,
Jingbo
