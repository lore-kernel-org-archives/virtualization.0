Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E82E6FE58
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 15:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9597C60E15;
	Fri, 22 Sep 2023 15:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9597C60E15
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6iHQhI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sz8-ZjDRkwXB; Fri, 22 Sep 2023 15:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 228E4610D7;
	Fri, 22 Sep 2023 15:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 228E4610D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB7CC0071;
	Fri, 22 Sep 2023 15:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9595C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 868C7836E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 868C7836E1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6iHQhI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OVWv07lHMm27
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:45:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46F2483112
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46F2483112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24e0MTM9Ea72ehbm0l01A6havDY/UYoKOi3aCHWehJU=;
 b=U6iHQhI+IDaEi9b1+pt0MJB7ud3ncpZR7k+rFyBdjYH/UPHJWS33pcOUkwIrzFgnbmNq5i
 uvm6RssvAIY+Yxi4x9omA0WiigCnAzKP68pPlPsiFn63r1falI41dF8ZlDtanMEeIy1B+G
 sezDDBQx61I7XzFK9WoeULrF2DE3Pi4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-9yIufwrtOrKSgLwmJdO_aA-1; Fri, 22 Sep 2023 11:45:28 -0400
X-MC-Unique: 9yIufwrtOrKSgLwmJdO_aA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-320bf1de0a6so1418785f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 08:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397527; x=1696002327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24e0MTM9Ea72ehbm0l01A6havDY/UYoKOi3aCHWehJU=;
 b=o1sZhjqDnTqRYTtWTbHOhVw+KcxvfNvmLC0TsDBnAIMlhCuspRUuKfimv7TJtc+KBV
 e9lovTvnAE2Ru2Arf0pDieH+l7XHkMwt/Ow+pMi4FjDRCEw4E6hcXKZoezssVZOEA5wM
 /BVoELQWz+SDVotYRV0YwRAeYxlbrqb9zByvZLZrwEVUtjqmuOiHXhqn3MWqeOHRwUOB
 mg0u1qP9zXv9fsi9seqzH4oLIBEY45n8XwNmY0311K9VDCwL2yqspfd1+ghS0i7ZRBqy
 7OGvCoQ01GM/x2dlNYpgB/V4KBtSxarSa0AVOaWMrECpA4ZhpobHqdHtZ17126QClbch
 EtAQ==
X-Gm-Message-State: AOJu0YyZZvXxbv2WVxddVosuuBdWKpvEBOCavss6Tj3SdjSaRFPJfByA
 93vwozwwnEHXl8T0WX4jxMykGcz1fZItxd6UdQO+zJ55E4CmelXm6gXSxvtjeOcZ0baNHTN+KBy
 Mz+yTqGifH+5pn+PJ2+kiiCJsN6gLn/nITHD24A1byg==
X-Received: by 2002:a5d:404d:0:b0:31f:e534:2d6f with SMTP id
 w13-20020a5d404d000000b0031fe5342d6fmr58820wrp.11.1695397527124; 
 Fri, 22 Sep 2023 08:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeBusEZRXoLGIDhzmsM8uH+6ZQqUREFrCewPrkgBuuX5Vrg5rtomLqzp/AHoeDKj4EWQLrgA==
X-Received: by 2002:a5d:404d:0:b0:31f:e534:2d6f with SMTP id
 w13-20020a5d404d000000b0031fe5342d6fmr58789wrp.11.1695397526760; 
 Fri, 22 Sep 2023 08:45:26 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 bl19-20020a170906c25300b0099bc8db97bcsm2854718ejb.131.2023.09.22.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:45:25 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:45:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922114122-mutt-send-email-mst@kernel.org>
References: <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <20230921224836.GD13733@nvidia.com>
 <20230922011918-mutt-send-email-mst@kernel.org>
 <20230922122328.GO13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230922122328.GO13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Fri, Sep 22, 2023 at 09:23:28AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 05:47:23AM -0400, Michael S. Tsirkin wrote:
> 
> > it will require maintainance effort when virtio changes are made.  For
> > example it pokes at the device state - I don't see specific races right
> > now but in the past we did e.g. reset the device to recover from errors
> > and we might start doing it again.
> > 
> > If more of the logic is under virtio directory where we'll remember
> > to keep it in loop, and will be able to reuse it from vdpa
> > down the road, I would be more sympathetic.
> 
> This is inevitable, the VFIO live migration driver will need all this
> infrastructure too.
> 
> Jason
>  

I am not sure what you are saying and what is inevitable.
VDPA for sure will want live migration support.  I am not at all
sympathetic to efforts that want to duplicate that support for virtio
under VFIO. Put it in a library under the virtio directory,
with a sane will documented interface.
I don't maintain VFIO and Alex can merge what he wants,
but I won't merge patches that export virtio internals in a way
that will make virtio maintainance harder.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
