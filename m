Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C4C5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 10:16:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C291B2223D
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 10:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GswmCO5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C291B2223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4211187028;
	Wed, 18 Nov 2020 10:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y18uqnaPmukK; Wed, 18 Nov 2020 10:16:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AFAE486631;
	Wed, 18 Nov 2020 10:16:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A7DC0800;
	Wed, 18 Nov 2020 10:16:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95C89C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 10:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 842A184A6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 10:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RHzYZWtjyDJo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 10:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F301084961
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605694584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yed5/d7vK7YdqC5lhdZVNcPCr3eQRtrjIPPe/s03Tno=;
 b=GswmCO5fFCyhwJqg5yIO+mnYY5WCzFMAeurmgZjWbb7lb46Q0vPhAU7bhV9g8CqkeMOoPM
 lxq1c1hbJLPglUXz/D+jHMlm+X51NFiQAY6yxeMkV6G3Fm/AM8djAc4Tapv42XAXVFgJrk
 lc3Av2VAeQxQW8knr7fMeF5GKsYnzrE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-mrIS2P-vP9i3II9IhOm_NQ-1; Wed, 18 Nov 2020 05:16:23 -0500
X-MC-Unique: mrIS2P-vP9i3II9IhOm_NQ-1
Received: by mail-wr1-f71.google.com with SMTP id n4so728263wrt.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 02:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Yed5/d7vK7YdqC5lhdZVNcPCr3eQRtrjIPPe/s03Tno=;
 b=hMZEQ5+l+bouVofAzazhG1AKFemZ8tKiJT2Q/meAfE3gSPIVaodKBu4CPQGb1aDPBH
 ML0mzLPYlUC2MxysZiDNEHVe4+yGnEevESSu1b15Gnxk7r05asl8RRZIaCm1nowM0qer
 2uicOQJBvuJDUxQyUqH/UzThVJAIGLrwoCaMo2FSwf4jZx4dkmUxBbLdoOpHBcRPcHnF
 KCDlSHxvaRpn1ysui5u8A0S5L2l+7eiFb93ODLWNc4XxzhAJluIXG/yqwaXeeiTrkb8k
 V821edxS0L5O6UP5XJ5PHTDgBH3mlUQqtgSj3TADnVOVJpmxu0VqF/frWG4TTzjRcRQg
 Xslw==
X-Gm-Message-State: AOAM5327axEl4VZUMtkrTcYlvtAetf3DnAR4yHFn6xmmvCowJYE7FDvf
 q9j9IY/xEMCAQ6Y2sn9xZViTdPz2G4cVne7UhoxnQzFkYmdccGUDNvv6fMCv9khCUNWyLTYqkVZ
 yp9Iqx9LgwYs7Yv/95LK5mIi8T7vXx+DQP7HJW6/EqQ==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr3793833wma.105.1605694581848; 
 Wed, 18 Nov 2020 02:16:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8gTvwJsFF5o43oH2YetHhRlLDl2RZsi15AIAqwyAVp6G3xTEHw8/0j0DSSSEDTs/utrvImA==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr3793798wma.105.1605694581613; 
 Wed, 18 Nov 2020 02:16:21 -0800 (PST)
Received: from redhat.com (bzq-109-67-54-78.red.bezeqint.net. [109.67.54.78])
 by smtp.gmail.com with ESMTPSA id
 b4sm2360517wmc.1.2020.11.18.02.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 02:16:20 -0800 (PST)
Date: Wed, 18 Nov 2020 05:16:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201118042039-mutt-send-email-mst@kernel.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
 <ca183081-5a9f-0104-bf79-5fea544c9271@st.com>
 <20201116162844.GB16619@infradead.org>
 <20201116163907.GA19209@infradead.org>
 <79d2eb78-caad-9c0d-e130-51e628cedaaa@st.com>
 <20201117140230.GA30567@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20201117140230.GA30567@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Alexander Lobakin <alobakin@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 Suman Anna <s-anna@ti.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, Nov 17, 2020 at 02:02:30PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 17, 2020 at 03:00:32PM +0100, Arnaud POULIQUEN wrote:
> > The dma_declare_coherent_memory allows to associate vdev0buffer memory region
> > to the remoteproc virtio device (vdev parent). This region is used to allocated
> > the rpmsg buffers.
> > The memory for the rpmsg buffer is allocated by the rpmsg_virtio device in
> > rpmsg_virtio_bus[1]. The size depends on the total size needed for the rpmsg
> > buffers.
> > 
> > The vrings are allocated directly by the remoteproc device.
> 
> Weird.  I thought virtio was pretty strict in not allowing diret DMA
> API usage in drivers to support the legacy no-mapping case.

Well remoteproc is weird in that it's use of DMA API precedes
standartization efforts, and it was never standardized in the virtio
spec ..

> Either way, the point stands:  if you want these magic buffers handed
> out to specific rpmsg instances I think not having to detour through the
> DMA API is going to make everyones life easier.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
