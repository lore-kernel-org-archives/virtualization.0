Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7213DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 03:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17EA041519;
	Tue, 12 Apr 2022 03:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPpT4T3dnYaX; Tue, 12 Apr 2022 03:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30C994150F;
	Tue, 12 Apr 2022 03:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0217C0033;
	Tue, 12 Apr 2022 03:27:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEB25C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C76D583E22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmloXzjqYcNR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 140F383E1C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649734033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3LHty2/qeNdZWq4XVW+rsoA0rPEGbU09m2IO66/YBI=;
 b=OorWtax2sd7fUC6q9uSdA+eDino3Ml2p277/w2Xjgyl0eTxJAnH/il2bqanaWjbNbBgvgo
 Wt3e126fbu9hIqJqYYV1htJbC3NCksXGzH0Z5IHBq883xj7FXi20gWpQQVuE4BHZiAzSRI
 KpOzJp2wTYPIYxs8TS+5u8uhZzG+M8I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-qlOWMC5yP2GQkHhGJO7QFg-1; Mon, 11 Apr 2022 23:27:04 -0400
X-MC-Unique: qlOWMC5yP2GQkHhGJO7QFg-1
Received: by mail-pf1-f200.google.com with SMTP id
 o64-20020a62cd43000000b00505f9ba9681so605051pfg.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 20:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=n3LHty2/qeNdZWq4XVW+rsoA0rPEGbU09m2IO66/YBI=;
 b=Mz0qjLIS3jBMETXXv1YHFvYsUQI/YGGlpg4PuPVTfyzjREG44F6S+VnOWoQ1TVWMU7
 AhyCdP15Q1XWXMezKvUdiyioJaFsPr7wOu9En3ARwU9DfVJ87/tiHUoGwOWilQVzk6Ex
 q8cpCp+Q17l7TKuMotiLEj8XduWCQcJEjVEH7+tZu8AfVhjl4oPaTbZloOSQfBUWn0XS
 SfJTtisw+Uye7VuGM4Ze6ZymMMT8x1y7WNYfxPcURhP2USQOue7dZMNLTK0f/oU0/aQ4
 6XXtS1Z5tWHM31sxn4s5jmNmWjQzc0+hLMo6jlBA+QMvF8y+B+/K596K9yF/UyDexuw5
 Co9w==
X-Gm-Message-State: AOAM530uq1mYHe80MPsFldkD7109+Q2x1f1tKQVk5/Yu4YBbJCh24lDc
 SxixDdyfS6b+S8JocxzzaDoBA54DncEu2SCfggWfX/z46RTLs4kTqY4Og52UJzfUFAcPkZraChI
 hBZi8oeGMb6AtqkgdfeTMBtXM9sPGL3NXElLMUG+bvg==
X-Received: by 2002:a17:902:b906:b0:158:3120:3b69 with SMTP id
 bf6-20020a170902b90600b0015831203b69mr15871774plb.33.1649734023809; 
 Mon, 11 Apr 2022 20:27:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHffDSvLUs63LGZC/1Iz9azGV9n6QX71FL6tEjgzfXt6jW1mB2ZTmIC449SS9wxUEzJSvkig==
X-Received: by 2002:a17:902:b906:b0:158:3120:3b69 with SMTP id
 bf6-20020a170902b90600b0015831203b69mr15871735plb.33.1649734023529; 
 Mon, 11 Apr 2022 20:27:03 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 k62-20020a17090a4cc400b001c7ea7f487asm872150pjh.39.2022.04.11.20.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 20:27:02 -0700 (PDT)
Message-ID: <927ee895-84ae-fb69-c9ed-9c1836ff1d03@redhat.com>
Date: Tue, 12 Apr 2022 11:26:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 07/32] virtio_ring: split: extract the logic of alloc
 state and extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-8-xuanzhuo@linux.alibaba.com>
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
aGUgbG9naWMgb2YgY3JlYXRpbmcgZGVzY19zdGF0ZSwgZGVzY19leHRyYSwgYW5kIHN1YnNlcXVl
bnQKPiBwYXRjaGVzIHdpbGwgY2FsbCBpdCBpbmRlcGVuZGVudGx5Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDcyZDVhZTA2M2ZhMC4uNmRlNjc0Mzlj
YjU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE5OCw2ICsxOTgsNyBAQCBzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlIHsKPiAgICNlbmRpZgo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgc3RydWN0
IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51
bSk7Cj4gICAKPiAgIC8qCj4gICAgKiBIZWxwZXJzLgo+IEBAIC05MTUsNiArOTE2LDMzIEBAIHN0
YXRpYyB2b2lkICp2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWZfc3BsaXQoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ICAgCXJldHVybiBOVUxMOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdnJp
bmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQodTMyIG51bSwKPiArCQkJCQkgc3RydWN0IHZyaW5n
X2Rlc2Nfc3RhdGVfc3BsaXQgKipkZXNjX3N0YXRlLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmdfZGVz
Y19leHRyYSAqKmRlc2NfZXh0cmEpCj4gK3sKPiArCXN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3Nw
bGl0ICpzdGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiArCj4gKwlz
dGF0ZSA9IGttYWxsb2NfYXJyYXkobnVtLCBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVf
c3BsaXQpLCBHRlBfS0VSTkVMKTsKPiArCWlmICghc3RhdGUpCj4gKwkJZ290byBlcnJfc3RhdGU7
Cj4gKwo+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKG51bSk7Cj4gKwlpZiAoIWV4
dHJhKQo+ICsJCWdvdG8gZXJyX2V4dHJhOwo+ICsKPiArCW1lbXNldChzdGF0ZSwgMCwgbnVtICog
c2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7Cj4gKwo+ICsJKmRlc2Nfc3Rh
dGUgPSBzdGF0ZTsKPiArCSpkZXNjX2V4dHJhID0gZXh0cmE7Cj4gKwlyZXR1cm4gMDsKPiArCj4g
K2Vycl9leHRyYToKPiArCWtmcmVlKHN0YXRlKTsKPiArZXJyX3N0YXRlOgo+ICsJcmV0dXJuIC1F
Tk9NRU07Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCAqdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gICAJCQkJICAgICBkbWFfYWRkcl90ICpkbWFf
YWRkciwKPiAgIAkJCQkgICAgIHUzMiAqbiwKPiBAQCAtMjE5Niw3ICsyMjI0LDEwIEBAIHN0cnVj
dCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4g
ICAJCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAgIAkJCQkJY29u
c3QgY2hhciAqbmFtZSkKPiAgIHsKPiArCXN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICpz
dGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiAgIAlzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cTsKPiArCWludCBlcnI7Cj4gICAKPiAgIAlpZiAodmlydGlvX2hhc19m
ZWF0dXJlKHZkZXYsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkKPiAgIAkJcmV0dXJuIE5VTEw7Cj4g
QEAgLTIyNDYsMzAgKzIyNzcsMjIgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmly
dHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdz
X3NoYWRvdyk7Cj4gICAJfQo+ICAgCj4gLQl2cS0+c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2Nf
YXJyYXkodnJpbmcubnVtLAo+IC0JCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3Bs
aXQpLCBHRlBfS0VSTkVMKTsKPiAtCWlmICghdnEtPnNwbGl0LmRlc2Nfc3RhdGUpCj4gLQkJZ290
byBlcnJfc3RhdGU7Cj4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCh2cmlu
Zy5udW0sICZzdGF0ZSwgJmV4dHJhKTsKCgpOaXQ6IHdlIGNhbiBwYXNzIGUuZyAmdnEtPnNwbGl0
LmRlc2Nfc3RhdGUgaGVyZSB0byBhdm9pZCBleHRyYSB0ZW1wIAp2YXJpYWJsZSBhbmQgYXNzaWdu
bWVudC4KCk90aGVyIGxvb2tzIGdvb2QuCgpUaGFua3MKCgo+ICsJaWYgKGVycikgewo+ICsJCWtm
cmVlKHZxKTsKPiArCQlyZXR1cm4gTlVMTDsKPiArCX0KPiAgIAo+IC0JdnEtPnNwbGl0LmRlc2Nf
ZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKHZyaW5nLm51bSk7Cj4gLQlpZiAoIXZxLT5z
cGxpdC5kZXNjX2V4dHJhKQo+IC0JCWdvdG8gZXJyX2V4dHJhOwo+ICsJdnEtPnNwbGl0LmRlc2Nf
c3RhdGUgPSBzdGF0ZTsKPiArCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gZXh0cmE7Cj4gICAKPiAg
IAkvKiBQdXQgZXZlcnl0aGluZyBpbiBmcmVlIGxpc3RzLiAqLwo+ICAgCXZxLT5mcmVlX2hlYWQg
PSAwOwo+IC0JbWVtc2V0KHZxLT5zcGxpdC5kZXNjX3N0YXRlLCAwLCB2cmluZy5udW0gKgo+IC0J
CQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpKTsKPiAgIAo+ICAgCXNwaW5f
bG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxp
c3QsICZ2ZGV2LT52cXMpOwo+ICAgCXNwaW5fdW5sb2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsK
PiAgIAlyZXR1cm4gJnZxLT52cTsKPiAtCj4gLWVycl9leHRyYToKPiAtCWtmcmVlKHZxLT5zcGxp
dC5kZXNjX3N0YXRlKTsKPiAtZXJyX3N0YXRlOgo+IC0Ja2ZyZWUodnEpOwo+IC0JcmV0dXJuIE5V
TEw7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChfX3ZyaW5nX25ld192aXJ0cXVldWUpOwo+
ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
