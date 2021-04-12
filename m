Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:00:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8BA61244
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8BA61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35EDB403C9;
	Mon, 12 Apr 2021 09:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t0vXwbkjQDMK; Mon, 12 Apr 2021 09:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61702403D0;
	Mon, 12 Apr 2021 09:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5C3AC0015;
	Mon, 12 Apr 2021 09:00:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B527BC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A302A6061A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dtPLD6zybrU1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F19C605CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618218041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RO2S6yuC/fkuz9B4sqL4SZHXLtN0NgAiJyds25neUik=;
 b=F65/dqilpIY3dlFhHJlfBUHtCJO1etStPCYwuddmqfDQGG5O+sQpdBkHB5Xh+u4A8e2a/U
 r2nWNgUeYXc3OxjPm/WekCHtspMVuMidT9jHx0Lc0kCn8DyvXGDiSbSD7JZcGCoK2AovBb
 meM4Trhdu4hmSh4SZpLKdIUABhoOX3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-PBMrDCnRMHajqJoPMkmctA-1; Mon, 12 Apr 2021 05:00:39 -0400
X-MC-Unique: PBMrDCnRMHajqJoPMkmctA-1
Received: by mail-wm1-f69.google.com with SMTP id p11so328515wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 02:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RO2S6yuC/fkuz9B4sqL4SZHXLtN0NgAiJyds25neUik=;
 b=jLiZFXTPHLX2ftrJO5KlicnW9DQ1m7VXEz+iXDblT4DAbzOCFRKhQ7KJWOF5zHoewm
 2A5paiw4GEEHxSR3emJNff/3WuJaJvsGlIWYomyU8jPFLaPZfq3LTUwqV54Fy2GOx7Kf
 RaH1Iss4Rzxtke0Ie65qwY5nxcGkL21I1zcomcAkLnHe0b7ke2vVDp7QvcRkfUUDNTny
 viK5VuF6NBgOnbXZ9+Y2hQTnJCYotRiuK+8/sDDJ6iFXyAFxVMfSe/3eXn7apBP2D1rU
 n8zIoD+W6t/yqWo4U1yUIJImALSuv94Ekx7ph7/NB2M6lIKz43anXGodKggyTRhLBF71
 IDOQ==
X-Gm-Message-State: AOAM530ZwnPpIGwDIvAhGM06J8Np1khDUa1vJPPqGCh0xI9OYorkrKXI
 4UogJm6xTX6Z2vyUVR/UBkmFX+Rsu5xd1ivHhJ7xabGgUhw256WbaCHKwIlWNdSZ2SHrIK8A/ZW
 gakIP0Q0/qMrT1G34fDhAUZTTIwJO7F8Sox7FyHKz0A==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr29772907wrx.399.1618218038354; 
 Mon, 12 Apr 2021 02:00:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR/AIXG2BimYzUPAOwQOnyWTMrNFFGz9SnJpjM9QiX4VEr9DYg+h2pMbQsHiZXPHGLQ0yBvg==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr29772882wrx.399.1618218038215; 
 Mon, 12 Apr 2021 02:00:38 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id m5sm15675048wrx.83.2021.04.12.02.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 02:00:37 -0700 (PDT)
Date: Mon, 12 Apr 2021 05:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access
 to vhost device iotlb
Message-ID: <20210412045900-mutt-send-email-mst@kernel.org>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-4-xieyongji@bytedance.com>
 <20210409121512-mutt-send-email-mst@kernel.org>
 <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
 <20210411164827-mutt-send-email-mst@kernel.org>
 <CACycT3v5Z8s9_pL79m0FY5jxx3fTRHHbtARfg0On3xTnNCOdkg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3v5Z8s9_pL79m0FY5jxx3fTRHHbtARfg0On3xTnNCOdkg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Mon, Apr 12, 2021 at 10:29:17AM +0800, Yongji Xie wrote:
> On Mon, Apr 12, 2021 at 4:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Apr 11, 2021 at 01:36:18PM +0800, Yongji Xie wrote:
> > > On Sat, Apr 10, 2021 at 12:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> > > > > Use vhost_dev->mutex to protect vhost device iotlb from
> > > > > concurrent access.
> > > > >
> > > > > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > I could not figure out whether there's a bug there now.
> > > > If yes when is the concurrent access triggered?
> > > >
> > >
> > > When userspace sends the VHOST_IOTLB_MSG_V2 message concurrently?
> > >
> > > vhost_vdpa_chr_write_iter -> vhost_chr_write_iter ->
> > > vhost_vdpa_process_iotlb_msg()
> > >
> > > Thanks,
> > > Yongji
> >
> > And then what happens currently?
> >
> 
> Then we might access vhost_vdpa_map() concurrently and cause
> corruption of the list and interval tree in struct vhost_iotlb.
> 
> Thanks,
> Yongji

OK. Sounds like it's actually needed in this release if possible.  Pls
add this info in the commit log and post it as a separate patch. 

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
