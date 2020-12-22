Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F799C433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 10:57:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C73323103
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 10:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C73323103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 163672721B;
	Tue, 22 Dec 2020 10:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MU4+QnzKIcHL; Tue, 22 Dec 2020 10:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 036332284F;
	Tue, 22 Dec 2020 10:57:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7BAEC1825;
	Tue, 22 Dec 2020 10:57:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD97C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 10:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 57FF2869DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 10:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMn+wC1EJxBO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 10:57:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F946869D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608634661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUqZxqa8Hto+LIciCh/MDtUD1YZexx2bkHHuabHifwA=;
 b=Nt/LALrV06hSXvBaIqW7TTm6d1j007ak7Z+Namo1oEP4pu7vjC/dMvE7a2v85Js7Gu+f2k
 oKG6vurhVsHCj7vo/LvWUhq4+yTUICcyRl/nJwt1vWuco7qzcuxTrjBysvyieGA1ZnwB/R
 ooUGx9B84vBijN7zHyozNYSb8dPihJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-cc2FbgF4NTCK8i7I-dorpQ-1; Tue, 22 Dec 2020 05:57:38 -0500
X-MC-Unique: cc2FbgF4NTCK8i7I-dorpQ-1
Received: by mail-wm1-f69.google.com with SMTP id b4so1531470wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 02:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HUqZxqa8Hto+LIciCh/MDtUD1YZexx2bkHHuabHifwA=;
 b=hI0gRhRFZIYv347l3G6Y17i/MiPwD65wORQLbIyM16aSqmm8WIUxH5fOi6W3RVpeCi
 HMbnNSRiTLdhJUqU/PNcqy9lI94JCg1WfgC9XSq7FHFjSMqOndDEiubuEIJqWlNwUVOD
 7bFvvxmbDFYK2qlZ2PS5GqRyJL02/CLbNqlgAjcpFahCzWvjQX0xziOhGvGZ3QuWkoOy
 da+2yagzhJjPGE5X/pWBQeHgbQv5dOCUcp6EqjjuXQwOZfS0MbLWdkpEQ4Mgg2X+Qkoq
 cxIILcRqcjAfBFcQPNz0w4MAr85g9xCYlMWR+d14iNk4ruHqB6tLA3Izf7FRjut7vQXK
 Tmqg==
X-Gm-Message-State: AOAM532Y9qn7vZ7fXgMc4HXh4rsMdRu4NEs6zBsowdp/8SEj1dQl+LUI
 f4BO+jAOJUKBK5umXnT8PV4durHupXhkAtYOp0M7CUfOgll0frnKwAiXl17Xv9mmr0VCBfKKuZL
 rDpZF3+Yqvg11YR0PR86XZhcx52sCvwSjYPBkmqRXPQ==
X-Received: by 2002:a1c:4684:: with SMTP id
 t126mr21204137wma.165.1608634657654; 
 Tue, 22 Dec 2020 02:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnZK58B0WG9HQAYkhmv2Ni3xwkfZ+ilVxWV+8a3a96JzWjI13O3HYHbD/TbNH2vg1Rhw94SQ==
X-Received: by 2002:a1c:4684:: with SMTP id
 t126mr21204104wma.165.1608634657357; 
 Tue, 22 Dec 2020 02:57:37 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id z22sm25892487wml.1.2020.12.22.02.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 02:57:36 -0800 (PST)
Date: Tue, 22 Dec 2020 11:57:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201222105733.4f6oou7lshi35qvc@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
 <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
MIME-Version: 1.0
In-Reply-To: <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
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

T24gVHVlLCBEZWMgMjIsIDIwMjAgYXQgMTA6NDQ6NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMi8yMSDkuIvljYg3OjE0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6MTY6NTRBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjAvMTIvMTgg5LiL5Y2INzozOCwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6NDhBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pj4KPj4+Pj5PbiAyMDIwLzExLzEzIOS4i+WNiDk6NDcsIFN0ZWZh
bm8gR2FyemFyZWxsYSB3cm90ZToKPj4+Pj4+VGhhbmtzIHRvIE1heCB0aGF0IHN0YXJ0ZWQgdGhp
cyB3b3JrIQo+Pj4+Pj5JIHRvb2sgaGlzIHBhdGNoZXMsIGFuZCBleHRlbmRlZCB0aGUgYmxvY2sg
c2ltdWxhdG9yIGEgYml0Lgo+Pj4+Pj4KPj4+Pj4+VGhpcyBzZXJpZXMgbW92ZXMgdGhlIG5ldHdv
cmsgZGV2aWNlIHNpbXVsYXRvciBpbiBhIG5ldyBtb2R1bGUKPj4+Pj4+KHZkcGFfc2ltX25ldCkg
YW5kIGxlYXZlcyB0aGUgZ2VuZXJpYyBmdW5jdGlvbnMgaW4gdGhlIHZkcGFfc2ltIGNvcmUKPj4+
Pj4+bW9kdWxlLCBhbGxvd2luZyB0aGUgcG9zc2liaWxpdHkgdG8gYWRkIG5ldyB2RFBBIGRldmlj
ZSBzaW11bGF0b3JzLgo+Pj4+Pj5UaGVuIHdlIGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBtb2R1
bGUgdG8gc2ltdWxhdGUgYSBibG9jayBkZXZpY2UuCj4+Pj4+Pgo+Pj4+Pj5JJ20gbm90IHN1cmUg
YWJvdXQgcGF0Y2ggMTEgKCJ2cmluZ2g6IGFsbG93IHZyaW5naF9pb3ZfeGZlcigpIHRvIHNraXAK
Pj4+Pj4+Ynl0ZXMgd2hlbiBwdHIgaXMgTlVMTCIpLCBtYXliZSB3ZSBjYW4gYWRkIGEgbmV3IGZ1
bmN0aW9ucyBpbnN0ZWFkIG9mCj4+Pj4+Pm1vZGlmeSB2cmluZ2hfaW92X3hmZXIoKS4KPj4+Pj4+
Cj4+Pj4+PkFzIE1heCByZXBvcnRlZCwgSSdtIGFsc28gc2VlaW5nIGVycm9ycyB3aXRoIHZkcGFf
c2ltX2JsayByZWxhdGVkIHRvCj4+Pj4+PmlvdGxiIGFuZCB2cmluZ2ggd2hlbiB0aGVyZSBpcyBo
aWdoIGxvYWQsIHRoZXNlIGFyZSBzb21lIG9mIHRoZSBlcnJvcgo+Pj4+Pj5tZXNzYWdlcyBJIGNh
biBzZWUgcmFuZG9tbHk6Cj4+Pj4+Pgo+Pj4+Pj7CoCB2cmluZ2g6IEZhaWxlZCB0byBhY2Nlc3Mg
YXZhaWwgaWR4IGF0IDAwMDAwMDAwZThkZWIyY2MKPj4+Pj4+wqAgdnJpbmdoOiBGYWlsZWQgdG8g
cmVhZCBoZWFkOiBpZHggNjI4OSBhZGRyZXNzIDAwMDAwMDAwZTFhZDFkNTAKPj4+Pj4+wqAgdnJp
bmdoOiBGYWlsZWQgdG8gZ2V0IGZsYWdzIGF0IDAwMDAwMDAwNjYzNWQ3YTMKPj4+Pj4+Cj4+Pj4+
PsKgIHZpcnRpb192ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjogLTE0
IAo+Pj4+Pj5vZmZzZXQ6IMKgIDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4+Pj4+wqAgdmlydGlv
X3ZkcGEgdmRwYTA6IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigpIGVycm9yOiAtMTQgCj4+Pj4+Pm9m
ZnNldDogwqAgMHg1OGVlMDAwIGxlbjogMHgzMDAwCj4+Pj4+Pgo+Pj4+Pj5UaGVzZSBlcnJvcnMg
c2hvdWxkIGFsbCBiZSByZWxhdGVkIHRvIHRoZSBmYWN0IHRoYXQgaW90bGJfdHJhbnNsYXRlKCkK
Pj4+Pj4+ZmFpbHMgd2l0aCAtRUlOVkFMLCBzbyBpdCBzZWVtcyB0aGF0IHdlIG1pc3Mgc29tZSBt
YXBwaW5nLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PklzIHRoaXMgb25seSByZXByb2R1Y2libGUgd2hlbiB0
aGVyZSdzIG11bHRpcGxlIGNvLWN1cnJlbnQgCj4+Pj4+YWNjZXNzaW5nIG9mIElPVExCPyBJZiB5
ZXMsIGl0J3MgcHJvYmFibHkgYSBoaW50IHRoYXQgc29tZSAKPj4+Pj5raW5kIG9mIHN5bmNocm9u
aXphdGlvbiBpcyBzdGlsbCBtaXNzZWQgc29tZXdoZXJlLgo+Pj4+Pgo+Pj4+Pkl0IG1pZ2h0IGJl
IHVzZWZ1bCB0byBsb2cgdGhlIGRtYV9tYXAvdW5tcCBpbiBib3RoIHZpcnRpb19yaW5nIAo+Pj4+
PmFuZCB2cmluZ2ggdG8gc2VlIHdobyBpcyBtaXNzaW5nIHRoZSBtYXAuCj4+Pj4+Cj4+Pj4KPj4+
Pkp1c3QgYW4gdXBkYXRlIGFib3V0IHRoZXNlIGlzc3VlcyB3aXRoIHZkcGEtc2ltLWJsay4KPj4+
PkkndmUgYmVlbiBmb2N1c2luZyBhIGxpdHRsZSBiaXQgb24gdGhlc2UgZmFpbHVyZXMgb3ZlciB0
aGUgbGFzdCAKPj4+PmZldyBkYXlzIGFuZCBoYXZlIGZvdW5kIHR3byBpc3N1ZXMgcmVsYXRlZCB0
byB0aGUgSU9UTEIvSU9NTVU6Cj4+Pj4KPj4+PjEuIFNvbWUgcmVxdWVzdHMgY29taW5nIGZyb20g
dGhlIGJsb2NrIGxheWVyIGZpbGxzIHRoZSBTRyBsaXN0IAo+Pj4+d2l0aCBtdWx0aXBsZSBidWZm
ZXJzIHRoYXQgaGFkIHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3MuIFRoaXMgCj4+Pj5oYXBwZW5z
IGZvciBleGFtcGxlIHdoaWxlIHVzaW5nICdta2ZzJywgYXQgc29tZSBwb2ludHMgbXVsdGlwbGUg
Cj4+Pj5zZWN0b3JzIGFyZSB6ZXJvZWQgc28gbXVsdGlwbGUgU0cgZWxlbWVudHMgcG9pbnQgdG8g
dGhlIHNhbWUgCj4+Pj5waHlzaWNhbCBwYWdlIHRoYXQgaXMgemVyb2VkLgo+Pj4+U2luY2Ugd2Ug
YXJlIHVzaW5nIHZob3N0X2lvdGxiX2RlbF9yYW5nZSgpIGluIHRoZSAKPj4+PnZkcGFzaW1fdW5t
YXBfcGFnZSgpLCB0aGlzIHJlbW92ZXMgYWxsIHRoZSBvdmVybGFwcGVkIHJhbmdlcy4gSSAKPj4+
PmZpeGVkIHJlbW92aW5nIGEgc2luZ2xlIG1hcCBpbiB2ZHBhc2ltX3VubWFwX3BhZ2UoKSwgYnV0
IGhhcyBhbiAKPj4+PmFsdGVybmF0aXZlIHdlIGNhbiBpbXBsZW1lbnQgc29tZSBraW5kIG9mIHJl
ZmVyZW5jZSBjb3VudHMuCj4+Pgo+Pj4KPj4+SSB0aGluayB3ZSBuZWVkIHRvIGRvIHdoYXQgaGFy
ZHdhcmUgZG8uIFNvIHVzaW5nIHJlZmNvdW50IGlzIAo+Pj5wcm9iYWJseSBub3QgYSBnb29kIGlk
YS4KPj4KPj5Pa2F5LCBzbyBzaW5jZSB3ZSBhcmUgdXNpbmcgZm9yIHNpbXBsaWNpdHkgYW4gaWRl
bnRpY2FsIG1hcHBpbmcsIHdlIAo+PmFyZSBhc3NpZ25pbmcgdGhlIHNhbWUgZG1hX2FkZHIgdG8g
bXVsdGlwbGUgcGFnZXMuCj4KPgo+SSB0aGluayBJIGdldCB5b3Ugbm93LiBUaGF0J3MgdGhlIHJv
b3QgY2F1c2UgZm9yIHRoZSBmYWlsdXJlLgoKWWVzLCBzb3JyeSwgSSBkaWRuJ3QgZXhwbGFpbiB3
ZWxsIHByZXZpb3VzbHkuCgo+Cj5UaGVuIEkgdGhpbmsgd2UgbmVlZCBhbiBzaW1wbGUgaW92YSBh
bGxvY2F0b3IgZm9yIHZkcGEgc2ltdWxhdG9yLCBhbmQgCj5pdCBtaWdodCBiZSB1c2VmdWwgZm9y
IFZEVVNFIGFzIHdlbGwuCgpPa2F5LCBJJ2xsIHdvcmsgb24gaXQuCklmIHlvdSBoYXZlIGFuIGV4
YW1wbGUgdG8gZm9sbG93IG9yIHNvbWUgcG9pbnRlcnMsIHRoZXkgYXJlIHdlbGNvbWUgOi0pCgpU
aGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
