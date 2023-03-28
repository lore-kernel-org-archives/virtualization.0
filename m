Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ABCC76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D726B82173;
	Tue, 28 Mar 2023 06:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D726B82173
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ee3c6erf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bAU_BvbPt1ED; Tue, 28 Mar 2023 06:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E9C08209C;
	Tue, 28 Mar 2023 06:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E9C08209C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBC2C0036;
	Tue, 28 Mar 2023 06:16:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F5ACC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 595336112A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 595336112A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ee3c6erf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fK1Gydfn_2yc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:15:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F51660BBE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F51660BBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlgxyFebJPma7f+wQJ3FxzJD5zU35u7FqncJ3IeO7b8=;
 b=ee3c6erfS3reY12M7d132lrkQwFbDv7jU6nkkgDvFvHItFgGGOoHxtuVtQ3O4CpfUgxJ9d
 vXqAOdils/Yp78Px2SjoXRgmmfiIG39smGPhoiId6m4WtZPJrE5gn3oOCusBgojjJ+ouBw
 4HodEc/GTmv6Ue552O//kqevy/nJulo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-hM1KjtpqNem9QBz70NpS8A-1; Tue, 28 Mar 2023 02:15:53 -0400
X-MC-Unique: hM1KjtpqNem9QBz70NpS8A-1
Received: by mail-pg1-f197.google.com with SMTP id
 t2-20020a632d02000000b005075b896422so2944706pgt.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlgxyFebJPma7f+wQJ3FxzJD5zU35u7FqncJ3IeO7b8=;
 b=FHr76CvQGPeHh3OGNv+VTxNuodah4ihbK/1g5WcRDsfI4nBUYkOQrGc7dd4bzFTqNe
 F/Sj2f6vY67rOriw8e9OYyiRXBMyGtEgzrW4mJFr1i9El4KZX2ASKu0moP9RiJ3kjeiz
 mbH4adgxrn24ax049ElIocYaxA62RGhh89lCSo9Lef1d6TBWN+yT5syh3zW7DBmMqXp6
 qpdzFr/Nj1euS+jao9mox3za5iLLaJ5iwAG5chQnUlYvCTYdsx1Q6rcRPhrdhuicwtZ0
 LKOukTQ6Uip3ZjUCJI9v/rtl5DbDN31V7fSrrzWY7dKlCNLIqwxJhbrabvH3RS5k40Iu
 lpdw==
X-Gm-Message-State: AO0yUKUV8MhizL1ypznivgErVQRP7oufSt+o+dlm6HLZMec7OWCeFMnu
 0/d0Pb2y8dKAQWaNH0DsAeGE9rOdUOGGRUyw78NP4cVleONGKMWTu4ZMT9N1HVNF/vHI7jLjkGP
 XVaysGQ++yPIm+p1TcpEroJZs0fWbUcyX2DHQcqxwtw==
X-Received: by 2002:a05:6a20:6695:b0:cc:fa4b:3a6a with SMTP id
 o21-20020a056a20669500b000ccfa4b3a6amr14533513pzh.58.1679984152659; 
 Mon, 27 Mar 2023 23:15:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/EXtnMriPNnUSBqMdB8R3MTX/HZbPmuUZaMQI3cIfChtQpMVsjoT28zHMG/6gN2eQzMIjreQ==
X-Received: by 2002:a05:6a20:6695:b0:cc:fa4b:3a6a with SMTP id
 o21-20020a056a20669500b000ccfa4b3a6amr14533498pzh.58.1679984152355; 
 Mon, 27 Mar 2023 23:15:52 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a63f046000000b0050bc4ca9024sm18626628pgj.65.2023.03.27.23.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:15:51 -0700 (PDT)
Message-ID: <92955312-b3f6-5f8e-0e2e-2a18e2af6666@redhat.com>
Date: Tue, 28 Mar 2023 14:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/11] vduse: Support get_vq_affinity callback
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-7-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-7-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzMvMjMgMTM6MzAsIFhpZSBZb25namkg5YaZ6YGTOgo+IFRoaXMgaW1wbGVtZW50
cyBnZXRfdnFfYWZmaW5pdHkgY2FsbGJhY2sgc28gdGhhdAo+IHRoZSB2aXJ0aW8tYmxrIGRyaXZl
ciBjYW4gYnVpbGQgdGhlIGJsay1tcSBxdWV1ZXMKPiBiYXNlZCBvbiB0aGUgaXJxIGNhbGxiYWNr
IGFmZmluaXR5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpU
aGFua3MKCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDkg
KysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92
ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCA0NWFhODcwM2M0YjUuLmNlZmFiZDBkYWI5YyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC03MjIsNiArNzIyLDE0IEBA
IHN0YXRpYyBpbnQgdmR1c2VfdmRwYV9zZXRfdnFfYWZmaW5pdHkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhLCB1MTYgaWR4LAo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgY3B1bWFzayAqCj4gK3ZkdXNlX3ZkcGFfZ2V0X3ZxX2FmZmluaXR5KHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSwgdTE2IGlkeCkKPiArewo+ICsJc3RydWN0IHZkdXNlX2RldiAqZGV2
ID0gdmRwYV90b192ZHVzZSh2ZHBhKTsKPiArCj4gKwlyZXR1cm4gJmRldi0+dnFzW2lkeF0tPmly
cV9hZmZpbml0eTsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgdmR1c2VfdmRwYV9zZXRfbWFwKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwKPiAgIAkJCQl1bnNpZ25lZCBpbnQgYXNpZCwKPiAgIAkJ
CQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQo+IEBAIC03NzMsNiArNzgxLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmR1c2VfdmRwYV9jb25maWdfb3BzID0gewo+
ICAgCS5zZXRfY29uZmlnCQk9IHZkdXNlX3ZkcGFfc2V0X2NvbmZpZywKPiAgIAkuZ2V0X2dlbmVy
YXRpb24JCT0gdmR1c2VfdmRwYV9nZXRfZ2VuZXJhdGlvbiwKPiAgIAkuc2V0X3ZxX2FmZmluaXR5
CT0gdmR1c2VfdmRwYV9zZXRfdnFfYWZmaW5pdHksCj4gKwkuZ2V0X3ZxX2FmZmluaXR5CT0gdmR1
c2VfdmRwYV9nZXRfdnFfYWZmaW5pdHksCj4gICAJLnJlc2V0CQkJPSB2ZHVzZV92ZHBhX3Jlc2V0
LAo+ICAgCS5zZXRfbWFwCQk9IHZkdXNlX3ZkcGFfc2V0X21hcCwKPiAgIAkuZnJlZQkJCT0gdmR1
c2VfdmRwYV9mcmVlLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
