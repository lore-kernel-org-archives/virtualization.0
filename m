Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DE2260F30;
	Tue, 12 Apr 2022 07:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bm4BC01ImzSb; Tue, 12 Apr 2022 07:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C23860593;
	Tue, 12 Apr 2022 07:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343BBC0082;
	Tue, 12 Apr 2022 07:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD3B0C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C269E40249
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p-A6hFjhQlMw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:08:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 842C740233
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649747296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rO0UiIR0RaZp+eJrqPEuwbF/F4u5EFxiYFSQC2lhpMQ=;
 b=TCpArwnnE6y8HPgC1eawpP9OICfLInKYgdeTDUwdNKp+BztGZPCjfkk+rOq950jupTjB2N
 ugVB/dvkwYeqEObflNDM+Gxd+FZENT5hbTxuyodht0WC4kKC1qfaUdFkepz1i7FxGgI7ib
 w99ZP5lT4b2PZRzeiOiHh3+lIJO78Rk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-atLL1UNHNVusHiOwbhSUIA-1; Tue, 12 Apr 2022 03:08:14 -0400
X-MC-Unique: atLL1UNHNVusHiOwbhSUIA-1
Received: by mail-pj1-f70.google.com with SMTP id
 p14-20020a17090a348e00b001cbc57fedc1so784437pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rO0UiIR0RaZp+eJrqPEuwbF/F4u5EFxiYFSQC2lhpMQ=;
 b=hyRr+lPET9SySkkHz30xIozRsl2DjYXPdujj4yqeqMbMnLjOX89ImsAaPfQmyzAPRk
 ZjrGKpXaQIHdCJCt7LVIUnAFywubFKtisbi7TcqRoxI9x1iO0ciDhvbiqqWkmbiDuK4L
 /D+Fbo5naRUy2sfU+0dOwc7uWVcUMwhZCCBLk6JcQ2OlDnBFzTc5RQnqz60Fatimioxl
 0ItnCJUWkqh+N/JOY3fD39MZgY/ANFJs0ZhFwwMVOXrzvdyj8VBm5DEUY95hHeMqaF2P
 9J/M9mAZhuCwR1juf7wHAS/CYdqVChcNCwUIUANOuL8e4Hn9zKzkDJSTXAxutaovgnSN
 JtRw==
X-Gm-Message-State: AOAM53056kBuk9xvTnhVGwrI6SJ/jCXFIpT3/O3iLW5eeRY23dTHdwlu
 uAYFU6qAG2JJlbp5a2HNLtqviQ8JEb5xl8s1TsI/Ff4BuDsBjZIi6CUsg0b5yypJ5bnCzvG6ErH
 lSMvvij97wQTUN+hrQQd4hM7Ja1ImUu9cuzEtfkPpAg==
X-Received: by 2002:a17:902:d4c1:b0:154:1273:6ec9 with SMTP id
 o1-20020a170902d4c100b0015412736ec9mr36389040plg.148.1649747293417; 
 Tue, 12 Apr 2022 00:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmBYQVhBgkM83IAVsIXuW8wi4G3nuNupPsrp7sYEa8TLNXxILPfIRwjGxeuvOgRL1kO9utqQ==
X-Received: by 2002:a17:902:d4c1:b0:154:1273:6ec9 with SMTP id
 o1-20020a170902d4c100b0015412736ec9mr36388997plg.148.1649747293111; 
 Tue, 12 Apr 2022 00:08:13 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a17090add4300b001ca56ea162bsm1611301pjv.33.2022.04.12.00.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 00:08:12 -0700 (PDT)
Message-ID: <d040a3fe-765e-93d6-cef9-603f23a0fd1e@redhat.com>
Date: Tue, 12 Apr 2022 15:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 23/32] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-24-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-24-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGlzIHBhdGNo
IGltcGxlbWVudHMgdmlydGlvIHBjaSBzdXBwb3J0IGZvciBRVUVVRSBSRVNFVC4KPgo+IFBlcmZv
cm1pbmcgcmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gdGhlc2Ugc3RlcHM6Cj4KPiAg
IDEuIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0IHRoZSBxdWV1ZQo+ICAgMi4gcmVjeWNsZSB0
aGUgYnVmZmVyIHN1Ym1pdHRlZAo+ICAgMy4gcmVzZXQgdGhlIHZyaW5nIChtYXkgcmUtYWxsb2Mp
Cj4gICA0LiBtbWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKPgo+IFRo
aXMgcGF0Y2ggaW1wbGVtZW50cyB2aXJ0aW9fcmVzZXRfdnEoKSwgdmlydGlvX2VuYWJsZV9yZXNl
dHEoKSBpbiB0aGUKPiBwY2kgc2NlbmFyaW8uCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9jb21tb24uYyB8ICA4ICstLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm4uYyB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8ICAyICsKPiAgIGluY2x1ZGUvbGludXgvdmlydGlv
LmggICAgICAgICAgICAgfCAgMSArCj4gICA0IGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9jb21tb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiBpbmRl
eCBmZGJkZTFkYjVlYzUuLjg2M2QzYThhMDk1NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9j
b21tb24uYwo+IEBAIC0yNDgsOSArMjQ4LDExIEBAIHN0YXRpYyB2b2lkIHZwX2RlbF92cShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvID0g
dnBfZGV2LT52cXNbdnEtPmluZGV4XTsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCj4g
LQlzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gLQlsaXN0X2RlbCgm
aW5mby0+bm9kZSk7Cj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZs
YWdzKTsKPiArCWlmICghdnEtPnJlc2V0KSB7CgoKT24gd2hpY2ggY29uZGl0aW9uIHRoYXQgd2Ug
bWF5IGhpdCB0aGlzIHBhdGg/CgoKPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2Nr
LCBmbGFncyk7Cj4gKwkJbGlzdF9kZWwoJmluZm8tPm5vZGUpOwo+ICsJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+ICsJfQo+ICAgCj4gICAJdnBfZGV2LT5k
ZWxfdnEoaW5mbyk7Cj4gICAJa2ZyZWUoaW5mbyk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bi5jCj4gaW5kZXggNDlhNDQ5MzczMmNmLi5jYjVkMzhmMWM5YzggMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfbW9kZXJuLmMKPiBAQCAtMzQsNiArMzQsOSBAQCBzdGF0aWMgdm9pZCB2cF90cmFu
c3BvcnRfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykK
PiAgIAlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9TUl9JT1YpKSAmJgo+ICAgCQkJ
cGNpX2ZpbmRfZXh0X2NhcGFiaWxpdHkocGNpX2RldiwgUENJX0VYVF9DQVBfSURfU1JJT1YpKQo+
ICAgCQlfX3ZpcnRpb19zZXRfYml0KHZkZXYsIFZJUlRJT19GX1NSX0lPVik7Cj4gKwo+ICsJaWYg
KGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9SSU5HX1JFU0VUKSkKPiArCQlfX3ZpcnRpb19z
ZXRfYml0KHZkZXYsIFZJUlRJT19GX1JJTkdfUkVTRVQpOwo+ICAgfQo+ICAgCj4gICAvKiB2aXJ0
aW8gY29uZmlnLT5maW5hbGl6ZV9mZWF0dXJlcygpIGltcGxlbWVudGF0aW9uICovCj4gQEAgLTE5
OSw2ICsyMDIsODMgQEAgc3RhdGljIGludCB2cF9hY3RpdmVfdnEoc3RydWN0IHZpcnRxdWV1ZSAq
dnEsIHUxNiBtc2l4X3ZlYykKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50
IHZwX21vZGVybl9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsJc3RydWN0
IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYpOwo+ICsJ
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4g
KwlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvOwo+ICsJdW5zaWduZWQgbG9uZyBmbGFn
czsKPiArCj4gKwlpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2cS0+dmRldiwgVklSVElPX0ZfUklO
R19SRVNFVCkpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7Cj4gKwo+ICsJdnBfbW9kZXJuX3NldF9xdWV1
ZV9yZXNldChtZGV2LCB2cS0+aW5kZXgpOwo+ICsKPiArCWluZm8gPSB2cF9kZXYtPnZxc1t2cS0+
aW5kZXhdOwo+ICsKPiArCS8qIGRlbGV0ZSB2cSBmcm9tIGlycSBoYW5kbGVyICovCj4gKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwlsaXN0X2RlbCgmaW5mby0+
bm9kZSk7Cj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsK
PiArCj4gKwlJTklUX0xJU1RfSEVBRCgmaW5mby0+bm9kZSk7Cj4gKwo+ICsJLyogRm9yIHRoZSBj
YXNlIHdoZXJlIHZxIGhhcyBhbiBleGNsdXNpdmUgaXJxLCB0byBwcmV2ZW50IHRoZSBpcnEgZnJv
bQo+ICsJICogYmVpbmcgcmVjZWl2ZWQgYWdhaW4gYW5kIHRoZSBwZW5kaW5nIGlycSwgY2FsbCBk
aXNhYmxlX2lycSgpLgo+ICsJICoKPiArCSAqIEluIHRoZSBzY2VuYXJpbyBiYXNlZCBvbiBzaGFy
ZWQgaW50ZXJydXB0cywgdnEgd2lsbCBiZSBzZWFyY2hlZCBmcm9tCj4gKwkgKiB0aGUgcXVldWUg
dmlydHF1ZXVlcy4gU2luY2UgdGhlIHByZXZpb3VzIGxpc3RfZGVsKCkgaGFzIGJlZW4gZGVsZXRl
ZAo+ICsJICogZnJvbSB0aGUgcXVldWUsIGl0IGlzIGltcG9zc2libGUgZm9yIHZxIHRvIGJlIGNh
bGxlZCBpbiB0aGlzIGNhc2UuCj4gKwkgKiBUaGVyZSBpcyBubyBuZWVkIHRvIGNsb3NlIHRoZSBj
b3JyZXNwb25kaW5nIGludGVycnVwdC4KPiArCSAqLwo+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3Zl
Y3RvcnMgJiYgaW5mby0+bXNpeF92ZWN0b3IgIT0gVklSVElPX01TSV9OT19WRUNUT1IpCj4gKwkJ
ZGlzYWJsZV9pcnEocGNpX2lycV92ZWN0b3IodnBfZGV2LT5wY2lfZGV2LCBpbmZvLT5tc2l4X3Zl
Y3RvcikpOwoKClNlZSB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgdGhlIHJldmVydCBvZiB0
aGUgZmlyc3QgdHJ5IHRvIGhhcmRlbiAKdGhlIGludGVycnVwdC4gV2UgcHJvYmFibHkgY2FuJ3Qg
dXNlIGRpc2FibGVfaXJxKCkgc2luY2UgaXQgY29uZmxpY3RzIAp3aXRoIHRoZSBhZmZpbml0eSBt
YW5hZ2VkIElSUSB0aGF0IGlzIHVzZWQgYnkgc29tZSBkcml2ZXJzLgoKV2UgbmVlZCB0byB1c2Ug
c3luY2hvbml6ZV9pcnEoKSBhbmQgcGVyIHZpcnRxdWV1ZSBmbGFnIGluc3RlYWQuIEFzIAptZW50
aW9uZWQgaW4gcHJldmlvdXMgcGF0Y2hlcywgdGhpcyBjb3VsZCBiZSBkb25lIG9uIHRvcCBvZiBt
eSByZXdvcmsgb24gCnRoZSBJUlEgaGFyZGVuaW5nIC4KCgo+ICsKPiArCXZxLT5yZXNldCA9IHRy
dWU7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgdnBfbW9kZXJuX2Vu
YWJsZV9yZXNldF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsJc3RydWN0IHZpcnRp
b19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodnEtPnZkZXYpOwo+ICsJc3RydWN0
IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4gKwlzdHJ1
Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvOwo+ICsJdW5zaWduZWQgbG9uZyBmbGFncywgaW5k
ZXg7Cj4gKwlpbnQgZXJyOwo+ICsKPiArCWlmICghdnEtPnJlc2V0KQo+ICsJCXJldHVybiAtRUJV
U1k7Cj4gKwo+ICsJaW5kZXggPSB2cS0+aW5kZXg7Cj4gKwlpbmZvID0gdnBfZGV2LT52cXNbaW5k
ZXhdOwo+ICsKPiArCS8qIGNoZWNrIHF1ZXVlIHJlc2V0IHN0YXR1cyAqLwo+ICsJaWYgKHZwX21v
ZGVybl9nZXRfcXVldWVfcmVzZXQobWRldiwgaW5kZXgpICE9IDEpCj4gKwkJcmV0dXJuIC1FQlVT
WTsKPiArCj4gKwllcnIgPSB2cF9hY3RpdmVfdnEodnEsIGluZm8tPm1zaXhfdmVjdG9yKTsKPiAr
CWlmIChlcnIpCj4gKwkJcmV0dXJuIGVycjsKPiArCj4gKwlpZiAodnEtPmNhbGxiYWNrKSB7Cj4g
KwkJc3Bpbl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+ICsJCWxpc3RfYWRk
KCZpbmZvLT5ub2RlLCAmdnBfZGV2LT52aXJ0cXVldWVzKTsKPiArCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCX0gZWxzZSB7Cj4gKwkJSU5JVF9MSVNU
X0hFQUQoJmluZm8tPm5vZGUpOwo+ICsJfQo+ICsKPiArCXZwX21vZGVybl9zZXRfcXVldWVfZW5h
YmxlKCZ2cF9kZXYtPm1kZXYsIGluZGV4LCB0cnVlKTsKPiArCj4gKwlpZiAodnBfZGV2LT5wZXJf
dnFfdmVjdG9ycyAmJiBpbmZvLT5tc2l4X3ZlY3RvciAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikK
PiArCQllbmFibGVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaW5mby0+bXNp
eF92ZWN0b3IpKTsKCgpXZSBoYWQgdGhlIHNhbWUgaXNzdWUgYXMgZGlzYWJsZV9pcnEoKS4KClRo
YW5rcwoKCj4gKwo+ICsJdnEtPnJlc2V0ID0gZmFsc2U7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30K
PiArCj4gICBzdGF0aWMgdTE2IHZwX2NvbmZpZ192ZWN0b3Ioc3RydWN0IHZpcnRpb19wY2lfZGV2
aWNlICp2cF9kZXYsIHUxNiB2ZWN0b3IpCj4gICB7Cj4gICAJcmV0dXJuIHZwX21vZGVybl9jb25m
aWdfdmVjdG9yKCZ2cF9kZXYtPm1kZXYsIHZlY3Rvcik7Cj4gQEAgLTQwNyw2ICs0ODcsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRpb19wY2lfY29uZmlnX25v
ZGV2X29wcyA9IHsKPiAgIAkuc2V0X3ZxX2FmZmluaXR5ID0gdnBfc2V0X3ZxX2FmZmluaXR5LAo+
ICAgCS5nZXRfdnFfYWZmaW5pdHkgPSB2cF9nZXRfdnFfYWZmaW5pdHksCj4gICAJLmdldF9zaG1f
cmVnaW9uICA9IHZwX2dldF9zaG1fcmVnaW9uLAo+ICsJLnJlc2V0X3ZxCSA9IHZwX21vZGVybl9y
ZXNldF92cSwKPiArCS5lbmFibGVfcmVzZXRfdnEgPSB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0X3Zx
LAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2
aXJ0aW9fcGNpX2NvbmZpZ19vcHMgPSB7Cj4gQEAgLTQyNSw2ICs1MDcsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRpb19wY2lfY29uZmlnX29wcyA9IHsKPiAg
IAkuc2V0X3ZxX2FmZmluaXR5ID0gdnBfc2V0X3ZxX2FmZmluaXR5LAo+ICAgCS5nZXRfdnFfYWZm
aW5pdHkgPSB2cF9nZXRfdnFfYWZmaW5pdHksCj4gICAJLmdldF9zaG1fcmVnaW9uICA9IHZwX2dl
dF9zaG1fcmVnaW9uLAo+ICsJLnJlc2V0X3ZxCSA9IHZwX21vZGVybl9yZXNldF92cSwKPiArCS5l
bmFibGVfcmVzZXRfdnEgPSB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0X3ZxLAo+ICAgfTsKPiAgIAo+
ICAgLyogdGhlIFBDSSBwcm9iaW5nIGZ1bmN0aW9uICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggNjI1MGUxOWZjNWJmLi45MTkzN2UyMWVkY2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMjAyOCw2ICsyMDI4LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0
ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAgCXZxLT52cS52ZGV2ID0gdmRldjsKPiAgIAl2cS0+dnEu
bmFtZSA9IG5hbWU7Cj4gICAJdnEtPnZxLmluZGV4ID0gaW5kZXg7Cj4gKwl2cS0+dnEucmVzZXQg
PSBmYWxzZTsKPiAgIAl2cS0+bm90aWZ5ID0gbm90aWZ5Owo+ICAgCXZxLT53ZWFrX2JhcnJpZXJz
ID0gd2Vha19iYXJyaWVyczsKPiAgIAo+IEBAIC0yNTA4LDYgKzI1MDksNyBAQCBzdHJ1Y3Qgdmly
dHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCXZx
LT52cS52ZGV2ID0gdmRldjsKPiAgIAl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gICAJdnEtPnZxLmlu
ZGV4ID0gaW5kZXg7Cj4gKwl2cS0+dnEucmVzZXQgPSBmYWxzZTsKPiAgIAl2cS0+bm90aWZ5ID0g
bm90aWZ5Owo+ICAgCXZxLT53ZWFrX2JhcnJpZXJzID0gd2Vha19iYXJyaWVyczsKPiAgIAo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+IGluZGV4IGM4NmZmMDJlMGNhMC4uMzNhYjAwM2M1MTAwIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdmlydGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTMz
LDYgKzMzLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSB7Cj4gICAJdW5zaWduZWQgaW50IG51bV9mcmVl
Owo+ICAgCXVuc2lnbmVkIGludCBudW1fbWF4Owo+ICAgCXZvaWQgKnByaXY7Cj4gKwlib29sIHJl
c2V0Owo+ICAgfTsKPiAgIAo+ICAgaW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0cnVjdCB2aXJ0
cXVldWUgKnZxLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
