Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBC135414
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234657; cv=none; b=slpNswAdsvK6V0MCT7lZvp+7msXeHzHsYDH5h5NbLEcWGJ6H+UErEhnLG7qdgzCHlfe/63m00Jluk4hUm5+LStT1LLs0LyqoY4g4p1uzD5DxpGRrG9vMv4uq+xLdrzTQT7ngONpPCz7RNeP6SN0gC9Q7mmR3PdZRByVZLNs1ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234657; c=relaxed/simple;
	bh=dNMIM9gLcsB7xsRSX5sa2T5uiuaOBVl9LF5KClq14WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8IbYE6XWJNujjS0ep4+yCt9DQTN/Sj7PSSBGYZOctLqet1Ypsi78mVm+yoETsndPGxirXvUshoJ+7N0jbQCEhbcIGwMKhsebSWhPLsUZAXcEa2XV0X9PrP697nBXlWbhzuGzvfSybuCNpV7KcXKxFWUCVPQEcc1pQdYyq7EcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uxU+fKuP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uxU+fKuP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso36615745e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719234653; x=1719839453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr5KXC/iq0S56OQVl/Sa+GkBCOHy4HcHpE/nQiq7OGU=;
        b=uxU+fKuPJ2N/keNY5/fMITRk8f7qL8xs9s3uuZFVt1L6jNxpRBhytExMrY0KLPmh4W
         6qhBbGGcs+hH3AJ5ZGkJJU77t/lhOQs7WEtkNKgW9L9Gpb4zqeEofOAIS+XxBSJOj4Ew
         +cWOVd6NfHXzQxRWeAVim1AfivdZCpA5mA7yOODvERdENSNqjkvsglN8oABVSz+veFQ6
         Vk0izW7SWG7K5abtrMcHcQJc/KfmDXTzTyGBpjbuxIi+tkbBOXEN8t7HZ2tKtFNIBo41
         HAuAEiJVoJqEFPuTKEKlTCrbWuj5s0UkWZ5M3UjxRusx5z4dmfHRa9uNxg0xNem8X6qd
         rIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234653; x=1719839453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr5KXC/iq0S56OQVl/Sa+GkBCOHy4HcHpE/nQiq7OGU=;
        b=HHHbJdhMayxD65IwvkoA2zaQcDAYDqJ/gXxUCXMkJKY82TAchVl6EWrUnqnnwYi7oe
         lGpVar7NkXZpgfPa2GzSuLAA8k3VFxGFP3eCsxOlyfA3iF0/qbpV/ENr7ItvsJzfLjXc
         Zu8nummdVqvxbERJMgYLKE8OeeLBYb/E7nYx5WCznQ5YlJQSsrGUZN63bezXRoAanUAp
         xVdVnK2QEBOqgEN9nb8q5CS+IovZcMlDcvEYFLPQwqGCZbdqP/Rr6wZh10YwxhTHYLWO
         H080SM6e5OURc7GATFXawF09rlmBcsYQu/FtxO7lqKEreembRxEwJqFPdq/Ubx4aug9J
         QUog==
X-Gm-Message-State: AOJu0YzsZoXq1/BnUjczemONHRMpKXpxGjSvTtXNZ1H8iUIxOiYVFCVz
	ss8uxK/y0QbgMS7Lt7PflWY5W5kgGwuiliNi0iY2qa0CHQROaC8ybvWgwgNxfPk=
X-Google-Smtp-Source: AGHT+IGQkoWXK94i3JgLivZzKOeCQV+m8bOYlnyUZeLEKmw8P/F+9D6ZJi9qgOwiHALm5aB+lXc7GA==
X-Received: by 2002:a05:600c:4c23:b0:421:7e6b:1b75 with SMTP id 5b1f17b1804b1-4248cc343a7mr32687365e9.17.1719234652722;
        Mon, 24 Jun 2024 06:10:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910fd4sm133288715e9.30.2024.06.24.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:10:52 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:10:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <ZnlwWYzdlc9oPLzq@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
 <20240624073115-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624073115-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:34:47PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 11:04:50AM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently, the code waits in a busy loop on every admin virtqueue issued
>> command to get a reply. That prevents callers from issuing multiple
>> commands in parallel.
>> 
>> To overcome this limitation, introduce a virtqueue event callback for
>> admin virtqueue. For every issued command, use completion mechanism
>> to wait on a reply. In the event callback, trigger the completion
>> is done for every incoming reply.
>> 
>> Alongside with that, introduce a spin lock to protect the admin
>> virtqueue operations.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 10 +++---
>>  drivers/virtio/virtio_pci_common.h |  3 ++
>>  drivers/virtio/virtio_pci_modern.c | 52 +++++++++++++++++++++++-------
>>  include/linux/virtio.h             |  2 ++
>>  4 files changed, 51 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index 07c0511f170a..5ff7304c7a2a 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -346,6 +346,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  		for (i = 0; i < nvqs; ++i)
>>  			if (names[i] && callbacks[i])
>>  				++nvectors;
>> +		if (avq_num)
>> +			++nvectors;
>>  	} else {
>>  		/* Second best: one for change, shared for all vqs. */
>>  		nvectors = 2;
>> @@ -375,8 +377,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  	if (!avq_num)
>>  		return 0;
>>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> -	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name,
>> -				     false, &allocated_vectors);
>> +	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
>> +				     avq->name, false, &allocated_vectors);
>>  	if (IS_ERR(vqs[i])) {
>>  		err = PTR_ERR(vqs[i]);
>>  		goto error_find;
>> @@ -432,8 +434,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>>  	if (!avq_num)
>>  		return 0;
>>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> -	vqs[i] = vp_setup_vq(vdev, queue_idx++, NULL, avq->name,
>> -			     false, VIRTIO_MSI_NO_VECTOR);
>> +	vqs[i] = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done,
>> +			     avq->name, false, VIRTIO_MSI_NO_VECTOR);
>>  	if (IS_ERR(vqs[i])) {
>>  		err = PTR_ERR(vqs[i]);
>>  		goto out_del_vqs;
>> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>> index b3ef76287b43..38a0b6df0844 100644
>> --- a/drivers/virtio/virtio_pci_common.h
>> +++ b/drivers/virtio/virtio_pci_common.h
>> @@ -45,6 +45,8 @@ struct virtio_pci_vq_info {
>>  struct virtio_pci_admin_vq {
>>  	/* serializing admin commands execution. */
>>  	struct mutex cmd_lock;
>> +	/* Protects virtqueue access. */
>> +	spinlock_t lock;
>>  	u64 supported_cmds;
>>  	/* Name of the admin queue: avq.$vq_index. */
>>  	char name[10];
>> @@ -174,6 +176,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>>  #endif
>>  
>> +void vp_modern_avq_done(struct virtqueue *vq);
>>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>>  			     struct virtio_admin_cmd *cmd);
>>  
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index b4041e541fc3..b9937e4b8a69 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>>  	return index == vp_dev->admin_vq.vq_index;
>>  }
>>  
>> +void vp_modern_avq_done(struct virtqueue *vq)
>> +{
>> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>> +	struct virtio_admin_cmd *cmd;
>> +	unsigned long flags;
>> +	unsigned int len;
>> +
>> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> +	do {
>> +		virtqueue_disable_cb(vq);
>> +		while ((cmd = virtqueue_get_buf(vq, &len)))
>> +			complete(&cmd->completion);
>> +	} while (!virtqueue_enable_cb(vq));
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +}
>> +
>>  static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>>  				    struct virtio_pci_admin_vq *admin_vq,
>>  				    u16 opcode,
>> @@ -62,7 +79,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>>  				    struct virtio_admin_cmd *cmd)
>>  {
>>  	struct virtqueue *vq;
>> -	int ret, len;
>> +	unsigned long flags;
>> +	int ret;
>>  
>>  	vq = vp_dev->vqs[admin_vq->vq_index]->vq;
>>  	if (!vq)
>> @@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>>  		return -EOPNOTSUPP;
>>  
>> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return -EIO;
>> -
>> -	if (unlikely(!virtqueue_kick(vq)))
>> -		return -EIO;
>> +	init_completion(&cmd->completion);
>>  
>> -	while (!virtqueue_get_buf(vq, &len) &&
>> -	       !virtqueue_is_broken(vq))
>> -		cpu_relax();
>> +again:
>> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		if (ret == -ENOSPC) {
>> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +			cpu_relax();
>> +			goto again;
>> +		}
>> +		goto unlock_err;
>> +	}
>> +	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
>> +		goto unlock_err;
>
>
>This can actually happen with suprise removal.
>So WARN_ON_ONCE isn't really appropriate I think.

Got it. Will remove this.



>
>
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>>  
>> -	if (virtqueue_is_broken(vq))
>> -		return -EIO;
>> +	wait_for_completion(&cmd->completion);
>>  
>>  	return 0;
>> +
>> +unlock_err:
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +	return -EIO;
>>  }
>>  
>>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> @@ -787,6 +814,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>>  	vp_dev->isr = mdev->isr;
>>  	vp_dev->vdev.id = mdev->id;
>>  
>> +	spin_lock_init(&vp_dev->admin_vq.lock);
>>  	mutex_init(&vp_dev->admin_vq.cmd_lock);
>>  	return 0;
>>  }
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 26c4325aa373..5db8ee175e71 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/gfp.h>
>>  #include <linux/dma-mapping.h>
>> +#include <linux/completion.h>
>>  
>>  /**
>>   * struct virtqueue - a queue to register buffers for sending or receiving.
>> @@ -109,6 +110,7 @@ struct virtio_admin_cmd {
>>  	__le64 group_member_id;
>>  	struct scatterlist *data_sg;
>>  	struct scatterlist *result_sg;
>> +	struct completion completion;
>>  };
>>  
>>  /**
>> -- 
>> 2.45.1
>
