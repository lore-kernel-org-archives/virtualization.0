Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CAECDB46A
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 17:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47D74403E7;
	Wed, 11 Oct 2023 17:05:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47D74403E7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I5FFcUno
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3iE_8zMCf-Xa; Wed, 11 Oct 2023 17:05:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23BC740280;
	Wed, 11 Oct 2023 17:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23BC740280
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDA88C0071;
	Wed, 11 Oct 2023 17:05:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD1FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2135A81DE7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2135A81DE7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I5FFcUno
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzIcrlGO7Vuj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:05:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 677D581D02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 17:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 677D581D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697043940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1brdHaYQR/1KT6dTzx9XTkLz90qgniDtBGmYHkS7B4=;
 b=I5FFcUnodOC16XoMNiXhFRe2ebrz+frPvXw5MpmwVN0Z1oprVAWzDuJ5JBGbVZNb9ykh4u
 gSWrGbC9mv4Oo3Z+36KXlOchLo3WsXlTzdl9CujZ0y0D0QIjpWfO6Fhad7BBjjHLSQcUcR
 t1CayPbnOFy+H+w7XwryMulkG+KwHGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-dYnj7AtKOFqQxQol5_e9sQ-1; Wed, 11 Oct 2023 13:05:33 -0400
X-MC-Unique: dYnj7AtKOFqQxQol5_e9sQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so731775e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 10:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697043932; x=1697648732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1brdHaYQR/1KT6dTzx9XTkLz90qgniDtBGmYHkS7B4=;
 b=CNJpSZgpzc0AboMxoiNOQNlHdEcRkmVVkuna9W+tP3nSPfcFcpkAvSvI+S4qlA2iuR
 ZOrXRXIRPXiAxUHtQ9xFDLYTMGe/Td5JjSanHby14i2gqpbXUOAc393RRb4rGV1yZJEg
 MCgkZ8gsDgnwV3etrGXjXPdLIHc5AeAWe43TI5KE4j6IIgH3796efpVPGNESlMNmEst8
 /mEtErumE+S2PvbImitYYQEmrQTR0lIwQno1q8Vjqp97wuecBvukkDfheTketUj+PcRC
 9M6jWVRdQAfxd26sDew3RgL68+O+sxiaGmEdvGGWK1eBuowFMF177EkFEVcrOruRRWEi
 AEcA==
X-Gm-Message-State: AOJu0YzjC31P/yqRhBXu8AyS4IfPMd1nBoD8696qBN1LxLn5XAXbZkGU
 AnYDBCSyswh+6ScToQm3Qz4eDRc6VARpxRb/al7qg8LZYTHeCtqjxgNIcMkWig8Ris+Ua3KK6sj
 zEVQDRO6+jG4Y3qnrojcFT9xG7+v+3dSe2do4J4XsWw==
X-Received: by 2002:a05:600c:b49:b0:406:7232:1431 with SMTP id
 k9-20020a05600c0b4900b0040672321431mr19337293wmr.33.1697043932505; 
 Wed, 11 Oct 2023 10:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkP7tKH7rx3WNL++lr4xFcEO49W8z8lrIDi+0WNMmcJnSlIasAGIk0kmgIQ5uKwF989mkFhg==
X-Received: by 2002:a05:600c:b49:b0:406:7232:1431 with SMTP id
 k9-20020a05600c0b4900b0040672321431mr19337264wmr.33.1697043932189; 
 Wed, 11 Oct 2023 10:05:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a5d6345000000b0032326908972sm15811545wrw.17.2023.10.11.10.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 10:05:31 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:05:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011130317-mutt-send-email-mst@kernel.org>
References: <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231011040331-mutt-send-email-mst@kernel.org>
 <20231011121849.GV3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231011121849.GV3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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

On Wed, Oct 11, 2023 at 09:18:49AM -0300, Jason Gunthorpe wrote:
> With VDPA doing the same stuff as vfio I'm not sure who is auditing it
> for security.

Check the signed off tags and who sends the pull requests if you want to
know.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
