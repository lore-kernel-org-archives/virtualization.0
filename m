Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809CC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 11:05:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD7064E96
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD7064E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58AE586F3F;
	Mon,  1 Feb 2021 11:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NhzCMIXJbHv; Mon,  1 Feb 2021 11:05:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E13C86D85;
	Mon,  1 Feb 2021 11:05:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17121C0174;
	Mon,  1 Feb 2021 11:05:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A61C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 01B3486DDC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cp7fNmJbZ-RS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F392686D85
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612177530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6CC4m3ZKiHoeJ4vm73j2nwZCcKHfss+LOR/CL/RX4k=;
 b=RyI/Evw3BHDfX3TvY+7vSUT6CxLJq9NBOsBqMhdo/x08ZVazx5/MqvP27qL5q5piHgh5VM
 0/tc9trA9QA90WKuRViC0jzmMCOBWefUPVE0eqFA0y/gV1yaFARm/kDehwiaCiyrg22hdd
 eA1hh8K75rqEk5fZK9FULJoIKe830NA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-2Wi7BbTDMAe-aANEha9a-g-1; Mon, 01 Feb 2021 06:05:26 -0500
X-MC-Unique: 2Wi7BbTDMAe-aANEha9a-g-1
Received: by mail-wm1-f70.google.com with SMTP id t13so4653248wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 03:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Y6CC4m3ZKiHoeJ4vm73j2nwZCcKHfss+LOR/CL/RX4k=;
 b=KqURWOIQaKAT66bPVArm4XRwKKtaoDHhgHkSCUbDuL4Fz9sc1JBKCW6vIfChg3KnEz
 dcjmavun9ATsJzmBl6PyBVFwE/JS49GnkU5hUgtjHiUzUUErldyBO9EMBENd5N4O8nm2
 yirvEN9bhWcsOC4gdAJ8W2h7c97U6S1bwX35QY9niw0ksGeu9VTlucPqALT3prhnSgp4
 BtNM6FQGHP7ntB+LtokZM4Rpr8H6wedi84oLMjCZ+VGb434NvrILGkK/Zy8+d3ABtuPb
 IQlZVwSlyDwCv/5ZpXNPMjzyiCT/8Tc4RH7ca9Q0zXnoA95OYQp6ZUnyUuMlFq8LAMgO
 W2kw==
X-Gm-Message-State: AOAM5306L9R7KlfgE60rRmQa7okRdxyZGrnmhPnHU+vIB97U8pJSN+0v
 Dnac81IUVtQZCvsv6eYQuD0jUjKt+slx6hOU5pA3Zr0iueFL40O9Q0tQrzmaGsQjLApwk9D0RPT
 GvzyXlFfKU+e7qXICk7LrlaY2ResqRi0qSeNjAQrCGQ==
X-Received: by 2002:a05:6000:1841:: with SMTP id
 c1mr17214343wri.278.1612177525192; 
 Mon, 01 Feb 2021 03:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMK79Mkew2h7U0GFOcmTtXkC8lH41EmCO+/jdmYzyRwl+sN2j7/Tb0HGWZdqr6tf0uwtKU+w==
X-Received: by 2002:a05:6000:1841:: with SMTP id
 c1mr17214306wri.278.1612177524950; 
 Mon, 01 Feb 2021 03:05:24 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s23sm20251966wmc.35.2021.02.01.03.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 03:05:23 -0800 (PST)
Date: Mon, 1 Feb 2021 12:05:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210201110521.o3m6temcw3nmkiea@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
 <20210127085728.j6x5yzrldp2wp55c@steredhat>
 <3cb239f5-fdd5-8311-35a0-c0f50b552521@redhat.com>
 <20210129150359.caitcskrfhqed73z@steredhat>
 <CACycT3sTx+NGg1iB8gmFbOPfzCvnq5F0nd2ePGs2_BUeU=-2_Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sTx+NGg1iB8gmFbOPfzCvnq5F0nd2ePGs2_BUeU=-2_Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-aio@kvack.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

T24gU2F0LCBKYW4gMzAsIDIwMjEgYXQgMDc6MzM6MDhQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPk9uIEZyaSwgSmFuIDI5LCAyMDIxIGF0IDExOjA0IFBNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0
IDExOjExOjQ5QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+ID4KPj4gPk9uIDIwMjEvMS8y
NyDkuIvljYg0OjU3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+ID4+T24gV2VkLCBKYW4g
MjcsIDIwMjEgYXQgMTE6MzM6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gPj4+Cj4+
ID4+Pk9uIDIwMjEvMS8yMCDkuIvljYg3OjA4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+
ID4+Pj5PbiBXZWQsIEphbiAyMCwgMjAyMSBhdCAxMTo0NjozOEFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+PiA+Pj4+Pgo+PiA+Pj4+Pk9uIDIwMjEvMS8xOSDkuIvljYgxMjo1OSwgWGllIFlv
bmdqaSB3cm90ZToKPj4gPj4+Pj4+V2l0aCBWRFVTRSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gc3Vw
cG9ydCBhbGwga2luZHMgb2YgdmlydGlvIGRldmljZXMuCj4+ID4+Pj4+Pgo+PiA+Pj4+Pj5TaWdu
ZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPj4gPj4+Pj4+
LS0tCj4+ID4+Pj4+PiBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDI5ICsrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCj4+ID4+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAy
NiBkZWxldGlvbnMoLSkKPj4gPj4+Pj4+Cj4+ID4+Pj4+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+ID4+Pj4+PmluZGV4IDI5ZWQ0MTcz
ZjA0ZS4uNDQ4YmU3ODc1YjZkIDEwMDY0NAo+PiA+Pj4+Pj4tLS0gYS9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+PiA+Pj4+Pj4rKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiA+Pj4+Pj5AQCAtMjIs
NiArMjIsNyBAQAo+PiA+Pj4+Pj4gI2luY2x1ZGUgPGxpbnV4L25vc3BlYy5oPgo+PiA+Pj4+Pj4g
I2luY2x1ZGUgPGxpbnV4L3Zob3N0Lmg+Cj4+ID4+Pj4+PiAjaW5jbHVkZSA8bGludXgvdmlydGlv
X25ldC5oPgo+PiA+Pj4+Pj4rI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19ibGsuaD4KPj4gPj4+Pj4+
ICNpbmNsdWRlICJ2aG9zdC5oIgo+PiA+Pj4+Pj5AQCAtMTg1LDI2ICsxODYsNiBAQCBzdGF0aWMg
bG9uZwo+PiA+Pj4+Pj52aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEgKnYs
IHU4IF9fdXNlcgo+PiA+Pj4+Pj4qc3RhdHVzcCkKPj4gPj4+Pj4+ICAgICByZXR1cm4gMDsKPj4g
Pj4+Pj4+IH0KPj4gPj4+Pj4+LXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ID4+Pj4+Pi0gICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZob3N0X3ZkcGFfY29uZmlnICpjKQo+PiA+Pj4+Pj4tewo+PiA+Pj4+Pj4tICAgIGxvbmcg
c2l6ZSA9IDA7Cj4+ID4+Pj4+Pi0KPj4gPj4+Pj4+LSAgICBzd2l0Y2ggKHYtPnZpcnRpb19pZCkg
ewo+PiA+Pj4+Pj4tICAgIGNhc2UgVklSVElPX0lEX05FVDoKPj4gPj4+Pj4+LSAgICAgICAgc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwo+PiA+Pj4+Pj4tICAgICAgICBi
cmVhazsKPj4gPj4+Pj4+LSAgICB9Cj4+ID4+Pj4+Pi0KPj4gPj4+Pj4+LSAgICBpZiAoYy0+bGVu
ID09IDApCj4+ID4+Pj4+Pi0gICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiA+Pj4+Pj4tCj4+ID4+
Pj4+Pi0gICAgaWYgKGMtPmxlbiA+IHNpemUgLSBjLT5vZmYpCj4+ID4+Pj4+Pi0gICAgICAgIHJl
dHVybiAtRTJCSUc7Cj4+ID4+Pj4+Pi0KPj4gPj4+Pj4+LSAgICByZXR1cm4gMDsKPj4gPj4+Pj4+
LX0KPj4gPj4+Pj4KPj4gPj4+Pj4KPj4gPj4+Pj5JIHRoaW5rIHdlIHNob3VsZCB1c2UgYSBzZXBh
cmF0ZSBwYXRjaCBmb3IgdGhpcy4KPj4gPj4+Pgo+PiA+Pj4+Rm9yIHRoZSB2ZHBhLWJsayBzaW11
bGF0b3IgSSBoYWQgdGhlIHNhbWUgaXNzdWVzIGFuZCBJJ20gYWRkaW5nCj4+ID4+Pj5hIC5nZXRf
Y29uZmlnX3NpemUoKSBjYWxsYmFjayB0byB2ZHBhIGRldmljZXMuCj4+ID4+Pj4KPj4gPj4+PkRv
IHlvdSB0aGluayBtYWtlIHNlbnNlIG9yIGlzIGJldHRlciB0byByZW1vdmUgdGhpcyBjaGVjayBp
bgo+PiA+Pj4+dmhvc3QvdmRwYSwgZGVsZWdhdGluZyB0aGUgYm91bmRhcmllcyBjaGVja3MgdG8K
Pj4gPj4+PmdldF9jb25maWcvc2V0X2NvbmZpZyBjYWxsYmFja3MuCj4+ID4+Pgo+PiA+Pj4KPj4g
Pj4+QSBxdWVzdGlvbiBoZXJlLiBIb3cgbXVjaCB2YWx1ZSBjb3VsZCB3ZSBnYWluIGZyb20KPj4g
Pj4+Z2V0X2NvbmZpZ19zaXplKCkgY29uc2lkZXIgd2UgY2FuIGxldCB2RFBBIHBhcmVudCB0byB2
YWxpZGF0ZSB0aGUKPj4gPj4+bGVuZ3RoIGluIGl0cyBnZXRfY29uZmlnKCkuCj4+ID4+Pgo+PiA+
Pgo+PiA+PkkgYWdyZWUsIG1vc3Qgb2YgdGhlIGltcGxlbWVudGF0aW9ucyBhbHJlYWR5IHZhbGlk
YXRlIHRoZSBsZW5ndGgsCj4+ID4+dGhlIG9ubHkgZ2FpbiBpcyBhbiBlcnJvciByZXR1cm5lZCBz
aW5jZSBnZXRfY29uZmlnKCkgaXMgdm9pZCwgYnV0Cj4+ID4+ZXZlbnR1YWxseSB3ZSBjYW4gYWRk
IGEgcmV0dXJuIHZhbHVlIHRvIGl0Lgo+PiA+Cj4+ID4KPj4gPlJpZ2h0LCBvbmUgcHJvYmxlbSBo
ZXJlIGlzIHRoYXQuIEZvciB0aGUgdmlyaXRvIHBhdGgsIGl0cyBnZXRfY29uZmlnKCkKPj4gPnJl
dHVybnMgdm9pZC4gU28gd2UgY2FuIG5vdCBwcm9wYWdhdGUgZXJyb3IgdG8gdmlydGlvIGRyaXZl
cnMuIEJ1dCBpdAo+PiA+bWlnaHQgbm90IGJlIGEgYmlnIGlzc3VlIHNpbmNlIHdlIHRydXN0IGtl
cm5lbCB2aXJ0aW8gZHJpdmVyLgo+PiA+Cj4+ID5TbyBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRv
IGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlIGluIHRoZSB2ZHBhIGNvbmZpZyBvcHMuCj4+Cj4+IFRo
YW5rcyBmb3IgeW91ciBmZWVkYmFjayEKPj4KPj4gQFhpZSBkbyB5b3UgcGxhbiB0byBkbyB0aGlz
Pwo+Pgo+PiBPdGhlcndpc2UgSSBjYW4gZG8gaW4gbXkgdmRwYS1ibGstc2ltIHNlcmllcywgd2hl
cmUgZm9yIG5vdyBJIHVzZWQgdGhpcwo+PiBwYXRjaCBhcyBpcy4KPj4KPgo+SGkgU3RlZmFubywg
cGxlYXNlIGRvIGluIHlvdXIgdmRwYS1ibGstc2ltIHNlcmllcy4gSSBoYXZlIG5vIHBsYW4gZm9y
IAo+aXQgbm93LgoKT2theSwgSSdsbCBkbyBpdC4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
