Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF357C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 08:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0F7D4174C;
	Wed, 13 Apr 2022 08:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fu10vYs9xP6X; Wed, 13 Apr 2022 08:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 101674021D;
	Wed, 13 Apr 2022 08:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0F3DC002F;
	Wed, 13 Apr 2022 08:14:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 829A2C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61C3A60A82
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-EoCc2LBoLA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:14:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B53B460067
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649837680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JaCjRDhcAQlFYlhtWNYdWseSonfQzqPpylM0vuUlol8=;
 b=UYdo1++MgYqVGkehgkrbR+sqsaRl87ScafBbec3epv9bbu6hry3PELnj5WSioR0vRPIjh0
 P58Jf6GInkG9UfaqHkxBCma81uGRKOTUxqBnPoG8uynkoD4Mf9rzlMKNe2mbfl34VeVV18
 21HyC3E1qhECzH6l53Ijy/E/uXt7joI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-98yTDR7AN8SBVB1BRbL6Zg-1; Wed, 13 Apr 2022 04:14:37 -0400
X-MC-Unique: 98yTDR7AN8SBVB1BRbL6Zg-1
Received: by mail-pg1-f197.google.com with SMTP id
 t3-20020a656083000000b0039cf337edd6so722350pgu.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 01:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JaCjRDhcAQlFYlhtWNYdWseSonfQzqPpylM0vuUlol8=;
 b=n29NqshJcm9Olb5Cnf2bvhZ1gI+k3IRq2he+dm/NUGvzydN43abMqgysLQ0YU6KDeV
 ZFsG6wxbo1ZTBNddcjC5Qc1wEoIn0xKBKAhqK/xP2yhArtswb4njSuFgeIGc4T9XnpoJ
 i2KrPaR12LsHvXhg5J+fbigTVdgJvUgP6eOGd5grvcpVv1HfMvEuvTFhw3bqJWDS8Y72
 8nTHBWMEs1C4Bx7z1au5e/y1/Jr2rYteNLvr4UVXrLPY6a0FZcZ+KcdHLaP/UgL6ZWBB
 /vAWNa2phkAbWt2hMPdYaT4fJW72vKOaKQi5erHGOtzMkRFFBzrFyy7sEyTvTKhFo5ra
 Ba1g==
X-Gm-Message-State: AOAM532+Xt0cEUTBX7ypdufToeY8aK/tWtcOU8cUcWb5jI6s8JGysLQN
 oxgqOjiTtdzcZbiPBXwSP75NQuy0zGAk5+rTo367J2QewdO69cjuXcI35JE/g9IwICFc5p5eFcY
 1itNo7dX57hncwte8CusnknVvhBhfkqt1wILL1HUOhA==
X-Received: by 2002:a17:903:1249:b0:154:c472:de6b with SMTP id
 u9-20020a170903124900b00154c472de6bmr41955319plh.38.1649837676550; 
 Wed, 13 Apr 2022 01:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ajsGKGH1EatN+KQ2iXpuRaWGLXVOtaxxTRwpviTqMpWsY8kzjD8kvbSeAKA1g9Dz34bxIg==
X-Received: by 2002:a17:903:1249:b0:154:c472:de6b with SMTP id
 u9-20020a170903124900b00154c472de6bmr41955301plh.38.1649837676273; 
 Wed, 13 Apr 2022 01:14:36 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d26-20020aa797ba000000b00505f0ed6494sm5963955pfq.192.2022.04.13.01.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 01:14:35 -0700 (PDT)
Message-ID: <f3f60d6e-a506-bd58-d763-848beb0e4c26@redhat.com>
Date: Wed, 13 Apr 2022 16:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] vDPA/ifcvf: assign nr_vring to the MSI vector of
 config_intr by default
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220408121013.54709-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220408121013.54709-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzQvOCDkuIvljYg4OjEwLCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+IFRoaXMgY29t
bWl0IGFzc2lnbiBzdHJ1Y3QgaWZjdmZfaHcubnJfdnJpbmcgdG8gdGhlIE1TSVggdmVjdG9yIG9m
IHRoZQo+IGNvbmZpZyBpbnRlcnJ1cHQgYnkgZGVmYXVsdCBpbiBpZmN2Zl9yZXF1ZXN0X2NvbmZp
Z19pcnEoKS4KPiBpZmN2Zl9ody5ucl92cmluZyBpcyB0aGUgbW9zdCBsaWtlbHkgYW5kIHRoZSBp
ZGVhbCBjYXNlIGZvcgo+IHRoZSBkZXZpY2UgY29uZmlnIGludGVycnVwdCBoYW5kbGluZywgbWVh
bnMgZXZlcnkgdmlydHF1ZXVlIGhhcwo+IGFuIGluZGl2aWR1YWwgTVNJWCB2ZWN0b3IoMCB+IG5y
X3ZyaW5nIC0gMSksIGFuZCB0aGUgY29uZmlnIGludGVycnVwdCBoYXMKPiBpdHMgb3duIE1TSVgg
dmVjdG9yKG51bWJlciBucl92cmluZykuCj4KPiBUaGlzIGNoYW5nZSBjYW4gYWxzbyBtYWtlIEdD
QyBXID0gMiBoYXBweSwgc2lsZW5jZSB0aGUKPiAidW5pbml0aWFsaXplZCIgd2FybmluZy4KPgo+
IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiBS
ZXZpZXdlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDggKysrKy0tLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCA0MzY2MzIwZmI2OGQuLmI1MDBmYjk0MWRhYiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC0yOTAsMTMgKzI5MCwxMyBAQCBzdGF0aWMgaW50
IGlmY3ZmX3JlcXVlc3RfY29uZmlnX2lycShzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikK
PiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gJmFkYXB0ZXItPnZmOwo+ICAgCWludCBjb25maWdf
dmVjdG9yLCByZXQ7Cj4gICAKPiArCS8qIHZlY3RvciAwIH4gdmYtPm5yX3ZyaW5nIGZvciB2cXMs
IG51bSB2Zi0+bnJfdnJpbmcgdmVjdG9yIGZvciBjb25maWcgaW50ZXJydXB0ICovCgoKVGhlIGNv
bW1lbnQgaXMgcmlnaHQgYmVmb3JlIHRoaXMgcGF0Y2gsIGJ1dCBwcm9iYWJseSB3cm9uZyBmb3Ig
Ck1TSVhfVkVDVE9SX0RFVl9TSEFSRUQuCgoKPiArCWNvbmZpZ192ZWN0b3IgPSB2Zi0+bnJfdnJp
bmc7Cj4gKwo+ICsJLyogcmUtdXNlIHRoZSB2cXMgdmVjdG9yICovCj4gICAJaWYgKHZmLT5tc2l4
X3ZlY3Rvcl9zdGF0dXMgPT0gTVNJWF9WRUNUT1JfREVWX1NIQVJFRCkKPiAgIAkJcmV0dXJuIDA7
Cj4gICAKPiAtCWlmICh2Zi0+bXNpeF92ZWN0b3Jfc3RhdHVzID09IE1TSVhfVkVDVE9SX1BFUl9W
UV9BTkRfQ09ORklHKQo+IC0JCS8qIHZlY3RvciAwIH4gdmYtPm5yX3ZyaW5nIGZvciB2cXMsIG51
bSB2Zi0+bnJfdnJpbmcgdmVjdG9yIGZvciBjb25maWcgaW50ZXJydXB0ICovCj4gLQkJY29uZmln
X3ZlY3RvciA9IHZmLT5ucl92cmluZzsKPiAtCj4gICAJaWYgKHZmLT5tc2l4X3ZlY3Rvcl9zdGF0
dXMgPT0gIE1TSVhfVkVDVE9SX1NIQVJFRF9WUV9BTkRfQ09ORklHKQo+ICAgCQkvKiB2ZWN0b3Ig
MCBmb3IgdnFzIGFuZCAxIGZvciBjb25maWcgaW50ZXJydXB0ICovCj4gICAJCWNvbmZpZ192ZWN0
b3IgPSAxOwoKCkFjdHVhbGx5LCBJIHByZWZlciB0byB1c2UgaWYgLi4uIGVsc2UgLi4uIGhlcmUu
CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
