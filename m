Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE21C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D270428D3;
	Fri, 26 May 2023 06:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D270428D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d5q4DXgP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U92PGSFsEL6h; Fri, 26 May 2023 06:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AD46428D1;
	Fri, 26 May 2023 06:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AD46428D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1971CC0036;
	Fri, 26 May 2023 06:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BE0DC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D1B884389
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D1B884389
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d5q4DXgP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRoocuC8NSCc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:57:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 550DB84383
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 550DB84383
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685084261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ze1eBV4qRCm3f7jG4VXgl0UZTu4+F/diGmfSJICaiCw=;
 b=d5q4DXgPwsSEQeTtuUBnZevL7a0WmWOiGE2M0jTc9tQosCawLWmmUPtL83E0reaZTEqCx+
 msBz+xCSh3Mx62iMwN/7DkcyrD+VA5WZ0CxixDBYTo8WUfo2XgSdK5NvE2DdY4rljD9ogs
 qYEBExJFfvAyhlpp844adsGbdKjxarE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-vqPrejNdMgyRi-i0mGEPww-1; Fri, 26 May 2023 02:57:39 -0400
X-MC-Unique: vqPrejNdMgyRi-i0mGEPww-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af20808e06so1838171fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 23:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685084258; x=1687676258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ze1eBV4qRCm3f7jG4VXgl0UZTu4+F/diGmfSJICaiCw=;
 b=DatIcqX2Nj/41Bs15YyKAoiIdrr81Pagerk2pmG0ogl2BY7RdPokVTg4wNQTOrxji3
 J8mucYfwJQTReV6rZPO6xdB0JFU+EbIlhymOoK7sDZjl+Vq4wBdzZtCEHksCbRrtJrmI
 j36NXVNhLSCZxQ8rW9n+/4YHh4GfBH1D/v8hGZqKy/SbCaNFQn/g+K7uTjvn0lA+N+yR
 6XQkCaEHG4jTNnFYW2/nat6cahIX9axPkzg4HYhS/jtteqQu2funDhavsdhfGBcd28xR
 brdrENHJCfAnZLhfqdQZLdTKY2h9Y6yoV/lllNCytD8psmlOSh6fhJ3tjwLG/rrXAK+d
 NMWA==
X-Gm-Message-State: AC+VfDxpRk7RwBQ8J6KLzv1J+bGv+uLp1p77QFcdDmPlFK4MkT417Szr
 BRfHmzNVLwK9KETCb24TT+NvTVNXHuXVL2dyQ0w0hV8HpEN7BVgNIu6WPFzCS7SEj6X7XK4BC8r
 I8//kUI4/Bvj4ggqxix/18S/yUbQFBckX9HFpfnGqsp0alMf/S/u+Yozlpw==
X-Received: by 2002:a2e:988a:0:b0:2af:19dd:ecda with SMTP id
 b10-20020a2e988a000000b002af19ddecdamr270645ljj.45.1685084258304; 
 Thu, 25 May 2023 23:57:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RUV+CPVbAikpmqLlt9KyfhEdW/YgA62KOwWCN81f6RByJJ2V+wLWEBsXzQPG8RpdaSOEsVayioAzSUl9FlpE=
X-Received: by 2002:a2e:988a:0:b0:2af:19dd:ecda with SMTP id
 b10-20020a2e988a000000b002af19ddecdamr270630ljj.45.1685084257924; Thu, 25 May
 2023 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-4-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-4-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:57:26 +0800
Message-ID: <CACGkMEsnto9APpDo1uzVJAWBwk9f8pt6D=J41tdf1ZQ63ADK9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: Introduce DMA pre-handler
To: Liang Chen <liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTo0N+KAr1BNIExpYW5nIENoZW4gPGxpYW5nY2hlbi5s
aW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQ3VycmVudGx5LCBETUEgb3BlcmF0aW9ucyBvZiB2
aXJ0aW8gZGV2aWNlcycgZGF0YSBidWZmZXIgYXJlIGVuY2Fwc3VsYXRlZAo+IHdpdGhpbiB0aGUg
dW5kZXJseWluZyB2aXJ0cXVldWUgaW1wbGVtZW50YXRpb24uIERNQSBtYXAvdW5tYXAgb3BlcmF0
aW9ucwo+IGFyZSBwZXJmb3JtZWQgZm9yIGVhY2ggZGF0YSBidWZmZXIgYXR0YWNoZWQgdG8vZGV0
YWNoZWQgZnJvbSB0aGUgdmlydHF1ZXVlLAo+IHdoaWNoIGlzIHRyYW5zcGFyZW50IGFuZCBpbnZp
c2libGUgdG8gdGhlIGhpZ2hlci1sZXZlbCB2aXJ0aW8gZGV2aWNlCj4gZHJpdmVycy4gVGhpcyBl
bmNhcHN1bGF0aW9uIG1ha2VzIGl0IG5vdCB2aWFibGUgZm9yIGRldmljZSBkcml2ZXJzIHRvCj4g
aW50cm9kdWNlIGNlcnRhaW4gbWVjaGFuaXNtcywgc3VjaCBhcyBwYWdlIHBvb2wsIHRoYXQgcmVx
dWlyZSBleHBsaWNpdAo+IG1hbmFnZW1lbnQgb2YgRE1BIG1hcC91bm1hcC4gVGhlcmVmb3JlLCBi
eSBpbnNlcnRpbmcgYSBwcmUtaGFuZGxlciBiZWZvcmUKPiB0aGUgZ2VuZXJpYyBETUEgbWFwL3Vu
bWFwIG9wZXJhdGlvbnMsIHZpcnRpbyBkZXZpY2UgZHJpdmVycyBoYXZlIHRoZQo+IG9wcG9ydHVu
aXR5IHRvIHBhcnRpY2lwYXRlIGluIERNQSBvcGVyYXRpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTog
TGlhbmcgQ2hlbiA8bGlhbmdjaGVuLmxpbnV4QGdtYWlsLmNvbT4KClNvIFh1YW4gaXMgZG9pbmcg
QUZfWERQIGZvciB0aGUgdmlydGlvLW5ldCB0aGF0IGFsbG93cyB0aGUgRE1BIHRvIGJlCm1hcHBl
ZCBhdCBsZWFzdCBieSB0aGUgdmlydGlvLW5ldC4KCkl0IGxvb2tzIGxpa2UgYSB3YXkgdG8gYWxs
b3cgdmlydGlvLW5ldCB0byBtYXAgYW5kIHVubWFwIHRoZSBETUEKYnVmZmVyIGJ5IGl0c2VsZiwg
YnV0IHRoaXMgcGF0Y2ggZ29lcyBpbnRvIGFub3RoZXIgd2F5IHdoaWNoIHNlZW1zIHRvCnF1ZXJ5
IHRoZSBhZGRyZXNzIGZyb20gdGhlIHZpcnRpbyBjb3JlLgoKUGVyc29uYWxseSwgSSB0aGluayBt
YXAgYW5kIHN5bmMgYnkgdGhlIHZpcnRpby1uZXQgZHJpdmVyIHNlZW1zIGNsZWFuLgpCdXQgd2Ug
Y2FuIHNlZS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
