Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889F4C6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ED8760F17;
	Thu, 16 Mar 2023 09:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ED8760F17
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AK46mX/h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aY2r49W7vKn; Thu, 16 Mar 2023 09:25:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81A3960B31;
	Thu, 16 Mar 2023 09:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81A3960B31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66590C0035;
	Thu, 16 Mar 2023 09:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4946C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD3B481F69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD3B481F69
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AK46mX/h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQftnQ8CaeaS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03FBA81F68
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03FBA81F68
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678958741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+6mrc9lcRETyQg/w4ndpwijr7SMvLTIz9AM+IjnlgM=;
 b=AK46mX/hlwtbLIIL61DWuRdm04GdfDZ6g37BJCUoG0XOW0s/8frDg1Rge+XzJTxnmMuxei
 XGC3+Q/2MIZ+FeZ61xWoCLAceYJBVcJ7at67g35RgU4eD27cB6R2fzlVE/K79LDAtl4604
 +p7URm/rWw4OsnjQeW9neY+O92zit78=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-dlZVvlm7NU6gqh1RqCRU9g-1; Thu, 16 Mar 2023 05:25:39 -0400
X-MC-Unique: dlZVvlm7NU6gqh1RqCRU9g-1
Received: by mail-pj1-f69.google.com with SMTP id
 p5-20020a17090a428500b0023b4776f0daso638753pjg.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678958738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+6mrc9lcRETyQg/w4ndpwijr7SMvLTIz9AM+IjnlgM=;
 b=dwySDpcD/Yj7u8oOokuf+RTRDr5HBX9L6MHjNf/EpRGkym9AhGYbBgNlO9q5gH183E
 he2mLzBNgFDL1s4Kv/9qhtRbw7AJEuu8NmvSjs1maNVLAcwd1x0tfucFo5I4zWzwN3Bi
 OQFwWHOy7vNv1QfPSNcW89ptSduwRb9EomU/RBaC8PwmEGihvpTv4/DO+HgK0EQXFJ7C
 w15zjK0OHKcY7sfNVQlObnWyWner2iwXcPK5OPBiIiM8MB2X6WeCWuyo9TGW/d+3eFf3
 tIQQrg0u74c1acgu2aAV5sccfoSB7zT1bCIwMhTkTdGmUvdcjK6ANpZsxTfEIc2s74F8
 b2AQ==
X-Gm-Message-State: AO0yUKW7L0qQAZ4A3QMrGdwox///DOFPlz7K2Zj2MRl5KndiCSdJWiNh
 Ebwts7Prfp95bUx1UQujLbUSDozqSznZFqvYOnLPcb9R0eW9vWMtuTkCDW/f0ak+4pmkNrfyN8s
 nL4UIfbwBjP0r2Aew9BJLk4dWQzdIrxqrB3j1Ll6sJg==
X-Received: by 2002:a05:6a20:6a9e:b0:cc:4118:7609 with SMTP id
 bi30-20020a056a206a9e00b000cc41187609mr2565269pzb.37.1678958738547; 
 Thu, 16 Mar 2023 02:25:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set/8ZIHUolDDxHyTi2C1eWuj/ZBB/IpACATprS/zOASEkDwrXA7eKsOTvDqvAFgzJ/3Sf9Rvqw==
X-Received: by 2002:a05:6a20:6a9e:b0:cc:4118:7609 with SMTP id
 bi30-20020a056a206a9e00b000cc41187609mr2565255pzb.37.1678958738283; 
 Thu, 16 Mar 2023 02:25:38 -0700 (PDT)
Received: from [10.72.13.123] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa785cd000000b005a852875590sm4996746pfn.113.2023.03.16.02.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Mar 2023 02:25:37 -0700 (PDT)
Message-ID: <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
Date: Thu, 16 Mar 2023 17:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-9-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230228094110.37-9-xieyongji@bytedance.com>
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

CuWcqCAyMDIzLzIvMjggMTc6NDEsIFhpZSBZb25namkg5YaZ6YGTOgo+IEFkZCBldmVudGZkIGZv
ciB0aGUgdmRwYSBjYWxsYmFjayBzbyB0aGF0IHVzZXIKPiBjYW4gc2lnbmFsIGl0IGRpcmVjdGx5
IGluc3RlYWQgb2YgcnVubmluZyB0aGUKPiBjYWxsYmFjay4gSXQgd2lsbCBiZSB1c2VkIGZvciB2
aG9zdC12ZHBhIGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgfCAy
ICsrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgMSArCj4gICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCAgICAgICAgIHwgMyArKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+IGluZGV4IGRjMTJkYmQ1YjQzYi4uYWU4OWMwY2NjMmJiIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBA
QCAtNTk5LDkgKzU5OSwxMSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCQlpZiAodnEtPmNhbGxf
Y3R4LmN0eCkgewo+ICAgCQkJY2IuY2FsbGJhY2sgPSB2aG9zdF92ZHBhX3ZpcnRxdWV1ZV9jYjsK
PiAgIAkJCWNiLnByaXZhdGUgPSB2cTsKPiArCQkJY2IuaXJxX2N0eCA9IHZxLT5jYWxsX2N0eC5j
dHg7Cj4gICAJCX0gZWxzZSB7Cj4gICAJCQljYi5jYWxsYmFjayA9IE5VTEw7Cj4gICAJCQljYi5w
cml2YXRlID0gTlVMTDsKPiArCQkJY2IuaXJxX2N0eCA9IE5VTEw7Cj4gICAJCX0KPiAgIAkJb3Bz
LT5zZXRfdnFfY2IodmRwYSwgaWR4LCAmY2IpOwo+ICAgCQl2aG9zdF92ZHBhX3NldHVwX3ZxX2ly
cSh2LCBpZHgpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IDllZWU4YWZhYmRhOC4uYTVjZWNh
ZmJjMmQxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gQEAgLTE5NSw2ICsxOTUsNyBAQCB2aXJ0
aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50
IGluZGV4LAo+ICAgCS8qIFNldHVwIHZpcnRxdWV1ZSBjYWxsYmFjayAqLwo+ICAgCWNiLmNhbGxi
YWNrID0gY2FsbGJhY2sgPyB2aXJ0aW9fdmRwYV92aXJ0cXVldWVfY2IgOiBOVUxMOwo+ICAgCWNi
LnByaXZhdGUgPSBpbmZvOwo+ICsJY2IuaXJxX2N0eCA9IE5VTEw7Cj4gICAJb3BzLT5zZXRfdnFf
Y2IodmRwYSwgaW5kZXgsICZjYik7Cj4gICAJb3BzLT5zZXRfdnFfbnVtKHZkcGEsIGluZGV4LCB2
aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodnEpKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggMTBiZDIyMzg3Mjc2
Li45NGE3ZWM0OTU4M2EgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC0xMywxMCArMTMsMTMgQEAKPiAgICAqIHN0cnVj
dCB2ZHBhX2NhbGxsYmFjayAtIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPiAgICAqIEBjYWxs
YmFjazogaW50ZXJydXB0IGNhbGxiYWNrIGZ1bmN0aW9uCj4gICAgKiBAcHJpdmF0ZTogdGhlIGRh
dGEgcGFzc2VkIHRvIHRoZSBjYWxsYmFjayBmdW5jdGlvbgo+ICsgKiBAaXJxX2N0eDogdGhlIGV2
ZW50ZmQgZm9yIHRoZSBjYWxsYmFjaywgdXNlciBjYW4gc2lnbmFsCj4gKyAqICAgICAgICAgICBp
dCBkaXJlY3RseSBpbnN0ZWFkIG9mIHJ1bm5pbmcgdGhlIGNhbGxiYWNrCgoKSSdkIHN1Z2dlc3Qg
dG8gZG8gbW9yZSB0d2Vha3MgdG8gbWVudGlvbjoKCjEpIGlycV9jdHggaXMgb3B0aW9uYWwKMikg
dGhhdCB3aGVuIHRoZSBpcnFfY3R4IGlzIHNldCwgdGhlIHZEUEEgZHJpdmVyIG11c3QgZ3VhcmFu
dGVlIHRoYXQgCnNpZ25hbGluZyBpdCBpcyBmdW5jdGlvbmFsIGVxdWl2YWxlbnQgdG8gdHJpZ2dl
cmluZyB0aGUgY2FsbGJhY2suIFdoZW4gCnNldCwgdkRQQSBwYXJlbnQgY2FuIHNpZ25hbCBpdCBk
aXJlY3RseSBpbnN0ZWFkIG9mIHRyaWdnZXJpbmcgdGhlIGNhbGxiYWNrLgoKPiAgICAqLwo+ICAg
c3RydWN0IHZkcGFfY2FsbGJhY2sgewo+ICAgCWlycXJldHVybl90ICgqY2FsbGJhY2spKHZvaWQg
KmRhdGEpOwo+ICAgCXZvaWQgKnByaXZhdGU7Cj4gKwlzdHJ1Y3QgZXZlbnRmZF9jdHggKmlycV9j
dHg7CgoKVGhlcmUncyBubyBJUlEgY29uY2VwdCBhdCB0aGUgdmlydHVhbCB2RFBBIGJ1cyBsZXZl
bCwgc28gaXQncyBwcm9iYWJseSAKYmV0dGVyIHRvIHJlbmFtZSBpdCBhcyAidHJpZ2dlciIuCgpC
dHcsIHNob3VsZCB3ZSBzZWxlY3QgRVZFTlRGRCBmb3IgdkRQQT8KClRoYW5rcwoKCj4gICB9Owo+
ICAgCj4gICAvKioKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
