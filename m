Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2EC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:29:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875BF2312C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7cnq/vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875BF2312C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C826867C6;
	Wed,  5 Aug 2020 13:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laulAwvthTQk; Wed,  5 Aug 2020 13:29:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA5EA8686A;
	Wed,  5 Aug 2020 13:29:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 947BCC0051;
	Wed,  5 Aug 2020 13:29:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27653C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2322B85F19
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gV9p8ISIg5YR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8B94685E79
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596634195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bM6BX5L4/TWGWo6Fw0MECvbQOerPg7X6HOlNI1yptJk=;
 b=Z7cnq/vyPMkF/EJ0TR9h3iACPePaB6flZFsXVwQUVdtXRJtP5LGTrBkxrGWkSsqXhxv0oE
 2tBfDzGHef5k07XSvDYmo7DtXSGmMKs4QNyjdOTOd8xsG1TniMHwXGIfQG37cGwFgeuD4n
 AdP8J4r/svxqo4P1yVtQGvL4GGjwb9k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-Wjp2JeM6MK-j9V7pVwjBlQ-1; Wed, 05 Aug 2020 09:29:53 -0400
X-MC-Unique: Wjp2JeM6MK-j9V7pVwjBlQ-1
Received: by mail-wr1-f70.google.com with SMTP id f7so13569566wrs.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bM6BX5L4/TWGWo6Fw0MECvbQOerPg7X6HOlNI1yptJk=;
 b=gnODa/V9lNFk781GqVwt0pxLflvKIqKE4myDrdC4kG42vYl36s3EwGhwwurUZ8kDmb
 mO/CtkT21779tOuCEmg3vvbWwEohw6g7xfdbjVXQXoORa001gS1paH/uu9JPCkOh2QuR
 715yQwdHS1U0kNPxLp8pbFIHppSDU8el9OACYSLxsFnF1JRR8kuU4ZXjc51LJQIJWMAU
 w3qcU8a5OiN0NP9VuuiarQcG2CHetETRzM4AwnmPH+l2bStwkPzTXAAuYN2MoobFTnwr
 jSMzZn4ErwO0FxwmzSK4lZcQat9pS/oi+64s8asY6nP5Lkfv670MzlB9/rrCwK05nF6S
 PL2Q==
X-Gm-Message-State: AOAM533dHsQnEX6Mcz8zc2HxTVUND7p56BG5kW4LVlE58iy+MUpFG3SL
 A9yVx7XFQIR+Z5FAFq2D8nZqBUTSuWgjA7Jj9WFRduggVPn3LLaJwWwO4xvnt+eO1l1odL2Pmgc
 Y6Qq5e0ut/6uoIHKlu7oxRiaayqQ08pCGWWIKcPPK0A==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr2729022wrr.353.1596634191933; 
 Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD71GjrxuIPt/70247PjYqetL3L7dJwS2itOOTaj8djrdCVByKfXCsWH/un1uLPcWYOq4+WA==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr2729006wrr.353.1596634191720; 
 Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 q2sm2752486wro.8.2020.08.05.06.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:29:51 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:29:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 17/24] virtio_config: disallow native type fields
Message-ID: <20200805092923-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-18-mst@redhat.com>
 <20200804165039.58dcb29e.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804165039.58dcb29e.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Aug 04, 2020 at 04:50:39PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 16:59:57 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Transitional devices should all use __virtioXX types.
> 
> I think they should use __leXX for those fields that are not present
> with legacy devices?

Will correct.

> > Modern ones should use __leXX.
> > _uXX type would be a bug.
> > Let's prevent that.
> 
> That sounds right, though.
> 
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 64da491936f7..c68f58f3bf34 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -319,9 +319,8 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >  	__virtio_pick_type(x, __u8, __u8,					\
> >  		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> >  			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> > -				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> > -					/* No other type allowed */		\
> > -					(void)0)))))
> > +				/* No other type allowed */			\
> > +				(void)0))))
> >  
> >  #endif
> >  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
