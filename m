Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B516C6FA8E
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 01:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEEB6610A0;
	Thu, 22 Sep 2022 01:39:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEEB6610A0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1XvmDlg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JsU8GM0jVmBH; Thu, 22 Sep 2022 01:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 388A060864;
	Thu, 22 Sep 2022 01:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 388A060864
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 044E2C0033;
	Thu, 22 Sep 2022 01:39:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3D47C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78EED41846
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78EED41846
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1XvmDlg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7I_eX1TDd1A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2D4941825
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2D4941825
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663810781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyylI6S78D0to8KJOV4qn2CDFp5MIulvTk/8RhI9Ulo=;
 b=U1XvmDlgEzlBtE7sHkQDq3IRMZdvmMynCRtGzA/lF0Q5Cp+9zuy12NeQ/ImwyjBwU9bV+S
 aAk+byolAMJV/mgdcwNc7ZePgXMczXDgnj8Tx2nGhdQ2FYCdXywXXOmmeO50rticRIFbvN
 3PMo1N8Nhwh5vDf/4pGYzHp6Ee8t+GM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-Aoyb0DzoMLOMNwoC9fpWZw-1; Wed, 21 Sep 2022 21:39:32 -0400
X-MC-Unique: Aoyb0DzoMLOMNwoC9fpWZw-1
Received: by mail-pg1-f200.google.com with SMTP id
 r7-20020a632047000000b00439d0709849so4408627pgm.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 18:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=TyylI6S78D0to8KJOV4qn2CDFp5MIulvTk/8RhI9Ulo=;
 b=ITIxf2SPru4HU0pFhT4HEZZCYSTaIYl5xg/1CJF1T29E/nRkzeSJ/IjcxyM849b0jh
 TtpAFaIc7CNXihdXszhulqwczE64iWs12rlGPf/RZileH9A2ozPzxy3L9Sqg6dCPMR3B
 OO9qoYsmIKSsimSx3+0fn5AEGJrU6Fmz9OEuZrpXX1S5DxMFR3kqJfPL6Fw4EgAfa+Xk
 qjBgfRh/O8sAyhIjQ7UKJOJ4Gi1fKRxmGgHhuCZXZNNl+yWvO2GGSyHhBB4CxTVgqpFt
 A1Lxu95T0sWwn3fWkahlmWMjetg6IF1wsoQwdGHMECP/awLX5WBqRLSKj8zsIFDYQO0E
 1/+A==
X-Gm-Message-State: ACrzQf1tNRpcHsLKFOZHPo7zPWtXbGhWJVpbjxhZWySMnCnsERIw4JrU
 EwsoRWhVrMtjZrPp3qWm13WgBPGtK42QCQsqAkT0/Ac+7ZA2cjDDt2Z4yDhZPji5KD6xJq/FzMa
 NvPgJRfFLFB4F00Fe82oM/A1lgdIulUiGaUw2Ti4QaA==
X-Received: by 2002:a17:90b:3843:b0:202:df54:4c10 with SMTP id
 nl3-20020a17090b384300b00202df544c10mr1061620pjb.100.1663810771713; 
 Wed, 21 Sep 2022 18:39:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6oFwx6a3DI+cicj7tL8pB2twl8+JQcb9PbYq2RXcEBMLEV3v3tVv9iJA92MJX2lydUK7QqOA==
X-Received: by 2002:a17:90b:3843:b0:202:df54:4c10 with SMTP id
 nl3-20020a17090b384300b00202df544c10mr1061600pjb.100.1663810771419; 
 Wed, 21 Sep 2022 18:39:31 -0700 (PDT)
Received: from [10.72.13.82] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 k18-20020aa79732000000b00545832dd969sm2908568pfg.145.2022.09.21.18.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Sep 2022 18:39:30 -0700 (PDT)
Message-ID: <5bab74d1-64fe-423c-32e8-c0047577bb68@redhat.com>
Date: Thu, 22 Sep 2022 09:39:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/2] virtio-net: introduce and use helper function for
 guest gso support checks
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, stephen@networkplumber.org, 
 davem@davemloft.net, jesse.brandeburg@intel.com, kuba@kernel.org,
 sridhar.samudrala@intel.com, loseweigh@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
References: <20220914144911.56422-1-gavinl@nvidia.com>
 <20220914144911.56422-2-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220914144911.56422-2-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Gavi Teitz <gavi@nvidia.com>
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

CuWcqCAyMDIyLzkvMTQgMjI6NDksIEdhdmluIExpIOWGmemBkzoKPiBQcm9iZSByb3V0aW5lIGlz
IGFscmVhZHkgc2V2ZXJhbCBodW5kcmVkIGxpbmVzLgo+IFVzZSBoZWxwZXIgZnVuY3Rpb24gZm9y
IGd1ZXN0IGdzbyBzdXBwb3J0IGNoZWNrLgo+Cj4gU2lnbmVkLW9mZi1ieTogR2F2aW4gTGkgPGdh
dmlubEBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBHYXZpIFRlaXR6IDxnYXZpQG52aWRpYS5j
b20+Cj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiBSZXZp
ZXdlZC1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiBSZXZpZXdl
ZC1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgoKCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gY2hhbmdlbG9nOgo+IHY0LT52
NQo+IC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gTWljaGFlbCBTLiBUc2lya2luCj4gLSBSZW1v
dmUgdW5uZWNlc3NhcnkgKCkgaW4gcmV0dXJuIGNsYXVzZQo+IHYxLT52Mgo+IC0gQWRkIG5ldyBw
YXRjaAo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTMgKysrKysrKysrLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCBlMGU1NzA4M2Q0NDIuLmY1NGM3MTgyNzU4ZiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtMzY4Miw2ICszNjgyLDE0IEBAIHN0YXRpYyBpbnQgdmlydG5ldF92YWxpZGF0ZShz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtz
dGF0aWMgYm9vbCB2aXJ0bmV0X2NoZWNrX2d1ZXN0X2dzbyhjb25zdCBzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSkKPiArewo+ICsJcmV0dXJuIHZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklS
VElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4gKwkJdmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2
LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikgfHwKPiArCQl2aXJ0aW9faGFzX2ZlYXR1cmUodmkt
PnZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9FQ04pIHx8Cj4gKwkJdmlydGlvX2hhc19mZWF0dXJl
KHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKTsKPiArfQo+ICsKPiAgIHN0YXRpYyBp
bnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIHsKPiAgIAlp
bnQgaSwgZXJyID0gLUVOT01FTTsKPiBAQCAtMzc3NywxMCArMzc4NSw3IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAlzcGluX2xvY2tf
aW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiAgIAo+ICAgCS8qIElmIHdlIGNhbiByZWNlaXZlIEFO
WSBHU08gcGFja2V0cywgd2UgbXVzdCBhbGxvY2F0ZSBsYXJnZSBvbmVzLiAqLwo+IC0JaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiAtCSAg
ICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHx8Cj4g
LQkgICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9FQ04pIHx8
Cj4gLQkgICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9VRk8p
KQo+ICsJaWYgKHZpcnRuZXRfY2hlY2tfZ3Vlc3RfZ3NvKHZpKSkKPiAgIAkJdmktPmJpZ19wYWNr
ZXRzID0gdHJ1ZTsKPiAgIAo+ICAgCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X05FVF9GX01SR19SWEJVRikpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
