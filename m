Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E622C47082
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:37:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C6861406
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C6861406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8E3F40145;
	Fri,  4 Jun 2021 02:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7p9HjzCccvm; Fri,  4 Jun 2021 02:37:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B4EF405FF;
	Fri,  4 Jun 2021 02:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59356C000D;
	Fri,  4 Jun 2021 02:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 429B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23BCF6F948
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oU2fyIu3LekJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:37:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5778C6F945
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622774257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOghEYXtPzp+Dy+j69IwEyf3koTKLk9pf72ZLOxEDSY=;
 b=QrcYfmSa3B6RzAbAs96Q3tY2t1s+K+7kusyH2bzi2qQsc4XIa3WlJjsKozpSh+qojVQY3R
 ZTqSW/NZguye8vIoYvRfVLvyu3FNBpOImsn6nszNGjxHVLGAIH0wHZhB9QfQELUL5RbofS
 r41NlkEdfJWQXOCqoPeuay8q1+Q+nio=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-bRFGS6R_M8CQqM6EDIK2Fg-1; Thu, 03 Jun 2021 22:37:35 -0400
X-MC-Unique: bRFGS6R_M8CQqM6EDIK2Fg-1
Received: by mail-pg1-f198.google.com with SMTP id
 28-20020a63135c0000b029021b78388f01so5073044pgt.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kOghEYXtPzp+Dy+j69IwEyf3koTKLk9pf72ZLOxEDSY=;
 b=ZzVD1I7gVMyOoxPjdnB/DbujC6qsGlRLbANizc5MrPTklMIHjAZBUJWXI2UyEh7Q+F
 xQsVErDmIMxnbaZGCeB9dhWP3Cf6DFVQbRoWgZwhgPjCY27lueH6+jzNl0HOSeexva/L
 eb0KZ0koS69PFM83KHp9BCItgktoe3gkpKDGwxzFrEF0clPEE0lId3Nfzvu5wmqsb/Qn
 D1v2YP2bV71N8LNoddH5QWH7zZAlOKFmP/bn8lKyCFJZMKo4o6Rpi8v5pFe3sDk0m6th
 aTLx3FXaDDpiiFRrT/ekI4hd0X7EBSMTpfRBXnOLzwSgtXtUDrynsmGEeIuSrZ+QXCH7
 dBKQ==
X-Gm-Message-State: AOAM5319doa1o/Oa8oGIp0wzMf+9okJKF6OjOxEFlRpmJoxxiiiG+HgW
 UOo5bHioHSJeO0comK4vSoUYxhX/YOMFKIRbPSLi5Aa36qH+51CDE6rbgI8y+nFedsT/MokcSZg
 m1U2tvklDE2BouRwBcRuuA1Zg19EICUT0PW2s/BLyiA==
X-Received: by 2002:a65:4109:: with SMTP id w9mr2569867pgp.24.1622774254753;
 Thu, 03 Jun 2021 19:37:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO+9ehWqEf54UWMqlG5rIQ/fRaRzW8G0Ta0PUxjkaNeUBZnbDO3aVcQ4c02+JK6pUbEW7hUg==
X-Received: by 2002:a65:4109:: with SMTP id w9mr2569857pgp.24.1622774254526;
 Thu, 03 Jun 2021 19:37:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g63sm329829pfb.55.2021.06.03.19.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:37:34 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio_net: set link state down when virtqueue
 is broken
To: wangyunjian <wangyunjian@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <79907bf6c835572b4af92f16d9a3ff2822b1c7ea.1622028946.git.wangyunjian@huawei.com>
 <03c68dd1-a636-9d3b-1dec-5e11c8025ccc@redhat.com>
 <d18383f7e675452d9392321506db6fa0@huawei.com>
 <0fcc1413-cb20-7a17-bdcd-6f9994990432@redhat.com>
 <20a5f1bd8a5a49fa8c0f90875a49631b@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1cc933e6-cde4-ba20-3c54-7391db93a9a1@redhat.com>
Date: Fri, 4 Jun 2021 10:37:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20a5f1bd8a5a49fa8c0f90875a49631b@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 dingxiaoxiong <dingxiaoxiong@huawei.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMyDkuIvljYg3OjM0LCB3YW5neXVuamlhbiDlhpnpgZM6Cj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2FuZ0By
ZWRoYXQuY29tXQo+PiBTZW50OiBNb25kYXksIE1heSAzMSwgMjAyMSAxMToyOSBBTQo+PiBUbzog
d2FuZ3l1bmppYW4gPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnCj4+IENjOiBrdWJhQGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IG1zdEByZWRo
YXQuY29tOwo+PiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgZGlu
Z3hpYW94aW9uZwo+PiA8ZGluZ3hpYW94aW9uZ0BodWF3ZWkuY29tPgo+PiBTdWJqZWN0OiBSZTog
W1BBVENIIG5ldC1uZXh0XSB2aXJ0aW9fbmV0OiBzZXQgbGluayBzdGF0ZSBkb3duIHdoZW4gdmly
dHF1ZXVlIGlzCj4+IGJyb2tlbgo+Pgo+Pgo+PiDlnKggMjAyMS81LzI4IOS4i+WNiDY6NTgsIHdh
bmd5dW5qaWFuIOWGmemBkzoKPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+PiBG
cm9tOiBZdW5qaWFuIFdhbmcgPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+Cj4+Pj4+Cj4+Pj4+IFRo
ZSBOSUMgY2FuJ3QgcmVjZWl2ZS9zZW5kIHBhY2tldHMgaWYgYSByeC90eCB2aXJ0cXVldWUgaXMg
YnJva2VuLgo+Pj4+PiBIb3dldmVyLCB0aGUgbGluayBzdGF0ZSBvZiB0aGUgTklDIGlzIHN0aWxs
IG5vcm1hbC4gQXMgYSByZXN1bHQsIHRoZQo+Pj4+PiB1c2VyIGNhbm5vdCBkZXRlY3QgdGhlIE5J
QyBleGNlcHRpb24uCj4+Pj4gRG9lc24ndCB3ZSBoYXZlOgo+Pj4+Cj4+Pj4gICAgwqDCoMKgwqDC
oMKgIC8qIFRoaXMgc2hvdWxkIG5vdCBoYXBwZW4hICovCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqAg
aWYgKHVubGlrZWx5KGVycikpIHsKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2LT5zdGF0cy50eF9maWZvX2Vycm9ycysrOwo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAobmV0X3JhdGVsaW1pdCgpKQo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oJmRldi0+ZGV2LAo+Pj4+
ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIlVuZXhwZWN0ZWQgVFhRICglZCkKPj4gcXVldWUKPj4+PiBmYWlsdXJlOiAl
ZFxuIiwKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFudW0sIGVycik7Cj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRldi0+c3RhdHMudHhfZHJvcHBlZCsrOwo+Pj4+ICAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfa2ZyZWVfc2tiX2FueShza2IpOwo+Pj4+ICAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTkVUREVWX1RYX09LOwo+Pj4+ICAg
IMKgwqDCoMKgwqDCoMKgIH0KPj4+Pgo+Pj4+IFdoaWNoIHNob3VsZCBiZSBzdWZmaWNpZW50Pwo+
Pj4gVGhlcmUgbWF5IGJlIG90aGVyIHJlYXNvbnMgZm9yIHRoaXMgZXJyb3IsIGUuZyAtRU5PU1BD
KG5vIGZyZWUgZGVzYykuCj4+Cj4+IFRoaXMgc2hvdWxkIG5vdCBoYXBwZW4gdW5sZXNzIHRoZSBk
ZXZpY2Ugb3IgZHJpdmVyIGlzIGJ1Z2d5LiBXZSBhbHdheXMgcmVzZXJ2ZWQKPj4gc3VmZmljaWVu
dCBzbG90czoKPj4KPj4gICDCoMKgwqDCoMKgwqDCoCBpZiAoc3EtPnZxLT5udW1fZnJlZSA8IDIr
TUFYX1NLQl9GUkFHUykgewo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRp
Zl9zdG9wX3N1YnF1ZXVlKGRldiwgcW51bSk7IC4uLgo+Pgo+Pgo+Pj4gQW5kIGlmIHJ4IHZpcnRx
dWV1ZSBpcyBicm9rZW4sIHRoZXJlIGlzIG5vIGVycm9yIHN0YXRpc3RpY3MuCj4+Cj4+IEZlZWwg
ZnJlZSB0byBhZGQgb25lIGlmIGl0J3MgbmVjZXNzYXJ5Lgo+IEN1cnJlbnRseSByZWNlaXZpbmcg
c2NlbmFyaW8sIGl0IGlzIGltcG9zc2libGUgdG8gZGlzdGluZ3Vpc2ggd2hldGhlciB0aGUgcmVh
c29uIGZvcgo+IG5vdCByZWNlaXZpbmcgcGFja2V0IGlzIHZpcnRxdWV1ZSdzIGJyb2tlbiBvciBu
byBwYWNrZXQuCgoKQ2FuIHdlIGludHJvZHVjZSByeF9maWZvX2Vycm9ycyBmb3IgdGhhdD8KCgo+
Cj4+IExldCdzIGxlYXZlIHRoZSBwb2xpY3kgZGVjaXNpb24gKGxpbmsgZG93bikgdG8gdXNlcnNw
YWNlLgo+Pgo+Pgo+Pj4+PiBUaGUgZHJpdmVyIGNhbiBzZXQgdGhlIGxpbmsgc3RhdGUgZG93biB3
aGVuIHRoZSB2aXJ0cXVldWUgaXMgYnJva2VuLgo+Pj4+PiBJZiB0aGUgc3RhdGUgaXMgZG93biwg
dGhlIHVzZXIgY2FuIHN3aXRjaCBvdmVyIHRvIGFub3RoZXIgTklDLgo+Pj4+IE5vdGUgdGhhdCwg
d2UgcHJvYmFibHkgbmVlZCB0aGUgd2F0Y2hkb2cgZm9yIHZpcnRpby1uZXQgaW4gb3JkZXIgdG8K
Pj4+PiBiZSBhIGNvbXBsZXRlIHNvbHV0aW9uLgo+Pj4gWWVzLCBJIGNhbiB0aGluayBvZiBpcyB0
aGF0IHRoZSB2aXJ0cXVldWUncyBicm9rZW4gZXhjZXB0aW9uIGlzIGRldGVjdGVkIG9uCj4+IHdh
dGNoZG9nLgo+Pj4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSB0aGF0IG5lZWRzIHRvIGJlIGRvbmU/
Cj4+Cj4+IEJhc2ljYWxseSwgaXQncyBhbGwgYWJvdXQgVFggc3RhbGwgd2hpY2ggd2F0Y2hkb2cg
dHJpZXMgdG8gY2F0Y2guIEJyb2tlbiB2cSBpcyBvbmx5Cj4+IG9uZSBvZiB0aGUgcG9zc2libGUg
cmVhc29uLgo+IEFyZSB0aGVyZSBhbnkgcGxhbnMgZm9yIHRoZSB3YXRjaGRvZz8KCgpTb21lYm9k
eSBwb3N0ZWQgYSBwcm90b3R5cGUgMyBvciA0IHllYXJzIGFnbywgeW91IGNhbiBzZWFyY2ggaXQg
YW5kIAptYXliZSB3ZSBjYW4gc3RhcnQgZnJvbSB0aGVyZS4KClRoYW5rcwoKCj4KPiBUaGFua3MK
Pgo+PiBUaGFua3MKPj4KPj4KPj4+IFRoYW5rcwo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
