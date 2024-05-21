Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8FC2E9
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258556; cv=none; b=RbjAkt95gycn8P5NENNxUbyBpAG/AhmYRVk+L0nxyl/nTl7HEpfeqEJ53IMtynCzwZI4IwZUVfX1eQl6x6e0wqXzo67fPzQ1YjdJsvNKbTayBdBBqNAs2Q/A3CQqxlZJkPDDqzXuouzae8nd8E+uY6LAQ+DJ8SeIscmfFX3Pzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258556; c=relaxed/simple;
	bh=fHuz2izoRrXrdHAlUrSjhQX2YUje7YUBi+uJY+FIFow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY5xfBdIkngn3SVqKtJD1vFGjHGx9LRoyecnXlosVoEK2wdAwTG0b6XncbV9NcBG5vHZW5dI91So1BQTi/qJDn1dfMZ8YvEjwH1FeuEZzKgg2H3ZOeseKv3512O7tpi7ECUROj/yW4bPoYSvcjhjrrEVUyQwrTkikd3AArau3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6UMxeLq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6UMxeLq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8A9B402DD
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSZP-mo_QyGF for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 02:29:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C901740264
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C901740264
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6UMxeLq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C901740264
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/SMSLTAXFZZwyaLr5kA0B7cu9hCGbcKtCcSYK2/MZg=;
	b=U6UMxeLqj/g244r0zOY7+I7RFOf2HAzZTcrIOhanm5KzQLnEI+LHkpu1yIdnJFgkKszaim
	lNnbGb2CG7XRuK0+3f3Alcl/BK/V2yhZ44Xm1SotweippXOs9OFwZX2Cml+x1MsOaBYDSM
	Vd/59X2MS4DoSZvcFE9rTD9gKiGHtys=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-dfR3pPNWPdKJTrL_cqeltA-1; Mon, 20 May 2024 22:29:10 -0400
X-MC-Unique: dfR3pPNWPdKJTrL_cqeltA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b364c4c4b0so12206806a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 19:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258550; x=1716863350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/SMSLTAXFZZwyaLr5kA0B7cu9hCGbcKtCcSYK2/MZg=;
        b=rbqtZxPG+PaVV9gweCwXUpZnu0HEuLd7UblNFvDPfoN4FCXfJ/hlGmhsyu+2Y9Qygl
         akvnbCfRbX08bNKZk3q1j1Vc5Z8aHIsm8bk1Oo3lxPfAit+DL/vpGOQtf45scK6ReMG6
         DT6Pko6Ue8kd9jb9ZSKuRZt3+8h2LyCWuTUAPe56q8ZlZygEL7mK82QLBLffXts/lhyT
         8D0hrPok2qosKJBSCKduzC0hxkBbB0tMhuJSjqN043c+TIOvHZuMviZAPJONmakPhsbE
         L027OcPicLCREllZULS5Ml7wGf7Zix4bTHCzy0d9h+n1xtOV5LHY4WqWBwnGhObIWU0X
         C6CQ==
X-Gm-Message-State: AOJu0YwqIHlAf+45BW2ry6UlP6H9bZSl9d+ac1Ye22LkSi+DCk4pUDqS
	K+dHiVDqR3qNRQtKeqqE2NwfPipVUYXYvy+fINm0GCiX7kCH9yCC2ZpxQX47Tj36x3lA60lrWeD
	UfbUF1zNPjy4E2SRiAdrp9ky42M1TL2mrL8jDTVHct4EJt2PtQuIHPS/TYYso9n/WdRTyLw1oYV
	hP4Sx+/yN8pAa9Efr1/RySnKa9BNnNWkIFuhpU9aLSX+B/JBIW3d3f0Q==
X-Received: by 2002:a17:90a:590e:b0:2bd:9319:3da1 with SMTP id 98e67ed59e1d1-2bd93193deemr634203a91.25.1716258549725;
        Mon, 20 May 2024 19:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo2Z7xohL05uhMNAfGrDbx9YpWpz1z4P9YFEzrqlUWpKPu7N+uZF6UrdhiOEzsxGwb66VvqwEqJFlwaQIRHdY=
X-Received: by 2002:a17:90a:590e:b0:2bd:9319:3da1 with SMTP id
 98e67ed59e1d1-2bd93193deemr634190a91.25.1716258549414; Mon, 20 May 2024
 19:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:28:57 +0800
Message-ID: <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
<steven.sistare@oracle.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
>
> Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ba52d128aeb7..189596caaec9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>                 return 0;
> @@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       vhost_dev_flush(vdev);

vhost-vDPA doesn't use workers, see:

        vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
                       vhost_vdpa_process_iotlb_msg);

So I wonder if this is a must.

Thanks

> +
>         ret =3D ops->suspend(vdpa);
>         if (!ret)
>                 v->suspended =3D true;
> --
> 2.39.3
>

