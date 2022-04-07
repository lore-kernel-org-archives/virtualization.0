Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C84C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 06:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66AB441966;
	Thu,  7 Apr 2022 06:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1k-5bP2vea4; Thu,  7 Apr 2022 06:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93F7A4196B;
	Thu,  7 Apr 2022 06:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6316FC002C;
	Thu,  7 Apr 2022 06:12:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABEFC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3340140360
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eodAGjtRN4IB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1895240133
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649311955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YMZD0zaXzNbiLYIAQQ6QdI+WDXn0cZA+j7h4YBjqmQ=;
 b=EACFAS/CuEnkh6duNKmq4PYN3Wui52oV7RpFTZ9nrMNek2vjFwoNbJA474zWOmo5mNOaKR
 tCKsP8i2WM8iFbAW+iEAHgLPUy5W3A973ljqOLbLVfKnB+w0VYCZf+yIfoCkTCnEYfzxIe
 Pg+k7MKqmjTuRuK/rvYDback097kSE8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-_YNcrjXhN8uqdJ33eKlZZQ-1; Thu, 07 Apr 2022 02:12:34 -0400
X-MC-Unique: _YNcrjXhN8uqdJ33eKlZZQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 z10-20020a634c0a000000b0036c5eb39076so2621952pga.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 23:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4YMZD0zaXzNbiLYIAQQ6QdI+WDXn0cZA+j7h4YBjqmQ=;
 b=duicls2DLlS0BwZbwIM0xo36cF07wtUtLdGnZjp140g4PPk718iHtgzomWYiGy0usm
 zdMuJ+KYByR2HV37ZvdEBINnpswLXotWcgxWO8ImKG2NjNkAStCvZ2klLWnlq6gZfWYm
 koJOipyJpKVtBwN6D7TXnkkDF/CQxhmuz3IXZcefPtpWNPUSI42ZTblGnTEOEnKrD4NB
 8VvTaKbhdjrM28mn2JvzfvITBm3eTZmf6aFWnGndeZkXV+PQr/7AU6i2y1z4CMR/kYq6
 srY5wnTPStlSKFnKWq6zjaUANqx5BKLjE+ArGEZd/WVIkzqz4H4PhN3ikYNj/w2Xycqd
 iWpg==
X-Gm-Message-State: AOAM530daDk/GfPajqJFW47WdkmZf/FpSqYuUEu+Ghjhz/p+SYH0AQ9Y
 39Bs9lER6QN8Xzm3mzjyBxdNotoF5zFHnXrkmQY/sP5Y96B86XhD7oLgNWww5rrSTihdC9IJ3ax
 /NE4cVAAISIn4a/oGiq7PuzXP/NEpkaPLkJUNwF6J3Q==
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id
 u22-20020a056a00125600b004fb13742f65mr12818684pfi.72.1649311953599; 
 Wed, 06 Apr 2022 23:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7rGbUuvcCunCR1UohNGot6xcJrqBbgAuS1tOEZdmzy6OiRlug1LP1U5zxK0CgvL2OVrSsvg==
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id
 u22-20020a056a00125600b004fb13742f65mr12818667pfi.72.1649311953327; 
 Wed, 06 Apr 2022 23:12:33 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056a000b8600b004faa49add69sm21140158pfj.107.2022.04.06.23.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 23:12:32 -0700 (PDT)
Message-ID: <ccb6be3f-e397-21cb-3490-637c96483fcb@redhat.com>
Date: Thu, 7 Apr 2022 14:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 0/5] rework on the IRQ hardening of virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406073500-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406073500-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peterz@infradead.org, maz@kernel.org, linux-kernel@vger.kernel.org,
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

CuWcqCAyMDIyLzQvNiDkuIvljYg3OjM2LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9u
IFdlZCwgQXByIDA2LCAyMDIyIGF0IDA0OjM1OjMzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IEhpIEFsbDoKPj4KPj4gVGhpcyBpcyBhIHJld29yayBvbiB0aGUgSVJRIGhhcmRlbmluZyBm
b3IgdmlydGlvIHdoaWNoIGlzIGRvbmUKPj4gcHJldmlvdXNseSBieSB0aGUgZm9sbG93aW5nIGNv
bW1pdHMgYXJlIHJldmVydGVkOgo+Pgo+PiA5ZTM1Mjc2YTUzNDQgKCJ2aXJ0aW9fcGNpOiBoYXJk
ZW4gTVNJLVggaW50ZXJydXB0cyIpCj4+IDA4MGNkN2MzYWM4NyAoInZpcnRpby1wY2k6IGhhcmRl
biBJTlRYIGludGVycnVwdHMiKQo+Pgo+PiBUaGUgcmVhc29uIGlzIHRoYXQgaXQgZGVwZW5kcyBv
biB0aGUgSVJRRl9OT19BVVRPRU4gd2hpY2ggbWF5IGNvbmZsaWN0Cj4+IHdpdGggdGhlIGFzc3Vt
cHRpb24gb2YgdGhlIGFmZmluaXR5IG1hbmFnZWQgSVJRIHRoYXQgaXMgdXNlZCBieSBzb21lCj4+
IHZpcnRpbyBkcml2ZXJzLiBBbmQgd2hhdCdzIG1vcmUsIGl0IGlzIG9ubHkgZG9uZSBmb3Igdmly
dGlvLXBjaSBidXQKPj4gbm90IG90aGVyIHRyYW5zcG9ydHMuCj4+Cj4+IEluIHRoaXMgcmV3b3Jr
LCBJIHRyeSB0byBpbXBsZW1lbnQgYSBnZW5lcmFsIHZpcnRpbyBzb2x1dGlvbiB3aGljaAo+PiBi
b3Jyb3dzIHRoZSBpZGVhIG9mIHRoZSBJTlRYIGhhcmRlbmluZyBieSBpbnRyb2R1Y2luZyBhIGJv
b2xlYW4gZm9yCj4+IHZpcnRxdWV1ZSBjYWxsYmFjayBlbmFibGluZyBhbmQgdG9nZ2xlIGl0IGlu
IHZpcnRpb19kZXZpY2VfcmVhZHkoKQo+PiBhbmQgdmlydGlvX3Jlc2V0X2RldmljZSgpLiBUaGVu
IHZyaW5nX2ludGVycnVwdCgpIGNhbiBzaW1wbHkgY2hlY2sgYW5kCj4+IHJldHVybiBlYXJseSBp
ZiB0aGUgZHJpdmVyIGlzIG5vdCByZWFkeS4KPgo+IEFsbCBvZiBhIHN1ZGRlbiBhbGwgcGF0Y2hl
cyBhcmUgaGF2aW5nIGEgd3JvbmcgbWltZSB0eXBlLgo+Cj4gSXQgaXMgYXBwbGljYXRpb24vb2N0
ZXQtc3RyZWFtOyBzaG91bGQgYmUgdGV4dC9wbGFpbgo+Cj4gUGxzIGZpeCBhbmQgcmVwb3N0LCB0
aGFua3MhCgoKU28gdGhlIHBhdGNoZXMgYXJlIGdlbmVyYXRlZCB2aWEgZ2l0LWZvcm1hdC1wYXRj
aCBhbmQgZ2l0LXNlbmQtZW1haWwgaW4gCm9uZSBydW4uCgpJIGNhbiBzZWUgbWFueSB1cHN0cmVh
bSBwYXRjaGVzIHdlcmUgY29udmVydGVkIHRvIAphcHBsaWNhdGlvbi9vY3RldC1zdHJlYW0gaWYg
RnJvbTogdGFnIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBzZW5kZXIuCgpNYXhpbWUgdG9sZCBtZSB0
aGV5J3ZlIGFsc28gbm90aWNlZCB0aGUgaXNzdWUgYW5kIGl0IGxvb2tzIGxpa2UgYSBpc3N1ZSAK
b2YgbWltZWNhc3QuCgpUaGFua3MKCgo+Cj4+IFBsZWFzZSByZXZpZXcuCj4+Cj4+IENoYW5nZXMg
c2luY2UgdjE6Cj4+Cj4+IC0gVXNlIHRyYW5zcG9ydCBzcGVjaWZpYyBpcnEgc3luY2hyb25pemF0
aW9uIG1ldGhvZCB3aGVuIHBvc3NpYmxlCj4+IC0gRHJvcCB0aGUgbW9kdWxlIHBhcmFtZXRlciBh
bmQgZW5hYmxlIHRoZSBoYXJkZW5pbmcgdW5jb25kaXRvbmFsbHkKPj4gLSBUd2VhayB0aGUgYmFy
cmllci9vcmRlcmluZyBmYWNpbGl0aWVzIHVzZWQgaW4gdGhlIGNvZGUKPj4gLSBSZWFubWUgaXJx
X3NvZnRfZW5hYmxlZCB0byBkcml2ZXJfcmVhZHkKPj4gLSBBdm9pZCB1bm5lY3NzYXJ5IElSUSBz
eW5jaG9ybml6YXRpb24gKGUuZyBkdXJpbmcgYm9vdCkKPj4KPj4gSmFzb24gV2FuZyAoNCk6Cj4+
ICAgIHZpcnRpbzogdXNlIHZpcnRpb19yZXNldF9kZXZpY2UoKSB3aGVuIHBvc3NpYmxlCj4+ICAg
IHZpcnRpbzogaW50cm9kdWNlIGNvbmZpZyBvcCB0byBzeW5jaHJvbml6ZSB2cmluZyBjYWxsYmFj
a3MKPj4gICAgdmlydGlvLXBjaTogaW1wbGVtZW50IHN5bmNocm9uaXplX3ZxcygpCj4+ICAgIHZp
cnRpbzogaGFyZGVuIHZyaW5nIElSUQo+Pgo+PiBTdGVmYW5vIEdhcnphcmVsbGEgKDEpOgo+PiAg
ICB2aXJ0aW86IHVzZSB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkgaW4gdmlydGlvX2RldmljZV9yZXN0
b3JlKCkKPj4KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyAgICAgICAgICAgIHwgMjAgKysr
KysrKysrKysrKysrKy0tLS0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5j
IHwgMTQgKysrKysrKysrKysrKysKPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5oIHwgIDIgKysKPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDEg
Kwo+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCAgMiArKwo+PiAgIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAgICAgfCAgOSArKysrKysrKy0KPj4gICBpbmNs
dWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgIDIgKysKPj4gICBpbmNsdWRlL2xpbnV4
L3ZpcnRpb19jb25maWcuaCAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAg
OCBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+PiAt
LSAKPj4gMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
