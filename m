Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C3DC4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 04:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9262182F20;
	Thu, 20 Oct 2022 04:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9262182F20
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fmZ3fJeK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3LnJdS4AB7Wn; Thu, 20 Oct 2022 04:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 18AD882CCA;
	Thu, 20 Oct 2022 04:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18AD882CCA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDD54C0033;
	Thu, 20 Oct 2022 04:38:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D33C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 04:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B14F6419D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 04:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B14F6419D3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fmZ3fJeK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8oX0Soi4zeg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 04:38:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7720F419AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7720F419AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 04:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666240720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kyv8nGXj9Ah4DccAJThYdzgEzvLEuADjYtSpDgDrIrY=;
 b=fmZ3fJeKo3ThMuSto0IsnudeKub3IKa13EW3EbiZudh6zG8LKbOLgtl+wHhG5WmEKdbsv4
 vmpzNhY7XHA96ZRxywqrUVWK2nj/gJ18HkaN14pjDDknIpgzdNqLMlsEaOq7Oc9BJNAl4j
 Cc7zzzOn77cECkod4X08WQvCrx1h92w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-a0ahRwt5NguOhGmpI_4aZQ-1; Thu, 20 Oct 2022 00:38:39 -0400
X-MC-Unique: a0ahRwt5NguOhGmpI_4aZQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 m20-20020a056402511400b0045da52f2d3cso7785404edd.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 21:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kyv8nGXj9Ah4DccAJThYdzgEzvLEuADjYtSpDgDrIrY=;
 b=k1MITdVQ+VZ7B2m+qMqjz79xwuWtPYZWUQjpZDZLWsRxRnqFRcbg/0Iu1cf/8Ywjb/
 grGCKvDwNiCcIil8NAbntNVKYX53UUBL897EDVuHaXALN/w+pbtdKug7Tg59gKLbARVO
 VtzJR33aPP21hxJc+jkFFAnMTGCbr9zjhSheTuavINSI7HvKm/zQETM29ZbvroRm2wuB
 kRFaEASrHuFkR3aU2lwo7N2eUoQ0YFfKw06zGHP9zIP7ruG92lHP0zwVIWILolUaDcko
 Oj+WFsAjIfx7YBx9MgE59SKehVfjaEByNDbVrjlABvpgfGMII04N5pUDZRUIeZIWqeyZ
 cqzg==
X-Gm-Message-State: ACrzQf3ser+aray00k7KcCdOayBjlN66jh9JMFza5K2XkPXMdHz3YYf6
 PzhJ+ukIDJGu+ihi9ucSNq9swUCG7EPBRsKjzRVZDNkPkxMO6rBoatfRnKH+cx8zJxydk2gmiEC
 E5/M1mA/dhF8JYdKyprKbJejp2cOHS4QJtoJ67dvjakj8iNY1gU2mwoz5rg==
X-Received: by 2002:a17:906:8a62:b0:78d:a05c:c37f with SMTP id
 hy2-20020a1709068a6200b0078da05cc37fmr9268198ejc.159.1666240715759; 
 Wed, 19 Oct 2022 21:38:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ZwOFEZM8doQCzml9WL1ee9yuCrqJnl7mDRSvjurlf1Q90Jp73KqKd+JTzUxzcUph64t0ai8+bt62iwoatemI=
X-Received: by 2002:a17:906:8a62:b0:78d:a05c:c37f with SMTP id
 hy2-20020a1709068a6200b0078da05cc37fmr9268186ejc.159.1666240715492; Wed, 19
 Oct 2022 21:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Oct 2022 12:38:22 +0800
Message-ID: <CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa: save vdpa_dev_set_config in struct
 vdpa_device
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query. This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> This commit attempts to make struct vdpa_device contain the struct
> vdpa_dev_set_config, where all config attributes upon vdpa creation
> are carried over. Which will be used in subsequent commits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/linux/vdpa.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4..f1838f5 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -58,6 +58,16 @@ struct vdpa_vq_state {
>         };
>  };
>
> +struct vdpa_dev_set_config {
> +       u64 device_features;
> +       struct {
> +               u8 mac[ETH_ALEN];
> +               u16 mtu;
> +               u16 max_vq_pairs;
> +       } net;

Not for this patch but I think there should be a union container for
this structure to make it usable for other types of devices.

> +       u64 mask;
> +};
> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -77,6 +87,8 @@ struct vdpa_vq_state {
>   * @nvqs: maximum number of supported virtqueues
>   * @mdev: management device pointer; caller must setup when registering device as part
>   *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
> + * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
> + *            the exact same config is needed.

Not a native speaker, but I guess it should be better named as "init_cfg"?

Thanks

>   */
>  struct vdpa_device {
>         struct device dev;
> @@ -91,6 +103,7 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct vdpa_dev_set_config vdev_cfg;
>  };
>
>  /**
> @@ -103,16 +116,6 @@ struct vdpa_iova_range {
>         u64 last;
>  };
>
> -struct vdpa_dev_set_config {
> -       u64 device_features;
> -       struct {
> -               u8 mac[ETH_ALEN];
> -               u16 mtu;
> -               u16 max_vq_pairs;
> -       } net;
> -       u64 mask;
> -};
> -
>  /**
>   * Corresponding file area for device memory mapping
>   * @file: vma->vm_file for the mapping
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
