Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB1C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 09:57:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53F760551
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 09:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A53F760551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B11F8101C;
	Tue, 26 Oct 2021 09:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p967arLUrNVB; Tue, 26 Oct 2021 09:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED89180FFE;
	Tue, 26 Oct 2021 09:57:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3EA0C0019;
	Tue, 26 Oct 2021 09:57:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3135C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 09:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E5BB60712
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 09:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mk7LZqIKeQil
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 09:57:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA02960639
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635242263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1zy+x1pDQRw0Wm0gptmGRgNn/axz9jWocmq6wNEwfts=;
 b=iAJDqmZdTManTrDirq0NhpQrePSBRKzaJrStisJhms7h5ZjVntrxl3MNpM80cw2d+vXHQe
 FxpyZFIRZ3sjDqRFU3mQ9FQPZ69pgBB9aTe7P8FK00nRHJjH87t05HhlyzuE8CJJgAvL7p
 UgDJsxPGbTSo8PYy9tTY9CVqElq61rY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-FHTUeLGjPbSHw8o3aoDXHw-1; Tue, 26 Oct 2021 05:57:40 -0400
X-MC-Unique: FHTUeLGjPbSHw8o3aoDXHw-1
Received: by mail-ed1-f69.google.com with SMTP id
 t18-20020a056402021200b003db9e6b0e57so3286395edv.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1zy+x1pDQRw0Wm0gptmGRgNn/axz9jWocmq6wNEwfts=;
 b=ILeCD9h+yU8/ms2DphLqK6nHDpYUHcDGNr8Dx++xmtIUyme04JsK1Djis30AMTvVId
 fXVJO/lVOy3i61ZbS7byQ9BRLXvAYg0zujCxYyBjK2mjAe24dHDKTVVVqXjb7W3Tl8YU
 Y2NDTtoER15ECoXK1zRut/7dKhiBPufiO3u7RmSRLR+gx2FNfQHG9+lFMHMdJ0Ouy+04
 j4cudEXHOGqzNGiSfMwoX+71x7NsXtGz18JxMStcBm8ibh5nd4uj83rD2k9Uu9w1kObL
 m/NqeEj/JrIIrSXkTTvL7LbliNcaNAZRCHwpCIi85rDR4EcdZdHUxsyr1yJ4Z6KM0o6i
 toPg==
X-Gm-Message-State: AOAM533i3NeOd1SNFgXkczoHmVyAjKd48Ln7R0y8osb7kd7Tm553tjb/
 m4jIkVurNxRtGcVcpyn8XPyRZOd3PAg5iRI3FpLPNzs+KnHtoThzY+Rd8fBVck5VZRdp32yNfD9
 k6CYLV5tyvupmPAiXvMFQmR85KR4u9DNGidlURT03Dg==
X-Received: by 2002:a17:907:7f87:: with SMTP id
 qk7mr1426861ejc.105.1635242259338; 
 Tue, 26 Oct 2021 02:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwS/KH58hNErZtIqzUcxf+jKnF612u7uUMoQ6KEk9+PhgjhDtnZ/bUayIb+ys9E04S1L9wMg==
X-Received: by 2002:a17:907:7f87:: with SMTP id
 qk7mr1426832ejc.105.1635242259097; 
 Tue, 26 Oct 2021 02:57:39 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id hp13sm7133502ejc.66.2021.10.26.02.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 02:57:38 -0700 (PDT)
Date: Tue, 26 Oct 2021 11:57:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] eni_vdpa: alibaba: fix Kconfig typo
Message-ID: <20211026095736.wwbjat4pzt3kpbm7@steredhat>
References: <20211026083214.3375383-1-arnd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211026083214.3375383-1-arnd@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Eli Cohen <elic@nvidia.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 26, 2021 at 10:31:59AM +0200, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The Kconfig symbol was misspelled, which leads to randconfig link
>failures:
>
>ld.lld: error: undefined symbol: vp_legacy_probe
>>>> referenced by eni_vdpa.c
>>>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a
>
>Fixes: 52e437b2b222 ("eni_vdpa: add vDPA driver for Alibaba ENI")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/vdpa/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
