Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD8C43217
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D23883E80;
	Tue, 12 Apr 2022 06:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsVxtaAQ14LR; Tue, 12 Apr 2022 06:43:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B990A83E74;
	Tue, 12 Apr 2022 06:43:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C5AC0082;
	Tue, 12 Apr 2022 06:43:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85606C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B10560F28
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vCOLBvB4KDbG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BEE660F04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649745802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEDFVaHE5LgovQ1qymAwTeM82i08IwmDwRWKJJtG8Gs=;
 b=hZtiyu1RibxHMuY7h+T4iWDINHudDPgb2ZR5a0uRVLmAinztpt7szMhwG8Cb5AaCvZzKpB
 i31bM0L42tyfgAD1T8xK5ECALmcmht7WI1Ozuzk/zYU++zkak025sicxl7OzTw9bVbVnCl
 fejkKsptPps9EH+XNuvKPMdQvP/e+ao=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-mOAYFYopPoKeiUe1BVJeVg-1; Tue, 12 Apr 2022 02:43:21 -0400
X-MC-Unique: mOAYFYopPoKeiUe1BVJeVg-1
Received: by mail-pj1-f72.google.com with SMTP id
 v14-20020a17090a0c8e00b001cb778cc439so3413124pja.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 23:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YEDFVaHE5LgovQ1qymAwTeM82i08IwmDwRWKJJtG8Gs=;
 b=pu0zVurOZ+yEwc3ltXJW5D5/gHeM3QzPbRZ1FktoMQTHQpNXaoRfI/HYAL3/RPekuu
 mbOrrk9spkThG6bVQjaLlgNusMCB1uu2ZQVh6ZxZXXNHCp7vIgZXiO1obe06F7TgGRXN
 Ys62L7vbXqDz6oEVloNQoqBOmn5NqUgusn2sVcTWq/SV8fvuW03JG1ODe5/65ae6qr3x
 KIanTAtPFJ9yQzBzXi48gSADR/gG7GtsV/SQqraR0YP7cXHu9JIzDQkRq0NGy4FU708I
 A9PeCsV7qucMcMp3rfsbAgXn2TlTno7xdrKXXRho5Vy7od1QeAuNYP2ohjDsczUR1d/e
 TfJA==
X-Gm-Message-State: AOAM532XLFl5X4/u2NMmC+mTi/YAgMIKO2LwFrwRdV4T3sH7qm49eRAj
 oAqF+e1tJcprKj4FjxLSe4IgSPQI1r1Wg+wbkUebPwmxYVCZ0m+ylWqF68Ug9sgS8gvDhssRqty
 wasCvTlzSMSx3MZ58zokqYds9okPN3cTz1R298imG6g==
X-Received: by 2002:a65:494b:0:b0:399:28c:614f with SMTP id
 q11-20020a65494b000000b00399028c614fmr28693514pgs.182.1649745800170; 
 Mon, 11 Apr 2022 23:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVisGJkqk8SxAqgvhvNH2N8TL+p8/HvB8CALOp5QP1jzqML5w0mYx0kcrqACK75c6WV3bObw==
X-Received: by 2002:a65:494b:0:b0:399:28c:614f with SMTP id
 q11-20020a65494b000000b00399028c614fmr28693502pgs.182.1649745799938; 
 Mon, 11 Apr 2022 23:43:19 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 mn18-20020a17090b189200b001cac1781bb4sm1544598pjb.35.2022.04.11.23.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 23:43:19 -0700 (PDT)
Message-ID: <5a4d48e1-aab9-9416-adc7-a07ebb39c84d@redhat.com>
Date: Tue, 12 Apr 2022 14:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 21/32] virtio_pci: queue_reset: update struct
 virtio_pci_common_cfg and option functions
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-22-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBBZGQgcXVldWVf
cmVzZXQgaW4gdmlydGlvX3BjaV9jb21tb25fY2ZnLCBhbmQgYWRkIHJlbGF0ZWQgb3BlcmF0aW9u
Cj4gZnVuY3Rpb25zLgo+Cj4gRm9yIG5vdCBicmVha3MgdUFCSSwgYWRkIGEgbmV3IHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmdfcmVzZXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAg
aW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oICAgICAgfCAgMiArKwo+ICAgaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCAgICAgICAgfCAgNyArKysrKwo+ICAgMyBmaWxlcyBj
aGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bl9kZXYuYwo+IGluZGV4IGU4YjNmZjJiOWZiYy4uOGM3NGIwMGJjNTExIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAtMyw2ICszLDcgQEAKPiAgICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXku
aD4KPiAgIAo+ICAgLyoKPiAgICAqIHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eSAtIG1hcCBhIHBh
cnQgb2YgdmlydGlvIHBjaSBjYXBhYmlsaXR5Cj4gQEAgLTQ2Myw2ICs0NjQsNDEgQEAgdm9pZCB2
cF9tb2Rlcm5fc2V0X3N0YXR1cyhzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2
LAo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnBfbW9kZXJuX3NldF9zdGF0dXMpOwo+ICAg
Cj4gKy8qCj4gKyAqIHZwX21vZGVybl9nZXRfcXVldWVfcmVzZXQgLSBnZXQgdGhlIHF1ZXVlIHJl
c2V0IHN0YXR1cwo+ICsgKiBAbWRldjogdGhlIG1vZGVybiB2aXJ0aW8tcGNpIGRldmljZQo+ICsg
KiBAaW5kZXg6IHF1ZXVlIGluZGV4Cj4gKyAqLwo+ICtpbnQgdnBfbW9kZXJuX2dldF9xdWV1ZV9y
ZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpCj4g
K3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfcmVzZXQgX19pb21lbSAqY2ZnOwo+
ICsKPiArCWNmZyA9IChzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3Jlc2V0IF9faW9tZW0g
KiltZGV2LT5jb21tb247Cj4gKwo+ICsJdnBfaW93cml0ZTE2KGluZGV4LCAmY2ZnLT5jZmcucXVl
dWVfc2VsZWN0KTsKPiArCXJldHVybiB2cF9pb3JlYWQxNigmY2ZnLT5xdWV1ZV9yZXNldCk7Cj4g
K30KPiArRVhQT1JUX1NZTUJPTF9HUEwodnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldCk7Cj4gKwo+
ICsvKgo+ICsgKiB2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0IC0gcmVzZXQgdGhlIHF1ZXVlCj4g
KyAqIEBtZGV2OiB0aGUgbW9kZXJuIHZpcnRpby1wY2kgZGV2aWNlCj4gKyAqIEBpbmRleDogcXVl
dWUgaW5kZXgKPiArICovCj4gK3ZvaWQgdnBfbW9kZXJuX3NldF9xdWV1ZV9yZXNldChzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1MTYgaW5kZXgpCj4gK3sKPiArCXN0cnVj
dCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfcmVzZXQgX19pb21lbSAqY2ZnOwo+ICsKPiArCWNmZyA9
IChzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3Jlc2V0IF9faW9tZW0gKiltZGV2LT5jb21t
b247Cj4gKwo+ICsJdnBfaW93cml0ZTE2KGluZGV4LCAmY2ZnLT5jZmcucXVldWVfc2VsZWN0KTsK
PiArCXZwX2lvd3JpdGUxNigxLCAmY2ZnLT5xdWV1ZV9yZXNldCk7Cj4gKwo+ICsJd2hpbGUgKHZw
X2lvcmVhZDE2KCZjZmctPnF1ZXVlX3Jlc2V0KSAhPSAxKQo+ICsJCW1zbGVlcCgxKTsKPiArfQo+
ICtFWFBPUlRfU1lNQk9MX0dQTCh2cF9tb2Rlcm5fc2V0X3F1ZXVlX3Jlc2V0KTsKPiArCj4gICAv
Kgo+ICAgICogdnBfbW9kZXJuX3F1ZXVlX3ZlY3RvciAtIHNldCB0aGUgTVNJWCB2ZWN0b3IgZm9y
IGEgc3BlY2lmaWMgdmlydHF1ZXVlCj4gICAgKiBAbWRldjogdGhlIG1vZGVybiB2aXJ0aW8tcGNp
IGRldmljZQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgg
Yi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBpbmRleCBlYjJiZDliNDA3N2Qu
LmNjNDE1NGRkN2IyOCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9k
ZXJuLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBAQCAtMTA2
LDQgKzEwNiw2IEBAIHZvaWQgX19pb21lbSAqIHZwX21vZGVybl9tYXBfdnFfbm90aWZ5KHN0cnVj
dCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYsCj4gICAJCQkJICAgICAgIHUxNiBpbmRl
eCwgcmVzb3VyY2Vfc2l6ZV90ICpwYSk7Cj4gICBpbnQgdnBfbW9kZXJuX3Byb2JlKHN0cnVjdCB2
aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYpOwo+ICAgdm9pZCB2cF9tb2Rlcm5fcmVtb3Zl
KHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYpOwo+ICtpbnQgdnBfbW9kZXJu
X2dldF9xdWV1ZV9yZXNldChzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2LCB1
MTYgaW5kZXgpOwo+ICt2b2lkIHZwX21vZGVybl9zZXRfcXVldWVfcmVzZXQoc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2RldmljZSAqbWRldiwgdTE2IGluZGV4KTsKPiAgICNlbmRpZgo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19wY2kuaAo+IGluZGV4IDIyYmVjOWJkMGRmYy4uZDk0NjJlZmQ2Y2U4IDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gQEAgLTE3Myw2ICsxNzMsMTMgQEAgc3RydWN0IHZp
cnRpb19wY2lfY29tbW9uX2NmZ19ub3RpZnkgewo+ICAgCV9fbGUxNiBwYWRkaW5nOwo+ICAgfTsK
PiAgIAo+ICtzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3Jlc2V0IHsKPiArCXN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcgY2ZnOwo+ICsKPiArCV9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0
YTsJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2IHF1ZXVlX3Jlc2V0OwkJLyogcmVhZC13cml0
ZSAqLwo+ICt9OwoKCkkgcHJlZmVyIHRvIHVzZSBhIHNlcGFyYXRlIHBhdGNoIGZvciB0aGUgdUFQ
SSBjaGFuZ2UuCgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoKPiArCj4gICAvKiBGaWVsZHMg
aW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPiAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NmZ19j
YXAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX2NhcCBjYXA7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
