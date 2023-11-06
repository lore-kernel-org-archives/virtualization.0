Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7771FC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCC2A41DD9;
	Mon,  6 Nov 2023 07:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCC2A41DD9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dd2jbEiU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iAogGaGAut9y; Mon,  6 Nov 2023 07:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9EC841749;
	Mon,  6 Nov 2023 07:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9EC841749
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A00B5C0071;
	Mon,  6 Nov 2023 07:25:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3BCC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C882D60FD4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C882D60FD4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dd2jbEiU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5EtqE8qgp2se
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:25:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E10CB60E70
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E10CB60E70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnPjZZzSQXWY9ANNSnV7yHw6hBbYFuGXz/mnxSTQkCQ=;
 b=dd2jbEiUt6mixDogi9rMDQcu8u4JR3xV6gtn8lxOuJYaOmfIMH6ZdsTlWNI+HUz3mZKu1y
 /5ahlNwunyoDxq54GBJZh2GuZkceXOuWJeeJJ/NgPwjMJQZKqHEt4AemHkmpS4uU0qn3Rs
 BEGKB/ScBx7TNpRh1PKty6PCzqHPSEg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-fL1F3PP_MJW6GTPlBWqSqQ-1; Mon, 06 Nov 2023 02:25:45 -0500
X-MC-Unique: fL1F3PP_MJW6GTPlBWqSqQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5094490b607so4213425e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 23:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255544; x=1699860344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnPjZZzSQXWY9ANNSnV7yHw6hBbYFuGXz/mnxSTQkCQ=;
 b=klCzr+EnlbAaa+RjH37u+dX+YWxUAmjLZTvz1q8e652YWHO2jvaUNDaJFfUkvkuaLo
 JgJOC0BSmEko2GI5m/OuRchxayPLf539XrWPqbMVkn/Eb9NeoLaAzR8vwwaqqQPZONzT
 Rgl1UIlu2CHzcvayVwELYsU+qe8xP939CMuMJJ5m1+Z8axhblaa21feLdC/0dsUlha0z
 ezC6RBUfgkbGak7j1L/h2lJIqWbkVr9qFRKgh7By2E9qix2FaqSo5o90rlw9Q+lGpjD9
 4IJNRje83tVdTVyEtuxT9UEAypz9mQ7iO1Mm3HnhvzV252aL2qaK6tJg6chQFpuIwJdI
 qF1g==
X-Gm-Message-State: AOJu0YyLi8GWZvi0IKqiCMetFO2Jri8WEQa/8SYvUI0SOhOeFOf+yD7Z
 zkj5f88og11wxj2yon/KnUwnWoaMKjU41dTpKV1acKaLBU7KlJ3rdrPJ+LoqeaCDv+PkFYrcu/V
 30JfOeTGHsKO4BIbimnvNanu/hyDP3WG89HAS0OFTkpFfmCrzx7ILyfU+Qg==
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id
 k4-20020ac257c4000000b004fdc7155667mr18797007lfo.20.1699255543985; 
 Sun, 05 Nov 2023 23:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGupcEpyFhjhM0FIOwp9UBm5oZuh57MUCs1hrDYjzMwG3NN6dklFvm80eN8mYejg9VfW1D3EymTIZw6vWamomw=
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id
 k4-20020ac257c4000000b004fdc7155667mr18797001lfo.20.1699255543700; Sun, 05
 Nov 2023 23:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-8-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:25:32 +0800
Message-ID: <CACGkMEuEpQinKo4zMVJ_MohPH8PkG9vx0MrhX4B_9d4UKkoV-w@mail.gmail.com>
Subject: Re: [RFC v1 7/8] vp_vdpa::Add support for iommufd
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU2F0LCBOb3YgNCwgMjAyMyBhdCAxOjE34oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBBZGQgbmV3IHZkcGFfY29uZmlnX29wcyBmdW5jdGlvbiB0byBzdXBwb3J0
IGlvbW11ZmQKPgo+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDQgKysrKwo+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZpcnRpb19wY2kvdnBfdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5j
Cj4gaW5kZXggMjgxMjg3ZmFlODlmLi5kZDJjMzcyZDM2YTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19w
Y2kvdnBfdmRwYS5jCj4gQEAgLTQ2MCw2ICs0NjAsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2
ZHBhX2NvbmZpZ19vcHMgdnBfdmRwYV9vcHMgPSB7Cj4gICAgICAgICAuc2V0X2NvbmZpZyAgICAg
PSB2cF92ZHBhX3NldF9jb25maWcsCj4gICAgICAgICAuc2V0X2NvbmZpZ19jYiAgPSB2cF92ZHBh
X3NldF9jb25maWdfY2IsCj4gICAgICAgICAuZ2V0X3ZxX2lycSAgICAgPSB2cF92ZHBhX2dldF92
cV9pcnEsCj4gKyAgICAgICAuYmluZF9pb21tdWZkID0gdmRwYV9pb21tdWZkX3BoeXNpY2FsX2Jp
bmQsCj4gKyAgICAgICAudW5iaW5kX2lvbW11ZmQgPSB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfdW5i
aW5kLAo+ICsgICAgICAgLmF0dGFjaF9pb2FzID0gdmRwYV9pb21tdWZkX3BoeXNpY2FsX2F0dGFj
aF9pb2FzLAo+ICsgICAgICAgLmRldGFjaF9pb2FzID0gdmRwYV9pb21tdWZkX3BoeXNpY2FsX2Rl
dGFjaF9pb2FzLAoKRm9yIHRoZSBkZXZpY2UgdGhhdCBkZXBlbmRzIG9uIHRoZSBwbGF0Zm9ybSBJ
T01NVSwgYW55IHJlYXNvbiB3ZSBzdGlsbApib3RoZXIgYSBwZXIgZGV2aWNlIGNvbmZpZyBvcHMg
aGVyZSBqdXN0IGFzIGFuIGluZGlyZWN0aW9uPwoKVGhhbmtzCgo+ICB9Owo+Cj4gIHN0YXRpYyB2
b2lkIHZwX3ZkcGFfZnJlZV9pcnFfdmVjdG9ycyh2b2lkICpkYXRhKQo+IC0tCj4gMi4zNC4zCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
