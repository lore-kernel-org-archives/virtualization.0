Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9CEC4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 11:23:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB96260F91
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 11:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB96260F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68B36827C9;
	Thu, 12 Aug 2021 11:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2GOwxpDI_HWq; Thu, 12 Aug 2021 11:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECBF880D63;
	Thu, 12 Aug 2021 11:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC412C001A;
	Thu, 12 Aug 2021 11:23:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0634C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D794840E18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdl-pMGMNoEV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:23:32 +0000 (UTC)
X-Greylist: delayed 00:07:08 by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E28640DE9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:23:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="237361324"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; d="scan'208";a="237361324"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 04:16:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; d="scan'208";a="469725505"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 04:16:01 -0700
Received: from andy by smile with local (Exim 4.94.2)
 (envelope-from <andy.shevchenko@gmail.com>)
 id 1mE8gk-008Z2D-MY; Thu, 12 Aug 2021 14:15:54 +0300
Date: Thu, 12 Aug 2021 14:15:54 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <YRUC6p+9jKmXu/NT@smile.fi.intel.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
 <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
 <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
 <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDk6MzQ6MDBBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6Cj4gT24gMTIuMDguMjEgMDk6MTQsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiA+
IE9uIFRodXJzZGF5LCBBdWd1c3QgMTIsIDIwMjEsIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tCj4gPiA8bWFpbHRvOmRhdmlkQHJlZGhhdC5jb20+PiB3cm90ZToKPiA+ICAgICBP
biAxMS4wOC4yMSAyMjo0NywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+ID4gICAgICAgICBPbiBX
ZWRuZXNkYXksIEF1Z3VzdCAxMSwgMjAyMSwgRGF2aWQgSGlsZGVuYnJhbmQKPiA+ICAgICAgICAg
PGRhdmlkQHJlZGhhdC5jb20gPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPgo+ID4gICAgICAgICA8
bWFpbHRvOmRhdmlkQHJlZGhhdC5jb20gPG1haWx0bzpkYXZpZEByZWRoYXQuY29tPj4+IHdyb3Rl
OgoKPiA+IFllcywgaXTigJlzIGxpa2UgbWljcm8gb3B0aW1pemF0aW9uLiBJZiB5b3Ugd2FudCB5
b3VyIHdheSBJIHN1Z2dlc3QgdGhlbgo+ID4gdG8gYWRkIGEgbWFjcm8KPiA+IAo+ID4gI2RlZmlu
ZSBmb3JfZWFjaF9pb21lbV9yZXNvdXJjZV9jaGlsZCgpIFwKPiA+ICDCoGZvciAoaW9tZW1fcmVz
b3VyY2UuLi4pCj4gCj4gSSB0aGluayB0aGUgb25seSB0aGluZyB0aGF0IHJlYWxseSBtYWtlcyBz
ZW5zZSB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzIG9uIHRvcCAobm90IGNvbXBpbGVkIHll
dCk6CgpNYWtlcyBzZW5zZSB0byBtZSwgdGhhbmtzLCBnbyBmb3IgaXQhCgotLSAKV2l0aCBCZXN0
IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
