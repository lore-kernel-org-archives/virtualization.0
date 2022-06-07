Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C9C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 10:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BC9641C0D;
	Tue,  7 Jun 2022 10:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wO5FSgtXfPSo; Tue,  7 Jun 2022 10:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C9AC41C0C;
	Tue,  7 Jun 2022 10:36:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2B7C0032;
	Tue,  7 Jun 2022 10:36:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17D64C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 10:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5C6960BE8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 10:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RukeHYVtaNEZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 10:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E8A860AA5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654598183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIZmENWoecc1Gjip/W8Q1+dSiheQPkO4yhqkXrzmqmA=;
 b=KbKhOchsr23hSRwnGzay+5kok3z0O/8peBFL/J/muwzfLomSRhhcD/HD2TOSdFypLp4GS+
 2Lmw0ZT0pbsbE57XE6+3evfI4QxZFDK/3hTL1WhH6BG7g7REX687TqRg3QJr7smYWAgeiG
 c6/gqjJtlseVjZyAIunHjpp9a1Sm2L8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-OSsQ4ElYPl6mBXfYWGVGxQ-1; Tue, 07 Jun 2022 06:36:22 -0400
X-MC-Unique: OSsQ4ElYPl6mBXfYWGVGxQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 o18-20020a5d4a92000000b00213b4eebc25so3094964wrq.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Jun 2022 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VIZmENWoecc1Gjip/W8Q1+dSiheQPkO4yhqkXrzmqmA=;
 b=r33+anRIdW0UW4vf8YuLS21MYQdHEzrIJx4jcFoamLH1LP7zRMOSmMmUzWPM+sGsPD
 2yjvXMHdvvNvAz4as1V+E4/48iHyR3lfmlMEChEZ3eZNtjPoZ3AvAUUHONKGxo5dITMF
 Tgvrl2fKsfurI9Vp4aXTHGSsxM2ldkakK1EDPYfXj48HN4wX4LwdVhU7JUTGHczpmwnB
 VzpbFurkfmCzx/tdWt/SWmUtyhP5NVdh3FJ2GowR5kGiIwgYYuNXfdiTQeu9p2gr6MwV
 AETmmf0dCktBXcSSpzz3zfGeU65b+Syo1JJXiFKX7daDpo3xD739w7SXyXDTbNPtNhJN
 tO+A==
X-Gm-Message-State: AOAM530o1S6DoIB+79Ms0Yzs/RFw8sUW0SLhEy1Vx6SbUjxBK4kdrRtZ
 dBiqCcrkY/0LZwut7KpyHbA59sPfMHDyYAn4bDUQOkn+Us6he76pt2Ofd58wJzRtZ/7P97LC/C8
 O3QQcQD7g4YfZczMyd4mPGBo8z9aB9RAI0R+QbZfpfw==
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id
 m32-20020a05600c3b2000b003976311c0c7mr56578496wms.69.1654598181301; 
 Tue, 07 Jun 2022 03:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMvJByNJtOpfW7JFF+6+fzeex2HW2ExVgG0ZmK8Z/TskZxgAJUrPnbY07auM9j9IWBDFyxdA==
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id
 m32-20020a05600c3b2000b003976311c0c7mr56578454wms.69.1654598181061; 
 Tue, 07 Jun 2022 03:36:21 -0700 (PDT)
Received: from redhat.com ([2.55.169.1]) by smtp.gmail.com with ESMTPSA id
 m4-20020a1c2604000000b0039c506de087sm5271489wmm.6.2022.06.07.03.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 03:36:20 -0700 (PDT)
Date: Tue, 7 Jun 2022 06:36:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call
Message-ID: <20220607063549-mutt-send-email-mst@kernel.org>
References: <f5cef070316447cebe0e9c6e86657218@inspur.com>
MIME-Version: 1.0
In-Reply-To: <f5cef070316447cebe0e9c6e86657218@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMDg6MDg6NThBTSArMDAwMCwgQm8gTGl1ICjliJjms6Ip
Lea1qua9ruS/oeaBryB3cm90ZToKPiBUaGlzIHBhdGNoIHJlbW92ZXMgdW5uZWNlc3NhcnkgY29k
ZSBhbmQgZ2VuZXJhdGVzIHNtYWxsZXIgYmluYXJ5IGZpbGVzLgo+IFRoYW5rcwoKQ2FuIHlvdSBw
b3N0IGluZm8gb24gd2hpY2ggZmlsZXMgYXJlIHNtYWxsZXIgYW4gYnkgaG93IG11Y2ggcGxlYXNl
PwoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
