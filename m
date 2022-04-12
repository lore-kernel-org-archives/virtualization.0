Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A027CC433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 05:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 396EB40616;
	Tue, 12 Apr 2022 05:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-pohqjXCXKk; Tue, 12 Apr 2022 05:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE0C3400EF;
	Tue, 12 Apr 2022 05:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640B2C0033;
	Tue, 12 Apr 2022 05:54:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41894C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1995E60F21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RDAYMYH7b2Hr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDCC560F04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649742845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=691Yo4tOxFREJuTeRonUH/gcyvI9lkMUJMdeyqkXSWQ=;
 b=VLRpx/y604ulpSnHd3oBgBryQ40YJV47hpgWmgMyhOka4OkTXOmdYl039yS9UbH5WW8vMr
 JQqbFsSZ5kawEQqCUqaptL4VTrq5vhk913MGoiaYk7WMI7ScN+j+9xyLpa89O6AuJ5tyGF
 Rd9a2H4W64zl+dIpveDfj4zkO3f8sbw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-N0F_wVSAPuKyTz3yWXLMrg-1; Tue, 12 Apr 2022 01:54:03 -0400
X-MC-Unique: N0F_wVSAPuKyTz3yWXLMrg-1
Received: by mail-pg1-f197.google.com with SMTP id
 t6-20020a6549c6000000b00398a43dbdf8so10016903pgs.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 22:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=691Yo4tOxFREJuTeRonUH/gcyvI9lkMUJMdeyqkXSWQ=;
 b=OtLgv2pY5nOm/SVqqgl7RSEccP4yqLQXFdNvS6cSlJweNwng61A5Zb8jxa7kba5Oqr
 YvRlPwPbRQbYXSDDg9bwi4H2bzGhg10TxDrz3SOGsd6wZR0OqMBa2ikxtVstp90SoJ/e
 eb6/opc/YM37aaiY228E5TThEmjy5wv3JomeJcX+1KBnnUyqADk2/OHsYkkWfJ16ZXRe
 BLghrs7RQjK2Zi4ZQH9oWQNkCyk9FbEaHXvyM+bBoFn92vccKGYNj+P2NW3xn+EmrCho
 Gf5uBynoIOWMAdsCFQbgdjKpanHtftVWzJYJVh1NAusFX5nT7dRrPcnSYXORUD+D0bMd
 3NRA==
X-Gm-Message-State: AOAM531va7E+1/npERUQQ7gFQyW2BOCm61dQ3sqy8aNwTm9TFOgSSSmj
 C41sGsfOiGgo0TPYNteIFxR/YZpZvPFNKAoSPQmWWju47/p7jDpuHIaKl4nNHnOYSwt/UhBj/M+
 Rk1Oh9ERe+4dkScr4CixwZfA7qv/+lNqD8o6L7kQpZg==
X-Received: by 2002:a17:902:f683:b0:158:8178:e7a0 with SMTP id
 l3-20020a170902f68300b001588178e7a0mr3510830plg.160.1649742841848; 
 Mon, 11 Apr 2022 22:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOjt8nlerN6jXVH9ANx2m0/Qvxoufl1r0WhRPAfaTl2kJvP+NMMrr2TTbfemTY216uBaWV4Q==
X-Received: by 2002:a17:902:f683:b0:158:8178:e7a0 with SMTP id
 l3-20020a170902f68300b001588178e7a0mr3510808plg.160.1649742841583; 
 Mon, 11 Apr 2022 22:54:01 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a056a001a0c00b004e1307b249csm37755988pfv.69.2022.04.11.22.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 22:54:01 -0700 (PDT)
Message-ID: <f79fc367-7ac5-961b-83c5-90f3d097c672@redhat.com>
Date: Tue, 12 Apr 2022 13:53:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 11/32] virtio_ring: split: introduce
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-12-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiB2aXJ0aW8gcmlu
ZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4KPiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMg
c3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPiB3ZSB3aWxsIHJl
bGVhc2UgdGhlIG9sZCB2cmluZy4gSW4gYW55IGNhc2UsIGFuIGVycm9yIGlzIHJldHVybmVkLAo+
IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcu
Cj4KPiBJbiB0aGUgY2FzZSBvZiBhbiBlcnJvciwgdGhlIGNhbGxlciBtdXN0Cj4gcmUtaW5pdGlh
bGl6ZSh2aXJ0cXVldWVfcmVpbml0X3NwbGl0KCkpIHRoZSB2aXJ0cXVldWUgdG8gZW5zdXJlIHRo
YXQgdGhlCj4gdnJpbmcgY2FuIGJlIHVzZWQuCj4KPiBJbiBhZGRpdGlvbiwgdnJpbmdfYWxpZ24s
IG1heV9yZWR1Y2VfbnVtIGFyZSBuZWNlc3NhcnkgZm9yIHJlYWxsb2NhdGluZwo+IHZyaW5nLCBz
byB0aGV5IGFyZSByZXRhaW5lZCBmb3IgY3JlYXRpbmcgdnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+IGluZGV4IDNkYzZhY2UyYmE3YS4uMzM4NjQxMzRhNzQ0IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gQEAgLTEzOSw2ICsxMzksMTIgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4g
ICAJCQkvKiBETUEgYWRkcmVzcyBhbmQgc2l6ZSBpbmZvcm1hdGlvbiAqLwo+ICAgCQkJZG1hX2Fk
ZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiAgIAkJCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+
ICsKPiArCQkJLyogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVzZXJ2
ZWQgZm9yCj4gKwkJCSAqIGNyZWF0aW5nIG5ldyB2cmluZy4KPiArCQkJICovCj4gKwkJCXUzMiB2
cmluZ19hbGlnbjsKPiArCQkJYm9vbCBtYXlfcmVkdWNlX251bTsKPiAgIAkJfSBzcGxpdDsKPiAg
IAo+ICAgCQkvKiBBdmFpbGFibGUgZm9yIHBhY2tlZCByaW5nICovCj4gQEAgLTE5OSw2ICsyMDUs
NyBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyBzdHJ1
Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQg
bnVtKTsKPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+
ICAgCj4gICAvKgo+ICAgICogSGVscGVycy4KPiBAQCAtMTA4OCw2ICsxMDk1LDggQEAgc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gICAJCXJl
dHVybiBOVUxMOwo+ICAgCX0KPiAgIAo+ICsJdG9fdnZxKHZxKS0+c3BsaXQudnJpbmdfYWxpZ24g
PSB2cmluZ19hbGlnbjsKPiArCXRvX3Z2cSh2cSktPnNwbGl0Lm1heV9yZWR1Y2VfbnVtID0gbWF5
X3JlZHVjZV9udW07CgoKSXQgbG9va3MgdG8gbWUgdGhlIGFib3ZlIHNob3VsZCBiZWxvbmcgdG8g
cGF0Y2ggNi4KCgo+ICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2Fk
ZHI7Cj4gICAJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3Np
emVfaW5fYnl0ZXM7Cj4gICAJdG9fdnZxKHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+IEBAIC0x
MDk1LDYgKzExMDQsNDQgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfc3BsaXQoCj4gICAJcmV0dXJuIHZxOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQg
dmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4g
K3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwlzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92cS0+dmRldjsKPiArCXN0cnVjdCB2cmluZ19kZXNj
X3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsK
PiArCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ICsJZG1hX2FkZHJfdCBkbWFfYWRkcjsK
PiArCXN0cnVjdCB2cmluZyB2cmluZzsKPiArCWludCBlcnIgPSAtRU5PTUVNOwo+ICsJdm9pZCAq
cXVldWU7Cj4gKwo+ICsJcXVldWUgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1h
X2FkZHIsICZudW0sCj4gKwkJCQkJdnEtPnNwbGl0LnZyaW5nX2FsaWduLAo+ICsJCQkJCXZxLT53
ZWFrX2JhcnJpZXJzLAo+ICsJCQkJCXZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAo
IXF1ZXVlKQo+ICsJCXJldHVybiAtRU5PTUVNOwo+ICsKPiArCXF1ZXVlX3NpemVfaW5fYnl0ZXMg
PSB2cmluZ19zaXplKG51bSwgdnEtPnNwbGl0LnZyaW5nX2FsaWduKTsKPiArCj4gKwllcnIgPSB2
cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdChudW0sICZzdGF0ZSwgJmV4dHJhKTsKPiArCWlm
IChlcnIpIHsKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3NpemVfaW5fYnl0ZXMs
IHF1ZXVlLCBkbWFfYWRkcik7Cj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gKwl9Cj4gKwo+ICsJdnJp
bmdfZnJlZSgmdnEtPnZxKTsKPiArCj4gKwl2cmluZ19pbml0KCZ2cmluZywgbnVtLCBxdWV1ZSwg
dnEtPnNwbGl0LnZyaW5nX2FsaWduKTsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQo
dnEsIHZyaW5nLCBzdGF0ZSwgZXh0cmEpOwo+ICsJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0g
ZG1hX2FkZHI7Cj4gKwl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVf
aW5fYnl0ZXM7CgoKSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gbW92ZSB0aGUgYWJvdmUgYXNz
aWdubWVudHMgdG8gCnZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoKS4KCk90aGVyIGxvb2tz
IGdvb2QuCgpUaGFua3MKCgo+ICsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHZxLCB2
ZGV2LCB0cnVlKTsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgCj4gICAvKgo+ICAgICogUGFj
a2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
