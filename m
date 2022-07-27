Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B10C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBA80605B0;
	Wed, 27 Jul 2022 04:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBA80605B0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MA/hizGb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGXWvTOW1h8O; Wed, 27 Jul 2022 04:23:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B6FE6058A;
	Wed, 27 Jul 2022 04:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B6FE6058A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA53C0035;
	Wed, 27 Jul 2022 04:23:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4E2040940
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4E2040940
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MA/hizGb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSrDyAQ14ajA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:23:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A3F408A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39A3F408A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658895820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdTyBXQ12zt36fi5CylDMDbBOh0jOOAI9MK/TOtCnDo=;
 b=MA/hizGbbNDOLImEI/oml/y6lqgCT6Qn5MHmMSHMtSLgxKv9yX/Sywbm6SMOO971FQiU4h
 pLqKiz3SCr89HmRXu34xS5zVZxfzFjtbnQkDuVR4prnoL14MmAPaP9VaEJIv7vD/MxFItj
 swtdpAwgx0bhgS58+FHk/tAHGJPAL18=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-Kf4uUWmaOSSJj-_V30AgHQ-1; Wed, 27 Jul 2022 00:23:39 -0400
X-MC-Unique: Kf4uUWmaOSSJj-_V30AgHQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 u64-20020a638543000000b00412b09eae15so7349298pgd.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OdTyBXQ12zt36fi5CylDMDbBOh0jOOAI9MK/TOtCnDo=;
 b=b6JmgT3cfjgNoYiqCSYj5ubB0b9ymataqvhKHICST7wo97qvM04lloCRpucGuJVKzu
 3GkJh+n5Q2rR6EFQtzK4/wNrvUYmULtw8jJ8GSpCd9MyQki7hjNPNfr/yVj+pUQxmSMe
 Jj2WWaLYVjRjC2aOzA0JEywu7k5kKmeZlYnYRa+41tKiuWSkm7LCvpZehNLxbu9Rvg9V
 kQz5VNLPp3VPUzVqF8Wlb8+eggC5+17tNplrxMtJolbYA5SfkXtACA72mya0CeruEXCp
 jWFhRHhwyT2nmVHROlZurUW5fHnxNygseJ/4LpsGtsSq9bUcsZCHBCwtZLpbcewWE5SC
 W0KA==
X-Gm-Message-State: AJIora/rCMHSkv8UhDWa7g2Ff9BeR/16WCkPghRFf+YHHW/qHBoW1xeg
 5sm0HxsyBgeHuCaTOs/ZqUOoSrKKy0Igb4WoVGx+JDcOliS5FSi/9fl4KVUe4XmKPqYcW0uIx2a
 sMvRVedoZmiZ3PtFl0hl/jJXoKkPxynPrRfRtrzLLLw==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id
 j14-20020a170903024e00b0016b9fa241e5mr20227899plh.127.1658895816064; 
 Tue, 26 Jul 2022 21:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFVrN7XGfUjMTUPwELy3bIdBt3XT5BzzLiiLmTtkRh2koWjrFFsrQ3JLmbIc4/6H4P5/I5Jg==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id
 j14-20020a170903024e00b0016b9fa241e5mr20227852plh.127.1658895815745; 
 Tue, 26 Jul 2022 21:23:35 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l28-20020a635b5c000000b0041a411823d4sm10950578pgm.22.2022.07.26.21.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:23:34 -0700 (PDT)
Message-ID: <1a5fa20c-c8f2-2537-2b3b-675a40e113ac@redhat.com>
Date: Wed, 27 Jul 2022 12:23:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 11/42] virtio_ring: split: extract the logic of alloc
 state and extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-12-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGNyZWF0aW5nIGRlc2Nfc3RhdGUsIGRlc2NfZXh0cmEsIGFuZCBzdWJzZXF1ZW50Cj4g
cGF0Y2hlcyB3aWxsIGNhbGwgaXQgaW5kZXBlbmRlbnRseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+IGluZGV4IDM4MTc1MjAzNzFlZS4uNmMyNGIzM2VhMTg2IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gQEAgLTIxMiw2ICsyMTIsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1
ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJCQkJICAg
ICAgIGJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gICAJCQkJCSAgICAgICB2
b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gICAJCQkJCSAgICAgICBjb25z
dCBjaGFyICpuYW1lKTsKPiArc3RhdGljIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICp2cmluZ19h
bGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pOwo+ICAgCj4gICAvKgo+ICAgICogSGVs
cGVycy4KPiBAQCAtOTQ3LDYgKzk0OCwzMiBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFj
aF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4gTlVM
TDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0
KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nX3NwbGl0KQo+ICt7Cj4gKwlzdHJ1
Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3RhdGU7Cj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19l
eHRyYSAqZXh0cmE7Cj4gKwl1MzIgbnVtID0gdnJpbmdfc3BsaXQtPnZyaW5nLm51bTsKPiArCj4g
KwlzdGF0ZSA9IGttYWxsb2NfYXJyYXkobnVtLCBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3Rh
dGVfc3BsaXQpLCBHRlBfS0VSTkVMKTsKPiArCWlmICghc3RhdGUpCj4gKwkJZ290byBlcnJfc3Rh
dGU7Cj4gKwo+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKG51bSk7Cj4gKwlpZiAo
IWV4dHJhKQo+ICsJCWdvdG8gZXJyX2V4dHJhOwo+ICsKPiArCW1lbXNldChzdGF0ZSwgMCwgbnVt
ICogc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7Cj4gKwo+ICsJdnJpbmdf
c3BsaXQtPmRlc2Nfc3RhdGUgPSBzdGF0ZTsKPiArCXZyaW5nX3NwbGl0LT5kZXNjX2V4dHJhID0g
ZXh0cmE7Cj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9leHRyYToKPiArCWtmcmVlKHN0YXRlKTsK
PiArZXJyX3N0YXRlOgo+ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICBzdGF0aWMgdm9p
ZCB2cmluZ19mcmVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nX3Nw
bGl0LAo+ICAgCQkJICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIHsKPiBAQCAt
MjI0Miw2ICsyMjY5LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJCQkJCSAgICAgICBjb25zdCBjaGFyICpu
YW1lKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ICsJaW50IGVycjsK
PiAgIAo+ICAgCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNL
RUQpKQo+ICAgCQlyZXR1cm4gTlVMTDsKPiBAQCAtMjI4MiwxNyArMjMxMCwxNCBAQCBzdGF0aWMg
c3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRl
eCwKPiAgIAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gICAJfQo+ICAgCj4g
LQl2cS0+c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2NfYXJyYXkodnJpbmdfc3BsaXQtPnZyaW5n
Lm51bSwKPiAtCQkJc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tF
Uk5FTCk7Cj4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+IC0JCWdvdG8gZXJyX3N0YXRl
Owo+IC0KPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19leHRyYSh2
cmluZ19zcGxpdC0+dnJpbmcubnVtKTsKPiAtCWlmICghdnEtPnNwbGl0LmRlc2NfZXh0cmEpCj4g
LQkJZ290byBlcnJfZXh0cmE7Cj4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxp
dCh2cmluZ19zcGxpdCk7Cj4gKwlpZiAoZXJyKSB7Cj4gKwkJa2ZyZWUodnEpOwo+ICsJCXJldHVy
biBOVUxMOwo+ICsJfQo+ICAgCj4gLQltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHZy
aW5nX3NwbGl0LT52cmluZy5udW0gKgo+IC0JCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3Rh
dGVfc3BsaXQpKTsKPiArCXZxLT5zcGxpdC5kZXNjX3N0YXRlID0gdnJpbmdfc3BsaXQtPmRlc2Nf
c3RhdGU7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX3NwbGl0LT5kZXNjX2V4dHJh
Owo+ICAgCj4gICAJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LT52cmluZy5udW0pOwo+
ICAgCj4gQEAgLTIzMDAsMTIgKzIzMjUsNiBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqX192
cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlsaXN0X2FkZF90YWls
KCZ2cS0+dnEubGlzdCwgJnZkZXYtPnZxcyk7Cj4gICAJc3Bpbl91bmxvY2soJnZkZXYtPnZxc19s
aXN0X2xvY2spOwo+ICAgCXJldHVybiAmdnEtPnZxOwo+IC0KPiAtZXJyX2V4dHJhOgo+IC0Ja2Zy
ZWUodnEtPnNwbGl0LmRlc2Nfc3RhdGUpOwo+IC1lcnJfc3RhdGU6Cj4gLQlrZnJlZSh2cSk7Cj4g
LQlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZSgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
