Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0935C4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 05:41:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9692661370
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 05:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9692661370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5642C403FB;
	Tue,  1 Jun 2021 05:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WB__p9S3FI9; Tue,  1 Jun 2021 05:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9763A400C7;
	Tue,  1 Jun 2021 05:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D5CFC000E;
	Tue,  1 Jun 2021 05:41:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97361C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DA716069D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kl8aMi79dxnw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA6A8605BB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622526072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1NQDpzYkVw3C4qKEnQShbVii8zUQRxdjPHGLNc8HVc=;
 b=DrwbYy7b4SbS/qq9twowAg9u6uRP49vwg30VHGr22DC06/12FCBOz8I2jzIb465TW6yZRN
 fjdntEoNLDFhm3okdJO+Gfoo+EXxiETthy91Thdgk/+Ty+mplwW4JjYPGjljT3KUNAeHA2
 S0U92NQbWhvb1ILQTG0jYSnedd58okM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-OigsHNC9OXuLlkr3SEwI5Q-1; Tue, 01 Jun 2021 01:41:10 -0400
X-MC-Unique: OigsHNC9OXuLlkr3SEwI5Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 v2-20020a17090a9602b029015b0bb8b2b9so1308019pjo.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=C1NQDpzYkVw3C4qKEnQShbVii8zUQRxdjPHGLNc8HVc=;
 b=bawOd1w3z2+g0k48wSoyykyJ/F4YlwsUtH7bsJ2JC6BOJpNk7VgQXgO7rgqZl9NSft
 vVZUmoO7BvC/4JJBwLZnd8LP6cZZJGt+E0lG7TbWMSC1ohd/M5zugTIVF+RgUWO25je7
 SZVxJG5kOKflA3+Y9YQkivYfXXjGDWoRPBnQoUwxVc4inRjVAqmG6gQIepBJPyw17Y6u
 Xd75tB9Vr3hjlRE60wEiL+R//wW2wYLWHkuRSDIIT2AsSnflTRh6sXN1nELSED5WKze5
 tq4WCsl100m6fw2fRKo1vDlwzIz1nhmROt413Yr46ILewMJRYDSPyMyX/aKCb00/avOd
 SEtQ==
X-Gm-Message-State: AOAM530Xie1yg+p+ctvsGVLwcqHrAMok1RMaLWg0LQYa5icef6spswz3
 4Dj61X6xsqYzexP6b6IvvfXpNhJ0s7dvKQktFbkGel3TYKrLycy40w5ra86Q3SYsRjHsZZxuPtd
 yqLZjE2/7tn6SO50nUN8HhAWoFCUppCM9Tou9ZEgDag==
X-Received: by 2002:a17:90a:aa0b:: with SMTP id
 k11mr2974604pjq.153.1622526069788; 
 Mon, 31 May 2021 22:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVClbCc5D4O+VxgtucOnXx4FQ/UfOs2+Bi5Vn/ZGvK3wa95qutO5mmev48fKsXbYESGPaV2Q==
X-Received: by 2002:a17:90a:aa0b:: with SMTP id
 k11mr2974589pjq.153.1622526069526; 
 Mon, 31 May 2021 22:41:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a15sm12044118pff.128.2021.05.31.22.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 22:41:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio/vdpa: Clear the available index during probe
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210531160502.31610-1-elic@nvidia.com>
 <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Message-ID: <70d6217d-3722-156b-fac0-620129bc3e56@redhat.com>
Date: Tue, 1 Jun 2021 13:40:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIxLzYvMSDkuIrljYgxMDoyMCwgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAy
MS82LzEg5LiK5Y2IMTI6MDUsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+IENsZWFyIHRoZSBhdmFpbGFi
bGUgaW5kZXggYXMgcGFydCBvZiB0aGUgaW5pdGlhbGl6YXRpb24gcHJvY2VzcyB0bwo+PiBjbGVh
ciBhbmQgdmFsdWVzIHRoYXQgbWlnaHQgYmUgbGVmdCBmcm9tIHByZXZpb3VzIHVzYWdlIG9mIHRo
ZSBkZXZpY2UuCj4+IEZvciBleGFtcGxlLCBpZiB0aGUgZGV2aWNlIHdhcyBwcmV2aW91c2x5IHVz
ZWQgYnkgdmhvc3RfdmRwYSBhbmQgbm93Cj4+IHByb2JlZCBieSB2aG9zdF92ZHBhLCB5b3Ugd2Fu
dCB0byBzdGFydCB3aXRoIGluZGljZXMuCj4+Cj4+IEZpeGVzOiBjMDQzYjRhOGNmM2IgKCJ2aXJ0
aW86IGludHJvZHVjZSBhIHZEUEEgYmFzZWQgdHJhbnNwb3J0IikKPj4gU2lnbmVkLW9mZi1ieTog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+IC0tLQo+Cj4KPiBBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPgo+IE5vdGUgdGhhdCB3ZSBwcm9iYWJseSBuZWVk
IGEgZm9sbG93LXVwIGZpeGVzIGZvciB2cF92ZHBhIGRyaXZlci4KPgo+IEkgd2lsbCBwb3N0IGl0
IHNvb24uCj4KPiBUaGFua3MKCgpIaSBFbGk6CgpSZXRoaW5rIGFib3V0IHRoaXMsIGl0IG9ubHkg
d29ya3MgZm9yIHRoZSBjYXNlIG9mIHNwbGl0IHZpcnRxdWV1ZS4KCkkgd2lsbCBwb3N0IGEgc2Vy
aWVzIHRoYXQgbWFrZXMgaXQgd29yayBmb3IgYm90aCBwYWNrZWQgYW5kIHNwbGl0IAp2aXJ0cXVl
dWUgKHdpdGggc29tZSB0d2VhayBvbiB0aGlzIHBhdGNoKS4KCkRvZXMgdGhpcyB3b3JrIGZvciB5
b3U/CgpUaGFua3MKCgo+Cj4KPj4gwqAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDYg
KysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jCj4+IGluZGV4IGUyOGFjZjQ4MmUwYy4uMzJmYjEyMWE2ZWM0IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb192ZHBhLmMKPj4gQEAgLTE0Miw2ICsxNDIsNyBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92
cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgCj4+IHVuc2lnbmVkIGludCBpbmRleCwKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
dmlydHF1ZXVlICp2cTsKPj4gwqDCoMKgwqDCoCB1NjQgZGVzY19hZGRyLCBkcml2ZXJfYWRkciwg
ZGV2aWNlX2FkZHI7Cj4+ICvCoMKgwqAgc3RydWN0IHZkcGFfdnFfc3RhdGUgc3RhdGUgPSB7MH07
Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsKPj4gwqDCoMKgwqDCoCB1MzIgYWxp
Z24sIG51bTsKPj4gwqDCoMKgwqDCoCBpbnQgZXJyOwo+PiBAQCAtMTkxLDYgKzE5MiwxMSBAQCB2
aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgCj4+IHVuc2ln
bmVkIGludCBpbmRleCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3ZxOwo+PiDCoMKg
wqDCoMKgIH0KPj4gwqAgK8KgwqDCoCAvKiByZXNldCBhdmFpbGFibGUgaW5kZXggKi8KPj4gK8Kg
wqDCoCBlcnIgPSBvcHMtPnNldF92cV9zdGF0ZSh2ZHBhLCBpbmRleCwgJnN0YXRlKTsKPj4gK8Kg
wqDCoCBpZiAoZXJyKQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfdnE7Cj4+ICsKPj4gwqDC
oMKgwqDCoCBvcHMtPnNldF92cV9yZWFkeSh2ZHBhLCBpbmRleCwgMSk7Cj4+IMKgIMKgwqDCoMKg
wqAgdnEtPnByaXYgPSBpbmZvOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
