Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21266C63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 08:34:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7770520719
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRb3fGdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7770520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 072032266C;
	Mon, 30 Nov 2020 08:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UzqyJQdglxQg; Mon, 30 Nov 2020 08:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7525F22011;
	Mon, 30 Nov 2020 08:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D26FC163C;
	Mon, 30 Nov 2020 08:33:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0EA8C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B0F4387366
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkCLZ+LdnqoO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:33:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 676BA87365
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606725233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOBw30VGGpYGUqtKjgp1D/xXFSKdq88sDVSnLLemHDo=;
 b=FRb3fGdf6aLMG6xJeHSgATNF+5MeF8CsLcrSLmJgvy3tWcQKhs+x8n1PKDN30xWSabPxpt
 CmxrZOqc6VAUEJDKbjpyg21zhrtTEb7PFhx3PYGLoFe7XuFsqRTEVI2FRF2E61wmZzUEUy
 rRgZU3+c/Qu5Znvqo9UfzMIzUGxDz8c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-IgNm_5rMNYS3ULkWeDAOLA-1; Mon, 30 Nov 2020 03:33:50 -0500
X-MC-Unique: IgNm_5rMNYS3ULkWeDAOLA-1
Received: by mail-wr1-f69.google.com with SMTP id b12so8100034wru.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 00:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vOBw30VGGpYGUqtKjgp1D/xXFSKdq88sDVSnLLemHDo=;
 b=IlKo9YqMpv5vNMcJbDEWeyis6FzP2kjQguhcPcjZXIMJRw8n9cVgWaCIENjKc+/yBF
 23cWZyWL+bEqV/AwqZVxUTIaaVD2Dm0iZLNpjTk9Abor0CiKjKKnB1FNE4ADd7AvcNw0
 XbXHU3+o5ido+unRt82htjfQFNMbQl27yD/8KZnM+8DQBtHOiTsz8v4GbiUAw1K2r4np
 kFfVbWmOAAY2OBV26FHMl+tjcfKzHz3hf0wuLuMiRfLaIEt3cR6ZzM8Lm7RGRkOyDuQ4
 Y2Mgw6COCncMv3dBEnkHMuwJ2sNuzjUcEMjoJiiBqjmaYgQqaV3G5by5a7fqGuV1xeC+
 i+bA==
X-Gm-Message-State: AOAM531Bx3OaQKMdaU6Vv04YFmwfSyJtBe36+CHy5bh1tRRpmckCaqPT
 bYt1B4vYklUOBsjm26BvWdJsGfkqEIc+4lJw8RL6ceY+FrQ95wAJuhzIpr3Jn2x7PsKdw7gYtkl
 LlUcZWKSr62UXQ7ytn4+QJ8Fe/lC9v/5OAjijdBSuxQ==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26727973wrm.36.1606725228953; 
 Mon, 30 Nov 2020 00:33:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxx/iQZGql5wZU5MomW2tQpacaKJDVUoRlyVnQsj6AxXWR1H+6D7EHUWZYX9I0NcbeUr12Ulw==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26727949wrm.36.1606725228783; 
 Mon, 30 Nov 2020 00:33:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id a184sm24043265wmf.8.2020.11.30.00.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 00:33:47 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Sasha Levin <sashal@kernel.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
Date: Mon, 30 Nov 2020 09:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201129210650.GP643756@sasha-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

T24gMjkvMTEvMjAgMjI6MDYsIFNhc2hhIExldmluIHdyb3RlOgo+IE9uIFN1biwgTm92IDI5LCAy
MDIwIGF0IDA2OjM0OjAxUE0gKzAxMDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4+IE9uIDI5LzEx
LzIwIDA1OjEzLCBTYXNoYSBMZXZpbiB3cm90ZToKPj4+PiBXaGljaCBkb2Vzbid0IHNlZW0gdG8g
YmUgc3VpdGFibGUgZm9yIHN0YWJsZSBlaXRoZXIuLi7CoCBQYXRjaCAzLzUgaW4KPj4+Cj4+PiBX
aHkgbm90PyBJdCB3YXMgc2VudCBhcyBhIGZpeCB0byBMaW51cy4KPj4KPj4gRHVubm8sIDEyMCBs
aW5lcyBvZiBuZXcgY29kZT/CoCBFdmVuIGlmIGl0J3Mgb2theSBmb3IgYW4gcmMsIEkgZG9uJ3Qg
Cj4+IHNlZSB3aHkgaXQgaXMgd291bGQgYmUgYmFja3BvcnRlZCB0byBzdGFibGUgcmVsZWFzZXMg
YW5kIHJlbGVhc2UgaXQgCj4+IHdpdGhvdXQgYW55IGtpbmQgb2YgdGVzdGluZy7CoCBNYXliZSBm
b3IgNS45IHRoZSBjaGFuY2VzIG9mIGJyZWFraW5nIAo+IAo+IExpbmVzIG9mIGNvZGUgaXMgbm90
IGV2ZXJ5dGhpbmcuIElmIHlvdSB0aGluayB0aGF0IHRoaXMgbmVlZHMgYWRkaXRpb25hbAo+IHRl
c3RpbmcgdGhlbiB0aGF0J3MgZmluZSBhbmQgd2UgY2FuIGRyb3AgaXQsIGJ1dCBub3QgcGlja2lu
ZyB1cCBhIGZpeAo+IGp1c3QgYmVjYXVzZSBpdCdzIDEyMCBsaW5lcyBpcyBub3Qgc29tZXRoaW5n
IHdlJ2QgZG8uCgpTdGFydGluZyB3aXRoIHRoZSBmaXJzdCB0d28gc3RlcHMgaW4gc3RhYmxlLWtl
cm5lbC1ydWxlcy5yc3Q6CgpSdWxlcyBvbiB3aGF0IGtpbmQgb2YgcGF0Y2hlcyBhcmUgYWNjZXB0
ZWQsIGFuZCB3aGljaCBvbmVzIGFyZSBub3QsIGludG8gCnRoZSAiLXN0YWJsZSIgdHJlZToKCiAg
LSBJdCBtdXN0IGJlIG9idmlvdXNseSBjb3JyZWN0IGFuZCB0ZXN0ZWQuCiAgLSBJdCBjYW5ub3Qg
YmUgYmlnZ2VyIHRoYW4gMTAwIGxpbmVzLCB3aXRoIGNvbnRleHQuCgo+IFBsdXMgYWxsIHRoZSB0
ZXN0aW5nIHdlIGhhdmUgZm9yIHRoZSBzdGFibGUgdHJlZXMsIHllcy4gSXQgZ29lcyBiZXlvbmQK
PiBqdXN0IGNvbXBpbGluZyBhdCB0aGlzIHBvaW50Lgo+IAo+IFlvdXIgdmVyeSBvd24gY28td29y
a2VycyAoaHR0cHM6Ly9ja2ktcHJvamVjdC5vcmcvKSBhcmUgcHVzaGluZyBoYXJkIG9uCj4gdGhp
cyBlZmZvcnQgYXJvdW5kIHN0YWJsZSBrZXJuZWwgdGVzdGluZywgYW5kIHN0YXRlbWVudHMgbGlr
ZSB0aGVzZQo+IGFyZW4ndCBoZWxwaW5nIGFueW9uZS4KCkkgYW0gbm90IGF3YXJlIG9mIGFueSBw
dWJsaWMgQ0kgYmVpbmcgZG9uZSBfYXQgYWxsXyBkb25lIG9uIHZob3N0LXNjc2ksIApieSBDS0kg
b3IgZXZlcnlvbmUgZWxzZS4gIFNvIGF1dG9zZWxlY3Rpb24gc2hvdWxkIGJlIGRvbmUgb25seSBv
biAKc3Vic3lzdGVtcyB0aGF0IGhhdmUgdmVyeSBoaWdoIGNvdmVyYWdlIGluIENJLgoKUGFvbG8K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
