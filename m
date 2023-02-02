Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DDBC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B8AF40FE4;
	Thu,  2 Feb 2023 17:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B8AF40FE4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6y35i1L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B6GHtWYAro6D; Thu,  2 Feb 2023 17:30:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02A98405BE;
	Thu,  2 Feb 2023 17:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02A98405BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0026C0033;
	Thu,  2 Feb 2023 17:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6ECEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81A7F40CF2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81A7F40CF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IOIoss_y59Q8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A703A405BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A703A405BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675359051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYKqs3MjGl7TQ1cHEqSG5d8XiBUPJ2VDaeFs07Gxf5M=;
 b=U6y35i1Ld8ySA5LIvYGHTvg6RlUMnqOXtvrYxiENbTu92DEJmkXNK1ltlZJd9e8h3HVkI8
 W19r/hXbA9L6/Yx5aSpANVKNtXBb289voqc+BqH77ka2x2UfLgB+107yp851KLP9ZgNz0n
 B98VMmEzZiGCCOgGtoQ3GfktLaMXri0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-TfTyArD9PhKQz_zuhGEddA-1; Thu, 02 Feb 2023 12:30:50 -0500
X-MC-Unique: TfTyArD9PhKQz_zuhGEddA-1
Received: by mail-ej1-f71.google.com with SMTP id
 ud13-20020a170907c60d00b0088d773d11d6so1981113ejc.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYKqs3MjGl7TQ1cHEqSG5d8XiBUPJ2VDaeFs07Gxf5M=;
 b=bTIT+1FNXrTI1lqw+Sf4gnVBVOyF5py/XLdeCAcKI7IomCB2wxjFkd77RURbVHLQp4
 2hEgRdZkQEUcu1mmMlx154d+7mWAfGtOQXQmcQaofwkAU6hAzeZKrC8aJsyUj/y0RxXA
 s0jo6bAMcv7I4VrOOHMkijDtMRAeV9AHPCg9bEq4v/nv9na/g+QnShiVCd9Syuz49Dq7
 lremet9wuQqdcolxOrd6jqedNosmcf+mEtWMxy8jw7Uwq8fwaMZRoDPrHi1ievphVQ8O
 giajOwPjznAzhSbD8GP+bwutT4ZHMLpBW2fjOe0gS4I7r89toWowEBCJxIDk6YggZasS
 pRVg==
X-Gm-Message-State: AO0yUKVYI4d+FiFod9C2U9qZ+kSPR88sBOq8xkRrLMr3qz53/yPpi754
 pDgK1v8WGu1UxXIxZWIjO0ENmfdXzqZfMVJu51CfbM1PgOXQzaPk2jcYfMlWsWg6YvFLYDg+ppQ
 exQZ3j4sfueqvvOgfLTBefiY/Jt7CJahwSp5bqGM2HQ==
X-Received: by 2002:aa7:d54c:0:b0:4a3:43c1:8441 with SMTP id
 u12-20020aa7d54c000000b004a343c18441mr2229030edr.21.1675359049157; 
 Thu, 02 Feb 2023 09:30:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/8iTLbXbQv+s/UGj22Gc8lXgPP1ENSohhV651rdA6zrWZf+Ya3iBnFyTnbDxf3sgsW2UZ+Dg==
X-Received: by 2002:aa7:d54c:0:b0:4a3:43c1:8441 with SMTP id
 u12-20020aa7d54c000000b004a343c18441mr2229020edr.21.1675359049002; 
 Thu, 02 Feb 2023 09:30:49 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 a16-20020aa7d910000000b00463bc1ddc76sm11448795edr.28.2023.02.02.09.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:30:48 -0800 (PST)
Date: Thu, 2 Feb 2023 12:30:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/6] features provisioning fixes and mlx5_vdpa support
Message-ID: <20230202123024-mutt-send-email-mst@kernel.org>
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, elic@nvidia.com,
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

On Tue, Jan 31, 2023 at 03:22:01PM -0800, Si-Wei Liu wrote:
> This patchset is pre-requisite to export and provision device
> config attributes and features for vdpa live migration, in a way
> backward and forward compatibility can be retained. The follow up
> work [1] will need to be built around the new feature provisioning
> uAPI, with which it's easier to formalize migration compatibility
> support at the driver level.
> 
> Thanks,
> -Siwei
> 
> [1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
> https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/

1-6 look like bugfixes right?

> ---
> 
> Si-Wei Liu (6):
>   vdpa: fix improper error message when adding vdpa dev
>   vdpa: conditionally read STATUS in config space
>   vdpa: validate provisioned device features against specified attribute
>   virtio: VIRTIO_DEVICE_F_MASK for all per-device features
>   vdpa: validate device feature provisioning against supported class
>   vdpa/mlx5: support device features provisioning
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 72 ++++++++++++++++++++++------
>  drivers/vdpa/vdpa.c                | 98 ++++++++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_config.h |  8 ++++
>  3 files changed, 149 insertions(+), 29 deletions(-)
> 
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
