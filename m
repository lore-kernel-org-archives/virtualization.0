Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45391CCA48A
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFC58405F8;
	Thu, 21 Jul 2022 09:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFC58405F8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzKRJYkq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YurL43ytgkCh; Thu, 21 Jul 2022 09:15:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48DDB4018F;
	Thu, 21 Jul 2022 09:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48DDB4018F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 275F8C0033;
	Thu, 21 Jul 2022 09:15:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01BE5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE95684777
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE95684777
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzKRJYkq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHX-6wnAIsJd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0A928476E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0A928476E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flUzKdjZ1/4EDqBKjfAvMc1rxeEdG1DoytUK7fLquSo=;
 b=ZzKRJYkqgjaKZd1css1iphT1KAl7nGrNLyJoZ1HygN03JW6TMrGDViH0z/Ii6Y+K8+l5QF
 oG8eTqWAwi82k/zLYV1ugf9p6y0Bdp/CeDDtsqNpfQGXaYasnluUbT2Um8lKpgCQMjyUKs
 4cr7DTfwrrEn1qZj9cJbXF6fU6PJgTw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-w9YrpEIEME-8V8OeKldQ7Q-1; Thu, 21 Jul 2022 05:15:04 -0400
X-MC-Unique: w9YrpEIEME-8V8OeKldQ7Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 h13-20020a63e14d000000b0040df75eaa2eso654816pgk.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=flUzKdjZ1/4EDqBKjfAvMc1rxeEdG1DoytUK7fLquSo=;
 b=TcpGSShJYngpVu8uiSosTYZ1IeCg5uDgJZuIDYQZJ4hKlQiHyEAgaXNs103E7cQj09
 xzvmPCcAjx9tFG4I3ejG/+wj7Kg0VkAlFhi1chYfantGL77JkwtbNMAA19ByafoFfGoa
 dtbamSADwvbIC5VjjzcTGUxBNO+wN+LGl+tnUUaXqM6PiSKUQ5JDypsf6EKplwc2DNcH
 prXwPlUYVz5mvIajWGQbd8EDG529tnHMjT7HGgFeMesrDCjRO4/N+vRi3e+cSB/SbR0d
 8vY8YMJsiA8sGPsYZChQRsMK/+okist+GP/New5fovQizgWGsHxCKkt6wO1UUubgCabu
 O1ZQ==
X-Gm-Message-State: AJIora+UHXLC+DqaAw6kFpMNsWLGUwhcwpTd4EdSEsEMa46qbDzUOdZE
 mTp7qL5rL+NIKNhZ38byxx2sxTCbvkGo9nGXNq7d4UTIBB2HID4TOU6YgNWKwCtf8Z+CfRMhLD4
 iLyPorfzeAzUX5eFkzURM5MGNkK1d1sEBJfvUxIafOg==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id
 u6-20020a634546000000b0041a5e8f508amr8003815pgk.419.1658394903088; 
 Thu, 21 Jul 2022 02:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUZ8W3Hy81eneplKjYeb4+YqIJ3cluF804ujXcDkWSb197c5rqPxj5tPxNoDGDy9bc1IdWeQ==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id
 u6-20020a634546000000b0041a5e8f508amr8003791pgk.419.1658394902799; 
 Thu, 21 Jul 2022 02:15:02 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170902e80c00b0016a11b7472csm1139255plg.166.2022.07.21.02.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:15:02 -0700 (PDT)
Message-ID: <74fb1fe4-87ce-eb24-e4a0-d81164c80f3c@redhat.com>
Date: Thu, 21 Jul 2022 17:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 27/40] virtio_pci: struct virtio_pci_common_cfg add
 queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gQWRkIHF1ZXVlX3Jlc2V0
IGluIHZpcnRpb19wY2lfY29tbW9uX2NmZy4KPgo+ICAgaHR0cHM6Ly9naXRodWIuY29tL29hc2lz
LXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0Cj4gICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMt
dGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xMzkKPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rl
cm4uaCB8IDIgKy0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICB8IDEgKwo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBpbmRleCA0MWY1YTAxOGJkOTQuLjA1MTIzYjlhNjA2
ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiBAQCAtOSw3ICs5LDcgQEAgc3Ry
dWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmcgY2ZnOwo+ICAgCj4gICAJX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiBy
ZWFkLXdyaXRlICovCj4gLQlfX2xlMTYgcGFkZGluZzsKPiArCV9fbGUxNiBxdWV1ZV9yZXNldDsJ
CS8qIHJlYWQtd3JpdGUgKi8KPiAgIH07Cj4gICAKPiAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVy
bl9kZXZpY2Ugewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5o
IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+IGluZGV4IGY1OTgxYTg3NDQ4MS4u
ZjcwM2FmYzdhZDMxIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNp
LmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gQEAgLTIwMyw2ICsy
MDMsNyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jZmdfY2FwIHsKPiAgICNkZWZpbmUgVklSVElPX1BD
SV9DT01NT05fUV9VU0VETE8JNDgKPiAgICNkZWZpbmUgVklSVElPX1BDSV9DT01NT05fUV9VU0VE
SEkJNTIKPiAgICNkZWZpbmUgVklSVElPX1BDSV9DT01NT05fUV9OREFUQQk1Ngo+ICsjZGVmaW5l
IFZJUlRJT19QQ0lfQ09NTU9OX1FfUkVTRVQJNTgKPiAgIAo+ICAgI2VuZGlmIC8qIFZJUlRJT19Q
Q0lfTk9fTU9ERVJOICovCj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
