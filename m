Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B94C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 05:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93D7B40BB3;
	Thu, 12 May 2022 05:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6EL7saG-38ew; Thu, 12 May 2022 05:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D426400E5;
	Thu, 12 May 2022 05:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E37D8C0032;
	Thu, 12 May 2022 05:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 908EEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69F4660B79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5Ye-rpA9HwL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FD2160ADC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652335047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t0bDFb/tAAbguC+IHzTExFsJLrZiV0YVZh8GFZSOhC8=;
 b=fbQOa0cBLXisj8omCSSa4ehkiRuak1D7ivcAesdzCwyPCkjIpFVBDhbxqOg7VUuPmhAfZ6
 octWV/1UHItnQOxUgU1TekOyCt/8d7Z3wC0QJzE1nU3bHpD8HMhrqygk6yEYzM+JQIHF3Q
 Xv63KST+A4DJ34yey/QX7nFIrmTt+RM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-XeXZlTS3Mo2BZ8qZYmcPFA-1; Thu, 12 May 2022 01:57:26 -0400
X-MC-Unique: XeXZlTS3Mo2BZ8qZYmcPFA-1
Received: by mail-ej1-f69.google.com with SMTP id
 j1-20020a170906278100b006fa14cafba4so2278743ejc.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 22:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t0bDFb/tAAbguC+IHzTExFsJLrZiV0YVZh8GFZSOhC8=;
 b=1HEHJZLQXisCaxagVK8EK+xVfQ2SbZ2in5Q+5gHJzqL6+1NqKJFYyQXxzMhnzYzJlj
 L0PNbnuxLeduHWZMJqAV16UGx92WmRdvib1B0trXBmNQ6/0kVO7ilxqKPYtld4wM1jx3
 2zF95lFv87M7wP3mjaDTp35N2UcFmCQAHL5z97eZUZxGtWIJO05aCQ0K6K04SJz85SJY
 kdFEcNWzHTAasvJrvT4fmO44DFlm427dX6Xm4OeiFQC2hnGVgnS0uLpS6bfsA5GkLzEu
 j8dflH9YulySekmGyJS1ntfJ1yvYAbTbOC2sn8tjfIuG0IDwSK5t5v++QD5CTVpHfS4y
 XdcQ==
X-Gm-Message-State: AOAM530uH1p8FabVDpnTQruBT2FeWfE3zw4BYyDx886PeJykbmDs6/6z
 yE40NzCreoUAbiINxLOY71kVyfyFY7aCUuHufTqxJh4wjZUloPREo8M75c8mUTMMZeu2kKok0Ib
 2WrvsskgdbPJm2OMVAF0iZuDL7wBpjDtQbhnbB60uAg==
X-Received: by 2002:a05:6402:5188:b0:428:e77:b55b with SMTP id
 q8-20020a056402518800b004280e77b55bmr33524669edd.82.1652335044998; 
 Wed, 11 May 2022 22:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweg8gy0e+6m0LjjDG+u4kpvwZO9qOgpH3UsJkCBifxEoBTksWtM9DNoFbA6rp3Rsn/gvanVw==
X-Received: by 2002:a05:6402:5188:b0:428:e77:b55b with SMTP id
 q8-20020a056402518800b004280e77b55bmr33524656edd.82.1652335044755; 
 Wed, 11 May 2022 22:57:24 -0700 (PDT)
Received: from redhat.com ([2.55.42.2]) by smtp.gmail.com with ESMTPSA id
 t5-20020a170906608500b006f4512e7bc8sm1716477ejj.60.2022.05.11.22.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 22:57:24 -0700 (PDT)
Date: Thu, 12 May 2022 01:57:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Warn if MTU configured is too low
Message-ID: <20220512014128-mutt-send-email-mst@kernel.org>
References: <20220511105642.124806-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220511105642.124806-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: si-wei.liu@oracle.com, linux-kernel@vger.kernel.org,
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

On Wed, May 11, 2022 at 01:56:42PM +0300, Eli Cohen wrote:
> Following the recommendation in virio spec 1.1, a device offering
> VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> 
> Print a warning if this recommendation is not met.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
>   chage pr_warn to netlink warning to userspace
> 
>  drivers/vdpa/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 91f4c13c7c7c..0fb4a615f267 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>  				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>  
> +/* Recommended virtio spec 1.1 section 5.1.4.1 */

I'd add name of section here too.

> +#define VIRTIO_MIN_PREFERRED_MTU 1280
> +

Preferred is kind of confusing here. I guess you are trying to
say it's not mandatory but I don't think this conveys this information.

Recommended (matching text below)?


>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct vdpa_dev_set_config config = {};
> @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  		err = PTR_ERR(mdev);
>  		goto err;
>  	}
> +	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> +	    (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> +	    config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> +		NL_SET_ERR_MSG_MOD(info->extack, "MTU is below recommended value\n");
>  	if ((config.mask & mdev->config_attr_mask) != config.mask) {
>  		NL_SET_ERR_MSG_MOD(info->extack,
>  				   "All provided attributes are not supported");


Pity we can't include the actual value here, but oh well. At least let's
include the recommended value, we can do that:
	"MTU is below recommended value of " __stringify(VIRTIO_MIN_PREFERRED_MTU) "\n"


> @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>  	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> -	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
>  };
>  
>  static const struct genl_ops vdpa_nl_ops[] = {
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
