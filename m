Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102BC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:41:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D246103A
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66D246103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D52180D84;
	Thu, 19 Aug 2021 03:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGkSOA9fpU1V; Thu, 19 Aug 2021 03:41:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF65E80D83;
	Thu, 19 Aug 2021 03:41:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87BF3C001A;
	Thu, 19 Aug 2021 03:41:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E35BC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77A35607F6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXvy2uDYFXQV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:41:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 230F760730
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629344464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkS4MAPpZ9QXW0en//zqkr0mO4bWwX4hP7T9+1waOfo=;
 b=e9ZHMCpUTCyYv5mJM/94npOdeX5A0qlhSbAh+zMV9kcDO1LNE2CudyV3TFyiXvVzPC5B1o
 kIYI//pGmq2ZeIc1UFa7SjoCM1+OxR1UL0TxNeJK6Ndn/vqXWatAcOh423cAuzrseFZnJf
 ksedPI+Z6W1IdXvMkuytzOgiv8mi4C8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-hnZFPa6eP2qccYf8uho3Og-1; Wed, 18 Aug 2021 23:41:02 -0400
X-MC-Unique: hnZFPa6eP2qccYf8uho3Og-1
Received: by mail-pj1-f71.google.com with SMTP id
 h9-20020a17090a470900b001791c0352aaso2084079pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 20:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UkS4MAPpZ9QXW0en//zqkr0mO4bWwX4hP7T9+1waOfo=;
 b=cGbdwxr/nsQoF5Eqjoblj1W0wMJVJgDwd2ZjS163YqvwgiqjLR5zr4DJWDW6sdXooY
 SZyxapsW01ju6udUpphkS8wb5VLHjJo+WFqb4pUId7Bl1qtkVVAJ34+k11ooGj2Jj45f
 5ijbUpFIgoPzPkRjsow+hWpnHl1Yv0HUVcgWPs0znrcJQS9cGF/4QkWx2tH3uAMzb+ux
 Hk3J4Cnk8T3vLZW9luvKgvEPIzfwHIG1I1NM/fEM16gEgM/W4hqbMBsUP4J8pBW5E0Qd
 g6kNlEVxcHetzJoOlIRnctxR0SzMsr+A2vR9C1dYPHdV3aXlc9lk9MQARmpwdMNUOJRG
 QUaQ==
X-Gm-Message-State: AOAM530i6KbBTviB+LRKEK3lg2ax4Y0HxslIYk38MmvjRgNcHIHTcHn6
 Vz44berb/Oqp1auZloDzeAytWSkap98iAIjNObx89HGPjNy1d/46F17UMrxcJGyIyhcyLMvNFx/
 ovmYz7mrpMcfby56HVia6iKH/7u1gE4Od9Jq+6Zhf/g==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id
 bg8-20020a1709028e88b029011eb70383f1mr9825135plb.79.1629344461674; 
 Wed, 18 Aug 2021 20:41:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqmFE6M9dmiOKjJr6ScGJd/jZDEHi/a6qERRc4lijWi9EZXMiMgs4L0F86ZkbyN8FyHDufWA==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id
 bg8-20020a1709028e88b029011eb70383f1mr9825119plb.79.1629344461366; 
 Wed, 18 Aug 2021 20:41:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q21sm1476374pgk.71.2021.08.18.20.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 20:41:00 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] vdpa/mlx5: Ensure valid indices are provided
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210817060250.188705-1-elic@nvidia.com>
 <20210817060250.188705-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e873f3f6-94ee-4b8f-9d25-c245bc993fd2@redhat.com>
Date: Thu, 19 Aug 2021 11:40:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817060250.188705-5-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8xNyDPws7nMjowMiwgRWxpIENvaGVuINC0tcA6Cj4gRm9sbG93aW5nIHBhdGNo
ZXMgYWRkIGNvbnRyb2wgdmlydHVxZXVlIGFuZCBtdWx0aXF1ZXVlIHN1cHBvcnQuIFdlIHdhbnQK
PiB0byB2ZXJpZnkgdGhhdCB0aGUgaW5kZXggdmFsdWUgdG8gY2FsbGJhY2tzIHJlZmVyZW5jaW5n
IGEgdmlydHF1ZXVlIGlzCj4gdmFsaWQuCj4KPiBUaGUgbG9naWMgZGVmaW5pbmcgdmFsaWQgaW5k
aWNlcyBpcyBhcyBmb2xsb3dzOgo+IENWUSBjbGVhcjogMCBhbmQgMS4KPiBDVlEgc2V0LCBNUSBj
bGVhcjogMCwgMSBhbmQgMgo+IENWUSBzZXQsIE1RIHNldDogMC4ubnZxIHdoZXJlIG52cSBpcyB3
aGF0ZXZlciBwcm92aWRlZCB0bwo+IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpCj4KPiBTaWduZWQt
b2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAgMSArCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaAo+IGluZGV4IDhkMGE2ZjJjYjNmMC4uNDFiMjA4NTVlZDMxIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21seDVfdmRwYS5oCj4gQEAgLTU2LDYgKzU2LDcgQEAgc3RydWN0IG1seDVfdmRwYV9k
ZXYgewo+ICAgCXU2NCBhY3R1YWxfZmVhdHVyZXM7Cj4gICAJdTggc3RhdHVzOwo+ICAgCXUzMiBt
YXhfdnFzOwo+ICsJdTE2IG1heF9pZHg7Cj4gICAJdTMyIGdlbmVyYXRpb247Cj4gICAKPiAgIAlz
dHJ1Y3QgbWx4NV92ZHBhX21yIG1yOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRl
eCAyMjJkZGZiZGUxMTYuLjBmZTdjZDM3MGU0YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiBAQCAtNDUsNiArNDUsOCBAQCBNT0RVTEVfTElDRU5TRSgiRHVhbCBCU0QvR1BMIik7
Cj4gICAJKFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSB8IFZJUlRJT19DT05GSUdfU19EUklW
RVIgfCBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LIHwgICAgICAgIFwKPiAgIAkgVklSVElPX0NP
TkZJR19TX0ZFQVRVUkVTX09LIHwgVklSVElPX0NPTkZJR19TX05FRURTX1JFU0VUIHwgVklSVElP
X0NPTkZJR19TX0ZBSUxFRCkKPiAgIAo+ICsjZGVmaW5lIE1MWDVfRkVBVFVSRShfbXZkZXYsIF9m
ZWF0dXJlKSAoISEoKF9tdmRldiktPmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoX2ZlYXR1cmUp
KSkKPiArCj4gICBzdHJ1Y3QgbWx4NV92ZHBhX25ldF9yZXNvdXJjZXMgewo+ICAgCXUzMiB0aXNu
Owo+ICAgCXUzMiB0ZG47Cj4gQEAgLTEzMyw2ICsxMzUsMTQgQEAgc3RydWN0IG1seDVfdmRwYV92
aXJ0cXVldWUgewo+ICAgICovCj4gICAjZGVmaW5lIE1MWDVfTUFYX1NVUFBPUlRFRF9WUVMgMTYK
PiAgIAo+ICtzdGF0aWMgYm9vbCBpc19pbmRleF92YWxpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHUxNiBpZHgpCj4gK3sKPiArCWlmICh1bmxpa2VseShpZHggPiBtdmRldi0+bWF4X2lk
eCkpCj4gKwkJcmV0dXJuIGZhbHNlOwo+ICsKPiArCXJldHVybiB0cnVlOwo+ICt9Cj4gKwo+ICAg
c3RydWN0IG1seDVfdmRwYV9uZXQgewo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2IG12ZGV2Owo+
ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0X3Jlc291cmNlcyByZXM7Cj4gQEAgLTEzNTUsNiArMTM2
NSw5IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9raWNrX3ZxKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTE2IGlkeCkKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVf
dmRwYV9uZGV2KG12ZGV2KTsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxID0g
Jm5kZXYtPnZxc1tpZHhdOwo+ICAgCj4gKwlpZiAoIWlzX2luZGV4X3ZhbGlkKG12ZGV2LCBpZHgp
KQo+ICsJCXJldHVybjsKPiArCj4gICAJaWYgKHVubGlrZWx5KCFtdnEtPnJlYWR5KSkKPiAgIAkJ
cmV0dXJuOwo+ICAgCj4gQEAgLTEzNjgsNiArMTM4MSw5IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X3NldF92cV9hZGRyZXNzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgdTY0IGRl
c2NfCj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldiht
dmRldik7Cj4gICAJc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSA9ICZuZGV2LT52cXNb
aWR4XTsKPiAgIAo+ICsJaWYgKCFpc19pbmRleF92YWxpZChtdmRldiwgaWR4KSkKPiArCQlyZXR1
cm4gLUVJTlZBTDsKPiArCj4gICAJbXZxLT5kZXNjX2FkZHIgPSBkZXNjX2FyZWE7Cj4gICAJbXZx
LT5kZXZpY2VfYWRkciA9IGRldmljZV9hcmVhOwo+ICAgCW12cS0+ZHJpdmVyX2FkZHIgPSBkcml2
ZXJfYXJlYTsKPiBAQCAtMTM4MCw2ICsxMzk2LDkgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3Nl
dF92cV9udW0oc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LCB1MzIgbnVtKQo+ICAg
CXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+
ICAgCXN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnE7Cj4gICAKPiArCWlmICghaXNfaW5k
ZXhfdmFsaWQobXZkZXYsIGlkeCkpCj4gKwkJcmV0dXJuOwo+ICsKPiAgIAltdnEgPSAmbmRldi0+
dnFzW2lkeF07Cj4gICAJbXZxLT5udW1fZW50ID0gbnVtOwo+ICAgfQo+IEBAIC0xMzk4LDYgKzE0
MTcsOSBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3ZxX3JlYWR5KHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTE2IGlkeCwgYm9vbCByZWFkeQo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0
ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFf
dmlydHF1ZXVlICptdnEgPSAmbmRldi0+dnFzW2lkeF07Cj4gICAKPiArCWlmICghaXNfaW5kZXhf
dmFsaWQobXZkZXYsIGlkeCkpCj4gKwkJcmV0dXJuOwo+ICsKPiAgIAlpZiAoIXJlYWR5KQo+ICAg
CQlzdXNwZW5kX3ZxKG5kZXYsIG12cSk7Cj4gICAKPiBAQCAtMTQxMCw2ICsxNDMyLDkgQEAgc3Rh
dGljIGJvb2wgbWx4NV92ZHBhX2dldF92cV9yZWFkeShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
IHUxNiBpZHgpCj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFf
bmRldihtdmRldik7Cj4gICAJc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cSA9ICZuZGV2
LT52cXNbaWR4XTsKPiAgIAo+ICsJaWYgKCFpc19pbmRleF92YWxpZChtdmRldiwgaWR4KSkKPiAr
CQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICAgCXJldHVybiBtdnEtPnJlYWR5Owo+ICAgfQo+ICAgCj4g
QEAgLTE0MjAsNiArMTQ0NSw5IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF92cV9zdGF0ZShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsCj4gICAJc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gICAJc3RydWN0IG1seDVfdmRw
YV92aXJ0cXVldWUgKm12cSA9ICZuZGV2LT52cXNbaWR4XTsKPiAgIAo+ICsJaWYgKCFpc19pbmRl
eF92YWxpZChtdmRldiwgaWR4KSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gICAJaWYgKG12
cS0+Zndfc3RhdGUgPT0gTUxYNV9WSVJUSU9fTkVUX1FfT0JKRUNUX1NUQVRFX1JEWSkgewo+ICAg
CQltbHg1X3ZkcGFfd2FybihtdmRldiwgImNhbid0IG1vZGlmeSBhdmFpbGFibGUgaW5kZXhcbiIp
Owo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiBAQCAtMTQzOCw2ICsxNDY2LDkgQEAgc3RhdGljIGlu
dCBtbHg1X3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlk
eCwgc3RydWN0IHZkcGEKPiAgIAlzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIGF0dHI7Cj4gICAJaW50
IGVycjsKPiAgIAo+ICsJaWYgKCFpc19pbmRleF92YWxpZChtdmRldiwgaWR4KSkKPiArCQlyZXR1
cm4gLUVJTlZBTDsKPiArCj4gICAJLyogSWYgdGhlIHZpcnRxIG9iamVjdCB3YXMgZGVzdHJveWVk
LCB1c2UgdGhlIHZhbHVlIHNhdmVkIGF0Cj4gICAJICogdGhlIGxhc3QgbWludXRlIG9mIHN1c3Bl
bmRfdnEuIFRoaXMgY2F0ZXJzIGZvciB1c2Vyc3BhY2UKPiAgIAkgKiB0aGF0IGNhcmVzIGFib3V0
IGVtdWxhdGluZyB0aGUgaW5kZXggYWZ0ZXIgdnEgaXMgc3RvcHBlZC4KPiBAQCAtMTU1Nyw2ICsx
NTg4LDE4IEBAIHN0YXRpYyBfX3ZpcnRpbzE2IGNwdV90b19tbHg1dmRwYTE2KHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwgdTE2IHZhbCkKPiAgIAlyZXR1cm4gX19jcHVfdG9fdmlydGlvMTYo
bWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4obXZkZXYpLCB2YWwpOwo+ICAgfQo+ICAgCj4gK3N0
YXRpYyB2b2lkIHVwZGF0ZV9jdnFfaW5mbyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4g
K3sKPiArCWlmIChNTFg1X0ZFQVRVUkUobXZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkgewo+
ICsJCWlmIChNTFg1X0ZFQVRVUkUobXZkZXYsIFZJUlRJT19ORVRfRl9NUSkpCj4gKwkJCW12ZGV2
LT5tYXhfaWR4ID0gbXZkZXYtPm1heF92cXM7Cj4gKwkJZWxzZQo+ICsJCQltdmRldi0+bWF4X2lk
eCA9IDI7Cj4gKwl9IGVsc2Ugewo+ICsJCW12ZGV2LT5tYXhfaWR4ID0gMTsKPiArCX0KPiArfQoK
Ck5pdDogaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGFkZCBhIGNvbW1lbnQgdG8gZXhwbGFpbiB0aGUg
bG9naWMgaGVyZS4KCkUuZyB3ZSBrbm93IGluZGV4IDAgYW5kIDEgc2hvdWxkIGFsd2F5cyB2YWxp
ZC4KCk90aGVyIHRoYW4gdGhpczoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgoKCj4gKwo+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgewo+ICAgCXN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+IEBAIC0xNTcyLDYgKzE2MTUsNyBA
QCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1NjQgZmVhdHVyZXMpCj4gICAJbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVh
dHVyZXMgJiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4gICAJbmRldi0+Y29uZmlnLm10dSA9
IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBuZGV2LT5tdHUpOwo+ICAgCW5kZXYtPmNvbmZpZy5z
dGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIFZJUlRJT19ORVRfU19MSU5LX1VQKTsK
PiArCXVwZGF0ZV9jdnFfaW5mbyhtdmRldik7Cj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiAgIAo+
IEBAIC0xNzkyLDYgKzE4MzYsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiAgIAkJbWx4NV92ZHBhX2Rlc3Ry
b3lfbXIoJm5kZXYtPm12ZGV2KTsKPiAgIAkJbmRldi0+bXZkZXYuc3RhdHVzID0gMDsKPiAgIAkJ
bmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzID0gMDsKPiArCQluZGV2LT5tdmRldi5hY3R1YWxfZmVh
dHVyZXMgPSAwOwo+ICAgCQkrK212ZGV2LT5nZW5lcmF0aW9uOwo+ICAgCQlpZiAoTUxYNV9DQVBf
R0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkgewo+ICAgCQkJaWYgKG1seDVfdmRwYV9jcmVh
dGVfbXIobXZkZXYsIE5VTEwpKQo+IEBAIC0xODkyLDYgKzE5MzcsOSBAQCBzdGF0aWMgc3RydWN0
IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgbWx4NV9nZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2
ZHBhX2RldmljZQo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+ICAgCXBoeXNfYWRk
cl90IGFkZHI7Cj4gICAKPiArCWlmICghaXNfaW5kZXhfdmFsaWQobXZkZXYsIGlkeCkpCj4gKwkJ
cmV0dXJuIHJldDsKPiArCj4gICAJLyogSWYgU0YgQkFSIHNpemUgaXMgc21hbGxlciB0aGFuIFBB
R0VfU0laRSwgZG8gbm90IHVzZSBkaXJlY3QKPiAgIAkgKiBub3RpZmljYXRpb24gdG8gYXZvaWQg
dGhlIHJpc2sgb2YgbWFwcGluZyBwYWdlcyB0aGF0IGNvbnRhaW4gQkFSIG9mIG1vcmUKPiAgIAkg
KiB0aGFuIG9uZSBTRgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
