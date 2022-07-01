Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE3BC43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71FDC416BE;
	Fri,  1 Jul 2022 09:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71FDC416BE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RDjsMza4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjFDxBoENUiI; Fri,  1 Jul 2022 09:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DAEA841697;
	Fri,  1 Jul 2022 09:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAEA841697
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF43DC0032;
	Fri,  1 Jul 2022 09:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9233C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADD4541694
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADD4541694
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l0uV53SB9Zxq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:00:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A46B34161C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A46B34161C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656666015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lQ6iUMnyQRqa4PGLu8+SgKnRgrhBYKLGeVI6yaxhUA=;
 b=RDjsMza4BbaVYNboiC8jjABNXleTsbHxCQr2QdOKtJy78s6cPyS5JCNi61Nb3jkL6RxDRj
 DJStoUkbw+YyefyrytWoDNRmEbiImHv4uM6+cvu5JRbMKJrtPZI2aGCDtZkaBQE2GiIS2n
 jsBeHTPOPTy6Mb3OjI1kTmnv7jp5E4I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-M24rARsYP4eGhdCrtZDRNg-1; Fri, 01 Jul 2022 05:00:14 -0400
X-MC-Unique: M24rARsYP4eGhdCrtZDRNg-1
Received: by mail-pj1-f71.google.com with SMTP id
 q9-20020a17090a68c900b001ec8111ea56so1131638pjj.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8lQ6iUMnyQRqa4PGLu8+SgKnRgrhBYKLGeVI6yaxhUA=;
 b=keIW1N/u4bYjUISsbjjGxzfhefY/KPVFG1k46fmuN5aMD2U7QQSDltzQYUF+E6d8wG
 mb+fMvHXNsBO3Tir2ZHmt8NI4DyU+UwTLbvVBLE4ckubaf3Xy3eaP5ruV3ujXkhXcpfC
 PlZ2eJBmGv84taRC+eqjbZWrsPrh9s2oOzJzO+I0mPP9IPXu6PzF6dV0J/T66FbeRAPu
 EENWtT3RwbvbX5llMsViWdjw0MrZRyda4g/phBJAuuys0EZrrlLH36f8zXNBZ1CEQjld
 OEeCLOtp6xIDGqJ58a5Ln8jr4dluTlLyaqTrzLuLPiLK4bMXrHsjNlfcz3eq09FRjKit
 GghA==
X-Gm-Message-State: AJIora+CBXJd9Xc/3u6RP8JhoeV7M9Rh+2Py7bV/5Gz5TwlfSV4H1rWa
 KhNNEs9LTieV9pDzhGstJ0Ti+GXNbNrAb8SmZZeOJnbHJ3JFKaIfviYws/T120QD+/OakeeSLxd
 wpfsd9lbXZZcfKAXYZ0cnreJiE2sjcvfzgXyngM0nXA==
X-Received: by 2002:a63:f102:0:b0:40d:1d1f:770c with SMTP id
 f2-20020a63f102000000b0040d1d1f770cmr11192913pgi.521.1656666013406; 
 Fri, 01 Jul 2022 02:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urKvm6LYkWKw16uIXqxBex7xUdVqhH17lRqnYeTgkb25NL8EQ+hO2PmoLH55tznJBr8D0cFQ==
X-Received: by 2002:a63:f102:0:b0:40d:1d1f:770c with SMTP id
 f2-20020a63f102000000b0040d1d1f770cmr11192864pgi.521.1656666013152; 
 Fri, 01 Jul 2022 02:00:13 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090322c300b001618b70dcc9sm15332754plg.101.2022.07.01.02.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:00:12 -0700 (PDT)
Message-ID: <e24fec52-72a4-caaf-e31f-0adc5a6593d7@redhat.com>
Date: Fri, 1 Jul 2022 17:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 10/40] virtio_ring: split: extract the logic of attach
 vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-11-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGF0dGFjaCB2cmluZywgc3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgY2FsbCBpdAo+IHNl
cGFyYXRlbHkuCj4KPiBTaW5jZSB0aGUgInN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgc3Bs
aXQiIGlzIGNyZWF0ZWQgb24gdGhlCj4gc3RhY2sgYW5kIGhhcyBiZWVuIGluaXRpYWxpemVkIHRv
IDAuIFNvIHVzaW5nCj4gc3BsaXQtPnF1ZXVlX2RtYV9hZGRyL3NwbGl0LT5xdWV1ZV9zaXplX2lu
X2J5dGVzIGFzc2lnbm1lbnQgZm9yCj4gcXVldWVfZG1hX2FkZHIvcXVldWVfc2l6ZV9pbl9ieXRl
cyBjYW4ga2VlcCB0aGUgc2FtZSBhcyB0aGUgb3JpZ2luYWwKPiBjb2RlLgo+Cj4gT24gdGhlIG90
aGVyIGhhbmQsIHN1YnNlcXVlbnQgcGF0Y2hlcyBjYW4gdXNlIHRoZSAic3RydWN0Cj4gdnJpbmdf
dmlydHF1ZXVlX3NwbGl0IHNwbGl0IiBvYnRhaW5lZCBieSB2cmluZ19hbGxvY19xdWV1ZV9zcGxp
dCgpIHRvCj4gZGlyZWN0bHkgY29tcGxldGUgdGhlIGF0dGFjaCBvcGVyYXRpb24uCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjAgKysrKysrKysrKysrKy0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gaW5kZXggY2VkZDM0MGQ2ZGI3Li45MDI1YmQzNzNkM2IgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiBAQCAtOTQwLDYgKzk0MCwxOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2Rl
dGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4g
TlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3Nw
bGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlX3NwbGl0ICp2cmluZykKPiArewo+ICsJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0g
dnJpbmctPnF1ZXVlX2RtYV9hZGRyOwo+ICsJdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMg
PSB2cmluZy0+cXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCj4gKwl2cS0+c3BsaXQudnJpbmcgPSB2
cmluZy0+dnJpbmc7Cj4gKwo+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSB2cmluZy0+ZGVzY19z
dGF0ZTsKPiArCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmctPmRlc2NfZXh0cmE7Cj4gK30K
PiArCj4gICBzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHN0cnVjdCB2
cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ19kZXNj
X3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiBAQCAtMjI4NywxMCArMjI5OSw2IEBAIHN0cnVjdCB2aXJ0
cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdnEt
PmluZGlyZWN0ID0gdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJF
Q1RfREVTQykgJiYKPiAgIAkJIWNvbnRleHQ7Cj4gICAKPiAtCXZxLT5zcGxpdC5xdWV1ZV9kbWFf
YWRkciA9IDA7Cj4gLQl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IDA7Cj4gLQo+IC0J
dnEtPnNwbGl0LnZyaW5nID0gX3ZyaW5nOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFk
b3cgPSAwOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiAgIAo+IEBAIC0y
MzEwLDEwICsyMzE4LDggQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVl
KHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAJfQo+ICAgCj4gLQl2
cS0+c3BsaXQuZGVzY19zdGF0ZSA9IHZyaW5nLmRlc2Nfc3RhdGU7Cj4gLQl2cS0+c3BsaXQuZGVz
Y19leHRyYSA9IHZyaW5nLmRlc2NfZXh0cmE7Cj4gLQo+ICAgCXZpcnRxdWV1ZV9pbml0KHZxLCB2
cmluZy52cmluZy5udW0pOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwgJnZy
aW5nKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlz
dF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
