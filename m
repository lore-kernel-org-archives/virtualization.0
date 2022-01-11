Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21277C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 04:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A259782FA5;
	Tue, 11 Jan 2022 04:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DET7vzm8JRi0; Tue, 11 Jan 2022 04:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 279B082F20;
	Tue, 11 Jan 2022 04:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4D4DC002F;
	Tue, 11 Jan 2022 04:06:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A150C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4F1D410AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEUDr7sm8zqb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 694C6410A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641873961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j57iOHdt0+hHkG5NMCwdg6XG2RVl9jKj5pe7d1y/oaY=;
 b=QYR6Nfgxoj0f5gUTnR7JN/BiR2t79cqdtlDsi8OvkFBWMaWVgfR782hO6LfM96TfLBNB94
 /+afy7kpiIwAY8zaqOF+KOQBM3zzwSKD5OAN0zxf5K2kyDpaUtM7fp5p8xUCIP48vCMDG5
 KEBC4RDSXetrXcynP+43xizriSOG3X4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-hcGgC6xQO9u_SwvvWsLPuQ-1; Mon, 10 Jan 2022 23:05:59 -0500
X-MC-Unique: hcGgC6xQO9u_SwvvWsLPuQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 x15-20020a17090a46cf00b001b35ee9643fso1411729pjg.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 20:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=j57iOHdt0+hHkG5NMCwdg6XG2RVl9jKj5pe7d1y/oaY=;
 b=MB5EuwAn6s+sWWsmpcsbzIBqAo2Hozkjz3mEu1zBIMSw6zkGpX8GrzBv/tTnEI6kPK
 vC4Zf/XgpShHGxpD42clV7qG5bayCUf94UmiFJMfhNNu4xPtNERXBG/204G+S3CZRuuL
 HFBWGnC+GPxaAImTjcLNmuNqqImSeHwn8K+AfvQ7N1rWedjp3fjcL5Be2V5dOG5kxqo+
 SnitfGv/XJ7WEFiD8yehXyTlq/iGLQgQxAaD5se/6SMH9Y6KmDLY6tSRkFtiPdlarQQ9
 stUNdorqW6VVepbuMXJyCumQqG56O+l3aSp260UFqA9zdu+pTD42Qc3muj1g2n3aAzI8
 6rxA==
X-Gm-Message-State: AOAM533+sfD5MoH+Xi2LcQycJtXW14dGbvsJZaT8owEEnInFWfl/GD76
 YyFKIfHm2kd9L+luUm1w5NJuMbh/ulRbxCj06+7UClDXqPWVG5cY5HF35r+1dNc5MixKHMXO+FG
 KNcKq84oMB+pyJMYsInUW/vWQjPtsYitG+9dMtpMmdw==
X-Received: by 2002:a17:90a:e610:: with SMTP id
 j16mr1108015pjy.139.1641873957961; 
 Mon, 10 Jan 2022 20:05:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiyZ3FXmA3cDHJpzQKJdoRERQuq+I3vTjGX55+gVot2kVqfrz76/R4a7jnSeGoY38thvsbNQ==
X-Received: by 2002:a17:90a:e610:: with SMTP id
 j16mr1107999pjy.139.1641873957633; 
 Mon, 10 Jan 2022 20:05:57 -0800 (PST)
Received: from [10.72.13.222] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d11sm8737373pfu.211.2022.01.10.20.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jan 2022 20:05:57 -0800 (PST)
Message-ID: <60f24351-1011-de84-b443-ff5a50c3ff7f@redhat.com>
Date: Tue, 11 Jan 2022 12:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 3/4] drivers/net/virtio_net: Added RSS hash report.
To: Andrew Melnychenko <andrew@daynix.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, mst@redhat.com
References: <20220109210659.2866740-1-andrew@daynix.com>
 <20220109210659.2866740-4-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220109210659.2866740-4-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

CuWcqCAyMDIyLzEvMTAg5LiK5Y2INTowNiwgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBB
ZGRlZCBmZWF0dXJlcyBmb3IgUlNTIGhhc2ggcmVwb3J0Lgo+IElmIGhhc2ggaXMgcHJvdmlkZWQg
LSBpdCBzZXRzIHRvIHNrYi4KPiBBZGRlZCBjaGVja3MgaWYgcnNzIGFuZC9vciBoYXNoIGFyZSBl
bmFibGVkIHRvZ2V0aGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1lbG55Y2hlbmtvIDxh
bmRyZXdAZGF5bml4LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU2
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4
IDIxNzk0NzMxZmM3NS4uNmU3NDYxYjAxZjg3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yMzEsNiAr
MjMxLDcgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gICAKPiAgIAkvKiBIb3N0IHN1cHBvcnRz
IHJzcyBhbmQvb3IgaGFzaCByZXBvcnQgKi8KPiAgIAlib29sIGhhc19yc3M7Cj4gKwlib29sIGhh
c19yc3NfaGFzaF9yZXBvcnQ7Cj4gICAJdTggcnNzX2tleV9zaXplOwo+ICAgCXUxNiByc3NfaW5k
aXJfdGFibGVfc2l6ZTsKPiAgIAl1MzIgcnNzX2hhc2hfdHlwZXNfc3VwcG9ydGVkOwo+IEBAIC00
MjQsNyArNDI1LDkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwKPiAgIAloZHJfcCA9IHA7Cj4gICAKPiAgIAloZHJfbGVuID0gdmkt
Pmhkcl9sZW47Cj4gLQlpZiAodmktPm1lcmdlYWJsZV9yeF9idWZzKQo+ICsJaWYgKHZpLT5oYXNf
cnNzX2hhc2hfcmVwb3J0KQo+ICsJCWhkcl9wYWRkZWRfbGVuID0gc2l6ZW9mKHN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl92MV9oYXNoKTsKPiArCWVsc2UgaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykK
PiAgIAkJaGRyX3BhZGRlZF9sZW4gPSBzaXplb2YoKmhkcik7Cj4gICAJZWxzZQo+ICAgCQloZHJf
cGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyKTsKPiBAQCAtMTE2MCw2
ICsxMTYzLDggQEAgc3RhdGljIHZvaWQgcmVjZWl2ZV9idWYoc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiAgIAlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
ID0gdmktPmRldjsKPiAgIAlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ICAgCXN0cnVjdCB2aXJ0aW9f
bmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiArCXN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNo
ICpoZHJfaGFzaDsKPiArCWVudW0gcGt0X2hhc2hfdHlwZXMgcnNzX2hhc2hfdHlwZTsKPiAgIAo+
ICAgCWlmICh1bmxpa2VseShsZW4gPCB2aS0+aGRyX2xlbiArIEVUSF9ITEVOKSkgewo+ICAgCQlw
cl9kZWJ1ZygiJXM6IHNob3J0IHBhY2tldCAlaVxuIiwgZGV2LT5uYW1lLCBsZW4pOwo+IEBAIC0x
MTg2LDYgKzExOTEsMjkgQEAgc3RhdGljIHZvaWQgcmVjZWl2ZV9idWYoc3RydWN0IHZpcnRuZXRf
aW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiAgIAkJcmV0dXJuOwo+ICAgCj4g
ICAJaGRyID0gc2tiX3ZuZXRfaGRyKHNrYik7Cj4gKwlpZiAoZGV2LT5mZWF0dXJlcyAmIE5FVElG
X0ZfUlhIQVNIKSB7Cj4gKwkJaGRyX2hhc2ggPSAoc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hh
c2ggKikoaGRyKTsKPiArCj4gKwkJc3dpdGNoIChoZHJfaGFzaC0+aGFzaF9yZXBvcnQpIHsKPiAr
CQljYXNlIFZJUlRJT19ORVRfSEFTSF9SRVBPUlRfVENQdjQ6Cj4gKwkJY2FzZSBWSVJUSU9fTkVU
X0hBU0hfUkVQT1JUX1VEUHY0Ogo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JFUE9SVF9UQ1B2
NjoKPiArCQljYXNlIFZJUlRJT19ORVRfSEFTSF9SRVBPUlRfVURQdjY6Cj4gKwkJY2FzZSBWSVJU
SU9fTkVUX0hBU0hfUkVQT1JUX1RDUHY2X0VYOgo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JF
UE9SVF9VRFB2Nl9FWDoKPiArCQkJcnNzX2hhc2hfdHlwZSA9IFBLVF9IQVNIX1RZUEVfTDQ7Cj4g
KwkJCWJyZWFrOwo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNIX1JFUE9SVF9JUHY0Ogo+ICsJCWNh
c2UgVklSVElPX05FVF9IQVNIX1JFUE9SVF9JUHY2Ogo+ICsJCWNhc2UgVklSVElPX05FVF9IQVNI
X1JFUE9SVF9JUHY2X0VYOgo+ICsJCQlyc3NfaGFzaF90eXBlID0gUEtUX0hBU0hfVFlQRV9MMzsK
PiArCQkJYnJlYWs7Cj4gKwkJY2FzZSBWSVJUSU9fTkVUX0hBU0hfUkVQT1JUX05PTkU6Cj4gKwkJ
ZGVmYXVsdDoKPiArCQkJcnNzX2hhc2hfdHlwZSA9IFBLVF9IQVNIX1RZUEVfTk9ORTsKPiArCQl9
Cj4gKwkJc2tiX3NldF9oYXNoKHNrYiwgaGRyX2hhc2gtPmhhc2hfdmFsdWUsIHJzc19oYXNoX3R5
cGUpOwo+ICsJfQo+ICAgCj4gICAJaWYgKGhkci0+aGRyLmZsYWdzICYgVklSVElPX05FVF9IRFJf
Rl9EQVRBX1ZBTElEKQo+ICAgCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX1VOTkVDRVNTQVJZ
Owo+IEBAIC0yMjMzLDcgKzIyNjEsOCBAQCBzdGF0aWMgYm9vbCB2aXJ0bmV0X2NvbW1pdF9yc3Nf
Y29tbWFuZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAlzZ19zZXRfYnVmKCZzZ3NbM10s
IHZpLT5jdHJsLT5yc3Mua2V5LCBzZ19idWZfc2l6ZSk7Cj4gICAKPiAgIAlpZiAoIXZpcnRuZXRf
c2VuZF9jb21tYW5kKHZpLCBWSVJUSU9fTkVUX0NUUkxfTVEsCj4gLQkJCQkgIFZJUlRJT19ORVRf
Q1RSTF9NUV9SU1NfQ09ORklHLCBzZ3MpKSB7Cj4gKwkJCQkgIHZpLT5oYXNfcnNzID8gVklSVElP
X05FVF9DVFJMX01RX1JTU19DT05GSUcKPiArCQkJCSAgOiBWSVJUSU9fTkVUX0NUUkxfTVFfSEFT
SF9DT05GSUcsIHNncykpIHsKPiAgIAkJZGV2X3dhcm4oJmRldi0+ZGV2LCAiVklSVElPTkVUIGlz
c3VlIHdpdGggY29tbWl0dGluZyBSU1Mgc2dzXG4iKTsKPiAgIAkJcmV0dXJuIGZhbHNlOwo+ICAg
CX0KPiBAQCAtMzIyMCw3ICszMjQ5LDkgQEAgc3RhdGljIGJvb2wgdmlydG5ldF92YWxpZGF0ZV9m
ZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAkgICAgIFZJUlRORVRfRkFJ
TF9PTih2ZGV2LCBWSVJUSU9fTkVUX0ZfTVEsICJWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIpIHx8Cj4g
ICAJICAgICBWSVJUTkVUX0ZBSUxfT04odmRldiwgVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIs
Cj4gICAJCQkgICAgICJWSVJUSU9fTkVUX0ZfQ1RSTF9WUSIpIHx8Cj4gLQkgICAgIFZJUlRORVRf
RkFJTF9PTih2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTLCAiVklSVElPX05FVF9GX1JTUyIpKSkgewo+
ICsJICAgICBWSVJUTkVUX0ZBSUxfT04odmRldiwgVklSVElPX05FVF9GX1JTUywgIlZJUlRJT19O
RVRfRl9SU1MiKSB8fAoKCkkgdGhpbmsgd2Ugc2hvdWxkIG1ha2UgUlNTIGRlcGVuZCBvbiBDVFJM
X1ZRLgoKCj4gKwkgICAgIFZJUlRORVRfRkFJTF9PTih2ZGV2LCBWSVJUSU9fTkVUX0ZfSEFTSF9S
RVBPUlQsCj4gKwkJCSAgICAgIlZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCIpKSkgewoKCk5lZWQg
dG8gZGVwZW5kIG9uIENUUkxfVlEgaGVyZS4KCgo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gICAJfQo+
ICAgCj4gQEAgLTMzNTUsNiArMzM4NiwxMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPiAgIAkJdmktPm1lcmdlYWJsZV9yeF9idWZzID0g
dHJ1ZTsKPiAgIAo+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0Zf
SEFTSF9SRVBPUlQpKSB7Cj4gKwkJdmktPmhhc19yc3NfaGFzaF9yZXBvcnQgPSB0cnVlOwo+ICsJ
CXZpLT5yc3NfaW5kaXJfdGFibGVfc2l6ZSA9IDE7Cj4gKwkJdmktPnJzc19rZXlfc2l6ZSA9IFZJ
UlRJT19ORVRfUlNTX01BWF9LRVlfU0laRTsKCgpBbnkgcmVhc29uIHRvIGluaXRpYWxpemUgUlNT
IGZlYXR1cmUgaGVyZSBub3QgdGhlIGluaXRfZGVmYXVsdF9yc3MoKT8KClRoYW5rcwoKCj4gKwl9
Cj4gKwo+ICAgCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX1JTUykp
IHsKPiAgIAkJdmktPmhhc19yc3MgPSB0cnVlOwo+ICAgCQl2aS0+cnNzX2luZGlyX3RhYmxlX3Np
emUgPQo+IEBAIC0zMzY0LDcgKzM0MDEsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJCQl2aXJ0aW9fY3JlYWQ4KHZkZXYsIG9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgcnNzX21heF9rZXlfc2l6ZSkpOwo+ICAgCX0K
PiAgIAo+IC0JaWYgKHZpLT5oYXNfcnNzKSB7Cj4gKwlpZiAodmktPmhhc19yc3MgfHwgdmktPmhh
c19yc3NfaGFzaF9yZXBvcnQpIHsKPiAgIAkJdmktPnJzc19oYXNoX3R5cGVzX3N1cHBvcnRlZCA9
Cj4gICAJCSAgICB2aXJ0aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcsIHN1cHBvcnRlZF9oYXNoX3R5cGVzKSk7Cj4gICAJCXZpLT5yc3NfaGFzaF90eXBl
c19zdXBwb3J0ZWQgJj0KPiBAQCAtMzM3NCw4ICszNDExLDExIEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAo+ICAgCQlkZXYtPmh3X2Zl
YXR1cmVzIHw9IE5FVElGX0ZfUlhIQVNIOwo+ICAgCX0KPiAtCWlmICh2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX05FVF9GX01SR19SWEJVRikgfHwKPiAtCSAgICB2aXJ0aW9faGFzX2Zl
YXR1cmUodmRldiwgVklSVElPX0ZfVkVSU0lPTl8xKSkKPiArCj4gKwlpZiAodmktPmhhc19yc3Nf
aGFzaF9yZXBvcnQpCj4gKwkJdmktPmhkcl9sZW4gPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRf
aGRyX3YxX2hhc2gpOwo+ICsJZWxzZSBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJ
T19ORVRfRl9NUkdfUlhCVUYpIHx8Cj4gKwkJIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fRl9WRVJTSU9OXzEpKQo+ICAgCQl2aS0+aGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgdmlydGlv
X25ldF9oZHJfbXJnX3J4YnVmKTsKPiAgIAllbHNlCj4gICAJCXZpLT5oZHJfbGVuID0gc2l6ZW9m
KHN0cnVjdCB2aXJ0aW9fbmV0X2hkcik7Cj4gQEAgLTM0NDIsNyArMzQ4Miw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAkJfQo+ICAg
CX0KPiAgIAo+IC0JaWYgKHZpLT5oYXNfcnNzKSB7Cj4gKwlpZiAodmktPmhhc19yc3MgfHwgdmkt
Pmhhc19yc3NfaGFzaF9yZXBvcnQpIHsKPiAgIAkJcnRubF9sb2NrKCk7Cj4gICAJCXZpcnRuZXRf
aW5pdF9kZWZhdWx0X3Jzcyh2aSk7Cj4gICAJCXJ0bmxfdW5sb2NrKCk7Cj4gQEAgLTM1ODAsNyAr
MzYyMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX2RldmljZV9pZCBpZF90YWJsZVtdID0gewo+
ICAgCVZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSLCBcCj4gICAJVklSVElPX05FVF9GX01UVSwg
VklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9BRFMsIFwKPiAgIAlWSVJUSU9fTkVUX0ZfU1BF
RURfRFVQTEVYLCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSwgXAo+IC0JVklSVElPX05FVF9GX1JTUwo+
ICsJVklSVElPX05FVF9GX1JTUywgVklSVElPX05FVF9GX0hBU0hfUkVQT1JUCj4gICAKPiAgIHN0
YXRpYyB1bnNpZ25lZCBpbnQgZmVhdHVyZXNbXSA9IHsKPiAgIAlWSVJUTkVUX0ZFQVRVUkVTLAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
