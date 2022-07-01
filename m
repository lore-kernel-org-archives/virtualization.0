Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D7EC433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1EF240B60;
	Fri,  1 Jul 2022 09:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1EF240B60
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KXHPsTCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J15h63-kprgf; Fri,  1 Jul 2022 09:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7277E40B5C;
	Fri,  1 Jul 2022 09:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7277E40B5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33377C0035;
	Fri,  1 Jul 2022 09:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5722BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2579240B5C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2579240B5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eRJFjNZBTcEt
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:28:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44F7D40B6A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44F7D40B6A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656667687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBQdYZv/rBFNAXGUnNhg85FJcoNaGILlYzbcDNSwkmw=;
 b=KXHPsTCAtSknDEfGObYr5gp9DDDeO4rCPttnG+HBqcss3SGcnzg9oKbDfsTAPIa5ycIHWL
 Kgaid5PpE2N0jCdXv078vGG3Tnukjr9rd7svGW6Ejr8Mx6B4A/cVebw7dpBxcS9zSSznfh
 LcNHDvJPR8QBFdev88klplWqFdspc4Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-WN4ZJRJQNYOC7ySGzZSETA-1; Fri, 01 Jul 2022 05:28:01 -0400
X-MC-Unique: WN4ZJRJQNYOC7ySGzZSETA-1
Received: by mail-pl1-f198.google.com with SMTP id
 h18-20020a170902f55200b0016a4a78bd71so1199402plf.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZBQdYZv/rBFNAXGUnNhg85FJcoNaGILlYzbcDNSwkmw=;
 b=RB7Ui8IE/U/b6zTV56l+xSnzKnFDYoD13MmeWhqC+LazLtX65zTEc48pjH0Veh1bA8
 55x0wiOlbpyXgzWWTdrMra9OIiihHtq5B9yYDbU4TwZ8H0a0gPg5xpQ7a9G1zDv+NjL6
 sZycN0BbgVSx2aLMEo+AWCVO6DrFswP2i0+QfNYsvdBBYDhzFe26sTxSk2aeYbfmATpq
 75WNw9EMh4EKi5FSFqXql79ltM0OMsAWUN1sgw7kHgo56aEp700Hio5dFb0L0AXgiAal
 8dqDdxxonr/wIuXdOdlqIb3lqW3VeRHd1bttBfVCKFaAHgSk88XO+Y0/KAFpmfceRO23
 4jzw==
X-Gm-Message-State: AJIora9VU1ymhAoN+1YiGYc6wQtQSm5zCN6EiWZSVpYWhtWfhspdYvW3
 mJ46R0ra25of9sm768Fm9mycxWAR3DuaFANl6hzWiYf/TPhT3kZNscmOdpqVulFJWTVoBDbJA8B
 dxSGkHLyr3KeR8bu1IMABPCbiOlQycAU2jZJeAi4Uog==
X-Received: by 2002:a17:90b:3141:b0:1ed:4ffb:f911 with SMTP id
 ip1-20020a17090b314100b001ed4ffbf911mr17631444pjb.80.1656667680008; 
 Fri, 01 Jul 2022 02:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v7wu5Pr52fEWhoICBbqVrBx5u9VuzueVx4HVEs9nrjbr1aixGJWRwEIuEt0pnr6Hnq0W2LoA==
X-Received: by 2002:a17:90b:3141:b0:1ed:4ffb:f911 with SMTP id
 ip1-20020a17090b314100b001ed4ffbf911mr17631389pjb.80.1656667679758; 
 Fri, 01 Jul 2022 02:27:59 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 a9-20020aa79709000000b00528208d3056sm1775809pfg.64.2022.07.01.02.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:27:59 -0700 (PDT)
Message-ID: <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
Date: Fri, 1 Jul 2022 17:27:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce
 virtqueue_resize_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydGlvIHJpbmcgcGFj
a2VkIHN1cHBvcnRzIHJlc2l6ZS4KPgo+IE9ubHkgYWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNj
ZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBuZXcgbnVtLAo+IHdlIHdpbGwgcmVsZWFz
ZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gaW5k
aWNhdGluZyB0aGF0IHRoZSB2cmluZyBzdGlsbCBwb2ludHMgdG8gdGhlIG9sZCB2cmluZy4KPgo+
IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKGJ5IHZpcnRxdWV1ZV9yZWlu
aXRfcGFja2VkKCkpIHRoZQo+IHZpcnRxdWV1ZSB0byBlbnN1cmUgdGhhdCB0aGUgdnJpbmcgY2Fu
IGJlIHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNjUwZjcwMWE1NDgwLi40ODYwNzg3
Mjg2ZGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjA0Miw2ICsyMDQyLDM1IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAg
IAlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVf
cGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPiArewo+ICsJc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZV9wYWNrZWQgdnJpbmcgPSB7fTsKPiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92
cS0+dmRldjsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tl
ZCgmdnJpbmcsIHZkZXYsIG51bSkpCj4gKwkJZ290byBlcnJfcmluZzsKPiArCj4gKwllcnIgPSB2
cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQoJnZyaW5nKTsKPiArCWlmIChlcnIpCj4gKwkJ
Z290byBlcnJfc3RhdGVfZXh0cmE7Cj4gKwo+ICsJdnJpbmdfZnJlZSgmdnEtPnZxKTsKPiArCj4g
Kwl2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmcudnJpbmcubnVtKTsKPiArCXZpcnRxdWV1ZV92cmlu
Z19hdHRhY2hfcGFja2VkKHZxLCAmdnJpbmcpOwo+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFj
a2VkKHZxKTsKPiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9zdGF0ZV9leHRyYToKPiArCXZy
aW5nX2ZyZWVfcGFja2VkKCZ2cmluZywgdmRldik7Cj4gK2Vycl9yaW5nOgo+ICsJdmlydHF1ZXVl
X3JlaW5pdF9wYWNrZWQodnEpOwoKClNvIGRlc2Nfc3RhdGUgYW5kIGRlc2NfZXh0cmEgaGFzIGJl
ZW4gZnJlZWQgdnJpbmdfZnJlZV9wYWNrZWQoKSB3aGVuIAp2cmluZ19hbGxvY19zdGF0ZV9leHRy
YV9wYWNrZWQoKSBmYWlscy4gV2UgbWlnaHQgZ2V0IHVzZS1hZnRlci1mcmVlIGhlcmU/CgpBY3R1
YWxseSwgSSB0aGluayBmb3IgcmVzaXplIHdlIG5lZWQKCjEpIGRldGFjaCBvbGQKMikgYWxsb2Nh
dGUgbmV3CjMpIGlmIDIpIHN1Y2NlZWQsIGF0dGFjaCBuZXcgb3RoZXJ3aXNlIGF0dGFjaCBvbGQK
ClRoaXMgc2VlbXMgbW9yZSBjbGVhcmVyIHRoYW4gdGhlIGN1cnJlbnQgbG9naWM/CgpUaGFua3MK
Cgo+ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICAKPiAgIC8qCj4gICAgKiBHZW5lcmlj
IGZ1bmN0aW9ucyBhbmQgZXhwb3J0ZWQgc3ltYm9scy4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
