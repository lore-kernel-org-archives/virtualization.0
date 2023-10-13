Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66410CDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 13:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA30761504;
	Fri, 13 Oct 2023 13:50:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA30761504
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gZj2BenX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szncE9ONfymr; Fri, 13 Oct 2023 13:50:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4B3661028;
	Fri, 13 Oct 2023 13:50:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4B3661028
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9812BC0039;
	Fri, 13 Oct 2023 13:50:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54DCFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 13:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 292F781F4E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 13:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 292F781F4E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gZj2BenX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6Lc1xLjvK4r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 13:50:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D797981E31
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 13:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D797981E31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697205031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+Ghitg1zY89Jip2T1goMJnTgMi5VDf/XGEOeNsAVBs=;
 b=gZj2BenX7JkcOb6BN2PdDAgYzYhPTZe773pRkZElT1q7YbMnmQx8fJhuj6kQcFxvvF/nTm
 M4IxLvRuG7CK3ScoVL7eXBDYpCZU8w7Zn+5ibqNtpiGCVYskIjDb6oip8zh4Sn+8ZURODH
 Lpqrr64uwTdlAOzvH2kdTONLAmmrVnE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-C8RB0kPRPTmKayPGs_8MYg-1; Fri, 13 Oct 2023 09:50:30 -0400
X-MC-Unique: C8RB0kPRPTmKayPGs_8MYg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so1000168f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 06:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205029; x=1697809829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+Ghitg1zY89Jip2T1goMJnTgMi5VDf/XGEOeNsAVBs=;
 b=hTPsBEf7FMqqv0kjkR05eRhZBM8h0oUd3rhTDX6+oLcS3gxwLUoEvXUSXBy0yDbbbj
 15qMsTCWPn8YpkG8ZB9GWHs1grJLu9rNQh2efOWDgHyOy/yfTM9damZlXBL2ouaKpVMM
 5p0Z0XNiZdbY7pgTSTLkUVjXvFPSxFmpTdQTDrK3k7c/s0dCMfjRlDOL+LDsQ7u4RIOy
 xcWpb3NbVoCJ1lYNGjum7wq4Ctvvlz/t126W4U0Yni2oUVV43jt+cgKPbUxQx2n/Anxl
 dGNaosiPRDXRua0A51elFMOkW3kOKlwbePicbWKaUo9PMZAzOxKOjr3uFnJwp7iD7fAG
 binQ==
X-Gm-Message-State: AOJu0YyvCgj6Lnetb9HlJTaJJcqPvMm3U3xTHvNaINzvXxdBZlr+NNi1
 pspZclBjCk7IbHfQP5GTOA/QdsQNKrBnavMVjv1JLghHp4lj8DHE2eGpGMf1fMasY8jeDvnndVH
 1G9Vmw637gUdX6G1TiWnb+tvXAvLrdy7CL9jsyobnsA==
X-Received: by 2002:adf:e412:0:b0:319:5234:5c92 with SMTP id
 g18-20020adfe412000000b0031952345c92mr120251wrm.35.1697205029103; 
 Fri, 13 Oct 2023 06:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy51rKDdAxtUym1VLRrNj6iWl5I9WPsUhrr6dkM69Wf9Z+UOFeOueRGKhYYJIybHTT8hScQQ==
X-Received: by 2002:adf:e412:0:b0:319:5234:5c92 with SMTP id
 g18-20020adfe412000000b0031952345c92mr120230wrm.35.1697205028759; 
 Fri, 13 Oct 2023 06:50:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:cf7d:d542:c2ef:a65c:aaad])
 by smtp.gmail.com with ESMTPSA id
 q14-20020adfcb8e000000b003296b488961sm20135825wrh.31.2023.10.13.06.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 06:50:28 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:50:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231013094959-mutt-send-email-mst@kernel.org>
References: <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
 <20231012132749.GK3952@nvidia.com>
 <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
MIME-Version: 1.0
In-Reply-To: <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
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

On Fri, Oct 13, 2023 at 06:28:34PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 10/12/2023 9:27 PM, Jason Gunthorpe wrote:
> 
>     On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:
> 
> 
>         sorry for the late reply, we have discussed this for weeks in virtio mailing
>         list. I have proposed a live migration solution which is a config space solution.
> 
>     I'm sorry that can't be a serious proposal - config space can't do
>     DMA, it is not suitable.
> 
> config space only controls the live migration process and config the related
> facilities.
> We don't use config space to transfer data.
> 
> The new added registers work like queue_enable or features.
> 
> For example, we use DMA to report dirty pages and MMIO to fetch the dirty data.
> 
> I remember in another thread you said:"you can't use DMA for any migration
> flows"
> 
> And I agree to that statement, so we use config space registers to control the
> flow.
> 
> Thanks,
> Zhu Lingshan
> 
> 
>     Jason
> 

If you are using dma then I don't see what's wrong with admin vq.
dma is all it does.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
