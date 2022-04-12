Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1CBC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B69E401B9;
	Tue, 12 Apr 2022 02:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJlVxh9YVG2h; Tue, 12 Apr 2022 02:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79EEF409EF;
	Tue, 12 Apr 2022 02:50:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54795C0082;
	Tue, 12 Apr 2022 02:50:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A491AC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 830FD60EDA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHCqxtWZa8KT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D44A760ECD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649731797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwRhwX5o1ZKlygCgQ3xGq/wyDNTDMYF/CMCZtPRL46U=;
 b=QButaGPS1XtO2pdDKnF91DnZ1jpyh4++3KyAOjGC2aiaswI/ahzEEZfyllwGTPFwCmqZQi
 Hm8By5r5kTHskfXelhifwldeo35Z2F9rAMVRRR99YN5w/yZoWH8BAU4HuwVinDJSorn1t9
 YZ3VYIbuxfG9pSQMbD4AO+KURPuer20=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-8DO5aXqKN12tUv-C5Cm1wQ-1; Mon, 11 Apr 2022 22:49:56 -0400
X-MC-Unique: 8DO5aXqKN12tUv-C5Cm1wQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 l6-20020a170903120600b0014f43ba55f3so7092522plh.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uwRhwX5o1ZKlygCgQ3xGq/wyDNTDMYF/CMCZtPRL46U=;
 b=Wn4M0qiXz5wOIj1PPDTG62Qu/Rz1Jb3W9LkgP7C2vhRZWqC6xbbzpvu7Zn/Jc4/SsF
 IvLxY98iUE61DCtP4BlhyB7/797DrMEvW8MZPwj54Jf+TrrOEgOIrOCGT6/4opSjICX9
 dGyUBJv7qh+lpn1e9cOvmD/N3Klaw84vjTan+wTltRjmZtbcPUUzL9HJGApC506h+BeB
 shvBjrQCyvFztxSCcjhtbuiAKO4L6gj6plui/rAJOTW+lWDQlFMutzPhHTB0boV/vrI3
 Rb3O3zh77aEsJo1Lrjo+5j65aplLMgDbLXouCeX1eS2JF++toXnLuJD3ITqZm5NTXZKa
 /BUQ==
X-Gm-Message-State: AOAM5313SrxyxtoVsUhsXZK24hu+b0e/aFsjokG7mU5wd70u+Z8lWZPN
 95pcy25JfhZ0f6fgiLY3odxsCBlQXzf4Wj1/kc1xAAJXrINI4FoBpBZ8TTdTFdQ7Wtv5IjGCYF2
 K6UPxkgv3/G6ccXjllYXse7nBLGz0sZjrQoulrFzx9A==
X-Received: by 2002:a17:902:f787:b0:152:157:eb7 with SMTP id
 q7-20020a170902f78700b0015201570eb7mr34196059pln.109.1649731795841; 
 Mon, 11 Apr 2022 19:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7g+34LbfFseW6K+0T9iSnUxylNiT1oNf8YpIYdQIMHAztol8ytTy6Bjs0RdOSSnoavA05bA==
X-Received: by 2002:a17:902:f787:b0:152:157:eb7 with SMTP id
 q7-20020a170902f78700b0015201570eb7mr34196016pln.109.1649731795595; 
 Mon, 11 Apr 2022 19:49:55 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 75-20020a62174e000000b0050579f94ed2sm13220419pfx.96.2022.04.11.19.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 19:49:55 -0700 (PDT)
Message-ID: <f57f8da3-38a6-91a5-05bb-9435a21880d7@redhat.com>
Date: Tue, 12 Apr 2022 10:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 03/32] virtio_ring: update the document of the
 virtqueue_detach_unused_buf for queue reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-4-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBBZGRlZCBkb2N1
bWVudGF0aW9uIGZvciB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYsIGFsbG93aW5nIGl0IHRv
IGJlCj4gY2FsbGVkIG9uIHF1ZXVlIHJlc2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGI4NzEzMGM4ZjMxMi4uZjE4MDdmNmIw
NmE1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTIxMjcsOCArMjEyNyw4IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZCk7Cj4gICAgKiBAX3ZxOiB0
aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ICAgICoKPiAgICAqIFJl
dHVybnMgTlVMTCBvciB0aGUgImRhdGEiIHRva2VuIGhhbmRlZCB0byB2aXJ0cXVldWVfYWRkXyoo
KS4KPiAtICogVGhpcyBpcyBub3QgdmFsaWQgb24gYW4gYWN0aXZlIHF1ZXVlOyBpdCBpcyB1c2Vm
dWwgb25seSBmb3IgZGV2aWNlCj4gLSAqIHNodXRkb3duLgo+ICsgKiBUaGlzIGlzIG5vdCB2YWxp
ZCBvbiBhbiBhY3RpdmUgcXVldWU7IGl0IGlzIHVzZWZ1bCBmb3IgZGV2aWNlCj4gKyAqIHNodXRk
b3duIG9yIHRoZSByZXNldCBxdWV1ZS4KPiAgICAqLwo+ICAgdm9pZCAqdmlydHF1ZXVlX2RldGFj
aF91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
