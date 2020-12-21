Return-Path: <SRS0=paXq=FZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506ECC433E0
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 11:14:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3814227BF
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 11:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3814227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49F9D877D5;
	Mon, 21 Dec 2020 11:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jsavd62DGcNz; Mon, 21 Dec 2020 11:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D80F87745;
	Mon, 21 Dec 2020 11:14:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C92FC1825;
	Mon, 21 Dec 2020 11:14:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D39BFC0893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 11:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C15F0877B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 11:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pm39F8D9hF0T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 11:14:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA28387745
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608549269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDuzjQILtwz+gw9q0HmA3y9zkFhYkHaBbPqeWnl780o=;
 b=H3+QLBjB+lAZijdExmTGmDyu53bIJW2w1z3Dlb058IyN6bd2G5jVch3Ww4kIWpYqa2q9Rg
 /UXFHeYf2URSzgpkNUa57D7EUxN3aTpH8ix5o2K9FgfYckQ7Irjw9Lc48vntLRJ/kksUb1
 BfDnoMYAPxKufKHiWBOXy5GAvjIgud0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-EMWsoKprMSuCXwicodcYGQ-1; Mon, 21 Dec 2020 06:14:28 -0500
X-MC-Unique: EMWsoKprMSuCXwicodcYGQ-1
Received: by mail-wm1-f72.google.com with SMTP id u9so4163768wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 03:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZDuzjQILtwz+gw9q0HmA3y9zkFhYkHaBbPqeWnl780o=;
 b=jZmlQuLBzCeWde2G/O0scesauI86Xth3AsCPlHK2kQiSrK/5NlxOJZPmWy2MMv3iHd
 GsBIu+kGfq2hL7rrlvLp8FVKIt0WpVmWbvkvUb8mwRyaLuGrVU4EsEoWjEdcNSt6joqw
 BcikTnQvPw+4u7hDk9rwxMD+8viY+so3CyhCcJU/OU/zZfmKC7xDN9Rr/9PCAu51KqBp
 qEjwr4084oYBhXCJyrr2pXNHloR3DQoNTHXFV65OAdYwh4DDvC7jEOIU0o2VVIKorvKb
 VI8a76cILsPVhbFRYRb+KZtRcyBu2RhmxwjM9OYYtKou5kgWP4Xk9K31YQu2uLPjMeJB
 cm2w==
X-Gm-Message-State: AOAM532BVQf6WoID7cDkGJNb3a0Ndl9HuiRZa0O2mIBw7iCcF0plCQ6d
 EXr+WGC1bXbhwRRhO4UYsvcRI4yKASZCmIm969KDyaekgi/ccnKWEXkTfMz0/WcCL0Gmt5MHr1x
 6M3LhjCrgHJbvyuq6fQRakSutTu54TatbpNFWx1XnhQ==
X-Received: by 2002:adf:e710:: with SMTP id c16mr18449658wrm.295.1608549266982; 
 Mon, 21 Dec 2020 03:14:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3nV2W14x0SGDcjI6dNEEZouk16bJA3Gmr/23ZBhO5vNIp1gfRAr6YwQplvjk3uknYrvF/0w==
X-Received: by 2002:adf:e710:: with SMTP id c16mr18449635wrm.295.1608549266799; 
 Mon, 21 Dec 2020 03:14:26 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id c10sm27792009wrb.92.2020.12.21.03.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 03:14:25 -0800 (PST)
Date: Mon, 21 Dec 2020 12:14:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201221111423.sestfroiw2dgpluc@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6MTY6NTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMi8xOCDkuIvljYg3OjM4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+VGhhbmtzIHRvIE1heCB0aGF0IHN0YXJ0ZWQgdGhpcyB3b3JrIQo+Pj4+SSB0
b29rIGhpcyBwYXRjaGVzLCBhbmQgZXh0ZW5kZWQgdGhlIGJsb2NrIHNpbXVsYXRvciBhIGJpdC4K
Pj4+Pgo+Pj4+VGhpcyBzZXJpZXMgbW92ZXMgdGhlIG5ldHdvcmsgZGV2aWNlIHNpbXVsYXRvciBp
biBhIG5ldyBtb2R1bGUKPj4+Pih2ZHBhX3NpbV9uZXQpIGFuZCBsZWF2ZXMgdGhlIGdlbmVyaWMg
ZnVuY3Rpb25zIGluIHRoZSB2ZHBhX3NpbSBjb3JlCj4+Pj5tb2R1bGUsIGFsbG93aW5nIHRoZSBw
b3NzaWJpbGl0eSB0byBhZGQgbmV3IHZEUEEgZGV2aWNlIHNpbXVsYXRvcnMuCj4+Pj5UaGVuIHdl
IGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBtb2R1bGUgdG8gc2ltdWxhdGUgYSBibG9jayBkZXZp
Y2UuCj4+Pj4KPj4+PkknbSBub3Qgc3VyZSBhYm91dCBwYXRjaCAxMSAoInZyaW5naDogYWxsb3cg
dnJpbmdoX2lvdl94ZmVyKCkgdG8gc2tpcAo+Pj4+Ynl0ZXMgd2hlbiBwdHIgaXMgTlVMTCIpLCBt
YXliZSB3ZSBjYW4gYWRkIGEgbmV3IGZ1bmN0aW9ucyBpbnN0ZWFkIG9mCj4+Pj5tb2RpZnkgdnJp
bmdoX2lvdl94ZmVyKCkuCj4+Pj4KPj4+PkFzIE1heCByZXBvcnRlZCwgSSdtIGFsc28gc2VlaW5n
IGVycm9ycyB3aXRoIHZkcGFfc2ltX2JsayByZWxhdGVkIHRvCj4+Pj5pb3RsYiBhbmQgdnJpbmdo
IHdoZW4gdGhlcmUgaXMgaGlnaCBsb2FkLCB0aGVzZSBhcmUgc29tZSBvZiB0aGUgZXJyb3IKPj4+
Pm1lc3NhZ2VzIEkgY2FuIHNlZSByYW5kb21seToKPj4+Pgo+Pj4+wqAgdnJpbmdoOiBGYWlsZWQg
dG8gYWNjZXNzIGF2YWlsIGlkeCBhdCAwMDAwMDAwMGU4ZGViMmNjCj4+Pj7CoCB2cmluZ2g6IEZh
aWxlZCB0byByZWFkIGhlYWQ6IGlkeCA2Mjg5IGFkZHJlc3MgMDAwMDAwMDBlMWFkMWQ1MAo+Pj4+
wqAgdnJpbmdoOiBGYWlsZWQgdG8gZ2V0IGZsYWdzIGF0IDAwMDAwMDAwNjYzNWQ3YTMKPj4+Pgo+
Pj4+wqAgdmlydGlvX3ZkcGEgdmRwYTA6IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigpIGVycm9yOiAt
MTQgb2Zmc2V0OiAKPj4+PsKgIDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4+PsKgIHZpcnRpb192
ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1bGxfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogCj4+
Pj7CoCAweDU4ZWUwMDAgbGVuOiAweDMwMDAKPj4+Pgo+Pj4+VGhlc2UgZXJyb3JzIHNob3VsZCBh
bGwgYmUgcmVsYXRlZCB0byB0aGUgZmFjdCB0aGF0IGlvdGxiX3RyYW5zbGF0ZSgpCj4+Pj5mYWls
cyB3aXRoIC1FSU5WQUwsIHNvIGl0IHNlZW1zIHRoYXQgd2UgbWlzcyBzb21lIG1hcHBpbmcuCj4+
Pgo+Pj4KPj4+SXMgdGhpcyBvbmx5IHJlcHJvZHVjaWJsZSB3aGVuIHRoZXJlJ3MgbXVsdGlwbGUg
Y28tY3VycmVudCAKPj4+YWNjZXNzaW5nIG9mIElPVExCPyBJZiB5ZXMsIGl0J3MgcHJvYmFibHkg
YSBoaW50IHRoYXQgc29tZSBraW5kIG9mIAo+Pj5zeW5jaHJvbml6YXRpb24gaXMgc3RpbGwgbWlz
c2VkIHNvbWV3aGVyZS4KPj4+Cj4+Pkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cgdGhlIGRtYV9t
YXAvdW5tcCBpbiBib3RoIHZpcnRpb19yaW5nIGFuZCAKPj4+dnJpbmdoIHRvIHNlZSB3aG8gaXMg
bWlzc2luZyB0aGUgbWFwLgo+Pj4KPj4KPj5KdXN0IGFuIHVwZGF0ZSBhYm91dCB0aGVzZSBpc3N1
ZXMgd2l0aCB2ZHBhLXNpbS1ibGsuCj4+SSd2ZSBiZWVuIGZvY3VzaW5nIGEgbGl0dGxlIGJpdCBv
biB0aGVzZSBmYWlsdXJlcyBvdmVyIHRoZSBsYXN0IGZldyAKPj5kYXlzIGFuZCBoYXZlIGZvdW5k
IHR3byBpc3N1ZXMgcmVsYXRlZCB0byB0aGUgSU9UTEIvSU9NTVU6Cj4+Cj4+MS4gU29tZSByZXF1
ZXN0cyBjb21pbmcgZnJvbSB0aGUgYmxvY2sgbGF5ZXIgZmlsbHMgdGhlIFNHIGxpc3Qgd2l0aCAK
Pj5tdWx0aXBsZSBidWZmZXJzIHRoYXQgaGFkIHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3MuIFRo
aXMgaGFwcGVucyAKPj5mb3IgZXhhbXBsZSB3aGlsZSB1c2luZyAnbWtmcycsIGF0IHNvbWUgcG9p
bnRzIG11bHRpcGxlIHNlY3RvcnMgYXJlIAo+Pnplcm9lZCBzbyBtdWx0aXBsZSBTRyBlbGVtZW50
cyBwb2ludCB0byB0aGUgc2FtZSBwaHlzaWNhbCBwYWdlIHRoYXQgCj4+aXMgemVyb2VkLgo+PlNp
bmNlIHdlIGFyZSB1c2luZyB2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoKSBpbiB0aGUgCj4+dmRwYXNp
bV91bm1hcF9wYWdlKCksIHRoaXMgcmVtb3ZlcyBhbGwgdGhlIG92ZXJsYXBwZWQgcmFuZ2VzLiBJ
IAo+PmZpeGVkIHJlbW92aW5nIGEgc2luZ2xlIG1hcCBpbiB2ZHBhc2ltX3VubWFwX3BhZ2UoKSwg
YnV0IGhhcyBhbiAKPj5hbHRlcm5hdGl2ZSB3ZSBjYW4gaW1wbGVtZW50IHNvbWUga2luZCBvZiBy
ZWZlcmVuY2UgY291bnRzLgo+Cj4KPkkgdGhpbmsgd2UgbmVlZCB0byBkbyB3aGF0IGhhcmR3YXJl
IGRvLiBTbyB1c2luZyByZWZjb3VudCBpcyBwcm9iYWJseSAKPm5vdCBhIGdvb2QgaWRhLgoKT2th
eSwgc28gc2luY2Ugd2UgYXJlIHVzaW5nIGZvciBzaW1wbGljaXR5IGFuIGlkZW50aWNhbCBtYXBw
aW5nLCB3ZSBhcmUgCmFzc2lnbmluZyB0aGUgc2FtZSBkbWFfYWRkciB0byBtdWx0aXBsZSBwYWdl
cy4KClNvLCBpdCBzaG91bGQgYmUgb2theSB0byByZW1vdmUgYSBzaW5nbGUgbWFwcGluZyBjaGVj
a2luZyB0aGUgb3RoZXJzIApwYXJhbWV0ZXJzIChpLmUuIGRpciwgc2l6ZSkuCgpJJ2xsIHNlbmQg
YSBwYXRjaCwgc28gd2l0aCB0aGUgY29kZSBpdCBzaG91bGQgYmUgZWFzaWVyIDotKQoKVGhhbmtz
LApTdGVmYW5vCgo+Cj4KPj4KPj4yLiBUaGVyZSB3YXMgYSByYWNlIGJldHdlZW4gZG1hX21hcC91
bm1hcCBhbmQgdGhlIHdvcmtlciB0aHJlYWQsIAo+PnNpbmNlIGJvdGggYXJlIGFjY2Vzc2luZyB0
aGUgSU9NTVUuIFRha2luZyB0aGUgaW9tbXVfbG9jayB3aGlsZSAKPj51c2luZyB2aG9zdF9pb3Rs
Yl8qIEFQSSBpbiB0aGUgd29ya2VyIHRocmVhZCBmaXhlcyB0aGUgInZyaW5naDogCj4+RmFpbGVk
IHRvICoiIGlzc3Vlcy4KPj4KPj5XaGl0IHRoZXNlIGlzc3VlcyBmaXhlZCB0aGUgdmRwYS1ibGsg
c2ltdWxhdG9yIHNlZW1zIHRvIHdvcmsgd2VsbC4KPj5JJ2xsIHNlbmQgdGhlIHBhdGNoZXMgbmV4
dCB3ZWVrIG9yIGFmdGVyIHRoZSBicmVhay4KPgo+Cj5Hb29kIHRvIGtub3cgdGhpcy4KPgo+VGhh
bmtzCj4KPgo+Pgo+PlRoYW5rcywKPj5TdGVmYW5vCj4+Cj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
