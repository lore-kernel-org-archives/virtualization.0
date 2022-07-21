Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B5EC43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BFC9422E4;
	Thu, 21 Jul 2022 09:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BFC9422E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YdR8+Ohk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qYR6HLj7v_zJ; Thu, 21 Jul 2022 09:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 46CE0422E0;
	Thu, 21 Jul 2022 09:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46CE0422E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDADC0033;
	Thu, 21 Jul 2022 09:15:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 316A1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEF0F422E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEF0F422E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aE7e-ckYUwW0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2DB5422E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2DB5422E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Escg7n0ywUK4qdukC0pSCylFb7FUJQPzR61HHZ9/jsk=;
 b=YdR8+OhkYXCqebYJmKY4J3pCFDk51CUVUgiPsUTfEyYcnZTjwipKwpFYjxZFeE1Iq77GrX
 jN138psrhyRR1jQ8QHKxXRlhdyXd0v0kZhBCg7aGWevxOGMvgtO+iSYqR7GrKfZNzgB7rD
 4kPeAAYawlJCzOZUX6vfHIhQVoqRwas=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-cfjq2Zw4NhSt-DKyOmkJ2Q-1; Thu, 21 Jul 2022 05:15:50 -0400
X-MC-Unique: cfjq2Zw4NhSt-DKyOmkJ2Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 s10-20020a170902ea0a00b0016cebf80007so862861plg.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Escg7n0ywUK4qdukC0pSCylFb7FUJQPzR61HHZ9/jsk=;
 b=UNh//OydzEU6AWKpX9zk0N1+/jc6LkIIic0bFowrvCuRvN7yB+G559rz3vuDwMiCqK
 4RZDNUw26xzGEIoUr0A3sr7jkvkx98vqoVc6nT9Sk46fONdscDdzuxLcQwA8+41Wb0dd
 loH6TE5OFW0n8Y8c01pyYnOUMoA0Exu8HZa7nyoKA8LLqNmyxwsPdNrqcSDFex7VcMPn
 rxMql/znlnthNLTBKUbN8zw0c9bxo4fh2a8jmCMfgVe660f7pHjW3qpNTvRlsUoadmUL
 Z+wqvNX+IURLQRRq/63XkxfWsVdhx312b7j9AcEgJKdqWOVz2XUjGmouCUmEjRJraxQg
 uV6A==
X-Gm-Message-State: AJIora9tmvSE68ecmfm1nLy0f1LC+EApqudGANSmJFRgJUlBik/rPLFd
 Dz5Rhe2YztmtCi/Eqbp2McJasHgzivGDwZLmWvtA2YK4Zvi4zaskl20nN115/PPbwJtr0X9ywYy
 rF676lX0lDpsT5U3wNAFK8VvELD5nDQ+30dZpMCL/UA==
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id
 x14-20020a056a00188e00b0052ab545559fmr43170875pfh.18.1658394949145; 
 Thu, 21 Jul 2022 02:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tse0avmLLaWWihH80dsCqYgwTb5M+a/h7oTDBCS5V2QWyEFXUICi4yWw1kN7K6oki4/v7zfQ==
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id
 x14-20020a056a00188e00b0052ab545559fmr43170831pfh.18.1658394948796; 
 Thu, 21 Jul 2022 02:15:48 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a634204000000b0041239bf9be8sm1036316pga.1.2022.07.21.02.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:15:48 -0700 (PDT)
Message-ID: <14c8469c-8609-78c6-308e-a00051634ce6@redhat.com>
Date: Thu, 21 Jul 2022 17:15:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 22/40] virtio_ring: introduce virtqueue_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-23-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIHZpcnRx
dWV1ZV9yZXNpemUoKSB0byBpbXBsZW1lbnQgdGhlIHJlc2l6ZSBvZiB2cmluZy4KPiBCYXNlZCBv
biB0aGVzZSwgdGhlIGRyaXZlciBjYW4gZHluYW1pY2FsbHkgYWRqdXN0IHRoZSBzaXplIG9mIHRo
ZSB2cmluZy4KPiBGb3IgZXhhbXBsZTogZXRodG9vbCAtRy4KPgo+IHZpcnRxdWV1ZV9yZXNpemUo
KSBpbXBsZW1lbnRzIHJlc2l6ZSBiYXNlZCBvbiB0aGUgdnEgcmVzZXQgZnVuY3Rpb24uIEluCj4g
Y2FzZSBvZiBmYWlsdXJlIHRvIGFsbG9jYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAg
cmVzaXplIGFuZCB1c2UKPiB0aGUgb3JpZ2luYWwgdnJpbmcuCj4KPiBEdXJpbmcgdGhpcyBwcm9j
ZXNzLCBpZiB0aGUgcmUtZW5hYmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4gbG9u
Z2VyIGJlIHVzZWQuIEFsdGhvdWdoIHRoZSBwcm9iYWJpbGl0eSBvZiB0aGlzIHNpdHVhdGlvbiBp
cyBub3QgaGlnaC4KPgo+IFRoZSBwYXJhbWV0ZXIgcmVjeWNsZSBpcyB1c2VkIHRvIHJlY3ljbGUg
dGhlIGJ1ZmZlciB0aGF0IGlzIG5vIGxvbmdlcgo+IHVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBp
bmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NzIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggYjA5MjkxNGU5ZGNk
Li5jZjQzNzkxNzUxNjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMjU0NSw2ICsyNTQ1
LDc1IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWUoCj4gICB9Cj4g
ICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19jcmVhdGVfdmlydHF1ZXVlKTsKPiAgIAo+ICsvKioK
PiArICogdmlydHF1ZXVlX3Jlc2l6ZSAtIHJlc2l6ZSB0aGUgdnJpbmcgb2YgdnEKPiArICogQF92
cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiArICogQG51bTog
bmV3IHJpbmcgbnVtCj4gKyAqIEByZWN5Y2xlOiBjYWxsYmFjayBmb3IgcmVjeWNsZSB0aGUgdXNl
bGVzcyBidWZmZXIKPiArICoKPiArICogV2hlbiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IHRvIGNy
ZWF0ZSBhIG5ldyB2cmluZywgaXQgd2lsbCBzZXQgdGhlIGN1cnJlbnQgdnEKPiArICogaW50byB0
aGUgcmVzZXQgc3RhdGUuIFRoZW4gY2FsbCB0aGUgcGFzc2VkIGNhbGxiYWNrIHRvIHJlY3ljbGUg
dGhlIGJ1ZmZlcgo+ICsgKiB0aGF0IGlzIG5vIGxvbmdlciB1c2VkLiBPbmx5IGFmdGVyIHRoZSBu
ZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZQo+ICsgKiBvbGQgdnJpbmcgd2ls
bCBiZSByZWxlYXNlZC4KPiArICoKPiArICogQ2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNh
bGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4gKyAqIGF0IHRoZSBzYW1l
IHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gKyAqCj4gKyAqIFJldHVybnMgemVybyBvciBh
IG5lZ2F0aXZlIGVycm9yLgo+ICsgKiAwOiBzdWNjZXNzLgo+ICsgKiAtRU5PTUVNOiBGYWlsZWQg
dG8gYWxsb2NhdGUgYSBuZXcgcmluZywgZmFsbCBiYWNrIHRvIHRoZSBvcmlnaW5hbCByaW5nIHNp
emUuCj4gKyAqICB2cSBjYW4gc3RpbGwgd29yayBub3JtYWxseQo+ICsgKiAtRUJVU1k6IEZhaWxl
ZCB0byBzeW5jIHdpdGggZGV2aWNlLCB2cSBtYXkgbm90IHdvcmsgcHJvcGVybHkKPiArICogLUVO
T0VOVDogVHJhbnNwb3J0IG9yIGRldmljZSBub3Qgc3VwcG9ydGVkCj4gKyAqIC1FMkJJRy8tRUlO
VkFMOiBudW0gZXJyb3IKPiArICogLUVQRVJNOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZAo+ICsg
Kgo+ICsgKi8KPiAraW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1
MzIgbnVtLAo+ICsJCSAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2
b2lkICpidWYpKQo+ICt7Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShf
dnEpOwo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dnEudmRldjsKPiArCXZv
aWQgKmJ1ZjsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKCF2cS0+d2Vfb3duX3JpbmcpCj4gKwkJ
cmV0dXJuIC1FUEVSTTsKPiArCj4gKwlpZiAobnVtID4gdnEtPnZxLm51bV9tYXgpCj4gKwkJcmV0
dXJuIC1FMkJJRzsKPiArCj4gKwlpZiAoIW51bSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4g
KwlpZiAoKHZxLT5wYWNrZWRfcmluZyA/IHZxLT5wYWNrZWQudnJpbmcubnVtIDogdnEtPnNwbGl0
LnZyaW5nLm51bSkgPT0gbnVtKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWlmICghdmRldi0+Y29u
ZmlnLT5kaXNhYmxlX3ZxX2FuZF9yZXNldCkKPiArCQlyZXR1cm4gLUVOT0VOVDsKPiArCj4gKwlp
ZiAoIXZkZXYtPmNvbmZpZy0+ZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KQo+ICsJCXJldHVybiAtRU5P
RU5UOwo+ICsKPiArCWVyciA9IHZkZXYtPmNvbmZpZy0+ZGlzYWJsZV92cV9hbmRfcmVzZXQoX3Zx
KTsKPiArCWlmIChlcnIpCj4gKwkJcmV0dXJuIGVycjsKPiArCj4gKwl3aGlsZSAoKGJ1ZiA9IHZp
cnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihfdnEpKSAhPSBOVUxMKQo+ICsJCXJlY3ljbGUoX3Zx
LCBidWYpOwo+ICsKPiArCWlmICh2cS0+cGFja2VkX3JpbmcpCj4gKwkJZXJyID0gdmlydHF1ZXVl
X3Jlc2l6ZV9wYWNrZWQoX3ZxLCBudW0pOwo+ICsJZWxzZQo+ICsJCWVyciA9IHZpcnRxdWV1ZV9y
ZXNpemVfc3BsaXQoX3ZxLCBudW0pOwo+ICsKPiArCWlmICh2ZGV2LT5jb25maWctPmVuYWJsZV92
cV9hZnRlcl9yZXNldChfdnEpKQo+ICsJCXJldHVybiAtRUJVU1k7Cj4gKwo+ICsJcmV0dXJuIGVy
cjsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfcmVzaXplKTsKPiArCj4gICAv
KiBPbmx5IGF2YWlsYWJsZSBmb3Igc3BsaXQgcmluZyAqLwo+ICAgc3RydWN0IHZpcnRxdWV1ZSAq
dnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJCQkJICAgICAgdW5z
aWduZWQgaW50IG51bSwKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvLmgKPiBpbmRleCAxMjliZGU3NTIxZTMuLjYyZTMxYmNhNTYwMiAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gKysrIGIvaW5jbHVkZS9saW51
eC92aXJ0aW8uaAo+IEBAIC05MSw2ICs5MSw5IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9k
ZXNjX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ICAgZG1hX2FkZHJfdCB2aXJ0cXVldWVf
Z2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ICAgZG1hX2FkZHJfdCB2aXJ0
cXVldWVfZ2V0X3VzZWRfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICAKPiAraW50IHZp
cnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUzMiBudW0sCj4gKwkJICAgICB2
b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpOwo+ICsKPiAg
IC8qKgo+ICAgICogdmlydGlvX2RldmljZSAtIHJlcHJlc2VudGF0aW9uIG9mIGEgZGV2aWNlIHVz
aW5nIHZpcnRpbwo+ICAgICogQGluZGV4OiB1bmlxdWUgcG9zaXRpb24gb24gdGhlIHZpcnRpbyBi
dXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
