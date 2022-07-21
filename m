Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B043EC43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 03:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D4F2612F9;
	Thu, 21 Jul 2022 03:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D4F2612F9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzjjwtQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9IUyfxCwYdWn; Thu, 21 Jul 2022 03:39:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B56FA60B95;
	Thu, 21 Jul 2022 03:39:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B56FA60B95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C79CC0035;
	Thu, 21 Jul 2022 03:39:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA13C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D2BD4089E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D2BD4089E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzjjwtQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j1CfDKypHxCE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 018AD4087B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 018AD4087B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 03:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658374773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/J4B4qcC/O6PCOtnZhz1fVwUIt6mfKVcFfx+S26Hn1w=;
 b=PzjjwtQAOq2sS3wdzhV1HjWPBaASbS944qdfw8GTnGcyK1lIYmzfa9pzKF3iML09NBH7tU
 nxY+JW+u++S1IylLlRz2TiZrDsONOsfN2JEqW7fRj8hFB1dkoaft/PqcxrlZXG8/63VDID
 T8G6cGT+91j1gCJbopZdVO7BIIcWBh0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-L7lpElQxPYmHvcQ7ZAbe2g-1; Wed, 20 Jul 2022 23:39:32 -0400
X-MC-Unique: L7lpElQxPYmHvcQ7ZAbe2g-1
Received: by mail-pf1-f199.google.com with SMTP id
 r7-20020aa79627000000b00528beaf82c3so270276pfg.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 20:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/J4B4qcC/O6PCOtnZhz1fVwUIt6mfKVcFfx+S26Hn1w=;
 b=3+yVqN92dBg20G/tvzmIeIa0NTNNWg8p4cODuS+RUBCVbIFoNbQ0xWM4joCF+zdjRi
 0+TLJebM/2Pb/bTU05q+lGdwOQYProlTfVm4K37Oq3dWhLvtx/X9m2aw18Qg2zVhgvED
 tWE5ylGW9dWwTeQPvxXW1TmfGJCOqSjd4+FIudL2raXFV31Q7pg976ek4/+iusO/N8SB
 bEUID/DYhWzChwkv+E2Z0NwcQVyi8XXTbNRXx7OxpA5NzibpNHZI6nYN8O30JSn2y48h
 EY5pTuQCK18HjS9M14tcB6PLtQmz3cW7aSrXqjpCVmxAGWcKw7x9PV5rB1c0rNgsLjxY
 2jyQ==
X-Gm-Message-State: AJIora9KlAyfV0Cq0lP9waxgLzWVYpJWesli5tGs2YlR6/DuM+422DYX
 bk8vjqexbMAvzLuTVakjNDlcAHOs/H7xRcvNnLP++46GqBi3tAkb0v3oBe4L63YYYeglFPktb8U
 D49xYYOmfvkuEkU0bK606bzmPmwdgQ5Z/WJoN9aiY0g==
X-Received: by 2002:a17:902:6943:b0:16c:ba81:1842 with SMTP id
 k3-20020a170902694300b0016cba811842mr34513142plt.24.1658374770939; 
 Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1VrQwD/Z1oboj3J8gyT4oRNKMLENwwF8aDJAS3C/huxjXfcUqUKDMCERwkdW74rqe0+fCQA==
X-Received: by 2002:a17:902:6943:b0:16c:ba81:1842 with SMTP id
 k3-20020a170902694300b0016cba811842mr34513102plt.24.1658374770599; 
 Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 v12-20020aa799cc000000b00528f9597fb3sm401825pfi.197.2022.07.20.20.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
Message-ID: <226ab2d4-0b3f-3a18-bed4-be5d278d2069@redhat.com>
Date: Thu, 21 Jul 2022 11:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gcmVzZXQgY2FuIGJlIGRp
dmlkZWQgaW50byB0aGUgZm9sbG93aW5nIGZvdXIgc3RlcHMgKGV4YW1wbGUpOgo+ICAgMS4gdHJh
bnNwb3J0OiBub3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiAgIDIuIHZyaW5n
OiAgICAgcmVjeWNsZSB0aGUgYnVmZmVyIHN1Ym1pdHRlZAo+ICAgMy4gdnJpbmc6ICAgICByZXNl
dC9yZXNpemUgdGhlIHZyaW5nIChtYXkgcmUtYWxsb2MpCj4gICA0LiB0cmFuc3BvcnQ6IG1tYXAg
dnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+Cj4gSW4gb3JkZXIgdG8gc3Vw
cG9ydCBxdWV1ZSByZXNldCwgYWRkIHR3byBjYWxsYmFja3MgaW4gc3RydWN0Cj4gdmlydGlvX2Nv
bmZpZ19vcHMgdG8gaW1wbGVtZW50IHN0ZXBzIDEgYW5kIDQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaCB8IDE0ICsrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCBiNDdjMmU3ZWQwZWUuLjM2
ZWM3YmUxZjQ4MCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTc4LDYgKzc4LDE4IEBA
IHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gICAgKiBAc2V0X3ZxX2FmZmluaXR5OiBzZXQg
dGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ICAgICogQGdldF92cV9h
ZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPiAg
ICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24g
dGhlIGluZGV4Lgo+ICsgKiBAZGlzYWJsZV92cV9hbmRfcmVzZXQ6IHJlc2V0IGEgcXVldWUgaW5k
aXZpZHVhbGx5IChvcHRpb25hbCkuCj4gKyAqCXZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCVJldHVy
bnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIHN0YXR1cwo+ICsgKglkaXNhYmxlX3ZxX2FuZF9yZXNl
dCB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBjYWxsYmFja3MgYXJlIGRpc2FibGVkIGFuZAo+ICsg
KglzeW5jaHJvbml6ZWQuCj4gKyAqCUV4Y2VwdCBmb3IgdGhlIGNhbGxiYWNrLCB0aGUgY2FsbGVy
IHNob3VsZCBndWFyYW50ZWUgdGhhdCB0aGUgdnJpbmcgaXMKPiArICoJbm90IGFjY2Vzc2VkIGJ5
IGFueSBmdW5jdGlvbnMgb2YgdmlydHF1ZXVlLgo+ICsgKiBAZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0
OiBlbmFibGUgYSByZXNldCBxdWV1ZQo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKglSZXR1
cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiArICoJSWYgZGlzYWJsZV92cV9hbmRf
cmVzZXQgaXMgc2V0LCB0aGVuIGVuYWJsZV92cV9hZnRlcl9yZXNldCBtdXN0IGFsc28gYmUKPiAr
ICoJc2V0Lgo+ICAgICovCj4gICB0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3Qgdmly
dHF1ZXVlICopOwo+ICAgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPiBAQCAtMTA0LDYgKzEx
Niw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gICAJCQlpbnQgaW5kZXgpOwo+ICAg
CWJvb2wgKCpnZXRfc2htX3JlZ2lvbikoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gICAJ
CQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdpb24sIHU4IGlkKTsKPiArCWlu
dCAoKmRpc2FibGVfdnFfYW5kX3Jlc2V0KShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gKwlpbnQg
KCplbmFibGVfdnFfYWZ0ZXJfcmVzZXQpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIH07Cj4g
ICAKPiAgIC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxs
IG5ldmVyIGFwcGVhci4gKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
