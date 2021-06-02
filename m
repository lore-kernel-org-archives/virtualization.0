Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A41C4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:20:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2F361363
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 07:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2F361363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFBD2400D2;
	Wed,  2 Jun 2021 07:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wMCU1XIHt7sg; Wed,  2 Jun 2021 07:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3744D400BA;
	Wed,  2 Jun 2021 07:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB31C000D;
	Wed,  2 Jun 2021 07:20:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1BFBC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EFFA402EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kVmWtEoleV7q
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EF7C4029E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622618399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4nP3Ng969nG95ueTZmh5K5TsN/lZGqF7zfAlo06R84=;
 b=D+7yk34r7OMmqz6aCUfwlvJ5igjOKYjeEc+zND1T+TPWPFjiMYZx3Gw4J9oRVBh5Ipois6
 I4y7gSpCt1SylJ3QE/AxJJRcUR43HhzF9PsaEmNe/EozGeGuDhvEqEFKV1OXLK6oF7oviT
 jGbkeYHznSiHgGh9Meh2pURT/9oz1cM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-HO_eQeFJNIqN5gq389KWlA-1; Wed, 02 Jun 2021 03:19:57 -0400
X-MC-Unique: HO_eQeFJNIqN5gq389KWlA-1
Received: by mail-pg1-f199.google.com with SMTP id
 s14-20020a63450e0000b029021f631b8861so1115935pga.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 00:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X4nP3Ng969nG95ueTZmh5K5TsN/lZGqF7zfAlo06R84=;
 b=TBIWSqTlfOcEsV6kXn5+2gGht6yzx2SPZmdCiluru3k2/CoZtaDAbeUgLYcoGt4E+j
 sNo+moZf711xRmG0/A+iB8X6kTTNevFZaDM2R5Y3CrbV/64V+oHbnDgMfU12oFHST/F8
 xbqqYP8bA+zX1alSq4mjSHM18WIVcCH6d2nFvmE6r4xXAAMjoNko8kOkHwNiyEuDulSY
 3aIUpcpzKbm/07J/JLd4jYxaKeSNkile8qbZCzqYocDeP9H+b8EKh3wAlxwDMVdeQzdn
 x7jxgHW09y17LWPbA9tkRVPwe1MuWRP8Etmt4KKbHTcpBQMOu4kSeXzwG1hajv6Ovn7W
 pwUw==
X-Gm-Message-State: AOAM532hMjWCUhlY2p6fx7mL77/pc3RpdvWu542s1TSs360lGRcLp47Q
 Xa1K2qFRCVXP9c9DBaXACJd2AoBgcyBhydRQ0Q2+r+qS2pjLdApxNSgFj86IhTXRlMll/lHMVpx
 X2pGS+IEJ9aT0fhfM5d85XTXsKEr6QbbU+dV4qlA7Kw==
X-Received: by 2002:a62:cd46:0:b029:2ea:299c:d7bd with SMTP id
 o67-20020a62cd460000b02902ea299cd7bdmr490444pfg.72.1622618396346; 
 Wed, 02 Jun 2021 00:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ645Is1tmz07mckMTyAA4Mz50hpb0lkW6SxhGDP6TZI8rBAamuObw3kS2TVn4LZecUfJFGQ==
X-Received: by 2002:a62:cd46:0:b029:2ea:299c:d7bd with SMTP id
 o67-20020a62cd460000b02902ea299cd7bdmr490428pfg.72.1622618396110; 
 Wed, 02 Jun 2021 00:19:56 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p11sm15880530pgn.65.2021.06.02.00.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:19:55 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: fix the kzalloc/kfree mismatch problem
To: Leon Romanovsky <leon@kernel.org>
References: <1621821978.04102-1-xuanzhuo@linux.alibaba.com>
 <36d1b92c-7dc5-f84e-ef86-980b15c39965@redhat.com> <YLccNiOW8UGFowli@unreal>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <abcc9911-67d8-8764-b986-d749187d4977@redhat.com>
Date: Wed, 2 Jun 2021 15:19:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLccNiOW8UGFowli@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Guodeqing \(A\)" <geffrey.guo@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvMiDkuIvljYgxOjUwLCBMZW9uIFJvbWFub3Zza3kg5YaZ6YGTOgo+IE9uIE1v
biwgTWF5IDI0LCAyMDIxIGF0IDEwOjM3OjE0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIxLzUvMjQg5LiK5Y2IMTA6MDYsIFh1YW4gWmh1byDlhpnpgZM6Cj4+PiBPbiBNb24s
IDI0IE1heSAyMDIxIDAxOjQ4OjUzICswMDAwLCBHdW9kZXFpbmcgKEEpIDxnZWZmcmV5Lmd1b0Bo
dWF3ZWkuY29tPiB3cm90ZToKPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+Pj4g
RnJvbTogTWF4IEd1cnRvdm95IFttYWlsdG86bWd1cnRvdm95QG52aWRpYS5jb21dCj4+Pj4+IFNl
bnQ6IFN1bmRheSwgTWF5IDIzLCAyMDIxIDE1OjI1Cj4+Pj4+IFRvOiBHdW9kZXFpbmcgKEEpIDxn
ZWZmcmV5Lmd1b0BodWF3ZWkuY29tPjsgbXN0QHJlZGhhdC5jb20KPj4+Pj4gQ2M6IGphc293YW5n
QHJlZGhhdC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsKPj4+Pj4g
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmcKPj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvLW5ldDogZml4IHRoZSBr
emFsbG9jL2tmcmVlIG1pc21hdGNoIHByb2JsZW0KPj4+Pj4KPj4+Pj4KPj4+Pj4gT24gNS8yMi8y
MDIxIDExOjAyIEFNLCBndW9kZXFpbmcgd3JvdGU6Cj4+Pj4+PiBJZiB0aGUgdmlydGlvX25ldCBk
ZXZpY2UgZG9lcyBub3Qgc3VwcHVydCB0aGUgY3RybCBxdWV1ZSBmZWF0dXJlLCB0aGUKPj4+Pj4+
IHZpLT5jdHJsIHdhcyBub3QgYWxsb2NhdGVkLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGZyZWUg
aXQuCj4+Pj4+IHlvdSBkb24ndCBuZWVkIHRoaXMgY2hlY2suCj4+Pj4+Cj4+Pj4+IGZyb20ga2Zy
ZWUgZG9jOgo+Pj4+Pgo+Pj4+PiAiSWYgQG9ianAgaXMgTlVMTCwgbm8gb3BlcmF0aW9uIGlzIHBl
cmZvcm1lZC4iCj4+Pj4+Cj4+Pj4+IFRoaXMgaXMgbm90IGEgYnVnLiBJJ3ZlIHNldCB2aS0+Y3Ry
bCB0byBiZSBOVUxMIGluIGNhc2UgIXZpLT5oYXNfY3ZxLgo+Pj4+Pgo+Pj4+Pgo+Pj4+ICAgICB5
ZXMsICB0aGlzIGlzIG5vdCBhIGJ1ZywgdGhlIHBhdGNoIGlzIGp1c3QgYSBvcHRpbWl6YXRpb24s
IGJlY2F1c2UgdGhlIHZpLT5jdHJsIG1heWJlCj4+Pj4gICAgIGJlIGZyZWVkIHdoaWNoICB3YXMg
bm90IGFsbG9jYXRlZCwgdGhpcyBtYXkgZ2l2ZSBwZW9wbGUgYSBtaXN1bmRlcnN0YW5kaW5nLgo+
Pj4+ICAgICBUaGFua3MuCj4+PiBJIHRoaW5rIGl0IG1heSBiZSBlbm91Z2ggdG8gYWRkIGEgY29t
bWVudCwgYW5kIHRoZSBjb2RlIGRvZXMgbm90IG5lZWQgdG8gYmUKPj4+IG1vZGlmaWVkLgo+Pj4K
Pj4+IFRoYW5rcy4KPj4KPj4gT3IgZXZlbiBqdXN0IGxlYXZlIHRoZSBjdXJyZW50IGNvZGUgYXMg
aXMuIEEgbG90IG9mIGtlcm5lbCBjb2RlcyB3YXMgd3JvdGUKPj4gdW5kZXIgdGhlIGFzc3VtcHRp
b24gdGhhdCBrZnJlZSgpIHNob3VsZCBkZWFsIHdpdGggTlVMTC4KPiBJdCBpcyBub3QgYXNzdW1w
dGlvbiBidXQgc3RhbmRhcmQgcHJhY3RpY2UgdGhhdCBjYW4gYmUgc2VlbiBhcyBzaWRlCj4gZWZm
ZWN0IG9mICI3KSBDZW50cmFsaXplZCBleGl0aW5nIG9mIGZ1bmN0aW9ucyIgc2VjdGlvbiBvZiBj
b2Rpbmctc3R5bGUucnN0Lgo+Cj4gVGhhbmtzCgoKSSBkb24ndCBzZWUgdGhlIGNvbm5lY3Rpb24g
dG8gdGhlIGNlbnRyYWxpemVkIGV4aXRpbmcuCgpTb21ldGhpbmcgbGlrZToKCmlmIChmb28pCiDC
oMKgwqAga2ZyZWUoZm9vKTsKCndvbid0IGJyZWFrIHRoZSBjZW50cmFsaXphdGlvbi4KClRoYW5r
cwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
