Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE4C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94C2340187;
	Mon, 14 Nov 2022 04:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C2340187
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSoLjxNH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3wPQtZiBtOx; Mon, 14 Nov 2022 04:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FCD7400DA;
	Mon, 14 Nov 2022 04:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FCD7400DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 056ECC0032;
	Mon, 14 Nov 2022 04:40:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 669E9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FD4540888
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FD4540888
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSoLjxNH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFuyOmIgM0Bd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:40:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 663DA40868
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 663DA40868
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668400827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2AITeW9SUbg+X03mosFnSodKHnylEEh3d619uSKZzAg=;
 b=HSoLjxNHhOUYbZ4/IFdYpZotczvZ+c8Mz31Nm8Qts/cmgKlfmMccm/yVjryQNQEZPtlcxd
 fFc0349j6O/1DrfrH5m+8oCpEOyvaXDrZ9kqmHYXC/Jfy0kFABIRWlmKitw4zgHwF5eTk3
 AIWnd17pDRGUQEcX4Y6W16JC5mVWegU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-9Q3785RJPa6jGmArv06cOw-1; Sun, 13 Nov 2022 23:40:25 -0500
X-MC-Unique: 9Q3785RJPa6jGmArv06cOw-1
Received: by mail-oi1-f199.google.com with SMTP id
 bl8-20020a056808308800b00359ea795db4so2817785oib.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2AITeW9SUbg+X03mosFnSodKHnylEEh3d619uSKZzAg=;
 b=tcljJ4p7S989jz1sBWWYtzqoXV/Z6jZy4BK5fwUfvIDaCtTTcLWWF+Iq5vB/2NYqxI
 qyd2kELSvgUKwF+vvsiYXd8fmB9zfqN89yq3oP1NkFgFRPECP8jAcUEBkgwExDgi3XD4
 2El9YEOK9zfcqqy9OJL6tznhTaH59N1mGDBvtybStwhvJ9CPFXqO+thB8tJg1Bt594KY
 yFF3jXnmrSFIHDpoiXSbIg1K/91MfuNj8txeudd5h+Tcj0XUyIdq9jM9TtB18HGvCeQw
 RVns/VpW+3O/YfNDDWQfyaVx5StRbALUgkGdnAt2qIUwdkdfezN9wV3KXc32s03pJeY6
 KSTA==
X-Gm-Message-State: ANoB5pnkI2BOUbh8JY/ymXE9lyK+P0NRMfSBqI8b8yU5i/dZcoq8M13S
 QvSkBY23IsiUSThHbCdPDbsmnlLMpGqzYZnI1hnXsFV1kFS5IjQwxzCYaArcuIxlNadmMRI5auY
 Vh/Kcq9wKMYGfREtwrGy3lV/R/7HCszEt2fm6xPR9ZlmGe3izRJJbknlA6g==
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5016274oip.35.1668400825293; 
 Sun, 13 Nov 2022 20:40:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7o1mzaVUMbysjWFfjZ1n8y2KTX5oFhKdFGWORBEYdEwS80wGhVDcsEa8CrPxN+qWO8ycrR83QFKV94ZMdM620=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5016269oip.35.1668400825116; Sun, 13 Nov
 2022 20:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-3-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 12:40:14 +0800
Message-ID: <CACGkMEuD0234xsjS2eOmJXvNup_VEN67NCxm-iR0vP6p-kbNKA@mail.gmail.com>
Subject: Re: [PATCH 2/7] vdpa/mlx5: Fix wrong mac address deletion
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: lulu@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Delete the old MAC from the table and not the new one which is not there
> yet.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ea95081eca0c..c54d5088ed4f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1686,7 +1686,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>
>                 /* Need recreate the flow table entry, so that the packet could forward back
>                  */
> -               mac_vlan_del(ndev, ndev->config.mac, 0, false);
> +               mac_vlan_del(ndev, mac_back, 0, false);
>
>                 if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
>                         mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
