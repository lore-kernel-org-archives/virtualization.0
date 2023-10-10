Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA66CD98C0
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 20:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B2FB60FBE;
	Tue, 10 Oct 2023 20:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B2FB60FBE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbzoRBc8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QBcGA3e48Q6i; Tue, 10 Oct 2023 20:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C53A612F8;
	Tue, 10 Oct 2023 20:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C53A612F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70272C0039;
	Tue, 10 Oct 2023 20:42:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2611C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB33580C98
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB33580C98
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbzoRBc8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNp2_dUr83zX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:42:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0331C80C00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0331C80C00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696970547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1XkdVIAATRQKg7AHNfv10yktqcK0FF54adD52mLpgs=;
 b=LbzoRBc8Sw8rT0GQhlbc0WUiW4SqHWS71j6oNMcitG3OI+OZkN8DwXqhkORgteC5iR4qeH
 aLKS5Quk9Q71S+nsVgivnCpSUpooeod3xzUoQwE2tpzDtvHewyIZFAH3+sxXANvReMeZ97
 JItqnUN2h4dFIQik1M03/JTCh7YLDg0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Lp4YrszvMuSWTy8qPc_-nw-1; Tue, 10 Oct 2023 16:42:25 -0400
X-MC-Unique: Lp4YrszvMuSWTy8qPc_-nw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32480c0ad52so4550355f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696970545; x=1697575345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1XkdVIAATRQKg7AHNfv10yktqcK0FF54adD52mLpgs=;
 b=PsVoRr3z3oSwV+h7tnKcxGIPIlqxu/Pxlreq5Up2mSSDutkeGFvGzcZChIa8yb4Chc
 W17zOEBduqGE5uS4O6m1Sm61twXtmuE3gT3h4Y3T0J6s3cSxfgyIvL/RYVu0uY3oeExQ
 JhlgWJWjyGevnJVOF8pkOgSn8FnaN+2EWElh/S7n1tWcho7I/l4rE6kuGSkz+cHn6Ur+
 LoGN7EfK1m5mNHktFf5jTIoot0iJWhQtWuwyrX5JCD0X55yHBbLQysNu/a+C+zOgWqzB
 XuZsVe3sMwfI1hsSVEtAo9NYgl1YjcuF553oTNJl0gR22kwIMn/07DiWtL4I3cnrk58W
 nCjQ==
X-Gm-Message-State: AOJu0Yx/7h/eUCaQTmf+Kgns+MmtkEd9wzZLahH/TPmjt2AdVtv4/jh0
 QuWFhh6zS94A6tRbOn4OE9P5qx6ZNQA12wKlHHwAdCtW2CjoT5rNsfS+RcJm6KjfDicCRLeKVOT
 LTfIfiZdZBoMAqgBjVgpisivWgKEOPNQ2GpyeJriJfQ==
X-Received: by 2002:a5d:4d8e:0:b0:324:7bdd:678e with SMTP id
 b14-20020a5d4d8e000000b003247bdd678emr15652317wru.60.1696970544814; 
 Tue, 10 Oct 2023 13:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqZyOhpPTeTKIlWFJfesH3VsxsWpp8rcGB8D55JEJraH8fvsymNK3DJLM+P5GzXRJP2B4zPQ==
X-Received: by 2002:a5d:4d8e:0:b0:324:7bdd:678e with SMTP id
 b14-20020a5d4d8e000000b003247bdd678emr15652301wru.60.1696970544527; 
 Tue, 10 Oct 2023 13:42:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 r18-20020adfe692000000b0031912c0ffebsm13563615wrm.23.2023.10.10.13.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 13:42:23 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:42:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010163914-mutt-send-email-mst@kernel.org>
References: <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 07:09:08PM +0300, Yishai Hadas wrote:
> 
> > > Assuming that we'll put each command inside virtio as the generic layer, we
> > > won't be able to call/use this API internally to get the PF as of cyclic
> > > dependencies between the modules, link will fail.

I just mean:
virtio_admin_legacy_io_write(sruct pci_device *,  ....)


internally it starts from vf gets the pf (or vf itself or whatever
the transport is) sends command gets status returns.

what is cyclic here?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
