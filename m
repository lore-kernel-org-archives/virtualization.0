Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9BBC433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D873F2076B
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 13:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwGlgCig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D873F2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2F2E85C11;
	Tue, 11 Aug 2020 13:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7CF14mzJHYH2; Tue, 11 Aug 2020 13:14:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C27A85B18;
	Tue, 11 Aug 2020 13:14:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88600C013C;
	Tue, 11 Aug 2020 13:14:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1832C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 13:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A929321FF8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 13:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S3s5UrwI5AUU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 13:14:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id DF29820395
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597151661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVz+WvKu02KshY69UDG58BjK5JTgpqlEiVYjTGuurb8=;
 b=iwGlgCigxjg2C5VEPC4x51De3VEClLRV50IZQsjoLerViEVNxSLHMwMZCfkw04mw6ZlMrZ
 JqXEWoCn4KKNzvmJrOy1FzSHEOoahmcpN+kDsdYpn745qMESQ2H7F9Be7LoX2l/I74a62Y
 SKvMqweFGE3VrDJiLjf0EkIo7B2zGf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-tawa24EJMIe0u0yEGUSCUw-1; Tue, 11 Aug 2020 09:14:19 -0400
X-MC-Unique: tawa24EJMIe0u0yEGUSCUw-1
Received: by mail-wr1-f72.google.com with SMTP id e12so5607399wra.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 06:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TVz+WvKu02KshY69UDG58BjK5JTgpqlEiVYjTGuurb8=;
 b=mj8dM2PDG4SfgAgnKlknURFFY5AcDksgseeUSrsn+KZEFGB0EsQeyEfIlKJ3sXoxkK
 W6hTRV4g4Rk1Ve6Yn+EyD+7YNzoAuINCmSC2kWUUIJUBMF28KYrmw9Niw9Tpx7T3bE6R
 jNuBphPz2bClOd6DqjDCa1y0eVMEFWaR1EOQYs9nSMZzx17aeHi4k8+/soCthhQUJ1V4
 AVoUuR46KqVMwVk6VKBU5z19gPqBNDEypS34li6PI7kQi8qmIopzA26n+rC3Y+/Rtm/v
 WcvlXu81N8HT2lKHaeCm8aaRcLesEwlqcvk0E8auzFbnbiGvdaiUks9C9mAij48kzc7s
 cjzg==
X-Gm-Message-State: AOAM5328dJYUmI1EN2MkxxIuetiePxYFYAgrCNhvRBilajGKODQd3nYC
 WI82b27J+j4u2g4GSNup3FDb/7X96cQB2EvlmP2V72SDq7ox69czrFvh+E+2tXhL3PQNVm4CBa2
 tpjPwk2KbUu3Om+GAmCilUS2eMCn4iaFLozxMgZYIsw==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr6233194wrp.308.1597151658386; 
 Tue, 11 Aug 2020 06:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximOrX4ndTC56X3oS5Gm0xyEvOpSMyMP0LgEghqenVVNIrUQJBsodOLvQ5AAZmZT5uSJO9Gw==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr6233172wrp.308.1597151658141; 
 Tue, 11 Aug 2020 06:14:18 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id g188sm5809032wma.5.2020.08.11.06.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 06:14:17 -0700 (PDT)
Date: Tue, 11 Aug 2020 09:14:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811090814-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
 <7affb721-9686-1262-b7cf-d9681646b602@redhat.com>
 <810451cf80032d131d5d3feb4fc8300549516f3d.camel@suse.com>
 <b764a4bb-b81f-b14f-9b7f-d6d087a8b1ea@redhat.com>
 <b8b19be7fd9b3fab629506eb30d9f0c820aa57d2.camel@suse.com>
 <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Martin Wilck <mwilck@suse.com>
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

On Tue, Aug 11, 2020 at 03:00:14PM +0200, Laurent Vivier wrote:
> No problem. This code is tricky and it took me several months to really
> start to understand it ...

Oh great, we actually have someone who understands the code!
Maybe you can help me understand: virtio_read
takes the buf pointer and puts it in the vq.
It can then return to caller (e.g. on a signal).
Device can meanwhile write into the buffer.

It looks like if another call then happens, and that
other call uses a different buffer, virtio rng
will happily return the data written into the
original buf pointer, confusing the caller.

Is that right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
