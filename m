Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344D7C4332F
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 07:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6C314086A;
	Mon,  7 Nov 2022 07:44:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6C314086A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMj6eVeL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NN5IDVN65Ley; Mon,  7 Nov 2022 07:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EFD084077D;
	Mon,  7 Nov 2022 07:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFD084077D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A1EC0032;
	Mon,  7 Nov 2022 07:44:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3052C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BACA605AC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BACA605AC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMj6eVeL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdKjXKT8IYXO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC227605A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC227605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667807088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
 b=cMj6eVeLEd/0fEe5k8r5HYFroJsVbOngK9RkN31kURXesD1wx4rFMG1fmNIvLS5M24Q+BH
 5XIymmnfwEN+06DW9kxzn0K3ORlB3dbUZH4fu1Lf7UhZA0y00TSH21qzycKMP0jgFc0yor
 Q7yPUvC+wWpwhGnpRevFfoCnH7RKsvE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-3PHND_uhOTaSJ9gUCxK7sw-1; Mon, 07 Nov 2022 02:44:47 -0500
X-MC-Unique: 3PHND_uhOTaSJ9gUCxK7sw-1
Received: by mail-oi1-f198.google.com with SMTP id
 v129-20020acaac87000000b0035a4772703cso4292611oie.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
 b=ZK8OBa1oTlulvqE509Q5loZeXvIttX/JL6OS2A/0G4bdQWt38PQl7AuNMRHlEJ0nt9
 scf9bm2mKgJ9IlzR2KTWFuKtOAo3xVGjByo6HJOayQDas0iEQrTjWfz1Xh7REQdgw//J
 zZt8GtN7+RECfYWVmzXuuukUlF7S4m3x6t/frKd21mseZyOuIII9Hg4acicz07qIZGdK
 jJ43XUqzyYZDach53g2WTOGfOqeN9zpIJXHFtUvB5Y2tJ2hXerqKaXBuyV24mP+5vIo8
 uCwRLVc6Hrar4IIi8igqtVLBk/AxoDP7qz1BUeBjoItfJDoG8uvcxb+WQicUqK9wDw2J
 YiQA==
X-Gm-Message-State: ACrzQf2yYlg4N2fIoOc4lzca+D/vf9ktwlYnETn9zAFUt0OlxKST6vpl
 Mn8hC8JwHicmj2hidWbewRARKPKKb05di62shT4H+P8SKeSOFrYfrf5uaBqPr3lg6wmbxa7dZ6c
 GBSHT8GLqtB2i+T2ou3/fJ+cH/rmbCpIUZZq1yEqWg6ft+9g6flOScNPqHQ==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr37655787oal.35.1667807087055; 
 Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-Smtp-Source: AMsMyM43CuZtbbZUUL09mIBdM0KXhoZTHYA7ejIPeVZeiGHn6tLwkEXQi3wb+5rVf+Ne1rZHUmGFX/lGOM+1MoRzqcc=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr37655777oal.35.1667807086875; Sun, 06
 Nov 2022 23:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Nov 2022 15:44:35 +0800
Message-ID: <CACGkMEtPGK1rkpbtDNQYKNZTMpgx+iPSMyK_aBQ_e=7356mLTA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
To: Rafael Mendonca <rafaelmendsr@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Suwan Kim <suwan.kim027@gmail.com>
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

On Sat, Oct 22, 2022 at 4:42 AM Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
>
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Do we need to cc the stable?

Thanks

> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..291f705e61a8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>                                         struct virtblk_req *vbr)
>  {
>         blk_status_t status;
> +       int num;
>
>         status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>         if (unlikely(status))
>                 return status;
>
> -       vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -       if (unlikely(vbr->sg_table.nents < 0)) {
> +       num = virtblk_map_data(hctx, req, vbr);
> +       if (unlikely(num < 0)) {
>                 virtblk_cleanup_cmd(req);
>                 return BLK_STS_RESOURCE;
>         }
> +       vbr->sg_table.nents = num;
>
>         blk_mq_start_request(req);
>
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
