Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E3AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F256641512;
	Wed,  9 Feb 2022 04:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7L2m489tYym; Wed,  9 Feb 2022 04:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9485F414C2;
	Wed,  9 Feb 2022 04:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9CDC001A;
	Wed,  9 Feb 2022 04:42:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CDDC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47B0C414C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yI9CQg_A1fm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 957AE414C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644381755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaq4rpOgDgAbrBPGfd0R9MJrfvV414wZMPHWroYPN5k=;
 b=WJgH+2cA0Vh4zjL88qj3/BsLZ2W2Ha5Qi3Hqklvvs1qq1P0kq9MgvxuwfqKnOfddQloae8
 3mIVllqojksGhOpevo/CIEpCxJ2acQtd4sfaw9b5+DHYa3Z2vT19sLYtipQXtluoywRMVY
 6EtbBLOUwXypngDlZq4h7rvMCcyLvXg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-pIPJSGcRMnenYcwbzirSLA-1; Tue, 08 Feb 2022 23:42:34 -0500
X-MC-Unique: pIPJSGcRMnenYcwbzirSLA-1
Received: by mail-pj1-f71.google.com with SMTP id
 g14-20020a17090a7d0e00b001b8ef9f9545so2800820pjl.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yaq4rpOgDgAbrBPGfd0R9MJrfvV414wZMPHWroYPN5k=;
 b=fed/B955ih+uF1NUDorQBRs9QCEtKmiDRWGP1RuDQEznd2d/JI6N7qL4mIoZRTF8Tj
 u25FeHqadkaLF2zoHSwzAt8AiiuoumLd45m+VrzGpkMnZTgqFriUQJ5WZViJqGB89TPn
 JnypADKgrYIsACelKKw81PWutpV313+Lj3CC2LliyLoT9iAOyurKo9q6kcCSI9ytA4wl
 H/mQ9oR3yz3S4YmHYt6BlxcMvomOZetmaFCzbOZX4HGskKkZcH8ejGNb/AJ44onJdg73
 DhXJt/RH1DZitsQdw5pzc/LuXcjcDJojwwrXCtYaplDDmdMV9slqUouYCebqHD646xJP
 EbcQ==
X-Gm-Message-State: AOAM531w5GLDM6NRAQbtqI0mteaTzkTaGdc560c4UPDI1J6TwrGowoTu
 nIiRxBI5bZ/mln8OteoPen8jwuvOZ5peDvuwu8D1uOkwteBQPBtq8FL6ciXtU7IEK1IWGVZvJER
 Ynx2P+tdLBFfSP7yCm/wV0drXqr2MVh5WuSIcMgEbnA==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr625902pjz.36.1644381753275; 
 Tue, 08 Feb 2022 20:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybr0rixmXjHT+8KfaprN9MEJ5npqWoXnDzZIPoVnL2fUOHdcT9dt7lsJLeGDIgt0wSg3oZGw==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr625883pjz.36.1644381753000; 
 Tue, 08 Feb 2022 20:42:33 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 16sm7028826pfm.200.2022.02.08.20.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 20:42:32 -0800 (PST)
Message-ID: <e5410a91-f9ac-6987-5de0-728a50431225@redhat.com>
Date: Wed, 9 Feb 2022 12:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 4/5] linux/virtio_net.h: Added Support for GSO_UDP_L4
 offload.
To: Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-5-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-5-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0NywgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBO
b3csIGl0J3MgcG9zc2libGUgdG8gY29udmVydCB2bmV0IHBhY2tldHMgZnJvbS90byBza2IuCgoK
SSBzdWdnZXN0IHRvIGNoYW5nZSB0aGUgdGl0bGUgdG8gIm5ldDogc3VwcG9ydCBYWFggb2ZmbG9h
ZCBpbiB2bmV0IGhlYWRlciIKClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWVs
bnljaGVua28gPGFuZHJld0BkYXluaXguY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0
aW9fbmV0LmggfCAxMSArKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1
ZGUvbGludXgvdmlydGlvX25ldC5oCj4gaW5kZXggYTk2MGRlNjhhYzY5Li45MzExZDQxZDBhODEg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgKPiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19uZXQuaAo+IEBAIC0xNyw2ICsxNyw5IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCB2aXJ0aW9fbmV0X2hkcl9tYXRjaF9wcm90byhfX2JlMTYgcHJvdG9jb2wsIF9fdTggZ3NvX3R5
cGUpCj4gICAJY2FzZSBWSVJUSU9fTkVUX0hEUl9HU09fVURQOgo+ICAgCQlyZXR1cm4gcHJvdG9j
b2wgPT0gY3B1X3RvX2JlMTYoRVRIX1BfSVApIHx8Cj4gICAJCSAgICAgICBwcm90b2NvbCA9PSBj
cHVfdG9fYmUxNihFVEhfUF9JUFY2KTsKPiArCWNhc2UgVklSVElPX05FVF9IRFJfR1NPX1VEUF9M
NDoKPiArCQlyZXR1cm4gcHJvdG9jb2wgPT0gY3B1X3RvX2JlMTYoRVRIX1BfSVApIHx8Cj4gKwkJ
ICAgICAgIHByb3RvY29sID09IGNwdV90b19iZTE2KEVUSF9QX0lQVjYpOwo+ICAgCWRlZmF1bHQ6
Cj4gICAJCXJldHVybiBmYWxzZTsKPiAgIAl9Cj4gQEAgLTMxLDYgKzM0LDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgdmlydGlvX25ldF9oZHJfc2V0X3Byb3RvKHN0cnVjdCBza19idWZmICpza2IsCj4g
ICAJc3dpdGNoIChoZHItPmdzb190eXBlICYgflZJUlRJT19ORVRfSERSX0dTT19FQ04pIHsKPiAg
IAljYXNlIFZJUlRJT19ORVRfSERSX0dTT19UQ1BWNDoKPiAgIAljYXNlIFZJUlRJT19ORVRfSERS
X0dTT19VRFA6Cj4gKwljYXNlIFZJUlRJT19ORVRfSERSX0dTT19VRFBfTDQ6Cj4gICAJCXNrYi0+
cHJvdG9jb2wgPSBjcHVfdG9fYmUxNihFVEhfUF9JUCk7Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2Ug
VklSVElPX05FVF9IRFJfR1NPX1RDUFY2Ogo+IEBAIC02OSw2ICs3MywxMSBAQCBzdGF0aWMgaW5s
aW5lIGludCB2aXJ0aW9fbmV0X2hkcl90b19za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiAgIAkJ
CWlwX3Byb3RvID0gSVBQUk9UT19VRFA7Cj4gICAJCQl0aGxlbiA9IHNpemVvZihzdHJ1Y3QgdWRw
aGRyKTsKPiAgIAkJCWJyZWFrOwo+ICsJCWNhc2UgVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNDoK
PiArCQkJZ3NvX3R5cGUgPSBTS0JfR1NPX1VEUF9MNDsKPiArCQkJaXBfcHJvdG8gPSBJUFBST1RP
X1VEUDsKPiArCQkJdGhsZW4gPSBzaXplb2Yoc3RydWN0IHVkcGhkcik7Cj4gKwkJCWJyZWFrOwo+
ICAgCQlkZWZhdWx0Ogo+ICAgCQkJcmV0dXJuIC1FSU5WQUw7Cj4gICAJCX0KPiBAQCAtMTgyLDYg
KzE5MSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKGNvbnN0
IHN0cnVjdCBza19idWZmICpza2IsCj4gICAJCQloZHItPmdzb190eXBlID0gVklSVElPX05FVF9I
RFJfR1NPX1RDUFY0Owo+ICAgCQllbHNlIGlmIChzaW5mby0+Z3NvX3R5cGUgJiBTS0JfR1NPX1RD
UFY2KQo+ICAgCQkJaGRyLT5nc29fdHlwZSA9IFZJUlRJT19ORVRfSERSX0dTT19UQ1BWNjsKPiAr
CQllbHNlIGlmIChzaW5mby0+Z3NvX3R5cGUgJiBTS0JfR1NPX1VEUF9MNCkKPiArCQkJaGRyLT5n
c29fdHlwZSA9IFZJUlRJT19ORVRfSERSX0dTT19VRFBfTDQ7Cj4gICAJCWVsc2UKPiAgIAkJCXJl
dHVybiAtRUlOVkFMOwo+ICAgCQlpZiAoc2luZm8tPmdzb190eXBlICYgU0tCX0dTT19UQ1BfRUNO
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
