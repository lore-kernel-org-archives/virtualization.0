Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA31C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B793840222;
	Wed, 27 Jul 2022 04:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B793840222
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UAHhSVmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7K8F7oLqrnYO; Wed, 27 Jul 2022 04:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB2F7401CC;
	Wed, 27 Jul 2022 04:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB2F7401CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59610C0035;
	Wed, 27 Jul 2022 04:33:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A843C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5A8F81934
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5A8F81934
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UAHhSVmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id npnn6w4qBjrV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19DDE81919
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19DDE81919
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODRM0zSUIZaPgOR8/bpOMiGz6jK2MmkN3FU9v6SxAsc=;
 b=UAHhSVmbm5DEDJwXxjd1zb9VKiDGj6aRx22JmBVuSELug5OEpO7hPjCs3pzJLuyjEd5aMz
 6EKt+996bgl3IdCWNqDqzu40YyRcRlrY/98MgSaHhn7MIjzIa8bbkNqXOfgi3vCG8JWKOz
 rzomqxaD3p5jgc3TTPhtuharuE7SCZI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-V98VHBRbNTOz0JKc8xWxbA-1; Wed, 27 Jul 2022 00:33:18 -0400
X-MC-Unique: V98VHBRbNTOz0JKc8xWxbA-1
Received: by mail-pg1-f200.google.com with SMTP id
 z18-20020a63d012000000b0041b3478e9a9so1297873pgf.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ODRM0zSUIZaPgOR8/bpOMiGz6jK2MmkN3FU9v6SxAsc=;
 b=wLIoT0L9tDAxOPX/QHr9f9r0axk0tQxAoVlPLTvDSvMj88vHcdlOVXUImczOD/Q6UB
 4TZJjvhd44INh7y2o9qJ+j3yUt2GvBjRnCVyL0uYfPQsFKkwUGWHws+LblNOrqlu5w7+
 t2KoKNaeVd1xn1+4RH1fELOaRUaRs7pv4Ls682YkRhpc6jMuH88ZDQHKGbU7lJDLcqOp
 xAHxqOg/Xs/cWxq06Xin4kzoBTkT4ZpYC2+uisKv4uxBSaPB4IscOvSGMMyKJ62vhwhB
 tytKaHElGytaEyP6JzUEKegF5vOBUTZvbhxolnwDWGkfpnq6Ri3CC1qxXeB5AmyxOkVm
 khqw==
X-Gm-Message-State: AJIora9y77rbxWh5wCkoGpjz5ZESvzNkVBhI+zxjxno6gyB0BEo6WIlD
 ZyzJmFnCUSmoIwrHWWfaJ97tn8WfeAQDTepNYEk2PbbpYNMpHa7n0c6s3LZ7UMGYfEbmEjA+WOK
 0tvQ7VkAsGqYWLs29XoVxvwqzQuQLIpvPJAT2NNpgNg==
X-Received: by 2002:a63:20e:0:b0:41a:f82c:daef with SMTP id
 14-20020a63020e000000b0041af82cdaefmr10287811pgc.165.1658896397830; 
 Tue, 26 Jul 2022 21:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tIGltlGmjqdvnQ8FUe2CBzMPphXcR7MEQHTWNTxKvA35C4DAmnE0tnwBMKdB4Yu1yuPE5jjw==
X-Received: by 2002:a63:20e:0:b0:41a:f82c:daef with SMTP id
 14-20020a63020e000000b0041af82cdaefmr10287789pgc.165.1658896397576; 
 Tue, 26 Jul 2022 21:33:17 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w184-20020a6230c1000000b0052b84ca900csm12590905pfw.62.2022.07.26.21.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:33:16 -0700 (PDT)
Message-ID: <d290e282-1a9d-b339-73e6-c66740f00b89@redhat.com>
Date: Wed, 27 Jul 2022 12:33:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 19/42] virtio_ring: packed: extract the logic of alloc
 state and extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-20-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-20-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIGZvciBhbGxvYyBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhLCB3aGljaCB3aWxsCj4gYmUg
Y2FsbGVkIHNlcGFyYXRlbHkgYnkgc3Vic2VxdWVudCBwYXRjaGVzLgo+Cj4gVXNlIHN0cnVjdCB2
cmluZ19wYWNrZWQgdG8gcGFzcyBkZXNjX3N0YXRlLCBkZXNjX2V4dHJhLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMTBjYzJiN2UzNTg4Li4zMjU5MGQ3NjNjM2IgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTkwOCw2ICsxOTA4LDMzIEBAIHN0YXRpYyBpbnQg
dnJpbmdfYWxsb2NfcXVldWVfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICp2
cmluZ19wYWNrZWQsCj4gICAJcmV0dXJuIC1FTk9NRU07Cj4gICB9Cj4gICAKPiArc3RhdGljIGlu
dCB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9w
YWNrZWQgKnZyaW5nX3BhY2tlZCkKPiArewo+ICsJc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFj
a2VkICpzdGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiArCXUzMiBu
dW0gPSB2cmluZ19wYWNrZWQtPnZyaW5nLm51bTsKPiArCj4gKwlzdGF0ZSA9IGttYWxsb2NfYXJy
YXkobnVtLCBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkKSwgR0ZQX0tFUk5F
TCk7Cj4gKwlpZiAoIXN0YXRlKQo+ICsJCWdvdG8gZXJyX2Rlc2Nfc3RhdGU7Cj4gKwo+ICsJbWVt
c2V0KHN0YXRlLCAwLCBudW0gKiBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2Vk
KSk7Cj4gKwo+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKG51bSk7Cj4gKwlpZiAo
IWV4dHJhKQo+ICsJCWdvdG8gZXJyX2Rlc2NfZXh0cmE7Cj4gKwo+ICsJdnJpbmdfcGFja2VkLT5k
ZXNjX3N0YXRlID0gc3RhdGU7Cj4gKwl2cmluZ19wYWNrZWQtPmRlc2NfZXh0cmEgPSBleHRyYTsK
PiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9kZXNjX2V4dHJhOgo+ICsJa2ZyZWUoc3RhdGUp
Owo+ICtlcnJfZGVzY19zdGF0ZToKPiArCXJldHVybiAtRU5PTUVNOwo+ICt9Cj4gKwo+ICAgc3Rh
dGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAg
CXVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0xOTIyLDYg
KzE5NDksNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1
ZV9wYWNrZWQoCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9wYWNrZWQgdnJpbmdf
cGFja2VkID0ge307Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gKwlpbnQgZXJy
Owo+ICAgCj4gICAJaWYgKHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tlZCgmdnJpbmdfcGFja2VkLCB2
ZGV2LCBudW0pKQo+ICAgCQlnb3RvIGVycl9yaW5nOwo+IEBAIC0xOTYxLDE4ICsxOTg5LDEyIEBA
IHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgK
PiAgIAl2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9IDA7Cj4gICAJdnEtPnBhY2tlZC5h
dmFpbF91c2VkX2ZsYWdzID0gMSA8PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMOwo+ICAgCj4g
LQl2cS0+cGFja2VkLmRlc2Nfc3RhdGUgPSBrbWFsbG9jX2FycmF5KG51bSwKPiAtCQkJc2l6ZW9m
KHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3BhY2tlZCksCj4gLQkJCUdGUF9LRVJORUwpOwo+IC0J
aWYgKCF2cS0+cGFja2VkLmRlc2Nfc3RhdGUpCj4gLQkJZ290byBlcnJfZGVzY19zdGF0ZTsKPiAt
Cj4gLQltZW1zZXQodnEtPnBhY2tlZC5kZXNjX3N0YXRlLCAwLAo+IC0JCW51bSAqIHNpemVvZihz
dHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9wYWNrZWQpKTsKPiArCWVyciA9IHZyaW5nX2FsbG9jX3N0
YXRlX2V4dHJhX3BhY2tlZCgmdnJpbmdfcGFja2VkKTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBl
cnJfc3RhdGVfZXh0cmE7Cj4gICAKPiAtCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9IHZyaW5nX2Fs
bG9jX2Rlc2NfZXh0cmEobnVtKTsKPiAtCWlmICghdnEtPnBhY2tlZC5kZXNjX2V4dHJhKQo+IC0J
CWdvdG8gZXJyX2Rlc2NfZXh0cmE7Cj4gKwl2cS0+cGFja2VkLmRlc2Nfc3RhdGUgPSB2cmluZ19w
YWNrZWQuZGVzY19zdGF0ZTsKPiArCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9IHZyaW5nX3BhY2tl
ZC5kZXNjX2V4dHJhOwo+ICAgCj4gICAJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90aGVyIHNpZGUg
bm90IHRvIGJvdGhlciB1cy4gKi8KPiAgIAlpZiAoIWNhbGxiYWNrKSB7Cj4gQEAgLTE5ODgsOSAr
MjAxMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVl
X3BhY2tlZCgKPiAgIAlzcGluX3VubG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJcmV0
dXJuICZ2cS0+dnE7Cj4gICAKPiAtZXJyX2Rlc2NfZXh0cmE6Cj4gLQlrZnJlZSh2cS0+cGFja2Vk
LmRlc2Nfc3RhdGUpOwo+IC1lcnJfZGVzY19zdGF0ZToKPiArZXJyX3N0YXRlX2V4dHJhOgo+ICAg
CWtmcmVlKHZxKTsKPiAgIGVycl92cToKPiAgIAl2cmluZ19mcmVlX3BhY2tlZCgmdnJpbmdfcGFj
a2VkLCB2ZGV2KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
