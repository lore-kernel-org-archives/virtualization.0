Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C403CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 07:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89D9C81427;
	Mon, 17 Jan 2022 07:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RJQj7REg6Jw; Mon, 17 Jan 2022 07:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E24781425;
	Mon, 17 Jan 2022 07:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0425C0039;
	Mon, 17 Jan 2022 07:00:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 295BAC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 091B481427
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ig4VuXf2TrJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:00:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D578781425
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642402839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ofvfyWd65gtsrhP134MR7DtI0EppdDbR1Ui87ThXPE=;
 b=fvVNvXgIoKmONUo0MTVvhvbbLET2hXJxQK6Ss/i6rsaUae6jGPk76x6tgSQ6WQ+uM5PddZ
 qYLp1NBPO+AfBIU1jX2d2DLpSilR7vYSDZEKDo5fjHOmDAoxS09AoS7JnlPlB19CCxGcOk
 eMzEvVHH4qd8Tpz9J00yjDr3XjtsIxs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-_3D91QtCMPaBXmoP1TU2tg-1; Mon, 17 Jan 2022 02:00:35 -0500
X-MC-Unique: _3D91QtCMPaBXmoP1TU2tg-1
Received: by mail-pj1-f69.google.com with SMTP id
 1-20020a17090a0e8100b001b2a885e155so8089247pjx.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 23:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8ofvfyWd65gtsrhP134MR7DtI0EppdDbR1Ui87ThXPE=;
 b=wiYu0c5suZp3IAhJjheeMpXLpc3A3Dw3isVdMNyBgoso2DJcXjb1r/9cSon1dmjwem
 zMMfJnMSoQnhMSvsVtKRrBPXsaYhv+20V7Bvi619Vydyx6vTA9WoDQ/JdjGx1oyBQQ2U
 5pUjBB0AycdQWslTL4XMg+FETSoXBiQRJfeFreYLlNDrebZtOAx+7b4K22CEi3b+MCV6
 zII4kLpbzHrvMJhSjHRLRkQj0yGF2f0cOmbhjefffqL+lGgPbyLPusKLDWvI0wNJcNOM
 MCnq8KRrPNoqe1eKlRNvBWcz1aSDjIYMQdDtNw7TxzbXO415IVI6kbCGugKMvJge9mBw
 sIuA==
X-Gm-Message-State: AOAM531fELNxEH5yNs8BCKxHGmTc9sw0DhDxdAL9jBKhwEyt0jIYVUbB
 6oO9dc1vTY01MEy1w2lptSsu5om0hFz10ser9XxJqbVXy0POPKAWiX9ZItVhfW7y6TaWx6ksM6b
 Dmgy0iVboKfsOJDMIYgpQai1tEekwB4SIXDY2QNTSTw==
X-Received: by 2002:a17:90b:2343:: with SMTP id
 ms3mr32919385pjb.130.1642402834629; 
 Sun, 16 Jan 2022 23:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy88tQRRTgnml6YUMfd7cNRyqIV7KZfp6hWeYhPOlqIO/XEDs4sdcLfX8YXK34UjCtmpaDC4w==
X-Received: by 2002:a17:90b:2343:: with SMTP id
 ms3mr32919363pjb.130.1642402834396; 
 Sun, 16 Jan 2022 23:00:34 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z31sm10667222pgl.10.2022.01.16.23.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 23:00:33 -0800 (PST)
Message-ID: <0c116e9c-9aeb-fc57-f744-c537ca695798@redhat.com>
Date: Mon, 17 Jan 2022 15:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] vdpa/mlx5: add validation for
 VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command
To: Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
 <1642206481-30721-4-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1642206481-30721-4-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvMTUg5LiK5Y2IODoyOCwgU2ktV2VpIExpdSDlhpnpgZM6Cj4gV2hlbiBjb250
cm9sIHZxIHJlY2VpdmVzIGEgVklSVElPX05FVF9DVFJMX01RX1ZRX1BBSVJTX1NFVCBjb21tYW5k
Cj4gcmVxdWVzdCBmcm9tIHRoZSBkcml2ZXIsIHByZXNlbnRseSB0aGVyZSBpcyBubyB2YWxpZGF0
aW9uIGFnYWluc3QgdGhlCj4gbnVtYmVyIG9mIHF1ZXVlIHBhaXJzIHRvIGNvbmZpZ3VyZSwgb3Ig
ZXZlbiBpZiBtdWx0aXF1ZXVlIGhhZCBiZWVuCj4gbmVnb3RpYXRlZCBvciBub3QgaXMgdW52ZXJp
ZmllZC4gVGhpcyBtYXkgbGVhZCB0byBrZXJuZWwgcGFuaWMgZHVlIHRvCj4gdW5pbml0aWFsaXpl
ZCByZXNvdXJjZSBmb3IgdGhlIHF1ZXVlcyB3ZXJlIHRoZXJlIGFueSBib2d1cyByZXF1ZXN0Cj4g
c2VudCBkb3duIGJ5IHVudHJ1c3RlZCBkcml2ZXIuIFRpZSB1cCB0aGUgbG9vc2UgZW5kcyB0aGVy
ZS4KPgo+IEZpeGVzOiA1Mjg5MzczM2YyYzUgKCJ2ZHBhL21seDU6IEFkZCBtdWx0aXF1ZXVlIHN1
cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNv
bT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+
ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTYgKysrKysrKysrKysrKysr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiBpbmRleCA2ZmE5NjhmLi44NmY4NGRjIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+IEBAIC0xNTYzLDExICsxNTYzLDI3IEBAIHN0YXRpYyB2aXJ0aW9fbmV0
X2N0cmxfYWNrIGhhbmRsZV9jdHJsX21xKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTgg
Y21kKQo+ICAgCj4gICAJc3dpdGNoIChjbWQpIHsKPiAgIAljYXNlIFZJUlRJT19ORVRfQ1RSTF9N
UV9WUV9QQUlSU19TRVQ6Cj4gKwkJLyogVGhpcyBtcSBmZWF0dXJlIGNoZWNrIGFsaWducyB3aXRo
IHByZS1leGlzdGluZyB1c2Vyc3BhY2UKPiArCQkgKiBpbXBsZW1lbnRhdGlvbi4KPiArCQkgKgo+
ICsJCSAqIFdpdGhvdXQgaXQsIGFuIHVudHJ1c3RlZCBkcml2ZXIgY291bGQgZmFrZSBhIG11bHRp
cXVldWUgY29uZmlnCj4gKwkJICogcmVxdWVzdCBkb3duIHRvIGEgbm9uLW1xIGRldmljZSB0aGF0
IG1heSBjYXVzZSBrZXJuZWwgdG8KPiArCQkgKiBwYW5pYyBkdWUgdG8gdW5pbml0aWFsaXplZCBy
ZXNvdXJjZXMgZm9yIGV4dHJhIHZxcy4gRXZlbiB3aXRoCj4gKwkJICogYSB3ZWxsIGJlaGF2aW5n
IGd1ZXN0IGRyaXZlciwgaXQgaXMgbm90IGV4cGVjdGVkIHRvIGFsbG93Cj4gKwkJICogY2hhbmdp
bmcgdGhlIG51bWJlciBvZiB2cXMgb24gYSBub24tbXEgZGV2aWNlLgo+ICsJCSAqLwo+ICsJCWlm
ICghTUxYNV9GRUFUVVJFKG12ZGV2LCBWSVJUSU9fTkVUX0ZfTVEpKQo+ICsJCQlicmVhazsKPiAr
Cj4gICAJCXJlYWQgPSB2cmluZ2hfaW92X3B1bGxfaW90bGIoJmN2cS0+dnJpbmcsICZjdnEtPnJp
b3YsICh2b2lkICopJm1xLCBzaXplb2YobXEpKTsKPiAgIAkJaWYgKHJlYWQgIT0gc2l6ZW9mKG1x
KSkKPiAgIAkJCWJyZWFrOwo+ICAgCj4gICAJCW5ld3FwcyA9IG1seDV2ZHBhMTZfdG9fY3B1KG12
ZGV2LCBtcS52aXJ0cXVldWVfcGFpcnMpOwo+ICsJCWlmIChuZXdxcHMgPCBWSVJUSU9fTkVUX0NU
UkxfTVFfVlFfUEFJUlNfTUlOIHx8Cj4gKwkJICAgIG5ld3FwcyA+IG1seDVfdmRwYV9tYXhfcXBz
KG12ZGV2LT5tYXhfdnFzKSkKPiArCQkJYnJlYWs7Cj4gKwo+ICAgCQlpZiAobmRldi0+Y3VyX251
bV92cXMgPT0gMiAqIG5ld3Fwcykgewo+ICAgCQkJc3RhdHVzID0gVklSVElPX05FVF9PSzsKPiAg
IAkJCWJyZWFrOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
