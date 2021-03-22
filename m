Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB8DC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5726192D
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5726192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 753B7606C7;
	Mon, 22 Mar 2021 08:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dPioo7J8bIJB; Mon, 22 Mar 2021 08:19:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A07D60666;
	Mon, 22 Mar 2021 08:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B91C000A;
	Mon, 22 Mar 2021 08:19:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF11C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64D3E402F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUCF8MG58sEk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7135F402F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616401170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WoKk7mGrLBFPYHjSxhI5m6ZJ3T1eCo8ygoYac0Rpup8=;
 b=XdKRA5ppbvlhDYKky+q5phompi7SFKIJptOGbu7MkXRy2qNC4OqI6aZpKPVIps6ajwi6ph
 c1HoMgP7tW0q9yabrsSYo7XaEDrPCd90vbet9BZddso1xb2OCb5J7IP55Z2XiuTofb61U0
 2d5AptjC4ecaADbnGN91ZWWsDquW1Yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-PYiGeiZXNuu57OQ-xyV3JQ-1; Mon, 22 Mar 2021 04:19:28 -0400
X-MC-Unique: PYiGeiZXNuu57OQ-xyV3JQ-1
Received: by mail-wm1-f72.google.com with SMTP id s192so14728159wme.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 01:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WoKk7mGrLBFPYHjSxhI5m6ZJ3T1eCo8ygoYac0Rpup8=;
 b=ZqQUZGvXOwMdp89exE7BV2bu564j0DVUHeEqopso5Y//0QMeHty3w8A5qmLQ+jeLBF
 JHbyK3EkonzXvuWVK5z2r8MZDemtTYTTmbWC4syjdYOv841XCC+l1c6iXQXiZlvUvMCD
 O1yCifaD8yueFvB8cOoZpO9i1XbzIF1onO6bM1CScSfNLsvEJBCqNSTvw5Y8bh3Aw5uk
 0B1Lrprd6Me5nAGdzC8mP+5MPCShVD2oEcrkzZgy44N35Jj8sH0Qhm33YqY7YdK23NNd
 TmN2m32a66GKvUBa/7nTecFScDMSgU74vFNlbqJxbKVDz+XHc0o9Xo+TyxYMnYKCW+eo
 JH3A==
X-Gm-Message-State: AOAM532ApouNw8VLKzuF8kvs4a2KmRcMvtBZp0zegMkjfA1/1TInpAAE
 JHPVEEp25qGvfrFZqrzB4CWWFQZFT+Rohmplb6c/BR0Km7cOk9KHOBh5c+iD7SPhY1Q1xGlxCih
 VYVROBN3U/hX9NjytgtIL2iYsoxoZ9Yft/41toUo4Ow==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr14925814wmj.34.1616401167060; 
 Mon, 22 Mar 2021 01:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/hGKwIQ8AizOzUTlpxccYR1kU76/f9kIiC5G+j9WI50iF5Kv+8CR5Hj4QZ7N0ojmMTnKJkQ==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr14925787wmj.34.1616401166932; 
 Mon, 22 Mar 2021 01:19:26 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id u15sm14813092wmq.4.2021.03.22.01.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 01:19:26 -0700 (PDT)
Date: Mon, 22 Mar 2021 04:19:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v9] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210322041857-mutt-send-email-mst@kernel.org>
References: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <e09c07532f5456816eb91ef4176bf910284df4ff.1616418890.git.jie.deng@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, wsa@kernel.org,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 virtualization@lists.linux-foundation.org, arnd@arndb.de, stefanha@redhat.com,
 tali.perry1@gmail.com, conghui.chen@intel.com, loic.poulain@linaro.org,
 linux-kernel@vger.kernel.org, Sergey.Semin@baikalelectronics.ru,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com, pbonzini@redhat.com,
 rppt@kernel.org
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

On Mon, Mar 22, 2021 at 09:35:59PM +0800, Jie Deng wrote:
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index bc1c062..6ae32db 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -54,5 +54,6 @@
>  #define VIRTIO_ID_FS			26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM			27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_I2C_ADPTER		34 /* virtio i2c adpter */

ADPTER -> ADAPTER?
adpter -> adapter?

>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
