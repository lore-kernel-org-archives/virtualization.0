Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A70C433FE
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D12DA60EB2;
	Tue, 17 May 2022 03:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XkSvlmadHJg; Tue, 17 May 2022 03:28:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79047606EB;
	Tue, 17 May 2022 03:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E886C0039;
	Tue, 17 May 2022 03:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A537C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEA9860C0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j0xME9MSU9qL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26F53606EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652758096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfYvqJbjgIc7IOH7luShABxjaUL4wbt2DabfVbbSuQY=;
 b=XGjOSWdmdVZ7WT6B/1EpoDNWeavdYtK50lL1zk2OSZPbs9y3cYNOH4Af7FJlI/kkEYg0Dy
 h1bXSLXiSASX2nn8nbLfPtIbks6m0Y6QBgzLyWPsGo5yZQgVHXHgFJBcnJ3YxFptj1n/SA
 rwcYVRAnTpKDSU/Et5O2GBiUe60G9s8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-F1V-fz_GM7W6egFKUPm8eg-1; Mon, 16 May 2022 23:28:14 -0400
X-MC-Unique: F1V-fz_GM7W6egFKUPm8eg-1
Received: by mail-pj1-f72.google.com with SMTP id
 e1-20020a17090a118100b001df53dfd969so2418363pja.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rfYvqJbjgIc7IOH7luShABxjaUL4wbt2DabfVbbSuQY=;
 b=ij1IJX9Ca2UlwqD8ka3cp40GlZ3NjoQIVNRD7PacfV0+kw+YjsKJXr8fxN4YbNypMF
 b5W2cgSDN/r4Wn9O1BD3E/1NmIr8UZNYPx2jzyPJKYc8W3RWAcWXDMJx1pLDqnQYoI6B
 tINiS6ZLB9c0gH18Oura07Ptqc35RJ4QrycwJrLsLkjY5XCTHQC9h0QYcRtyn1t/mnF5
 oI8QbCA4tlykeXckrqhZXIu5RpRUPjcuRWbgRpo3YM3YvVUPT1iPjt+22LU913MX0Zpv
 2+GTgpwfzPlLVvOwwPFD9zkcpM2P5lB1UQCh/ZxuRRy0AyeNa4rIMYsbW5eshEU2C3pP
 XBGQ==
X-Gm-Message-State: AOAM5300MBrdxyPAGQyEi4Py4FRLK09nnT2a4KrirmHpw//NbWY4Ta4l
 iJsa0KbANItaaFtlvRn+E6WQ4BVqFth5fTyQ/BnSyp/EkhSQxNwPFHIhM43Kuz5Gzs3cliKm99H
 74vV35mSGQ3zQ45EKtUebR+ajPFzNHknkxh54m3bA5A==
X-Received: by 2002:a17:903:481:b0:161:6392:c350 with SMTP id
 jj1-20020a170903048100b001616392c350mr11164675plb.17.1652758093869; 
 Mon, 16 May 2022 20:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcho+1XA6XGgxnYg/Y2IsRg7C3bdSswe87qHKCL4IJN9KidQ3XE5xYGtPSDW52SHG/CnEnJA==
X-Received: by 2002:a17:903:481:b0:161:6392:c350 with SMTP id
 jj1-20020a170903048100b001616392c350mr11164653plb.17.1652758093627; 
 Mon, 16 May 2022 20:28:13 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a63ee57000000b003db8f00aba0sm7553245pgk.0.2022.05.16.20.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:28:13 -0700 (PDT)
Message-ID: <8fd59dd7-9d9e-4f08-e595-1557e9caf313@redhat.com>
Date: Tue, 17 May 2022 11:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 7/8] vhost-test: drop flush after vhost_dev_cleanup
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-8-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-8-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IFRoZSBmbHVzaCBh
ZnRlciB2aG9zdF9kZXZfY2xlYW51cCBpcyBub3QgbmVlZGVkIGJlY2F1c2U6Cj4KPiAxLiBJdCBk
b2Vzbid0IGRvIGFueXRoaW5nLiB2aG9zdF9kZXZfY2xlYW51cCB3aWxsIHN0b3AgdGhlIHdvcmtl
ciB0aHJlYWQKPiBzbyB0aGUgZmx1c2ggY2FsbCB3aWxsIGp1c3QgcmV0dXJuIHNpbmNlIHRoZSB3
b3JrZXIgaGFzIG5vdCBkZXZpY2UuCj4KPiAyLiBJdCdzIG5vdCBuZWVkZWQuIFRoZSBjb21tZW50
IGFib3V0IGpvYnMgcmUtcXVldWVpbmcgdGhlbXNlbHZlcyBkb2VzCj4gbm90IGxvb2sgY29ycmVj
dCBiZWNhdXNlIGhhbmRsZV92cSBkb2VzIG5vdCByZXF1ZXVlIHdvcmsuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmhvc3QvdGVzdC5jIHwgMyAtLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdGVzdC5jIGIvZHJpdmVycy92aG9zdC90ZXN0
LmMKPiBpbmRleCA4MzcxNDhkMGE2YTguLmE2M2E2MjZhNTU0ZSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3Rlc3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gQEAgLTE1OCw5
ICsxNTgsNiBAQCBzdGF0aWMgaW50IHZob3N0X3Rlc3RfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZikKPiAgIAl2aG9zdF90ZXN0X2ZsdXNoKG4pOwo+ICAgCXZob3N0
X2Rldl9zdG9wKCZuLT5kZXYpOwo+ICAgCXZob3N0X2Rldl9jbGVhbnVwKCZuLT5kZXYpOwo+IC0J
LyogV2UgZG8gYW4gZXh0cmEgZmx1c2ggYmVmb3JlIGZyZWVpbmcgbWVtb3J5LAo+IC0JICogc2lu
Y2Ugam9icyBjYW4gcmUtcXVldWUgdGhlbXNlbHZlcy4gKi8KPiAtCXZob3N0X3Rlc3RfZmx1c2go
bik7Cj4gICAJa2ZyZWUobi0+ZGV2LnZxcyk7Cj4gICAJa2ZyZWUobik7Cj4gICAJcmV0dXJuIDA7
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
