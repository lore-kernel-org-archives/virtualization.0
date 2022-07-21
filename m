Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EDBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 07:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA14360E45;
	Thu, 21 Jul 2022 07:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA14360E45
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZlQnGerN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZ_KYgeeTl2q; Thu, 21 Jul 2022 07:07:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2387160A90;
	Thu, 21 Jul 2022 07:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2387160A90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9749C0035;
	Thu, 21 Jul 2022 07:07:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67FCAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 340C98143D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 340C98143D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZlQnGerN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zpSAqW_49oP1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:07:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2909F8143C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2909F8143C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658387251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2P/fakD309VXAoVD6j5x51+KtbA6fMKZfHVhcOwNC8=;
 b=ZlQnGerNEzdv0Fx+rDh7cNjRe2blhHXMwJFZe/UyC7IPNokRVUpdIQ3z+T3SvqDmSJAXRn
 Ae9ay2oXjv/a9qS42Mm1SehJVr+P1hwQJygY8MRXFhkOckDeDwwSSnJrhBhuSlJ4fvAr6d
 fk03dk41MeWnXMB0FKBtnDKadf0fdgQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-OvtifnBTPgecmchAxJrRxw-1; Thu, 21 Jul 2022 03:07:28 -0400
X-MC-Unique: OvtifnBTPgecmchAxJrRxw-1
Received: by mail-pf1-f200.google.com with SMTP id
 x34-20020a056a000be200b0052b7f102681so471686pfu.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 00:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=p2P/fakD309VXAoVD6j5x51+KtbA6fMKZfHVhcOwNC8=;
 b=g3geI50Y5YPYkczSoqq/6RKymHz95X9qeUZX1J/vfFSUAPz6cnKxU169sBqCxP5BlV
 rlFu8zfS5+02ENQImRQ2pbbdW7VvYuNdiQP7NJ6RU9HqqIyFFZcWMQcdNZLsMSEA7ImA
 qT0BrQ6HPevMuX1ShgWY57OBXwbDkLRI9yFYUcNES9BzXctUhg8azntCN2BngxVkTqkE
 ebW2pm2DhN0Az6sHsQxDBrLxFHs1bFec5LyxuxjdQUCW3UnMnfK5QGE9/jwiurvgpjcS
 x/eO0PTyi6iAp6g7MVM5x44XeCETlkoPIpfEtuc4/VX6OGq7vTkMdYiGpSc8yMNJhI5M
 5RLw==
X-Gm-Message-State: AJIora/wu1wvm9GbjT0VF2d9vF1VYtq8ypliQ1pWfhZN6oQQ+RjlxV4v
 oxluB3trpxX2vLEuKFCIMkgwsX7uOiVXEDD/tM7Fli5R7noz7HgxdhqjvdWv0r2RnxJlTi+spV9
 vWMQ2Ch7gdLouFUxOiw8AxFJex81ivXNSZB8YyNNblA==
X-Received: by 2002:a05:6a00:1a:b0:52a:dec1:308c with SMTP id
 h26-20020a056a00001a00b0052adec1308cmr43027999pfk.52.1658387247181; 
 Thu, 21 Jul 2022 00:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tK0/eD/GljWYSBQ/IjcruuC00jeXyMoir/L48eboBrwPVAnyIj6/ptwUKz85QkGsmF8udXGg==
X-Received: by 2002:a05:6a00:1a:b0:52a:dec1:308c with SMTP id
 h26-20020a056a00001a00b0052adec1308cmr43027959pfk.52.1658387246593; 
 Thu, 21 Jul 2022 00:07:26 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170903110900b0016cf3f124e5sm826885plh.131.2022.07.21.00.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 00:07:25 -0700 (PDT)
Message-ID: <7753fdae-839c-dbdf-7d24-2db2627c27aa@redhat.com>
Date: Thu, 21 Jul 2022 15:07:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 06/40] virtio_ring: introduce virtqueue_init()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-7-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIHZpcnRxdWV1ZSBpbml0aWFsaXphdGlvbi4gVGhpcyBsb2dpYyBpcyBpcnJlbGV2YW50
Cj4gdG8gcmluZyBsYXlvdXQuCj4KPiBUaGlzIGxvZ2ljIGNhbiBiZSBjYWxsZWQgaW5kZXBlbmRl
bnRseSB3aGVuIGltcGxlbWVudGluZyByZXNpemUvcmVzZXQKPiBsYXRlci4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCA2MSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDFiYzU3OTRlOTczOS4uODdjZTE3NTYyYjI5IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTM2OCw2ICszNjgsMzQgQEAgc3RhdGljIGludCB2
cmluZ19tYXBwaW5nX2Vycm9yKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAg
CXJldHVybiBkbWFfbWFwcGluZ19lcnJvcih2cmluZ19kbWFfZGV2KHZxKSwgYWRkcik7Cj4gICB9
Cj4gICAKPiArc3RhdGljIHZvaWQgdmlydHF1ZXVlX2luaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsIHUzMiBudW0pCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ICsK
PiArCXZkZXYgPSB2cS0+dnEudmRldjsKPiArCj4gKwl2cS0+dnEubnVtX2ZyZWUgPSBudW07Cj4g
KwlpZiAodnEtPnBhY2tlZF9yaW5nKQo+ICsJCXZxLT5sYXN0X3VzZWRfaWR4ID0gMCB8ICgxIDw8
IFZSSU5HX1BBQ0tFRF9FVkVOVF9GX1dSQVBfQ1RSKTsKPiArCWVsc2UKPiArCQl2cS0+bGFzdF91
c2VkX2lkeCA9IDA7Cj4gKwl2cS0+ZXZlbnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gKwl2cS0+bnVt
X2FkZGVkID0gMDsKPiArCXZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYp
Owo+ICsjaWZkZWYgREVCVUcKPiArCXZxLT5pbl91c2UgPSBmYWxzZTsKPiArCXZxLT5sYXN0X2Fk
ZF90aW1lX3ZhbGlkID0gZmFsc2U7Cj4gKyNlbmRpZgo+ICsKPiArCXZxLT5ldmVudCA9IHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCk7Cj4gKwo+ICsJaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gKwkJ
dnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPiArCj4gKwkvKiBQdXQgZXZlcnl0aGluZyBpbiBm
cmVlIGxpc3RzLiAqLwo+ICsJdnEtPmZyZWVfaGVhZCA9IDA7Cj4gK30KPiArCj4gICAKPiAgIC8q
Cj4gICAgKiBTcGxpdCByaW5nIHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfc3BsaXQoKS4KPiBAQCAt
MTcwNiw3ICsxNzM0LDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfcGFja2VkKAo+ICAgCXZxLT52cS5jYWxsYmFjayA9IGNhbGxiYWNrOwo+ICAgCXZx
LT52cS52ZGV2ID0gdmRldjsKPiAgIAl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gLQl2cS0+dnEubnVt
X2ZyZWUgPSBudW07Cj4gICAJdnEtPnZxLmluZGV4ID0gaW5kZXg7Cj4gICAJdnEtPndlX293bl9y
aW5nID0gdHJ1ZTsKPiAgIAl2cS0+bm90aWZ5ID0gbm90aWZ5Owo+IEBAIC0xNzE2LDIyICsxNzQz
LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Bh
Y2tlZCgKPiAgICNlbHNlCj4gICAJdnEtPmJyb2tlbiA9IGZhbHNlOwo+ICAgI2VuZGlmCj4gLQl2
cS0+bGFzdF91c2VkX2lkeCA9IDAgfCAoMSA8PCBWUklOR19QQUNLRURfRVZFTlRfRl9XUkFQX0NU
Uik7Cj4gLQl2cS0+ZXZlbnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gLQl2cS0+bnVtX2FkZGVkID0g
MDsKPiAgIAl2cS0+cGFja2VkX3JpbmcgPSB0cnVlOwo+IC0JdnEtPnVzZV9kbWFfYXBpID0gdnJp
bmdfdXNlX2RtYV9hcGkodmRldik7Cj4gLSNpZmRlZiBERUJVRwo+IC0JdnEtPmluX3VzZSA9IGZh
bHNlOwo+IC0JdnEtPmxhc3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxzZTsKPiAtI2VuZGlmCj4gICAK
PiAgIAl2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdf
Rl9JTkRJUkVDVF9ERVNDKSAmJgo+ICAgCQkhY29udGV4dDsKPiAtCXZxLT5ldmVudCA9IHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCk7Cj4gLQo+IC0JaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkpCj4gLQkJ
dnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPiAgIAo+ICAgCXZxLT5wYWNrZWQucmluZ19kbWFf
YWRkciA9IHJpbmdfZG1hX2FkZHI7Cj4gICAJdnEtPnBhY2tlZC5kcml2ZXJfZXZlbnRfZG1hX2Fk
ZHIgPSBkcml2ZXJfZXZlbnRfZG1hX2FkZHI7Cj4gQEAgLTE3NTksOCArMTc3NCw3IEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAlt
ZW1zZXQodnEtPnBhY2tlZC5kZXNjX3N0YXRlLCAwLAo+ICAgCQludW0gKiBzaXplb2Yoc3RydWN0
IHZyaW5nX2Rlc2Nfc3RhdGVfcGFja2VkKSk7Cj4gICAKPiAtCS8qIFB1dCBldmVyeXRoaW5nIGlu
IGZyZWUgbGlzdHMuICovCj4gLQl2cS0+ZnJlZV9oZWFkID0gMDsKPiArCXZpcnRxdWV1ZV9pbml0
KHZxLCBudW0pOwo+ICAgCj4gICAJdnEtPnBhY2tlZC5kZXNjX2V4dHJhID0gdnJpbmdfYWxsb2Nf
ZGVzY19leHRyYShudW0pOwo+ICAgCWlmICghdnEtPnBhY2tlZC5kZXNjX2V4dHJhKQo+IEBAIC0y
MjA1LDcgKzIyMTksNiBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUo
dW5zaWduZWQgaW50IGluZGV4LAo+ICAgCXZxLT52cS5jYWxsYmFjayA9IGNhbGxiYWNrOwo+ICAg
CXZxLT52cS52ZGV2ID0gdmRldjsKPiAgIAl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gLQl2cS0+dnEu
bnVtX2ZyZWUgPSB2cmluZy5udW07Cj4gICAJdnEtPnZxLmluZGV4ID0gaW5kZXg7Cj4gICAJdnEt
PndlX293bl9yaW5nID0gZmFsc2U7Cj4gICAJdnEtPm5vdGlmeSA9IG5vdGlmeTsKPiBAQCAtMjIx
NSwyMSArMjIyOCw5IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAjZWxzZQo+ICAgCXZxLT5icm9rZW4gPSBmYWxzZTsKPiAg
ICNlbmRpZgo+IC0JdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+IC0JdnEtPmV2ZW50X3RyaWdnZXJl
ZCA9IGZhbHNlOwo+IC0JdnEtPm51bV9hZGRlZCA9IDA7Cj4gLQl2cS0+dXNlX2RtYV9hcGkgPSB2
cmluZ191c2VfZG1hX2FwaSh2ZGV2KTsKPiAtI2lmZGVmIERFQlVHCj4gLQl2cS0+aW5fdXNlID0g
ZmFsc2U7Cj4gLQl2cS0+bGFzdF9hZGRfdGltZV92YWxpZCA9IGZhbHNlOwo+IC0jZW5kaWYKPiAg
IAo+ICAgCXZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklO
R19GX0lORElSRUNUX0RFU0MpICYmCj4gICAJCSFjb250ZXh0Owo+IC0JdnEtPmV2ZW50ID0gdmly
dGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYKTsKPiAtCj4gLQlp
ZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX09SREVSX1BMQVRGT1JNKSkKPiAt
CQl2cS0+d2Vha19iYXJyaWVycyA9IGZhbHNlOwo+ICAgCj4gICAJdnEtPnNwbGl0LnF1ZXVlX2Rt
YV9hZGRyID0gMDsKPiAgIAl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IDA7Cj4gQEAg
LTIyNTUsMTEgKzIyNTYsMTEgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1
ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+
ICAgCQlnb3RvIGVycl9leHRyYTsKPiAgIAo+IC0JLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBs
aXN0cy4gKi8KPiAtCXZxLT5mcmVlX2hlYWQgPSAwOwo+ICAgCW1lbXNldCh2cS0+c3BsaXQuZGVz
Y19zdGF0ZSwgMCwgdnJpbmcubnVtICoKPiAgIAkJCXNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19z
dGF0ZV9zcGxpdCkpOwo+ICAgCj4gKwl2aXJ0cXVldWVfaW5pdCh2cSwgdnEtPnNwbGl0LnZyaW5n
Lm51bSk7Cj4gKwo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlz
dF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwo+ICAgCXNwaW5fdW5sb2NrKCZ2
ZGV2LT52cXNfbGlzdF9sb2NrKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
