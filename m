Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2E9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 08:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A8DC60F37;
	Mon, 20 Jun 2022 08:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A8DC60F37
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B7/7s4vX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fF26G8DnHoLa; Mon, 20 Jun 2022 08:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6BD060F2E;
	Mon, 20 Jun 2022 08:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6BD060F2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A042EC0032;
	Mon, 20 Jun 2022 08:24:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4406CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1108660F2F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1108660F2F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L5vtmOBfv-Bb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A6DF60625
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A6DF60625
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655713477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6ksPPnyGgOYO6quOjNZEzWgaMag0zFdWZyTCSpNBko=;
 b=B7/7s4vXvVfCFGthS2DpGox3F3SyFyQdoU6VgVvvJZrFOOkrzYxuOfT2vRbK1EuPJOm+dy
 UMNCXKgsw9fRIXlMELOXqbjgSLD+EPeCwvWsXc6e3WTo9ymDCWFCKqf4Kni0jxTOshwK1Q
 OPw4ue7r3UZBJI1pjlzZrHkXKctIAcI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-QUAxhaiyNmKun8zxeVXFgw-1; Mon, 20 Jun 2022 04:24:36 -0400
X-MC-Unique: QUAxhaiyNmKun8zxeVXFgw-1
Received: by mail-ej1-f69.google.com with SMTP id
 lv2-20020a170906bc8200b0070e0d6bcec0so3151667ejb.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e6ksPPnyGgOYO6quOjNZEzWgaMag0zFdWZyTCSpNBko=;
 b=44VbRW9opes+VRVYcna5R9FG3uyUUTsimN505EoX8ffNyLpnuXeLq0LsFSMa+vXuja
 Aj4o9+UJkdiBjmhLa/sLT0xlD234qcJzydDRQZgGRgugx6rYjMxTnDfZ1COGwNYxXmyQ
 6vAwDoiICmMVZg8P+xfz3ucOr07Nx6M9vx4BSw5YkhGtRyDUDUgd5On6R0bL4jhCLNZf
 owJqpoqTqZFItotbIvNlqY32ri8CcpP+xWKma8peZ9+9NKAUwKEoVLK2KvpbDTGrEPkX
 jUvja5OAABpxjaFTtKj/U41I5k9IuIl5tbMSlrfXRf20d04cM7pqUFKf+9VCP7QNgGxa
 kngA==
X-Gm-Message-State: AJIora94FDFlt2BJGoXZcij3snNjYnK7VBcBwq0/fsLf5mHqdvaFmmsI
 US+/PkmRrwqXZxW8BPT+8dxck7fp+HM34vGX91LQPmvZ/pe1OkPUPFDKwf4BogiNbgVdiiCAGds
 Qk2rhFW9uSLyLvD8q8tTb/g3kfEKfyzmBDomwgiomVA==
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr28239619edd.11.1655713474777; 
 Mon, 20 Jun 2022 01:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZJFz4jypDP9bnqRJi3iDgujFYlZ8/dhQlpRBA4gnyiHbIdX6gXU3ScDQzxUS9zbdSyqyZfQ==
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr28239603edd.11.1655713474518; 
 Mon, 20 Jun 2022 01:24:34 -0700 (PDT)
Received: from redhat.com ([2.52.146.221]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa7d619000000b0043574d27ddasm4114501edr.16.2022.06.20.01.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 01:24:33 -0700 (PDT)
Date: Mon, 20 Jun 2022 04:24:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtio_ring: Optimize duplicate judgment codes for
 virtqueue_add_split
Message-ID: <20220620042221-mutt-send-email-mst@kernel.org>
References: <20220620080656.1559-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220620080656.1559-1-wangdeming@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 20, 2022 at 04:06:56AM -0400, Deming Wang wrote:
> We combine repeated judgments about indirect in one place
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>


Point being? The patch makes the code kind of confusing.
What do we gain in return?

> ---
>  drivers/virtio/virtio_ring.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..331fa3cf5be7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -582,23 +582,19 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  					 total_sg * sizeof(struct vring_desc),
>  					 VRING_DESC_F_INDIRECT,
>  					 false);
> +		vq->free_head = vq->split.desc_extra[head].next;
> +		vq->split.desc_state[head].indir_desc = desc;
> +	} else {
> +		/* Update free pointer */
> +		vq->free_head = i;
> +		vq->split.desc_state[head].indir_desc = ctx;
>  	}
>  
>  	/* We're using some buffers from the free list. */
>  	vq->vq.num_free -= descs_used;
>  
> -	/* Update free pointer */
> -	if (indirect)
> -		vq->free_head = vq->split.desc_extra[head].next;
> -	else
> -		vq->free_head = i;
> -
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> -	if (indirect)
> -		vq->split.desc_state[head].indir_desc = desc;
> -	else
> -		vq->split.desc_state[head].indir_desc = ctx;
>  
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
