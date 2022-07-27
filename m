Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC2C19F2C
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67F03403D6;
	Wed, 27 Jul 2022 04:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67F03403D6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=huqhHaiK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q8Eh_SP3Plqy; Wed, 27 Jul 2022 04:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF19E4039D;
	Wed, 27 Jul 2022 04:29:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF19E4039D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92569C0035;
	Wed, 27 Jul 2022 04:29:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1663EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1D7660AB3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D7660AB3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=huqhHaiK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IMwGZcLblwc5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF6D460AB1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF6D460AB1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3R1yCR4JjKjOL2e44LtMos911qHy0R24gXLvjAAiWw=;
 b=huqhHaiKIe9msZ9SdjhFmrYyyy3nsnEczEYgqzsT1Fvam23o5dCG0SMeajtUNiX7p2NL0N
 Ae6XPk0FqyEpccRPgQ+88hRpYYwtDwDgmdL5bEh4ucxeeGMVGzsCFhO0ACmc1WuwCMd42T
 6fFJ0VucxZTU7a6n4IHBS4VtTzrSCQc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-gPWVzHmeNOmDtMf-W8KdWw-1; Wed, 27 Jul 2022 00:29:53 -0400
X-MC-Unique: gPWVzHmeNOmDtMf-W8KdWw-1
Received: by mail-pg1-f200.google.com with SMTP id
 u11-20020a654c0b000000b00415ed4acf16so7356850pgq.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=m3R1yCR4JjKjOL2e44LtMos911qHy0R24gXLvjAAiWw=;
 b=m7TgeunNWLUYY/ZGxnWOAgJZmhGH+GYvKyRNuInxF5bjY9e6UQCubQzUxSgO5Lh4En
 PorhRNADCmfqR228G3Ij7j+CK2+NOoD/AF3CPGp1bSdTJkih6aPneMqK4T1oy0y0q4mF
 ZzTRfdfrwsFg3tmSpNmzmB2V5+U/tfDaNeQwOj5aJrFz6rN7rBHnTWixZKMiouAl9ZiM
 BQg6cSGUfeGZOMWE9jFNGvj9ooxMUtcegH8XvP3Ou93Dk2CXWvhfFnMdVB6zeHGurzce
 fQcsW2Vj9Ydbtp/AdARuVtlCPE/mKTjfmQHTyp0xHZMT7cAsyzDp4QyxFbNxE1hqOXDT
 RlvQ==
X-Gm-Message-State: AJIora+EEJPy9EIczsohPC/U9ZhidMz0luVBjixAFl01D3Xv9SBefDPe
 2bz+2wa5yzHc/IfYY0yAZtVEwfBFuVHM270UbfFxoDDJELiu3Vs2Us8KZiW/kdnYFFqB3IGueLS
 oIvL/IpcjBufkN7yxuEMJWYCSBQyJrjlYjhUbJFVFgA==
X-Received: by 2002:a62:29c3:0:b0:52b:f774:7242 with SMTP id
 p186-20020a6229c3000000b0052bf7747242mr12643013pfp.67.1658896192594; 
 Tue, 26 Jul 2022 21:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJEmlIFJw4XLwcoDuJY/DA3iRQl4vi72zW5Nqvakm1GQ10IUCcyGSf9WmnEO/2tbD5Ja9IXw==
X-Received: by 2002:a62:29c3:0:b0:52b:f774:7242 with SMTP id
 p186-20020a6229c3000000b0052bf7747242mr12642976pfp.67.1658896192306; 
 Tue, 26 Jul 2022 21:29:52 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090abf8400b001f10b31e7a7sm469679pjs.32.2022.07.26.21.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:29:51 -0700 (PDT)
Message-ID: <4de63999-2c35-3208-709b-2a67d696fec6@redhat.com>
Date: Wed, 27 Jul 2022 12:29:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 18/42] virtio_ring: packed: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-19-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-19-xuanzhuo@linux.alibaba.com>
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
Z2ljIG9mIHBhY2tlZCB0byBjcmVhdGUgdnJpbmcgcXVldWUuCj4KPiBUaGlzIGZlYXR1cmUgaXMg
cmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVxdWV1ZSByZXNldCB2cmluZy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCA4MCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDg5MTkwMGIzMWMzZC4uMTBjYzJiN2UzNTg4
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE4NTcsMTkgKzE4NTcsMTAgQEAgc3RhdGlj
IHZvaWQgdnJpbmdfZnJlZV9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9wYWNrZWQgKnZy
aW5nX3BhY2tlZCwKPiAgIAlrZnJlZSh2cmluZ19wYWNrZWQtPmRlc2NfZXh0cmEpOwo+ICAgfQo+
ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Bh
Y2tlZCgKPiAtCXVuc2lnbmVkIGludCBpbmRleCwKPiAtCXVuc2lnbmVkIGludCBudW0sCj4gLQl1
bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gLQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwK
PiAtCWJvb2wgd2Vha19iYXJyaWVycywKPiAtCWJvb2wgbWF5X3JlZHVjZV9udW0sCj4gLQlib29s
IGNvbnRleHQsCj4gLQlib29sICgqbm90aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+IC0Jdm9p
ZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+IC0JY29uc3QgY2hhciAqbmFtZSkK
PiArc3RhdGljIGludCB2cmluZ19hbGxvY19xdWV1ZV9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZV9wYWNrZWQgKnZyaW5nX3BhY2tlZCwKPiArCQkJCSAgICBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiwKPiArCQkJCSAgICB1MzIgbnVtKQo+ICAgewo+IC0Jc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnE7Cj4gICAJc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICpyaW5nOwo+ICAgCXN0cnVj
dCB2cmluZ19wYWNrZWRfZGVzY19ldmVudCAqZHJpdmVyLCAqZGV2aWNlOwo+ICAgCWRtYV9hZGRy
X3QgcmluZ19kbWFfYWRkciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRyLCBkZXZpY2VfZXZlbnRfZG1h
X2FkZHI7Cj4gQEAgLTE4ODEsNyArMTg3MiwxMSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAq
dnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICAJCQkJICZyaW5nX2RtYV9hZGRyLAo+
ICAgCQkJCSBHRlBfS0VSTkVMfF9fR0ZQX05PV0FSTnxfX0dGUF9aRVJPKTsKPiAgIAlpZiAoIXJp
bmcpCj4gLQkJZ290byBlcnJfcmluZzsKPiArCQlnb3RvIGVycjsKPiArCj4gKwl2cmluZ19wYWNr
ZWQtPnZyaW5nLmRlc2MgICAgICAgICA9IHJpbmc7Cj4gKwl2cmluZ19wYWNrZWQtPnJpbmdfZG1h
X2FkZHIgICAgICA9IHJpbmdfZG1hX2FkZHI7Cj4gKwl2cmluZ19wYWNrZWQtPnJpbmdfc2l6ZV9p
bl9ieXRlcyA9IHJpbmdfc2l6ZV9pbl9ieXRlczsKPiAgIAo+ICAgCWV2ZW50X3NpemVfaW5fYnl0
ZXMgPSBzaXplb2Yoc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjX2V2ZW50KTsKPiAgIAo+IEBAIC0x
ODg5LDEzICsxODg0LDQ3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVf
dmlydHF1ZXVlX3BhY2tlZCgKPiAgIAkJCQkgICAmZHJpdmVyX2V2ZW50X2RtYV9hZGRyLAo+ICAg
CQkJCSAgIEdGUF9LRVJORUx8X19HRlBfTk9XQVJOfF9fR0ZQX1pFUk8pOwo+ICAgCWlmICghZHJp
dmVyKQo+IC0JCWdvdG8gZXJyX2RyaXZlcjsKPiArCQlnb3RvIGVycjsKPiArCj4gKwl2cmluZ19w
YWNrZWQtPnZyaW5nLmRyaXZlciAgICAgICAgICA9IGRyaXZlcjsKPiArCXZyaW5nX3BhY2tlZC0+
ZXZlbnRfc2l6ZV9pbl9ieXRlcyAgID0gZXZlbnRfc2l6ZV9pbl9ieXRlczsKPiArCXZyaW5nX3Bh
Y2tlZC0+ZHJpdmVyX2V2ZW50X2RtYV9hZGRyID0gZHJpdmVyX2V2ZW50X2RtYV9hZGRyOwo+ICAg
Cj4gICAJZGV2aWNlID0gdnJpbmdfYWxsb2NfcXVldWUodmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRl
cywKPiAgIAkJCQkgICAmZGV2aWNlX2V2ZW50X2RtYV9hZGRyLAo+ICAgCQkJCSAgIEdGUF9LRVJO
RUx8X19HRlBfTk9XQVJOfF9fR0ZQX1pFUk8pOwo+ICAgCWlmICghZGV2aWNlKQo+IC0JCWdvdG8g
ZXJyX2RldmljZTsKPiArCQlnb3RvIGVycjsKPiArCj4gKwl2cmluZ19wYWNrZWQtPnZyaW5nLmRl
dmljZSAgICAgICAgICA9IGRldmljZTsKPiArCXZyaW5nX3BhY2tlZC0+ZGV2aWNlX2V2ZW50X2Rt
YV9hZGRyID0gZGV2aWNlX2V2ZW50X2RtYV9hZGRyOwo+ICsKPiArCXZyaW5nX3BhY2tlZC0+dnJp
bmcubnVtID0gbnVtOwo+ICsKPiArCXJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsJdnJpbmdfZnJl
ZV9wYWNrZWQodnJpbmdfcGFja2VkLCB2ZGV2KTsKPiArCXJldHVybiAtRU5PTUVNOwo+ICt9Cj4g
Kwo+ICtzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNr
ZWQoCj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJdW5z
aWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4g
Kwlib29sIHdlYWtfYmFycmllcnMsCj4gKwlib29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9vbCBj
b250ZXh0LAo+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZvaWQg
KCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4g
K3sKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkIHZyaW5nX3BhY2tlZCA9IHt9Owo+
ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gKwo+ICsJaWYgKHZyaW5nX2FsbG9jX3F1
ZXVlX3BhY2tlZCgmdnJpbmdfcGFja2VkLCB2ZGV2LCBudW0pKQo+ICsJCWdvdG8gZXJyX3Jpbmc7
Cj4gICAKPiAgIAl2cSA9IGttYWxsb2Moc2l6ZW9mKCp2cSksIEdGUF9LRVJORUwpOwo+ICAgCWlm
ICghdnEpCj4gQEAgLTE5MTgsMTcgKzE5NDcsMTQgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUg
KnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAgCXZxLT5pbmRpcmVjdCA9IHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpICYmCj4gICAJ
CSFjb250ZXh0Owo+ICAgCj4gLQl2cS0+cGFja2VkLnJpbmdfZG1hX2FkZHIgPSByaW5nX2RtYV9h
ZGRyOwo+IC0JdnEtPnBhY2tlZC5kcml2ZXJfZXZlbnRfZG1hX2FkZHIgPSBkcml2ZXJfZXZlbnRf
ZG1hX2FkZHI7Cj4gLQl2cS0+cGFja2VkLmRldmljZV9ldmVudF9kbWFfYWRkciA9IGRldmljZV9l
dmVudF9kbWFfYWRkcjsKPiArCXZxLT5wYWNrZWQucmluZ19kbWFfYWRkciA9IHZyaW5nX3BhY2tl
ZC5yaW5nX2RtYV9hZGRyOwo+ICsJdnEtPnBhY2tlZC5kcml2ZXJfZXZlbnRfZG1hX2FkZHIgPSB2
cmluZ19wYWNrZWQuZHJpdmVyX2V2ZW50X2RtYV9hZGRyOwo+ICsJdnEtPnBhY2tlZC5kZXZpY2Vf
ZXZlbnRfZG1hX2FkZHIgPSB2cmluZ19wYWNrZWQuZGV2aWNlX2V2ZW50X2RtYV9hZGRyOwo+ICAg
Cj4gLQl2cS0+cGFja2VkLnJpbmdfc2l6ZV9pbl9ieXRlcyA9IHJpbmdfc2l6ZV9pbl9ieXRlczsK
PiAtCXZxLT5wYWNrZWQuZXZlbnRfc2l6ZV9pbl9ieXRlcyA9IGV2ZW50X3NpemVfaW5fYnl0ZXM7
Cj4gKwl2cS0+cGFja2VkLnJpbmdfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nX3BhY2tlZC5yaW5nX3Np
emVfaW5fYnl0ZXM7Cj4gKwl2cS0+cGFja2VkLmV2ZW50X3NpemVfaW5fYnl0ZXMgPSB2cmluZ19w
YWNrZWQuZXZlbnRfc2l6ZV9pbl9ieXRlczsKPiAgIAo+IC0JdnEtPnBhY2tlZC52cmluZy5udW0g
PSBudW07Cj4gLQl2cS0+cGFja2VkLnZyaW5nLmRlc2MgPSByaW5nOwo+IC0JdnEtPnBhY2tlZC52
cmluZy5kcml2ZXIgPSBkcml2ZXI7Cj4gLQl2cS0+cGFja2VkLnZyaW5nLmRldmljZSA9IGRldmlj
ZTsKPiArCXZxLT5wYWNrZWQudnJpbmcgPSB2cmluZ19wYWNrZWQudnJpbmc7Cj4gICAKPiAgIAl2
cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4ID0gMDsKPiAgIAl2cS0+cGFja2VkLmF2YWlsX3dyYXBf
Y291bnRlciA9IDE7Cj4gQEAgLTE5NjcsMTEgKzE5OTMsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRx
dWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICBlcnJfZGVzY19zdGF0ZToK
PiAgIAlrZnJlZSh2cSk7Cj4gICBlcnJfdnE6Cj4gLQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIGV2
ZW50X3NpemVfaW5fYnl0ZXMsIGRldmljZSwgZGV2aWNlX2V2ZW50X2RtYV9hZGRyKTsKPiAtZXJy
X2RldmljZToKPiAtCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgZXZlbnRfc2l6ZV9pbl9ieXRlcywg
ZHJpdmVyLCBkcml2ZXJfZXZlbnRfZG1hX2FkZHIpOwo+IC1lcnJfZHJpdmVyOgo+IC0JdnJpbmdf
ZnJlZV9xdWV1ZSh2ZGV2LCByaW5nX3NpemVfaW5fYnl0ZXMsIHJpbmcsIHJpbmdfZG1hX2FkZHIp
Owo+ICsJdnJpbmdfZnJlZV9wYWNrZWQoJnZyaW5nX3BhY2tlZCwgdmRldik7Cj4gICBlcnJfcmlu
ZzoKPiAgIAlyZXR1cm4gTlVMTDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
