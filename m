Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE1C433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 09:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13E454091C;
	Mon,  7 Mar 2022 09:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a62H3_H9IyMm; Mon,  7 Mar 2022 09:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8E5340915;
	Mon,  7 Mar 2022 09:05:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8312DC000B;
	Mon,  7 Mar 2022 09:05:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C79A4C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A867860806
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SX7Khsa2snpQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0765360745
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646643945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KquYHpLzP9rbFE8aNYKIXPzbeoLEFNa1Q6VUPR36ZHo=;
 b=bfjmJBFnRN1ONubY2n8sYXci1jS3eYaRiYvBJe2Q3BE5WD2+iumyCdwsv00cJrBcIJc1ge
 vU/UToyGUo+0zmZzVhT2KrAnelOHxXbB+hICH9VtP7H0fDaOJDh4x2jkw1Pt1oQiVHQMxx
 wJ6DV02Vbl+J6jHxdgztmbll788vzwY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-cGMopJXKNVS04APz5keruw-1; Mon, 07 Mar 2022 04:05:44 -0500
X-MC-Unique: cGMopJXKNVS04APz5keruw-1
Received: by mail-ed1-f71.google.com with SMTP id
 y10-20020a056402358a00b00410deddea4cso8237201edc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 01:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KquYHpLzP9rbFE8aNYKIXPzbeoLEFNa1Q6VUPR36ZHo=;
 b=DktiV/ak0lEYNmgBAN/ntpznY7Qqhvo5aDjT5Ij/RX40pNxIAEXTh4IyoYYiYCMmtd
 u/qCqO2d1RtqQERzYLTwDKiCWha6T+fAgBEaBNv1hnpYtkWM0XtmaJ7aLS/QRJRVx4u5
 Yjh4U/xNrkU4H+GoE3ZBfBUZ33aEz93VJIY6t8ZMQYDP7PCq4tOsysl/RwlLUIT3oN6E
 w1lWl0WCtubTAnxHNw97Fu/CSLWndGgb7E22PDkl2HuNLgazzBxCvZJ40TY+WNUofQiS
 vByYsZYgMmr0lwVSfBhtq+s8E7CHtUUhs3IJIG2i70EoI/8hvBigtyaZEfIIzzh3hALR
 u9Qw==
X-Gm-Message-State: AOAM530Dg41toJFtPIkZqwGH4ZLF39mXqQhBcdn43HTKNtz44zP/1E40
 9tWYXQ8j5A4VuYdZiO9fPtHj049aXtq4TVsFXrPhmQuSZ+l4Mrm/Gu/r36fRHxEyHrRRtWCzWzj
 Wp8xBm4PbGKN4WZi1SUxd2P3Pjmmr8gi8UCRnq8CKaQ==
X-Received: by 2002:a50:fb93:0:b0:416:c4f:bd24 with SMTP id
 e19-20020a50fb93000000b004160c4fbd24mr10142941edq.225.1646643941308; 
 Mon, 07 Mar 2022 01:05:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWeD5sAgrgZ1GTJMg5/qZSM+l+wtaHwT/4dN4mntileJu6VvueA9/As61UwE+i+QOYycmFEg==
X-Received: by 2002:a50:fb93:0:b0:416:c4f:bd24 with SMTP id
 e19-20020a50fb93000000b004160c4fbd24mr10142922edq.225.1646643941088; 
 Mon, 07 Mar 2022 01:05:41 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 a25-20020a50ff19000000b0040f84cd806csm5875397edu.59.2022.03.07.01.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 01:05:40 -0800 (PST)
Date: Mon, 7 Mar 2022 04:05:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220307040431-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: herbert@gondor.apana.org.au, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, helei.sig11@bytedance.com
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

On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> Hi, Michael & Lei
> 
> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> for a revoting procedure?

You can but not it probably will be deferred to 1.3. OK with you?

> Also cc Cornelia Huck.
> 
> On 3/2/22 11:39 AM, zhenwei pi wrote:
> > v2 -> v3:
> >    Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
> >      minor changes of function name.
> >    Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
> >      buffer if opcode is verify.
> > 
> > v1 -> v2:
> >    Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
> >    Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
> >      struct virtio_crypto_config directly without size change.
> >    Add padding in struct virtio_crypto_ecdsa_session_para to keep
> >      64-bit alignment.
> >    Remove irrelevant change by code format alignment.
> > 
> >    Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> > 
> >    Test with QEMU(patched by the v2 version), works fine.
> > 
> > v1:
> >    Introduce akcipher service, implement RSA algorithm, and a minor fix.
> > 
> > zhenwei pi (4):
> >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> >    virtio-crypto: introduce akcipher service
> >    virtio-crypto: implement RSA algorithm
> >    virtio-crypto: rename skcipher algs
> > 
> >   drivers/crypto/virtio/Makefile                |   3 +-
> >   .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
> >   drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
> >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
> >   ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
> >   include/uapi/linux/virtio_crypto.h            |  82 ++-
> >   7 files changed, 693 insertions(+), 9 deletions(-)
> >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >   rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)
> > 
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
