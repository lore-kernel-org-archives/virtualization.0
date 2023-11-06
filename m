Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8089DC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F1B740C0C;
	Mon,  6 Nov 2023 07:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F1B740C0C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fW02jtHL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 601cngAktAeq; Mon,  6 Nov 2023 07:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF1EC40C01;
	Mon,  6 Nov 2023 07:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF1EC40C01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B9CC0071;
	Mon,  6 Nov 2023 07:30:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3492CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F5BB41C0B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:30:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F5BB41C0B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fW02jtHL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DG_5HDLNYsUR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:30:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E60A41BC5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E60A41BC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
 b=fW02jtHLC8uecPeNmrOqg0LiOkKvhVFS5YDll2wq/H8YtoMZDhjPiMkiDfdPOwpT5Xz0cG
 jz+Pc5xdN5Ct/IKsqNrhwTBXw2BwkgAunZqxUwRsZ0LcceHcWrCuCI8HSXNUwZ1VzMhaGE
 8l5/AUsKf0NlgRYR+i7zZTqQJTE1Fxs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-QyinCDOBP3mHqi8zumnn7Q-1; Mon, 06 Nov 2023 02:30:26 -0500
X-MC-Unique: QyinCDOBP3mHqi8zumnn7Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50798a259c7so3800772e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 23:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699255825; x=1699860625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
 b=Ib6gsDJ0bF9DHWL1vAgdUx38pkuKUKBsUwUwxPfGmuSHbKL0Muyx4zCtG9Ix/m3E24
 oTTKuphCrh09IlJtbdkSZAFJdpRaZ0ldLcBj2Kg7ZXBrWPDaOVHBgADQtLWm2s0fMVFp
 If/hwTwfdkceNO54FbeADvN0nA3dXvUyA3ZTFw5BZir9bD6Jsf+InyNc6N4+ntzAcAMG
 Pf54aCM1jWx0J6nMrCY7HVq16Xr5PjEnDeVCvXKxBHWwA8jCZnqFe5nhd43IbJZesB/h
 wvOCJTI33N32eF43EkuqjommrhCooPA+JQPYNJWvZAkwLolK/RuzU1Wyz1by/PrJLnHS
 Ca/w==
X-Gm-Message-State: AOJu0Yz8OXdfCkS+ia8A5aQ2afhUOc8AzXN05K6k9m3zX5lJB8ptxK/j
 Fy9kK2xdlMB67b0XR5ZtIE0komVrfHxqkU++Al6Y7gG7dm6ckYsYKEDsm50OcM45inoU/TGj4u5
 yljaQ2x8aaHQqtiTYw1XFjsXjwWGekfexs0Pv8eU5TT8RMXHrJc7AhhvEYg==
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id
 i8-20020a0565123e0800b00503099d5a97mr28482714lfv.20.1699255825096; 
 Sun, 05 Nov 2023 23:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHur0uXYPVe6IlJPXMRunyH5xL4ebGdX/vCL/0AKGxbasEI2KxpGo3WC3Ky/u+84NkABZC4UMdi2leH4CxHzsw=
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id
 i8-20020a0565123e0800b00503099d5a97mr28482691lfv.20.1699255824752; Sun, 05
 Nov 2023 23:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:30:13 +0800
Message-ID: <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
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
bT4gd3JvdGU6Cj4KPiBWSE9TVF9WRFBBX1NFVF9JT01NVV9GRDogYmluZCB0aGUgZGV2aWNlIHRv
IGlvbW11ZmQgZGV2aWNlCj4KPiBWRFBBX0RFVklDRV9BVFRBQ0hfSU9NTVVGRF9BUzogQXR0YWNo
IGEgdmRwYSBkZXZpY2UgdG8gYW4gaW9tbXVmZAo+IGFkZHJlc3Mgc3BhY2Ugc3BlY2lmaWVkIGJ5
IElPQVMgaWQuCj4KPiBWRFBBX0RFVklDRV9ERVRBQ0hfSU9NTVVGRF9BUzogRGV0YWNoIGEgdmRw
YSBkZXZpY2UKPiBmcm9tIHRoZSBpb21tdWZkIGFkZHJlc3Mgc3BhY2UKPgo+IFNpZ25lZC1vZmYt
Ynk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gLS0tCgpbLi4uXQoKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3Qu
aAo+IGluZGV4IGY1YzQ4YjYxYWI2Mi4uMDdlMWIyYzQ0M2NhIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC92aG9zdC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgK
PiBAQCAtMjE5LDQgKzIxOSw3MCBAQAo+ICAgKi8KPiAgI2RlZmluZSBWSE9TVF9WRFBBX1JFU1VN
RSAgICAgICAgICAgICAgX0lPKFZIT1NUX1ZJUlRJTywgMHg3RSkKPgo+ICsvKiB2aG9zdF92ZHBh
X3NldF9pb21tdWZkCj4gKyAqIElucHV0IHBhcmFtZXRlcnM6Cj4gKyAqIEBpb21tdWZkOiBmaWxl
IGRlc2NyaXB0b3IgZnJvbSAvZGV2L2lvbW11OyBwYXNzIC0xIHRvIHVuc2V0Cj4gKyAqIEBpb21t
dWZkX2lvYXNpZDogSU9BUyBpZGVudGlmaWVyIHJldHVybmVkIGZyb20gaW9jdGwoSU9NTVVfSU9B
U19BTExPQykKPiArICogT3V0cHV0IHBhcmFtZXRlcnM6Cj4gKyAqIEBvdXRfZGV2X2lkOiBkZXZp
Y2UgaWRlbnRpZmllcgo+ICsgKi8KPiArc3RydWN0IHZob3N0X3ZkcGFfc2V0X2lvbW11ZmQgewo+
ICsgICAgICAgX19zMzIgaW9tbXVmZDsKPiArICAgICAgIF9fdTMyIGlvbW11ZmRfaW9hc2lkOwo+
ICsgICAgICAgX191MzIgb3V0X2Rldl9pZDsKPiArfTsKPiArCj4gKyNkZWZpbmUgVkhPU1RfVkRQ
QV9TRVRfSU9NTVVfRkQgXAo+ICsgICAgICAgX0lPVyhWSE9TVF9WSVJUSU8sIDB4N0YsIHN0cnVj
dCB2aG9zdF92ZHBhX3NldF9pb21tdWZkKQo+ICsKPiArLyoKPiArICogVkRQQV9ERVZJQ0VfQVRU
QUNIX0lPTU1VRkRfQVMgLQo+ICsgKiBfSU9XKFZIT1NUX1ZJUlRJTywgMHg3Ziwgc3RydWN0IHZk
cGFfZGV2aWNlX2F0dGFjaF9pb21tdWZkX2FzKQo+ICsgKgo+ICsgKiBBdHRhY2ggYSB2ZHBhIGRl
dmljZSB0byBhbiBpb21tdWZkIGFkZHJlc3Mgc3BhY2Ugc3BlY2lmaWVkIGJ5IElPQVMKPiArICog
aWQuCj4gKyAqCj4gKyAqIEF2YWlsYWJsZSBvbmx5IGFmdGVyIGEgZGV2aWNlIGhhcyBiZWVuIGJv
dW5kIHRvIGlvbW11ZmQgdmlhCj4gKyAqIFZIT1NUX1ZEUEFfU0VUX0lPTU1VX0ZECj4gKyAqCj4g
KyAqIFVuZG8gYnkgVkRQQV9ERVZJQ0VfREVUQUNIX0lPTU1VRkRfQVMgb3IgZGV2aWNlIGZkIGNs
b3NlLgo+ICsgKgo+ICsgKiBAYXJnc3o6ICAgICB1c2VyIGZpbGxlZCBzaXplIG9mIHRoaXMgZGF0
YS4KPiArICogQGZsYWdzOiAgICAgbXVzdCBiZSAwLgo+ICsgKiBAaW9hc19pZDogICBJbnB1dCB0
aGUgdGFyZ2V0IGlkIHdoaWNoIGNhbiByZXByZXNlbnQgYW4gaW9hcwo+ICsgKiAgICAgICAgICAg
ICBhbGxvY2F0ZWQgdmlhIGlvbW11ZmQgc3Vic3lzdGVtLgo+ICsgKgo+ICsgKiBSZXR1cm46IDAg
b24gc3VjY2VzcywgLWVycm5vIG9uIGZhaWx1cmUuCj4gKyAqLwo+ICtzdHJ1Y3QgdmRwYV9kZXZp
Y2VfYXR0YWNoX2lvbW11ZmRfYXMgewo+ICsgICAgICAgX191MzIgYXJnc3o7Cj4gKyAgICAgICBf
X3UzMiBmbGFnczsKPiArICAgICAgIF9fdTMyIGlvYXNfaWQ7Cj4gK307CgpJIHRoaW5rIHdlIG5l
ZWQgdG8gbWFwIGlvYXMgdG8gdkRQQSBBUywgc28gdGhlcmUgc2hvdWxkIGJlIGFuIEFTSUQKZnJv
bSB0aGUgdmlldyBvZiB2RFBBPwoKVGhhbmtzCgo+ICsKPiArI2RlZmluZSBWRFBBX0RFVklDRV9B
VFRBQ0hfSU9NTVVGRF9BUyBcCj4gKyAgICAgICBfSU9XKFZIT1NUX1ZJUlRJTywgMHg4Miwgc3Ry
dWN0IHZkcGFfZGV2aWNlX2F0dGFjaF9pb21tdWZkX2FzKQo+ICsKPiArLyoKPiArICogVkRQQV9E
RVZJQ0VfREVUQUNIX0lPTU1VRkRfQVMKPiArICoKPiArICogRGV0YWNoIGEgdmRwYSBkZXZpY2Ug
ZnJvbSB0aGUgaW9tbXVmZCBhZGRyZXNzIHNwYWNlIGl0IGhhcyBiZWVuCj4gKyAqIGF0dGFjaGVk
IHRvLiBBZnRlciBpdCwgZGV2aWNlIHNob3VsZCBiZSBpbiBhIGJsb2NraW5nIERNQSBzdGF0ZS4K
PiArICoKPiArICogQXZhaWxhYmxlIG9ubHkgYWZ0ZXIgYSBkZXZpY2UgaGFzIGJlZW4gYm91bmQg
dG8gaW9tbXVmZCB2aWEKPiArICogVkhPU1RfVkRQQV9TRVRfSU9NTVVfRkQKPiArICoKPiArICog
QGFyZ3N6OiAgICAgdXNlciBmaWxsZWQgc2l6ZSBvZiB0aGlzIGRhdGEuCj4gKyAqIEBmbGFnczog
ICAgIG11c3QgYmUgMC4KPiArICoKPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBv
biBmYWlsdXJlLgo+ICsgKi8KPiArc3RydWN0IHZkcGFfZGV2aWNlX2RldGFjaF9pb21tdWZkX2Fz
IHsKPiArICAgICAgIF9fdTMyIGFyZ3N6Owo+ICsgICAgICAgX191MzIgZmxhZ3M7Cj4gK307Cj4g
Kwo+ICsjZGVmaW5lIFZEUEFfREVWSUNFX0RFVEFDSF9JT01NVUZEX0FTIFwKPiArICAgICAgIF9J
T1coVkhPU1RfVklSVElPLCAweDgzLCBzdHJ1Y3QgdmRwYV9kZXZpY2VfZGV0YWNoX2lvbW11ZmRf
YXMpCj4gKwo+ICAjZW5kaWYKPiAtLQo+IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
