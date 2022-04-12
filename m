Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E657C4332F
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 03:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD3C2415B7;
	Tue, 12 Apr 2022 03:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25Q_eXjQG-Py; Tue, 12 Apr 2022 03:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E705441511;
	Tue, 12 Apr 2022 03:31:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F42BC0033;
	Tue, 12 Apr 2022 03:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C6ACC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 428AC60EDA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9VebNWMOI2At
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71FFE60ECD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649734283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eb+Gzab3jr62PJIS60DbGOqSCN3+xOrWtJx9HNjsDg=;
 b=iTzp+csEX+0whsPH7vlq3Pl5WVUoqAheRtlYnPzv2zeDha6Hpqr+wDt9kjX4KznlxMsONj
 BZuh3Il20YKisQVz5TUEDgM1pdzNrgxBJhbBeweDvYj73D7rppuL2bn4c9aTJ77JveK9oK
 FgEa1weEMAmvp8AVsMYsyOjRV/Ti4Oo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-W5JRT3JOP4ePvNI2wFyHSw-1; Mon, 11 Apr 2022 23:31:20 -0400
X-MC-Unique: W5JRT3JOP4ePvNI2wFyHSw-1
Received: by mail-pf1-f200.google.com with SMTP id
 x2-20020a628602000000b005057a9b1675so6898787pfd.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 20:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5eb+Gzab3jr62PJIS60DbGOqSCN3+xOrWtJx9HNjsDg=;
 b=JLMjULfv5LsFQKUE3cUY4P4JbwRRV788NF2GgM4mRJT58HcAKnzA8qwdAMlP2UkKwR
 Y+k2ADskabNY6soU0IKIpLMks1qqo+XzjyU55JBRo8KTU6tZJeMyfqXM3d0lmFGBPbMc
 QA5g9e94mzmBlMIo8uHE/eL4ID9AUrmJSTXizTEzq4588TOFVUtwKDgoVLjluflF0pAx
 nysgzjldJsu6bbR5XzYsUMMp3WTeUqyDSwwB/u3ot+6U+S+D3fLcypdv9toe2eOgvYRs
 e/P8x1A2qDZ9eoOUlqDJ9YriFXbdEkQFgl+vCkaWCjbdcXjrrhALpqzwBZQGlweAj/xV
 IURg==
X-Gm-Message-State: AOAM530V6gVxxFp2vNTOUqAUi4+e3l93YmHjDwts6vKuoFYsD6bycnNp
 vjJUcqK9lSRQA5iUEPSqVmly2Xf9T5AQi6gaHvx/uM2v6MzNGebtWtza1gA8RQ8CDnyROR1eXra
 rbfOq1px+KBpM44rIf/d4BcvoAQSQPvaIa6Dr6o9XEQ==
X-Received: by 2002:a63:3fc7:0:b0:398:aad3:3ce1 with SMTP id
 m190-20020a633fc7000000b00398aad33ce1mr28475489pga.461.1649734279083; 
 Mon, 11 Apr 2022 20:31:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz47KljxbHDCRWoq3Z8n63z/qIZIEy7qpHO2PYfQHRukhkqpY0pZKdUv2yQALElEze5aAFBww==
X-Received: by 2002:a63:3fc7:0:b0:398:aad3:3ce1 with SMTP id
 m190-20020a633fc7000000b00398aad33ce1mr28475463pga.461.1649734278851; 
 Mon, 11 Apr 2022 20:31:18 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a637204000000b00398522203a2sm1029161pgc.80.2022.04.11.20.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 20:31:18 -0700 (PDT)
Message-ID: <28237db0-cf04-aa36-b7b8-de55b11d18db@redhat.com>
Date: Tue, 12 Apr 2022 11:31:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 08/32] virtio_ring: split: extract the logic of attach
 vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2YgYXR0YWNoIHZyaW5nLCBzdWJzZXF1ZW50IHBhdGNoZXMgd2lsbCBjYWxsIGl0
Cj4gc2VwYXJhdGVseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwg
MjAgKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNmRlNjc0Mzlj
YjU3Li4wODNmMjk5MmJhMGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtOTE2LDYgKzkx
NiwxOSBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmX3NwbGl0KHN0
cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICtzdGF0
aWMgdm9pZCB2cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gKwkJCQkJIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3NwbGl0ICpkZXNjX3N0YXRlLAo+ICsJCQkJCSBzdHJ1Y3QgdnJpbmdfZGVz
Y19leHRyYSAqZGVzY19leHRyYSkKPiArewo+ICsJdnEtPnNwbGl0LnZyaW5nID0gdnJpbmc7Cj4g
Kwl2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwo+ICsJdnEtPnNwbGl0LnF1ZXVlX3NpemVf
aW5fYnl0ZXMgPSAwOwoKCkFueSByZWFzb24gdG8gYWRkIHRoZSBhYm92ZSB0d28gYXNzaWdubWVu
dCBpbiBhdHRhY2g/IEl0IHNlZW1zIGJlbG9uZyB0byAKZnJlZSBvciByZXNldC4KClRoYW5rcwoK
Cj4gKwo+ICsJdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBkZXNjX3N0YXRlOwo+ICsJdnEtPnNwbGl0
LmRlc2NfZXh0cmEgPSBkZXNjX2V4dHJhOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2cmluZ19h
bGxvY19zdGF0ZV9leHRyYV9zcGxpdCh1MzIgbnVtLAo+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rl
c2Nfc3RhdGVfc3BsaXQgKipkZXNjX3N0YXRlLAo+ICAgCQkJCQkgc3RydWN0IHZyaW5nX2Rlc2Nf
ZXh0cmEgKipkZXNjX2V4dHJhKQo+IEBAIC0yMjYyLDEwICsyMjc1LDYgQEAgc3RydWN0IHZpcnRx
dWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlpZiAo
dmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX09SREVSX1BMQVRGT1JNKSkKPiAgIAkJ
dnEtPndlYWtfYmFycmllcnMgPSBmYWxzZTsKPiAgIAo+IC0JdnEtPnNwbGl0LnF1ZXVlX2RtYV9h
ZGRyID0gMDsKPiAtCXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPiAtCj4gLQl2
cS0+c3BsaXQudnJpbmcgPSB2cmluZzsKPiAgIAl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93
ID0gMDsKPiAgIAl2cS0+c3BsaXQuYXZhaWxfaWR4X3NoYWRvdyA9IDA7Cj4gICAKPiBAQCAtMjI4
Myw4ICsyMjkyLDcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVu
c2lnbmVkIGludCBpbmRleCwKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAJfQo+ICAgCj4gLQl2cS0+
c3BsaXQuZGVzY19zdGF0ZSA9IHN0YXRlOwo+IC0JdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSBleHRy
YTsKPiArCXZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQodnEsIHZyaW5nLCBzdGF0ZSwgZXh0
cmEpOwo+ICAgCj4gICAJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiAgIAl2
cS0+ZnJlZV9oZWFkID0gMDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
