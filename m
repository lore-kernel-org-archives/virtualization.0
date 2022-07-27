Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE0C19F2B
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABD4D40941;
	Wed, 27 Jul 2022 04:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABD4D40941
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GXbzbq6Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImWeBKLfS54x; Wed, 27 Jul 2022 04:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D022A408A5;
	Wed, 27 Jul 2022 04:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D022A408A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A69C5C0035;
	Wed, 27 Jul 2022 04:24:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FFE3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DFA7818E8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DFA7818E8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GXbzbq6Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SNAWUbfCi6vu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6036A81763
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6036A81763
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658895878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yok+W8J1zKJN3VSngD/6A5xyt1kdGDnR3MRcZGx2JdM=;
 b=GXbzbq6Yn0nxpxgV8laBdeqo3LDMWiEwHWTb0R8WlnG6Jlv+zPTheRmdcsXee1lPPDPN5h
 eNrnSxLUzILjxaNXhP+vLLoDMkNSz98FHeNRHdcjKHYz1MVvI7zfi5E1eSZv9/1tTAQyKA
 NnfGo7D9+TgMhfMtJLxQ5cdLXJ8T9qg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-5zvZG8d2OpWzJDkiUv_pqw-1; Wed, 27 Jul 2022 00:24:37 -0400
X-MC-Unique: 5zvZG8d2OpWzJDkiUv_pqw-1
Received: by mail-pj1-f72.google.com with SMTP id
 r13-20020a17090a454d00b001f04dfc6195so533037pjm.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Yok+W8J1zKJN3VSngD/6A5xyt1kdGDnR3MRcZGx2JdM=;
 b=E9BUhuiB4Af821Umsha6n2liQQwlSBBdTTX5+b3PhFfi2ja3WPtMceeaD8x+3Obtxm
 4hoVzrclnCYeHa3D9KxZP8JnIZZezds2730zZRxvD7mWNTtnDQWizCJ8OU+h6611nLlT
 uKemZN5NqAdzU0+dn8ihUMoQozrwagrfY43mAFUBtw3jdAGWw6SZOxS8aSrbyLb0QA2V
 90618TJ9HK4lrKlFGx+WnfkqN9+bE4aiRTUK3vZKghpQy8kPkKT/eoU2WXHDiV/VGpCk
 FfYPIagHATRwqzhUYTGHCtktxP+/DrVPolq5m7shYDFy7mlmdkr37WY1pkHY7ZQFMmvZ
 c6GA==
X-Gm-Message-State: AJIora/zt7ssSK0YxCgji+ffxcVYeahofcIlLiXj6kJP6l++PFY7Uw60
 uH91emuIZYsifqUthcjKB2La1P1de9mfST6ED9BkisHn9zd9F05UJM3NiZFsEw8W0oMDB4D1Ami
 k1/W0Mbmnn7zYATlcI6P6fOyAdSHOCOids6g7/Xl7Eg==
X-Received: by 2002:a17:90a:ea90:b0:1f2:81cd:1948 with SMTP id
 h16-20020a17090aea9000b001f281cd1948mr2513904pjz.172.1658895875913; 
 Tue, 26 Jul 2022 21:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shgnF0FTkAghWAebt2dLxHjIMnalV8dd87lEKXX5Ir9vcvUUz2DeWLC6lS50voh4OTJ1rbZA==
X-Received: by 2002:a17:90a:ea90:b0:1f2:81cd:1948 with SMTP id
 h16-20020a17090aea9000b001f281cd1948mr2513861pjz.172.1658895875684; 
 Tue, 26 Jul 2022 21:24:35 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 ik1-20020a170902ab0100b0016c48c52ce4sm12556176plb.204.2022.07.26.21.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:24:33 -0700 (PDT)
Message-ID: <113b77e4-ccc5-7a92-60db-26c25c184e20@redhat.com>
Date: Wed, 27 Jul 2022 12:24:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 17/42] virtio_ring: packed: introduce vring_free_packed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-18-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gRnJlZSB0aGUgc3RydWN0
dXJlIHN0cnVjdCB2cmluZ192cml0cXVldWVfcGFja2VkLgo+Cj4gU3Vic2VxdWVudCBwYXRjaGVz
IHJlcXVpcmUgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+IGluZGV4IDU4MzU1ZTFhYzdkNy4uODkxOTAwYjMxYzNkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gQEAgLTE4MzUsNiArMTgzNSwyOCBAQCBzdGF0aWMgc3RydWN0IHZy
aW5nX2Rlc2NfZXh0cmEgKnZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50IG51bSkK
PiAgIAlyZXR1cm4gZGVzY19leHRyYTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2cmluZ19m
cmVlX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCAqdnJpbmdfcGFja2VkLAo+
ICsJCQkgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiArewo+ICsJaWYgKHZyaW5n
X3BhY2tlZC0+dnJpbmcuZGVzYykKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHZyaW5nX3Bh
Y2tlZC0+cmluZ19zaXplX2luX2J5dGVzLAo+ICsJCQkJIHZyaW5nX3BhY2tlZC0+dnJpbmcuZGVz
YywKPiArCQkJCSB2cmluZ19wYWNrZWQtPnJpbmdfZG1hX2FkZHIpOwo+ICsKPiArCWlmICh2cmlu
Z19wYWNrZWQtPnZyaW5nLmRyaXZlcikKPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHZyaW5n
X3BhY2tlZC0+ZXZlbnRfc2l6ZV9pbl9ieXRlcywKPiArCQkJCSB2cmluZ19wYWNrZWQtPnZyaW5n
LmRyaXZlciwKPiArCQkJCSB2cmluZ19wYWNrZWQtPmRyaXZlcl9ldmVudF9kbWFfYWRkcik7Cj4g
Kwo+ICsJaWYgKHZyaW5nX3BhY2tlZC0+dnJpbmcuZGV2aWNlKQo+ICsJCXZyaW5nX2ZyZWVfcXVl
dWUodmRldiwgdnJpbmdfcGFja2VkLT5ldmVudF9zaXplX2luX2J5dGVzLAo+ICsJCQkJIHZyaW5n
X3BhY2tlZC0+dnJpbmcuZGV2aWNlLAo+ICsJCQkJIHZyaW5nX3BhY2tlZC0+ZGV2aWNlX2V2ZW50
X2RtYV9hZGRyKTsKPiArCj4gKwlrZnJlZSh2cmluZ19wYWNrZWQtPmRlc2Nfc3RhdGUpOwo+ICsJ
a2ZyZWUodnJpbmdfcGFja2VkLT5kZXNjX2V4dHJhKTsKPiArfQo+ICsKPiAgIHN0YXRpYyBzdHJ1
Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAl1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4gICAJdW5zaWduZWQgaW50IG51bSwKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
