Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE5C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E37FD60BE3;
	Tue, 27 Dec 2022 09:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E37FD60BE3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qa811v46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ju80jpuie4fl; Tue, 27 Dec 2022 09:31:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8CA8D60BCE;
	Tue, 27 Dec 2022 09:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CA8D60BCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D02C0035;
	Tue, 27 Dec 2022 09:31:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2401DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5DF660BDF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:31:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5DF660BDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l5446bEicw-8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:31:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F9C660BCE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F9C660BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672133478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjEgqHC0TjJVZZyBA3pSEYd/RXRUNHEpnJ2isGBT+vY=;
 b=Qa811v46n6XUQ03f81sqx/CWIIkoigf9vvrAFpge4VYjU6+97/6cleKw+am30MJZTMQSuY
 cIw5ChTrFT5GLyABg6QsxNJ+6wtp5cqy3MYI78RdtBpeu7TGoPXRF816bEipgjz6QpvFqn
 jWbfIEnbBkNfDw8Fk4xOOhSXj5/RKMU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-VpGlUCSmOYyymKb-QLuPXg-1; Tue, 27 Dec 2022 04:31:14 -0500
X-MC-Unique: VpGlUCSmOYyymKb-QLuPXg-1
Received: by mail-wm1-f70.google.com with SMTP id
 n8-20020a05600c294800b003d1cc68889dso3097342wmd.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjEgqHC0TjJVZZyBA3pSEYd/RXRUNHEpnJ2isGBT+vY=;
 b=WgQW1QAN9MafllCDp8aFWYLMig5jKVes2NpMnDnuPmVdeh6lVPcAUh3FLspLCPyZtX
 bnGny+A561GgFbpvA0BhT1jfa/ig12RpxT0NBNABtsSrCL624vqzuV9LhJaTkHVV69sX
 s3rewkjJZfhaLEm8+I8MjDgqNWAtb6D0AqkdMdmJ1XFXLsIj83hltjWqZPP9Utkea2y9
 hL9jS6VEMfTRCy/nRd6T6/0/TJDEvzAH0wuKsiTaIkgvsZvUlBhVeDaSk9DWqbychbg0
 YJbaQZI2vXGY5wvpQDAU6IVe8Og5zTO6zi7ZsOAG4N2ofiJdy/+KfAQHqZZVg3S1wCAq
 AoXQ==
X-Gm-Message-State: AFqh2kphr8lbTQH0pO+ExMJsBgLY0i0I+KglmPfffEScKI++opvq3Ljo
 qQHCIOQt437Wrnne+GZnqcIEsqBsJWXwLYiNyQocxofLNY6tu5UlOZ3yPzbay+FNTnfAAhvbas1
 RzGwxwXhejOlDUEpe3JgttsxIA25QgPYd6veuO+4Tzg==
X-Received: by 2002:adf:e6d1:0:b0:27c:dcf5:ad52 with SMTP id
 y17-20020adfe6d1000000b0027cdcf5ad52mr4845012wrm.11.1672133473258; 
 Tue, 27 Dec 2022 01:31:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtDqoROpQZXF0N0D/7AOnnSo+AghfYu/wxAstc5C3cls1UCZ3EJFRFCd83x4sF0qZzA1zj90A==
X-Received: by 2002:adf:e6d1:0:b0:27c:dcf5:ad52 with SMTP id
 y17-20020adfe6d1000000b0027cdcf5ad52mr4844997wrm.11.1672133473018; 
 Tue, 27 Dec 2022 01:31:13 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 h29-20020adfaa9d000000b002368f6b56desm15219971wrc.18.2022.12.27.01.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Dec 2022 01:31:12 -0800 (PST)
Date: Tue, 27 Dec 2022 04:31:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Message-ID: <20221227042855-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 27, 2022 at 05:17:20PM +0800, Jason Wang wrote:
> > > > In particular, we will also directly break the device.
> > > It's kind of hardening for malicious devices.
> > ATM no amount of hardening can prevent a malicious hypervisor from
> > blocking the guest. Recovering when a hardware device is broken would be
> > nice but I think if we do bother then we should try harder to recover,
> > such as by driving device reset.
> 
> 
> Probably, but as discussed in another thread, it needs co-operation in the
> upper layer (networking core).

To track all state? Yea, maybe. For sure it's doable just in virtio,
but if you can find 1-2 other drivers that do this internally
then factoring this out to net core will likely be accepted.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
