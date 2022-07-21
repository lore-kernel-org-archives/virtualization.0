Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF1C43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 03:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AECAD84042;
	Thu, 21 Jul 2022 03:36:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AECAD84042
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCOXgnOO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gy7PjsAiIOfp; Thu, 21 Jul 2022 03:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC2FF84017;
	Thu, 21 Jul 2022 03:36:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC2FF84017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A985DC0035;
	Thu, 21 Jul 2022 03:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC7FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E434F84032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:36:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E434F84032
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T6nyYTis5Y5J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA08084017
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA08084017
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658374597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZs2MTtPJCgrF13MTLP6HwaK4P20s9o4BWWN0llGmLc=;
 b=cCOXgnOO8xmvw+LZvOOhfD76/BS0ADF+QjtgZYBEk8Eyh6cDt/NnNyz2jv4kZCu3pnbKpT
 eXKngVDK+Gj0hgYTtJiNCyFxq6oOqR7tNJFB+8FB5fAxvuvdtBwPi2q0BEhCjNZtlGNMG5
 R+X9K2RsWhf5vPk7ynjvP82NHxs4RvY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-GLAebea6OHiDFGdsECVe6Q-1; Wed, 20 Jul 2022 23:36:36 -0400
X-MC-Unique: GLAebea6OHiDFGdsECVe6Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 q12-20020a632a0c000000b00419b66851e8so294515pgq.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 20:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XZs2MTtPJCgrF13MTLP6HwaK4P20s9o4BWWN0llGmLc=;
 b=0jFnQPt/mZWSm5GHwr+VQ6an9DM1WUI8iQQEKNs6ZRSDSGSuANggjtp88UPwnzotox
 YhrH2jenpidBar9z7xNVaSJSN23zkyvXpMc5kJSSm/B1QQtVLY9VmmAvtbK8hx0MRwlw
 Q+zaP4nwEH4zscTfNGBheymQmb6HSL/aYzVJEMBqcaS1BDs+9r/0hJ9feTnR33oA1vBH
 wvSMzqU3Wgli4Vg7poJQ2A1lP7hE1gnv5cGfS+ZIEZ9i2hZ+138p2qF+DRf6XLBZwcpY
 ICNYnBFj1ZioA78NkgXEdIDe7sMfaohb58+mPkVXT+V6E5cf+D78kzF8WRpeApWfALd2
 E3lQ==
X-Gm-Message-State: AJIora86ZHv85RsWgE+HSOTDqjBzRx3+/BG8KaFxkX7iVHRKeZkRQWUT
 8SykiH+OKIa67TRl/3JBMM1yqblpRGcsRs8vPkTcbCi3wpYLW583l/lbZ8b2YfXg8lTd16LN0i3
 tvTDCIvgCrV6e4oihF3P84gGm+9RB3DrucMeSf6Rh9Q==
X-Received: by 2002:a17:903:230c:b0:16c:4c65:18be with SMTP id
 d12-20020a170903230c00b0016c4c6518bemr41221951plh.138.1658374595140; 
 Wed, 20 Jul 2022 20:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tr2BE9d26jAFZ7UzmaXmDCEYEs27OTIGhFU26HuMl2rkNob1MeYihMEZsIvqYHGU+JOzJneA==
X-Received: by 2002:a17:903:230c:b0:16c:4c65:18be with SMTP id
 d12-20020a170903230c00b0016c4c6518bemr41221903plh.138.1658374594755; 
 Wed, 20 Jul 2022 20:36:34 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x22-20020aa79416000000b005289fad1bbesm424278pfo.94.2022.07.20.20.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jul 2022 20:36:34 -0700 (PDT)
Message-ID: <ba2ae3e4-a950-6b7f-8748-c45a685bb6b0@redhat.com>
Date: Thu, 21 Jul 2022 11:36:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 01/40] virtio: record the maximum queue num supported
 by the device.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-2-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvLW5ldCBjYW4g
ZGlzcGxheSB0aGUgbWF4aW11bSAoc3VwcG9ydGVkIGJ5IGhhcmR3YXJlKSByaW5nIHNpemUgaW4K
PiBldGh0b29sIC1nIGV0aDAuCj4KPiBXaGVuIHRoZSBzdWJzZXF1ZW50IHBhdGNoIGltcGxlbWVu
dHMgdnJpbmcgcmVzZXQsIGl0IGNhbiBqdWRnZSB3aGV0aGVyCj4gdGhlIHJpbmcgc2l6ZSBwYXNz
ZWQgYnkgdGhlIGRyaXZlciBpcyBsZWdhbCBiYXNlZCBvbiB0aGlzLgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBhcmNoL3VtL2RyaXZlcnMv
dmlydGlvX3VtbC5jICAgICAgICAgICAgIHwgMSArCj4gICBkcml2ZXJzL3BsYXRmb3JtL21lbGxh
bm94L21seGJmLXRtZmlmby5jIHwgMiArKwo+ICAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXBy
b2NfdmlydGlvLmMgICB8IDIgKysKPiAgIGRyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5j
ICAgICAgICAgfCAzICsrKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyAgICAgICAg
ICAgICB8IDIgKysKPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgICAgICAg
fCAyICsrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jICAgICAgIHwgMiAr
Kwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgICAgICAgICB8IDIgKysKPiAg
IGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgICAgICAgICAgfCAyICsrCj4gICA5IGZp
bGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9hcmNoL3VtL2Ry
aXZlcnMvdmlydGlvX3VtbC5jIGIvYXJjaC91bS9kcml2ZXJzL3ZpcnRpb191bWwuYwo+IGluZGV4
IDgyZmYzNzg1YmY2OS4uZTcxOWFmOGJkZjU2IDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0vZHJpdmVy
cy92aXJ0aW9fdW1sLmMKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMvdmlydGlvX3VtbC5jCj4gQEAg
LTk1OCw2ICs5NTgsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnVfc2V0dXBfdnEoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gICAJCWdvdG8gZXJyb3JfY3JlYXRlOwo+ICAgCX0K
PiAgIAl2cS0+cHJpdiA9IGluZm87Cj4gKwl2cS0+bnVtX21heCA9IG51bTsKPiAgIAludW0gPSB2
aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodnEpOwo+ICAgCj4gICAJaWYgKHZ1X2Rldi0+cHJvdG9j
b2xfZmVhdHVyZXMgJgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21s
eGJmLXRtZmlmby5jIGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZpZm8uYwo+
IGluZGV4IDM4ODAwZTg2ZWQ4YS4uMWFlM2M1NmI2NmIwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
cGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtdG1maWZvLmMKPiArKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L21lbGxhbm94L21seGJmLXRtZmlmby5jCj4gQEAgLTk1OSw2ICs5NTksOCBAQCBzdGF0aWMgaW50
IG1seGJmX3RtZmlmb192aXJ0aW9fZmluZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
Cj4gICAJCQlnb3RvIGVycm9yOwo+ICAgCQl9Cj4gICAKPiArCQl2cS0+bnVtX21heCA9IHZyaW5n
LT5udW07Cj4gKwo+ICAgCQl2cXNbaV0gPSB2cTsKPiAgIAkJdnJpbmctPnZxID0gdnE7Cj4gICAJ
CXZxLT5wcml2ID0gdnJpbmc7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1v
dGVwcm9jX3ZpcnRpby5jIGIvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMK
PiBpbmRleCBkNDNkNzQ3MzNmMGEuLjBmNzcwNmUyM2ViOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY192aXJ0aW8uYwo+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJv
Yy9yZW1vdGVwcm9jX3ZpcnRpby5jCj4gQEAgLTEyNSw2ICsxMjUsOCBAQCBzdGF0aWMgc3RydWN0
IHZpcnRxdWV1ZSAqcnBfZmluZF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAgIAkJ
cmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gICAJfQo+ICAgCj4gKwl2cS0+bnVtX21heCA9IG51
bTsKPiArCj4gICAJcnZyaW5nLT52cSA9IHZxOwo+ICAgCXZxLT5wcml2ID0gcnZyaW5nOwo+ICAg
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jIGIvZHJpdmVy
cy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPiBpbmRleCAxNjFkM2IxNDFmMGQuLjZiODZkMDI4
MGQ2YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+ICsr
KyBiL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4gQEAgLTUzMCw2ICs1MzAsOSBA
QCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdmlydGlvX2Njd19zZXR1cF92cShzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldiwKPiAgIAkJZXJyID0gLUVOT01FTTsKPiAgIAkJZ290byBvdXRfZXJy
Owo+ICAgCX0KPiArCj4gKwl2cS0+bnVtX21heCA9IGluZm8tPm51bTsKPiArCj4gICAJLyogaXQg
bWF5IGhhdmUgYmVlbiByZWR1Y2VkICovCj4gICAJaW5mby0+bnVtID0gdmlydHF1ZXVlX2dldF92
cmluZ19zaXplKHZxKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
bW1pby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+IGluZGV4IDA4M2ZmMWViNzQz
ZC4uYTIwZDVhNmI1ODE5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlv
LmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gQEAgLTQwMyw2ICs0MDMs
OCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdm1fc2V0dXBfdnEoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbgo+ICAgCQlnb3RvIGVycm9yX25ld192aXJ0cXVl
dWU7Cj4gICAJfQo+ICAgCj4gKwl2cS0+bnVtX21heCA9IG51bTsKPiArCj4gICAJLyogQWN0aXZh
dGUgdGhlIHF1ZXVlICovCj4gICAJd3JpdGVsKHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2cSks
IHZtX2Rldi0+YmFzZSArIFZJUlRJT19NTUlPX1FVRVVFX05VTSk7Cj4gICAJaWYgKHZtX2Rldi0+
dmVyc2lvbiA9PSAxKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bGVnYWN5LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gaW5kZXggYTVl
NTcyMTE0NWM3Li4yMjU3ZjFiM2Q4YWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9sZWdhY3kuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5
LmMKPiBAQCAtMTM1LDYgKzEzNSw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpzZXR1cF92
cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiwKPiAgIAlpZiAoIXZxKQo+ICAgCQly
ZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAgIAo+ICsJdnEtPm51bV9tYXggPSBudW07Cj4gKwo+
ICAgCXFfcGZuID0gdmlydHF1ZXVlX2dldF9kZXNjX2FkZHIodnEpID4+IFZJUlRJT19QQ0lfUVVF
VUVfQUREUl9TSElGVDsKPiAgIAlpZiAocV9wZm4gPj4gMzIpIHsKPiAgIAkJZGV2X2VycigmdnBf
ZGV2LT5wY2lfZGV2LT5kZXYsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbW9kZXJuLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gaW5kZXgg
NjIzOTA2YjQ5OTZjLi5lN2UwYjhjODUwZjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm4uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuLmMKPiBAQCAtMjE4LDYgKzIxOCw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpzZXR1
cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiwKPiAgIAlpZiAoIXZxKQo+ICAg
CQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAgIAo+ICsJdnEtPm51bV9tYXggPSBudW07Cj4g
Kwo+ICAgCS8qIGFjdGl2YXRlIHRoZSBxdWV1ZSAqLwo+ICAgCXZwX21vZGVybl9zZXRfcXVldWVf
c2l6ZShtZGV2LCBpbmRleCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7Cj4gICAJdnBf
bW9kZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRy
KHZxKSwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBpbmRleCBjNDBmN2RlYjZiNWEuLjk2NzBjYzc5Mzcx
ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gKysrIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IEBAIC0xODMsNiArMTgzLDggQEAgdmlydGlvX3Zk
cGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRl
eCwKPiAgIAkJZ290byBlcnJvcl9uZXdfdmlydHF1ZXVlOwo+ICAgCX0KPiAgIAo+ICsJdnEtPm51
bV9tYXggPSBtYXhfbnVtOwo+ICsKPiAgIAkvKiBTZXR1cCB2aXJ0cXVldWUgY2FsbGJhY2sgKi8K
PiAgIAljYi5jYWxsYmFjayA9IGNhbGxiYWNrID8gdmlydGlvX3ZkcGFfdmlydHF1ZXVlX2NiIDog
TlVMTDsKPiAgIAljYi5wcml2YXRlID0gaW5mbzsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBpbmRleCBkOGZkZjE3MDYzN2Mu
LjEyOWJkZTc1MjFlMyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gKysr
IGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IEBAIC0xOSw2ICsxOSw3IEBACj4gICAgKiBAcHJp
djogYSBwb2ludGVyIGZvciB0aGUgdmlydHF1ZXVlIGltcGxlbWVudGF0aW9uIHRvIHVzZS4KPiAg
ICAqIEBpbmRleDogdGhlIHplcm8tYmFzZWQgb3JkaW5hbCBudW1iZXIgZm9yIHRoaXMgcXVldWUu
Cj4gICAgKiBAbnVtX2ZyZWU6IG51bWJlciBvZiBlbGVtZW50cyB3ZSBleHBlY3QgdG8gYmUgYWJs
ZSB0byBmaXQuCj4gKyAqIEBudW1fbWF4OiB0aGUgbWF4aW11bSBudW1iZXIgb2YgZWxlbWVudHMg
c3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2UuCj4gICAgKgo+ICAgICogQSBub3RlIG9uIEBudW1fZnJl
ZTogd2l0aCBpbmRpcmVjdCBidWZmZXJzLCBlYWNoIGJ1ZmZlciBuZWVkcyBvbmUKPiAgICAqIGVs
ZW1lbnQgaW4gdGhlIHF1ZXVlLCBvdGhlcndpc2UgYSBidWZmZXIgd2lsbCBuZWVkIG9uZSBlbGVt
ZW50IHBlcgo+IEBAIC0zMSw2ICszMiw3IEBAIHN0cnVjdCB2aXJ0cXVldWUgewo+ICAgCXN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ICAgCXVuc2lnbmVkIGludCBpbmRleDsKPiAgIAl1bnNp
Z25lZCBpbnQgbnVtX2ZyZWU7Cj4gKwl1bnNpZ25lZCBpbnQgbnVtX21heDsKPiAgIAl2b2lkICpw
cml2Owo+ICAgfTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
