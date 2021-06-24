Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE172C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 04:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB68613CC
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 04:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB68613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D7C74027F;
	Thu, 24 Jun 2021 04:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqFn1xT7giu9; Thu, 24 Jun 2021 04:03:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFEE9400CE;
	Thu, 24 Jun 2021 04:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71A6AC0010;
	Thu, 24 Jun 2021 04:03:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CBDC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EBC63406AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JLuvdjRzrng1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9960A406AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624507381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6l8HNUseLWNe4QRrXc5Pxgwkec9RXr3zdcloJqebyc=;
 b=gLVhDbID8o+MCAotB9oBrboA8Z3X58AE9zXVhWit2X/zYiiEi3AljxMpNralw70AJQxrbW
 Yi0xe2Y5z9qVkxjtJ60hyvbjovBnWFbegieiyLFet2Vbx/u2VskGXGPl1vN06pmOfSjxuy
 VN+gEMX0Ba9Gn0IxZ4EpWpfFG3HSQ6U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-q95l8HSpOze8O_nQat17Vw-1; Thu, 24 Jun 2021 00:02:59 -0400
X-MC-Unique: q95l8HSpOze8O_nQat17Vw-1
Received: by mail-pj1-f71.google.com with SMTP id
 w13-20020a17090aea0db029016f87715355so2660469pjy.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 21:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=t6l8HNUseLWNe4QRrXc5Pxgwkec9RXr3zdcloJqebyc=;
 b=OsT595XC/VO3nzSdbLPVDcQGMx4I7Ne+MmOqaW146PE2c1K/WOgIfDSK4SU7JfKgED
 3fNNdpDBLyZO6p1UhJIaAj8UlD9XWzegeUhRbpmRrZZsUkge2FKLcXD2C+EQJvoz9+RN
 0u+vc0Js0HxVJlBqwMSmoszRJ/AYammX0glbJLNeU5nb15Ypke/dZvnimndLeUBx+YcD
 dVSdO8ruNK0LJyYmcTGWp1546/zLkxzWXAs/m3eDdAJiY6/f+CuxDG7Nc/srCOe6C84q
 9ABJb6yQ1h+FuMNAPVTGF9XVKrznFPjfuVKDK7w3qegzG9yRtwIxl1/LwKExIl7W4yuW
 r/9A==
X-Gm-Message-State: AOAM5321pOQ7MRvOktywIQM0TDEyqmGRfz7wc0QvBCN3iVpfJporRyzu
 kimcvRFOJYerwFaYsw2Qb7avrBck/rV7CjmyLJ47739ig/mLh+MJgQaHQH/5DI5QXJPuJvO86Co
 spqupEZ8foGELHFadZQ4pwGQRrKeSO8h8ikFte6bPEw==
X-Received: by 2002:a17:90a:bc89:: with SMTP id
 x9mr3143551pjr.228.1624507378319; 
 Wed, 23 Jun 2021 21:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxANFKxiBZPVYUWF8G1+pn0yAJ3j5nPH8r+gAHEprM5IowLdBJhaK1UbOKwNKvW/vGrG1fMTQ==
X-Received: by 2002:a17:90a:bc89:: with SMTP id
 x9mr3143534pjr.228.1624507378157; 
 Wed, 23 Jun 2021 21:02:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b6sm599868pgw.67.2021.06.23.21.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 21:02:57 -0700 (PDT)
Subject: Re: [PATCH v2] virtio_net/vringh: add "else { }" according coding
 style
To: Cai Huoqing <caihuoqing@baidu.com>, mst@redhat.com, davem@davemloft.net,
 kuba@kernel.org
References: <20210624011757.338-1-caihuoqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93b1bdd8-93b7-9e85-7c52-9b4b8ff36292@redhat.com>
Date: Thu, 24 Jun 2021 12:02:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624011757.338-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNi8yNCDJz87nOToxNywgQ2FpIEh1b3Fpbmcg0LS1wDoKPiBjb2Rpbmctc3R5bGUu
cnN0IHNob3dzIHRoYXQ6Cj4gICAgICAgICAgaWYgKGNvbmRpdGlvbikgewo+ICAgICAgICAgICAg
ICAgICAgZG9fdGhpcygpOwo+ICAgICAgICAgICAgICAgICAgZG9fdGhhdCgpOwo+ICAgICAgICAg
IH0gZWxzZSB7Cj4gICAgICAgICAgICAgICAgICBvdGhlcndpc2UoKTsKPiAgICAgICAgICB9CgoK
U28gZ2l0IGdyZXAgdG9sZCBtZSB0aGVyZSdyZSBhdCBsZWFzdCAyOCBzaW1pbGFyICJpc3N1ZXMi
IGluIApkcml2ZXJzL3Zpcml0by4gQW5kIHRoZXJlIHdpbGwgYmUgYSBsb3QgaW4gdGhlIG90aGVy
IHBhcnQgb2YgdGhlIGtlcm5lbAoKSSB0aGluayBpdCdzIG5vdCB3b3J0aCB0byBib3RoZXIuIFdl
IGNhbiBzdGFydCB0byB3b3JrIG9uIHNvbWV0aGluZyB0aGF0IAppcyByZWFsbHkgaW50ZXJlc3Rp
bmcuCgpFLmcgd2UgaGFkIHRoZSBwbGFuIHRvIGNvbnZlcnQgdG8gdXNlIGlvdiBpdGVyYXRvciBp
bnN0ZWFkIG9mIHVzaW5nIGEgCnZyaW5naCBzcGVjaWZpYyBpb3YgIml0ZXJhdG9yIiBpbXBsZW1l
bnRhdGlvbi4gRG8geW91IHdhbnQgdG8gZG8gdGhhdD8KClRoYW5rcwoKCj4KPiBTaWduZWQtb2Zm
LWJ5OiBDYWkgSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgfCAzICsrLQo+ICAgZHJpdmVycy92aG9zdC92cmluZ2guYyAgIHwg
MyArKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+IGluZGV4IDIxZmY3YjllNDljMi4uN2NkMDYyY2I0NjhlIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+IEBAIC0zMTQsOCArMzE0LDkgQEAgc3RhdGljIHN0cnVjdCBwYWdlICpnZXRfYV9w
YWdlKHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgZ2ZwX3QgZ2ZwX21hc2spCj4gICAgICAgICAg
ICAgICAgICBycS0+cGFnZXMgPSAoc3RydWN0IHBhZ2UgKilwLT5wcml2YXRlOwo+ICAgICAgICAg
ICAgICAgICAgLyogY2xlYXIgcHJpdmF0ZSBoZXJlLCBpdCBpcyB1c2VkIHRvIGNoYWluIHBhZ2Vz
ICovCj4gICAgICAgICAgICAgICAgICBwLT5wcml2YXRlID0gMDsKPiAtICAgICAgIH0gZWxzZQo+
ICsgICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgIHAgPSBhbGxvY19wYWdlKGdmcF9t
YXNrKTsKPiArICAgICAgIH0KPiAgICAgICAgICByZXR1cm4gcDsKPiAgIH0KPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGlu
ZGV4IDRhZjhmYTI1OWQ2NS4uNzk1NDJjYWQxMDcyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTQ1NCw4ICs0
NTQsOSBAQCBzdGF0aWMgaW5saW5lIGludCBfX3ZyaW5naF9jb21wbGV0ZShzdHJ1Y3QgdnJpbmdo
ICp2cmgsCj4gICAgICAgICAgICAgICAgICBpZiAoIWVycikKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gcHV0dXNlZCh2cmgsICZ1c2VkX3JpbmctPnJpbmdbMF0sIHVzZWQgKyBwYXJ0
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV91c2VkIC0gcGFy
dCk7Cj4gLSAgICAgICB9IGVsc2UKPiArICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAgICAg
ICBlcnIgPSBwdXR1c2VkKHZyaCwgJnVzZWRfcmluZy0+cmluZ1tvZmZdLCB1c2VkLCBudW1fdXNl
ZCk7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgICBpZiAoZXJyKSB7Cj4gICAgICAgICAgICAgICAg
ICB2cmluZ2hfYmFkKCJGYWlsZWQgdG8gd3JpdGUgJXUgdXNlZCBlbnRyaWVzICV1IGF0ICVwIiwK
PiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
