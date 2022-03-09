Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169EC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 851C74049E;
	Wed,  9 Mar 2022 09:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRL9Tp2KdiZK; Wed,  9 Mar 2022 09:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9CE44002B;
	Wed,  9 Mar 2022 09:06:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A965C0012;
	Wed,  9 Mar 2022 09:06:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE9AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E7108429B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GH-qYuOACDXs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:06:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A92B982835
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646816806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmarRpfjcD+wJIBdiG5Aw9gDSJ+EPWEuC8CvMx7WuN8=;
 b=P9tvPzIMow6o0bHh4eH7O7pzyZsLVvlMQZTNT5u3hv2SV5jFUDUBXhczg3ltfpTqXJeYPm
 cn9CrBh6RyNjKDf/Zb20Io+aBeRztejVQu0ApG5SGIeEml2rmMmurfsmApq3ikKxZkBNfd
 4UNgnzovL0hikNrXNFXN6FQ1FX0Oum0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Jj6kus71MTulOJobiJlgsQ-1; Wed, 09 Mar 2022 04:06:43 -0500
X-MC-Unique: Jj6kus71MTulOJobiJlgsQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 z14-20020a170902ccce00b0014d7a559635so827649ple.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dmarRpfjcD+wJIBdiG5Aw9gDSJ+EPWEuC8CvMx7WuN8=;
 b=oTAG7ryG8C3DHq8HZ8aWh+6YGA1jGLus1vtprePaCgLF5z6JE9Nl3oBpw+h54pR+f8
 0ZcZQ0XtNgU0Pwx000g4uPBGPN3z6LhTxQcJEbJqCBZprr0/lovNNPF7bf9gihDME1Ol
 bww/xOmsFqtStdYMlnWPAZ+4lYuv7Z3f0Rf430Y+++w1yjwuk/ZsBl7ViPrlV9lFl7vx
 rw+X1mqMLdGgc5k8KILQrUqeSzx+Z28Ux2vCoTaWQmtEHkFQ9FYlr69OwRIkdQ5KjvZo
 GKI0hwdswpJVfVCtpZSjGOEOvDz3+uwZ/Zn5ibbCiIN5SvwKmy+Cn55urS2TqkO4Pf1p
 zobg==
X-Gm-Message-State: AOAM530Gimr0BbctIH12y8YpAjh0/Rgj/F92XWtCdNUfl9QeEiYQ8ITq
 lUSu399N2uE6r2MzdnKS72CSzHlEhqSJ9X2qjhSQujpo+Fm3FwMXslOfVlGC19b1E8dFEzupqfG
 fBNnP6njwYJHblccHb0SgQ0g9yH0fCmNwMb4dT9P7cw==
X-Received: by 2002:a63:854a:0:b0:380:352e:8009 with SMTP id
 u71-20020a63854a000000b00380352e8009mr12892140pgd.292.1646816802500; 
 Wed, 09 Mar 2022 01:06:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9eDcfFxbje1rdv28H7WkiZwFVsxL2GSk9kNibKQYu1fo/Qm/IxgRXDvzx0fDGJ0esSBvzvg==
X-Received: by 2002:a63:854a:0:b0:380:352e:8009 with SMTP id
 u71-20020a63854a000000b00380352e8009mr12892088pgd.292.1646816802085; 
 Wed, 09 Mar 2022 01:06:42 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a17090ad68300b001b8bcd47c35sm5646802pju.6.2022.03.09.01.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 01:06:41 -0800 (PST)
Message-ID: <9049128d-543e-be7b-a0a1-08e9bf94c282@redhat.com>
Date: Wed, 9 Mar 2022 17:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 23/26] virtio_net: split free_unused_bufs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-24-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-24-xuanzhuo@linux.alibaba.com>
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoaXMgcGF0Y2gg
c2VwYXJhdGVzIHR3byBmdW5jdGlvbnMgZm9yIGZyZWVpbmcgc3EgYnVmIGFuZCBycSBidWYgZnJv
bQo+IGZyZWVfdW51c2VkX2J1ZnMoKS4KPgo+IFdoZW4gc3VwcG9ydGluZyB0aGUgZW5hYmxlL2Rp
c2FibGUgdHgvcnEgcXVldWUgaW4gdGhlIGZ1dHVyZSwgaXQgaXMKPiBuZWNlc3NhcnkgdG8gc3Vw
cG9ydCBzZXBhcmF0ZSByZWNvdmVyeSBvZiBhIHNxIGJ1ZiBvciBhIHJxIGJ1Zi4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiBpbmRleCA1OWIxZWE4MmY1ZjAuLjQwOWE4ZTE4MDkxOCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBAQCAtMjgwNCwzNiArMjgwNCw0NSBAQCBzdGF0aWMgdm9pZCBmcmVlX3JlY2Vp
dmVfcGFnZV9mcmFncyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAkJCXB1dF9wYWdlKHZp
LT5ycVtpXS5hbGxvY19mcmFnLnBhZ2UpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGZyZWVf
dW51c2VkX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gK3N0YXRpYyB2b2lkIHZpcnRu
ZXRfc3FfZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArCQkJCQlz
dHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EpCj4gICB7Cj4gICAJdm9pZCAqYnVmOwo+IC0JaW50IGk7Cj4g
ICAKPiAtCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAtCQlz
dHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5zcVtpXS52cTsKPiAtCQl3aGlsZSAoKGJ1ZiA9IHZp
cnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpIHsKPiAtCQkJaWYgKCFpc194
ZHBfZnJhbWUoYnVmKSkKPiAtCQkJCWRldl9rZnJlZV9za2IoYnVmKTsKPiAtCQkJZWxzZQo+IC0J
CQkJeGRwX3JldHVybl9mcmFtZShwdHJfdG9feGRwKGJ1ZikpOwo+IC0JCX0KPiArCXdoaWxlICgo
YnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHNxLT52cSkpICE9IE5VTEwpIHsKPiAr
CQlpZiAoIWlzX3hkcF9mcmFtZShidWYpKQo+ICsJCQlkZXZfa2ZyZWVfc2tiKGJ1Zik7Cj4gKwkJ
ZWxzZQo+ICsJCQl4ZHBfcmV0dXJuX2ZyYW1lKHB0cl90b194ZHAoYnVmKSk7Cj4gICAJfQo+ICt9
Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiAt
CQlzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5ycVtpXS52cTsKPiAtCj4gLQkJd2hpbGUgKChi
dWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKSB7Cj4gLQkJCWlm
ICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpIHsKPiAtCQkJCXB1dF9wYWdlKHZpcnRfdG9faGVhZF9w
YWdlKGJ1ZikpOwo+IC0JCQl9IGVsc2UgaWYgKHZpLT5iaWdfcGFja2V0cykgewo+IC0JCQkJZ2l2
ZV9wYWdlcygmdmktPnJxW2ldLCBidWYpOwo+IC0JCQl9IGVsc2Ugewo+IC0JCQkJcHV0X3BhZ2Uo
dmlydF90b19oZWFkX3BhZ2UoYnVmKSk7Cj4gLQkJCX0KPiAtCQl9Cj4gK3N0YXRpYyB2b2lkIHZp
cnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArCQkJ
CQlzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gK3sKPiArCXZvaWQgKmJ1ZjsKPiArCj4gKwl3
aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihycS0+dnEpKSAhPSBOVUxM
KSB7Cj4gKwkJaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykKPiArCQkJcHV0X3BhZ2UodmlydF90
b19oZWFkX3BhZ2UoYnVmKSk7Cj4gKwkJZWxzZSBpZiAodmktPmJpZ19wYWNrZXRzKQo+ICsJCQln
aXZlX3BhZ2VzKHJxLCBidWYpOwo+ICsJCWVsc2UKPiArCQkJcHV0X3BhZ2UodmlydF90b19oZWFk
X3BhZ2UoYnVmKSk7Cj4gICAJfQo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGZyZWVfdW51c2Vk
X2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gK3sKPiArCWludCBpOwo+ICsKPiArCWZv
ciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4gKwkJdmlydG5ldF9zcV9m
cmVlX3VudXNlZF9idWZzKHZpLCB2aS0+c3EgKyBpKTsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwg
dmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKQo+ICsJCXZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVm
cyh2aSwgdmktPnJxICsgaSk7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2aXJ0bmV0X2RlbF92
cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gICB7Cj4gICAJc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYgPSB2aS0+dmRldjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
