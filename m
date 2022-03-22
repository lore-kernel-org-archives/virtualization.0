Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E97C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 06:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6EA441604;
	Tue, 22 Mar 2022 06:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTOYF06gixoP; Tue, 22 Mar 2022 06:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6582E41603;
	Tue, 22 Mar 2022 06:33:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34DA7C001A;
	Tue, 22 Mar 2022 06:33:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 763BBC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5298E80F2C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDJoHqGJ8EUp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F68E80F05
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647930821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1LMlN3/HiZxqLxcRiMsW4oXg3bMrW3Z+MBWhIXImSc=;
 b=QoyfE7Yg1fNWvDAyLYMnENrSNdwTM0gWP6k9Rv1J91+LrmAfeISJJjixxMFMmLz4P9QF31
 LwREltVHYAq0ivt1h7paEkSLOzkytscXs8FBv+tIlMwQ1WtTCb05qKhX9S+ZsE1SwAww5t
 80tnXvd8Efs9WWDnZagEDOAl+lEkDUY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-wk_WEk96PKyT9z9zi181fQ-1; Tue, 22 Mar 2022 02:33:39 -0400
X-MC-Unique: wk_WEk96PKyT9z9zi181fQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 b7-20020a633407000000b0038413d39ca9so646280pga.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 23:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=C1LMlN3/HiZxqLxcRiMsW4oXg3bMrW3Z+MBWhIXImSc=;
 b=36XDZ90IGptHxWjA+wNxWRrEkW/Lv4RDkqxwHdgCwf31DKy9KkN2gbF+WgUbsueUFr
 SYBUoCTrelxZByDHkuEbaXXerxtQuVmGbwNyz07IJ9u6z7HidyOjU0m3wyYYIDJ/Rcow
 sB+ie9KXux/xfgAuuWBLFRsF6fpZAHRXZk2BLYCHbtLGC/OW/DqiuA2f7VANC7Lo/bhl
 g1/l46N2rmEl9/2mJR8JWCT675xjR2YpZyqqWD5gC+49rAat6mCmbtAAS51fXc77kgQf
 V75e0I6V9Y3vhIR3bkfBsi+xwm2S+sX7Dv5AOahzyBzlgVX4dPuJ5wJF54n2RsGehkjZ
 /Ngw==
X-Gm-Message-State: AOAM532zuVWFbsmvW/8fnsThvuBXwnAyB8XkPdA3aHH87kS5LBbFqKIL
 meLKDZYIGMjpYtYqoGyYOAyqVwpekIuAqdC9jVpWQl8T00zIIOpEbqe27srESco2LVfC7EYXtpi
 rvJPbjQhfss3AknarwRqLO0ExLSIamMjM3aFUE3778Q==
X-Received: by 2002:a17:90a:6849:b0:1c7:5640:9c0d with SMTP id
 e9-20020a17090a684900b001c756409c0dmr2464134pjm.188.1647930818573; 
 Mon, 21 Mar 2022 23:33:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznqgBFxnltZamb/Bo60Fiq9jtrFWwik9bfvK72B2yVNFdyAnzN5B48TudGCmLiZcUPtew4YQ==
X-Received: by 2002:a17:90a:6849:b0:1c7:5640:9c0d with SMTP id
 e9-20020a17090a684900b001c756409c0dmr2464113pjm.188.1647930818271; 
 Mon, 21 Mar 2022 23:33:38 -0700 (PDT)
Received: from [10.72.13.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 2-20020a631342000000b0037487b6b018sm16273517pgt.0.2022.03.21.23.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 23:33:37 -0700 (PDT)
Message-ID: <910406b9-2693-c52e-4214-7a47f40100f7@redhat.com>
Date: Tue, 22 Mar 2022 14:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 07/16] virtio_ring: split: extract the logic of alloc
 state and extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220314093455.34707-8-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2YgY3JlYXRpbmcgZGVzY19zdGF0ZSwgZGVzY19leHRyYSwgYW5kIHN1YnNlcXVl
bnQKPiBwYXRjaGVzIHdpbGwgY2FsbCBpdCBpbmRlcGVuZGVudGx5Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGQ3NjY3Zjc0YzQyYi4uOWI4NTAxODhj
MzhlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxODYsNiArMjE4NiwzMyBAQCBpcnFy
ZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX3ZxKQo+ICAgfQo+ICAgRVhQ
T1JUX1NZTUJPTF9HUEwodnJpbmdfaW50ZXJydXB0KTsKPiAgIAo+ICtzdGF0aWMgaW50IF9fdnJp
bmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQodTMyIG51bSwKPiArCQkJCQkgICBzdHJ1Y3QgdnJp
bmdfZGVzY19zdGF0ZV9zcGxpdCAqKmRlc2Nfc3RhdGUsCj4gKwkJCQkJICAgc3RydWN0IHZyaW5n
X2Rlc2NfZXh0cmEgKipkZXNjX2V4dHJhKQoKCkEgbml0IGhlcmU6IEkgdGhpbmsgd2UgY2FuIHNp
bXBseSByZW1vdmUgdGhlICJfXyIgcHJlZml4IHNpbmNlOgoKMSkgV2UgaGF2ZW4ndCBoYWQgYSB2
ZXJzaW9uIG9mIGhlbHBlciB3aXRob3V0ICJfXyIKCjIpIFRoZXJlJ3JlIG90aGVyIGludGVybmFs
IGhlbHBlcnMgdGhhdCBkb2Vzbid0IHVzZSAiX18iCgpUaGFua3MKCgo+ICt7Cj4gKwlzdHJ1Y3Qg
dnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3RhdGU7Cj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19leHRy
YSAqZXh0cmE7Cj4gKwo+ICsJc3RhdGUgPSBrbWFsbG9jX2FycmF5KG51bSwgc2l6ZW9mKHN0cnVj
dCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIXN0YXRlKQo+
ICsJCWdvdG8gZXJyX3N0YXRlOwo+ICsKPiArCWV4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19leHRy
YShudW0pOwo+ICsJaWYgKCFleHRyYSkKPiArCQlnb3RvIGVycl9leHRyYTsKPiArCj4gKwltZW1z
ZXQoc3RhdGUsIDAsIG51bSAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCkp
Owo+ICsKPiArCSpkZXNjX3N0YXRlID0gc3RhdGU7Cj4gKwkqZGVzY19leHRyYSA9IGV4dHJhOwo+
ICsJcmV0dXJuIDA7Cj4gKwo+ICtlcnJfZXh0cmE6Cj4gKwlrZnJlZShzdGF0ZSk7Cj4gK2Vycl9z
dGF0ZToKPiArCXJldHVybiAtRU5PTUVNOwo+ICt9Cj4gKwo+ICAgLyogT25seSBhdmFpbGFibGUg
Zm9yIHNwbGl0IHJpbmcgKi8KPiAgIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRx
dWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJCQkJCXN0cnVjdCB2cmluZyB2cmluZywKPiBA
QCAtMjE5Niw3ICsyMjIzLDEwIEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRx
dWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0
IHZpcnRxdWV1ZSAqKSwKPiAgIAkJCQkJY29uc3QgY2hhciAqbmFtZSkKPiAgIHsKPiArCXN0cnVj
dCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4
dHJhICpleHRyYTsKPiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiArCWludCBlcnI7
Cj4gICAKPiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX1JJTkdfUEFD
S0VEKSkKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gQEAgLTIyNDYsMzAgKzIyNzYsMjIgQEAgc3RydWN0
IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAg
IAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gICAJfQo+ICAgCj4gLQl2cS0+
c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2NfYXJyYXkodnJpbmcubnVtLAo+IC0JCQlzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpLCBHRlBfS0VSTkVMKTsKPiAtCWlmICghdnEt
PnNwbGl0LmRlc2Nfc3RhdGUpCj4gLQkJZ290byBlcnJfc3RhdGU7Cj4gKwllcnIgPSBfX3ZyaW5n
X2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KHZyaW5nLm51bSwgJnN0YXRlLCAmZXh0cmEpOwo+ICsJ
aWYgKGVycikgewo+ICsJCWtmcmVlKHZxKTsKPiArCQlyZXR1cm4gTlVMTDsKPiArCX0KPiAgIAo+
IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKHZyaW5nLm51
bSk7Cj4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+IC0JCWdvdG8gZXJyX2V4dHJhOwo+
ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBzdGF0ZTsKPiArCXZxLT5zcGxpdC5kZXNjX2V4dHJh
ID0gZXh0cmE7Cj4gICAKPiAgIAkvKiBQdXQgZXZlcnl0aGluZyBpbiBmcmVlIGxpc3RzLiAqLwo+
ICAgCXZxLT5mcmVlX2hlYWQgPSAwOwo+IC0JbWVtc2V0KHZxLT5zcGxpdC5kZXNjX3N0YXRlLCAw
LCB2cmluZy5udW0gKgo+IC0JCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQp
KTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlzdF9h
ZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwo+ICAgCXNwaW5fdW5sb2NrKCZ2ZGV2
LT52cXNfbGlzdF9sb2NrKTsKPiAgIAlyZXR1cm4gJnZxLT52cTsKPiAtCj4gLWVycl9leHRyYToK
PiAtCWtmcmVlKHZxLT5zcGxpdC5kZXNjX3N0YXRlKTsKPiAtZXJyX3N0YXRlOgo+IC0Ja2ZyZWUo
dnEpOwo+IC0JcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChfX3ZyaW5n
X25ld192aXJ0cXVldWUpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
