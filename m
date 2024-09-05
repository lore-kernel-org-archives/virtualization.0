Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C1194AF3
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538321; cv=none; b=n2Ozau05AQT0sxuf3avbnK3pTK/4CwjNhHiMNoI9ms4O7Y4ZUvrnsSn8znoRlA0shOcYzzRLD9Lwj4j7VwCKDYuZBgT6Eqrc5IYVoZr3IM5v365252WUgTUmrNJP1Yd6/609O3bb0IKvnJdHgxZUIcHyccTzJXaM5MxqHOD1QhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538321; c=relaxed/simple;
	bh=rxVBrr5JB+LiJcrM9kipJYfpbElLY1RcLEjHjvLLoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GPGdMGJzmA6OO/61Qb8BzMK2RdNdw8K6RGvX0EbXhQ4b/V6ypogVNyHiFZ/r1ytwDUjM2Tr7kSpnUdrL4dijA5jK+MiuBekmFGIKK/4akgUBnWj3LAFKA8repJQ2t7MvLsh90JzwjBmTHqvE6MsdTnkfN9tgIBAJGy2U7CW59jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDbPgUAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDbPgUAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725538317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uV9Ps9I2kiQkXKKB9CYYT2x6uyi7nvkPpJLSIw5AOEQ=;
	b=MDbPgUAfnTpApeWOUkmsAgXEwAtcEGB6TkO3uRiKo/UIZQM7wsndVbKcA+ZwBipoHirMDX
	XWv20IxjcBrqGlyMTlePM9q7x2x+nzthSuggktr8g8M71Bo3dzW8Y1o5oNd2/67hHO3WiV
	IDiuvRs7/zIbQcRZjGoBBuRJLuT15eM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-LV0yh-5-NVKNVSstZX_KDA-1; Thu, 05 Sep 2024 08:11:56 -0400
X-MC-Unique: LV0yh-5-NVKNVSstZX_KDA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c32158d0so476536f8f.1
        for <virtualization@lists.linux.dev>; Thu, 05 Sep 2024 05:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538315; x=1726143115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV9Ps9I2kiQkXKKB9CYYT2x6uyi7nvkPpJLSIw5AOEQ=;
        b=SGyOG73ghxN39i8Fs8xceC2YGwbSvJE+h8Ic4pu6rrpOyVQ4rlq2g4UP2AHADty5xc
         SobvfaFfznY6aYYzsgNhJ7laalqTsyeYYivJYhLOeC1LWpx5ibx2uvvMpqrLKXt8K3qi
         Jb0+IEYwV6gSRmFrmL1CitfDrD6VM00jN8GhCcSGbGPxmJW1eK68TqH1fe3HMXXKSOUC
         HOJU/Ol05SX+lJyhR+ctcd2wRnDLNJwoiwbnychG+3Wopp+/AmEeEPmxZKWl56tFhs7b
         3DQa8DuD8xtM+H/Iib1wSraTamgNvF4AifJpQdZkY1qsHn64qnHK1czTwo/cPoopxLGN
         NDCw==
X-Forwarded-Encrypted: i=1; AJvYcCW2kH7Jd77D0WtVPGKFN78/1SSww87cOUFmfTv/FyyWply673SKrtnQ5v24hGj/4AEk/0N184nZW18rWcMBmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnvXl/xqV4sJVDSaljSWUKPcyBbndTIkjQe22hVZ9yuBGYkfSR
	LG3cMPFvwSYSYHDkZDeIP2IN3Rf2hIt3qiWXEOgss4DqbPB4bRZXBOqgsxHbgJg6Td6/Vx76LLJ
	pD+/Nqmza6R4Gt0F46EGeUa96gzgyTfF1079nQynk1B/uzEyuWpbv3vb8ShEyaEub
X-Received: by 2002:adf:e38c:0:b0:371:a844:d326 with SMTP id ffacd0b85a97d-374bcfe5e74mr12844287f8f.43.1725538315007;
        Thu, 05 Sep 2024 05:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWHWAhLTW54aL8/fKJKu2un/o8IsgIWTybMSffflhkCvx7Czg/Z9Plp17Cp/9d4oe6RJHNRQ==
X-Received: by 2002:adf:e38c:0:b0:371:a844:d326 with SMTP id ffacd0b85a97d-374bcfe5e74mr12844227f8f.43.1725538314095;
        Thu, 05 Sep 2024 05:11:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ee:dac1:384c:40cd:a203:ee4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf1b0c18sm250501545e9.37.2024.09.05.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:11:53 -0700 (PDT)
Date: Thu, 5 Sep 2024 08:11:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, virtualization@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kvm@vger.kernel.org,
	Jingbo Xu <jefflexu@linux.alibaba.com>, pgootzen@nvidia.com,
	smalin@nvidia.com, larora@nvidia.com, ialroy@nvidia.com,
	oren@nvidia.com, izach@nvidia.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v1 1/2] virtio_fs: introduce virtio_fs_put_locked helper
Message-ID: <20240905081133-mutt-send-email-mst@kernel.org>
References: <20240825130716.9506-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240825130716.9506-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Cc: "Eugenio Pérez" <eperezma@redhat.com>


On Sun, Aug 25, 2024 at 04:07:15PM +0300, Max Gurtovoy wrote:
> Introduce a new helper function virtio_fs_put_locked to encapsulate the
> common pattern of releasing a virtio_fs reference while holding a lock.
> The existing virtio_fs_put helper will be used to release a virtio_fs
> reference while not holding a lock.
> 
> Also add an assertion in case the lock is not taken when it should.
> 
> Reviewed-by: Idan Zach <izach@nvidia.com>
> Reviewed-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  fs/fuse/virtio_fs.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index dd5260141615..43f7be1d7887 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -201,18 +201,25 @@ static const struct kobj_type virtio_fs_ktype = {
>  };
>  
>  /* Make sure virtiofs_mutex is held */
> -static void virtio_fs_put(struct virtio_fs *fs)
> +static void virtio_fs_put_locked(struct virtio_fs *fs)
>  {
> +	lockdep_assert_held(&virtio_fs_mutex);
> +
>  	kobject_put(&fs->kobj);
>  }
>  
> +static void virtio_fs_put(struct virtio_fs *fs)
> +{
> +	mutex_lock(&virtio_fs_mutex);
> +	virtio_fs_put_locked(fs);
> +	mutex_unlock(&virtio_fs_mutex);
> +}
> +
>  static void virtio_fs_fiq_release(struct fuse_iqueue *fiq)
>  {
>  	struct virtio_fs *vfs = fiq->priv;
>  
> -	mutex_lock(&virtio_fs_mutex);
>  	virtio_fs_put(vfs);
> -	mutex_unlock(&virtio_fs_mutex);
>  }
>  
>  static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
> @@ -1052,7 +1059,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  
>  	vdev->priv = NULL;
>  	/* Put device reference on virtio_fs object */
> -	virtio_fs_put(fs);
> +	virtio_fs_put_locked(fs);
>  	mutex_unlock(&virtio_fs_mutex);
>  }
>  
> @@ -1596,9 +1603,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  
>  out_err:
>  	kfree(fc);
> -	mutex_lock(&virtio_fs_mutex);
>  	virtio_fs_put(fs);
> -	mutex_unlock(&virtio_fs_mutex);
>  	return err;
>  }
>  
> -- 
> 2.18.1

