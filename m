Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F72EC00144
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 03:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5D23818BE;
	Wed, 27 Jul 2022 03:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5D23818BE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Da7f4qex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNLEwO3a9ZHf; Wed, 27 Jul 2022 03:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E219B81656;
	Wed, 27 Jul 2022 03:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E219B81656
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC77C0033;
	Wed, 27 Jul 2022 03:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23C54C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE93240327
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:05:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE93240327
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Da7f4qex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-19WAFRMZnM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:05:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8CF04011C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8CF04011C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658891134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPVjRi2laBOhHF0iGlxYnBot8C54I4jUPdsnzaNkbSA=;
 b=Da7f4qexCiQbEu3XtOyZIgJWch+L0j3jztCeKKHvtRE5eoViYZY59srBFJrrbKGvG+liQr
 ExJXpeOjsE4UBuhGviWBRfhzHy7jRGZey1AK2/D6IU+LSTXzD7fup8X2oampWHbwFyTzGO
 OOiSfS8x1MCTc//GbWzEtvB4oWVDYSA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-7ucFj6A1PH6SJdvnWm1ieQ-1; Tue, 26 Jul 2022 23:05:30 -0400
X-MC-Unique: 7ucFj6A1PH6SJdvnWm1ieQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 f13-20020a056a001acd00b0052ab9ae76fbso5453708pfv.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JPVjRi2laBOhHF0iGlxYnBot8C54I4jUPdsnzaNkbSA=;
 b=GL27atslhDmAeRHzDn6MeLn11D8Wh1uDKfc02+bF2MxwiOrXAqxow4eubjyMlJUY53
 rVPXUtz5sA1+uzMUUBxRDpFOKOF870TW6UuKOcv3COf51kdEU20kDzS4tfFcOS7X70SP
 lvVGe5LnV40Xjilx1OI9syHTnKR3+PUQ17OdNBmJ5MyDrFC0rBD5oBeipzrFRC2MFu0z
 wIV+LupA0tvRuAgyjbVEdyJ+uw8f5grzW0apnuFMbzm5yGXK8KPTMqJB1275uOUGpFG9
 1AkH5btH1Qm5JFmhV0f6fW0PnKNjDchnqCKPq6nZWdMzsoTclSpJT+M9tJxLZlj5mdvO
 hnSg==
X-Gm-Message-State: AJIora+fh8vkzpjpZUYsrOJ081vdU4Z21Syh/bYx0c/8Nd0ga0LuUuOf
 KKkNC/Xf6WkiOoe2vEfRjJMYFoLE16r/v/XyCISUjm44s50bqY//W8+b2FofbPDS+B3ggULSIJa
 pWxxK48CkhDpD376Tbyy88d/yD1NbbFc4zZVtMlPzCQ==
X-Received: by 2002:a63:8b43:0:b0:41a:668b:399a with SMTP id
 j64-20020a638b43000000b0041a668b399amr16859312pge.554.1658891129598; 
 Tue, 26 Jul 2022 20:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uvlNVzsM47OO+owdTKGvivmzfNPlB+iaGP4TESyvpuwSsv3a453beLdZ4leUSPBNJBaopldw==
X-Received: by 2002:a63:8b43:0:b0:41a:668b:399a with SMTP id
 j64-20020a638b43000000b0041a668b399amr16859261pge.554.1658891129209; 
 Tue, 26 Jul 2022 20:05:29 -0700 (PDT)
Received: from [10.72.13.38] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 cp17-20020a170902e79100b0016c0c82e85csm12215069plb.75.2022.07.26.20.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 20:05:28 -0700 (PDT)
Message-ID: <0aa1a062-968b-370a-3a50-e0364914a7c4@redhat.com>
Date: Wed, 27 Jul 2022 11:05:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 08/42] virtio_ring: split: __vring_new_virtqueue()
 accept struct vring_virtqueue_split
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gX192cmluZ19uZXdfdmly
dHF1ZXVlKCkgaW5zdGVhZCBhY2NlcHRzIHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQuCj4K
PiBUaGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvIHBhc3MgbW9yZSBpbmZvcm1hdGlvbiBpbnRvCj4g
X192cmluZ19uZXdfdmlydHF1ZXVlKCkgdG8gbWFrZSB0aGUgY29kZSBzaW1wbGVyIGFuZCB0aGUg
c3RydWN0dXJlCj4gY2xlYW5lci4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyOSAr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNGU1
NGVkN2VlN2ZiLi40ZDY1YzQzN2Q5NjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjA1
LDcgKzIwNSw3IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgfTsKPiAgIAo+ICAgc3Rh
dGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQg
aW5kZXgsCj4gLQkJCQkJICAgICAgIHN0cnVjdCB2cmluZyB2cmluZywKPiArCQkJCQkgICAgICAg
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmdfc3BsaXQsCj4gICAJCQkJCSAgICAg
ICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAgIAkJCQkJICAgICAgIGJvb2wgd2Vha19i
YXJyaWVycywKPiAgIAkJCQkJICAgICAgIGJvb2wgY29udGV4dCwKPiBAQCAtOTU5LDYgKzk1OSw3
IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0
KAo+ICAgCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAgIAljb25zdCBj
aGFyICpuYW1lKQo+ICAgewo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19z
cGxpdCA9IHt9Owo+ICAgCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ICAgCXZvaWQgKnF1ZXVlID0g
TlVMTDsKPiAgIAlkbWFfYWRkcl90IGRtYV9hZGRyOwo+IEBAIC05OTQsMTAgKzk5NSwxMCBAQCBz
dGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAg
IAkJcmV0dXJuIE5VTEw7Cj4gICAKPiAgIAlxdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6
ZShudW0sIHZyaW5nX2FsaWduKTsKPiAtCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1ZXVlLCB2
cmluZ19hbGlnbik7Cj4gKwl2cmluZ19pbml0KCZ2cmluZ19zcGxpdC52cmluZywgbnVtLCBxdWV1
ZSwgdnJpbmdfYWxpZ24pOwo+ICAgCj4gLQl2cSA9IF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRl
eCwgdnJpbmcsIHZkZXYsIHdlYWtfYmFycmllcnMsIGNvbnRleHQsCj4gLQkJCQkgICBub3RpZnks
IGNhbGxiYWNrLCBuYW1lKTsKPiArCXZxID0gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCAm
dnJpbmdfc3BsaXQsIHZkZXYsIHdlYWtfYmFycmllcnMsCj4gKwkJCQkgICBjb250ZXh0LCBub3Rp
ZnksIGNhbGxiYWNrLCBuYW1lKTsKPiAgIAlpZiAoIXZxKSB7Cj4gICAJCXZyaW5nX2ZyZWVfcXVl
dWUodmRldiwgcXVldWVfc2l6ZV9pbl9ieXRlcywgcXVldWUsCj4gICAJCQkJIGRtYV9hZGRyKTsK
PiBAQCAtMjIwNiw3ICsyMjA3LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfaW50ZXJydXB0
KTsKPiAgIAo+ICAgLyogT25seSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiAgIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGlu
ZGV4LAo+IC0JCQkJCSAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gKwkJCQkJICAgICAgIHN0
cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nX3NwbGl0LAo+ICAgCQkJCQkgICAgICAg
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gICAJCQkJCSAgICAgICBib29sIHdlYWtfYmFy
cmllcnMsCj4gICAJCQkJCSAgICAgICBib29sIGNvbnRleHQsCj4gQEAgLTIyNDMsNyArMjI0NCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWdu
ZWQgaW50IGluZGV4LAo+ICAgCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IDA7Cj4gICAJdnEt
PnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSAwOwo+ICAgCj4gLQl2cS0+c3BsaXQudnJpbmcg
PSB2cmluZzsKPiArCXZxLT5zcGxpdC52cmluZyA9IHZyaW5nX3NwbGl0LT52cmluZzsKPiAgIAl2
cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiAgIAl2cS0+c3BsaXQuYXZhaWxfaWR4
X3NoYWRvdyA9IDA7Cj4gICAKPiBAQCAtMjI1NSwxOSArMjI1NiwxOSBAQCBzdGF0aWMgc3RydWN0
IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAg
IAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gICAJfQo+ICAgCj4gLQl2cS0+
c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2NfYXJyYXkodnJpbmcubnVtLAo+ICsJdnEtPnNwbGl0
LmRlc2Nfc3RhdGUgPSBrbWFsbG9jX2FycmF5KHZyaW5nX3NwbGl0LT52cmluZy5udW0sCj4gICAJ
CQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpLCBHRlBfS0VSTkVMKTsKPiAg
IAlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+ICAgCQlnb3RvIGVycl9zdGF0ZTsKPiAgIAo+
IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKHZyaW5nLm51
bSk7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodnJp
bmdfc3BsaXQtPnZyaW5nLm51bSk7Cj4gICAJaWYgKCF2cS0+c3BsaXQuZGVzY19leHRyYSkKPiAg
IAkJZ290byBlcnJfZXh0cmE7Cj4gICAKPiAtCW1lbXNldCh2cS0+c3BsaXQuZGVzY19zdGF0ZSwg
MCwgdnJpbmcubnVtICoKPiArCW1lbXNldCh2cS0+c3BsaXQuZGVzY19zdGF0ZSwgMCwgdnJpbmdf
c3BsaXQtPnZyaW5nLm51bSAqCj4gICAJCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVf
c3BsaXQpKTsKPiAgIAo+IC0JdmlydHF1ZXVlX2luaXQodnEsIHZxLT5zcGxpdC52cmluZy5udW0p
Owo+ICsJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LT52cmluZy5udW0pOwo+ICAgCj4g
ICAJc3Bpbl9sb2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiAgIAlsaXN0X2FkZF90YWlsKCZ2
cS0+dnEubGlzdCwgJnZkZXYtPnZxcyk7Cj4gQEAgLTIzMTcsMTQgKzIzMTgsMTQgQEAgc3RydWN0
IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJ
CQkJICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSksCj4gICAJCQkJ
ICAgICAgY29uc3QgY2hhciAqbmFtZSkKPiAgIHsKPiAtCXN0cnVjdCB2cmluZyB2cmluZzsKPiAr
CXN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgdnJpbmdfc3BsaXQgPSB7fTsKPiAgIAo+ICAg
CWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+ICAg
CQlyZXR1cm4gTlVMTDsKPiAgIAo+IC0JdnJpbmdfaW5pdCgmdnJpbmcsIG51bSwgcGFnZXMsIHZy
aW5nX2FsaWduKTsKPiAtCXJldHVybiBfX3ZyaW5nX25ld192aXJ0cXVldWUoaW5kZXgsIHZyaW5n
LCB2ZGV2LCB3ZWFrX2JhcnJpZXJzLCBjb250ZXh0LAo+IC0JCQkJICAgICBub3RpZnksIGNhbGxi
YWNrLCBuYW1lKTsKPiArCXZyaW5nX2luaXQoJnZyaW5nX3NwbGl0LnZyaW5nLCBudW0sIHBhZ2Vz
LCB2cmluZ19hbGlnbik7Cj4gKwlyZXR1cm4gX192cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCAm
dnJpbmdfc3BsaXQsIHZkZXYsIHdlYWtfYmFycmllcnMsCj4gKwkJCQkgICAgIGNvbnRleHQsIG5v
dGlmeSwgY2FsbGJhY2ssIG5hbWUpOwo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdf
bmV3X3ZpcnRxdWV1ZSk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
