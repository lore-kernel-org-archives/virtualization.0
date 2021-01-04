Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86219C43381
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 20:11:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C83221F8
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 20:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C83221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 489E5861E3;
	Mon,  4 Jan 2021 20:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLxaxEEXJhjF; Mon,  4 Jan 2021 20:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53A56861CE;
	Mon,  4 Jan 2021 20:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083A6C0893;
	Mon,  4 Jan 2021 20:11:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63A89C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 53CA0861CE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U_fMmxeYN-ti
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:11:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3D5F1861C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609791074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzb8vPZ5tL+JqIKlDSV+9+O5aQFXZvXFgnRErEP99Qs=;
 b=PtpD3d5bFfMMFVJvwEzKmakIkvDI0iFwDdugXNy0+PgsZLRGaL13IS3LtxrtC+jRPewdFI
 5vW72vIWJNRZ8r9cuDq8Ur/DqHcDvadfGoTFA6lgWXoWNVJR8iISBWnxyZyID8lC43aVDE
 qUwKNH7+u8l0Naqv3Nni3Iur1+Xiklo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-scAfyLIkN5SYWgfdb2wg4Q-1; Mon, 04 Jan 2021 15:11:10 -0500
X-MC-Unique: scAfyLIkN5SYWgfdb2wg4Q-1
Received: by mail-wr1-f72.google.com with SMTP id w8so13726459wrv.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jan 2021 12:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Uf7YcQ6j4//fvt+DAqWWp4t8Vqx45+iboex03SWw704=;
 b=OrupQAdq4nPNKXdxtzaJCZV95DCobcC48xTBNc6i5zCaT2AMc3QecWBTce/LSMMwWS
 1fa57OzJMr0DMPcTUQLCjw1AwcpLu2eAOk6zEe/t5RZQgLI14ybw09rTGlYW3n9CLW3k
 aGfQmwsUuDq0SSuOPD+K5l8JckONxdO30Nc3pdtuL/Q7YtR7q6EZqMbhnujUQKoqhK6F
 shzecfczSF1LaLQUfTtmGWepTApdZq4+KvkWfzR2coaP4vw+7MoAUe3HUP/tYb/kZYH0
 4AT5pmWIkKlTP44T9hqm2DhyH44Y+ZEpsFBtvv0hR00eIy9uHL1l2SLfOYfzGPeVna3u
 b9OQ==
X-Gm-Message-State: AOAM5333sIPQvV8fNTAmGKgiGLcw0x6VEZP565dUdEpqGi2Hf9IVob6z
 YIDp8arraHEFBx2Y5w84lxfL2ZA7tvSpP7Z75heHfG+gA6XHZVsUfGyvJPXn5K34DP024t/vXCf
 IdQYkvI/XD8G+obbT7scvzBWfr//DOUuMIqKIOhuctg==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr80661639wrm.167.1609791069113; 
 Mon, 04 Jan 2021 12:11:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkdFEzyOlA3Y8Eyk0/ltCkVecx3CgLuE1hJOwodBehjEmZXochwhSLXoNLGXuGRBsrbBGEYg==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr80661617wrm.167.1609791068978; 
 Mon, 04 Jan 2021 12:11:08 -0800 (PST)
Received: from [192.168.3.108] (p5b0c69d7.dip0.t-ipconnect.de. [91.12.105.215])
 by smtp.gmail.com with ESMTPSA id 138sm731389wma.41.2021.01.04.12.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jan 2021 12:11:08 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
Date: Mon, 4 Jan 2021 21:11:07 +0100
Message-Id: <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
In-Reply-To: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18C66)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
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

Cj4gQW0gMDQuMDEuMjAyMSB1bSAyMDo1MiBzY2hyaWViIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+Ogo+IAo+IO+7v09uIDEvNC8yMSAxMToyNyBBTSwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6Cj4+PiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAxMToxOToxM0FNIC0wODAwLCBEYXZl
IEhhbnNlbiB3cm90ZToKPj4+IE9uIDEyLzIxLzIwIDg6MzAgQU0sIExpYW5nIExpIHdyb3RlOgo+
Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oCj4+Pj4gKysrIGIvaW5jbHVkZS9s
aW51eC9wYWdlLWZsYWdzLmgKPj4+PiBAQCAtMTM3LDYgKzEzNyw5IEBAIGVudW0gcGFnZWZsYWdz
IHsKPj4+PiAjZW5kaWYKPj4+PiAjaWZkZWYgQ09ORklHXzY0QklUCj4+Pj4gICAgUEdfYXJjaF8y
LAo+Pj4+ICsjZW5kaWYKPj4+PiArI2lmZGVmIENPTkZJR19QUkVaRVJPX1BBR0UKPj4+PiArICAg
IFBHX3plcm8sCj4+Pj4gI2VuZGlmCj4+Pj4gICAgX19OUl9QQUdFRkxBR1MsCj4+PiAKPj4+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBpcyB3b3J0aCBhIGdlbmVyaWMgcGFnZS0+ZmxhZ3MgYml0Lgo+Pj4g
Cj4+PiBUaGVyZSdzIGEgdG9uIG9mIHNwYWNlIGluICdzdHJ1Y3QgcGFnZScgZm9yIHBhZ2VzIHRo
YXQgYXJlIGluIHRoZQo+Pj4gYWxsb2NhdG9yLiAgQ2FuJ3Qgd2UgdXNlIHNvbWUgb2YgdGhhdCBz
cGFjZT8KPj4gCj4+IEkgd2FzIGdvaW5nIHRvIG9iamVjdCB0byB0aGF0IHRvbywgYnV0IEkgdGhp
bmsgdGhlIGVudGlyZSBhcHByb2FjaCBpcwo+PiBmbGF3ZWQgYW5kIG5lZWRzIHRvIGJlIHRocm93
biBvdXQuICBJdCBqdXN0IG51a2VzIHRoZSBjYWNoZXMgaW4gZXh0cmVtZWx5Cj4+IHN1YnRsZSBh
bmQgaGFyZCB0byBtZWFzdXJlIHdheXMsIGxvd2VyaW5nIG92ZXJhbGwgc3lzdGVtIHBlcmZvcm1h
bmNlLgo+IAo+IFllYWgsIGl0IGNlcnRhaW5seSBjYW4ndCBiZSB0aGUgZGVmYXVsdCwgYnV0IGl0
ICppcyogdXNlZnVsIGZvciB0aGluZwo+IHdoZXJlIHdlIGtub3cgdGhhdCB0aGVyZSBhcmUgbm8g
Y2FjaGUgYmVuZWZpdHMgdG8gemVyb2luZyBjbG9zZSB0byB3aGVyZQo+IHRoZSBtZW1vcnkgaXMg
YWxsb2NhdGVkLgo+IAo+IFRoZSB0cmljayBpcyBvcHRpbmcgaW50byBpdCBzb21laG93LCBlaXRo
ZXIgaW4gYSBwcm9jZXNzIG9yIGEgVk1BLgo+IAoKVGhlIHBhdGNoIHNldCBpcyBtb3N0bHkgdHJ5
aW5nIHRvIG9wdGltaXplIHN0YXJ0aW5nIGEgbmV3IHByb2Nlc3MuIFNvIHByb2Nlc3Mvdm1hIGRv
ZXNu4oCYdCByZWFsbHkgd29yay4KCkkgc3RpbGwgd29uZGVyIGlmIHVzaW5nIHRtcGZzL3NobWVt
IGNhbm5vdCBzb21laG93IGJlIHVzZWQgdG8gY292ZXIgdGhlIG9yaWdpbmFsIHVzZSBjYXNlIG9m
IHN0YXJ0aW5nIGEgbmV3IHZtIGZhc3QgKG9yIHJlYm9vdGluZyBhbiBleGlzdGluZyBvbmUgaW52
b2x2aW5nIHJlc3RhcnRpbmcgdGhlIHByb2Nlc3MpLgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
