Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788BAC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 05:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FD4742479;
	Fri,  7 Jan 2022 05:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iSi0UgEQzDzW; Fri,  7 Jan 2022 05:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5035C401A4;
	Fri,  7 Jan 2022 05:51:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34DA5C002F;
	Fri,  7 Jan 2022 05:51:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72E9BC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60F2883774
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLWYa28yhPRr
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5B8B837AC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 05:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641534667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3Z14jSfG95v5OT0JauPCcbhENpcmv0EeMRM+F9ae/g=;
 b=DMvZM+JbxGKWCvH7Mo+EH5XmM30QsNIK4f7Feulz9/GoKgg0/f6mNcHTCqtLJ+wwkjSCtB
 MdEKOIO3DjRzpW2UPGlFMq5YfZDqbGUwLaIgoN2T7lT+AOXmExwLLhBpQq1i+USP8+bU1a
 qXbvmCbI4zVNcaCj7oVVCFWzAfP2AKc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-fh6F2la7OVOeCTURvYfQQA-1; Fri, 07 Jan 2022 00:51:06 -0500
X-MC-Unique: fh6F2la7OVOeCTURvYfQQA-1
Received: by mail-pf1-f200.google.com with SMTP id
 w189-20020a6262c6000000b004ba80a30727so3184825pfb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 21:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=G3Z14jSfG95v5OT0JauPCcbhENpcmv0EeMRM+F9ae/g=;
 b=yVh2DG4byc0vrEfyyFK3b4D5yIy1SkxB4jvDMrSNJuiATEi10T1U3NCSURpGnA/m1S
 ErO23Co9vRAL9jM1DuJTZvhXCZFVIVF/Jh7jVvgq1Hwdf9MrdMyzp/54zuyLaW34F7H9
 rNT+TBHDn2zO2THcIdtKrLFseJubwU3YvzmCk3TLrjmjgTatTnPGthalIv+GbNXNXbZG
 YZsouPO2NwnaMNG5vg3OVVDh1G3LBTgp1+FlHY08kekAxygqEcryKP/pHqrCUiG6gJuP
 JOKRcmS8iC3SlUBl+EouZuboA6Q0p5AarJPBjVvZf6I5j+mF9Q0sHq/GCpzU71z00e74
 KblQ==
X-Gm-Message-State: AOAM533rwWR0J70uBPkNkubCViXqZ/Yi8QBNA5/Koebe8bVmIzgkcoAR
 3N5SWvEICMdEfHjm5Ps53EmrQNzxMVOXqFOrbwbo4s9cd6ytf8iqzxT+lTSWr8s4YypnfUgxD8z
 S4GpV4AIbPvDOb6L9LOmzQYKHdKAM0oKTiNDUY6STuw==
X-Received: by 2002:a17:90b:4b0f:: with SMTP id
 lx15mr14238033pjb.232.1641534665539; 
 Thu, 06 Jan 2022 21:51:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMBk4SQv5XxQsNYnAlFoYn7itGcSif3ewhEezRQxw/Uk+W6Wpr1kKmyDEHDtiu6dSqRZGBOw==
X-Received: by 2002:a17:90b:4b0f:: with SMTP id
 lx15mr14238024pjb.232.1641534665310; 
 Thu, 06 Jan 2022 21:51:05 -0800 (PST)
Received: from [10.72.13.245] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ke3sm7688910pjb.46.2022.01.06.21.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jan 2022 21:51:04 -0800 (PST)
Message-ID: <e661dde4-d5a3-80f9-10a3-431cfd8571d3@redhat.com>
Date: Fri, 7 Jan 2022 13:51:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 13/14] vdpa: Use BIT_ULL for bit operations
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-14-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220105114646.577224-14-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

CuWcqCAyMDIyLzEvNSDkuIvljYg3OjQ2LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IEFsbCBtYXNrcyBp
biB0aGlzIGZpbGUgYXJlIDY0IGJpdHMuIENoYW5nZSBCSVQgdG8gQklUX1VMTC4KPgo+IE90aGVy
IG9jY3VyZW5jZXMgdXNlICgxIDw8IHZhbCkgd2hpY2ggeWllbGRzIGEgMzIgYml0IHZhbHVlLiBD
aGFuZ2UgdGhlbQo+IHRvIHVzZSBCSVRfVUxMIHRvby4KPgo+IFJldmlld2VkLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxl
bGljQG52aWRpYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgfCAxMiArKysrKystLS0tLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiBpbmRl
eCAzNGZhMjUxZGI4Y2MuLjQzODAzNjdkMDBiNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEv
dmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IEBAIC01OTAsOSArNTkwLDkgQEAg
dmRwYV9ubF9jbWRfbWdtdGRldl9nZXRfZHVtcGl0KHN0cnVjdCBza19idWZmICptc2csIHN0cnVj
dCBuZXRsaW5rX2NhbGxiYWNrICpjYikKPiAgIAlyZXR1cm4gbXNnLT5sZW47Cj4gICB9Cj4gICAK
PiAtI2RlZmluZSBWRFBBX0RFVl9ORVRfQVRUUlNfTUFTSyAoKDEgPDwgVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01BQ0FERFIpIHwgXAo+IC0JCQkJICgxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
VFUpIHwgXAo+IC0JCQkJICgxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQKSkKPiAr
I2RlZmluZSBWRFBBX0RFVl9ORVRfQVRUUlNfTUFTSyAoQklUX1VMTChWRFBBX0FUVFJfREVWX05F
VF9DRkdfTUFDQUREUikgfCBcCj4gKwkJCQkgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdf
TVRVKSAgICAgfCBcCj4gKwkJCQkgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZR
UCkpCj4gICAKPiAgIHN0YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2FkZF9zZXRfZG9pdChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQo+ICAgewo+IEBAIC02MTEs
MTIgKzYxMSwxMiBAQCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2RvaXQoc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGdlbmxfaW5mbyAqaQo+ICAgCWlmIChubF9hdHRyc1tW
RFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUl0pIHsKPiAgIAkJbWFjYWRkciA9IG5sYV9kYXRh
KG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSk7Cj4gICAJCW1lbWNweShj
b25maWcubmV0Lm1hYywgbWFjYWRkciwgc2l6ZW9mKGNvbmZpZy5uZXQubWFjKSk7Cj4gLQkJY29u
ZmlnLm1hc2sgfD0gKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpOwo+ICsJCWNv
bmZpZy5tYXNrIHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpOwo+ICAg
CX0KPiAgIAlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVV0pIHsKPiAgIAkJ
Y29uZmlnLm5ldC5tdHUgPQo+ICAgCQkJbmxhX2dldF91MTYobmxfYXR0cnNbVkRQQV9BVFRSX0RF
Vl9ORVRfQ0ZHX01UVV0pOwo+IC0JCWNvbmZpZy5tYXNrIHw9ICgxIDw8IFZEUEFfQVRUUl9ERVZf
TkVUX0NGR19NVFUpOwo+ICsJCWNvbmZpZy5tYXNrIHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01UVSk7Cj4gICAJfQo+ICAgCWlmIChubF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9D
RkdfTUFYX1ZRUF0pIHsKPiAgIAkJY29uZmlnLm5ldC5tYXhfdnFfcGFpcnMgPQo+IEBAIC04Mjgs
NyArODI4LDcgQEAgc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LAo+ICAgewo+ICAgCXUxNiB2YWxfdTE2Owo+ICAgCj4gLQlpZiAo
KGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX05FVF9GX01RKSkgPT0gMCkKPiArCWlmICgoZmVh
dHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSkpID09IDApCj4gICAJCXJldHVybiAwOwo+
ICAgCj4gICAJdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9wYWly
cyk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
