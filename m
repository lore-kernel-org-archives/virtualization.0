Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE583CD4
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616621; cv=none; b=YEviXFGfvWr4V/5iEZDO0D0qTYDE1YLUPaRLjqplNzVLF7sO8XfX86/AssyRrILUp4VbrdDGyQwzmYX5LYI9zCPqIv3zkfRDxEY73MIPUizZHq8uK41nSOdOpy3nnGwOiS2YDeUgA40rmAbxTM+JJrynOlPKbqD0eOQjZflQDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616621; c=relaxed/simple;
	bh=zHA2edNBKD5TyQ7XQpng+rmKmGP55X9ikEUmjW6FASg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ojn40MN9kvH3ytvOWwGdxKk2QWRGlkBdvhlh769LCdV3Pm9h2v1k0uHBHy27O1ouw/87ICtc3gU51oUBQjdXgBR+N0FR3uciMBXE6SoR7pp4ddR7HFkoaUKNivfBGoqYrpprW8entgoAqLJCqDQ923NsYjjddWszwf8Ig0hEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jyxGLoJh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jyxGLoJh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42795086628so3734215e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720616616; x=1721221416; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mszwoJHAWEOb1Rdvi04TadZZz0iDSmITaqkQeQgzDY=;
        b=jyxGLoJhsBHoJde13A/VJ4J8fN7DTEQXZXzYwrybtzLfS7FdtOrUixrq1TGnCjd2j3
         Sc6jWhqVlO4FzOamQBbE9lAYEE/fEvKgvKiY/uZojb8dxSfOtMK/V1q1z8ucv6Z07IXd
         ZiOKgLBHSFUxVAHcU4LAhreDxBhuIfnjNb5FBiQWOmfjxt8Ce2I//GC/+q+pk9dLzNAY
         mP30wmBvwTGyR8FbXUHe9N3OoH7JVD/sNsz7/I9wPiyok409S8r16ZaCSh/B342WXyHm
         Tbw55pKoMStrQOEhXwrFkZ//hcb5OvL6CJmTQBjoviOaBLfV1P9Ki5XytRZHJ4Vlb+l3
         L3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720616616; x=1721221416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mszwoJHAWEOb1Rdvi04TadZZz0iDSmITaqkQeQgzDY=;
        b=NAZRyY4ddSxIucyiGshSZP1L9XgWTuxR44Ub57IE+OxG+pqvpyCqQLjLJLs+Np46h4
         EXhWo709fq58+/RojyIvBXZrSYkGvAfoIHHuYmF8mEYqRJc1Mt/jP3wQur9/UuE5tAWw
         csIw7obHfAsfOg6KiickzlN5xzrBtQWcbBXs2r2Snxmk4QTcoBCtZeDXMU8CnkU8mVZ7
         YWie8qiAL9ycMUR/7kLmSFGkiZ4IYs2MZHUkDswk0uB3qZ8Mj5zMaYwxcXf0m5CrisY1
         7nBePRoDgaW7lVvjDSyqr8anwKxw1JvfzgQzjo/K81oKbIDQOmDCgvX/LVqiUy2skoLq
         TZSg==
X-Gm-Message-State: AOJu0Yzay3xZS0/u+rI9f6fTkTDvzfZj/TtzY6FIIwggleNM2bPExZ5U
	gLfdy1Eu49VxcQQqOzs1IkA9cbwn1PZ+s2hrYaaovMvgyHwJl9WPUrCoB8DjiAM=
X-Google-Smtp-Source: AGHT+IEa01Jv+CWjaU2SEf/OjZDLzmUksADifQDAJWPg+SzSqthXhfDtycyxopcA7OdNu+3LgKVYNg==
X-Received: by 2002:a05:600c:a:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-426707cc06emr35605815e9.7.1720616615493;
        Wed, 10 Jul 2024 06:03:35 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f1ff9sm82256995e9.18.2024.07.10.06.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:03:34 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:03:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v2 12/13] virtio_pci_modern: use completion
 instead of busy loop to wait on admin cmd result
Message-ID: <Zo6GpTOCJ-MJdU8P@nanopsycho.orion>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-13-jiri@resnulli.us>
 <20240710073925-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710073925-mutt-send-email-mst@kernel.org>

Wed, Jul 10, 2024 at 01:47:22PM CEST, mst@redhat.com wrote:
>On Wed, Jul 10, 2024 at 08:36:00AM +0200, Jiri Pirko wrote:
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
>> v1->v2:
>> - rebased on top of newly added patches
>> - rebased on top of changes in previous patches (vq info, vqs[])
>> - removed WARN_ON_ONCE() when calling virtqueue_kick()
>> - added virtqueue_is_broken check in virtqueue_exec_admin_cmd() loop
>> - added vp_modern_avq_cleanup() implementation to handle surprise
>>   removal case
>> ---
>>  drivers/virtio/virtio_pci_common.c | 13 ++++--
>>  drivers/virtio/virtio_pci_common.h |  3 ++
>>  drivers/virtio/virtio_pci_modern.c | 74 +++++++++++++++++++++++++-----
>>  include/linux/virtio.h             |  3 ++
>>  4 files changed, 77 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index 267643bb1cd5..c44d8ba00c02 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -395,6 +395,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  			if (vqi->name && vqi->callback)
>>  				++nvectors;
>>  		}
>> +		if (avq_num && vector_policy == VP_VQ_VECTOR_POLICY_EACH)
>> +			++nvectors;
>>  	} else {
>>  		/* Second best: one for change, shared for all vqs. */
>>  		nvectors = 2;
>> @@ -425,9 +427,9 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>>  	if (!avq_num)
>>  		return 0;
>>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> -	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
>> -				 true, &allocated_vectors, vector_policy,
>> -				 &vp_dev->admin_vq.info);
>> +	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
>> +				 avq->name, false, true, &allocated_vectors,
>> +				 vector_policy, &vp_dev->admin_vq.info);
>>  	if (IS_ERR(vq)) {
>>  		err = PTR_ERR(vq);
>>  		goto error_find;
>> @@ -486,8 +488,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>>  	if (!avq_num)
>>  		return 0;
>>  	sprintf(avq->name, "avq.%u", avq->vq_index);
>> -	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
>> -			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
>> +	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
>> +			 false, VIRTIO_MSI_NO_VECTOR,
>> +			 &vp_dev->admin_vq.info);
>>  	if (IS_ERR(vq)) {
>>  		err = PTR_ERR(vq);
>>  		goto out_del_vqs;
>> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>> index de59bb06ec3c..90df381fbbcf 100644
>> --- a/drivers/virtio/virtio_pci_common.h
>> +++ b/drivers/virtio/virtio_pci_common.h
>> @@ -47,6 +47,8 @@ struct virtio_pci_admin_vq {
>>  	struct virtio_pci_vq_info *info;
>>  	/* serializing admin commands execution. */
>>  	struct mutex cmd_lock;
>> +	/* Protects virtqueue access. */
>> +	spinlock_t lock;
>>  	u64 supported_cmds;
>>  	/* Name of the admin queue: avq.$vq_index. */
>>  	char name[10];
>> @@ -178,6 +180,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>>  #define VIRTIO_ADMIN_CMD_BITMAP 0
>>  #endif
>>  
>> +void vp_modern_avq_done(struct virtqueue *vq);
>>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>>  			     struct virtio_admin_cmd *cmd);
>>  
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index 0fd344d1eaf9..608df3263df1 100644
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
>>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>>  				    u16 opcode,
>>  				    struct scatterlist **sgs,
>> @@ -61,7 +78,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>>  				    struct virtio_admin_cmd *cmd)
>>  {
>>  	struct virtqueue *vq;
>> -	int ret, len;
>> +	unsigned long flags;
>> +	int ret;
>>  
>>  	vq = admin_vq->info->vq;
>>  	if (!vq)
>> @@ -72,21 +90,33 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>>  		return -EOPNOTSUPP;
>>  
>> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return -EIO;
>> +	init_completion(&cmd->completion);
>>  
>> -	if (unlikely(!virtqueue_kick(vq)))
>> +again:
>> +	if (virtqueue_is_broken(vq))
>>  		return -EIO;
>>  
>> -	while (!virtqueue_get_buf(vq, &len) &&
>> -	       !virtqueue_is_broken(vq))
>> -		cpu_relax();
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
>> +	if (!virtqueue_kick(vq))
>> +		goto unlock_err;
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>>  
>> -	if (virtqueue_is_broken(vq))
>> -		return -EIO;
>> +	wait_for_completion(&cmd->completion);
>>  
>> -	return 0;
>> +	return cmd->ret;
>> +
>> +unlock_err:
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +	return -EIO;
>>  }
>>  
>>  int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>> @@ -209,6 +239,25 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
>>  	virtio_pci_admin_cmd_list_init(vdev);
>>  }
>>  
>> +static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>> +{
>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +	struct virtio_admin_cmd *cmd;
>> +	struct virtqueue *vq;
>> +
>> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>> +		return;
>> +
>> +	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
>> +	if (!vq)
>> +		return;
>> +
>> +	while ((cmd = virtqueue_detach_unused_buf(vq))) {
>> +		cmd->ret = -EIO;
>> +		complete(&cmd->completion);
>> +	}
>> +}
>> +
>
>
>I think surprise removal is still broken with this.

Why do you think so? I will drain the remaining buffers from the queue
and complete them all. What's missing?


>You need to add a callback and signal the completion.

Callback to what?




>
>-- 
>MST
>
