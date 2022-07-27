Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F0C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DDC2402E2;
	Wed, 27 Jul 2022 04:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DDC2402E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBgkWJXa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLSgT8WdFk4t; Wed, 27 Jul 2022 04:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2A1340193;
	Wed, 27 Jul 2022 04:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2A1340193
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB549C0035;
	Wed, 27 Jul 2022 04:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB649C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9361B60AB1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9361B60AB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBgkWJXa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NId7wfIw13N5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B595360601
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B595360601
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ccV224xkXshDy5Rfnr1IHUz5X0tm4nlYhk3kCg3nne0=;
 b=FBgkWJXark6qkOI/3B4NoTJSD2/QlRCtzVF6FO9t+CTzcjeCAqnGrdB9VLbPMC7MNU/PqL
 umd9SabxjtpTU5+pPB8CwUP90RRqbSNOO1pdEna7B5pMTti0H13SpfCpJC/JEaF+imD+vx
 X4lpnj4C+k9l49bCaXPVmP9LjyV7ZoM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-fvKDhqsfMpSajTvvtUrJaQ-1; Wed, 27 Jul 2022 00:34:48 -0400
X-MC-Unique: fvKDhqsfMpSajTvvtUrJaQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 j10-20020a62b60a000000b0052b30f6626bso5518698pff.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ccV224xkXshDy5Rfnr1IHUz5X0tm4nlYhk3kCg3nne0=;
 b=p2nc1Hwytacm2IEjurddpwh5m4tiD6ZGdseH8Nux484Xn3TMH2gPPSpx7wIrlft6BR
 n+hVPtQ2cFAROqWg//1FgRQ7XU50I54wfZS5qVhxEU/8+MCN1z39dEjrmNG2p4JGoIZU
 TulwIaBtgqPaMhQ+Jf8DjAZfb/1a0mAELbXcr3OvT4LRG5DyTicA32FHONXsWtoW23Xq
 FzXhyXQ2UD8A9DiuR/rXJQM1AGINkz/M6xcv4eWbYX1n85vkctWyAX+dXrqkt73F7ntI
 6nCtlKOZJraUQK+O/SR3mO2JXs7p2XHB0jSi1Zfm8cwliSKpHknl6pxCzeWpKvl5yA+9
 o4tQ==
X-Gm-Message-State: AJIora9qMM/y6YBVLL1ubmlg8PIqT3YhZc2liQcUKiA7fHbC3neojWKm
 BQhHBMVbLMwBvnBg+13iCysBzKStoWYNno5g62pnLXc7pQUNSPpg70sK4X/OCrL9xse8V5HjIKi
 Xj28VqifVNM8e2HPBP9nnHS3tHzF16tNLYZFPHlwqyg==
X-Received: by 2002:a63:d64e:0:b0:41a:b83d:1b2a with SMTP id
 d14-20020a63d64e000000b0041ab83d1b2amr15478512pgj.122.1658896487305; 
 Tue, 26 Jul 2022 21:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/FJ74Zcl7b0UCclD3iCK7AwYJZlRdXpyiM8TPXcthnYH8m/z4m9rgQ1C6aXiOk5BimF8JNw==
X-Received: by 2002:a63:d64e:0:b0:41a:b83d:1b2a with SMTP id
 d14-20020a63d64e000000b0041ab83d1b2amr15478481pgj.122.1658896487011; 
 Tue, 26 Jul 2022 21:34:47 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a1709026f0200b0016be24e3668sm12363324plk.291.2022.07.26.21.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:34:45 -0700 (PDT)
Message-ID: <055a1aa0-756a-778d-3039-6eb452ccd390@redhat.com>
Date: Wed, 27 Jul 2022 12:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 21/42] virtio_ring: packed: extract the logic of
 attach vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-22-xuanzhuo@linux.alibaba.com>
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
Z2ljIG9mIGF0dGFjaCB2cmluZywgdGhlIHN1YnNlcXVlbnQgcGF0Y2ggd2lsbCBjYWxsIGl0Cj4g
c2VwYXJhdGVseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxOSArKysrKysrLS0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGZjNGUzZGI5ZjkzYi4uMDBiMThjZjNi
NGQ5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE5NTEsNiArMTk1MSwxMiBAQCBzdGF0
aWMgdm9pZCB2aXJ0cXVldWVfdnJpbmdfaW5pdF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZV9wYWNrZWQgKnZyaW5nX3BhYwo+ICAgCX0KPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0
cXVldWVfdnJpbmdfYXR0YWNoX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAr
CQkJCQkgIHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkICp2cmluZ19wYWNrZWQpCj4gK3sK
PiArCXZxLT5wYWNrZWQgPSAqdnJpbmdfcGFja2VkOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHN0cnVj
dCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ICAgCXVuc2lnbmVk
IGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0xOTkxLDI1ICsxOTk3LDE0
IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tl
ZCgKPiAgIAl2cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJ
TkdfRl9JTkRJUkVDVF9ERVNDKSAmJgo+ICAgCQkhY29udGV4dDsKPiAgIAo+IC0JdnEtPnBhY2tl
ZC5yaW5nX2RtYV9hZGRyID0gdnJpbmdfcGFja2VkLnJpbmdfZG1hX2FkZHI7Cj4gLQl2cS0+cGFj
a2VkLmRyaXZlcl9ldmVudF9kbWFfYWRkciA9IHZyaW5nX3BhY2tlZC5kcml2ZXJfZXZlbnRfZG1h
X2FkZHI7Cj4gLQl2cS0+cGFja2VkLmRldmljZV9ldmVudF9kbWFfYWRkciA9IHZyaW5nX3BhY2tl
ZC5kZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gLQo+IC0JdnEtPnBhY2tlZC5yaW5nX3NpemVfaW5f
Ynl0ZXMgPSB2cmluZ19wYWNrZWQucmluZ19zaXplX2luX2J5dGVzOwo+IC0JdnEtPnBhY2tlZC5l
dmVudF9zaXplX2luX2J5dGVzID0gdnJpbmdfcGFja2VkLmV2ZW50X3NpemVfaW5fYnl0ZXM7Cj4g
LQo+IC0JdnEtPnBhY2tlZC52cmluZyA9IHZyaW5nX3BhY2tlZC52cmluZzsKPiAtCj4gICAJZXJy
ID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfcGFja2VkKCZ2cmluZ19wYWNrZWQpOwo+ICAgCWlm
IChlcnIpCj4gICAJCWdvdG8gZXJyX3N0YXRlX2V4dHJhOwo+ICAgCj4gLQl2cS0+cGFja2VkLmRl
c2Nfc3RhdGUgPSB2cmluZ19wYWNrZWQuZGVzY19zdGF0ZTsKPiAtCXZxLT5wYWNrZWQuZGVzY19l
eHRyYSA9IHZyaW5nX3BhY2tlZC5kZXNjX2V4dHJhOwo+IC0KPiAgIAl2aXJ0cXVldWVfdnJpbmdf
aW5pdF9wYWNrZWQoJnZyaW5nX3BhY2tlZCwgISFjYWxsYmFjayk7Cj4gICAKPiAgIAl2aXJ0cXVl
dWVfaW5pdCh2cSwgbnVtKTsKPiArCXZpcnRxdWV1ZV92cmluZ19hdHRhY2hfcGFja2VkKHZxLCAm
dnJpbmdfcGFja2VkKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7
Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
