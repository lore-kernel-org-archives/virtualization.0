Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5FC4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:34:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663F761019
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 663F761019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27C9160B62;
	Thu, 12 Aug 2021 07:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sk8tXHwxLpvw; Thu, 12 Aug 2021 07:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB3326076F;
	Thu, 12 Aug 2021 07:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D688C001A;
	Thu, 12 Aug 2021 07:34:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7257C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0FCF40734
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RF0RLSHWkR05
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:34:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EE42406DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628753643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYH9IB8kLiUJPK2eGWH1AkGjFzTYCt4aUi+sk0Dhj6E=;
 b=Z+YLRIj3vsy10ZK6eYwx2B8zdDYWo2fvLYYOGC2bLUmEMS0iBQDBFUXzI+WWJwPSA53k4q
 E04/kQWVryDuvpIjiNSoxbmbyja8WGXU86NSwHO2k4WHbeFkJSZR5s1ZDnYT3hKsmAI+NB
 k487+nKLY+eTy7SiWMg0Ji7pn+tMhlM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-ZWJr_Yy4OsS17h9JklH6aQ-1; Thu, 12 Aug 2021 03:34:02 -0400
X-MC-Unique: ZWJr_Yy4OsS17h9JklH6aQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 v2-20020a7bcb420000b02902e6b108fcf1so1393487wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 00:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mYH9IB8kLiUJPK2eGWH1AkGjFzTYCt4aUi+sk0Dhj6E=;
 b=a9QeTfcToqViI3zXOnJ9mx5KFHhqf2a+mNP56XTpPLZ7egmRUdpsiRLtv2S6yHhlHy
 iF48ddzCnyM97CxKo44UGgUZ4OgcTS3CYev2C9A4SWNYxdgOMKXEC16uCKXLtmV7x/H0
 wwGYL+w1DeNiaxtiAb0oDaMhWaOlwDvz9r+6p19+RRd6YqOZB4z8Zrvn+WDaAzw6Lyx7
 /9XHbyfxFj0rjaTBBRCY6iJSkZeq1+tdGttPk3z4/jJtuMDwPZ6aXMSJNr36BRYiLSX6
 fJoPrPj9ETavAmjRGYpkmRjJFyVLSEQq0WIrojLxAyH7xxH9Ab6v7cYbFSKkTEtzMDZQ
 gNrA==
X-Gm-Message-State: AOAM530mE51iJKog4aTMP0rNOjG2rDv2NxE3WJfBgMbceITZdiw0bRfq
 F3glIqJX370Po7mJOzLo99T59fIxVZhRdU+O01fNrAdbwnjpgs1yJrZdRZBfW73tN5thkPYxSkX
 DxtZjNuk2BjjAvH+CqsvbjiMu9bSUi6E/20/nE9I+dg==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2456015wmk.136.1628753641688; 
 Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXDY4HnbdNw6PM31nv/QfI9ZkXgq7IZiHchMbUa+C8ozEvyCRTCvh51tc4Bi0fHK++AFiliw==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2455999wmk.136.1628753641495; 
 Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
 by smtp.gmail.com with ESMTPSA id n186sm9388381wme.40.2021.08.12.00.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
 <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
 <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
Date: Thu, 12 Aug 2021 09:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
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

T24gMTIuMDguMjEgMDk6MTQsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiAKPiAKPiBPbiBUaHVy
c2RheSwgQXVndXN0IDEyLCAyMDIxLCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bSAKPiA8bWFpbHRvOmRhdmlkQHJlZGhhdC5jb20+PiB3cm90ZToKPiAKPiAgICAgT24gMTEuMDgu
MjEgMjI6NDcsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiAKPiAKPiAKPiAgICAgICAgIE9uIFdl
ZG5lc2RheSwgQXVndXN0IDExLCAyMDIxLCBEYXZpZCBIaWxkZW5icmFuZAo+ICAgICAgICAgPGRh
dmlkQHJlZGhhdC5jb20gPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPgo+ICAgICAgICAgPG1haWx0
bzpkYXZpZEByZWRoYXQuY29tIDxtYWlsdG86ZGF2aWRAcmVkaGF0LmNvbT4+PiB3cm90ZToKPiAK
PiAgICAgICAgICDCoCDCoCBMZXQncyBjbGVhbiBpdCB1cCBhIGJpdCwgcmVtb3ZpbmcgdGhlIHVu
bmVjZXNzYXJ5IHVzYWdlIG9mCj4gICAgICAgICByX25leHQoKSBieQo+ICAgICAgICAgIMKgIMKg
IG5leHRfcmVzb3VyY2UoKSwgYW5kIHVzZSBuZXh0X3JhbmdlX3Jlc291cmNlKCkgaW4gY2FzZSB3
ZQo+ICAgICAgICAgYXJlIG5vdAo+ICAgICAgICAgIMKgIMKgIGludGVyZXN0ZWQgaW4gYSBjZXJ0
YWluIHN1YnRyZWUuCj4gCj4gICAgICAgICAgwqAgwqAgU2lnbmVkLW9mZi1ieTogRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20KPiAgICAgICAgIDxtYWlsdG86ZGF2aWRAcmVkaGF0
LmNvbT4KPiAgICAgICAgICDCoCDCoCA8bWFpbHRvOmRhdmlkQHJlZGhhdC5jb20gPG1haWx0bzpk
YXZpZEByZWRoYXQuY29tPj4+Cj4gICAgICAgICAgwqAgwqAgLS0tCj4gICAgICAgICAgwqAgwqAg
wqDCoGtlcm5lbC9yZXNvdXJjZS5jIHwgMTkgKysrKysrKysrKystLS0tLS0tLQo+ICAgICAgICAg
IMKgIMKgIMKgwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKPiAKPiAgICAgICAgICDCoCDCoCBkaWZmIC0tZ2l0IGEva2VybmVsL3Jlc291cmNlLmMgYi9r
ZXJuZWwvcmVzb3VyY2UuYwo+ICAgICAgICAgIMKgIMKgIGluZGV4IDI5MzhjZjUyMGNhMy4uZWE4
NTNhMDc1YTgzIDEwMDY0NAo+ICAgICAgICAgIMKgIMKgIC0tLSBhL2tlcm5lbC9yZXNvdXJjZS5j
Cj4gICAgICAgICAgwqAgwqAgKysrIGIva2VybmVsL3Jlc291cmNlLmMKPiAgICAgICAgICDCoCDC
oCBAQCAtMTc1NCw5ICsxNzU0LDggQEAgc3RhdGljIGludCBzdHJpY3RfaW9tZW1fY2hlY2tzOwo+
ICAgICAgICAgIMKgIMKgIMKgwqAgKi8KPiAgICAgICAgICDCoCDCoCDCoMKgYm9vbCBpb21lbV9p
c19leGNsdXNpdmUodTY0IGFkZHIpCj4gICAgICAgICAgwqAgwqAgwqDCoHsKPiAgICAgICAgICDC
oCDCoCAtwqAgwqAgwqAgwqBzdHJ1Y3QgcmVzb3VyY2UgKnAgPSAmaW9tZW1fcmVzb3VyY2U7Cj4g
ICAgICAgICAgwqAgwqAgK8KgIMKgIMKgIMKgc3RydWN0IHJlc291cmNlICpwOwo+ICAgICAgICAg
IMKgIMKgIMKgwqAgwqAgwqAgwqAgYm9vbCBlcnIgPSBmYWxzZTsKPiAgICAgICAgICDCoCDCoCAt
wqAgwqAgwqAgwqBsb2ZmX3QgbDsKPiAgICAgICAgICDCoCDCoCDCoMKgIMKgIMKgIMKgIGludCBz
aXplID0gUEFHRV9TSVpFOwo+IAo+ICAgICAgICAgIMKgIMKgIMKgwqAgwqAgwqAgwqAgaWYgKCFz
dHJpY3RfaW9tZW1fY2hlY2tzKQo+ICAgICAgICAgIMKgIMKgIEBAIC0xNzY1LDI3ICsxNzY0LDMx
IEBAIGJvb2wgaW9tZW1faXNfZXhjbHVzaXZlKHU2NCBhZGRyKQo+ICAgICAgICAgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgYWRkciA9IGFkZHIgJiBQQUdFX01BU0s7Cj4gCj4gICAgICAgICAgwqAgwqAg
wqDCoCDCoCDCoCDCoCByZWFkX2xvY2soJnJlc291cmNlX2xvY2spOwo+ICAgICAgICAgIMKgIMKg
IC3CoCDCoCDCoCDCoGZvciAocCA9IHAtPmNoaWxkOyBwIDsgcCA9IHJfbmV4dChOVUxMLCBwLCAm
bCkpIHsKPiAgICAgICAgICDCoCDCoCArwqAgwqAgwqAgwqBmb3IgKHAgPSBpb21lbV9yZXNvdXJj
ZS5jaGlsZDsgcCA7KSB7Cj4gCj4gCj4gICAgIEhpIEFuZHksCj4gCj4gCj4gICAgICAgICBJIGNv
bnNpZGVyIHRoZSBvcmRpbmFsIHBhcnQgb2YgcCBpbml0aWFsaXphdGlvbiBpcyBzbGlnaHRseQo+
ICAgICAgICAgYmV0dGVyIGFuZCBkb25lIG91dHNpZGUgb2YgcmVhZCBsb2NrLgo+IAo+ICAgICAg
ICAgU29tZXRoaW5nIGxpa2UKPiAgICAgICAgIHA9ICZpb21lbV9yZXMuLi47Cj4gICAgICAgICBy
ZWFkIGxvY2sKPiAgICAgICAgIGZvciAocCA9IHAtPmNoaWxkOyAuLi4pIHsKPiAKPiAKPiAgICAg
V2h5IHNob3VsZCB3ZSBjYXJlIGFib3V0IGRvaW5nIHRoYXQgb3V0c2lkZSBvZiB0aGUgbG9jaz8g
VGhhdCBzbWVsbHMKPiAgICAgbGlrZSBhIG1pY3JvLW9wdGltaXphdGlvbiB0aGUgY29tcGlsZXIg
d2lsbCBtb3N0IHByb2JhYmx5IG92ZXJ3cml0ZQo+ICAgICBlaXRoZXIgd2F5IGFzIHRoZSBhZGRy
ZXNzIG9mIGlvbWVtX3Jlc291cmNlIGlzIGp1c3QgY29uc3RhbnQ/Cj4gCj4gICAgIEFsc28sIGZv
ciBtZSBpdCdzIG11Y2ggbW9yZSByZWFkYWJsZSBhbmQgY29tcGFjdCBpZiB3ZSBwZXJmb3JtIGEK
PiAgICAgc2luZ2xlIGluaXRpYWxpemF0aW9uIGluc3RlYWQgb2YgdHdvIHNlcGFyYXRlIG9uZXMg
aW4gdGhpcyBjYXNlLgo+IAo+ICAgICBXZSdyZSB1c2luZyB0aGUgcGF0dGVybiBJIHVzZSBpbiwg
ZmluZF9uZXh0X2lvbWVtX3JlcygpIGFuZAo+ICAgICBfX3JlZ2lvbl9pbnRlcnNlY3RzKCksIHdo
aWxlIHdlIHVzZSB0aGUgb2xkIHBhdHRlcm4gaW4KPiAgICAgaW9tZW1fbWFwX3Nhbml0eV9jaGVj
aygpLCB3aGVyZSB3ZSBhbHNvIHVzZSB0aGUgc2FtZSB1bm5lY2Vzc2FyeQo+ICAgICByX25leHQo
KSBjYWxsLgo+IAo+ICAgICBJIG1pZ2h0IGp1c3QgY2xlYW51cCBpb21lbV9tYXBfc2FuaXR5X2No
ZWNrKCkgaW4gYSBzaW1pbGFyIHdheS4KPiAKPiAKPiAKPiBZZXMsIGl04oCZcyBsaWtlIG1pY3Jv
IG9wdGltaXphdGlvbi4gSWYgeW91IHdhbnQgeW91ciB3YXkgSSBzdWdnZXN0IHRoZW4gCj4gdG8g
YWRkIGEgbWFjcm8KPiAKPiAjZGVmaW5lIGZvcl9lYWNoX2lvbWVtX3Jlc291cmNlX2NoaWxkKCkg
XAo+ICDCoGZvciAoaW9tZW1fcmVzb3VyY2UuLi4pCgpJIHRoaW5rIHRoZSBvbmx5IHRoaW5nIHRo
YXQgcmVhbGx5IG1ha2VzIHNlbnNlIHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXMgb24gdG9w
IChub3QgY29tcGlsZWQgeWV0KToKCgpkaWZmIC0tZ2l0IGEva2VybmVsL3Jlc291cmNlLmMgYi9r
ZXJuZWwvcmVzb3VyY2UuYwppbmRleCBlYTg1M2EwNzVhODMuLjM1YWFhNzJkZjBjZSAxMDA2NDQK
LS0tIGEva2VybmVsL3Jlc291cmNlLmMKKysrIGIva2VybmVsL3Jlc291cmNlLmMKQEAgLTgwLDYg
KzgwLDExIEBAIHN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgKm5leHRfcmVzb3VyY2Vfc2tpcF9jaGls
ZHJlbihzdHJ1Y3QgcmVzb3VyY2UgKnApCiAgICAgICAgIHJldHVybiBwLT5zaWJsaW5nOwogIH0K
ICAKKyNkZWZpbmUgZm9yX2VhY2hfcmVzb3VyY2UoX3Jvb3QsIF9wLCBfc2tpcF9jaGlsZHJlbikg
XAorICAgICAgIGZvciAoKF9wKSA9IChfcm9vdCktPmNoaWxkOyAoX3ApOyBcCisgICAgICAgICAg
ICAoX3ApID0gKF9za2lwX2NoaWxkcmVuKSA/IG5leHRfcmVzb3VyY2Vfc2tpcF9jaGlsZHJlbihf
cCkgOiBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5leHRfcmVzb3Vy
Y2UoX3ApKQorCiAgc3RhdGljIHZvaWQgKnJfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQg
KnYsIGxvZmZfdCAqcG9zKQogIHsKICAgICAgICAgc3RydWN0IHJlc291cmNlICpwID0gdjsKQEAg
LTE3MTQsMTYgKzE3MTksMTYgQEAgaW50IGlvbWVtX21hcF9zYW5pdHlfY2hlY2socmVzb3VyY2Vf
c2l6ZV90IGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKICBib29sIGlvbWVtX3JhbmdlX2NvbnRh
aW5zX2V4Y2x1ZGVkKHU2NCBhZGRyLCB1NjQgc2l6ZSkKICB7CiAgICAgICAgIGNvbnN0IHVuc2ln
bmVkIGludCBmbGFncyA9IElPUkVTT1VSQ0VfU1lTVEVNX1JBTSB8IElPUkVTT1VSQ0VfRVhDTFVT
SVZFOwotICAgICAgIGJvb2wgZXhjbHVkZWQgPSBmYWxzZTsKKyAgICAgICBib29sIHNraXBfY2hp
bGRyZW4sIGV4Y2x1ZGVkID0gZmFsc2U7CiAgICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcDsKICAK
ICAgICAgICAgcmVhZF9sb2NrKCZyZXNvdXJjZV9sb2NrKTsKLSAgICAgICBmb3IgKHAgPSBpb21l
bV9yZXNvdXJjZS5jaGlsZDsgcCA7KSB7CisgICAgICAgZm9yX2VhY2hfcmVzb3VyY2UoJmlvbWVt
X3Jlc291cmNlLCBwLCBza2lwX2NoaWxkcmVuKSB7CiAgICAgICAgICAgICAgICAgaWYgKHAtPnN0
YXJ0ID49IGFkZHIgKyBzaXplKQogICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgICAgICAgICAgaWYgKHAtPmVuZCA8IGFkZHIpIHsKICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIE5vIG5lZWQgdG8gY29uc2lkZXIgY2hpbGRyZW4gKi8KLSAgICAgICAgICAgICAgICAgICAg
ICAgcCA9IG5leHRfcmVzb3VyY2Vfc2tpcF9jaGlsZHJlbihwKTsKKyAgICAgICAgICAgICAgICAg
ICAgICAgc2tpcF9jaGlsZHJlbiA9IHRydWU7CiAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsKICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgLyoKQEAgLTE3MzUsNyAr
MTc0MCw3IEBAIGJvb2wgaW9tZW1fcmFuZ2VfY29udGFpbnNfZXhjbHVkZWQodTY0IGFkZHIsIHU2
NCBzaXplKQogICAgICAgICAgICAgICAgICAgICAgICAgZXhjbHVkZWQgPSB0cnVlOwogICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICAgICAgfQotICAgICAgICAgICAg
ICAgcCA9IG5leHRfcmVzb3VyY2UocCk7CisgICAgICAgICAgICAgICBza2lwX2NoaWxkcmVuID0g
ZmFsc2U7CiAgICAgICAgIH0KICAgICAgICAgcmVhZF91bmxvY2soJnJlc291cmNlX2xvY2spOwog
IApAQCAtMTc1NSw3ICsxNzYwLDcgQEAgc3RhdGljIGludCBzdHJpY3RfaW9tZW1fY2hlY2tzOwog
IGJvb2wgaW9tZW1faXNfZXhjbHVzaXZlKHU2NCBhZGRyKQogIHsKICAgICAgICAgc3RydWN0IHJl
c291cmNlICpwOwotICAgICAgIGJvb2wgZXJyID0gZmFsc2U7CisgICAgICAgYm9vbCBza2lwX2No
aWxkcmVuLCBlcnIgPSBmYWxzZTsKICAgICAgICAgaW50IHNpemUgPSBQQUdFX1NJWkU7CiAgCiAg
ICAgICAgIGlmICghc3RyaWN0X2lvbWVtX2NoZWNrcykKQEAgLTE3NjQsNyArMTc2OSw3IEBAIGJv
b2wgaW9tZW1faXNfZXhjbHVzaXZlKHU2NCBhZGRyKQogICAgICAgICBhZGRyID0gYWRkciAmIFBB
R0VfTUFTSzsKICAKICAgICAgICAgcmVhZF9sb2NrKCZyZXNvdXJjZV9sb2NrKTsKLSAgICAgICBm
b3IgKHAgPSBpb21lbV9yZXNvdXJjZS5jaGlsZDsgcCA7KSB7CisgICAgICAgZm9yX2VhY2hfcmVz
b3VyY2UoJmlvbWVtX3Jlc291cmNlLCBwLCBza2lwX2NoaWxkcmVuKSB7CiAgICAgICAgICAgICAg
ICAgLyoKICAgICAgICAgICAgICAgICAgKiBXZSBjYW4gcHJvYmFibHkgc2tpcCB0aGUgcmVzb3Vy
Y2VzIHdpdGhvdXQKICAgICAgICAgICAgICAgICAgKiBJT1JFU09VUkNFX0lPIGF0dHJpYnV0ZT8K
QEAgLTE3NzMsNyArMTc3OCw3IEBAIGJvb2wgaW9tZW1faXNfZXhjbHVzaXZlKHU2NCBhZGRyKQog
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICAgICAgaWYgKHAtPmVu
ZCA8IGFkZHIpIHsKICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE5vIG5lZWQgdG8gY29uc2lk
ZXIgY2hpbGRyZW4gKi8KLSAgICAgICAgICAgICAgICAgICAgICAgcCA9IG5leHRfcmVzb3VyY2Vf
c2tpcF9jaGlsZHJlbihwKTsKKyAgICAgICAgICAgICAgICAgICAgICAgc2tpcF9jaGlsZHJlbiA9
IHRydWU7CiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgICAg
ICB9CiAgCkBAIC0xNzg4LDcgKzE3OTMsNyBAQCBib29sIGlvbWVtX2lzX2V4Y2x1c2l2ZSh1NjQg
YWRkcikKICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHRydWU7CiAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgICAgICB9Ci0gICAgICAgICAgICAgICBwID0g
bmV4dF9yZXNvdXJjZShwKTsKKyAgICAgICAgICAgICAgIHNraXBfY2hpbGRyZW4gPSBmYWxzZTsK
ICAgICAgICAgfQogICAgICAgICByZWFkX3VubG9jaygmcmVzb3VyY2VfbG9jayk7CiAgCgoKVGhv
dWdodHM/CgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
