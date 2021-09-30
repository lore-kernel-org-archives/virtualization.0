Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F4C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:12:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F1661994
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81F1661994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B6B4613C7;
	Thu, 30 Sep 2021 11:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnRrlKaZSmAs; Thu, 30 Sep 2021 11:12:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C38A7606D6;
	Thu, 30 Sep 2021 11:12:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 916B3C000F;
	Thu, 30 Sep 2021 11:12:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEFF5C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B926442584
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwHyloAE7dUs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:12:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3D0442578
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633000348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mamYV94DvaSHcTpxY1jybCBi3DFQDGd0SIaH6v4W57c=;
 b=ePej418kHlo0VYsUXlCcCmVc+XsfGrewGGdYukXQBUEJyOr2xEN00DG3nSeTqyq6j7++yF
 w4QEI5szjf9yX/02FIXQOVQH8hlwxcekrXqI7G3ed6ffqCF50K0raINjrj6RXXxq1bWJWU
 Lb6F+mlFoFXWlRuo7RS4e+jF75qvlpE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-VbAI0QcTNTC4qicYxb1ynA-1; Thu, 30 Sep 2021 07:12:27 -0400
X-MC-Unique: VbAI0QcTNTC4qicYxb1ynA-1
Received: by mail-ed1-f69.google.com with SMTP id
 r11-20020aa7cfcb000000b003d4fbd652b9so5875804edy.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mamYV94DvaSHcTpxY1jybCBi3DFQDGd0SIaH6v4W57c=;
 b=y4SusUB8CrR2WUwM07TQRoQEH/j14mfb9K2YnYV0tAH7heZzSCzgcD/m9qymCygFhZ
 FTNJjMtjt7+wXmZoar7r6KOjLmtClP1iQPqsO4bNGB2RcESPLMBlovp947dpAxsWUi/R
 jVjSJJocFnRnzf97oRzEmPpUSguh3Zx2tFFCWWjXGQPXRx8nv+96Gowb6JWko8QUQSiq
 tyVPcCTZydswsJq4/Qi/661v78/W/pi/ohDXQFhwcIFJ2xQJszkox3A6upEx+1ewb9ZN
 6criE8O2vfnYsz5Kt0f0V85F1ThM6Rt8FkifA5QfOtFNosq20KwtNWVw32Dlyy/w81EX
 GsLg==
X-Gm-Message-State: AOAM530xozRd0o+OLHZWFtMgyvZGbc71+oMf3EtZVjPRzFHbgZj1ze6c
 UmpEv6I5WIPc8MfIQDbbbTzATndHAA17GLHx+WzfS+JJkzGe1CdNWObTWmWZYw3kdCIjzSayuDe
 F9YecdLyzQGPvTvv9yskBRmGOwPx+XPk3LBPPNgcdNQ==
X-Received: by 2002:a05:6402:b12:: with SMTP id
 bm18mr6097147edb.199.1633000345844; 
 Thu, 30 Sep 2021 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtq8ej/t/V3JAgc3SlMjXpl9ktAa0aZIENmSOuBoeE8pGgLamCebSOneonGrTqyR1oxhTg6w==
X-Received: by 2002:a05:6402:b12:: with SMTP id
 bm18mr6097132edb.199.1633000345651; 
 Thu, 30 Sep 2021 04:12:25 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id s17sm1300678edd.47.2021.09.30.04.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 04:12:24 -0700 (PDT)
Date: Thu, 30 Sep 2021 07:12:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20210930070444-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20210930012049.3780865-1-pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> This patch fixes a regression introduced by commit 82e89ea077b9
> ("virtio-blk: Add validation for block size in config space") and
> enables similar checks in verify() on big endian platforms.
> 
> The problem with checking multi-byte config fields in the verify
> callback, on big endian platforms, and with a possibly transitional
> device is the following. The verify() callback is called between
> config->get_features() and virtio_finalize_features(). That we have a
> device that offered F_VERSION_1 then we have the following options
> either the device is transitional, and then it has to present the legacy
> interface, i.e. a big endian config space until F_VERSION_1 is
> negotiated, or we have a non-transitional device, which makes
> F_VERSION_1 mandatory, and only implements the non-legacy interface and
> thus presents a little endian config space. Because at this point we
> can't know if the device is transitional or non-transitional, we can't
> know do we need to byte swap or not.

Hmm which transport does this refer to?
Distinguishing between legacy and modern drivers is transport
specific.  PCI presents
legacy and modern at separate addresses so distinguishing
between these two should be no trouble.
Channel i/o has versioning so same thing?

> The virtio spec explicitly states that the driver MAY read config
> between reading and writing the features so saying that first accessing
> the config before feature negotiation is done is not an option. The
> specification ain't clear about setting the features multiple times
> before FEATURES_OK, so I guess that should be fine.
> 
> I don't consider this patch super clean, but frankly I don't think we
> have a ton of options. Another option that may or man not be cleaner,
> but is also IMHO much uglier is to figure out whether the device is
> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> according tho what we have figured out, hoping that the characteristics
> of the device didn't change.

I am confused here. So is the problem at the device or at the driver level?
I suspect it's actually the host that has the issue, not
the guest?


> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Reported-by: markver@us.ibm.com
> ---
>  drivers/virtio/virtio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..9dc3cfa17b1c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>  		if (device_features & (1ULL << i))
>  			__virtio_set_bit(dev, i);
>  
> +	/* Write back features before validate to know endianness */
> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> +		dev->config->finalize_features(dev);
> +
>  	if (drv->validate) {
>  		err = drv->validate(dev);
>  		if (err)
> 
> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
