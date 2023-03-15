Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F98C6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 03:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 852EA60B57;
	Wed, 15 Mar 2023 03:01:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 852EA60B57
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dl6BVXM0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Lh-iEBjJYsH; Wed, 15 Mar 2023 03:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2E8F60672;
	Wed, 15 Mar 2023 03:01:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2E8F60672
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A15BFC0071;
	Wed, 15 Mar 2023 03:01:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2A45C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 03:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8062401B1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 03:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8062401B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dl6BVXM0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEL-WjPVoB3c
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 03:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95A6540022
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95A6540022
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678849256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tucg0GiUCQnvYvu2GCMdDmsSb94agPko/WDn4Pw2Zqw=;
 b=dl6BVXM05ZsSpySrxu4eyQ0IhdTn3KdGZXshf/iN9JNHWjfv6d5tBAupacMeucrGu81IS7
 LhclUa/I0PhmuHf9TSyf5EipGV/d7x7wf68dSVlwZ7wj/OHaThaMdHv+DVHF57/kbpydte
 W+Cv9vUW06qJU2VDxv5RDIUuNf4xEKE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-uHHWfGqfM52hncTq-9z5dQ-1; Tue, 14 Mar 2023 23:00:55 -0400
X-MC-Unique: uHHWfGqfM52hncTq-9z5dQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 a17-20020a056a001d1100b00625760338c5so1599838pfx.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 20:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678849254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tucg0GiUCQnvYvu2GCMdDmsSb94agPko/WDn4Pw2Zqw=;
 b=OvwuoA2FWUaICTdQWcf4lColiRpvh4qJ+NvAJS37j6fSPtgWhzdDjDwPUs0F/fxUej
 w4w7NHEmnKR8d270v9Sll7zHhfYOvoro0t+dsM3L/CFLBROCdfyS9JiPy1nJtW0I+WeB
 g7jo0v3wR6TsnyVNdrSUNAnG7ssFQvW7TDWQnJ4fbLZFPT0cuve7JGtzAQZO4v2V9PlZ
 Yyo/QakotGlXgz3xhWJFjwBiDIAXKhqV7TYmF0fn2HdrhDR1BNxWfGGyNSKcd0ltDNLe
 e2+vRaoOiQmzWfOrqNJVX7S1NTw8U5wNy3EulT2zvCAmNEHc3+UABbmlD4cEHKSL6XaO
 ZJRQ==
X-Gm-Message-State: AO0yUKU56mQrT0JmgRMpxU386jxyDqzrtvJ5n6xmZWXMuFAe+TnmnOPc
 Ma47SRGhkES3vIVQVfN6qiP0uWO58bfLC1bvt70TiowygH3p5L84qasgBjiNR+/7pnft5z0K1cB
 BKQNYBw4K8mC96CcNoMgb6uU9UTo9dGoZNYxL1HJqVA==
X-Received: by 2002:a17:902:e193:b0:19c:fa22:e984 with SMTP id
 y19-20020a170902e19300b0019cfa22e984mr810385pla.48.1678849254255; 
 Tue, 14 Mar 2023 20:00:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set8rqj+9WtUEGouiWdbzxGnLTn7BrtbXCAmSzInNN+RhqLc6M5r9l6Ob46h05wOrKZfnR2lwUQ==
X-Received: by 2002:a17:902:e193:b0:19c:fa22:e984 with SMTP id
 y19-20020a170902e19300b0019cfa22e984mr810372pla.48.1678849253943; 
 Tue, 14 Mar 2023 20:00:53 -0700 (PDT)
Received: from [10.72.13.131] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a170902ed4200b00198d7b52eefsm2393850plb.257.2023.03.14.20.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Mar 2023 20:00:53 -0700 (PDT)
Message-ID: <c81a9b79-1ad3-8961-15bd-1b07848946b3@redhat.com>
Date: Wed, 15 Mar 2023 11:00:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH vhost v2 12/12] virtio_ring: introduce virtqueue_reset()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230308064443.50639-13-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIzLzMvOCAxNDo0NCwgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2UgdmlydHF1
ZXVlX3Jlc2V0KCkgdG8gcmVsZWFzZSBhbGwgYnVmZmVyIGluc2lkZSB2cS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCgo+IC0tLQo+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4
IGYyNmJkN2JiZmY1ZS4uMWE4ZGU5MTZiYjIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAg
LTI3ODcsNiArMjc4NywzOSBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsIHUzMiBudW0sCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfcmVz
aXplKTsKPiAgIAo+ICsvKioKPiArICogdmlydHF1ZXVlX3Jlc2V0IC0gZGV0YWNoIGFuZCByZWN5
Y2xlIGFsbCB1bnVzZWQgYnVmZmVycwo+ICsgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3
ZSdyZSB0YWxraW5nIGFib3V0Lgo+ICsgKiBAcmVjeWNsZTogY2FsbGJhY2sgdG8gcmVjeWNsZSB1
bnVzZWQgYnVmZmVycwo+ICsgKgo+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2Fs
bCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiArICogYXQgdGhlIHNhbWUg
dGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiArICoKPiArICogUmV0dXJucyB6ZXJvIG9yIGEg
bmVnYXRpdmUgZXJyb3IuCj4gKyAqIDA6IHN1Y2Nlc3MuCj4gKyAqIC1FQlVTWTogRmFpbGVkIHRv
IHN5bmMgd2l0aCBkZXZpY2UsIHZxIG1heSBub3Qgd29yayBwcm9wZXJseQo+ICsgKiAtRU5PRU5U
OiBUcmFuc3BvcnQgb3IgZGV2aWNlIG5vdCBzdXBwb3J0ZWQKPiArICogLUVQRVJNOiBPcGVyYXRp
b24gbm90IHBlcm1pdHRlZAo+ICsgKi8KPiAraW50IHZpcnRxdWV1ZV9yZXNldChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsCj4gKwkJICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwgdm9pZCAqYnVmKSkKPiArewo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192
dnEoX3ZxKTsKPiArCWludCBlcnI7Cj4gKwo+ICsJZXJyID0gdmlydHF1ZXVlX2Rpc2FibGVfYW5k
X3JlY3ljbGUoX3ZxLCByZWN5Y2xlKTsKPiArCWlmIChlcnIpCj4gKwkJcmV0dXJuIGVycjsKPiAr
Cj4gKwlpZiAodnEtPnBhY2tlZF9yaW5nKQo+ICsJCXZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKHZx
KTsKPiArCWVsc2UKPiArCQl2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiArCj4gKwlyZXR1
cm4gdmlydHF1ZXVlX2VuYWJsZV9hZnRlcl9yZXNldChfdnEpOwo+ICt9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKHZpcnRxdWV1ZV9yZXNldCk7Cj4gKwo+ICAgLyogT25seSBhdmFpbGFibGUgZm9yIHNw
bGl0IHJpbmcgKi8KPiAgIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX25ld192aXJ0cXVldWUodW5z
aWduZWQgaW50IGluZGV4LAo+ICAgCQkJCSAgICAgIHVuc2lnbmVkIGludCBudW0sCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
aW5kZXggMWZhNTAxOTFjZjBhLi4yMmJiZDA2ZWY4YzggMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9s
aW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBAQCAtOTcsNiAr
OTcsOCBAQCBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxKTsKPiAgIAo+ICAgaW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAq
dnEsIHUzMiBudW0sCj4gICAJCSAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpKTsKPiAraW50IHZpcnRxdWV1ZV9yZXNldChzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwKPiArCQkgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lk
ICpidWYpKTsKPiAgIAo+ICAgLyoqCj4gICAgKiBzdHJ1Y3QgdmlydGlvX2RldmljZSAtIHJlcHJl
c2VudGF0aW9uIG9mIGEgZGV2aWNlIHVzaW5nIHZpcnRpbwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
