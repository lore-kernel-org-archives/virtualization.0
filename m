Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C6C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 05:55:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0515661029
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 05:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0515661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7B6D834E1;
	Mon,  2 Aug 2021 05:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hnX1WHO-UZqZ; Mon,  2 Aug 2021 05:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4548482532;
	Mon,  2 Aug 2021 05:55:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD9FC0010;
	Mon,  2 Aug 2021 05:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E16ECC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 05:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF919401D3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 05:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6RU5gOyWIS-2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 05:55:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83EBD40017
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627883742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivPqFlYITqRUkuoXkFTKBay5LBYZ801aDo0Fz7/YC94=;
 b=IGT89iJTZ3oTzkvaGRjUqyqSPQD0oZLGChHHiIAkPNtdaUqRrKc6M12FU6K0BrUxHq6Wmt
 kDqcsl1tR3wg6oVcuOPvpxbwdCcWfUutzlxGQAR/1hNIY23nuxoQPx9ckx6IeGUnQRb9Qm
 uHogsQ/teNJZ0vK1ILWF9H0KozeTk3s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-gGL3cbEWNCazXjlGc9iD-Q-1; Mon, 02 Aug 2021 01:55:40 -0400
X-MC-Unique: gGL3cbEWNCazXjlGc9iD-Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 o1-20020a17090aac01b029017730151351so67953pjq.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 01 Aug 2021 22:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ivPqFlYITqRUkuoXkFTKBay5LBYZ801aDo0Fz7/YC94=;
 b=nXN93gVGFuWIGwrDlQbJI0oY4PZRjAvnuIPmd5gWLJLIYFGaycPcEGe/BPHiuua05f
 hA2f5IlEv49WFY30LhocuTgRPIwB6tdiLYXDjrYJNBtfnFdIJatZE6Livt0wW2OY7c6j
 +K2cQTUDA4p8cXFRC9vhR/8R4Lb2SmZoEJL+OmIDD6J5cL/yZcoti+A8K8OkXzipghFF
 2g2qI+/gpiGTshGshoZ9dkWnltfRc7c8hUrOHQMgiKzOlY3QqcY5I/Ntqs/WxDXEPuMs
 PwSKsNwv0yl/IoPNW9e4Vhe7BuQ07rebFE2Y7oCxiP6facVhZe7cAiS9jC0N7bKThIHG
 HZGA==
X-Gm-Message-State: AOAM530vFaNWe+sC0RQwbXmV4zJNY6NPRlo4IeOES6zKUqC07FHCuDnM
 bOWzuKUA0y9Ec9YvbNriM2K5/or1NY7YCwinlNtACgrDyCD57adnPT6C54PnggxilElSoF49j1Z
 Wb2oQ6PiX/OVVbevrsn0ccxTD5Z/E2XsORIPLCHG+KdPteWNPVzvDupwUZmurUxiyhmazLK5QZn
 mhp+SgHXED2G3qAavw7g==
X-Received: by 2002:a17:902:7889:b029:12b:cf54:4bf1 with SMTP id
 q9-20020a1709027889b029012bcf544bf1mr13203530pll.85.1627883739531; 
 Sun, 01 Aug 2021 22:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCymVYU/4mTuqAsIpJXfqohEsOKqh1rlQQr8yeuVnx7kilOyGUBZP3wg1qufTUzqmR/4n/Hw==
X-Received: by 2002:a17:902:7889:b029:12b:cf54:4bf1 with SMTP id
 q9-20020a1709027889b029012bcf544bf1mr13203506pll.85.1627883739140; 
 Sun, 01 Aug 2021 22:55:39 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 136sm9275832pge.77.2021.08.01.22.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Aug 2021 22:55:38 -0700 (PDT)
Subject: Re: [PATCH] vdpa: Make use of PFN_PHYS/PFN_UP/PFN_DOWN helper macro
To: Cai Huoqing <caihuoqing@baidu.com>, mst@redhat.com
References: <20210802013717.851-1-caihuoqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8ae935c5-27fd-ef96-94f1-6d935381ee18@redhat.com>
Date: Mon, 2 Aug 2021 13:55:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802013717.851-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvOC8yIMnPzuc5OjM3LCBDYWkgSHVvcWluZyDQtLXAOgo+IGl0J3MgYSBuaWNlIHJl
ZmFjdG9yIHRvIG1ha2UgdXNlIG9mCj4gUEZOX1BIWVMvUEZOX1VQL1BGTl9ET1dOIGhlbHBlciBt
YWNybwo+Cj4gU2lnbmVkLW9mZi1ieTogQ2FpIEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29t
PgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4g
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBp
bmRleCAyMTBhYjM1YTdlYmYuLjFmNmRkNmFkMGY4YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTUwNywxNSArNTA3
LDE1IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAoc3RydWN0IHZob3N0X3Zk
cGEgKnYsIHU2NCBzdGFydCwgdTY0IGxhc3QpCj4gICAJdW5zaWduZWQgbG9uZyBwZm4sIHBpbm5l
ZDsKPiAgIAo+ICAgCXdoaWxlICgobWFwID0gdmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIs
IHN0YXJ0LCBsYXN0KSkgIT0gTlVMTCkgewo+IC0JCXBpbm5lZCA9IG1hcC0+c2l6ZSA+PiBQQUdF
X1NISUZUOwo+IC0JCWZvciAocGZuID0gbWFwLT5hZGRyID4+IFBBR0VfU0hJRlQ7Cj4gKwkJcGlu
bmVkID0gUEZOX0RPV04obWFwLT5zaXplKTsKPiArCQlmb3IgKHBmbiA9IFBGTl9ET1dOKG1hcC0+
YWRkcik7Cj4gICAJCSAgICAgcGlubmVkID4gMDsgcGZuKyssIHBpbm5lZC0tKSB7Cj4gICAJCQlw
YWdlID0gcGZuX3RvX3BhZ2UocGZuKTsKPiAgIAkJCWlmIChtYXAtPnBlcm0gJiBWSE9TVF9BQ0NF
U1NfV08pCj4gICAJCQkJc2V0X3BhZ2VfZGlydHlfbG9jayhwYWdlKTsKPiAgIAkJCXVucGluX3Vz
ZXJfcGFnZShwYWdlKTsKPiAgIAkJfQo+IC0JCWF0b21pYzY0X3N1YihtYXAtPnNpemUgPj4gUEFH
RV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4gKwkJYXRvbWljNjRfc3ViKFBGTl9ET1dO
KG1hcC0+c2l6ZSksICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+ICAgCQl2aG9zdF9pb3RsYl9tYXBf
ZnJlZShpb3RsYiwgbWFwKTsKPiAgIAl9Cj4gICB9Cj4gQEAgLTU3Nyw3ICs1NzcsNyBAQCBzdGF0
aWMgaW50IHZob3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCWlmIChyKQo+
ICAgCQl2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUg
LSAxKTsKPiAgIAllbHNlCj4gLQkJYXRvbWljNjRfYWRkKHNpemUgPj4gUEFHRV9TSElGVCwgJmRl
di0+bW0tPnBpbm5lZF92bSk7Cj4gKwkJYXRvbWljNjRfYWRkKFBGTl9ET1dOKHNpemUpLCAmZGV2
LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAo+ICAgCXJldHVybiByOwo+ICAgfQo+IEBAIC02MzAsNyAr
NjMwLDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVj
dCB2aG9zdF92ZHBhICp2LAo+ICAgCWlmIChtc2ctPnBlcm0gJiBWSE9TVF9BQ0NFU1NfV08pCj4g
ICAJCWd1cF9mbGFncyB8PSBGT0xMX1dSSVRFOwo+ICAgCj4gLQlucGFnZXMgPSBQQUdFX0FMSUdO
KG1zZy0+c2l6ZSArIChpb3ZhICYgflBBR0VfTUFTSykpID4+IFBBR0VfU0hJRlQ7Cj4gKwlucGFn
ZXMgPSBQRk5fVVAobXNnLT5zaXplICsgKGlvdmEgJiB+UEFHRV9NQVNLKSk7Cj4gICAJaWYgKCFu
cGFnZXMpIHsKPiAgIAkJcmV0ID0gLUVJTlZBTDsKPiAgIAkJZ290byBmcmVlOwo+IEBAIC02Mzgs
NyArNjM4LDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0
cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCj4gICAJbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4g
ICAKPiAtCWxvY2tfbGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7
Cj4gKwlsb2NrX2xpbWl0ID0gUEZOX0RPV04ocmxpbWl0KFJMSU1JVF9NRU1MT0NLKSk7Cj4gICAJ
aWYgKG5wYWdlcyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xp
bWl0KSB7Cj4gICAJCXJldCA9IC1FTk9NRU07Cj4gICAJCWdvdG8gdW5sb2NrOwo+IEBAIC02NzIs
OSArNjcyLDkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0
cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCj4gICAJCQlpZiAobGFzdF9wZm4gJiYgKHRoaXNfcGZu
ICE9IGxhc3RfcGZuICsgMSkpIHsKPiAgIAkJCQkvKiBQaW4gYSBjb250aWd1b3VzIGNodW5rIG9m
IG1lbW9yeSAqLwo+IC0JCQkJY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFH
RV9TSElGVDsKPiArCQkJCWNzaXplID0gUEZOX1BIWVMobGFzdF9wZm4gLSBtYXBfcGZuICsgMSk7
Cj4gICAJCQkJcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4gLQkJCQkJCSAg
ICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULAo+ICsJCQkJCQkgICAgIFBGTl9QSFlTKG1hcF9wZm4p
LAo+ICAgCQkJCQkJICAgICBtc2ctPnBlcm0pOwo+ICAgCQkJCWlmIChyZXQpIHsKPiAgIAkJCQkJ
LyoKPiBAQCAtNjk4LDEzICs2OTgsMTMgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3Nf
aW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQkJbGFzdF9wZm4gPSB0aGlz
X3BmbjsKPiAgIAkJfQo+ICAgCj4gLQkJY3VyX2Jhc2UgKz0gcGlubmVkIDw8IFBBR0VfU0hJRlQ7
Cj4gKwkJY3VyX2Jhc2UgKz0gUEZOX1BIWVMocGlubmVkKTsKPiAgIAkJbnBhZ2VzIC09IHBpbm5l
ZDsKPiAgIAl9Cj4gICAKPiAgIAkvKiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPiAtCXJldCA9IHZo
b3N0X3ZkcGFfbWFwKHYsIGlvdmEsIChsYXN0X3BmbiAtIG1hcF9wZm4gKyAxKSA8PCBQQUdFX1NI
SUZULAo+IC0JCQkgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwgbXNnLT5wZXJtKTsKPiArCXJl
dCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIFBGTl9QSFlTKGxhc3RfcGZuIC0gbWFwX3BmbiAr
IDEpLAo+ICsJCQkgICAgIFBGTl9QSFlTKG1hcF9wZm4pLCBtc2ctPnBlcm0pOwo+ICAgb3V0Ogo+
ICAgCWlmIChyZXQpIHsKPiAgIAkJaWYgKG5jaHVua3MpIHsKPiBAQCAtOTQ0LDcgKzk0NCw3IEBA
IHN0YXRpYyB2bV9mYXVsdF90IHZob3N0X3ZkcGFfZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYp
Cj4gICAKPiAgIAl2bWEtPnZtX3BhZ2VfcHJvdCA9IHBncHJvdF9ub25jYWNoZWQodm1hLT52bV9w
YWdlX3Byb3QpOwo+ICAgCWlmIChyZW1hcF9wZm5fcmFuZ2Uodm1hLCB2bWYtPmFkZHJlc3MgJiBQ
QUdFX01BU0ssCj4gLQkJCSAgICBub3RpZnkuYWRkciA+PiBQQUdFX1NISUZULCBQQUdFX1NJWkUs
Cj4gKwkJCSAgICBQRk5fRE9XTihub3RpZnkuYWRkciksIFBBR0VfU0laRSwKPiAgIAkJCSAgICB2
bWEtPnZtX3BhZ2VfcHJvdCkpCj4gICAJCXJldHVybiBWTV9GQVVMVF9TSUdCVVM7Cj4gICAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
