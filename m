Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D0C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18A0C4151E;
	Wed,  9 Feb 2022 04:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5srfBht_jO6; Wed,  9 Feb 2022 04:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 630FA414C2;
	Wed,  9 Feb 2022 04:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12BE2C001A;
	Wed,  9 Feb 2022 04:26:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8FC7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87D0E400F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDeWfueeAzUA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:26:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A925C400CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644380764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mY8elVfyQglRlLXkjN7Nh6smhNHX9r1QRGNGZo7nas=;
 b=Ydg9kdCgjsyeH75vEjAHfAJvCJYZNpGNlQHutgvEXcMbMvrxO90uphX19pNVKJmM2c6FEY
 miM1QXtsPWZVUTGNVeFxlXIyeLWAWb7B4SgdJZO9iVLjqkavNOZ0LrFf32Us2V35Y7ipY4
 fsq897Pn9fpB/7IIaHK5Kkov0EGVQgA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-8mKQNyQ-MRmHF9DUhAqD6Q-1; Tue, 08 Feb 2022 23:26:03 -0500
X-MC-Unique: 8mKQNyQ-MRmHF9DUhAqD6Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 204-20020a6214d5000000b004e0003cee84so892366pfu.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8mY8elVfyQglRlLXkjN7Nh6smhNHX9r1QRGNGZo7nas=;
 b=M+ArbM3RDhYGafneCcrqtCS6o6qZEFJ+NhZf2H7kkWwSx9cgeYJb4t7VR7Tp1Adbsq
 1wsdshIKAzdn5uolOzjscB5SGvT3UQw7hevgxTVrsYtN++vml3+T8j3PqeiLqRxZOQVr
 a7RXMtiSdJ9yf096DI/9okjOLRicGBgIWP4oZsvzy9gBokFGZJcJqdbBBjIskg3bHrRk
 dVOV4nqI182ZAmJxaXFasaSwYqbTjgjvIMWBEyIXNqrPPk4psvoItv6heGfkbTuL+P99
 Vu53C0YG9mDKg0ftDHEWCp0IM0hdac66C1t7rlRvLeQ51C2TVGxwHeLYip6XU5fQq/39
 Q+TA==
X-Gm-Message-State: AOAM53072GIp5KsJkWuyI6K4lHqUOdG55cVbFIbmLVu4fpxseQr5QLuu
 YRH8Ob4RIAfW4sMg6YEH8k4tesV8YET2Bs+xfxRVRBe7DyaJWo7LD3Kr51+VWIJJ3r6lUc6s3bL
 DXr0KhZ8wl7MVKprTQz5hZJYyxql+kD1Ebe7W0Gki0A==
X-Received: by 2002:a17:902:d4d2:: with SMTP id
 o18mr689059plg.70.1644380762290; 
 Tue, 08 Feb 2022 20:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykaFv2k/rU0QWZ6U8v2dqzYGXw3Od1HYD//YNB9h1Dzi13vXmiZ2WWJpeEOkwfNhTZU6a1Xw==
X-Received: by 2002:a17:902:d4d2:: with SMTP id
 o18mr689040plg.70.1644380761987; 
 Tue, 08 Feb 2022 20:26:01 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z15sm10137088pfh.82.2022.02.08.20.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 20:26:01 -0800 (PST)
Message-ID: <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
Date: Wed, 9 Feb 2022 12:25:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
To: Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-2-andrew@daynix.com>
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

CuWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0NiwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBB
ZGRlZCBUVU5HRVRTVVBQT1JURURPRkZMT0FEUyB0aGF0IHNob3VsZCBhbGxvdwo+IHRvIGdldCBi
aXRzIG9mIHN1cHBvcnRlZCBvZmZsb2Fkcy4KCgpTbyB3ZSBkb24ndCB1c2UgZGVkaWNhdGVkIGlv
Y3RscyBpbiB0aGUgcGFzdCwgaW5zdGVhZCwgd2UganVzdCBwcm9iaW5nIApieSBjaGVja2luZyB0
aGUgcmV0dXJuIHZhbHVlIG9mIFRVTlNFVE9GRkxPQURTLgoKRS5nIHFlbXUgaGFzIHRoZSBmb2xs
b3dpbmcgY29kZXM6CgppbnQgdGFwX3Byb2JlX2hhc191Zm8oaW50IGZkKQp7CiDCoMKgwqAgdW5z
aWduZWQgb2ZmbG9hZDsKCiDCoMKgwqAgb2ZmbG9hZCA9IFRVTl9GX0NTVU0gfCBUVU5fRl9VRk87
CgogwqDCoMKgIGlmIChpb2N0bChmZCwgVFVOU0VUT0ZGTE9BRCwgb2ZmbG9hZCkgPCAwKQogwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7CgogwqDCoMKgIHJldHVybiAxOwp9CgpBbnkgcmVhc29uIHdl
IGNhbid0IGtlZXAgdXNpbmcgdGhhdD8KClRoYW5rcwoKCj4gQWRkZWQgMiBhZGRpdGlvbmFsIG9m
Zmxsb2FkcyBmb3IgVVNPKElQdjQgJiBJUHY2KS4KPiBTZXBhcmF0ZSBvZmZsb2FkcyBhcmUgcmVx
dWlyZWQgZm9yIFdpbmRvd3MgVk0gZ3Vlc3RzLAo+IGcuZS4gV2luZG93cyBtYXkgc2V0IFVTTyBy
eCBvbmx5IGZvciBJUHY0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1lbG55Y2hlbmtvIDxh
bmRyZXdAZGF5bml4LmNvbT4KPiAtLS0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC9pZl90dW4uaCB8
IDMgKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1
bi5oCj4gaW5kZXggNDU0YWUzMWI5M2M3Li4wNzY4MGZhZTZlMTggMTAwNjQ0Cj4gLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1
bi5oCj4gQEAgLTYxLDYgKzYxLDcgQEAKPiAgICNkZWZpbmUgVFVOU0VURklMVEVSRUJQRiBfSU9S
KCdUJywgMjI1LCBpbnQpCj4gICAjZGVmaW5lIFRVTlNFVENBUlJJRVIgX0lPVygnVCcsIDIyNiwg
aW50KQo+ICAgI2RlZmluZSBUVU5HRVRERVZORVROUyBfSU8oJ1QnLCAyMjcpCj4gKyNkZWZpbmUg
VFVOR0VUU1VQUE9SVEVET0ZGTE9BRFMgX0lPUignVCcsIDIyOCwgdW5zaWduZWQgaW50KQo+ICAg
Cj4gICAvKiBUVU5TRVRJRkYgaWZyIGZsYWdzICovCj4gICAjZGVmaW5lIElGRl9UVU4JCTB4MDAw
MQo+IEBAIC04OCw2ICs4OSw4IEBACj4gICAjZGVmaW5lIFRVTl9GX1RTTzYJMHgwNAkvKiBJIGNh
biBoYW5kbGUgVFNPIGZvciBJUHY2IHBhY2tldHMgKi8KPiAgICNkZWZpbmUgVFVOX0ZfVFNPX0VD
TgkweDA4CS8qIEkgY2FuIGhhbmRsZSBUU08gd2l0aCBFQ04gYml0cy4gKi8KPiAgICNkZWZpbmUg
VFVOX0ZfVUZPCTB4MTAJLyogSSBjYW4gaGFuZGxlIFVGTyBwYWNrZXRzICovCj4gKyNkZWZpbmUg
VFVOX0ZfVVNPNAkweDIwCS8qIEkgY2FuIGhhbmRsZSBVU08gZm9yIElQdjQgcGFja2V0cyAqLwo+
ICsjZGVmaW5lIFRVTl9GX1VTTzYJMHg0MAkvKiBJIGNhbiBoYW5kbGUgVVNPIGZvciBJUHY2IHBh
Y2tldHMgKi8KPiAgIAo+ICAgLyogUHJvdG9jb2wgaW5mbyBwcmVwZW5kZWQgdG8gdGhlIHBhY2tl
dHMgKHdoZW4gSUZGX05PX1BJIGlzIG5vdCBzZXQpICovCj4gICAjZGVmaW5lIFRVTl9QS1RfU1RS
SVAJMHgwMDAxCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
