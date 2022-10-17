Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA64C4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E480F4035C;
	Mon, 17 Oct 2022 07:19:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E480F4035C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCxldr1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkgX-kutftrd; Mon, 17 Oct 2022 07:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08B7440340;
	Mon, 17 Oct 2022 07:19:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08B7440340
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DF5C0032;
	Mon, 17 Oct 2022 07:19:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EE3C409F3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:19:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EE3C409F3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCxldr1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKNI02pbtz-d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA172404B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA172404B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665991168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkUg6/0FMIF28QDhQtxTrbq13wIxQfU7Z/tHdIVDWY8=;
 b=dCxldr1UpjLpvKxdNRWr9WSCARrsyJArsgKAWhQb3As2LUikAqbgBB0ZSSLw+pHbifO5Nb
 dxVgTX4sCFuE0Fi9LjtlBOGhb+qXA6W/YDoEhvAwrjGlvdovNtFGE3P5XUz71T4XNKbGWO
 U/VlqH4Ty8vUEXhQN9VnIl7wDxgwq6U=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-uoq88s6hNjK-bBYDp3F3WA-1; Mon, 17 Oct 2022 03:19:26 -0400
X-MC-Unique: uoq88s6hNjK-bBYDp3F3WA-1
Received: by mail-oi1-f200.google.com with SMTP id
 m11-20020aca1e0b000000b00350c1f42f26so3609671oic.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SkUg6/0FMIF28QDhQtxTrbq13wIxQfU7Z/tHdIVDWY8=;
 b=FYmvefZSyFwF8WltolX+kTY3X6YuxpGicm6JJB9KNXJWkXqfNf+JhKQGHGBSZIts+5
 mnQEzMeilUGK1ObT9k3TWsFLH1FhvCn6lk1M4+bstQWyrqlBeAmQAAaHHREdfScCxrxu
 ecH8uY7+C0bvnFxBpYEzWfCIIPyW2Dla6PSdAQ98SUu3G6pduZs/Tw4aZcZbxZ6Cfx3a
 sZPHLW3hZqWQAbvEv8kOx+bOIX70+KBPdOqdHg1Xw3iNrpCZZuCa5hZBxsHPBT8/w0a6
 gWeJfS3Smit/j1HR2Dpejtcu/ph1Q4llQBbe3d7C4WfZDyrBrvNYp4zxemh0+fhivegO
 T2tw==
X-Gm-Message-State: ACrzQf1EmSZj4BthBGiUiqA3fy//D4nQAzoVGp7mPj7OwxznftsvMaZ3
 TSDZckhsZC5CqJARNJ+4wstw+QSSiZ7qhk4bIzexvFitRI6Sv2DGPfjQs3J325RXa8gxXOu9z1i
 4lN9T4qyIhg0o78P72DRBuhZZG/LlSKAyTvJVZXizAvB96JcJ21WRnEyRag==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14258362oad.35.1665991166231; 
 Mon, 17 Oct 2022 00:19:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6w6Nfjbl4EdqH2QKlTcRuRUKkwREHqHvlZjA4lkO2jYOgVdLekwLpAhaotX8iPTSZNGJ/fR4PkyFLtIYd0ty8=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14258353oad.35.1665991166054; Mon, 17
 Oct 2022 00:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <491fb8fe786739958eb9ff3df2250a4188b0bbe5.1665745877.git.sebastien.boeuf@intel.com>
In-Reply-To: <491fb8fe786739958eb9ff3df2250a4188b0bbe5.1665745877.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:19:14 +0800
Message-ID: <CACGkMEviBPXzg1Wyx6coi8o9EPNtERZ43AN_L8Lk5mfuhryycg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa: Add resume operation
To: sebastien.boeuf@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, mst@redhat.com,
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

On Fri, Oct 14, 2022 at 7:14 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Add a new operation to allow a vDPA device to be resumed after it has
> been suspended. Trying to resume a device that wasn't suspended will
> result in a no-op.
>
> This operation is optional. If it's not implemented, the associated
> backend feature bit will not be exposed. And if the feature bit is not
> exposed, invoking this operation will return an error.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/vdpa.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..96d308cbf97b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -219,7 +219,10 @@ struct vdpa_map_file {
>   * @reset:                     Reset device
>   *                             @vdev: vdpa device
>   *                             Returns integer: success (0) or error (< 0)
> - * @suspend:                   Suspend or resume the device (optional)
> + * @suspend:                   Suspend the device (optional)
> + *                             @vdev: vdpa device
> + *                             Returns integer: success (0) or error (< 0)
> + * @resume:                    Resume the device (optional)
>   *                             @vdev: vdpa device
>   *                             Returns integer: success (0) or error (< 0)
>   * @get_config_size:           Get the size of the configuration space includes
> @@ -324,6 +327,7 @@ struct vdpa_config_ops {
>         void (*set_status)(struct vdpa_device *vdev, u8 status);
>         int (*reset)(struct vdpa_device *vdev);
>         int (*suspend)(struct vdpa_device *vdev);
> +       int (*resume)(struct vdpa_device *vdev);
>         size_t (*get_config_size)(struct vdpa_device *vdev);
>         void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>                            void *buf, unsigned int len);
> --
> 2.34.1
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
