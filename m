Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB96C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:07:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581B160E05
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 581B160E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08AD381BC5;
	Mon, 11 Oct 2021 09:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vovcKgBAAkU; Mon, 11 Oct 2021 09:07:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95CA181A8E;
	Mon, 11 Oct 2021 09:07:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 683A2C0011;
	Mon, 11 Oct 2021 09:07:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4425FC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 257E140261
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLZD2KeC1cTv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:07:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B74D40258
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633943262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDNmTw3S09hIeU8Xean1+IG/zrM+6vJwA8pmtg/de7s=;
 b=WksvuGdqSdxiV7WLCBH3lm14DnsOUuVwDbQPQZRXU7nYqEjHfsCwVQMAbH+d1ooHktcQft
 12KGUFNbbvygbK0GVhUVMy0vD6dSloKJ+D7/e69R0hNCDwM1dk5Nvxj78paIIrbVdZzID1
 NpVxVjs70E6Yk0QDy9Lear3lddj65U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-hIvBPOWyOviZmm_DpWdpRQ-1; Mon, 11 Oct 2021 05:07:31 -0400
X-MC-Unique: hIvBPOWyOviZmm_DpWdpRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCB3EC1A0;
 Mon, 11 Oct 2021 09:07:29 +0000 (UTC)
Received: from localhost (unknown [10.39.193.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5535F707;
 Mon, 11 Oct 2021 09:07:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xie Yongji
 <xieyongji@bytedance.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
In-Reply-To: <20211011053921.1198936-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 11 Oct 2021 11:07:12 +0200
Message-ID: <87czocx73z.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com, qemu-devel@nongnu.org,
 stable@vger.kernel.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com
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

On Mon, Oct 11 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> The virtio specification virtio-v1.1-cs01 states: "Transitional devices
> MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> been acknowledged by the driver."  This is exactly what QEMU as of 6.1
> has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
>
> However, the specification also says: "... the driver MAY read (but MUST
> NOT write) the device-specific configuration fields to check that it can
> support the device ..." before setting FEATURES_OK.
>
> In that case, any transitional device relying solely on
> VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> legacy format.  In particular, this implies that it is in big endian
> format for big endian guests. This naturally confuses the driver which
> expects little endian in the modern mode.
>
> It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. Before validate callback existed, config space was only
> read after FEATURES_OK. However, we already have two regressions, so
> let's address this here as well.
>
> The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> virtio 1.0 is used on both sides. The latter renders virtio-blk unusable
> with DASD backing, because things simply don't work with the default.
> See Fixes tags for relevant commits.
>
> For QEMU, we can work around the issue by writing out the feature bits
> with VIRTIO_F_VERSION_1 bit set.  We (ab)use the finalize_features
> config op for this. This isn't enough to address all vhost devices since
> these do not get the features until FEATURES_OK, however it looks like
> the affected devices actually never handled the endianness for legacy
> mode correctly, so at least that's not a regression.
>
> No devices except virtio net and virtio blk seem to be affected.
>
> Long term the right thing to do is to fix the hypervisors.
>
> Cc: <stable@vger.kernel.org> #v4.11
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Fixes: fe36cbe0671e ("virtio_net: clear MTU when out of range")
> Reported-by: markver@us.ibm.com
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> @Connie: I made some more commit message changes to accommodate Michael's
> requests. I just assumed these will work or you as well and kept your
> r-b. Please shout at me if it needs to be dropped :)

No need to shout, still looks good to me :)

> ---
>  drivers/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..236081afe9a2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -239,6 +239,17 @@ static int virtio_dev_probe(struct device *_d)
>  		driver_features_legacy = driver_features;
>  	}
>  
> +	/*
> +	 * Some devices detect legacy solely via F_VERSION_1. Write
> +	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
> +	 * these when needed.
> +	 */
> +	if (drv->validate && !virtio_legacy_is_little_endian()
> +			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
> +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> +		dev->config->finalize_features(dev);
> +	}
> +
>  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>  		dev->features = driver_features & device_features;
>  	else
>
> base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
