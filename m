Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0421C43217
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 03:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F75D60EE2;
	Tue, 12 Apr 2022 03:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id je6k_Qr6wqR2; Tue, 12 Apr 2022 03:42:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1C9560ECD;
	Tue, 12 Apr 2022 03:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89D34C0033;
	Tue, 12 Apr 2022 03:42:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4589C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C179830E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6U1ZOyIxMlg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:42:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D47D68308D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649734964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/OsiNJ9A/eOeLohaa+XnOAzDTM4dK3oraaYOkfTH1I=;
 b=Dew50VFpMTJZvW4Y/77ndZDBMolOMm3zuArHEzmtLF214aWQ8vG9W+TvEs7SqXyh+BFniL
 pYZkmBhtOo7Z4/H6JM1GX/Wgk6k53XHDVjo8QUsNI9MzKK4vB/nj9AIIgNUs1dME8+eFc7
 W4MVmWBjDOqiIPWNSsNxJITbsmCvC9Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-liFRdEToM8WpmzYA3Mzxlg-1; Mon, 11 Apr 2022 23:42:43 -0400
X-MC-Unique: liFRdEToM8WpmzYA3Mzxlg-1
Received: by mail-pj1-f70.google.com with SMTP id
 p14-20020a17090a348e00b001cbc57fedc1so486662pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=e/OsiNJ9A/eOeLohaa+XnOAzDTM4dK3oraaYOkfTH1I=;
 b=sOkNPIGqLhYJW1fpyuOVe1oF+O4LzQxJv4Cp7sUzj8ARuYN0ConBJ+x88VsBB7SvHr
 vBQtwXfDPE9RsHIbn6/VddcjdNYXW+ZvZk0XUJXqHlTt3JMj9ksfLy2EZfrJUKaQ3UO9
 zv6xM4XHdkQ/0O3UO9bA20rcGpyYFUy6ILSq9MXDDLLKZBKsybmtA6C7ML/kXelJdh/t
 uGYJXAWjH8vuAulYkj4ZPadDfjCLi2baqwm5TDn5vThY6rctVco1j8ZLZIzRPG1nxGSF
 G7Q67KScSNyG1/lWjJXX7Kt4drMHKhNHMxXqsr6wEe0mGpS6Ryn6ryqv88I61Sd2u96z
 EGfQ==
X-Gm-Message-State: AOAM532ecCME3c1a/LqgRtKpv5K6yP6l4jIW/rm8RPCN41ZmKdEOZ1iA
 45L1ZSfmSfwAlJxihXoduGWudDCTqgIw/HVgZ7u7irHezAGEbtQbn124fVrNj8Y5JoiTL314taX
 HFPaIV2Sd23BU4AbpI/PZ1mNYcyDEKg5TE5Jo8ildLw==
X-Received: by 2002:a17:902:d641:b0:158:7b09:a597 with SMTP id
 y1-20020a170902d64100b001587b09a597mr1464282plh.38.1649734962160; 
 Mon, 11 Apr 2022 20:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMq3ocoOmI2KUnRkjYaMPOtPHjUJwi0YEpLw+I2/CAUycWFX4s/+dC2J75Q6+K+XriTggTwA==
X-Received: by 2002:a17:902:d641:b0:158:7b09:a597 with SMTP id
 y1-20020a170902d64100b001587b09a597mr1464238plh.38.1649734961868; 
 Mon, 11 Apr 2022 20:42:41 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a63cd4b000000b00378b9167493sm1090853pgj.52.2022.04.11.20.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 20:42:41 -0700 (PDT)
Message-ID: <f91435e4-6559-c0c9-2b37-92084c88dee2@redhat.com>
Date: Tue, 12 Apr 2022 11:42:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 09/32] virtio_ring: split: extract the logic of vq init
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-10-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2YgaW5pdGlhbGl6aW5nIHZxLCBhbmQgc3Vic2VxdWVudCBwYXRjaGVzIHdpbGwg
Y2FsbAo+IGl0IHNlcGFyYXRlbHkuCj4KPiBUaGUgZmVhdHVyZSBvZiB0aGlzIHBhcnQgaXMgdGhh
dCBpdCBkb2VzIG5vdCBkZXBlbmQgb24gdGhlIGluZm9ybWF0aW9uCj4gcGFzc2VkIGJ5IHRoZSB1
cHBlciBsYXllciBhbmQgY2FuIGJlIGNhbGxlZCByZXBlYXRlZGx5Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDA4M2YyOTkyYmEwZC4uODc0Zjg3ODA4
N2EzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTkxNiw2ICs5MTYsNDMgQEAgc3RhdGlj
IHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdnJpbmdf
dmlydHF1ZXVlX2luaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkg
ICAgICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwkJCQkgICAgICAgYm9vbCBvd25f
cmluZykKPiArewo+ICsJdnEtPnBhY2tlZF9yaW5nID0gZmFsc2U7Cj4gKwl2cS0+dnEubnVtX2Zy
ZWUgPSB2cS0+c3BsaXQudnJpbmcubnVtOwo+ICsJdnEtPndlX293bl9yaW5nID0gb3duX3Jpbmc7
Cj4gKwl2cS0+YnJva2VuID0gZmFsc2U7Cj4gKwl2cS0+bGFzdF91c2VkX2lkeCA9IDA7Cj4gKwl2
cS0+ZXZlbnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gKwl2cS0+bnVtX2FkZGVkID0gMDsKPiArCXZx
LT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYpOwo+ICsjaWZkZWYgREVCVUcK
PiArCXZxLT5pbl91c2UgPSBmYWxzZTsKPiArCXZxLT5sYXN0X2FkZF90aW1lX3ZhbGlkID0gZmFs
c2U7Cj4gKyNlbmRpZgo+ICsKPiArCXZxLT5ldmVudCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCk7Cj4gKwo+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gKwkJdnEtPndlYWtfYmFycmllcnMg
PSBmYWxzZTsKPiArCj4gKwl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiArCXZx
LT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiArCj4gKwkvKiBObyBjYWxsYmFjaz8gIFRl
bGwgb3RoZXIgc2lkZSBub3QgdG8gYm90aGVyIHVzLiAqLwo+ICsJaWYgKCF2cS0+dnEuY2FsbGJh
Y2spIHsKPiArCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93IHw9IFZSSU5HX0FWQUlMX0Zf
Tk9fSU5URVJSVVBUOwo+ICsJCWlmICghdnEtPmV2ZW50KQo+ICsJCQl2cS0+c3BsaXQudnJpbmcu
YXZhaWwtPmZsYWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gKwkJCQkJdnEtPnNwbGl0LmF2
YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gKwl9Cj4gKwo+ICsJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJl
ZSBsaXN0cy4gKi8KPiArCXZxLT5mcmVlX2hlYWQgPSAwOwoKCkl0J3Mgbm90IGNsZWFyIHdoYXQg
a2luZCBvZiBpbml0aWFsaXphdGlvbiB0aGF0IHdlIHdhbnQgdG8gZG8gaGVyZS4gRS5nIAppdCBt
aXhlcyBzcGxpdCBzcGVjaWZpYyBzZXR1cHMgd2l0aCBzb21lIGdlbmVyYWwgc2V0dXBzIHdoaWNo
IGlzIGtpbmQgb2YgCmR1cGxpY2F0aW9uIG9mIHZyaW5nX3ZpcnRxdWV1ZV9pbml0X3BhY2tlZCgp
LgoKSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gb25seSBkbyBzcGxpdCBzcGVjaWZpYyBzZXR1
cHMgaGVyZSBhbmQgaGF2ZSBhIApjb21tb24gaGVscGVyIHRvIGRvIHRoZSBzZXR1cCB0aGF0IGlz
IGlycmVsZXZhbnQgdG8gcmluZyBsYXlvdXQuCgpUaGFua3MKCgo+ICt9Cj4gKwo+ICAgc3RhdGlj
IHZvaWQgdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwKPiAgIAkJCQkJIHN0cnVjdCB2cmluZyB2cmluZywKPiAgIAkJCQkJIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+IEBAIC0yMjQ5LDQyICsyMjg2LDE1IEBA
IHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5k
ZXgsCj4gICAJaWYgKCF2cSkKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAKPiAtCXZxLT5wYWNrZWRf
cmluZyA9IGZhbHNlOwo+ICAgCXZxLT52cS5jYWxsYmFjayA9IGNhbGxiYWNrOwo+ICAgCXZxLT52
cS52ZGV2ID0gdmRldjsKPiAgIAl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gLQl2cS0+dnEubnVtX2Zy
ZWUgPSB2cmluZy5udW07Cj4gICAJdnEtPnZxLmluZGV4ID0gaW5kZXg7Cj4gLQl2cS0+d2Vfb3du
X3JpbmcgPSBmYWxzZTsKPiAgIAl2cS0+bm90aWZ5ID0gbm90aWZ5Owo+ICAgCXZxLT53ZWFrX2Jh
cnJpZXJzID0gd2Vha19iYXJyaWVyczsKPiAtCXZxLT5icm9rZW4gPSBmYWxzZTsKPiAtCXZxLT5s
YXN0X3VzZWRfaWR4ID0gMDsKPiAtCXZxLT5ldmVudF90cmlnZ2VyZWQgPSBmYWxzZTsKPiAtCXZx
LT5udW1fYWRkZWQgPSAwOwo+IC0JdnEtPnVzZV9kbWFfYXBpID0gdnJpbmdfdXNlX2RtYV9hcGko
dmRldik7Cj4gLSNpZmRlZiBERUJVRwo+IC0JdnEtPmluX3VzZSA9IGZhbHNlOwo+IC0JdnEtPmxh
c3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxzZTsKPiAtI2VuZGlmCj4gICAKPiAgIAl2cS0+aW5kaXJl
Y3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJUkVDVF9ERVND
KSAmJgo+ICAgCQkhY29udGV4dDsKPiAtCXZxLT5ldmVudCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCk7Cj4gLQo+IC0JaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gLQkJdnEtPndlYWtfYmFycmll
cnMgPSBmYWxzZTsKPiAtCj4gLQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiAt
CXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiAtCj4gLQkvKiBObyBjYWxsYmFjaz8g
IFRlbGwgb3RoZXIgc2lkZSBub3QgdG8gYm90aGVyIHVzLiAqLwo+IC0JaWYgKCFjYWxsYmFjaykg
ewo+IC0JCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZBSUxfRl9OT19J
TlRFUlJVUFQ7Cj4gLQkJaWYgKCF2cS0+ZXZlbnQpCj4gLQkJCXZxLT5zcGxpdC52cmluZy5hdmFp
bC0+ZmxhZ3MgPSBjcHVfdG9fdmlydGlvMTYodmRldiwKPiAtCQkJCQl2cS0+c3BsaXQuYXZhaWxf
ZmxhZ3Nfc2hhZG93KTsKPiAtCX0KPiAgIAo+ICAgCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4
dHJhX3NwbGl0KHZyaW5nLm51bSwgJnN0YXRlLCAmZXh0cmEpOwo+ICAgCWlmIChlcnIpIHsKPiBA
QCAtMjI5Myw5ICsyMzAzLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1
ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl9Cj4gICAKPiAgIAl2cmluZ192aXJ0cXVldWVf
YXR0YWNoX3NwbGl0KHZxLCB2cmluZywgc3RhdGUsIGV4dHJhKTsKPiAtCj4gLQkvKiBQdXQgZXZl
cnl0aGluZyBpbiBmcmVlIGxpc3RzLiAqLwo+IC0JdnEtPmZyZWVfaGVhZCA9IDA7Cj4gKwl2cmlu
Z192aXJ0cXVldWVfaW5pdF9zcGxpdCh2cSwgdmRldiwgZmFsc2UpOwo+ICAgCj4gICAJc3Bpbl9s
b2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiAgIAlsaXN0X2FkZF90YWlsKCZ2cS0+dnEubGlz
dCwgJnZkZXYtPnZxcyk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
