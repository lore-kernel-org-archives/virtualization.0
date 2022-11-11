Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D0C4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 15:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BEFA40C02;
	Fri, 11 Nov 2022 15:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BEFA40C02
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5jpV6/3a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SxjWsIVBMRkn; Fri, 11 Nov 2022 15:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B96C8400E2;
	Fri, 11 Nov 2022 15:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B96C8400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D667C0033;
	Fri, 11 Nov 2022 15:44:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D0E0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ACFE60FE1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:44:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ACFE60FE1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=5jpV6/3a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GsQTkkZ6SWxJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:44:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0A6660FE0
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0A6660FE0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 15:44:15 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-13bd2aea61bso5852948fac.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7fOQCR9LQsILHqpLYgIKXsnkpnQvN1ZGRGiti7+qNI0=;
 b=5jpV6/3aruxYPNfduil2C2LPvo7ROmSpgyPdA6DoZarfXFyiXOpcu5oWmAvl0/YInl
 TB+RdTX88OZDwFx9UR0Y0VyPzz2tQ1yIqkyTxnfKER2VGJEU2TPvRB5fwOAaJyog9Fna
 ZbgrPa4Gm8mDaOzjrvbi/ia2bh3IVusDJPuN1cmvopCIaarUDv3gLx/9VewvxAFhTOJQ
 BOA7EoW8FWF+8uwXvVb6CF+uZ22VFhpdF73nbc/3iPw+aCgWrLi3bBVdnCnonIWx5VVD
 /vfu+FM9JSKUQQsIOBgDemlBQ7m2NKfcs9uOpDIC4wKgFptRagj6x2WCMOxcu1aBdikb
 PZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fOQCR9LQsILHqpLYgIKXsnkpnQvN1ZGRGiti7+qNI0=;
 b=IPOJGOdFTuFyZZsT10zCngV/UVBhObsmRFI2Mid7KDI5Sp+bgEtGwzulQY4egjsia5
 eKTK3wVClfECP7C4UcL0uBAqYE96cDkg/+OIHlp60IBJ+NDv4f1DbkYJjre2Oud/0yP+
 NnHtFcD/lV58pGmFsJE89UH4o3YJcRh+7WzrqdRK8al6loy56cRxYbiMB6Xpyu9T2CML
 95gwAryVD8EHK5Jg9lZMsiEFlrxWRBYxOZ8wlvq4fNFv5iv5NNYAP36G9CGN+vXAx65f
 +KGQ97TLdjwqakEqHuNlruitwCKX+jINAbZJ8Sf9KLxoKIRX7BcN93e/7ykuh4X2eq89
 DHJg==
X-Gm-Message-State: ANoB5pmBPkK4ldcmQo/MGye4UDMDrGElB2kLwhe2glHs5BBe/Wx+0W6e
 1XKZHa5Y7HUFSLa+NWVC1jysa1e6eY+L4MHlmSp+sw==
X-Google-Smtp-Source: AA0mqf6mvtkmvc+WPlk4+UgNWrGdCnjrnli9ahzCHIrG4v2gQU9idkJQ/Ogkw9XqkIwGGSpX8QhbQx/VQHHfkNwDcs0=
X-Received: by 2002:a05:6870:8316:b0:136:437a:a465 with SMTP id
 p22-20020a056870831600b00136437aa465mr1228730oae.273.1668181454587; Fri, 11
 Nov 2022 07:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
 <20221111091708-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221111091708-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 11 Nov 2022 17:43:37 +0200
Message-ID: <CAJs=3_AR92a=51y6q3-CnHX-UJ6UkLjuYeY7z2faLY8EQx9bFA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

> hmm what does this have to do with lifetime?

> Does this have something to do with lifetime?

At the moment, if a request operation is REQ_OP_DRV_IN, the function
virtblk_setup_cmd assigns the virtio type VIRTIO_BLK_T_GET_ID.
I changed it so a REQ_OP_DRV_IN operation could have different virtio types.

Instead of setting the type in virtblk_setup_cmd, the type for
REQ_OP_DRV_IN operations is set in the function that creates the
request (virtblk_get_id, virtblk_ioctl_lifetime)
I see now that I didn't add iopprio for legacy devices, I'll add it in
the next version.

> You don't need the cast to void *.

> Neither here.

> Nor here.

Ok.

> block comments have wrong format I think.

Are you talking about the empty top line?
/* empty
 * line 1
 * line 2
 */
 If so, I'll fix it.

> I think if you are going to pass struct virtio_blk_lifetime to
> userspace, better pass it as defined in the spec, in LE format.

Ok.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
