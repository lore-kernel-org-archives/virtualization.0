Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E99C47082
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 02:37:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E4261003
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 02:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E4261003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82DD860694;
	Mon, 24 May 2021 02:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ygj7avOlSye; Mon, 24 May 2021 02:37:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12F2160659;
	Mon, 24 May 2021 02:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA21FC000E;
	Mon, 24 May 2021 02:37:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98D4EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C34E40336
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 86R8rArHL-sZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:37:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20B3C40333
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621823842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtRzjJU3zz/wMpYYu1wZ0eR2bUfiIpbddTRFTd2F8tI=;
 b=KNsTaCyh6D9GyFY/MK/rV6RH/k1q6nh8Q0+kLUE15xCXh+tz1GwvPkpDlT1fwV9BK0up7+
 Y17osa1F4T4iUuzaQaCFTNuwFq9nGgTIE5Bx5XW9IMG0BcicWH4xYRdPKBMv0HKx6i2F3O
 tcwe8IGKdmmDJujMyoINcYm93f7EbCo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-MMyFIMxjNAST-26Le_afdA-1; Sun, 23 May 2021 22:37:21 -0400
X-MC-Unique: MMyFIMxjNAST-26Le_afdA-1
Received: by mail-pl1-f197.google.com with SMTP id
 2-20020a1709020202b02900eecb50c2deso12148363plc.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 May 2021 19:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RtRzjJU3zz/wMpYYu1wZ0eR2bUfiIpbddTRFTd2F8tI=;
 b=Li2MUZS3nGS7qeLOe7oNgoqsaJX0nEbYTBcv4R4tyeqA86gRcep6d+zgvWPANEyVVO
 KggqMmOPiUd3txwT56CmUNrFZ0JeUFPeroBmONS8rhTY2q/XrPa6668ivXusaKEamCHR
 swY5ynVMPGupATMrJEFgEnHBvvVIk4cUAysc4k3Ql0bbx/+QM2YNfvHuTenK/WlVcW0d
 WRx07Q3ANAFkvCtamtRD3YWF+o1mDmF5xyn3gvB8BGQJygXDU9FvCQHaCurWH7SJtJjP
 Kl+yq9xfS2HiB+DJPQ6bEPLWEXbD/lj/fFMzgeqEquRUAxsZ0kXm9zfq4KIkMxZ7LMBK
 Bjdg==
X-Gm-Message-State: AOAM531gQ0iHg6qyWQUQJUd9gp9pxpxGp/ezu6KF1QeK2Ewdja148Fus
 P2pyTkXxBh0Eus3K4xQXUgSg5oVNai+xcakGjyEsCLlDJifwF4COusNc25a+yRbVYak2BX54YJV
 MLok0GAXlj0mFuFFvG0Z+ZjHH34FanGNCmpPYMg6WWw==
X-Received: by 2002:a05:6a00:bcd:b029:2e5:694c:1c96 with SMTP id
 x13-20020a056a000bcdb02902e5694c1c96mr13004704pfu.53.1621823840111; 
 Sun, 23 May 2021 19:37:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx37stF392FcwzsfWouLaJiCy30jVN9MxMjs2gF5N3m/RiHjhLpwt2/v+Fs58s94Yk5v76tVg==
X-Received: by 2002:a05:6a00:bcd:b029:2e5:694c:1c96 with SMTP id
 x13-20020a056a000bcdb02902e5694c1c96mr13004685pfu.53.1621823839871; 
 Sun, 23 May 2021 19:37:19 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l1sm8671328pjt.40.2021.05.23.19.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 May 2021 19:37:19 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: fix the kzalloc/kfree mismatch problem
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Guodeqing (A)" <geffrey.guo@huawei.com>
References: <1621821978.04102-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <36d1b92c-7dc5-f84e-ef86-980b15c39965@redhat.com>
Date: Mon, 24 May 2021 10:37:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621821978.04102-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

CtTaIDIwMjEvNS8yNCDJz87nMTA6MDYsIFh1YW4gWmh1byDQtLXAOgo+IE9uIE1vbiwgMjQgTWF5
IDIwMjEgMDE6NDg6NTMgKzAwMDAsIEd1b2RlcWluZyAoQSkgPGdlZmZyZXkuZ3VvQGh1YXdlaS5j
b20+IHdyb3RlOgo+Pgo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IE1h
eCBHdXJ0b3ZveSBbbWFpbHRvOm1ndXJ0b3ZveUBudmlkaWEuY29tXQo+Pj4gU2VudDogU3VuZGF5
LCBNYXkgMjMsIDIwMjEgMTU6MjUKPj4+IFRvOiBHdW9kZXFpbmcgKEEpIDxnZWZmcmV5Lmd1b0Bo
dWF3ZWkuY29tPjsgbXN0QHJlZGhhdC5jb20KPj4+IENjOiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBk
YXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7Cj4+PiB2aXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+Pj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gdmlydGlvLW5ldDogZml4IHRoZSBremFsbG9jL2tmcmVlIG1pc21h
dGNoIHByb2JsZW0KPj4+Cj4+Pgo+Pj4gT24gNS8yMi8yMDIxIDExOjAyIEFNLCBndW9kZXFpbmcg
d3JvdGU6Cj4+Pj4gSWYgdGhlIHZpcnRpb19uZXQgZGV2aWNlIGRvZXMgbm90IHN1cHB1cnQgdGhl
IGN0cmwgcXVldWUgZmVhdHVyZSwgdGhlCj4+Pj4gdmktPmN0cmwgd2FzIG5vdCBhbGxvY2F0ZWQs
IHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZnJlZSBpdC4KPj4+IHlvdSBkb24ndCBuZWVkIHRoaXMg
Y2hlY2suCj4+Pgo+Pj4gZnJvbSBrZnJlZSBkb2M6Cj4+Pgo+Pj4gIklmIEBvYmpwIGlzIE5VTEws
IG5vIG9wZXJhdGlvbiBpcyBwZXJmb3JtZWQuIgo+Pj4KPj4+IFRoaXMgaXMgbm90IGEgYnVnLiBJ
J3ZlIHNldCB2aS0+Y3RybCB0byBiZSBOVUxMIGluIGNhc2UgIXZpLT5oYXNfY3ZxLgo+Pj4KPj4+
Cj4+ICAgIHllcywgIHRoaXMgaXMgbm90IGEgYnVnLCB0aGUgcGF0Y2ggaXMganVzdCBhIG9wdGlt
aXphdGlvbiwgYmVjYXVzZSB0aGUgdmktPmN0cmwgbWF5YmUKPj4gICAgYmUgZnJlZWQgd2hpY2gg
IHdhcyBub3QgYWxsb2NhdGVkLCB0aGlzIG1heSBnaXZlIHBlb3BsZSBhIG1pc3VuZGVyc3RhbmRp
bmcuCj4+ICAgIFRoYW5rcy4KPgo+IEkgdGhpbmsgaXQgbWF5IGJlIGVub3VnaCB0byBhZGQgYSBj
b21tZW50LCBhbmQgdGhlIGNvZGUgZG9lcyBub3QgbmVlZCB0byBiZQo+IG1vZGlmaWVkLgo+Cj4g
VGhhbmtzLgoKCk9yIGV2ZW4ganVzdCBsZWF2ZSB0aGUgY3VycmVudCBjb2RlIGFzIGlzLiBBIGxv
dCBvZiBrZXJuZWwgY29kZXMgd2FzIAp3cm90ZSB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IGtm
cmVlKCkgc2hvdWxkIGRlYWwgd2l0aCBOVUxMLgoKVGhhbmtzCgoKPgo+Pj4+IEhlcmUgSSBhZGp1
c3QgdGhlIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIGFuZCB0aGUgY2hlY2sgb2YgdmktPmhhc19j
dnEKPj4+PiB0byBzbG92ZSB0aGlzIHByb2JsZW0uCj4+Pj4KPj4+PiBGaXhlczogCTEyMmI4NGEx
MjY3YSAoInZpcnRpby1uZXQ6IGRvbid0IGFsbG9jYXRlIGNvbnRyb2xfYnVmIGlmIG5vdAo+Pj4g
c3VwcG9ydGVkIikKPj4+PiBTaWduZWQtb2ZmLWJ5OiBndW9kZXFpbmcgPGdlZmZyZXkuZ3VvQGh1
YXdlaS5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjAg
KysrKysrKysrKy0tLS0tLS0tLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGluZGV4Cj4+Pj4gOWI2YTRh
ODc1YzU1Li44OTRmODk0ZDNhMjkgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4gQEAgLTI2OTEs
NyArMjY5MSw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfZnJlZV9xdWV1ZXMoc3RydWN0Cj4+Pj4g
dmlydG5ldF9pbmZvICp2aSkKPj4+Pgo+Pj4+ICAgIAlrZnJlZSh2aS0+cnEpOwo+Pj4+ICAgIAlr
ZnJlZSh2aS0+c3EpOwo+Pj4+IC0Ja2ZyZWUodmktPmN0cmwpOwo+Pj4+ICsJaWYgKHZpLT5oYXNf
Y3ZxKQo+Pj4+ICsJCWtmcmVlKHZpLT5jdHJsKTsKPj4+PiAgICB9Cj4+Pj4KPj4+PiAgICBzdGF0
aWMgdm9pZCBfZnJlZV9yZWNlaXZlX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpIEBAIC0y
ODcwLDEzCj4+Pj4gKzI4NzEsNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYWxsb2NfcXVldWVzKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+Pj4+ICAgIHsKPj4+PiAgICAJaW50IGk7Cj4+Pj4KPj4+
PiAtCWlmICh2aS0+aGFzX2N2cSkgewo+Pj4+IC0JCXZpLT5jdHJsID0ga3phbGxvYyhzaXplb2Yo
KnZpLT5jdHJsKSwgR0ZQX0tFUk5FTCk7Cj4+Pj4gLQkJaWYgKCF2aS0+Y3RybCkKPj4+PiAtCQkJ
Z290byBlcnJfY3RybDsKPj4+PiAtCX0gZWxzZSB7Cj4+Pj4gLQkJdmktPmN0cmwgPSBOVUxMOwo+
Pj4+IC0JfQo+Pj4+ICAgIAl2aS0+c3EgPSBrY2FsbG9jKHZpLT5tYXhfcXVldWVfcGFpcnMsIHNp
emVvZigqdmktPnNxKSwgR0ZQX0tFUk5FTCk7Cj4+Pj4gICAgCWlmICghdmktPnNxKQo+Pj4+ICAg
IAkJZ290byBlcnJfc3E7Cj4+Pj4gQEAgLTI4ODQsNiArMjg3OCwxMiBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfYWxsb2NfcXVldWVzKHN0cnVjdAo+Pj4gdmlydG5ldF9pbmZvICp2aSkKPj4+PiAgICAJ
aWYgKCF2aS0+cnEpCj4+Pj4gICAgCQlnb3RvIGVycl9ycTsKPj4+Pgo+Pj4+ICsJaWYgKHZpLT5o
YXNfY3ZxKSB7Cj4+Pj4gKwkJdmktPmN0cmwgPSBremFsbG9jKHNpemVvZigqdmktPmN0cmwpLCBH
RlBfS0VSTkVMKTsKPj4+PiArCQlpZiAoIXZpLT5jdHJsKQo+Pj4+ICsJCQlnb3RvIGVycl9jdHJs
Owo+Pj4+ICsJfQo+Pj4+ICsKPj4+PiAgICAJSU5JVF9ERUxBWUVEX1dPUksoJnZpLT5yZWZpbGws
IHJlZmlsbF93b3JrKTsKPj4+PiAgICAJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFp
cnM7IGkrKykgewo+Pj4+ICAgIAkJdmktPnJxW2ldLnBhZ2VzID0gTlVMTDsKPj4+PiBAQCAtMjkw
MiwxMSArMjkwMiwxMSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYWxsb2NfcXVldWVzKHN0cnVjdAo+
Pj4+IHZpcnRuZXRfaW5mbyAqdmkpCj4+Pj4KPj4+PiAgICAJcmV0dXJuIDA7Cj4+Pj4KPj4+PiAr
ZXJyX2N0cmw6Cj4+Pj4gKwlrZnJlZSh2aS0+cnEpOwo+Pj4+ICAgIGVycl9ycToKPj4+PiAgICAJ
a2ZyZWUodmktPnNxKTsKPj4+PiAgICBlcnJfc3E6Cj4+Pj4gLQlrZnJlZSh2aS0+Y3RybCk7Cj4+
Pj4gLWVycl9jdHJsOgo+Pj4+ICAgIAlyZXR1cm4gLUVOT01FTTsKPj4+PiAgICB9Cj4+Pj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
