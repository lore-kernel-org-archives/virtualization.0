Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F30DC19F2D
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 03:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0239E60AA7;
	Wed, 27 Jul 2022 03:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0239E60AA7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fqwa/KHl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEWmagT0sgrr; Wed, 27 Jul 2022 03:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F21E60A94;
	Wed, 27 Jul 2022 03:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F21E60A94
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D91CC0033;
	Wed, 27 Jul 2022 03:12:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA06C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4956A60A94
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4956A60A94
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj4WcJFVGRIR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:12:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DB8A605AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DB8A605AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658891554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WiQGdroVpMu2sEzrZ478PJ3v7YHoeLWedG+fQPiT4w=;
 b=fqwa/KHlh9APD2kt5Yakp5jxPN4kePm3V1tLLBRcfF/JrAi2S6DCHU85fUmDDx7SmJLyxQ
 639jbdOoz8SRGLP1hC1TqgVhEeWKga8OBIOeq6VthUHR+QMgomqFAj1ryZvi82zDBTxwsh
 WUktVkeLHAjNl8EWsO7tVHN6Qt5LOLE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-BVX1x9hsOcq1ik7Phhlhaw-1; Tue, 26 Jul 2022 23:12:32 -0400
X-MC-Unique: BVX1x9hsOcq1ik7Phhlhaw-1
Received: by mail-pj1-f69.google.com with SMTP id
 pv18-20020a17090b3c9200b001f2460e8ce1so5566731pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9WiQGdroVpMu2sEzrZ478PJ3v7YHoeLWedG+fQPiT4w=;
 b=snX/PDYOa3PK3gWd2jEgYQirG6c8eXQcV0naZzLgSlWXpvywVwDOBF3EEb4bYB7SeO
 rjho2V9v7aso79JFzUddpgpOKADMsdgl25onwAbCyOIy102JJQPR4x9n4CwX5/vuBJ/Y
 RY9BtYCon4+GcA/X+D6zGvRk2cd9wEMOdHJ8Pk+aY/xy4a5TqxE6LmUgHDiqobvhSoVy
 wNenwsV9My3OMbpGl2TNbiH9cXEL3GSq+v04oMK3NH+0vpUrEcU1V4iWoOgFsaV4RQvy
 umTk0aplMlQ7lfxvm7f/krb2/6tcWfhOT7f2Zgq/X0QoMWevP2ybmDAE/C88wgaQaNBg
 4qxw==
X-Gm-Message-State: AJIora+x2Iq1z1h71Fw77U/HatoPKaW0kLIcwtPNXF0Gubqp+65vu6Yb
 pJP/2hbcn2/KxAWAZo+iQ6xOxAW0suegpWGmnFa+x5iGeTCS/dotsicGwzMv4hI6Uad7FOOiJyU
 pS9tFfPdoUWs04sUaFrJxlmUT1dY2J7orEZ+m30n7rw==
X-Received: by 2002:a17:902:e845:b0:16d:9e9f:457 with SMTP id
 t5-20020a170902e84500b0016d9e9f0457mr5383588plg.40.1658891551774; 
 Tue, 26 Jul 2022 20:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sBLZXzS1O8m+ePPhAyCt6oGj/JXZrm3fBlWjHZx5umFDpHDdxeZHjj9QjfQ98Mbt6FR/NsZA==
X-Received: by 2002:a17:902:e845:b0:16d:9e9f:457 with SMTP id
 t5-20020a170902e84500b0016d9e9f0457mr5383560plg.40.1658891551489; 
 Tue, 26 Jul 2022 20:12:31 -0700 (PDT)
Received: from [10.72.13.38] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a1709028a9600b0016d27cead72sm12189306plo.196.2022.07.26.20.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 20:12:30 -0700 (PDT)
Message-ID: <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
Date: Wed, 27 Jul 2022 11:12:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgc3Bs
aXQgc3VwcG9ydHMgcmVzaXplLgo+Cj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nl
c3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gd2Ugd2lsbCByZWxlYXNl
IHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNlLCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiBpbmRp
Y2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUgb2xkIHZyaW5nLgo+Cj4g
SW4gdGhlIGNhc2Ugb2YgYW4gZXJyb3IsIHJlLWluaXRpYWxpemUodmlydHF1ZXVlX3JlaW5pdF9z
cGxpdCgpKSB0aGUKPiB2aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1
c2VkLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gaW5kZXggYjZmZGE5MWM4MDU5Li41ODM1NWUxYWM3ZDcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjIwLDYgKzIyMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgdmly
dHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCQkJ
CQkgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ICAgCQkJCQkg
ICAgICAgY29uc3QgY2hhciAqbmFtZSk7Cj4gICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0
cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSk7Cj4gK3N0YXRpYyB2
b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiAgIAo+ICAgLyoKPiAgICAq
IEhlbHBlcnMuCj4gQEAgLTExMTcsNiArMTExOCwzOSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1
ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiAgIAlyZXR1cm4gdnE7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIGludCB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwgdTMyIG51bSkKPiArewo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmlu
Z19zcGxpdCA9IHt9Owo+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3Zx
KTsKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+ICsJaW50IGVy
cjsKPiArCj4gKwllcnIgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZk
ZXYsIG51bSwKPiArCQkJCSAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiArCQkJCSAgICAg
IHZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwoK
CkkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBoZXJlPwoKCj4gKwo+ICsJZXJy
ID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQoJnZyaW5nX3NwbGl0KTsKPiArCWlmIChl
cnIpIHsKPiArCQl2cmluZ19mcmVlX3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldik7Cj4gKwkJZ290
byBlcnI7CgoKSSBzdWdnZXN0IHRvIG1vdmUgdnJpbmdfZnJlZV9zcGxpdCgpIGludG8gYSBkZWRp
Y2F0ZWQgZXJyb3IgbGFiZWwuCgpUaGFua3MKCgo+ICsJfQo+ICsKPiArCXZyaW5nX2ZyZWUoJnZx
LT52cSk7Cj4gKwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoJnZyaW5nX3NwbGl0LCB2
cSk7Cj4gKwo+ICsJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LnZyaW5nLm51bSk7Cj4g
Kwl2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ICsKPiAr
CXJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsJdmlydHF1ZXVlX3JlaW5pdF9zcGxpdCh2cSk7Cj4g
KwlyZXR1cm4gLUVOT01FTTsKPiArfQo+ICsKPiAgIAo+ICAgLyoKPiAgICAqIFBhY2tlZCByaW5n
IHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
