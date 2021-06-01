Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20065C47082
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:18:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA01D6100B
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 02:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA01D6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7833B83C91;
	Tue,  1 Jun 2021 02:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQLtBY2ddeoG; Tue,  1 Jun 2021 02:18:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 279A483C8C;
	Tue,  1 Jun 2021 02:18:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBFE7C000E;
	Tue,  1 Jun 2021 02:18:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D955DC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C02C840250
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90K7IFHuI7hB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A032400A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 02:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622513894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qah3pGsHCuXsfTF0OUk7eXsZti9ZWLtXe4xmV52gYbI=;
 b=K/rwQvoTbsGAKQdHRng/nhV4B3jw7bBStbFKFYSfgAp0mnboBDV14yMH8/zG/glaHs19wq
 W0R7zriIUawDn2wDKn+6yN4Eq1la3x8T6kC2ugHscgLnyfFu1azctBNF8Sw1OfFlPm/2Vo
 WWvBUU83SqadVmpTHBn2fLJETUz0Zjc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-4QCL2rmjM_iRW9ZAE8Rf-g-1; Mon, 31 May 2021 22:18:12 -0400
X-MC-Unique: 4QCL2rmjM_iRW9ZAE8Rf-g-1
Received: by mail-pj1-f70.google.com with SMTP id
 me1-20020a17090b17c1b029015f8192660bso998927pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 19:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Qah3pGsHCuXsfTF0OUk7eXsZti9ZWLtXe4xmV52gYbI=;
 b=j9ZqVrDmYj1n557RAYw0jB4a46D98xbkRF6uR+NFdKCiQAogV3zxgnn29nkpNQfppt
 I2AbTU3vlElPTFbZ6hYEc1c0YK389d8gnhQ0j4M5Anh5u6GxQAXpFMNrSvVt6vjOnrih
 Q/FncdHsrfSscf9fcf1+Z0ycK9g5ojOOn/3Fhups/MTxyd1WsC7I20ogBkNDLbXMv0B4
 U4Zl4kZkpZBWRZ197YZvJEKFAcgi9vASmKmMEMejtt5Oh3E3BoDNn0FVIZvkMnqwnf67
 C+zbeYrwDXEGkJOMjlBjD4w12qON9oVNcpasRebj2uRgWUYprCF+YuO5jm/OoX0Tage/
 9dWw==
X-Gm-Message-State: AOAM533HWMPkzPaevZvd6Cp8l38abj42O2wqkbIo/v5w649UfGFtQ7R8
 hB9g1QtuyPItpYkiygVFkcFjka3lGau5Xfi49H5UhrCivUMHO0FQZXIyiHiuNoBSo6di/W8oGll
 vXpvuKb/sTV0uHQ8WsGZ0lfUVe/8O8WKHUaO54llowA==
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id
 m1-20020aa790010000b02902d494089998mr19494501pfo.9.1622513891534; 
 Mon, 31 May 2021 19:18:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyViY/11X5ZmHxcXMbLw20tdAdNdmLZ/NY2hL8pS6mFvRo+xXempO+kgmaKJ7FVMPR7k2FjOA==
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id
 m1-20020aa790010000b02902d494089998mr19494489pfo.9.1622513891309; 
 Mon, 31 May 2021 19:18:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g6sm2679339pfq.110.2021.05.31.19.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 19:18:10 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210531160448.31537-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
Date: Tue, 1 Jun 2021 10:18:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160448.31537-1-elic@nvidia.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xIMnPzucxMjowNCwgRWxpIENvaGVuINC0tcA6Cj4gT25seSByZXR1cm4gdGhl
IHZhbHVlIG9mIHRoZSByZWFkeSBmaWVsZCBpZiB0aGUgVlEgaXMgaW5pdGlhbGl6ZWQgaW4KPiB3
aGljaCBjYXNlIHRoZSB2YWx1ZSBvZiB0aGUgZmllbGQgaXMgdmFsaWQuCj4KPiBGYWlsaW5nIHRv
IGRvIHNvIGNhbiByZXN1bHQgaW4gdmlydGlvX3ZkcGEgZmFpbGluZyB0byBsb2FkIGlmIHRoZSBk
ZXZpY2UKPiB3YXMgcHJldmlvdXNseSB1c2VkIGJ5IHZob3N0X3ZkcGEgYW5kIHRoZSBvbGQgdmFs
dWVzIGFyZSByZWFkeS4KPiB2aXJ0aW9fdmRwYSBleHBlY3RzIHRvIGZpbmQgVlFzIGluICJub3Qg
cmVhZHkiIHN0YXRlLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZE
UEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBF
bGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDAyYTA1
NDkyMjA0Yy4uZjZiNjgwZDJhYjFjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
IEBAIC0xNDA3LDcgKzE0MDcsNyBAQCBzdGF0aWMgYm9vbCBtbHg1X3ZkcGFfZ2V0X3ZxX3JlYWR5
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBh
X25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgIAlzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdWV1ZSAqbXZxID0gJm5kZXYtPnZxc1tpZHhdOwo+ICAgCj4gLQlyZXR1cm4gbXZx
LT5yZWFkeTsKPiArCXJldHVybiBtdnEtPmluaXRpYWxpemVkICYmIG12cS0+cmVhZHk7CgoKSSB0
aGluayB0aGUgbW9yZSBzdWl0YWJsZSBmaXggaXMgdG8gcmVzZXQgbXZxLT5yZWFkeSBkdXJpbmcg
cmVzZXQuIFRoZSAKdnFfcmVhZHkgc2hvdWxkIGZvbGxvdyB0aGUgcXVldWVfZW5hYmxlIHNlbWFu
dGljIGluIHZpcnRpby1wY2k6CgoiClRoZSBkZXZpY2UgTVVTVCBwcmVzZW50IGEgMCBpbiBxdWV1
ZV9lbmFibGUgb24gcmVzZXQuCiIKClRoYW5rcwoKCj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQg
bWx4NV92ZHBhX3NldF92cV9zdGF0ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgs
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
