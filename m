Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202A7C001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 06:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEAAB60FCC;
	Thu, 10 Aug 2023 06:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEAAB60FCC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+c79nOm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQUrKhkbysjf; Thu, 10 Aug 2023 06:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F33460B00;
	Thu, 10 Aug 2023 06:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F33460B00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F052BC0072;
	Thu, 10 Aug 2023 06:39:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5701DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E93781E36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E93781E36
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+c79nOm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-aRI8A7a_gu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:39:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C74E81D4F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 06:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C74E81D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691649594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22HFwMNskHBOB8y/dJtS9BqnPtSGN8PjvKQGJBr0IAM=;
 b=d+c79nOmZdYG540YsxGiFTBF/t4YH2kyi6GwBjvv5c8binl+mYlrZLlJsJcHkU774DYE2r
 MDYO7wWr6i1YWg11FxGsxeLdfNTPI0cl8tLNezR6dS6prEn+7X3Vf2zJfU4FQVuxu7iRPK
 m/Z47YmoABox/Jmi46mCT/EYSWrPL9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-LMEeNdPPPwKUgDXuQI-VKw-1; Thu, 10 Aug 2023 02:39:52 -0400
X-MC-Unique: LMEeNdPPPwKUgDXuQI-VKw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so3430575e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 23:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691649592; x=1692254392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22HFwMNskHBOB8y/dJtS9BqnPtSGN8PjvKQGJBr0IAM=;
 b=lKwCVHarnS2YS5NxQJrUNyUbSOmqTiCssTvirr5y42aHEB3AXseU7n5F8c1WaXGGmd
 dw1XYMLSCCI4L3NjT4pQf8y8DD/NfmsFf6HCIleZOq+j0/29dZ/74JMrknYgZic/fs12
 iHguTlhWK1NL1uG1NMZZ7CYoWCX1hiSvqmANtixr9fiQitbZNe9iMMEYvI7g3l2Hi1ok
 wHPKcwATzDrInKepRMyp3GZWEyHSAU9n7iELtbkfPJ94UmR4at6QCyZTvWMthrYp2Po4
 BFjgidgmKaphxYAr61tOqJhEr0G8Pvutz8cUZfi3o5/kPQ7O+lV7KDTLNarI3foV+vvp
 idrA==
X-Gm-Message-State: AOJu0YwyftNNPEUqWWU/q1j23/GpzhR41+sNSksAQBlkTxmHKrBNcnI/
 w5k/0eAWEABoF+XFXBhMlWGP+uZz44zEMSdFYcW3GxGPdlaXgSM7MEw3/0ZAxp9aSOgwrSCebf8
 N3RypkAWyCpC/Q5WwmyYrRrGnaeUMF/ZFY+DMDuX/zQ==
X-Received: by 2002:a05:600c:c3:b0:3fc:a49:4c05 with SMTP id
 u3-20020a05600c00c300b003fc0a494c05mr936414wmm.40.1691649591836; 
 Wed, 09 Aug 2023 23:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEybtnYNEhFJRufjXc6/kaGifm/ioS0+TszaHtLZfnLCZBBs3ACOUB1YaEr18zALjPpkTUGJg==
X-Received: by 2002:a05:600c:c3:b0:3fc:a49:4c05 with SMTP id
 u3-20020a05600c00c300b003fc0a494c05mr936399wmm.40.1691649591550; 
 Wed, 09 Aug 2023 23:39:51 -0700 (PDT)
Received: from redhat.com ([2.52.137.93]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003fbc30825fbsm1078877wml.39.2023.08.09.23.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 23:39:50 -0700 (PDT)
Date: Thu, 10 Aug 2023 02:39:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230810023253-mutt-send-email-mst@kernel.org>
References: <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Aug 10, 2023 at 09:56:54AM +0800, Xuan Zhuo wrote:
> 
> Ping!!
> 
> Could we push this to the next linux version?
> 
> Thanks.

You sent v12, so not this one for sure.
v12 triggered kbuild warnings, you need to fix them and repost.
Note that I'm on vacation from monday, so if you want this
merged this needs to be addressed ASAP.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
