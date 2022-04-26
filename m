Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75707C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13BF360E72;
	Tue, 26 Apr 2022 06:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ymkf-a9vyXU; Tue, 26 Apr 2022 06:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2FE160B71;
	Tue, 26 Apr 2022 06:05:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 678FEC0032;
	Tue, 26 Apr 2022 06:05:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FDC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F84C414C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlSISWgkugnm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4289541603
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650953136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2egRURZGc3X1zsm5gAB76hti2IuqB4ZG8M3lASWWXA4=;
 b=hm3vrFqaWA0JAxNzMccEPIzjHmzB5KeH1ZRwIJ3z8ChqhUkaSj+sGI/OGeyZVgRt1P16w8
 f91ajGObVFgye/qjh3SPttlivIM2hHgmVx+Du9egEnqG0xbV4rvtyH86Mnd5NsLgBpnfqF
 lcXYtiJJVEIKbvBZTp32q0/BGvKvt4Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-_gPAgk38O0CK1lU2dM2STQ-1; Tue, 26 Apr 2022 02:05:34 -0400
X-MC-Unique: _gPAgk38O0CK1lU2dM2STQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 l26-20020a2e99da000000b0024f02d881cdso1671605ljj.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 23:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2egRURZGc3X1zsm5gAB76hti2IuqB4ZG8M3lASWWXA4=;
 b=MWbonW1VbrtYnC7LXFB85iYPBwj+i0Tywvuehn5cS3C3Cu8l9TaGuWjwJxsB/aNlvu
 +fpyyHT7THWJrjWJQEObjsCf7SuquQhXcl1twqnjXHj1PCygv8mCZAdtvEhG68bsKPK6
 k1R2NPZ8GG8WhzL7UNhjoWAn9y/ldTqoPuWnAkwydP/G4aZ99Z0+3gXD6ojrY2AePgU/
 jYKQZubVjWrQNEg7FwaJOtfIihdQbEJ4pFMGv26wP3XjXmsmgvzre7xdP7HHyuNLOlnD
 FAmNbBxEQuToOuqhlDFlN5oUTBiF3PS/glvMA2IMnoewZQyoIMWfsD0fmWKduARFUtad
 9SDg==
X-Gm-Message-State: AOAM531dy363CSWFf3zC/OjhZCXM+AsqdgQ460fLToHvBnpNhWJR6an9
 k0jf9Jp0P35eIWodIX+qghuSlMcYP0CC+8uRFQCnj3USlwqbvwVl8gbM7r3pOROe6ZkTH+34H8c
 S1Y7XSb1NpP6Mc0vy1vIB785BbqBxJNeM2M5CiNQWC7FUiiYs1zdC0g7R5A==
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr13647213ljd.315.1650953133065; 
 Mon, 25 Apr 2022 23:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvqk67sw4EDGv0ATnZE0rdxm7etQKm8KtJCuN+NgM20B0XOe9lQOGILQ7TAJClGDrxsUb8Af50QocRPtJgc+k=
X-Received: by 2002:a2e:534a:0:b0:24a:f64f:a1d6 with SMTP id
 t10-20020a2e534a000000b0024af64fa1d6mr13647200ljd.315.1650953132889; Mon, 25
 Apr 2022 23:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-2-lulu@redhat.com>
In-Reply-To: <20220425062735.172576-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Apr 2022 14:05:21 +0800
Message-ID: <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To: Cindy Lu <lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
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

On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>
> this patch is to add the support for vdpa tool in vp_vdpa
> here is the example steps
>
> modprobe vp_vdpa
> modprobe vhost_vdpa
> echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
>
> vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 138 +++++++++++++++++++++++-------
>  1 file changed, 106 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index cce101e6a940..873402977543 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -32,7 +32,8 @@ struct vp_vring {
>
>  struct vp_vdpa {
>         struct vdpa_device vdpa;
> -       struct virtio_pci_modern_device mdev;
> +       /* this is an pointer point to the mdev in vp_vdpa_mgmtdev*/
> +       struct virtio_pci_modern_device *mdev;

The code can explain itself, so the comment is redundant.

>         struct vp_vring *vring;
>         struct vdpa_callback config_cb;
>         char msix_name[VP_VDPA_NAME_SIZE];
> @@ -41,6 +42,12 @@ struct vp_vdpa {
>         int vectors;
>  };
>
> +struct vp_vdpa_mgmtdev {
> +       struct vdpa_mgmt_dev mgtdev;
> +       struct virtio_pci_modern_device mdev;

I think coupling it with mgmt device is probably not good, any reason
we can't allocate it independently?

Thanks

> +       struct vp_vdpa *vp_vdpa;
> +};

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
