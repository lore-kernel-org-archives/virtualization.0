Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE21BDC9
	for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3Icgkin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705410265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkZSOnIygpbJ+i2FOTNIbQzjiHiHU9Jj+ia6iKy7fds=;
	b=U3Icgkin8vHduClBNLCtdYrfLKeJNNBuS81bW88qYN5hx/8fxXYoP0ifygFlTX84HW205b
	W0qBCv/H//7zZqFfEg3jWUI/9GqO5Dj3Ru+qm7TOs6x2h+o+Bbd/5bjc9fXCOwIEbJDUt+
	vl3MQ5ZMzby5X7xOAGUWPUWpI1vXVPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5rGq9MIGNris1abUsUjC-Q-1; Tue, 16 Jan 2024 08:04:21 -0500
X-MC-Unique: 5rGq9MIGNris1abUsUjC-Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337b38d69dfso268759f8f.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 05:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410260; x=1706015060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkZSOnIygpbJ+i2FOTNIbQzjiHiHU9Jj+ia6iKy7fds=;
        b=hqYdlzUZexD0Cyg3uPC3oTfTOVxBJLNYwF5XrUyhdCQk9TeXviGgXDXEDCefW+cU3x
         L1liNObXVqeZeyHWXVnMd2l1sdubd3VUf7yJ3L4iXpcoTog3gtza2AbDpyFRmj/iiERZ
         4hq2GXwBI5L0MHBymK1JE7SafnXvT7vCZToof/swc9XzFD1Oic7aollwO8dgrMPKVZlt
         KJ0tt0Ra9j3LlqvNJ7apUthEX9mKeUe4S1QT8rkwmHhJifwHRNakZrO8wk+KD1NuL/KC
         5M2W3fvpDIT0PYc43WqBwi7UsaxppvuWIHby0c7Ae8Z3KYS60PK0+LNBt0JyQszqcIx/
         IKjQ==
X-Gm-Message-State: AOJu0YxqgdhQBN/saEo5SIQBCMmWkQYIXqnga7fsklsMx/Mgn2aD95eI
	LWQCRamnmCSwVoDkfi58NK4w3Jfe1ZDtBMHUVD2+YRm4dx6GM8Q0yPs+5HQfKkQuoqYcANYrHpW
	3Ja/2M4qSz6HnP5mE0ilQuYGF3r6HCBBWBXY=
X-Received: by 2002:a05:600c:4593:b0:40e:4deb:ebb8 with SMTP id r19-20020a05600c459300b0040e4debebb8mr3969366wmo.110.1705410260632;
        Tue, 16 Jan 2024 05:04:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyZdcsasGz47vtQaNB8csj3bWm95OR3KENXLPC0whD1sH4fuYcQBxPhDpk8+TYhBCKD+yU/Q==
X-Received: by 2002:a05:600c:4593:b0:40e:4deb:ebb8 with SMTP id r19-20020a05600c459300b0040e4debebb8mr3969351wmo.110.1705410260253;
        Tue, 16 Jan 2024 05:04:20 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm19339021wmf.43.2024.01.16.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:04:19 -0800 (PST)
Date: Tue, 16 Jan 2024 08:04:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] virtio_scsi: remove duplicate check if queue is broken
Message-ID: <20240116080403-mutt-send-email-mst@kernel.org>
References: <20240116045836.12475-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240116045836.12475-1-lirongqing@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 12:58:36PM +0800, Li RongQing wrote:
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/scsi/virtio_scsi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 9d1bdcd..e15b380 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -182,8 +182,6 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
>  		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
>  			fn(vscsi, buf);
>  
> -		if (unlikely(virtqueue_is_broken(vq)))
> -			break;
>  	} while (!virtqueue_enable_cb(vq));
>  	spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
>  }
> -- 
> 2.9.4

