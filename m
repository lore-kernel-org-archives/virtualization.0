Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98641C43217
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 05:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4108460E4B;
	Tue, 12 Apr 2022 05:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWmMnlvWmp3i; Tue, 12 Apr 2022 05:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E80B360F21;
	Tue, 12 Apr 2022 05:50:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B61C0033;
	Tue, 12 Apr 2022 05:50:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83FD4C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 592C2410C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pwbyQRqLEp-B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:49:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 197384091F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649742597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nfLWnPBAuMlm5r+UmbtTzmJcwM0c6Blxn5Idke/QAM=;
 b=BesQG/+zMgYVGv6tJ22Ckx2QQMhcq4cgFcWwTaJpri6mxw64qbfpX0oPPAg56c6goL2jaA
 t+qiP66hTnqGKZw98dw0HxdcNbKDeg0gnshz7YxDdwoK86moHHKUGQbsicbIF8I/Ni32hi
 7SSIigz7aGR3cDcpo/6zVGRCW37oVGw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-wsgLdhciO9mJ3hx9Fz_S-Q-1; Tue, 12 Apr 2022 01:49:56 -0400
X-MC-Unique: wsgLdhciO9mJ3hx9Fz_S-Q-1
Received: by mail-pl1-f198.google.com with SMTP id
 u8-20020a170903124800b0015195a5826cso7302184plh.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 22:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+nfLWnPBAuMlm5r+UmbtTzmJcwM0c6Blxn5Idke/QAM=;
 b=jlWu8dlrrSV++qg33tjsM+t8Tv+EjQrtu5ACZfQRVbaRzHVKhhrmtvqyRH0vbWctYx
 +6I7LIik76p0wyk+iK5fd6WZFAmc5HT9Ac9HmAvVDVLJAB+jWYEcpQHqDIZrurwMXLaU
 6WOZpW4O6J4j/3dXC5rV8G1V9avWFCF+A4g2ti2AoMFARQmrHQzjEB3o1KfHV07r1BR6
 UGrq2OTBAYTgF3EAltcHBeim57+wHtdSj9N7Ux2dR4aDXtSGfJV8x0Tw5a8NW/eecYJZ
 Qa44bVGv4QRWW7jgeRe5Z8F7J4KVwpP7Yy8SB1y3K0HAxpq/lB6MyvsKv+nlpcmqFOnU
 l6og==
X-Gm-Message-State: AOAM531zxbLnkyUWSIzRL4SejOevH6zYFXPvFFD3bhcWzk1d6nVfLOo0
 onxcbHG6HwjfWX7umlrfodlvwyxef3jgadJRbR/Rn4PltKmi8/9GcFUl9+IXRjk+ghYkUiUOavO
 iUEwpuCAzW/OTelFxb2J9KpU6HtTYVEOMQRqs525LLg==
X-Received: by 2002:a17:90a:2b0f:b0:1cb:a3e5:413b with SMTP id
 x15-20020a17090a2b0f00b001cba3e5413bmr3111689pjc.115.1649742595587; 
 Mon, 11 Apr 2022 22:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5M7w4regKv/6lTzZiCGXRv4gWijfltQwpzvyUhGLz6udlOo2qWGkxbBotpTg1IaFMoqyGeg==
X-Received: by 2002:a17:90a:2b0f:b0:1cb:a3e5:413b with SMTP id
 x15-20020a17090a2b0f00b001cba3e5413bmr3111650pjc.115.1649742595355; 
 Mon, 11 Apr 2022 22:49:55 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 3-20020a17090a034300b001c779e82af6sm1265782pjf.48.2022.04.11.22.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 22:49:54 -0700 (PDT)
Message-ID: <14ab2942-2141-cb1b-14be-35da1c9ee03d@redhat.com>
Date: Tue, 12 Apr 2022 13:49:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 10/32] virtio_ring: split: introduce
 virtqueue_reinit_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
YSBmdW5jdGlvbiB0byBpbml0aWFsaXplIHZxIHdpdGhvdXQgYWxsb2NhdGluZyBuZXcgcmluZywK
PiBkZXNjX3N0YXRlLCBkZXNjX2V4dHJhLgo+Cj4gU3Vic2VxdWVudCBwYXRjaGVzIHdpbGwgY2Fs
bCB0aGlzIGZ1bmN0aW9uIGFmdGVyIHJlc2V0IHZxIHRvCj4gcmVpbml0aWFsaXplIHZxLgo+Cj4g
U2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRl
eCA4NzRmODc4MDg3YTMuLjNkYzZhY2UyYmE3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBA
IC05NTMsNiArOTUzLDI1IEBAIHN0YXRpYyB2b2lkIHZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0
KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgCXZxLT5mcmVlX2hlYWQgPSAwOwo+ICAg
fQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdnEt
PnZxLnZkZXY7Cj4gKwlpbnQgc2l6ZSwgaTsKPiArCj4gKwltZW1zZXQodnEtPnNwbGl0LnZyaW5n
LmRlc2MsIDAsIHZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzKTsKPiArCj4gKwlzaXplID0g
c2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSAqIHZxLT5zcGxpdC52cmluZy5u
dW07Cj4gKwltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHNpemUpOwo+ICsKPiArCXNp
emUgPSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEpICogdnEtPnNwbGl0LnZyaW5nLm51
bTsKPiArCW1lbXNldCh2cS0+c3BsaXQuZGVzY19leHRyYSwgMCwgc2l6ZSk7Cj4gKwo+ICsJZm9y
IChpID0gMDsgaSA8IHZxLT5zcGxpdC52cmluZy5udW0gLSAxOyBpKyspCj4gKwkJdnEtPnNwbGl0
LmRlc2NfZXh0cmFbaV0ubmV4dCA9IGkgKyAxOwo+ICsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9pbml0
X3NwbGl0KHZxLCB2ZGV2LCB0cnVlKTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHZyaW5nX3Zp
cnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAJCQkJ
CSBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gICAJCQkJCSBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9z
cGxpdCAqZGVzY19zdGF0ZSwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
