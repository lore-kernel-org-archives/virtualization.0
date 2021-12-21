Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA69C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 05:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4EAE409D2;
	Tue, 21 Dec 2021 05:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M46AEZqMP83k; Tue, 21 Dec 2021 05:58:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 418524051B;
	Tue, 21 Dec 2021 05:58:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F086C001E;
	Tue, 21 Dec 2021 05:58:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 934C7C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DFFC408D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ai3NYIt4e5Th
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:58:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07A78408D2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640066288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SWj8bqqc5bqSr3T3WFSPPAdZyuEjHckvNTvH1+DRKKY=;
 b=P1CfjAIqYKqpvJ6QKoQMzVqG8l/YptyX+n9QZbPQQRcxY2HVjGrx/gcdAaxsq7LO0ncCzl
 2x8tmBOoxBj8LafT7UczxCyB3qw0Ge9E3Htdd0s/vKf9G8Hd4maRogjtMoyTykCnCNu7o7
 I5FH60MVBfwB1tdVOx1dTjNl1QotC/w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37---kE9gTkNvqn7kIzCoUA9g-1; Tue, 21 Dec 2021 00:58:07 -0500
X-MC-Unique: --kE9gTkNvqn7kIzCoUA9g-1
Received: by mail-lf1-f71.google.com with SMTP id
 r21-20020ac25f95000000b004259e6ab262so3813942lfe.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SWj8bqqc5bqSr3T3WFSPPAdZyuEjHckvNTvH1+DRKKY=;
 b=iDoFle/cqV1+MbLZtJC/xSsSApoD2yIWURae/8mH0Y4LBvWAHVYLJx8sxw2GLw7Duc
 GT/cQmpTNoriaN8Zoqn0rUYJ6CxPE96kbYiavQvwQKw9FMj9gH6uMT2JYSPyU//K2/3u
 asn/myGiRSL6uR6FBHHtPWSPw1FsNzNohKPmTbAAE365CpgxrpbIgqJ0gFEk/bwJrt84
 0p9damYCi5BDvJTTpzGaDjFDWNhcbhWcx6A8pakdIRiKqxomzQ44m6NpBTPsd2eB9PJE
 zGdJhEgTdcvzmf5xIIPQiHACfsn4IWUdu45cKna0QSdngmLB4L6p8ZNfxBxAmL9M/Zki
 RznA==
X-Gm-Message-State: AOAM532M+0Ui6SthLaih0/8T6q8cs2Fkm5wBRRUq/oc64NPWNJK/0OLY
 1zSL1mYtxpQB+Z/Z1uhQzvrC4wGOCUQhZgZyGkI8fsD6TTFdqJ+3rAPt8hPMxZtuIQyJlB+4zBF
 LaI2HrukCxVko26h2mtr3MCL+DjuQN6VYSFdJhgRbhDDCj31Nz/4cJCHzzQ==
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr1695089lfu.199.1640066285381; 
 Mon, 20 Dec 2021 21:58:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzP1IlLdHIltNn2sJ4s6Brkg/QDnTdp0CfY//B/nPPpCD0/rmGRpSuoCxOa8f9DLI5Pvk220R6cGeZtnmnPLYg=
X-Received: by 2002:a05:6512:22d6:: with SMTP id
 g22mr1695064lfu.199.1640066285173; 
 Mon, 20 Dec 2021 21:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-8-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-8-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 13:57:54 +0800
Message-ID: <CACGkMEtBqBo_AF-yxQ=TkF3Nt6uWWBKDtLEUVmjRdrzn-e7DzA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] vdpa: Add support for returning device
 configuration information
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Add netlink attribute to store the negotiated features. This can be used
> by userspace to get the current state of the vdpa instance.
>
> Example:
> $ vdpa dev config show vdpa-a
> vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs
> 16 mtu 1500 features c3182bc3182b
> CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS VERSION_1 \
> ACCESS_PLATFORM
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
>
> ----
> V2 -> V3
> 1. Move attribute definition to end of enum definition
> 2. Return the entire negotiated features bit mask
> ---
>  drivers/vdpa/vdpa.c       | 3 +++
>  include/uapi/linux/vdpa.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 83730713c7d0..64b2ab60e0bb 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -820,6 +820,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>                 return -EMSGSIZE;
>
>         features = vdev->config->get_driver_features(vdev);
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
>
>         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>  }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..db3738ef3beb 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -23,6 +23,9 @@ enum vdpa_command {
>  enum vdpa_attr {
>         VDPA_ATTR_UNSPEC,
>
> +       /* Pad attribute for 64b alignment */
> +       VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> +

I may miss something, but will this lead to a change in the existing ABI?

Thanks

>         /* bus name (optional) + dev name together make the parent device handle */
>         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
>         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
> @@ -40,6 +43,7 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
>
> +       VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
