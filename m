Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CBC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 12:15:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B0E61163
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 12:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0B0E61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC04B404D6;
	Wed,  6 Oct 2021 12:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08aXBzatgnT2; Wed,  6 Oct 2021 12:15:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 412084060C;
	Wed,  6 Oct 2021 12:15:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10511C000F;
	Wed,  6 Oct 2021 12:15:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80711C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 12:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DAB183EE7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 12:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwG-IocWE9ST
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 12:15:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B83FA83EDA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633522516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
 b=cKiG+WOybh2sZ2ZsquOVXREOamLakQY0NRF5kFPQpIHmLAar0SumRuYLGIjv4rjBwgZ1Et
 gHXDMaFILOaRQLrS39E0aScUeTgvnUgqIoJYuKrhdH8LsqWTo7i++0Q/wte9m262C6g2Fz
 cGVnXJuOXLIvsaCRD2dWgl8Ph3UPXmM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-DPfBAgFdNGqavmontHfqTw-1; Wed, 06 Oct 2021 08:15:14 -0400
X-MC-Unique: DPfBAgFdNGqavmontHfqTw-1
Received: by mail-ed1-f69.google.com with SMTP id
 g28-20020a50d0dc000000b003dae69dfe3aso2458074edf.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Oct 2021 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
 b=T50j904xZ5v58Ck3DP36YtLIuyA4/7x40+djxPEzsGPu6Wh/7gjvtJ5eUFilyri1aS
 j5KobWv86LUUa9dPOiwzb4khkJLN/rpHcZRa3zR7OqgzOamnGB8ny1DMNPkWoXzIBt83
 zWTyQQm7SW0DxqLFtcJgRG80YCfhQ5/fnYjFV6rw9TuZnULjLuhbt7kMkZf0bJbuSPDz
 rvc8ZuizIIX64xcvrYA8yQef9Zu6K1JsUMpvbQ/8wX5d6/FoA9J/U24ZHaFAIm5+4XAa
 XhFRFazSvC34wPeF48ytqpl30rP9a4saNoBIUJvCYMn+LKVhI2j0a2GNvu8WlZZ6Yiqo
 dxlA==
X-Gm-Message-State: AOAM530dhSTYJWH2kVao8m90v4c9U09X2MAO8lvDSKkrt8HvpLV202co
 1yeh+gV+DTbwmL+Zpja2Z9y5UBmc6IH2zy7WBYLmYoWCvJTPIoJhnmqTShEyoeFovYfmFez1nRu
 wo27moH+estNzpR2OU3ERqYQoGD3fK8keVv1IuyF1Mg==
X-Received: by 2002:a17:906:f208:: with SMTP id
 gt8mr21806745ejb.522.1633522513831; 
 Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG9wllx9y16DQrS76uUlfwpX+3oqTEzh8ajeSft32BLV8/8AcXlKmgVAU0xygywoNNmIYASA==
X-Received: by 2002:a17:906:f208:: with SMTP id
 gt8mr21806715ejb.522.1633522513589; 
 Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id k20sm8795905ejd.33.2021.10.06.05.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 05:15:12 -0700 (PDT)
Date: Wed, 6 Oct 2021 08:15:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211006081430-mutt-send-email-mst@kernel.org>
References: <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
 <87wnms23hn.fsf@redhat.com>
 <20211004151408-mutt-send-email-mst@kernel.org>
 <87sfxezcjp.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87sfxezcjp.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, Xie Yongji <xieyongji@bytedance.com>
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

On Wed, Oct 06, 2021 at 12:13:14PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 05:50:44PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> >> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> >> >> 
> >> >> >> [cc:qemu-devel]
> >> >> >> 
> >> >> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >> 
> >> >> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> >> >> > compatible device must use LE.
> >> >> >> > It can also present a legacy config space where the
> >> >> >> > endian depends on the guest.
> >> >> >> 
> >> >> >> So, how is the virtio core supposed to determine this? A
> >> >> >> transport-specific callback?
> >> >> >
> >> >> > I'd say a field in VirtIODevice is easiest.
> >> >> 
> >> >> The transport needs to set this as soon as it has figured out whether
> >> >> we're using legacy or not.
> >> >
> >> > Basically on each device config access?
> >> 
> >> Prior to the first one, I think. It should not change again, should it?
> >
> > Well yes but we never prohibited someone from poking at both ..
> > Doing it on each access means we don't have state to migrate.
> 
> Yes; if it isn't too high overhead, that's probably the safest way to
> handle it.
> 
> >
> >> >
> >> >> I guess we also need to fence off any
> >> >> accesses respectively error out the device if the driver tries any
> >> >> read/write operations that would depend on that knowledge?
> >> >> 
> >> >> And using a field in VirtIODevice would probably need some care when
> >> >> migrating. Hm...
> >> >
> >> > It's just a shorthand to minimize changes. No need to migrate I think.
> >> 
> >> If we migrate in from an older QEMU, we don't know whether we are
> >> dealing with legacy or not, until feature negotiation is already
> >> done... don't we have to ask the transport?
> >
> > Right but the only thing that can happen is config access.
> 
> Checking on each config space access would be enough then.
> 
> > Well and for legacy a kick I guess.
> 
> I think any driver that does something that is not config space access,
> status access, or feature bit handling without VERSION_1 being set is
> neccessarily legacy? Does that really need special handling?

Likely not, I just wanted to be exact.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
