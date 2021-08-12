Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD347C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:07:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C57F60EB2
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C57F60EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B7680B3C;
	Thu, 12 Aug 2021 07:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWdkkGVlRAy2; Thu, 12 Aug 2021 07:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 835D080B39;
	Thu, 12 Aug 2021 07:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58F1DC0010;
	Thu, 12 Aug 2021 07:07:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4887C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B46C5406DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L2yA6324bAkk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:07:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2D00400D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628752068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgOG1KaHZGrp2vIMn7queyr7qSVpNW7VY1VTdadCTbg=;
 b=asPgrJS8p23R9joRMalWLcGZTWgOfW98Ob2sinAfaWJmm/CQvTJIa/YjglCmnOaw+7QCnu
 Bn1IT2A4RJikgrA0EkBipaAccHsHoZ3dRMbz4lv+B4+Ci/QtM39eqGR+vBOn6QvURRGXVB
 UNVXSnihnXXigB61XDJU9v26RiuA6/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-5cIcr-OfP4WqPbQ0NNQY2Q-1; Thu, 12 Aug 2021 03:07:44 -0400
X-MC-Unique: 5cIcr-OfP4WqPbQ0NNQY2Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 m2-20020a0560000082b0290154f6e2e51fso1496895wrx.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 00:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QgOG1KaHZGrp2vIMn7queyr7qSVpNW7VY1VTdadCTbg=;
 b=RMOMVKJjbX2K8tVyCGiAT1OQvv8Dlpy530XNI1tZVdg+MtKnL3ibZ6IK3rEL5EQP9n
 BR3egy4XQxLKAZtRB4VMgLaX7bsdK1HNtje4u4NjHOkSOeDjt0qUYrLg0LoIisMdnhor
 JBFJvJMFBBHaixoQa7dPNl3eIR2II3uxGPQmns0BKyVFON6rEaASjHy6UN/kzKoa9++u
 +uUaiY3Aj+n6uHnj8wkSvPvYNlKVXSCz3tAz6xmS11/m54V4qWWsq5Ru11/mjjCVu0pq
 b8GVTtBDgCaPpu9RWBfXbD8xlggigILtv1DUdWbUO6QYz47JWu+PM8XK+kantyWno/CX
 q+FQ==
X-Gm-Message-State: AOAM533rv37y5Ep2jPPMN9XaL5Va9knFTWJhi4Uo9eUnWBOURpOMtB3M
 duYj734KOSigmFp6ubU7rxiMxcgnt79j5a92GLR+BWpQUWSopLLUoJZKC6pJUDXpg0YwyLtR1y2
 4nfeNbMUJp1w15WfVFEoqCrOVChQsbrBcmw6i1O8hhw==
X-Received: by 2002:a05:600c:a08:: with SMTP id
 z8mr2323941wmp.52.1628752063500; 
 Thu, 12 Aug 2021 00:07:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/dQjmzRpVnjhu2nYG+mODfNo/0E2cQXbxEhmzGgBMgSVGnSaxBpdZxfEwooDN34fMK4D4Zw==
X-Received: by 2002:a05:600c:a08:: with SMTP id
 z8mr2323911wmp.52.1628752063241; 
 Thu, 12 Aug 2021 00:07:43 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
 by smtp.gmail.com with ESMTPSA id i10sm8311155wmq.21.2021.08.12.00.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 00:07:42 -0700 (PDT)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
Date: Thu, 12 Aug 2021 09:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

T24gMTEuMDguMjEgMjI6NDcsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiAKPiAKPiBPbiBXZWRu
ZXNkYXksIEF1Z3VzdCAxMSwgMjAyMSwgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5j
b20gCj4gPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPj4gd3JvdGU6Cj4gCj4gICAgIExldCdzIGNs
ZWFuIGl0IHVwIGEgYml0LCByZW1vdmluZyB0aGUgdW5uZWNlc3NhcnkgdXNhZ2Ugb2Ygcl9uZXh0
KCkgYnkKPiAgICAgbmV4dF9yZXNvdXJjZSgpLCBhbmQgdXNlIG5leHRfcmFuZ2VfcmVzb3VyY2Uo
KSBpbiBjYXNlIHdlIGFyZSBub3QKPiAgICAgaW50ZXJlc3RlZCBpbiBhIGNlcnRhaW4gc3VidHJl
ZS4KPiAKPiAgICAgU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhh
dC5jb20KPiAgICAgPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPj4KPiAgICAgLS0tCj4gICAgICDC
oGtlcm5lbC9yZXNvdXJjZS5jIHwgMTkgKysrKysrKysrKystLS0tLS0tLQo+ICAgICAgwqAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiAgICAgZGlm
ZiAtLWdpdCBhL2tlcm5lbC9yZXNvdXJjZS5jIGIva2VybmVsL3Jlc291cmNlLmMKPiAgICAgaW5k
ZXggMjkzOGNmNTIwY2EzLi5lYTg1M2EwNzVhODMgMTAwNjQ0Cj4gICAgIC0tLSBhL2tlcm5lbC9y
ZXNvdXJjZS5jCj4gICAgICsrKyBiL2tlcm5lbC9yZXNvdXJjZS5jCj4gICAgIEBAIC0xNzU0LDkg
KzE3NTQsOCBAQCBzdGF0aWMgaW50IHN0cmljdF9pb21lbV9jaGVja3M7Cj4gICAgICDCoCAqLwo+
ICAgICAgwqBib29sIGlvbWVtX2lzX2V4Y2x1c2l2ZSh1NjQgYWRkcikKPiAgICAgIMKgewo+ICAg
ICAtwqAgwqAgwqAgwqBzdHJ1Y3QgcmVzb3VyY2UgKnAgPSAmaW9tZW1fcmVzb3VyY2U7Cj4gICAg
ICvCoCDCoCDCoCDCoHN0cnVjdCByZXNvdXJjZSAqcDsKPiAgICAgIMKgIMKgIMKgIMKgIGJvb2wg
ZXJyID0gZmFsc2U7Cj4gICAgIC3CoCDCoCDCoCDCoGxvZmZfdCBsOwo+ICAgICAgwqAgwqAgwqAg
wqAgaW50IHNpemUgPSBQQUdFX1NJWkU7Cj4gCj4gICAgICDCoCDCoCDCoCDCoCBpZiAoIXN0cmlj
dF9pb21lbV9jaGVja3MpCj4gICAgIEBAIC0xNzY1LDI3ICsxNzY0LDMxIEBAIGJvb2wgaW9tZW1f
aXNfZXhjbHVzaXZlKHU2NCBhZGRyKQo+ICAgICAgwqAgwqAgwqAgwqAgYWRkciA9IGFkZHIgJiBQ
QUdFX01BU0s7Cj4gCj4gICAgICDCoCDCoCDCoCDCoCByZWFkX2xvY2soJnJlc291cmNlX2xvY2sp
Owo+ICAgICAtwqAgwqAgwqAgwqBmb3IgKHAgPSBwLT5jaGlsZDsgcCA7IHAgPSByX25leHQoTlVM
TCwgcCwgJmwpKSB7Cj4gICAgICvCoCDCoCDCoCDCoGZvciAocCA9IGlvbWVtX3Jlc291cmNlLmNo
aWxkOyBwIDspIHsKPiAKCkhpIEFuZHksCgo+IAo+IEkgY29uc2lkZXIgdGhlIG9yZGluYWwgcGFy
dCBvZiBwIGluaXRpYWxpemF0aW9uIGlzIHNsaWdodGx5IGJldHRlciBhbmQgCj4gZG9uZSBvdXRz
aWRlIG9mIHJlYWQgbG9jay4KPiAKPiBTb21ldGhpbmcgbGlrZQo+IHA9ICZpb21lbV9yZXMuLi47
Cj4gcmVhZCBsb2NrCj4gZm9yIChwID0gcC0+Y2hpbGQ7IC4uLikgewoKV2h5IHNob3VsZCB3ZSBj
YXJlIGFib3V0IGRvaW5nIHRoYXQgb3V0c2lkZSBvZiB0aGUgbG9jaz8gVGhhdCBzbWVsbHMgCmxp
a2UgYSBtaWNyby1vcHRpbWl6YXRpb24gdGhlIGNvbXBpbGVyIHdpbGwgbW9zdCBwcm9iYWJseSBv
dmVyd3JpdGUgCmVpdGhlciB3YXkgYXMgdGhlIGFkZHJlc3Mgb2YgaW9tZW1fcmVzb3VyY2UgaXMg
anVzdCBjb25zdGFudD8KCkFsc28sIGZvciBtZSBpdCdzIG11Y2ggbW9yZSByZWFkYWJsZSBhbmQg
Y29tcGFjdCBpZiB3ZSBwZXJmb3JtIGEgc2luZ2xlIAppbml0aWFsaXphdGlvbiBpbnN0ZWFkIG9m
IHR3byBzZXBhcmF0ZSBvbmVzIGluIHRoaXMgY2FzZS4KCldlJ3JlIHVzaW5nIHRoZSBwYXR0ZXJu
IEkgdXNlIGluLCBmaW5kX25leHRfaW9tZW1fcmVzKCkgYW5kIApfX3JlZ2lvbl9pbnRlcnNlY3Rz
KCksIHdoaWxlIHdlIHVzZSB0aGUgb2xkIHBhdHRlcm4gaW4gCmlvbWVtX21hcF9zYW5pdHlfY2hl
Y2soKSwgd2hlcmUgd2UgYWxzbyB1c2UgdGhlIHNhbWUgdW5uZWNlc3NhcnkgCnJfbmV4dCgpIGNh
bGwuCgpJIG1pZ2h0IGp1c3QgY2xlYW51cCBpb21lbV9tYXBfc2FuaXR5X2NoZWNrKCkgaW4gYSBz
aW1pbGFyIHdheS4KCi0tIApUaGFua3MsCgpEYXZpZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
