Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66683C61DB3
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1E0D61227;
	Fri, 27 Jan 2023 10:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1E0D61227
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P28M6Hx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lKba134YeKBc; Fri, 27 Jan 2023 10:30:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 584B160E4C;
	Fri, 27 Jan 2023 10:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 584B160E4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E479C0032;
	Fri, 27 Jan 2023 10:30:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36C99C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD54540153
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD54540153
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P28M6Hx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DspoTe_lOFq7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F7B84023B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F7B84023B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674815396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eca9c7qo8eB3nh6kdmgANWZsjB9aO/pdYCMOTO/h+eU=;
 b=P28M6Hx0SHBiTEHMs489TbHWZowPMzNhU9fmrh7VNSdWDQHvSg30KUDkvjiYGKFEKTLv0Z
 KwMMrQ0MYN55Z/lqClGb4FeGRMC7ubezLqzXp2xHTV1AUgGfW8xqUOfeUICNo8U2Nu5nRJ
 ZJsaw0t5ETclpxiL/tqjCbAfYCFkVBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-iQnawPG-N22OY7mPbWqsNw-1; Fri, 27 Jan 2023 05:29:53 -0500
X-MC-Unique: iQnawPG-N22OY7mPbWqsNw-1
Received: by mail-ej1-f69.google.com with SMTP id
 jg2-20020a170907970200b0086ee94381fbso3141442ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eca9c7qo8eB3nh6kdmgANWZsjB9aO/pdYCMOTO/h+eU=;
 b=YdJ9Oz3g5A+mySZPL226/RDWIirS8H0rEPROZf1VrOIhA7V6quYpbiZVke8hXzcsvh
 YPC/fMSKUgWGwJjQHEaQk+l8XFboaQQHVN9rGp/y1CLl/Y4PAwM877Pbqdtxxt3FUboK
 CAM4gWRNDQmB0STBNUA+3LKqZnnm6prVk/7GN7jh/LstHLmphWny00EQn4dKSVbZw65t
 WPQyzk96sFlTb/vkH5WROXnHRBMT4gmrXcwwWcom8oQ2KqEk4v4nUfI6ZSFlDaVaorV9
 ztr0lN3D6FtKurtnxWY/nyqEICioe7fBQr6j70CcR1tXhM2MQj1INQ1CVmoAVHy1KR9F
 EWgg==
X-Gm-Message-State: AO0yUKWDSLoOs+DhDu+NKrgJjpJfMx3w1APec2v/ad1jn7DiTl0sDHJ5
 zxlmqg2tSEiyDDhuRKnyLN3i9rcCHQuZ+ZHh2EwVEW8o4vtNzU+30GEbN6m6SweH+sVXlrl60Vw
 ztvdp1dkioCxrmBjqz4rTJ21szuWNMrpq1wqg2y6IZg==
X-Received: by 2002:a17:906:9d87:b0:878:4e6c:344e with SMTP id
 fq7-20020a1709069d8700b008784e6c344emr6281221ejc.43.1674815392032; 
 Fri, 27 Jan 2023 02:29:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+h10ut0cxRycIemYstJmoZPh215OT9jfPTJWRHWUR+m3SZgGBEvC96RhqS9Ea/kSTQvU7ogg==
X-Received: by 2002:a17:906:9d87:b0:878:4e6c:344e with SMTP id
 fq7-20020a1709069d8700b008784e6c344emr6281202ejc.43.1674815391832; 
 Fri, 27 Jan 2023 02:29:51 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 my20-20020a1709065a5400b00878465f059dsm1992805ejc.59.2023.01.27.02.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:29:51 -0800 (PST)
Date: Fri, 27 Jan 2023 05:29:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
Message-ID: <20230127052843-mutt-send-email-mst@kernel.org>
References: <20221223060021.28011-1-jasowang@redhat.com>
 <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
 <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com, hch@lst.de
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

On Mon, Dec 26, 2022 at 12:12:42PM +0800, Jason Wang wrote:
> > >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> > >       if (asid >= vdpasim->dev_attr.nas)
> > >               return -EINVAL;
> > >
> > >+      if (vdpasim->iommu_pt[asid]) {
> >
> > We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> > should be better to return an error, since this case should not happen?
> 
> So it's a question of how to behave when unmap is called without a
> map. I think we can leave the code as is or if we wish, it needs a
> separate patch.
> 
> (We didn't error this previously anyhow).
> 
> Thanks

OK I picked as is. Do we want WARN_ON maybe?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
