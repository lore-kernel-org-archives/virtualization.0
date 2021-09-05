Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43EC433F5
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:50:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E20760F56
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E20760F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3378D400CC;
	Sun,  5 Sep 2021 15:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 016Bu_vrjvc8; Sun,  5 Sep 2021 15:50:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8AA240106;
	Sun,  5 Sep 2021 15:50:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95E92C0010;
	Sun,  5 Sep 2021 15:50:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 481CAC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C0B6063A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4WnWw5Ivxa6z
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:50:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4251C6062B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630857020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt3+lUrr17xrCqRRoNhFo4SoQOQwGb+2P4GqnUIMZG4=;
 b=X0uRKxScafZ8cP5x3OvbPC69kVrPHnmj1SrI+dw9mj0LmOoSqquzlSFa3a6XM2Y0jcgogP
 7Qyrt6MTQic3/4Ndb5mEy/DxG9w+vCIOod+RcJgUPgeSa3yYdDFt2qct1LeG+Mo2tkv3fP
 kzysVAj4HdizsVtkQ5t71DieJiBEQ6I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qfhn0VEgPb-JFcyGei7k4g-1; Sun, 05 Sep 2021 11:50:19 -0400
X-MC-Unique: qfhn0VEgPb-JFcyGei7k4g-1
Received: by mail-ej1-f72.google.com with SMTP id
 bx10-20020a170906a1ca00b005c341820edeso1220126ejb.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 08:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dt3+lUrr17xrCqRRoNhFo4SoQOQwGb+2P4GqnUIMZG4=;
 b=bJuSAm9H6n9foFj/C/ZJgN929d/iCwKdOaQByXIKCwISrhn0b6i5kEOww/OgG6FkBU
 XTB9vdpGl+sztV1v1W5o7qN/N+SPlFfQWu4nUH9O7eZj4mP0hSAGpUrVOp1jdm/2k3Ea
 JZbxdCaIrpqWszsytz7exL6vFqgG/tQ7v5fdLx+yLFlWCIqAcHebHPgxm7lIjBjq+ZG0
 yF6wupuGeLF/PeAEzR4daA2d6ekAPE3yvEqFJ3E2MQ6bkjehrmlCXOBKqds7Xo7XGnv1
 LbrsWobglCKNkBNyYT3DqGFWtLihJHlYKzybYCnDH+m0f6/aVKB7Gz6xNfhoajjFev4Y
 9Qug==
X-Gm-Message-State: AOAM530KczDALNrwatF+9RHuTGAPKENxKHG06ekzJL06PwgoWAmtyW2l
 uMakwR8pgvb641Nqs1u19XBoQH6dhpmu6/b+lO/2S7PSuE1WAXPM0Xi+SX+LSCTGbFvjvrHVTwn
 ddDGhP6n9NG6Yd3py86vTKGxPTsDzgZw2NdnAvrnJ4w==
X-Received: by 2002:aa7:c514:: with SMTP id o20mr9209153edq.318.1630857016058; 
 Sun, 05 Sep 2021 08:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Vr1hTVx3/Sty6LNqcZMAJAOmpd1FUx3LtNW8reY+9FMDFhx51QrJugo5epYEB0BNnX/rsw==
X-Received: by 2002:aa7:c514:: with SMTP id o20mr9209144edq.318.1630857015928; 
 Sun, 05 Sep 2021 08:50:15 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id g18sm2495519ejr.99.2021.09.05.08.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 08:50:15 -0700 (PDT)
Date: Sun, 5 Sep 2021 11:50:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH net-next v4 2/6] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR'
 bit.
Message-ID: <20210905115002-mutt-send-email-mst@kernel.org>
References: <20210903061353.3187150-1-arseny.krasnov@kaspersky.com>
 <20210903061523.3187714-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210903061523.3187714-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Sep 03, 2021 at 09:15:20AM +0300, Arseny Krasnov wrote:
> This bit is used to handle POSIX MSG_EOR flag passed from
> userspace in 'send*()' system calls. It marks end of each
> record and is visible to receiver using 'recvmsg()' system
> call.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Spec patch for this?

> ---
>  include/uapi/linux/virtio_vsock.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 8485b004a5f8..64738838bee5 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -98,6 +98,7 @@ enum virtio_vsock_shutdown {
>  /* VIRTIO_VSOCK_OP_RW flags values */
>  enum virtio_vsock_rw {
>  	VIRTIO_VSOCK_SEQ_EOM = 1,
> +	VIRTIO_VSOCK_SEQ_EOR = 2,
>  };
>  
>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
