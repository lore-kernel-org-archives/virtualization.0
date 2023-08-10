Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41120C001DE
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 08:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9490F41A32;
	Thu, 10 Aug 2023 08:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9490F41A32
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1Vs3e2J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sdqmyiDqAoq; Thu, 10 Aug 2023 08:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C288641A05;
	Thu, 10 Aug 2023 08:54:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C288641A05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90693C0072;
	Thu, 10 Aug 2023 08:54:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9475CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6706282C2E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:54:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6706282C2E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1Vs3e2J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfFruRPKpGOU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:54:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80D7982209
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:54:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80D7982209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691657666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syF1yE0Uo9LWT8K9qVuNApPlR5YgTqMfG6lKK6clKkQ=;
 b=I1Vs3e2JxYmR1gGl+CH9IP2RPfrvHRVA52dgAYB17U69wrUUvPYmya1tH8PeVVPnNxqR4t
 CbLGkLp9jv2w8UlivEgNpJJJD5ngO68aLXkracFPnGpbsUon6dRFmSolhjl4AN8HuUuQGL
 RbfmoeQpUVzim9HTkQcZp1x4jz6lbak=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-u2-Swp--Mh2gvI-1VMJpMg-1; Thu, 10 Aug 2023 04:54:25 -0400
X-MC-Unique: u2-Swp--Mh2gvI-1VMJpMg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so54989666b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 01:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691657664; x=1692262464;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=syF1yE0Uo9LWT8K9qVuNApPlR5YgTqMfG6lKK6clKkQ=;
 b=DdKiqf17nPLSagxOIAbZHrXfbJG7VIr0KCY2RNxje7RVMZtBrm2pFeKEffnoQ+2YvG
 CAKSNAKcjLC3o5GrBwlku6bc2BxW3YoGhgXVG0wuq3uvbcC9VEI9jy26EaDPNoKadzgQ
 gaW3xmHJ3ZGIXLGT4xT/sR47qNTHpmMm/T2vHNIxlkzuybThcEsW6fa9UNeG74dY7XrG
 rBQIRvZGAELshVoqnIFZ2g+2X9W47tOp5SN2fnsMGQFGTuH9+VxF/BTNsw5dtQfhbypi
 +S9zItZdYWaemGzza3wJrZJlm77bP4qkftQ9uPnEJnUteTcM2OKrxw2/13hyAbeYttFV
 43kg==
X-Gm-Message-State: AOJu0YwXqG2R1C+kBvoYYU/IbzggO2X7IF1aRPJ6y4hqUURBOVXYS49n
 Bn0CN9iyw9yokSP5NT0fClz0nzfd6sBJ/jQfcfq4oU3oor+aa699PDNqATFM43VIQrGGdUyZFMo
 A/CQm5IInJcG2bQls3HgKxbhV23+zKtLLCxshbQW9Qw==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id
 jx27-20020a170907761b00b0099beca247a8mr1511606ejc.38.1691657664381; 
 Thu, 10 Aug 2023 01:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfoYcwfAed0pASymHc6kVO4/QGY/UY6jbAbQ1bPq1grl4/G73DT3oQNt2A8/r/JxJnzu6vQw==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id
 jx27-20020a170907761b00b0099beca247a8mr1511585ejc.38.1691657663865; 
 Thu, 10 Aug 2023 01:54:23 -0700 (PDT)
Received: from redhat.com ([2.52.137.93]) by smtp.gmail.com with ESMTPSA id
 p18-20020a17090635d200b0099d0a8ccb5fsm627267ejb.152.2023.08.10.01.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 01:54:23 -0700 (PDT)
Date: Thu, 10 Aug 2023 04:54:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
Message-ID: <20230810045328-mutt-send-email-mst@kernel.org>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 02, 2023 at 08:12:16PM +0300, Dragos Tatulea wrote:
> This patch series is based on Eugenio's fix for handling CVQs in
> a different ASID [0].
> =

> The first patch is the actual fix.
> =

> The next 2 patches are fixing a possible issue that I found while
> implementing patch 1. The patches are ordered like this for clarity.
> =

> [0] https://lore.kernel.org/lkml/20230112142218.725622-1-eperezma@redhat.=
com/


So what are we doing with this patchset? If we are merging anything
for this release it has to happen now.

> Dragos Tatulea (1):
>   vdpa/mlx5: Fix mr->initialized semantics
> =

> Eugenio P=E9rez (1):
>   vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
> =

>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +
>  drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  4 +-
>  3 files changed, 74 insertions(+), 29 deletions(-)
> =

> -- =

> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
