Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2FC433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 22:29:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2CB2253A
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2CB2253A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1945720378;
	Mon,  4 Jan 2021 22:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hBjduOOn2WaK; Mon,  4 Jan 2021 22:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 498922011A;
	Mon,  4 Jan 2021 22:29:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FFECC0893;
	Mon,  4 Jan 2021 22:29:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87C8BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 22:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E4C685EB4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 22:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id srkqdAdUYmZR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 22:29:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5F9B485EA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 22:29:48 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id n26so38833613eju.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jan 2021 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bZYZtiZqtjiM5mTKJrFBVkfoUrE9/7TPDo+TfeeGsN0=;
 b=SZ0tfQHLhsr9W1ajzZ39FhUzRaxy3x+zBWBSD+fu8SGm84RUr8oeAtTXXk34EIqT80
 tDMqqZ6IdhqCS6JSANuPqibcoPCEoly7svMmOTZFAPM2+CsDRFNM7PDMeYhE+m7oeIxf
 +8GSdXQNOjaF8R0tToPJnc0n0RUoTrRkrCGnHcNek2i5t/XbwHT1ZJH9ZFYOX5OQTl09
 Tvhaup+6QcssSXygg5EhjaW6SkhdaAA9pFJYgBeZTethdmdHFkGzSKrHPaZpiN0srscY
 HEcLktaEA2rc8qprUWbvJ1yVRNnuoYCACG9cGgQxBit2TOzM4VehHDRkZC0hFtdJysbt
 4KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bZYZtiZqtjiM5mTKJrFBVkfoUrE9/7TPDo+TfeeGsN0=;
 b=RLXlVtfqw9ucEEQahCtClzPMVV3dMZwJc4/xQnLlCPi9WplTpF/84jJk9chAHWiEa8
 gHlGybi48YqCS5WI5dOGKe4AT4kkOpPtfjiKfgaLyG3AgdCz1WdGoL87tOS5fbQc22+Q
 lqYvZIFCOPGGKkYkAFmNAYx1DgNI9ZSFB89wkANTJ9/r0X1CSnhL5Q1ryoaSqPYXghyf
 g86ncV6zSOl1HpT5H/GQg02qjV0D++pLuM7pbsrYvpcNM4wUmflL6rRHUgMoWjPB61hF
 QqwEouJqihhuGl8b4zN8AjcUi10KLPojHzTK4al5kkqqRpd2Ab9uOJuDRRoqVoe6H3Y6
 IrSQ==
X-Gm-Message-State: AOAM530S5YIeNWF6eC389Lk2WIUeNMjrbh92fY0+eepY0X3LFlqlLWsO
 WmamO6VyWlkSvTnIInW6ICRKtGmdM04Lw2hKtiYqvQ==
X-Google-Smtp-Source: ABdhPJxXfxM1BhY/5z030aM8G0Z4MMK7+AFboBuQ+Z7CQL9mSMsZkJ/4MtVxebNyRvqCTydGRunUvLgJHIogTDu1raY=
X-Received: by 2002:a17:906:edb2:: with SMTP id
 sa18mr65644898ejb.264.1609799386671; 
 Mon, 04 Jan 2021 14:29:46 -0800 (PST)
MIME-Version: 1.0
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
In-Reply-To: <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 14:29:40 -0800
Message-ID: <CAPcyv4hkAN1hz=9yJ2CRYfNQ3Tjwm6z+Fghti9QKZLN-ZfR5aQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBKYW4gNCwgMjAyMSBhdCAxMjoxMSBQTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPgo+ID4gQW0gMDQuMDEuMjAyMSB1bSAyMDo1MiBzY2hyaWVi
IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+Ogo+ID4KPiA+IO+7v09uIDEvNC8y
MSAxMToyNyBBTSwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4gPj4+IE9uIE1vbiwgSmFuIDA0LCAy
MDIxIGF0IDExOjE5OjEzQU0gLTA4MDAsIERhdmUgSGFuc2VuIHdyb3RlOgo+ID4+PiBPbiAxMi8y
MS8yMCA4OjMwIEFNLCBMaWFuZyBMaSB3cm90ZToKPiA+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
cGFnZS1mbGFncy5oCj4gPj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaAo+ID4+
Pj4gQEAgLTEzNyw2ICsxMzcsOSBAQCBlbnVtIHBhZ2VmbGFncyB7Cj4gPj4+PiAjZW5kaWYKPiA+
Pj4+ICNpZmRlZiBDT05GSUdfNjRCSVQKPiA+Pj4+ICAgIFBHX2FyY2hfMiwKPiA+Pj4+ICsjZW5k
aWYKPiA+Pj4+ICsjaWZkZWYgQ09ORklHX1BSRVpFUk9fUEFHRQo+ID4+Pj4gKyAgICBQR196ZXJv
LAo+ID4+Pj4gI2VuZGlmCj4gPj4+PiAgICBfX05SX1BBR0VGTEFHUywKPiA+Pj4KPiA+Pj4gSSBk
b24ndCB0aGluayB0aGlzIGlzIHdvcnRoIGEgZ2VuZXJpYyBwYWdlLT5mbGFncyBiaXQuCj4gPj4+
Cj4gPj4+IFRoZXJlJ3MgYSB0b24gb2Ygc3BhY2UgaW4gJ3N0cnVjdCBwYWdlJyBmb3IgcGFnZXMg
dGhhdCBhcmUgaW4gdGhlCj4gPj4+IGFsbG9jYXRvci4gIENhbid0IHdlIHVzZSBzb21lIG9mIHRo
YXQgc3BhY2U/Cj4gPj4KPiA+PiBJIHdhcyBnb2luZyB0byBvYmplY3QgdG8gdGhhdCB0b28sIGJ1
dCBJIHRoaW5rIHRoZSBlbnRpcmUgYXBwcm9hY2ggaXMKPiA+PiBmbGF3ZWQgYW5kIG5lZWRzIHRv
IGJlIHRocm93biBvdXQuICBJdCBqdXN0IG51a2VzIHRoZSBjYWNoZXMgaW4gZXh0cmVtZWx5Cj4g
Pj4gc3VidGxlIGFuZCBoYXJkIHRvIG1lYXN1cmUgd2F5cywgbG93ZXJpbmcgb3ZlcmFsbCBzeXN0
ZW0gcGVyZm9ybWFuY2UuCj4gPgo+ID4gWWVhaCwgaXQgY2VydGFpbmx5IGNhbid0IGJlIHRoZSBk
ZWZhdWx0LCBidXQgaXQgKmlzKiB1c2VmdWwgZm9yIHRoaW5nCj4gPiB3aGVyZSB3ZSBrbm93IHRo
YXQgdGhlcmUgYXJlIG5vIGNhY2hlIGJlbmVmaXRzIHRvIHplcm9pbmcgY2xvc2UgdG8gd2hlcmUK
PiA+IHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkLgo+ID4KPiA+IFRoZSB0cmljayBpcyBvcHRpbmcg
aW50byBpdCBzb21laG93LCBlaXRoZXIgaW4gYSBwcm9jZXNzIG9yIGEgVk1BLgo+ID4KPgo+IFRo
ZSBwYXRjaCBzZXQgaXMgbW9zdGx5IHRyeWluZyB0byBvcHRpbWl6ZSBzdGFydGluZyBhIG5ldyBw
cm9jZXNzLiBTbyBwcm9jZXNzL3ZtYSBkb2VzbuKAmHQgcmVhbGx5IHdvcmsuCj4KPiBJIHN0aWxs
IHdvbmRlciBpZiB1c2luZyB0bXBmcy9zaG1lbSBjYW5ub3Qgc29tZWhvdyBiZSB1c2VkIHRvIGNv
dmVyIHRoZSBvcmlnaW5hbCB1c2UgY2FzZSBvZiBzdGFydGluZyBhIG5ldyB2bSBmYXN0IChvciBy
ZWJvb3RpbmcgYW4gZXhpc3Rpbmcgb25lIGludm9sdmluZyByZXN0YXJ0aW5nIHRoZSBwcm9jZXNz
KS4KCklmIGl0J3MgcmVib290aW5nIGEgVk0gdGhlbiBmaWxlLWJhY2tlZCBzaG91bGQgYmUgYWJs
ZSB0byBza2lwIHRoZQp6ZXJvaW5nIGJlY2F1c2UgdGhlIHN0YWxlIGRhdGEgZXhwb3N1cmUgaXMg
b25seSB0byBpdHNlbGYuIElmIHRoZQptZW1vcnkgaXMgYmVpbmcgcmVwdXJwb3NlZCB0byBhIG5l
dyBWTSB0aGVuIHRoZSBmaWxlIG5lZWRzIHRvIGJlCnJlYWxsb2NhdGVkIC8gcmUtemVyb2VkIGp1
c3QgbGlrZSB0aGUgYW5vbnltb3VzIGNhc2UuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
