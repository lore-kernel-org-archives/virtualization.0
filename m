Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22490C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 06:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA1FE60F6A;
	Thu,  7 Apr 2022 06:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WCHsZ3N5O6S; Thu,  7 Apr 2022 06:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 613B060C03;
	Thu,  7 Apr 2022 06:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 352B5C002C;
	Thu,  7 Apr 2022 06:19:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31284C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DFED40160
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IJBzDEZb_uX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E1F340133
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649312348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSoQ5rtvOHp3Q8UdZ46y3auvh3IsXFHtX0lRwfM7Hh0=;
 b=AdW5jKWSyHVueE8MHBdBL5cEFKdgbYIKUmWZL7UFWIjoYUXarmgeBz0TghHUEoLpiihoC2
 /JorNQgq9fD7N8DxnAcBaay/5Y4Mw3PDdcXC/4jbNw08qaiUPy5IsMeE32nJWdZLUFqA05
 lTyCM7gautL5BmrEpx2rFfbdSb7RY9g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-DcWmU3OMNfCTV3yc6t-kDQ-1; Thu, 07 Apr 2022 02:19:07 -0400
X-MC-Unique: DcWmU3OMNfCTV3yc6t-kDQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 k71-20020a636f4a000000b00382a7c27856so2657280pgc.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 23:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TSoQ5rtvOHp3Q8UdZ46y3auvh3IsXFHtX0lRwfM7Hh0=;
 b=kHq9BlNxx1/44hUcorWNqmmASLPpfYcKJlJVbqqR9JLQDXyWxk2n+rHcPVv2glBWbb
 dSRWdwR40OL5YKPac9CdZCrdmnyvP1G9qHzDNBOZCD0lHEtC0IpjliRDEho8TUsFGppP
 besL+rEVwq1lddY4jmn2/ahIGnmk9WKqIAPJRlmnf0hZ+mA4BKfiEepju/F7E9DQOan+
 lLdm6eY3aziwpNxWZxESvUdLqrhwvVmb/POhfTTiLPhUPvgLr6xhKyPIsimlkt/I/EME
 vVA9DWnX2Bod3uXZUb+TyDkBlRwPx7AJ4iA46Vgmb2p4FiDExbKcF1TIZfyU8gxTMzQG
 gYrw==
X-Gm-Message-State: AOAM531sHcAi4xZv0Qx389D6+jDEeg29VqIx1RcL0aTK+Iu9asbw1O3t
 qK/AQGjpZ0F9jibi/+03XU3ss4AteMdM/Oilu75UUwBgm4Da9rNsmVdXR7CAS4KHgaxndAowEBT
 EDKAXXaUTAQ7/cHa32QXPCdiyKDyuKvIWIAPTNqPx4A==
X-Received: by 2002:a17:90b:4b10:b0:1c7:5b66:28df with SMTP id
 lx16-20020a17090b4b1000b001c75b6628dfmr14030858pjb.33.1649312346596; 
 Wed, 06 Apr 2022 23:19:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweJp2zPRrmAPlPETh78WGTKxsWNZZmlfTbsV43Rw8FTB6b1dnjjPEVt0sxXbGTw9H+3SE4Fw==
X-Received: by 2002:a17:90b:4b10:b0:1c7:5b66:28df with SMTP id
 lx16-20020a17090b4b1000b001c75b6628dfmr14030831pjb.33.1649312346324; 
 Wed, 06 Apr 2022 23:19:06 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a056a00114a00b004f784ba5e6asm21959166pfm.17.2022.04.06.23.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 23:19:05 -0700 (PDT)
Message-ID: <be2dd73d-7394-20d0-fa2b-652fdaa5700f@redhat.com>
Date: Thu, 7 Apr 2022 14:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/5] virtio: use virtio_device_ready() in
 virtio_device_restore()
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-2-jasowang@redhat.com>
 <20220406073803-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406073803-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

CuWcqCAyMDIyLzQvNiDkuIvljYg3OjQ0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IHBh
dGNoIGhhZCB3cm9uZyBtaW1lIHR5cGUuIEkgbWFuYWdlZCB0byBleHRyYSBpdCBidXQgcGxzIGZp
eC4KPgo+Pgo+PiBGcm9tOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+
Cj4+Cj4+IEl0IHdpbGwgYWxsb3dzIHVzCj4gd2lsbCBhbGxvdyB1cwo+Cj4+IHRvIGRvIGV4dGVu
c2lvbiBvbiB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkgd2l0aG91dAo+PiBkdXBsaWNhdGluZyBjb2Rl
cy4KPiBjb2RlCj4KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+
PiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+PiBDYzogIlBhdWwg
RS4gTWNLZW5uZXkiIDxwYXVsbWNrQGtlcm5lbC5vcmc+Cj4+IENjOiBNYXJjIFp5bmdpZXIgPG1h
ekBrZXJuZWwub3JnPgo+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpby5jIHwgNSArKystLQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpby5jCj4+IGluZGV4IDIyZjE1ZjQ0NGY3NS4uNzVjOGQ1NjBiYmQzIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8u
Ywo+PiBAQCAtNTI2LDggKzUyNiw5IEBAIGludCB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUoc3RydWN0
IHZpcnRpb19kZXZpY2UgKmRldikKPj4gICAJCQlnb3RvIGVycjsKPj4gICAJfQo+PiAgIAo+PiAt
CS8qIEZpbmFsbHksIHRlbGwgdGhlIGRldmljZSB3ZSdyZSBhbGwgc2V0ICovCj4+IC0JdmlydGlv
X2FkZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKTsKPj4gKwkvKiBJZiBy
ZXN0b3JlIGRpZG4ndCBkbyBpdCwgbWFyayBkZXZpY2UgRFJJVkVSX09LIG91cnNlbHZlcy4gKi8K
Pj4gKwlpZiAoIShkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyhkZXYpICYgVklSVElPX0NPTkZJR19T
X0RSSVZFUl9PSykpCj4+ICsJCXZpcnRpb19kZXZpY2VfcmVhZHkoZGV2KTsKPj4gICAKPj4gICAJ
dmlydGlvX2NvbmZpZ19lbmFibGUoZGV2KTsKPiBpdCdzIHVuZm9ydHVuYXRlIHRoYXQgdGhpcyBh
ZGRzIGFuIGV4dHJhIHZtZXhpdCBzaW5jZSB2aXJ0aW9fZGV2aWNlX3JlYWR5Cj4gY2FsbHMgZ2V0
X3N0YXR1cyB0b28uCj4KPiBXZSBub3cgaGF2ZToKPgo+IHN0YXRpYyBpbmxpbmUKPiB2b2lkIHZp
cnRpb19kZXZpY2VfcmVhZHkoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldikKPiB7Cj4gICAgICAg
ICAgdW5zaWduZWQgc3RhdHVzID0gZGV2LT5jb25maWctPmdldF9zdGF0dXMoZGV2KTsKPiAgICAg
ICAgICAgICAgICAgIAo+ICAgICAgICAgIEJVR19PTihzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1Nf
RFJJVkVSX09LKTsKPiAgICAgICAgICBkZXYtPmNvbmZpZy0+c2V0X3N0YXR1cyhkZXYsIHN0YXR1
cyB8IFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spOwo+IH0KPgo+Cj4gSSBwcm9wb3NlIGFkZGlu
ZyBhIGhlbHBlciBhbmQgcHV0dGluZyBjb21tb24gY29kZSB0aGVyZS4KCgpPaywgbGV0IG1lIGZp
eCBpdC4KClRoYW5rcwoKCj4KPj4gICAKPj4gLS0gCj4+IDIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
