Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11498EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 02:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 791B840589;
	Wed, 28 Jun 2023 02:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 791B840589
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU/q/H2V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7NfIZw6MLET; Wed, 28 Jun 2023 02:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1198F401D2;
	Wed, 28 Jun 2023 02:35:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1198F401D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1E0DC0072;
	Wed, 28 Jun 2023 02:35:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8606CC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 607EB40576
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:35:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 607EB40576
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cFY2nfia8b-h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3022401D2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3022401D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687919710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRFSqjQ8goVbgezkdLbcR17PF9Y4JZ+FcQZ0y0X5sGQ=;
 b=UU/q/H2VC/4SgJi41WmXlouT1og/lrf+jpjWfUtkCr6VCEFoawa4j3815XP3VW53j0fLt5
 ZqJA6MGdrKWxCynwf6Qy79pFoKq+A3EOX7CItoRZgbMEMz+fD4Q4D/gNRiV9bliTqwPf4S
 wIW5Q5bsnNsFI1CWZSYHUSSyitrP7vY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-wma9Z--ZMACTosIgcQ1OQQ-1; Tue, 27 Jun 2023 22:35:09 -0400
X-MC-Unique: wma9Z--ZMACTosIgcQ1OQQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb76659d54so2852971e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 19:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687919707; x=1690511707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRFSqjQ8goVbgezkdLbcR17PF9Y4JZ+FcQZ0y0X5sGQ=;
 b=BSZJ+2WxIw3HlMTHmQ4oowSKBHC+uXxAHyaiUDSxYRbHefQXZqG/p0AJYbxhHvhCFM
 rqrGUa++5TACl/oGWjFqmJiP2F4vgPZBf3hlKh9nUY+drphIl2eWQPtpgAAC4ZIbm9f0
 J3FwiNquAh1PCaLfjfy/qZbvD/v/9xF6ug8fRfvOuWXoAaJ5k8FJGjiTJXehkje1lWfF
 Zc4Am+M9YY4Qh0iDqAbYJMvFK6lJmmfsbGNzkUIneTzCZ7wJVKEphOV+XMpQLYO3g5N9
 0DNG/Mot6MSIcQhj5US0Cm3cGz/RC9yssG8eeGB8HRS4nq1ruBT2vv64wOjZydcIo1VX
 4FTg==
X-Gm-Message-State: AC+VfDyet0fBuY5DKxalblYvc8MeVL9OBKVjxeISYk7xUJsJn/EfBqmP
 z2o0AfE/NF/PcBAGaC3aR9k48vqbEYme9UOz8JHCl3KtWWRVLv54jeFfogcksKStgFsHeSJ/Ukj
 fPDbPL4ETQqurl/BnvGLxPmCTMfhjvsFHMLK0jv+xHKJdf7x58uTN82tEpQ==
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca0:9334 with SMTP id
 u4-20020a056512128400b004f95ca09334mr13621881lfs.34.1687919706918; 
 Tue, 27 Jun 2023 19:35:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xylHTvh/QQtP38BdSnzUfN0JkrGyzTKp0POais1RFAfmEoycQEQtV+DQPp1OpEQfGy/r+jgJaS3aGfUM8vzg=
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca0:9334 with SMTP id
 u4-20020a056512128400b004f95ca09334mr13621868lfs.34.1687919706658; Tue, 27
 Jun 2023 19:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230627113652.65283-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 10:34:55 +0800
Message-ID: <CACGkMEuKyeFoaAfVfBKMv43sdX7GQDQyDLO-+eukg29t+0Ef0g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 eperezma@redhat.com, david.marchand@redhat.com
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgNzozN+KAr1BNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBhZGRzIFZpcnRpby1u
ZXQgZGV2aWNlIHR5cGUgdG8gdGhlIHN1cHBvcnRlZAo+IGRldmljZXMgdHlwZXMuIEluaXRpYWxp
emF0aW9uIGZhaWxzIGlmIHRoZSBkZXZpY2UgZG9lcwo+IG5vdCBzdXBwb3J0IFZJUlRJT19GX1ZF
UlNJT05fMSBmZWF0dXJlLCBpbiBvcmRlciB0bwo+IGd1YXJhbnRlZSB0aGUgY29uZmlndXJhdGlv
biBzcGFjZSBpcyByZWFkLW9ubHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgQ29xdWVsaW4g
PG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIv
dmR1c2VfZGV2LmMgfCA2ICsrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCBjMWMyZjRjNzExYWUuLjg5
MDg4ZmEyNzAyNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC0xNDIs
NiArMTQyLDcgQEAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp2ZHVzZV9pcnFfYm91
bmRfd3E7Cj4KPiAgc3RhdGljIHUzMiBhbGxvd2VkX2RldmljZV9pZFtdID0gewo+ICAgICAgICAg
VklSVElPX0lEX0JMT0NLLAo+ICsgICAgICAgVklSVElPX0lEX05FVCwKPiAgfTsKPgo+ICBzdGF0
aWMgaW5saW5lIHN0cnVjdCB2ZHVzZV9kZXYgKnZkcGFfdG9fdmR1c2Uoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhKQo+IEBAIC0xNjY4LDYgKzE2NjksMTAgQEAgc3RhdGljIGJvb2wgZmVhdHVyZXNf
aXNfdmFsaWQoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZykKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAoY29uZmlnLT5mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19CTEtfRl9DT05G
SUdfV0NFKSkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPgo+ICsgICAgICAgaWYg
KChjb25maWctPmRldmljZV9pZCA9PSBWSVJUSU9fSURfTkVUKSAmJgo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICEoY29uZmlnLT5mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05f
MSkpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gKwo+ICAgICAgICAgcmV0dXJu
IHRydWU7Cj4gIH0KPgo+IEBAIC0yMDIzLDYgKzIwMjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHZkcGFfbWdtdGRldl9vcHMgdmRwYV9kZXZfbWdtdGRldl9vcHMgPSB7Cj4KPiAgc3RhdGljIHN0
cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7Cj4gICAgICAgICB7IFZJUlRJT19J
RF9CTE9DSywgVklSVElPX0RFVl9BTllfSUQgfSwKPiArICAgICAgIHsgVklSVElPX0lEX05FVCwg
VklSVElPX0RFVl9BTllfSUQgfSwKPiAgICAgICAgIHsgMCB9LAo+ICB9Owo+Cj4gLS0KPiAyLjQx
LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
