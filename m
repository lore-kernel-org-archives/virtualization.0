Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D5C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1969F603E9
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1969F603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEC1540100;
	Thu,  9 Sep 2021 02:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Je8QKGX27aA; Thu,  9 Sep 2021 02:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37D8C40451;
	Thu,  9 Sep 2021 02:53:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1074EC0011;
	Thu,  9 Sep 2021 02:53:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 429D5C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C4F5407AC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rNMb9TRhvrlQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01CDD40798
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631155992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Dd9/A9sFeDep6pwypkyHRy6LbqeJ+nHZSlHUWD9puM=;
 b=LwwwRfEb7kSUSqx9BJpdwrHPpPVXHy7UaQmVJGxgm5Ey6DM+ucc8DTOM7UJOKgkd3p4OKe
 0ODdoXV1Edg/HRfx+4AjS/4HzIN7CygC621zy4sU8y+hQlTJNaoeZAA15SPVz3h2t1imw7
 PYknWeW+4DsMiomc8MT98G2KbvNRCG4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-9REg3KpYOwKTzLP1nqSHhQ-1; Wed, 08 Sep 2021 22:53:11 -0400
X-MC-Unique: 9REg3KpYOwKTzLP1nqSHhQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 w27-20020a05651204db00b003d8fb25ec90so128955lfq.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Sep 2021 19:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4Dd9/A9sFeDep6pwypkyHRy6LbqeJ+nHZSlHUWD9puM=;
 b=poey3q5UWY3Wwb5vthj8ayo64WkhSYDdQ0MCMi6qRJPpVG6eTilMJNycJTSvdO1J1T
 jBRkUkbiTKykxwhnraViU1HSfaqQmEprBR/WTUWDl8JdascpZqbDLx5HwJxk+27yS89L
 K0kgwxJOGRpISDEKpBV9mYM8DD0BBn5/BW925SVmyvGmHzLmZmLhlCihUEt2hzwU0dBt
 eFM4BPYxO3Z/uCqAl7ZAf6x/SNje85m+4zI8HfaCLhofAcvAzGA1l56iEwR49wiDHD5U
 C3rWF5qwnnicc4jor1+KvZZZqP8jQl4VKz3lwYQQLyvF6/FnpxVq5BLEIRuigDdc1Uwx
 0Bew==
X-Gm-Message-State: AOAM531kV/vBQNwu9YFFIDBidZwV86AFBSYgOGH1fxBrd5RdlJMMm5xH
 0sdLInZ1ZRrYG92aG16QDwyVICMTSxteTl88J78hQGKkxgGmkR6F5/k5j2JAy1yBe5CBBoZpSPZ
 ePYr1eESJqmbKmEZ7De8qMmPoCsMHhiaKl/tUCzat3UcjO8sXK3uFXyWdog==
X-Received: by 2002:a2e:99d9:: with SMTP id l25mr425109ljj.217.1631155990108; 
 Wed, 08 Sep 2021 19:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo1QiSnPNV+uG69sTm5YphTzwX2AqVXNZlrZDd69Dbr+lA7ndwSZ8/FU/at8ix62m9YeVPMnUYQ2Rz6NMek4E=
X-Received: by 2002:a2e:99d9:: with SMTP id l25mr425099ljj.217.1631155989914; 
 Wed, 08 Sep 2021 19:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <463c1b02ca6f65fc1183431d8d85ec8154a2c28e.1631090797.git.pabeni@redhat.com>
In-Reply-To: <463c1b02ca6f65fc1183431d8d85ec8154a2c28e.1631090797.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Sep 2021 10:52:59 +0800
Message-ID: <CACGkMEvTBt3WSJnxvGN0-gsZNXE1eRqx4ZV7X+d9gar1VfwArA@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: fix OoB on sendmsg() failure.
To: Paolo Abeni <pabeni@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Sep 8, 2021 at 7:42 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> If the sendmsg() call in vhost_tx_batch() fails, both the 'batched_xdp'
> and 'done_idx' indexes are left unchanged. If such failure happens
> when batched_xdp == VHOST_NET_BATCH, the next call to
> vhost_net_build_xdp() will access and write memory outside the xdp
> buffers area.
>
> Since sendmsg() can only error with EBADFD, this change addresses the
> issue explicitly freeing the XDP buffers batch on error.
>
> Fixes: 0a0be13b8fe2 ("vhost_net: batch submitting XDP buffers to underlayer sockets")
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: my understanding is that this should go through MST's tree, please
> educate me otherwise, thanks!
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks!

>  drivers/vhost/net.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 3a249ee7e144..28ef323882fb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -467,7 +467,7 @@ static void vhost_tx_batch(struct vhost_net *net,
>                 .num = nvq->batched_xdp,
>                 .ptr = nvq->xdp,
>         };
> -       int err;
> +       int i, err;
>
>         if (nvq->batched_xdp == 0)
>                 goto signal_used;
> @@ -476,6 +476,15 @@ static void vhost_tx_batch(struct vhost_net *net,
>         err = sock->ops->sendmsg(sock, msghdr, 0);
>         if (unlikely(err < 0)) {
>                 vq_err(&nvq->vq, "Fail to batch sending packets\n");
> +
> +               /* free pages owned by XDP; since this is an unlikely error path,
> +                * keep it simple and avoid more complex bulk update for the
> +                * used pages
> +                */
> +               for (i = 0; i < nvq->batched_xdp; ++i)
> +                       put_page(virt_to_head_page(nvq->xdp[i].data));
> +               nvq->batched_xdp = 0;
> +               nvq->done_idx = 0;
>                 return;
>         }
>
> --
> 2.26.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
