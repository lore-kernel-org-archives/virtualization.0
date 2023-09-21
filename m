Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A716E7106C
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 13:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D6CF408DA;
	Thu, 21 Sep 2023 13:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D6CF408DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpYe4c6m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MG986zLKRY0; Thu, 21 Sep 2023 13:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E02124062E;
	Thu, 21 Sep 2023 13:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E02124062E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE5C8C0039;
	Thu, 21 Sep 2023 13:33:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF62C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0A2081D9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0A2081D9F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpYe4c6m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hP9jKB5gRRmK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:33:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D4FA81D73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D4FA81D73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695303200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISuC9AVqcaXixUkxtppp8LUjHO6shANtza8stDjTgo8=;
 b=BpYe4c6mc4GpgNJcjQwiWGK2UxxKh0QOEURIaVnUkX4J1PntHBfOO+uenr+4Cn2oLYkrBs
 cNDwirhKfrlYk5fhvYzxBQXRA7EXS/amqiHLAL046h+lT3Kvl5rhuX5zCbH0fQyzrOkfVY
 JF0s4/wcsOnxs0h8YjSL0ZZYgefevQ0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-32KpVUlgOE-JxLkLPCAp3A-1; Thu, 21 Sep 2023 09:33:18 -0400
X-MC-Unique: 32KpVUlgOE-JxLkLPCAp3A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-52fa763ad54so661791a12.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 06:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303196; x=1695907996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISuC9AVqcaXixUkxtppp8LUjHO6shANtza8stDjTgo8=;
 b=ouknciY9WQz1XYb6vN4oULguRTJgeIDE48tzc4UsoF8tfy8Mlvccwx5jaTyK2s5JyI
 kEq1pCjJH7zRSVYdzjiC0Z9vqjncQLXWx69x5PDpe/oi4P/k/qrfbnMy8tm0fu8FNoer
 9hiSXKLJV2l+8Q4f02CeAjmyZKwisArKYHhiz5RvCi8E9h1AUr5tW/5E+2ahD531gWyV
 giTdtwp3rTkTlYfmAib1pUspPC858TWLCHwL9GroYjwldocm3BckBDMw5h35uayePLZb
 eSvD79ATH9GKQdmE4EiHwuqM3Y3gRULbqxurJZyo8zfj+Jyq/nYBf9U9E51+nP1YnpPG
 H/pA==
X-Gm-Message-State: AOJu0Yy1PYaAH+G+nrtTnFU2qIik7eZ0j+lYBwLTPLRCRtS0m7DJ5nXU
 pC9A3Q5P0L8+sJW78qofzjluy6sYOKxOPUGYND/sLq0/xg2FVd02NZpXn8+UyQNXu1HH+lft19r
 5WKRfgoHqfM3HTdnc5e1JWgHw998HEkvGtTCTIOZNKA==
X-Received: by 2002:a05:6402:b36:b0:530:9fbc:8df6 with SMTP id
 bo22-20020a0564020b3600b005309fbc8df6mr4896869edb.2.1695303196390; 
 Thu, 21 Sep 2023 06:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWkySiLdgAdNKnLNCgYei8zh/ZPXT0tiKpgirtwwvkw7Ye5tlhji3W9LqtB9azmo8hjNyCeQ==
X-Received: by 2002:a05:6402:b36:b0:530:9fbc:8df6 with SMTP id
 bo22-20020a0564020b3600b005309fbc8df6mr4896841edb.2.1695303196047; 
 Thu, 21 Sep 2023 06:33:16 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 u25-20020aa7d0d9000000b0051e1660a34esm843110edo.51.2023.09.21.06.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:33:15 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:33:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921091756-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921124040.145386-12-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:40:40PM +0300, Yishai Hadas wrote:
> +#define VIRTIO_LEGACY_IO_BAR_HEADER_LEN 20
> +#define VIRTIO_LEGACY_IO_BAR_MSIX_HEADER_LEN 4

This is exactly part of VIRTIO_PCI_CONFIG_OFF duplicated.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
