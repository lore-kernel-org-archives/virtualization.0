Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32728C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 03:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FB4D40104;
	Wed, 21 Dec 2022 03:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FB4D40104
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KxwGc+yz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCF4G-NctshR; Wed, 21 Dec 2022 03:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BA9840B05;
	Wed, 21 Dec 2022 03:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BA9840B05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1273FC007B;
	Wed, 21 Dec 2022 03:25:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A09FBC007B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BCEF81FCB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:23:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BCEF81FCB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KxwGc+yz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LCsdkG_MQeyT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C61DE81FCA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C61DE81FCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671593002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CFnvNj9hg0uk4ty9l25TpJtyYdolUCT1QyYJMfBzM80=;
 b=KxwGc+yzosbf5BcN+DXSN5MojJAyPhQ9OZTpBXQOuGIg+Q4f7lg+fXwGt5lwr/tBilPgux
 jQdckQKPfyY1w3ZLveYMa3IU5akrVKnp+kwgb2MeBahJKX0pwcIFWU7f35+4rRsEfAB+2K
 QpU1jkNU8G2MpduQNh3D9VBtnPSBwes=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-0fKzoVWGNw6Y4Gsv6ufHPA-1; Tue, 20 Dec 2022 22:23:21 -0500
X-MC-Unique: 0fKzoVWGNw6Y4Gsv6ufHPA-1
Received: by mail-oo1-f72.google.com with SMTP id
 x20-20020a4a6214000000b004a36ed7679eso6390947ooc.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CFnvNj9hg0uk4ty9l25TpJtyYdolUCT1QyYJMfBzM80=;
 b=JdVHgCVS8pK7KUCzvtxaMR6teQmKQxrM3ryfJPKQ9LiS8LwhbgaxAJU0jrYdw9E5XW
 k3OMSk1QmXim6irfTaaP5887kGKtRDR9d1KM8og4+e6UlRng86P1E+opAoaZgCorUKsM
 SKXTXYDDt5JcDu9q9v3VkoRhC9NYwRA7bkCr5NmK+p22UedR9Rv9Qjtp7LQfAf/fLyCl
 G0t59jcZ1odV5xKYJkR/7jO/nFa3SFvNb63eDj6A4ZMFUyRHRAYZ7hEk78jUgW7kJoBH
 M0niRnHOHg3Y2yFN9ug1YB9JVs8+L/HMcqj+qWTiXdXBz7BldnbMMPTZB53UhyeW0l52
 ni8w==
X-Gm-Message-State: AFqh2kqbAW6pw3lvi/MmQ9lQBE3iGiqPlocUw/5PoEnA7HPAi2q3f3gN
 +bgJfLs16fD017cgi5EiB66kwpyMxQcTfKHR1v/AwWGbfQyrCfCekpR9z7xo+mCCnnmQ+BSa034
 dBUZdD2zlUZXZi3pGb6Ig3h3ebTemEDG5NEr+HBtTSspSMM2STMg4T1ZHxg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr5746oah.35.1671593000983; 
 Tue, 20 Dec 2022 19:23:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCqHucOMNWaOuq5hOMU7pwt2QCc0KdTdowmUytqZw+Vtlqfi8EU47R4djYK+989+3MChf2+uVMV3LQ50Op9xs=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr5744oah.35.1671593000701; Tue, 20 Dec
 2022 19:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20221220140205.795115-1-lulu@redhat.com>
In-Reply-To: <20221220140205.795115-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 11:23:09 +0800
Message-ID: <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
>
> The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> But some function was not changed while calling this function.
> Add this change
>
> Cc: stable@vger.kernel.org
> Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")

Is this commit merged into Linus tree?

Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
can squash the fix into the new version?

Thanks

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 46ce35bea705..ec32f785dfde 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
>  static dev_t vhost_vdpa_major;
>
>  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> -                                  struct vhost_iotlb *iotlb,
> -                                  u64 start, u64 last);
> +                                  struct vhost_iotlb *iotlb, u64 start,
> +                                  u64 last, u32 asid);
>
>  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
>  {
> @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>                 return -EINVAL;
>
>         hlist_del(&as->hash_link);
> -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>         kfree(as);
>
>         return 0;
> --
> 2.34.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
