Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F65C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 11:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A7BA4182D;
	Tue, 30 May 2023 11:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A7BA4182D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f91S2VjR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TdR--T_QJfSo; Tue, 30 May 2023 11:27:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2BDA4177B;
	Tue, 30 May 2023 11:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2BDA4177B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C14C0035;
	Tue, 30 May 2023 11:27:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E60EC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52E954074E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52E954074E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f91S2VjR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xn4RoUPanqAT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:27:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 975F1400F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 975F1400F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685446058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLpDIoY/l+ntuQOmsSqPPsSE7Zqi06pR85Bxwal7ZuA=;
 b=f91S2VjRYu+BUyywsSwGxjbibcVUUYZ4ocFvNjDgv+WNNzrGbjKdN/zUT7tEBXGoRMMYJK
 +PTCNGPlvyH8Ahtj6XrRn++pjraCJBZayAKXIO17etjiKkyIrbhEk7/ICWzOEvPT5MdO4J
 4N7NLchHRgvc3McI15Abhuwe2fGZZ/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-BtLErZDBNNGdDcVffKNdyA-1; Tue, 30 May 2023 07:27:37 -0400
X-MC-Unique: BtLErZDBNNGdDcVffKNdyA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-307897bc279so2337297f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 04:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685446056; x=1688038056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLpDIoY/l+ntuQOmsSqPPsSE7Zqi06pR85Bxwal7ZuA=;
 b=bZx4hgJTQcg1Oz0wPd8lhyLH9PeIsnmjpJBm0pZODpZkUCcEKC2H2BqUVyl07BNDb5
 l8+ssVVxdMwbTFeIZUs9Xdm9Zdiw6lwAHBl6lguu5sLQoO697qmHMfMDT4nFq+NDljaV
 7xxMLClw/le30MuhWHhK5NUgG3Angv77VgzzNMFgzp2Aozf3RKe6GUsOOkbHx9fxmZz9
 bsapIQzFJN8wJDR7a+L6uEUOgd08u9RXbq/UenFYBw9shUmwBqXhScrrMD6y6NxUOfVo
 WAp7bgx4XOVnMsAk1fJ2hW+jox1x6MtPDLyU2oK5B/U8QmeT3rHR9OLH0dztvIazm0iC
 /CWQ==
X-Gm-Message-State: AC+VfDy2XiLx/s05WkaKd89Nz6N5wOHrFg9jX79Wc80D4Lr7G1hzpLQ3
 D8Cqob+cKz+xrWAMLtM9uxsU8T9IID3BNPY2FbS8txMlkTFWHtxfuHU0/0lJrcETG233MZTZ7/+
 /mmI2qF4eP7bJVIcjBIZ8+tIRXoygcK0is163dynGUA==
X-Received: by 2002:adf:f2ca:0:b0:306:492c:cdd8 with SMTP id
 d10-20020adff2ca000000b00306492ccdd8mr1390218wrp.15.1685446056262; 
 Tue, 30 May 2023 04:27:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6v5lVt1G56Fy0lybDZAjjMJK+Gr1E7oNlpLtLUFw/azeFRVrAPkC2Zu+XN8ZsiAG0mKTRyEg==
X-Received: by 2002:adf:f2ca:0:b0:306:492c:cdd8 with SMTP id
 d10-20020adff2ca000000b00306492ccdd8mr1390202wrp.15.1685446055944; 
 Tue, 30 May 2023 04:27:35 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 e7-20020a5d5947000000b0030647d1f34bsm3014430wri.1.2023.05.30.04.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 04:27:35 -0700 (PDT)
Date: Tue, 30 May 2023 07:27:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
Message-ID: <20230530072642-mutt-send-email-mst@kernel.org>
References: <20230529181729.15745-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230529181729.15745-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jiri Pirko <jiri@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
> Fix code style related to including header file. Include header files
> before declaring macro definitions to avoid conflicts.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Which conflicts? These macros are there precisely to change
how the header behaves.

> ---
>  drivers/virtio/virtio_pci_modern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..b21a489e0086 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -15,9 +15,10 @@
>   */
>  
>  #include <linux/delay.h>
> +#include "virtio_pci_common.h"
> +
>  #define VIRTIO_PCI_NO_LEGACY
>  #define VIRTIO_RING_NO_LEGACY
> -#include "virtio_pci_common.h"
>  
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
> -- 
> 2.37.1 (Apple Git-137.1)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
