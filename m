Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5329EC54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9C2560F78;
	Tue, 27 Sep 2022 04:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9C2560F78
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fEs2C4eL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DTY1r_8yaiEg; Tue, 27 Sep 2022 04:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E7A460F7C;
	Tue, 27 Sep 2022 04:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E7A460F7C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57912C0033;
	Tue, 27 Sep 2022 04:01:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E71E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B438F405CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B438F405CE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fEs2C4eL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eD6yTuJCoT2n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1831240112
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1831240112
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664251310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7lIjUt+hfufCzcxQtRQ7Q4/F8PQSEKvpahXtOM1zAs0=;
 b=fEs2C4eLytTHIBiv+7qB8HY/ewAPixyMbX7WV5vctrFt+Rao6/jmM8f8fqvUA+C9lgVEWr
 9Z+eYWRy72jAi6ldZejKRxEG+l5OEYrHa6HEmnU/ME6PIRkBzJFQWu1Ztu+2OQIvaGjH6j
 FkSO7V7xL61b5F32NMKQZIurlLDec9k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-oiwrq6OhMgyg8EbyB5jv-Q-1; Tue, 27 Sep 2022 00:01:42 -0400
X-MC-Unique: oiwrq6OhMgyg8EbyB5jv-Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 bl2-20020a056808308200b0035028763f44so2778543oib.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=7lIjUt+hfufCzcxQtRQ7Q4/F8PQSEKvpahXtOM1zAs0=;
 b=KWNRhmrjbd9F498oGD4csxrK6ZNR2ctDe+TrO4odz+KKuV1DuUTEpctMKaace2tiGk
 T0Fczeg0kZaB3sxPh1mRGWELFiWujpMIw8BDDAj+ky8ixiE+Xc9zNa1TfWo1/8WJMgBN
 2mzKu6nGDQVpwuVD/7N6l06+kOqa1wdbOW9F1uuj2RDcMWvE6lk+ggirNaS3BINIB3v7
 B3efRBf9BDZStlwpf481ku0Dfb93KBufTBxquzgkJvgBl+VVNQCk3j8qCzEIGLqrWAGG
 OdgeNIVK0uTA0z85fA2GTKliPdFaUdRnCf8PGlLGcy5eiF8/EjK8AvqTzGmZ4EG1uMHj
 ekjw==
X-Gm-Message-State: ACrzQf0mCuYNmhFsnoAlkugbcWqGnuhgU8QnCKadiesDQ3jOd0azzxhk
 ksmSJkmYnYwhTzkmD6BGuK3/tmi5T9rYxD4IYabphG/8Jgy4cR1iWDfjSuU0+PYZaxofBHhaOgk
 ga8zkY52N/o40trsKWS7iNMpzaBgoKg9/XFP6aibLcgD8bc+1Qhe0Rb7OAQ==
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1049115oag.280.1664251301525; 
 Mon, 26 Sep 2022 21:01:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70F8Ybkw+ftIjAd0V0ZxtTyRfkCtq71sY1UXmniwDHvOisWowtKgZkzq9L+wAcLMvQbmN4FB4GulJ4+Dx5uA0=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1049102oag.280.1664251301353; Mon, 26
 Sep 2022 21:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926102946.3097-1-wangdeming@inspur.com>
In-Reply-To: <20220926102946.3097-1-wangdeming@inspur.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:01:30 +0800
Message-ID: <CACGkMEtnsBEu6nm0oFCJyQwwf5PzdMRAsbzZZPZZ1TS9vRg1RQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Drop unnecessary initialization of
 detach_buf_packed
To: Deming Wang <wangdeming@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Sep 26, 2022 at 7:15 PM Deming Wang <wangdeming@inspur.com> wrote:
>
> The variable is initialized but it is only used after its assignment.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..abac0a3de440 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1544,7 +1544,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  static void detach_buf_packed(struct vring_virtqueue *vq,
>                               unsigned int id, void **ctx)
>  {
> -       struct vring_desc_state_packed *state = NULL;
> +       struct vring_desc_state_packed *state;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
>
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
