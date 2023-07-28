Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CFEC001DC
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 01:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6679340616;
	Fri, 28 Jul 2023 01:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6679340616
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNZylASW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDi88KEdm7Lj; Fri, 28 Jul 2023 01:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E56864012B;
	Fri, 28 Jul 2023 01:40:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E56864012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B39A3C0071;
	Fri, 28 Jul 2023 01:40:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E621FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2F1784092
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:40:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2F1784092
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNZylASW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIAdlfgmU8dS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:40:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF66684081
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 01:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF66684081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690508403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pN/ym8BrU7SB9ZbfxQKn7T8k7nbmNNGc1emjzZf6u4=;
 b=HNZylASWe3lEHios/txMzHXeeEywoNN1ADN1ubZd1t6WDaNq7bv0qMXzbJpFPAO2Zt1HtM
 0v8A0SALaVj2taGgmYqrKssxmT5Wk+8AVmtlMocfEwdplae8SqU+87AWfLs9V+EdLdqB8n
 FJGon2cifY2AGvvU7IGsaoJdVEHPjPQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-zCZUKF0QN7qwolGGmm7QCw-1; Thu, 27 Jul 2023 21:40:01 -0400
X-MC-Unique: zCZUKF0QN7qwolGGmm7QCw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b70bfc97e4so18697991fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 18:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690508400; x=1691113200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pN/ym8BrU7SB9ZbfxQKn7T8k7nbmNNGc1emjzZf6u4=;
 b=grDa7SHpbh7c8nVjdZf21+rID9QYjYGMYI+bXKfit6uLU9n8BsvCf++0laIog0/7yq
 XaUbnwVp4ChB7g2COqFsP4uUhhXoskd7bT7r9CkmvHkIevW5o8C9COl6KeKe1rV8GO8L
 IbOOnLtXTu/udDPTdWtB4r9DPryd0srEvyOy7nSucpzYkKr88Mlk0yoFhQ3sSV1lJbSV
 woG2NBpchcREvc8AIpV6ebdKZ46NqifPokWjK8UE4yESLLWVhl7iA/3egGAliJz20Xre
 A6gtyB5yYjRSakyaSWSsl9JNfedIsYVRM9mfKGI/J8xM9TCvUmUUMJJpg8T2jLvAppG9
 6uRg==
X-Gm-Message-State: ABy/qLYH1uQygRe81qXCXQBHAsb5+/a3BLHku9W0t2imYh027k3qGgJ7
 IGiVpgjS8X9ja+3ii46qvPMo2EsSyNsVe6ysDXKwQxkqytW2Llqsgn8pIe9Cw0LgUVCDypw+vBF
 McMwQ0jdU8dbr29OntirvXFiNfhJTKsP/zMg3q7NTHx/uvv3IGODga6Wr0Q==
X-Received: by 2002:a2e:a209:0:b0:2b6:d137:b61c with SMTP id
 h9-20020a2ea209000000b002b6d137b61cmr441077ljm.39.1690508400564; 
 Thu, 27 Jul 2023 18:40:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGab46NQRatFjFpsN54F27KgE8MufnbMbfw9gfYF6c93BHJSpvkz53N2RdBZe8GLRXOISNFHSGw4FAtqFK+QmU=
X-Received: by 2002:a2e:a209:0:b0:2b6:d137:b61c with SMTP id
 h9-20020a2ea209000000b002b6d137b61cmr441072ljm.39.1690508400375; Thu, 27 Jul
 2023 18:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727172354.68243-2-dtatulea@nvidia.com>
In-Reply-To: <20230727172354.68243-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jul 2023 09:39:49 +0800
Message-ID: <CACGkMEt5+O1Q1=SvPpD5kwhEnoLNva73Uew0vaWBVXW3xE-o0Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Correct default number of queues when MQ is on
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgMToyNeKAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IFRoZSBzdGFuZGFyZCBzcGVjaWZpZXMgdGhhdCB0aGUg
aW5pdGlhbCBudW1iZXIgb2YgcXVldWVzIGlzIHRoZQo+IGRlZmF1bHQsIHdoaWNoIGlzIDEgKDEg
dHgsIDEgcngpLgo+Cj4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52
aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQu
Y29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDEwICsrKysrKysr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDkxMzhlZjJmYjJjOC4uNmI2ZWI2OWE4
YTkwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0yNTE3LDcgKzI1MTcs
MTUgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiAgICAgICAgIGVsc2UKPiAgICAgICAgICAg
ICAgICAgbmRldi0+cnF0X3NpemUgPSAxOwo+Cj4gLSAgICAgICBuZGV2LT5jdXJfbnVtX3ZxcyA9
IDIgKiBuZGV2LT5ycXRfc2l6ZTsKPiArICAgICAgIC8qIERldmljZSBtdXN0IHN0YXJ0IHdpdGgg
MSBxdWV1ZSBwYWlyLCBhcyBwZXIgVklSVElPIHYxLjIgc3BlYywgc2VjdGlvbgo+ICsgICAgICAg
ICogNS4xLjYuNS41ICJEZXZpY2Ugb3BlcmF0aW9uIGluIG11bHRpcXVldWUgbW9kZSI6Cj4gKyAg
ICAgICAgKgo+ICsgICAgICAgICogTXVsdGlxdWV1ZSBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lgo+
ICsgICAgICAgICogVGhlIGRyaXZlciBlbmFibGVzIG11bHRpcXVldWUgYnkgc2VuZGluZyBhIGNv
bW1hbmQgdXNpbmcgY2xhc3MKPiArICAgICAgICAqIFZJUlRJT19ORVRfQ1RSTF9NUS4gVGhlIGNv
bW1hbmQgc2VsZWN0cyB0aGUgbW9kZSBvZiBtdWx0aXF1ZXVlCj4gKyAgICAgICAgKiBvcGVyYXRp
b24sIGFzIGZvbGxvd3M6IC4uLgo+ICsgICAgICAgICovCj4gKyAgICAgICBuZGV2LT5jdXJfbnVt
X3ZxcyA9IDI7Cj4KPiAgICAgICAgIHVwZGF0ZV9jdnFfaW5mbyhtdmRldik7Cj4gICAgICAgICBy
ZXR1cm4gZXJyOwo+IC0tCj4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
