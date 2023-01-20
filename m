Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6F7C27C7C
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 11:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CEA2404D4;
	Fri, 20 Jan 2023 11:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CEA2404D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gwNXb6+v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ujVuwO6VD_Rq; Fri, 20 Jan 2023 11:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0778F401A1;
	Fri, 20 Jan 2023 11:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0778F401A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D92B0C0032;
	Fri, 20 Jan 2023 11:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DF4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 11:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1C5341C2C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 11:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1C5341C2C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gwNXb6+v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgxYspvk8jXx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 11:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41ED141BC3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41ED141BC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674215746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xSseqynolRz7PSqM1s8S1KWufbOig9tOH/7xArRYSoc=;
 b=gwNXb6+vkxvE6WGhGpEFwb3s6iRFZJEexhqIkylKlRTP38ATL4IoDpRd8UkA1vRctSfQVX
 220YDwLWedMi2S3bs6NY4tXQMTHpM49PNSVSKKyw4m3SQYNZ8qbp+05KL/L6DDhpwZLb+u
 G0iE3afQBlUYHQ0DpPBLyN6pdLa+spo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-BrAsNZBEO06E9XnjXz1hHw-1; Fri, 20 Jan 2023 06:55:44 -0500
X-MC-Unique: BrAsNZBEO06E9XnjXz1hHw-1
Received: by mail-wr1-f69.google.com with SMTP id
 d27-20020adfa35b000000b002bc813ba677so915237wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 03:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSseqynolRz7PSqM1s8S1KWufbOig9tOH/7xArRYSoc=;
 b=kETnfne/q+E/9Ul4UcmCUBg/0wxHtq6mz8fNmXlNOjm9FaAJ2zd5HgIZ4RmC1Z/zie
 B3oIALY1O4eIvzvuH6sLd7EQJMzov1txE4UcMWIA5wjg0P9GP3cg5vCSvSvk+PyRJZ/I
 kOG9a5SXzwlzP/+FFYMLxtzCOXGHra4lel/5YYCeL9VpKxVJxXamxK4pjjcWZaBUhiJF
 s6wxkMcGErodEFd9uqjNOb4jErflpeUmLYVN/oKC84NLAcq8PCDoto3wXlGenihnNXC3
 V3hjJDGrWZNFOBfTVj0iLh6jdTrGNRmxHCK+3x49Xhhhn97Edcj7sKl46yYinVdkjPXo
 ugQQ==
X-Gm-Message-State: AFqh2kohseZ1oiXgRRNm1tPbiABQS7N7Hz/Rf6sTNOsbS92RYpp6wzA7
 Va9iI75PVcmeQELGFBNMyL5YEIiNnNGY7Faiw54qDu/v3+ccdyukXjqa9E9MtphqdmbqnbTdw0b
 prwFGaHbS1cQy5+cUbHTCTtHsIkmFFiTADCjPMHV4Dw==
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id
 n26-20020a05600c181a00b003d220439cbfmr13938711wmp.10.1674215743597; 
 Fri, 20 Jan 2023 03:55:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOcvaB+LCHhfsBeCZmk1/bVqC5w78IurqnA4dYjWOnrtFroLGFV2PoZ6naZCe1IposyXGIiw==
X-Received: by 2002:a05:600c:181a:b0:3d2:2043:9cbf with SMTP id
 n26-20020a05600c181a00b003d220439cbfmr13938687wmp.10.1674215743276; 
 Fri, 20 Jan 2023 03:55:43 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c314b00b003db2e3f2c7csm3089265wmo.0.2023.01.20.03.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 03:55:42 -0800 (PST)
Date: Fri, 20 Jan 2023 06:55:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 0/6] Harden a few virtio bits
Message-ID: <20230120065402-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
 elena.reshetova@intel.com, virtualization@lists.linux-foundation.org
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

On Thu, Jan 19, 2023 at 03:57:15PM +0200, Alexander Shishkin wrote:
> Hi,
> 
> Here are 6 patches that harden console, net and 9p drivers against
> various malicious host input as well as close a bounds check bypass
> in the split virtio ring.

Hardening against buggy devices is one thing,
Hardening against malicious devices is another.
Which is this?
If really malicious, aren't there any spectre considerations here?
I am for example surprised not to find anything addressing
spectre v1 nor any uses of array_index_nospec here.


> Changes since previous version:
>  * Added Christian's R-B to 3/6
>  * Added a speculation fix per Michael's comment on the cover letter
>  * CC'ing lkml
> 
> Alexander Shishkin (3):
>   virtio console: Harden control message handling
>   virtio_net: Guard against buffer length overflow in
>     xdp_linearize_page()
>   virtio_ring: Prevent bounds check bypass on descriptor index
> 
> Andi Kleen (3):
>   virtio console: Harden multiport against invalid host input
>   virtio console: Harden port adding
>   virtio 9p: Fix an overflow
> 
>  drivers/char/virtio_console.c | 19 ++++++++++++-------
>  drivers/net/virtio_net.c      |  4 +++-
>  drivers/virtio/virtio_ring.c  |  3 +++
>  net/9p/trans_virtio.c         |  2 +-
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
