Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7463BC433FE
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:24:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246FC60F11
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 246FC60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E189D80B08;
	Mon, 25 Oct 2021 02:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Xfcsn0ZKGRJ; Mon, 25 Oct 2021 02:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A76980C48;
	Mon, 25 Oct 2021 02:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 703E6C0012;
	Mon, 25 Oct 2021 02:24:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E54C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 940CE6072A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xg_rAwb4z2bg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:24:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA6D860720
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635128645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JUxXUseIXFIvap74/jQsZQQ03ufSBRIw3QP8jHZu/g=;
 b=K2BBvo44u2La9k9m4dxOdFji5GpkIK2iKGPyXWDmtCDcvvRhNfawNWoUXe6dS1pA+V3U1C
 A92vI71cu10pmCrGzum6Wrz+rA08KsuSbdQRQzAthw+FhtW44IR3EBgtTJkoh1I6TUWAr7
 o/p2EyuJW+iNElI8b1MieNaFrOFE2IQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-cvqy64SAOLSr89Ecf4W0eA-1; Sun, 24 Oct 2021 22:24:04 -0400
X-MC-Unique: cvqy64SAOLSr89Ecf4W0eA-1
Received: by mail-lf1-f70.google.com with SMTP id
 j22-20020a05651231d600b003ffacdb8311so386847lfe.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4JUxXUseIXFIvap74/jQsZQQ03ufSBRIw3QP8jHZu/g=;
 b=zlE4fPhdhfnkgjnLKGv7XK6Owonf116t5JyxUJNLFn+1t+JVys1NW4+vdyByIwpVtA
 fHOy5j33HbLc9tfP++IJn/bakKsW0aZ2xbI/VCSdxOmNFwrODaDhJQqFmo9HO3StYzdJ
 LHeYFS+qrx58s8aaHHRDpB43AUlv2nE9e14U7bDKW3Tqeu9j16NE/W3nNqFsJkdeqXK2
 5w6D8cav5h6U+5QIbTAVsp3tTrkyB55iMJZCEFk3aPOGN3DGD8/cqyPg3AvpGFWw0LuE
 Jqh6l3BfRdy9bjw8pooUBfM+gpwpx5OkdPxMBxUYzJgKR/18cz/6v16ZdeIDPUxYNEwh
 HvbQ==
X-Gm-Message-State: AOAM530yy1EEkcgFJ/k818XrESPh01M6Ktv+jitpVRgQTNZUhOXshOwQ
 J8funkrRr7XpDYvgoXuZHuNI+gyF3Fq68riPAgdJiuEZTqiz86G4sjgTgP/rS+BRjJB9Ki7d7f5
 obnu9zpr9HXrdx4o6dosh9hHlPXpYP9pAxBv7BuT1BzHRJ7Fjjh14yHsnVA==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr14686415lfg.498.1635128642526; 
 Sun, 24 Oct 2021 19:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx68SuxBTomY8Ig7IPrhEEiEwDcHl1JPOAJIFpQUPmwPQ6Fx2+wDmEHPAd46eAvJrJ/xnbyrwoNDDYIdx3jL6I=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr14686381lfg.498.1635128642191; 
 Sun, 24 Oct 2021 19:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <f3d36f0d7c9588aefaf6eeaa235b0a22fee23d56.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <f3d36f0d7c9588aefaf6eeaa235b0a22fee23d56.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:23:51 +0800
Message-ID: <CACGkMEvyiJk+o9DNxoUGSUcytu9a56XQje-HZncYNDc9_eJGHA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This attribute advertises the min value of virtqueue size. The value is
> 0 by default.

As discussed previously, 0 seems an invalid value. We should use 1 at least.

Thanks

>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/vdpa.c       | 5 +++++
>  include/uapi/linux/vdpa.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index fd014ecec711..4aeb1458b924 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -500,6 +500,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>               int flags, struct netlink_ext_ack *extack)
>  {
>         u16 max_vq_size;
> +       u16 min_vq_size = 0;
>         u32 device_id;
>         u32 vendor_id;
>         void *hdr;
> @@ -516,6 +517,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>         device_id = vdev->config->get_device_id(vdev);
>         vendor_id = vdev->config->get_vendor_id(vdev);
>         max_vq_size = vdev->config->get_vq_num_max(vdev);
> +       if (vdev->config->get_vq_num_min)
> +               min_vq_size = vdev->config->get_vq_num_min(vdev);
>
>         err = -EMSGSIZE;
>         if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> @@ -528,6 +531,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>                 goto msg_err;
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
>                 goto msg_err;
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
> +               goto msg_err;
>
>         genlmsg_end(msg, hdr);
>         return 0;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..e3b87879514c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -32,6 +32,7 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
>         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
>         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> +       VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
>
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
