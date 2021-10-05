Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A3C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:20:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECA961425
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ECA961425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4632060AE7;
	Tue,  5 Oct 2021 11:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 608szgIQGu_v; Tue,  5 Oct 2021 11:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9A5A60903;
	Tue,  5 Oct 2021 11:20:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD850C000F;
	Tue,  5 Oct 2021 11:20:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6ABC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B382407C1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8oimjPfht0Ip
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98CF2407B8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633432831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
 b=O3J0BYrh/6MyaVfuUIqwey05Wno9o4wV0wIYo5hPl+Dg7K8+IoUWXk+oz71QwbFYYmMYZg
 JWgDGlkU60YzTP7uFwK9xiLYYsIc4wtgk8vRUKRL9uAQyfqx4HJoXnX2R8Tdpymo+qrDEH
 yTJW/mJv9z/eX6w4y7JScjJ1SWg4mWc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-NZjlwbotMjW3yjbGuB8Efg-1; Tue, 05 Oct 2021 07:20:26 -0400
X-MC-Unique: NZjlwbotMjW3yjbGuB8Efg-1
Received: by mail-ed1-f69.google.com with SMTP id
 14-20020a508e4e000000b003d84544f33eso20335176edx.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
 b=KWWQoqZR+jQ18bwWITM2n3r4ilOdsWKSPBS0TyxCopy7daGhQYWTmHpgZvHAXXzZPQ
 C6hniQWytIhcGDon5ju6K81aFYG+NZy2LPtgOls7PWFeTnnGvuXGDuWYoRW+pVV/BvYG
 ZtSPD7rlCLgffYI3nFpNCgS6sx34PnkdsLtJZikk0ukOyweWWaHMYkkD4lZWPgYvz6cz
 SNNjwPPXDzoRbYOnIC5HbkYocGgPe7uRI7r/i/OgsOmIEqtTKT38xl06a9YZuoQ20/Ux
 F10s6WTv4oEv2TliPECpDGC+des8YwyC5dV1f1VvDhu2DRa6vM9/GCKtQ9M176UmJ3Wy
 N67A==
X-Gm-Message-State: AOAM532E/dw+ndwdcN+HYN8s9K/degjq7z1s2rYJijpPSbGmWta694op
 xblvCwSisgh8aDR+cToAqVSeyx0MzfXo8YoO9BVoHUppD+QRT9uXWrwFTeqo+VW/0JZhPxYqE3b
 C61zQsuPa7GvbXyEHWVmPNV2UrXtwE1VINOe4Is6Uhg==
X-Received: by 2002:a17:906:3a0a:: with SMTP id
 z10mr12655450eje.111.1633432825628; 
 Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX7CkJhv+B6EpESQjJAlERsSi/L6SFxie1MuYGz7XrNTrZeHjtBwjO3hp8O2z35qxUHeEJOQ==
X-Received: by 2002:a17:906:3a0a:: with SMTP id
 z10mr12655428eje.111.1633432825464; 
 Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id b2sm8650876edv.73.2021.10.05.04.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 04:20:24 -0700 (PDT)
Date: Tue, 5 Oct 2021 07:20:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005072006-mutt-send-email-mst@kernel.org>
References: <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
 <87lf372084.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87lf372084.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, stefanha@redhat.com,
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

On Tue, Oct 05, 2021 at 01:13:31PM +0200, Cornelia Huck wrote:
> On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 4 Oct 2021 05:07:13 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> Well we established that we can know. Here's an alternative explanation:
> >
> >
> > I thin we established how this should be in the future, where a transport
> > specific mechanism is used to decide are we operating in legacy mode or
> > in modern mode. But with the current QEMU reality, I don't think so.
> > Namely currently the switch native-endian config -> little endian config
> > happens when the VERSION_1 is negotiated, which may happen whenever
> > the VERSION_1 bit is changed, or only when FEATURES_OK is set
> > (vhost-user).
> >
> > This is consistent with device should detect a legacy driver by checking
> > for VERSION_1, which is what the spec currently says.
> >
> > So for transitional we start out with native-endian config. For modern
> > only the config is always LE.
> >
> > The guest can distinguish between a legacy only device and a modern
> > capable device after the revision negotiation. A legacy device would
> > reject the CCW.
> >
> > But both a transitional device and a modern only device would accept
> > a revision > 0. So the guest does not know for ccw.
> 
> Well, for pci I think the driver knows that it is using either legacy or
> modern, no?
> 
> And for ccw, the driver knows at that point in time which revision it
> negotiated, so it should know that a revision > 0 will use LE (and the
> device will obviously know that as well.)
> 
> Or am I misunderstanding what you're getting at?

Exactly what I'm saying.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
