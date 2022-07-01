Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE5C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 157B740AF6;
	Fri,  1 Jul 2022 09:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 157B740AF6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcgJlsXS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X2zPvl2_nAeU; Fri,  1 Jul 2022 09:09:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2846D40A93;
	Fri,  1 Jul 2022 09:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2846D40A93
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0E12C0032;
	Fri,  1 Jul 2022 09:09:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F25C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA00F40AF6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA00F40AF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8C9_XFZVIMT
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FC9140A93
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FC9140A93
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656666569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saiQ5wFJJA8eA9HPaDwAsrYblDAAKsPCjYisojMTkZw=;
 b=FcgJlsXS+Jj7GhH3qNZ0DCfniHmml1vRkQERzXVrbEF353ccSva8BAvsqCC8oximKvzcrz
 Z7f9O3yOU2PPntH1gBtid/136C4AMSeEsaOzf4I1X1c9pTZTg+E6h8nLAuyzS5M/3QAtqT
 HndaYb5snwkKJqiNWoNBk4athLN7/MA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-EIBl41ZKOjy4y4x46lERSQ-1; Fri, 01 Jul 2022 05:09:28 -0400
X-MC-Unique: EIBl41ZKOjy4y4x46lERSQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 c16-20020a170902b69000b0016a71a49c0cso1169990pls.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=saiQ5wFJJA8eA9HPaDwAsrYblDAAKsPCjYisojMTkZw=;
 b=nC+XSDtmLLHe2Jr1qV3hkzb9U/QUIYC3nz0pyVHQzw+WdQMyy4RaN3v5UmTYPKEOy1
 0mldFcrO5l+MN9ye+fE1CdpdEUyy6z+UdXLDMTVyvRapbu7Hi8YihiZyv8Ifip70XOff
 MeBT6hZX4YIQO3VUYx0yd8HJFfaa7G1yrbHV+QD3cKNGH6e43Y2OfeEmqAb4y0cUXC33
 4x/RH52Wl/9QnGTA2x5JSnbGP1mUaCEMF2jAiMo8CyrASoYTGdhq/go48aEal9Rppcvn
 rO9DrSdfqW8cpJa/lJ6pOkFV+HZ4Rsb3Anp86DUoL2tvtpxUTnlaDVowICEhI6Y+friA
 MPyQ==
X-Gm-Message-State: AJIora+9gcWeEMyL+JmrzqDNr9KyZ1R/BXzhvOH3trqC9UzumBRvxf7n
 PiW/K6KRLLAijJjG4sB2O/+Q7Hspxs3qFpMtlJmhgH0aHFClSUu/FbqCplcpox1qn6caP1MJABS
 +lnmkXbvyZMWtczEVo/eQX3AtZU85sFR3+5TMTglbuQ==
X-Received: by 2002:a17:90a:fa8c:b0:1ec:9f5c:846d with SMTP id
 cu12-20020a17090afa8c00b001ec9f5c846dmr15441630pjb.73.1656666567472; 
 Fri, 01 Jul 2022 02:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vA1dTIazYR3bB1gNFv3RFbJN8Z3XTbc6Oeecp05m0N8NOinTXnkwxvAjkIm4tnkL8fohP/9Q==
X-Received: by 2002:a17:90a:fa8c:b0:1ec:9f5c:846d with SMTP id
 cu12-20020a17090afa8c00b001ec9f5c846dmr15441568pjb.73.1656666567223; 
 Fri, 01 Jul 2022 02:09:27 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jj22-20020a170903049600b001674d61c1c6sm14812024plb.272.2022.07.01.02.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:09:26 -0700 (PDT)
Message-ID: <6256ad45-1606-f805-3427-ecee360c011f@redhat.com>
Date: Fri, 1 Jul 2022 17:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 14/40] virtio_ring: split: introduce
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-15-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgc3Bs
aXQgc3VwcG9ydHMgcmVzaXplLgo+Cj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nl
c3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gd2Ugd2lsbCByZWxlYXNl
IHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiBpbmRp
Y2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUgb2xkIHZyaW5nLgo+Cj4g
SW4gdGhlIGNhc2Ugb2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9z
cGxpdCgpKSB0aGUKPiB2aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1
c2VkLgo+Cj4gSW4gYWRkaXRpb24sIHZyaW5nX2FsaWduLCBtYXlfcmVkdWNlX251bSBhcmUgbmVj
ZXNzYXJ5IGZvciByZWFsbG9jYXRpbmcKPiB2cmluZywgc28gdGhleSBhcmUgcmV0YWluZWQgZm9y
IGNyZWF0aW5nIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMy
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDljODNjNWU2ZDVhOS4u
MWFhYTFlNWY5OTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxMiw2ICsyMTIsNyBA
QCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBzdHJ1Y3Qg
dnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVt
KTsKPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ICAg
Cj4gICAvKgo+ICAgICogSGVscGVycy4KPiBAQCAtMTExNCw2ICsxMTE1LDM3IEBAIHN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCXJldHVy
biB2cTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoc3Ry
dWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2
cmluZyA9IHt9Owo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4g
KwlpbnQgZXJyOwo+ICsKPiArCWVyciA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KCZ2cmluZywg
dmRldiwgbnVtLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24sCj4gKwkJCQkgICAgICB2cS0+c3BsaXQu
bWF5X3JlZHVjZV9udW0pOwo+ICsJaWYgKGVycikKPiArCQlnb3RvIGVycjsKCgpJdCdzIGJldHRl
ciB0byBoYXZlIGRlY291cGxlIHRoZSBhbGxvY2F0aW9uIGZ1dHVyZSBtb3JlIHRvIGF2b2lkIGFu
eSAKcmV3aW5kIGhlcmUgaW4gdGhlIGZ1dHVyZS4KCkJ1dCB0aGUgcGF0Y2ggc2hvdWxkIGJlIGZp
bmUuCgpTbwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAr
Cj4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmcpOwo+ICsJaWYg
KGVycikgewo+ICsJCXZyaW5nX2ZyZWVfc3BsaXQoJnZyaW5nLCB2ZGV2KTsKPiArCQlnb3RvIGVy
cjsKPiArCX0KPiArCj4gKwl2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ICsKPiArCXZpcnRxdWV1ZV9p
bml0KHZxLCB2cmluZy52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxp
dCh2cSwgJnZyaW5nKTsKPiArCXZpcnRxdWV1ZV92cmluZ19pbml0X3NwbGl0KHZxKTsKPiArCj4g
KwlyZXR1cm4gMDsKPiArCj4gK2VycjoKPiArCXZpcnRxdWV1ZV9yZWluaXRfc3BsaXQodnEpOwo+
ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICAKPiAgIC8qCj4gICAgKiBQYWNrZWQgcmlu
ZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
