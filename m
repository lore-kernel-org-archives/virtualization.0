Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AEDC001DC
	for <virtualization@archiver.kernel.org>; Sun, 23 Jul 2023 09:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CF9C82285;
	Sun, 23 Jul 2023 09:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CF9C82285
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cNshD94a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9steX1MIbYJ6; Sun, 23 Jul 2023 09:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7F8482288;
	Sun, 23 Jul 2023 09:22:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7F8482288
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F94DC0071;
	Sun, 23 Jul 2023 09:22:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF55FC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9646660B8F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9646660B8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cNshD94a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWj-ddZ4_fqZ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:22:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DD8560B60
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:22:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DD8560B60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690104131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wjrc6TOLXArF64jzw4lnU3nwlr/kM5lUILDmXAhT2bQ=;
 b=cNshD94aBNgb7fwqyWxEkVBSoOVv+iyL6lZND8iG5YtwTiMUS0sFs1vz4UtHtvcSy4/x1B
 3XO+0dschz4YywaNwvRZcN5CIJCiUWnaCanu4SrDBY5afGFQXJIg3n3s6kD/mmDOFmtYcI
 71uKKWaTqPcBoBquwmmLCsjhgHpUcXk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Snh6mEL5P86sTYCung_TPw-1; Sun, 23 Jul 2023 05:22:09 -0400
X-MC-Unique: Snh6mEL5P86sTYCung_TPw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31443e13f9dso1710711f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104128; x=1690708928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wjrc6TOLXArF64jzw4lnU3nwlr/kM5lUILDmXAhT2bQ=;
 b=abNEDXNWT+IdlihuzPLMjSz3MnJadBaijFNyRIBI2deFqIBng2dzvXl+iibSF2NyZF
 Waxwa7TTpQzsJqA19zl8j/asHWdCj7t1Wd1wNpiwuiAhsWKNbaasQ+US1Fj51qky9XC8
 uyqKeWWzVA86jlnpdKStuANZxLzHtnvcD8+iVC1xDeQoIfRnA+K17v5CvFWRYVTwBYy6
 CTby5rPpGCQ3vMiqXgCohTHU0VPD12j+1MiemujPGjP9l2Cz4uW9ibAATeCW02EDAsQp
 Fu2Ms/5jZkXx4R0EtWTgMk3Nx5xoiw5NP97SfaQpv3bVFbcObRovYYdqDkAj80vZilqR
 KrKQ==
X-Gm-Message-State: ABy/qLbAMXnHpAk8WABl4xE+qZCITgVNfm2OBSDgau4VYWhApaT+xYw0
 HKFT6KQrf1s3Ma/xg3KCYroaFre3sFXU/FV5BueWloYSne1PnfsuIAGU2uP+aVQbLnjhuJpH+59
 sg4CgsDRHt+fPxF0EgRmBB1I+SbbhcZ+qLkeYQ70Hyg==
X-Received: by 2002:a5d:50c6:0:b0:317:5b5f:3348 with SMTP id
 f6-20020a5d50c6000000b003175b5f3348mr703719wrt.71.1690104128226; 
 Sun, 23 Jul 2023 02:22:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4VWdAF8sEgmxCXAx+NL/2ya4luKKVI/QrBQmHRwPdNIMT0zNeOjBSDEEZ20I/Pl78wcJHbA==
X-Received: by 2002:a5d:50c6:0:b0:317:5b5f:3348 with SMTP id
 f6-20020a5d50c6000000b003175b5f3348mr703703wrt.71.1690104127892; 
 Sun, 23 Jul 2023 02:22:07 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 q9-20020adfcd89000000b0030ae3a6be4asm9209312wrj.72.2023.07.23.02.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:22:06 -0700 (PDT)
Date: Sun, 23 Jul 2023 05:22:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230723050656-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20230723080507.3716924-1-linma@zju.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
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

On Sun, Jul 23, 2023 at 04:05:07PM +0800, Lin Ma wrote:
> The vdpa_nl_policy structure is used to validate the nlattr when parsing
> the incoming nlmsg. It will ensure the attribute being described produces
> a valid nlattr pointer in info->attrs before entering into each handler
> in vdpa_nl_ops.
> 
> That is to say, the missing part in vdpa_nl_policy may lead to illegal
> nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

Hmm.

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3773

** RESERVED ** This candidate has been reserved by an organization or individual that will use it when announcing a new security problem. When the candidate has been publicized, the details for this candidate will be provided.



> This patch adds three missing nla_policy to avoid such bugs.
> 
> Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
> Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

I don't know how OOB triggers but this duplication is problematic I
think: we are likely to forget again in the future.  Isn't there a way
to block everything that is not listed?


> ---
>  drivers/vdpa/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 965e32529eb8..f2f654fd84e5 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1247,8 +1247,11 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> +	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
>  	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>  	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
> +	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
>  };
>  
>  static const struct genl_ops vdpa_nl_ops[] = {
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
