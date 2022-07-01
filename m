Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D30C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7B583380;
	Fri,  1 Jul 2022 09:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C7B583380
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PaITlvTG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBp5GL1h-tH3; Fri,  1 Jul 2022 09:39:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C4A1183459;
	Fri,  1 Jul 2022 09:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4A1183459
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8F3C0035;
	Fri,  1 Jul 2022 09:39:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE156C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2FCB83459
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:39:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2FCB83459
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3mmlNHyUd7g
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:39:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A48B483380
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A48B483380
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656668389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
 b=PaITlvTG1hJCz7f7vx6xXHcCF7/FLQs2YtmRau83iRQBD2MNBUTLBFgNDlMgX5GjUfjf4V
 fOcDS10rLrG0L4P5pPgslCsaCGiZQCp0Vo+TKOoyjYnCUTJIpBM5tPrSH+BEbSJRM+zNeP
 jEJ7OZlJR8uwQpg8FC5JSjMJvbPC31g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-EK4ySwsOPfKTt95wokluTg-1; Fri, 01 Jul 2022 05:39:48 -0400
X-MC-Unique: EK4ySwsOPfKTt95wokluTg-1
Received: by mail-pj1-f72.google.com with SMTP id
 gd18-20020a17090b0fd200b001ef193b5452so1135751pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
 b=d98I1J6n8HjAjXgDsOTsuua2QbseFh5y0CxfK62IxDXFehiX7TXHhyCgruxbQ1QFo0
 gPowjyN3I07pbsn3VOB4oiRGF2bDG87OHgOOZ4/hz/mzlFBVdLyGtoS+JAqEgwjFWchb
 5xAoJM1l1rBJFIykOclTRlUxtHljaDq/n7upW1QNF0zmJuYgiUSQCZA0cDT00T/bK4Nd
 CkEb4JPPGFXItxT8DWfjSuTXZ/J4+HSxp6rdKnZZK6WV62/llRYlzHLk/h3yV5+2Nj/U
 2tBRewXNKatKUYS3caC47Q6tc7uJA5RfPAkhEhlE8cHQZm2zK3bSGPno+vfnKa4QMOHX
 /jEg==
X-Gm-Message-State: AJIora+daUh1X7FPdifgE3Hwd0tOOR3SgtlX1R9oZr8ugqr6d1L8MkL6
 aSehLVjXn7dE2DU9fRoycABFLLhsM1QrbMmcchXRLZ/OScUXBIFATxWzH8ehjSeGnVtb1YTX0w1
 oDki8dFpTslmteO8BVwpraM4QmoAbI6z+/SRG8z0N2g==
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id
 u10-20020a63454a000000b00411bbffb079mr4669459pgk.507.1656668387167; 
 Fri, 01 Jul 2022 02:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQXl0Mg32c6PANnbBYsi+TCYur6T2X1Z6vqtoZHDXDxtmKbFKHms2mPc6lxJgdRzWP3sExWg==
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id
 u10-20020a63454a000000b00411bbffb079mr4669428pgk.507.1656668386921; 
 Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jy18-20020a17090b325200b001e31803540fsm6079692pjb.6.2022.07.01.02.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Message-ID: <494bcf3f-d42c-f05b-cbdb-d4ba834bd118@redhat.com>
Date: Fri, 1 Jul 2022 17:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 28/40] virtio_pci: introduce helper to get/set queue
 reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIG5ldyBo
ZWxwZXJzIHRvIGltcGxlbWVudCBxdWV1ZSByZXNldCBhbmQgZ2V0IHF1ZXVlIHJlc2V0Cj4gc3Rh
dHVzLgo+Cj4gICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vl
cy8xMjQKPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVz
LzEzOQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAzNSArKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5o
ICAgICAgfCAgMiArKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+IGluZGV4IGZhMmE5NDQ1YmIxOC4u
MDc0MTU2NTQyNDdjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMK
PiBAQCAtMyw2ICszLDcgQEAKPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5o
Pgo+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5o
Pgo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiAgIAo+ICAgLyoKPiAgICAqIHZwX21vZGVy
bl9tYXBfY2FwYWJpbGl0eSAtIG1hcCBhIHBhcnQgb2YgdmlydGlvIHBjaSBjYXBhYmlsaXR5Cj4g
QEAgLTQ3NCw2ICs0NzUsNDAgQEAgdm9pZCB2cF9tb2Rlcm5fc2V0X3N0YXR1cyhzdHJ1Y3Qgdmly
dGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LAo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
dnBfbW9kZXJuX3NldF9zdGF0dXMpOwo+ICAgCj4gKy8qCj4gKyAqIHZwX21vZGVybl9nZXRfcXVl
dWVfcmVzZXQgLSBnZXQgdGhlIHF1ZXVlIHJlc2V0IHN0YXR1cwo+ICsgKiBAbWRldjogdGhlIG1v
ZGVybiB2aXJ0aW8tcGNpIGRldmljZQo+ICsgKiBAaW5kZXg6IHF1ZXVlIGluZGV4Cj4gKyAqLwo+
ICtpbnQgdnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5f
ZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcgX19pb21lbSAqY2ZnID0gbWRldi0+Y29tbW9uOwo+ICsKPiArCXZwX2lvd3JpdGUxNihp
bmRleCwgJmNmZy0+cXVldWVfc2VsZWN0KTsKPiArCXJldHVybiB2cF9pb3JlYWQxNigmY2ZnLT5x
dWV1ZV9yZXNldCk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodnBfbW9kZXJuX2dldF9xdWV1
ZV9yZXNldCk7Cj4gKwo+ICsvKgo+ICsgKiB2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0IC0gcmVz
ZXQgdGhlIHF1ZXVlCj4gKyAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRpby1wY2kgZGV2aWNlCj4g
KyAqIEBpbmRleDogcXVldWUgaW5kZXgKPiArICovCj4gK3ZvaWQgdnBfbW9kZXJuX3NldF9xdWV1
ZV9yZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgp
Cj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY2ZnID0gbWRl
di0+Y29tbW9uOwo+ICsKPiArCXZwX2lvd3JpdGUxNihpbmRleCwgJmNmZy0+cXVldWVfc2VsZWN0
KTsKPiArCXZwX2lvd3JpdGUxNigxLCAmY2ZnLT5xdWV1ZV9yZXNldCk7Cj4gKwo+ICsJd2hpbGUg
KHZwX2lvcmVhZDE2KCZjZmctPnF1ZXVlX3Jlc2V0KSkKPiArCQltc2xlZXAoMSk7Cj4gKwo+ICsJ
d2hpbGUgKHZwX2lvcmVhZDE2KCZjZmctPnF1ZXVlX2VuYWJsZSkpCj4gKwkJbXNsZWVwKDEpOwo+
ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQpOwo+ICsK
PiAgIC8qCj4gICAgKiB2cF9tb2Rlcm5fcXVldWVfdmVjdG9yIC0gc2V0IHRoZSBNU0lYIHZlY3Rv
ciBmb3IgYSBzcGVjaWZpYyB2aXJ0cXVldWUKPiAgICAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRp
by1wY2kgZGV2aWNlCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rl
cm4uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IGJlZWJjN2E0
YTMxZC4uZGVkMDExNTdmODY0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3Bj
aV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IEBA
IC0xMzQsNCArMTM0LDYgQEAgdm9pZCBfX2lvbWVtICogdnBfbW9kZXJuX21hcF92cV9ub3RpZnko
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiwKPiAgIAkJCQkgICAgICAgdTE2
IGluZGV4LCByZXNvdXJjZV9zaXplX3QgKnBhKTsKPiAgIGludCB2cF9tb2Rlcm5fcHJvYmUoc3Ry
dWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldik7Cj4gICB2b2lkIHZwX21vZGVybl9y
ZW1vdmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldik7Cj4gK2ludCB2cF9t
b2Rlcm5fZ2V0X3F1ZXVlX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1k
ZXYsIHUxNiBpbmRleCk7Cj4gK3ZvaWQgdnBfbW9kZXJuX3NldF9xdWV1ZV9yZXNldChzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpOwo+ICAgI2VuZGlmCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
