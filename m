Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B31C6FD18
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 16:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 737F560AB2;
	Wed, 29 Mar 2023 16:28:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 737F560AB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bAlc681h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IhgLK4HAqguN; Wed, 29 Mar 2023 16:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B22860B1C;
	Wed, 29 Mar 2023 16:28:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B22860B1C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2361C0037;
	Wed, 29 Mar 2023 16:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69DF5C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37CDD60AA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37CDD60AA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QfyfnAc_yyBM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:28:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83DA560585
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83DA560585
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680107298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RNV3SNYYIlFYMBuhq2GEFacMvzVUMzJmv6WI/yLqIc=;
 b=bAlc681hfP1LsrVRWkP/OXQ6Xr80mLuMceYv9LWqpxIwW4cYUazx/9AmKr+Lg1NbdEw0iT
 /5XE3YeRbzb7eI9KEGJ+uRf+igVVkAMopxMsvU14KfBDkC8b1TSubVGTCTn1goZ1C33ZH0
 ZPXo2AQ7yXjr3J/iEx7gTMplw1f4+XY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-QpUs19prNK-2HO0BgoE3fw-1; Wed, 29 Mar 2023 12:28:16 -0400
X-MC-Unique: QpUs19prNK-2HO0BgoE3fw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v7-20020a05600c470700b003ef6ebfa99fso5097385wmo.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680107296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RNV3SNYYIlFYMBuhq2GEFacMvzVUMzJmv6WI/yLqIc=;
 b=E4dIh8nkXR3+IdT/HB1Y6CQOIYSo3Zu7NbuLnuxE1K47d5O9aEhm8SrR9hXRL0zD5r
 tlG5YTKO7dguWz1pPIR3BAHPvl3twXuKeeA/FbbMiq8wtZ5R0dUs3rmDZHPdzd+RkVOd
 YiIgMNAr6lrZd6Lg2ecgFwRBP2tYhadvO2kHl6P75I9aLEoapQxAuCRFNAgJEsZNw4jK
 BEMlH6qYJEE8vHpcLe2xb/MoW810U8siNBo6m3V2eCdFzuOy1jm1merpC0VmPgrkslRv
 7FHWoIYno6lWgBrbwPTorUiPXp0NWWOi9TC+DP6PuxvrgrfRiSEN1+0/ySDpFyL2nQB0
 owLQ==
X-Gm-Message-State: AO0yUKXz8GHKrKRCSNkOsFVSRpqg1OMbk7p4HdQX+ENLMsNS5HOc2pj3
 bs7I//+JW7iBvKb1Nemp4JEd91BfzENA8gKCmAPOK/XWGpW883Cl8fKSGzX5ToLwWuFQvIu+mOX
 pcW/w4Rz+m7aO9aKMv/Mtaruv7t4xbgS+E4KLXg5kkA==
X-Received: by 2002:a7b:c7d1:0:b0:3ed:8bef:6a04 with SMTP id
 z17-20020a7bc7d1000000b003ed8bef6a04mr15658430wmk.27.1680107295866; 
 Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set90/PaRSiGbUWRt/zderMMHrDvZtjT5MLaNI2vgj2wXzhqKQt862wm81Ijxg7RKvcOyXxWThw==
X-Received: by 2002:a7b:c7d1:0:b0:3ed:8bef:6a04 with SMTP id
 z17-20020a7bc7d1000000b003ed8bef6a04mr15658418wmk.27.1680107295568; 
 Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 k20-20020a7bc414000000b003ede3e54ed7sm2767779wmi.6.2023.03.29.09.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 09:28:15 -0700 (PDT)
Date: Wed, 29 Mar 2023 12:28:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329122727-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
 <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
 <20230329012908-mutt-send-email-mst@kernel.org>
 <20230329072135.44757-1-huangjie.albert@bytedance.com>
 <1680074823.805977-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1680074823.805977-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Albert Huang <huangjie.albert@bytedance.com>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 29, 2023 at 03:27:03PM +0800, Xuan Zhuo wrote:
> Maybe one new thread is better.
> 
> Thanks.

I don't know but do not post same message twice please
without explanation. if you repost put "PATCH repost" in
the subject.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
