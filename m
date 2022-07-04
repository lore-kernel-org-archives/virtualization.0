Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B8CCA483
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 03:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E54AD60A81;
	Mon,  4 Jul 2022 03:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E54AD60A81
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GWJzdVcG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4VSm05L4hRL; Mon,  4 Jul 2022 03:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B73660B8A;
	Mon,  4 Jul 2022 03:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B73660B8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AAC6C0032;
	Mon,  4 Jul 2022 03:27:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 824DDC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 551D860B8A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:27:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 551D860B8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNTrAHqF6snx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:27:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6980560A81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6980560A81
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656905270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRPYTHBNTJ6D/pzk3vuj7nrJ9A7vkHl8Eh3Xeb1Gu4I=;
 b=GWJzdVcGc9JOEgi14c8YHb0/B+nWEfFbjCqnWX5xOMna3z3oD7483XAUmJG/cbhX6ub8Zj
 cYEvZQNvepw/+nidUM8OVXkxE570TCsHXGFCgwpRTXo0T8ZK8mbGJYiPk7HyLdQvr8pn/C
 tuJfQZp9goP1OH8sN9FeAek42yhubs4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-hQqgj8vMOLyCiYUROCO1vg-1; Sun, 03 Jul 2022 23:27:49 -0400
X-MC-Unique: hQqgj8vMOLyCiYUROCO1vg-1
Received: by mail-pf1-f198.google.com with SMTP id
 bx17-20020a056a00429100b005283c415c8cso1432795pfb.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 20:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aRPYTHBNTJ6D/pzk3vuj7nrJ9A7vkHl8Eh3Xeb1Gu4I=;
 b=wpcWj9yEDFHdV8eZNQWFGfeQBP6uQCSUUNzaZDbYA4RJAz4eWC0skjR2a1IBEw5fAm
 aCPCOY+0nM++YyFoBkn+skGQRjZ0z3iXI32BZFBdywNvzRAUcjPKqSWclT6yrgcjSKox
 tEioXDgs+YgAvYqxErefU0wvPgTbGx8QgI7TmojzIpBUiaZzhl9fueGhhARkZmllze83
 fz3JGHgTFLjOzZYhpx+n3KwKQMpq/ANXTF6CA3/cbx1CByJflJTVtVZTGq2aWBD1ZY1c
 B/VY/pFNipRxeHDSQxPtGuyb0egZJvHb2vXrRJbFR6IRha6Jluh60JuF3La42/i4dgWP
 wEhw==
X-Gm-Message-State: AJIora9VgwD//rw2g/JxMglE/bZ9jWkK/41ElZ/P6/UA/KAt9g4GXLlF
 oM3FTGINdAO+aUUSKlTi6/0wf85cke6U54ZzlEOFSNJx/jW+iGSKRTqLvsbzxMYves7jztDkdOW
 /gL5hQWaeZ7dQC+0C3gmBBNpxBGqP3YKUzeeUtNhcbg==
X-Received: by 2002:a17:902:f681:b0:16a:4ca8:65e2 with SMTP id
 l1-20020a170902f68100b0016a4ca865e2mr33354291plg.63.1656905268187; 
 Sun, 03 Jul 2022 20:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s/uCdtDZHsC0HjhgrEkOhi+t5KGA26R5v4fDXt8yqlKRWInD3k5Nf4L4GFhmSP9ZEn6fn8Fw==
X-Received: by 2002:a17:902:f681:b0:16a:4ca8:65e2 with SMTP id
 l1-20020a170902f68100b0016a4ca865e2mr33354249plg.63.1656905267861; 
 Sun, 03 Jul 2022 20:27:47 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l189-20020a6225c6000000b005255263a864sm19874688pfl.169.2022.07.03.20.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 20:27:47 -0700 (PDT)
Message-ID: <0263ecf4-043a-7cc1-950f-f48d3b66bed7@redhat.com>
Date: Mon, 4 Jul 2022 11:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 30/40] virtio_pci: support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-31-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-31-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3IgUVVFVUUgUkVTRVQuCj4KPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIHRoZXNlIHN0ZXBzOgo+Cj4gICAxLiBu
b3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiAgIDIuIHJlY3ljbGUgdGhlIGJ1
ZmZlciBzdWJtaXR0ZWQKPiAgIDMuIHJlc2V0IHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ICAg
NC4gbW1hcCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1ZXVlCj4KPiBUaGlzIHBh
dGNoIGltcGxlbWVudHMgdmlydGlvX3Jlc2V0X3ZxKCksIHZpcnRpb19lbmFibGVfcmVzZXRxKCkg
aW4gdGhlCj4gcGNpIHNjZW5hcmlvLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfY29tbW9uLmMgfCAxMiArKystCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bi5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jICAgICAgIHwgIDIgKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAg
ICAgICAgICAgICB8ICAxICsKPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTA4IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiBpbmRleCBj
YTUxZmNjOWRhYWIuLmFkMjU4YTlkM2I5ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYwo+IEBAIC0yMTQsOSArMjE0LDE1IEBAIHN0YXRpYyB2b2lkIHZwX2RlbF92cShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSkKPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvID0gdnBf
ZGV2LT52cXNbdnEtPmluZGV4XTsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCj4gLQlz
cGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gLQlsaXN0X2RlbCgmaW5m
by0+bm9kZSk7Cj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdz
KTsKPiArCS8qCj4gKwkgKiBJZiBpdCBmYWlscyBkdXJpbmcgcmUtZW5hYmxlIHJlc2V0IHZxLiBU
aGlzIHdheSB3ZSB3b24ndCByZWpvaW4KPiArCSAqIGluZm8tPm5vZGUgdG8gdGhlIHF1ZXVlLiBQ
cmV2ZW50IHVuZXhwZWN0ZWQgaXJxcy4KPiArCSAqLwo+ICsJaWYgKCF2cS0+cmVzZXQpIHsKPiAr
CQlzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwkJbGlzdF9kZWwo
JmluZm8tPm5vZGUpOwo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+bG9jaywg
ZmxhZ3MpOwo+ICsJfQo+ICAgCj4gICAJdnBfZGV2LT5kZWxfdnEoaW5mbyk7Cj4gICAJa2ZyZWUo
aW5mbyk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gaW5kZXggOTA0MWQ5YTQxYjdk
Li43NTRlNWUxMDM4NmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm4uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBAQCAt
MzQsNiArMzQsOSBAQCBzdGF0aWMgdm9pZCB2cF90cmFuc3BvcnRfZmVhdHVyZXMoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiAgIAlpZiAoKGZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fRl9TUl9JT1YpKSAmJgo+ICAgCQkJcGNpX2ZpbmRfZXh0X2NhcGFiaWxpdHko
cGNpX2RldiwgUENJX0VYVF9DQVBfSURfU1JJT1YpKQo+ICAgCQlfX3ZpcnRpb19zZXRfYml0KHZk
ZXYsIFZJUlRJT19GX1NSX0lPVik7Cj4gKwo+ICsJaWYgKGZlYXR1cmVzICYgQklUX1VMTChWSVJU
SU9fRl9SSU5HX1JFU0VUKSkKPiArCQlfX3ZpcnRpb19zZXRfYml0KHZkZXYsIFZJUlRJT19GX1JJ
TkdfUkVTRVQpOwo+ICAgfQo+ICAgCj4gICAvKiB2aXJ0aW8gY29uZmlnLT5maW5hbGl6ZV9mZWF0
dXJlcygpIGltcGxlbWVudGF0aW9uICovCj4gQEAgLTE5OSw2ICsyMDIsOTUgQEAgc3RhdGljIGlu
dCB2cF9hY3RpdmVfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUxNiBtc2l4X3ZlYykKPiAgIAly
ZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZwX21vZGVybl9yZXNldF92cShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9k
ZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYpOwo+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJu
X2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV92cV9p
bmZvICppbmZvOwo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsKPiArCj4gKwlpZiAoIXZpcnRpb19o
YXNfZmVhdHVyZSh2cS0+dmRldiwgVklSVElPX0ZfUklOR19SRVNFVCkpCj4gKwkJcmV0dXJuIC1F
Tk9FTlQ7Cj4gKwo+ICsJdnBfbW9kZXJuX3NldF9xdWV1ZV9yZXNldChtZGV2LCB2cS0+aW5kZXgp
Owo+ICsKPiArCWluZm8gPSB2cF9kZXYtPnZxc1t2cS0+aW5kZXhdOwo+ICsKPiArCS8qIGRlbGV0
ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5s
b2NrLCBmbGFncyk7Cj4gKwlsaXN0X2RlbCgmaW5mby0+bm9kZSk7Cj4gKwlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCj4gKwlJTklUX0xJU1RfSEVBRCgm
aW5mby0+bm9kZSk7Cj4gKwo+ICsJLyogRm9yIHRoZSBjYXNlIHdoZXJlIHZxIGhhcyBhbiBleGNs
dXNpdmUgaXJxLCB0byBwcmV2ZW50IHRoZSBpcnEgZnJvbQo+ICsJICogYmVpbmcgcmVjZWl2ZWQg
YWdhaW4gYW5kIHRoZSBwZW5kaW5nIGlycSwgY2FsbCBzeW5jaHJvbml6ZV9pcnEoKSwgYW5kCj4g
KwkgKiBicmVhayBpdC4KPiArCSAqCj4gKwkgKiBXZSBjYW4ndCB1c2UgZGlzYWJsZV9pcnEoKSBz
aW5jZSBpdCBjb25mbGljdHMgd2l0aCB0aGUgYWZmaW5pdHkKPiArCSAqIG1hbmFnZWQgSVJRIHRo
YXQgaXMgdXNlZCBieSBzb21lIGRyaXZlcnMuIFNvIHRoaXMgaXMgZG9uZSBvbiB0b3Agb2YKPiAr
CSAqIElSUSBoYXJkZW5pbmcuCj4gKwkgKgo+ICsJICogSW4gdGhlIHNjZW5hcmlvIGJhc2VkIG9u
IHNoYXJlZCBpbnRlcnJ1cHRzLCB2cSB3aWxsIGJlIHNlYXJjaGVkIGZyb20KPiArCSAqIHRoZSBx
dWV1ZSB2aXJ0cXVldWVzLiBTaW5jZSB0aGUgcHJldmlvdXMgbGlzdF9kZWwoKSBoYXMgYmVlbiBk
ZWxldGVkCj4gKwkgKiBmcm9tIHRoZSBxdWV1ZSwgaXQgaXMgaW1wb3NzaWJsZSBmb3IgdnEgdG8g
YmUgY2FsbGVkIGluIHRoaXMgY2FzZS4KPiArCSAqIFRoZXJlIGlzIG5vIG5lZWQgdG8gY2xvc2Ug
dGhlIGNvcnJlc3BvbmRpbmcgaW50ZXJydXB0Lgo+ICsJICovCj4gKwlpZiAodnBfZGV2LT5wZXJf
dnFfdmVjdG9ycyAmJiBpbmZvLT5tc2l4X3ZlY3RvciAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikg
ewo+ICsjaWZkZWYgQ09ORklHX1ZJUlRJT19IQVJERU5fTk9USUZJQ0FUSU9OCj4gKwkJX192aXJ0
cXVldWVfYnJlYWsodnEpOwo+ICsjZW5kaWYKPiArCQlzeW5jaHJvbml6ZV9pcnEocGNpX2lycV92
ZWN0b3IodnBfZGV2LT5wY2lfZGV2LCBpbmZvLT5tc2l4X3ZlY3RvcikpOwo+ICsJfQo+ICsKPiAr
CXZxLT5yZXNldCA9IHRydWU7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBp
bnQgdnBfbW9kZXJuX2VuYWJsZV9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+
ICsJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEtPnZk
ZXYpOwo+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYt
Pm1kZXY7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvOwo+ICsJdW5zaWduZWQg
bG9uZyBmbGFncywgaW5kZXg7Cj4gKwlpbnQgZXJyOwo+ICsKPiArCWlmICghdnEtPnJlc2V0KQo+
ICsJCXJldHVybiAtRUJVU1k7Cj4gKwo+ICsJaW5kZXggPSB2cS0+aW5kZXg7Cj4gKwlpbmZvID0g
dnBfZGV2LT52cXNbaW5kZXhdOwo+ICsKPiArCWlmICh2cF9tb2Rlcm5fZ2V0X3F1ZXVlX3Jlc2V0
KG1kZXYsIGluZGV4KSkKPiArCQlyZXR1cm4gLUVCVVNZOwo+ICsKPiArCWlmICh2cF9tb2Rlcm5f
Z2V0X3F1ZXVlX2VuYWJsZShtZGV2LCBpbmRleCkpCj4gKwkJcmV0dXJuIC1FQlVTWTsKPiArCj4g
KwllcnIgPSB2cF9hY3RpdmVfdnEodnEsIGluZm8tPm1zaXhfdmVjdG9yKTsKPiArCWlmIChlcnIp
Cj4gKwkJcmV0dXJuIGVycjsKPiArCj4gKwlpZiAodnEtPmNhbGxiYWNrKSB7Cj4gKwkJc3Bpbl9s
b2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+ICsJCWxpc3RfYWRkKCZpbmZvLT5u
b2RlLCAmdnBfZGV2LT52aXJ0cXVldWVzKTsKPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2
cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCX0gZWxzZSB7Cj4gKwkJSU5JVF9MSVNUX0hFQUQoJmlu
Zm8tPm5vZGUpOwo+ICsJfQo+ICsKPiArI2lmZGVmIENPTkZJR19WSVJUSU9fSEFSREVOX05PVElG
SUNBVElPTgo+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3ZlY3RvcnMgJiYgaW5mby0+bXNpeF92ZWN0
b3IgIT0gVklSVElPX01TSV9OT19WRUNUT1IpCj4gKwkJX192aXJ0cXVldWVfdW5icmVhayh2cSk7
Cj4gKyNlbmRpZgo+ICsKPiArCXZwX21vZGVybl9zZXRfcXVldWVfZW5hYmxlKCZ2cF9kZXYtPm1k
ZXYsIGluZGV4LCB0cnVlKTsKPiArCXZxLT5yZXNldCA9IGZhbHNlOwo+ICsKPiArCXJldHVybiAw
Owo+ICt9Cj4gKwo+ICAgc3RhdGljIHUxNiB2cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2aXJ0aW9f
cGNpX2RldmljZSAqdnBfZGV2LCB1MTYgdmVjdG9yKQo+ICAgewo+ICAgCXJldHVybiB2cF9tb2Rl
cm5fY29uZmlnX3ZlY3RvcigmdnBfZGV2LT5tZGV2LCB2ZWN0b3IpOwo+IEBAIC00MTMsNiArNTA1
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2aXJ0aW9fcGNpX2Nv
bmZpZ19ub2Rldl9vcHMgPSB7Cj4gICAJLnNldF92cV9hZmZpbml0eSA9IHZwX3NldF92cV9hZmZp
bml0eSwKPiAgIAkuZ2V0X3ZxX2FmZmluaXR5ID0gdnBfZ2V0X3ZxX2FmZmluaXR5LAo+ICAgCS5n
ZXRfc2htX3JlZ2lvbiAgPSB2cF9nZXRfc2htX3JlZ2lvbiwKPiArCS5yZXNldF92cQkgPSB2cF9t
b2Rlcm5fcmVzZXRfdnEsCj4gKwkuZW5hYmxlX3Jlc2V0X3ZxID0gdnBfbW9kZXJuX2VuYWJsZV9y
ZXNldF92cSwKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2NvbmZp
Z19vcHMgdmlydGlvX3BjaV9jb25maWdfb3BzID0gewo+IEBAIC00MzEsNiArNTI1LDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2aXJ0aW9fcGNpX2NvbmZpZ19vcHMg
PSB7Cj4gICAJLnNldF92cV9hZmZpbml0eSA9IHZwX3NldF92cV9hZmZpbml0eSwKPiAgIAkuZ2V0
X3ZxX2FmZmluaXR5ID0gdnBfZ2V0X3ZxX2FmZmluaXR5LAo+ICAgCS5nZXRfc2htX3JlZ2lvbiAg
PSB2cF9nZXRfc2htX3JlZ2lvbiwKPiArCS5yZXNldF92cQkgPSB2cF9tb2Rlcm5fcmVzZXRfdnEs
Cj4gKwkuZW5hYmxlX3Jlc2V0X3ZxID0gdnBfbW9kZXJuX2VuYWJsZV9yZXNldF92cSwKPiAgIH07
Cj4gICAKPiAgIC8qIHRoZSBQQ0kgcHJvYmluZyBmdW5jdGlvbiAqLwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IGluZGV4IDdiMDJiZTdmY2U2Ny4uODJiMDU4ZThjZTM0IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gQEAgLTIwMDgsNiArMjAwOCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmlu
Z19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAl2cS0+dnEudmRldiA9IHZkZXY7Cj4gICAJ
dnEtPnZxLm5hbWUgPSBuYW1lOwo+ICAgCXZxLT52cS5pbmRleCA9IGluZGV4Owo+ICsJdnEtPnZx
LnJlc2V0ID0gZmFsc2U7Cj4gICAJdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKPiAgIAl2cS0+bm90
aWZ5ID0gbm90aWZ5Owo+ICAgCXZxLT53ZWFrX2JhcnJpZXJzID0gd2Vha19iYXJyaWVyczsKPiBA
QCAtMjQ4Nyw2ICsyNDg4LDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1
ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl2cS0+dnEudmRldiA9IHZkZXY7Cj4gICAJdnEt
PnZxLm5hbWUgPSBuYW1lOwo+ICAgCXZxLT52cS5pbmRleCA9IGluZGV4Owo+ICsJdnEtPnZxLnJl
c2V0ID0gZmFsc2U7Cj4gICAJdnEtPndlX293bl9yaW5nID0gZmFsc2U7Cj4gICAJdnEtPm5vdGlm
eSA9IG5vdGlmeTsKPiAgIAl2cS0+d2Vha19iYXJyaWVycyA9IHdlYWtfYmFycmllcnM7Cj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5o
Cj4gaW5kZXggZGM0NzRhMGQ0OGQxLi44OGYyMTc5NmIxYzMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBAQCAtMzMs
NiArMzMsNyBAQCBzdHJ1Y3QgdmlydHF1ZXVlIHsKPiAgIAl1bnNpZ25lZCBpbnQgbnVtX2ZyZWU7
Cj4gICAJdW5zaWduZWQgaW50IG51bV9tYXg7Cj4gICAJdm9pZCAqcHJpdjsKPiArCWJvb2wgcmVz
ZXQ7Cj4gICB9OwoKCkkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvIG1vdmUgdmlydGlvX3Jpbmcg
cGFydCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guCgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoK
PiAgIAo+ICAgaW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
