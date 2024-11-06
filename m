Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367BC20CCF6
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929263; cv=none; b=u+Cyu+k7o1A+ZA+gan5YICBAI19MsuICmykyAs4UjSWrqxblXo7pvnUTeO2tvYf23U4A90OClZl0c2DGyuj+4JgyKs4RK9bw+4mngkvB35Hf0pxGnesL1fH3hCgxl175cQHDxE2z2XowpZk8vkCxcDLS5Mn5YtEQ4ApAVMeeFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929263; c=relaxed/simple;
	bh=9Y+RRzsvAYCa/G23SNNKkBP82ujzZCoCFSvTIEULxsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxTpi6F4txYdgnPv03eZfkC8Y262hAzC11uwHOodau5alkPy4es0GQqwVpaYGS7xS7niUfCx+QhrqLcvnozvr7kKtRCIlevdqzX0k29JgdP8afloM7TdkBhL/gy6rbKpL1dRfjnu2+cpRlptYiHz4fJcoLRvCJEUmxYRPlUDOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=df3HFfEv; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="df3HFfEv"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E03D080C07
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44jP-sHgQLd5 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 21:41:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0BC0380C16
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BC0380C16
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=df3HFfEv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BC0380C16
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730929257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkAv1xv3L+lLwsH5N6TnynV2mpC7hr2h9WvHLXOozvM=;
	b=df3HFfEvRirEm4HXBlo3qwtxbV9FjpzM8PrR4qAO4yyGeJkeXbb3WOn6AMq8JCjbpgPGZ/
	62mSGG+wsWYfbiZ2T8whtUiDe0mnx1ZDvKbziONCymxsr3ujk6w0Ln/mtehwZpBmC6oSw/
	8XnGU/n60nYt95bQnXEp2HHUO99u4qc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-4Sh2_hSDNm--X06TeHWvgA-1; Wed, 06 Nov 2024 16:40:55 -0500
X-MC-Unique: 4Sh2_hSDNm--X06TeHWvgA-1
X-Mimecast-MFC-AGG-ID: 4Sh2_hSDNm--X06TeHWvgA
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6e4f039cfso497015ab.3
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Nov 2024 13:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929255; x=1731534055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkAv1xv3L+lLwsH5N6TnynV2mpC7hr2h9WvHLXOozvM=;
        b=bQTchmbKXl/9bmdNOZN9LgEK3UWFUXeOHfK12RHOHN7s/u/NceSxdz4o0gcZmsAI/H
         E8MbwjEZe1ic2Wx7IjbDIW9GVQXtSIuBDqy4GDGOZ+miXIEBUozsw5Ys8EGKGFUDmpfr
         Y735+arswzv9+KqozBiK5m9mYjk05bWax5OOIAYc8WaPBfUXRGJsVn4ZPt/0tTGwq3gj
         1QjMmxCOJpnYTfZViLkPIu7UbMngnbEcEoGaNsBwMQ7U3m3AzPOfv1h6argEIszSYY9b
         VUc3U+0KupTERgpb8xHFMlDj0edtv0GDZzDqswV4vXY53ZlyB+WFMeXjD5HEkebnGNK/
         SyAg==
X-Forwarded-Encrypted: i=1; AJvYcCW31jkK4PJJ2udY3/ixDGrt/npb7D9yFjLGy/6spkXvXOFQBY9LLsyX57KixPgEFm3OwBrvEAgqHsyWWD+3KA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz81rrpcfh1Bz+5nXRv1zlgxHTk+vbkNSqIy0L55kfhXytmLPc5
	lyxJWg+DToJakvC1EU7svznHl/IfVD13bikR47QNzpKWJ8+EOutV9PObXTTbj0B6wm/Sux1uKhw
	8dUgfsGOGr1F5I1Hb/cbGHntIH1J5utowZq3CZcDkCzbucsy0cYrUnBtZAcGBrvQL9a/YRErTo+
	Ittkc=
X-Received: by 2002:a05:6602:6423:b0:83a:abd1:6af2 with SMTP id ca18e2360f4ac-83df2442e08mr31342639f.3.1730929255173;
        Wed, 06 Nov 2024 13:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmaJCa6K1T+N21UQP7q5cHuDh9w/YU3TsQUPNVu6zTjgnwEmuBfGqqe4PZwEt0qklkr+LM9A==
X-Received: by 2002:a05:6602:6423:b0:83a:abd1:6af2 with SMTP id ca18e2360f4ac-83df2442e08mr31341339f.3.1730929254742;
        Wed, 06 Nov 2024 13:40:54 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e4f56sm3023903173.78.2024.11.06.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 13:40:54 -0800 (PST)
Date: Wed, 6 Nov 2024 14:40:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 6/7] vfio/virtio: Add PRE_COPY support for live
 migration
Message-ID: <20241106144053.2f365e22.alex.williamson@redhat.com>
In-Reply-To: <977be8e4-e52c-41bc-8a43-31ae906e6665@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-7-yishaih@nvidia.com>
	<20241105161845.734e777e.alex.williamson@redhat.com>
	<977be8e4-e52c-41bc-8a43-31ae906e6665@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8BOkNDh1lhjVrL79sZ793nMl-Sv7kbqmxG2fUFRRp54_1730929255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 13:16:34 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 06/11/2024 1:18, Alex Williamson wrote:
> > On Mon, 4 Nov 2024 12:21:30 +0200
> > Yishai Hadas <yishaih@nvidia.com> wrote:
> >   
> >> Add PRE_COPY support for live migration.
> >>
> >> This functionality may reduce the downtime upon STOP_COPY as of letting
> >> the target machine to get some 'initial data' from the source once the
> >> machine is still in its RUNNING state and let it prepares itself
> >> pre-ahead to get the final STOP_COPY data.
> >>
> >> As the Virtio specification does not support reading partial or
> >> incremental device contexts. This means that during the PRE_COPY state,
> >> the vfio-virtio driver reads the full device state.
> >>
> >> As the device state can be changed and the benefit is highest when the
> >> pre copy data closely matches the final data we read it in a rate
> >> limiter mode and reporting no data available for some time interval
> >> after the previous call.
> >>
> >> With PRE_COPY enabled, we observed a downtime reduction of approximately
> >> 70-75% in various scenarios compared to when PRE_COPY was disabled,
> >> while keeping the total migration time nearly the same.
> >>
> >> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> >> ---
> >>   drivers/vfio/pci/virtio/common.h  |   4 +
> >>   drivers/vfio/pci/virtio/migrate.c | 233 +++++++++++++++++++++++++++++-
> >>   2 files changed, 229 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/virtio/common.h b/drivers/vfio/pci/virtio/common.h
> >> index 3bdfb3ea1174..5704603f0f9d 100644
> >> --- a/drivers/vfio/pci/virtio/common.h
> >> +++ b/drivers/vfio/pci/virtio/common.h
> >> @@ -10,6 +10,8 @@
> >>   
> >>   enum virtiovf_migf_state {
> >>   	VIRTIOVF_MIGF_STATE_ERROR = 1,
> >> +	VIRTIOVF_MIGF_STATE_PRECOPY = 2,
> >> +	VIRTIOVF_MIGF_STATE_COMPLETE = 3,
> >>   };
> >>   
> >>   enum virtiovf_load_state {
> >> @@ -57,6 +59,8 @@ struct virtiovf_migration_file {
> >>   	/* synchronize access to the file state */
> >>   	struct mutex lock;
> >>   	loff_t max_pos;
> >> +	u64 pre_copy_initial_bytes;
> >> +	struct ratelimit_state pre_copy_rl_state;
> >>   	u64 record_size;
> >>   	u32 record_tag;
> >>   	u8 has_obj_id:1;
> >> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> >> index 2a9614c2ef07..cdb252f6fd80 100644
> >> --- a/drivers/vfio/pci/virtio/migrate.c
> >> +++ b/drivers/vfio/pci/virtio/migrate.c  
> > ...  
> >> @@ -379,9 +432,104 @@ static ssize_t virtiovf_save_read(struct file *filp, char __user *buf, size_t le
> >>   	return done;
> >>   }
> >>   
> >> +static long virtiovf_precopy_ioctl(struct file *filp, unsigned int cmd,
> >> +				   unsigned long arg)
> >> +{
> >> +	struct virtiovf_migration_file *migf = filp->private_data;
> >> +	struct virtiovf_pci_core_device *virtvdev = migf->virtvdev;
> >> +	struct vfio_precopy_info info = {};
> >> +	loff_t *pos = &filp->f_pos;
> >> +	bool end_of_data = false;
> >> +	unsigned long minsz;
> >> +	u32 ctx_size;
> >> +	int ret;
> >> +
> >> +	if (cmd != VFIO_MIG_GET_PRECOPY_INFO)
> >> +		return -ENOTTY;
> >> +
> >> +	minsz = offsetofend(struct vfio_precopy_info, dirty_bytes);
> >> +	if (copy_from_user(&info, (void __user *)arg, minsz))
> >> +		return -EFAULT;
> >> +
> >> +	if (info.argsz < minsz)
> >> +		return -EINVAL;
> >> +
> >> +	mutex_lock(&virtvdev->state_mutex);
> >> +	if (virtvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY &&
> >> +	    virtvdev->mig_state != VFIO_DEVICE_STATE_PRE_COPY_P2P) {
> >> +		ret = -EINVAL;
> >> +		goto err_state_unlock;
> >> +	}
> >> +
> >> +	/*
> >> +	 * The virtio specification does not include a PRE_COPY concept.
> >> +	 * Since we can expect the data to remain the same for a certain period,
> >> +	 * we use a rate limiter mechanism before making a call to the device.
> >> +	 */
> >> +	if (!__ratelimit(&migf->pre_copy_rl_state)) {
> >> +		/* Reporting no data available */
> >> +		ret = 0;
> >> +		goto done;  
> > 
> > @ret is not used by the done: goto target.  Don't we need to zero dirty
> > bytes, or account for initial bytes not being fully read yet?  
> 
> The 'dirty bytes' are actually zero as we used the below line [1] of 
> code above.
> 
> [1] struct vfio_precopy_info info = {};

Ah, missed that.
 
> However, I agree, we may better account for the 'initial bytes' which 
> potentially might not being fully read yet.
> Same can be true for returning the actual 'dirty bytes' that we may have 
> from the previous call.
> 
> So, in V2 I'll change the logic to initially set:
> u32 ctx_size = 0;
> 
> Then, will call the device to get its 'ctx_size' only if time has passed 
> according to the rate limiter.
> 
> Something as of the below.
> 
> if (__ratelimit(&migf->pre_copy_rl_state)) {
> 	ret = virtio_pci_admin_dev_parts_metadata_get(.., &ctx_size);
> 	if (ret)
> 		goto err_state_unlock;
> }
> 
>  From that point the function will proceed with its V1 flow to return 
> the actual 'initial bytes' and 'dirty_bytes' while considering the extra 
> context size from the device to be 0.

That appears correct to me.  Thanks,

Alex

