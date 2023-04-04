Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33861C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 08:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AABCF409D8;
	Tue,  4 Apr 2023 08:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AABCF409D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7domGpU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vd_S8umyH5e2; Tue,  4 Apr 2023 08:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4683C401C2;
	Tue,  4 Apr 2023 08:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4683C401C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC4DC0036;
	Tue,  4 Apr 2023 08:05:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BDCAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16775409D8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:05:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16775409D8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEchjiUs_IlU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:05:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71539401C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71539401C2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680595525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4PWSjtw5OZmTNkv2TLwma+qz6gck6KzkNs4p4mRICk=;
 b=D7domGpUC+DjErckfHYSIfxFmv6gh772bK7AjuANegVsItDE8TKeJz1Zt3CCQ7xte0UBq9
 Q0JATII/qk/Y5Han/TEQ6G56k1dUr6vkzJWuyP2HTkZHrgRykmRwOIocO46c3v4J/Qak9c
 v582pOTxl9JD4jKEE/aSGFXoNZYpCeQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-hUv0deU9O6iZGe6DkxvkWg-1; Tue, 04 Apr 2023 04:05:24 -0400
X-MC-Unique: hUv0deU9O6iZGe6DkxvkWg-1
Received: by mail-ot1-f71.google.com with SMTP id
 c24-20020a9d67d8000000b006a39141668cso282345otn.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 01:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680595523; x=1683187523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4PWSjtw5OZmTNkv2TLwma+qz6gck6KzkNs4p4mRICk=;
 b=sGoOo+8YbcDAcZ86I0STYqWdSWW2H/ADkbJsglCETfN71L/ySh8NWMF83yOkeCMgRa
 H0nL39izDrWozIJk5jWV6d/n9vYSfAoOCBqNXtAX3ehgQwYG2TD1Vg2lwz6u8381onrd
 FWmFMztzGbDx24oO5mAYEmuQlCpU/caZRvBbsRL85bDmQlEqixgkQRfueF9P6TkkCN1C
 SWnDct2EPtWfYzhP3QLatwmTdseg9vwsa6VHkmjOdtXCZgJ9IfnNRR5f5WavdQwH4NmW
 E1KlNF2r/BYU7B2dDKUhsQjSSX5j6tozO6Ktuf2Lr2hWyeQZyF3077cdCUdGYKQPGFzX
 Ym9g==
X-Gm-Message-State: AAQBX9dGdEF51IGgqcK5uFfAB50OzZZJF7eexytw0P1Ey+17UmbB09C6
 IP2UMcOVlcn0S9KIA7g3HsqDR2KB1GDrsgBvFhlKNvl7pz++ompf/OCpQDAo+zkRk3kfMYxdGa3
 ezBCwCqUaLY4FIM1E2ccXghN7Zm6EWpoAT2DDzqtrA1ulBgrpGjHoWPbyQQ==
X-Received: by 2002:a9d:75d1:0:b0:6a1:cbc6:f1b3 with SMTP id
 c17-20020a9d75d1000000b006a1cbc6f1b3mr600457otl.2.1680595523477; 
 Tue, 04 Apr 2023 01:05:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350bBw8AdbzUufY7E5YpLvRIixs3+aTWMWIXnO2UGRNWBCUDT+pEz7xtSsf5lpZY3Gyrg2H8EltFd4Gxt5mlAmIY=
X-Received: by 2002:a9d:75d1:0:b0:6a1:cbc6:f1b3 with SMTP id
 c17-20020a9d75d1000000b006a1cbc6f1b3mr600454otl.2.1680595523216; Tue, 04 Apr
 2023 01:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
 <CACGkMEuQo+ojjtjH=Ne0e5wESERUPmSvCDgTXwepz=TR7fO8RQ@mail.gmail.com>
 <AM0PR04MB47231B9400D7E491D1489611D4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB47231B9400D7E491D1489611D4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 16:05:12 +0800
Message-ID: <CACGkMEseqLP2m-bNir43_AOr221Y+EMai+Ragz0588sxKCYgRg@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "viktor@daynix.com" <viktor@daynix.com>, "mst@redhat.com" <mst@redhat.com>
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

T24gVHVlLCBBcHIgNCwgMjAyMyBhdCAzOjIw4oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiA+ID4gKyAqIEBraWNrX3ZxX3dpdGhfZGF0YTog
ICAgICAgICBLaWNrIHRoZSB2aXJ0cXVldWUgYW5kIHN1cHBseSBleHRyYSBkYXRhCj4gPiA+ICsg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKG9ubHkgaWYgVklSVElPX0ZfTk9USUZJQ0FU
SU9OX0RBVEEgaXMgbmVnb3RpYXRlZCkKPiA+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiA+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBAZGF0YTogaW5jbHVkZXMgdnFuLCBuZXh0X29mZiBhbmQgbmV4dF93cmFwIGZvcgo+ID4g
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tlZCB2aXJ0cXVldWVzCj4gPgo+
ID4gVGhpcyBuZWVkcyBzb21lIHR3ZWFraW5nLCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSB3
b3JrcyBmb3Igc3BsaXQKPiA+IHZpcnRxdWV1ZSBhcyB3ZWxsLgo+ID4KPgo+IEkgbWVhbnQgdGhh
dCBuZXh0X3dyYXAgaXMgZm9yIHBhY2tlZCBWUXMsIGJ1dCBJIHNlZSB5b3VyIHBvaW50LCBpdCdz
IG5vIGNsZWFyIGZyb20gdGhlIGNvbW1lbnQuCj4gSSdsbCBmaXggaXQgaW4gdjIuCgpuZXh0X3dy
YXAgd29ya3MgZm9yIHNwbGl0IGFzIHdlbGwsIHNwZWMgc2FpZAoKIgpXaXRob3V0IFZJUlRJT19G
X1JJTkdfUEFDS0VEIHRoaXMgaXMgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYml0IChiaXQgMTUpCm9m
IHRoZSBhdmFpbGFibGUgaW5kZXguCiIKClRoYW5rcwoKPgo+IFRoYW5rcwo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
