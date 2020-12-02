Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6FAC64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:23:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5D822206
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5D822206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DF1087099;
	Wed,  2 Dec 2020 09:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gAolpR6igj7; Wed,  2 Dec 2020 09:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 11EB287093;
	Wed,  2 Dec 2020 09:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC098C0859;
	Wed,  2 Dec 2020 09:23:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDFD2C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB1C32E214
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T-yKWGh8noJY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1DF782E20F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606901000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aZ1JXSOGr3F029oxNT6iT6cI6Gbdl6ZOd26DcQSOUk=;
 b=fRFbMvaaSotGmxxSSNdm0k1ZfPJtXE4HjKc2mH9IPLvqy/TujujzJxug0t5TcD0TjWL2Ur
 SMTLElLpENtWbgDborUcTeKjKRbhL/nsY+GBprAQCELeHiTWZ1lQUv6Ulh+TY1DQZhQez5
 96CqORy91rSFVvkJjy69d3J2eaOOrgc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-IoYcFYItNKCcQfYbuSN1dg-1; Wed, 02 Dec 2020 04:23:17 -0500
X-MC-Unique: IoYcFYItNKCcQfYbuSN1dg-1
Received: by mail-wm1-f72.google.com with SMTP id y187so2180788wmy.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 01:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0aZ1JXSOGr3F029oxNT6iT6cI6Gbdl6ZOd26DcQSOUk=;
 b=YQilfXOP5iDP4HJzG0s2GHJqhgLl1MQz9LtB4gutWG2PmhrWOnEvR4y6aGmmjOfT4+
 /iENXbC6ehZXidHkUUGlyO835tEpFSh9HDT7QRzwmQtAPCoT/Z7Qxn2i+sWnTIE5o6LV
 axSOge+fQjKy23/ocjR0gX0KGeWXFK9NATZWwPoiKXLzvv9U2wGPzR2qr5VM85QXjf88
 rRFx67RKMUV6xSxNSXxrddXiWkrLyPgrxxa8A66UeC1wlND4zlbcOJqSKU+8LAbn1rBe
 8frrw05I6TcJgohEClm4R7IxCIIjNfMnk05jn9hj3cSnWh/TuU6+4OU9zt6wv003qYgy
 QIaQ==
X-Gm-Message-State: AOAM532nvSt3W1p2inAXWi69x7dljIUeXQWhN2VCfi0bJUzQ4HMeWVuK
 gmk4cctifRLJ9UvP6Ot+hPP1rlSA3U3gn6gvaBnRVMz4F3XSwT0lEYPXmsw/UN4yuvNdVkpZkIU
 mZ5KIZ+A09ZbFdX2/308AlDeBaklIyNB9Du9Lrwtqmw==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2014700wma.17.1606900994474;
 Wed, 02 Dec 2020 01:23:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6uCrYmhNCjCFZsfapUjM6u+S2GgCXjCo2JKYgBy2pqylz4vSLSQTatSD/aa+GZCN2UlNovQ==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2014679wma.17.1606900994190;
 Wed, 02 Dec 2020 01:23:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id 9sm1248512wmo.34.2020.12.02.01.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 01:23:13 -0800 (PST)
Date: Wed, 2 Dec 2020 04:23:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202041518-mutt-send-email-mst@kernel.org>
References: <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDc6NTc6MTRBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgRGVjIDAyLCAyMDIwIGF0IDEyOjE4OjM2UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+IE9uIDIwMjAvMTIvMSDkuIvljYg1OjIzLCBDaW5keSBMdSB3cm90ZToK
PiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MzMgUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQg
MDY6NDE6NDVQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6Cj4gPiA+ID4gPiBPbiBNb24sIE5vdiAz
MCwgMjAyMCBhdCA1OjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMToyNzo1OUFNICswMjAw
LCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQg
MDQ6MDA6NTFBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDg6Mjc6NDZBTSArMDIwMCwgRWxpIENvaGVuIHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAwMzowODoyMlBN
IC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
U3VuLCBOb3YgMjksIDIwMjAgYXQgMDg6NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2Ugc2hvdWxkIG5vdCB0cnkgdG8gdXNlIHRoZSBWRiBNQUMg
YWRkcmVzcyBhcyB0aGF0IGlzIHVzZWQgYnkgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZWd1
bGFyIChlLmcuIG1seDVfY29yZSkgTklDIGltcGxlbWVudGF0aW9uLiBJbnN0ZWFkLCB1c2UgYSBy
YW5kb20KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGdlbmVyYXRlZCBNQUMgYWRkcmVzcy4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU3VnZ2VzdGVkIGJ5OiBDaW5k
eSBMdSA8bHVsdUByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRml4ZXM6IDFhODZi
Mzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBk
ZXZpY2VzIikKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8
ZWxpY0BudmlkaWEuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZGlkbid0IHJlYWxpc2UgaXQn
cyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPiA+ID4gPiA+ID4gPiA+ID4gPiB3aXRo
IGFuZCB3aXRob3V0IHZkcGEuCj4gPiA+ID4gPiA+ID4gPiA+IFVzaW5nIGEgVkYgeW91IGNhbiBj
cmVhdGUgcXVpdGUgYSBmZXcgcmVzb3VyY2VzLCBlLmcuIHNlbmQgcXVldWVzCj4gPiA+ID4gPiA+
ID4gPiA+IHJlY2lldmUgcXVldWVzLCB2aXJ0aW9fbmV0IHF1ZXVlcyBldGMuIFNvIHlvdSBjYW4g
cG9zc2libHkgY3JlYXRlCj4gPiA+ID4gPiA+ID4gPiA+IHNldmVyYWwgaW5zdGFuY2VzIG9mIHZk
cGEgbmV0IGRldmljZXMgYW5kIG5pYyBuZXQgZGV2aWNlcy4KPiA+ID4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ID4gPiA+ID4gQ291bGQgeW91IGluY2x1ZGUgYSBiaXQgbW9yZSBkZXNjcmlwdGlv
biBvbiB0aGUgZmFpbHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+IG1vZGU/Cj4gPiA+ID4gPiA+ID4g
PiA+IFdlbGwsIHVzaW5nIHRoZSBNQUMgYWRkcmVzcyBvZiB0aGUgbmljIHZwb3J0IGlzIHdyb25n
IHNpbmNlIHRoYXQgaXMgdGhlCj4gPiA+ID4gPiA+ID4gPiA+IE1BQyBvZiB0aGUgcmVndWxhciBO
SUMgaW1wbGVtZW50YXRpb24gb2YgbWx4NV9jb3JlLgo+ID4gPiA+ID4gPiA+ID4gUmlnaHQgYnV0
IEFUTSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUgcHJvYmxlbT8K
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFRoaXMgY2FsbCBpcyB3cm9uZzogIG1seDVf
cXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gPiBJcyBzd2l0Y2hpbmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNoIGFuIHVudXN1YWwK
PiA+ID4gPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9uIHJlYWxseSBqdXN0aWZpZWQ/Cj4gPiA+
ID4gPiA+ID4gPiA+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMncyBNQUMgYWRkcmVzcywgSSBo
YXZlIHR3byBvcHRpb25zOgo+ID4gPiA+ID4gPiA+ID4gPiAxLiBUbyBnZXQgdGhlIE1BQyBhZGRy
ZXNzIGFzIHdhcyBjaG9zZW4gYnkgdGhlIHVzZXIgYWRtaW5pc3RlcmluZyB0aGUKPiA+ID4gPiA+
ID4gPiA+ID4gICAgIE5JQy4gVGhpcyBzaG91bGQgaW52b2tlIHRoZSBzZXRfY29uZmlnIGNhbGxi
YWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gICAgIGlzIG5vdCBpbXBs
ZW1lbnRlZCB5ZXQuCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiAyLiBVc2Ug
YSByYW5kb20gTUFDIGFkZHJlc3MuIFRoaXMgaXMgT0sgc2luY2UgaWYgKDEpIGlzIGltcGxlbWVu
dGVkIGl0Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFu
ZG9tIGNvbmZpZ3VyYXRpb24uCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+
IEl0IGxvb2tzIGxpa2UgY2hhbmdpbmcgYSBNQUMgY291bGQgYnJlYWsgc29tZSBndWVzdHMsCj4g
PiA+ID4gPiA+ID4gPiA+ID4gY2FuIGl0IG5vdD8KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ID4gTm8sIGl0IHdpbGwgbm90LiBUaGUgY3VycmVudCB2ZXJzaW9uIG9mIG1seDUg
VkRQQSBkb2VzIG5vdCBhbGxvdyByZWd1bGFyCj4gPiA+ID4gPiA+ID4gPiA+IE5JQyBkcml2ZXIg
YW5kIFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRjaGVzIHJlYWR5IHRoYXQgZW5hYmxlIHRo
YXQKPiA+ID4gPiA+ID4gPiA+ID4gZnJvbSBzdGVlcmluZyBwb2ludCBvZiB2aWV3LiBJIHdpbGwg
cG9zdCB0aGVtIGhlcmUgb25jZSBvdGhlciBwYXRjaGVzIG9uCj4gPiA+ID4gPiA+ID4gPiA+IHdo
aWNoIHRoZXkgZGVwZW5kIHdpbGwgYmUgbWVyZ2VkLgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9w
YXRjaC8yMDIwMTEyMDIzMDMzOS42NTE2MDktMTItc2FlZWRtQG52aWRpYS5jb20vCj4gPiA+ID4g
PiA+ID4gPiBDb3VsZCB5b3UgYmUgbW9yZSBleHBsaWNpdCBvbiB0aGUgZm9sbG93aW5nIHBvaW50
czoKPiA+ID4gPiA+ID4gPiA+IC0gd2hpY2ggY29uZmlndXJhdGlvbiBpcyBicm9rZW4gQVRNIChh
cyBpbiwgdHdvIGRldmljZSBoYXZlIGlkZW50aWNhbAo+ID4gPiA+ID4gPiA+ID4gICAgbWFjcz8g
YW55IG90aGVyIGlzc3Vlcyk/Cj4gPiA+ID4gPiA+ID4gVGhlIG9ubHkgd3JvbmcgdGhpbmcgaXMg
dGhlIGNhbGwgdG8gIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkuCj4gPiA+ID4g
PiA+ID4gSXQncyBub3QgYnJlYWtpbmcgYW55dGhpbmcgeWV0IGlzIHdyb25nLiBUaGUgcmFuZG9t
IE1BQyBhZGRyZXNzIHNldHRpbmcKPiA+ID4gPiA+ID4gPiBpcyByZXF1aXJlZCBmb3IgdGhlIHN0
ZWVyaW5nIHBhdGNoZXMuCj4gPiA+ID4gPiA+IE9rYXkgc28gSSdtIG5vdCBzdXJlIHRoZSBGaXhl
cyB0YWcgYXQgbGVhc3QgaXMgYXBwcm9wcmlhdGUgaWYgaXQncyBhCj4gPiA+ID4gPiA+IGRlcGVu
ZGVuY3kgb2YgYSBuZXcgZmVhdHVyZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiAtIHdo
eSB3b24ndCBkZXZpY2UgTUFDIGNoYW5nZSBmcm9tIGd1ZXN0IHBvaW50IG9mIHZpZXc/Cj4gPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBJdCdzIGxhY2sgb2YgaW1wbGVtZW50YXRpb24gaW4g
cWVtdSBhcyBmYXIgYXMgSSBrbm93Lgo+ID4gPiA+ID4gPiBTb3JyeSBub3Qgc3VyZSBJIHVuZGVy
c3RhbmQuIFdoYXQncyBub3QgaW1wbGVtZW50ZWQgaW4gUUVNVT8KPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiBISSBNaWNoYWVsLCB0aGVyZSBhcmUgc29tZSBidWcgaW4gcWVtdSB0byBzZXRfY29uZmln
LCB0aGlzIHdpbGwgZml4IGluIGZ1dHVyZSwKPiA+ID4gPiA+IEJ1dCB0aGlzIHBhdGNoIGlzIHN0
aWxsIG5lZWRlZCwgYmVjYXVzZSB3aXRob3V0IHRoaXMgcGF0Y2ggdGhlIG1seAo+ID4gPiA+ID4g
ZHJpdmVyIHdpbGwgZ2l2ZSBhbiAwIG1hYyBhZGRyZXNzIHRvIHFlbXUKPiA+ID4gPiA+IGFuZCBx
ZW11IHdpbGwgb3ZlcndyaXRlIHRoZSBkZWZhdWx0IG1hYyBhZGRyZXNzLiAgVGhpcyB3aWxsIGNh
dXNlIHRyYWZmaWMgZG93bi4KPiA+ID4gPiBIbW0gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHNheXMg
VkYgbWFjIGFkZHJlc3MsIG5vdCAwIGFkZHJlc3MuIENvbmZ1c2VkLgo+ID4gPiA+IElmIHRoZXJl
J3Mgbm8gbWFjIHdlIGNhbiBjbGVhciBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBoYXZlIGd1ZXN0Cj4g
PiA+ID4gdXNlIGEgcmFuZG9tIHZhbHVlIC4uLgo+ID4gCj4gPiAKPiA+IEknbSBub3Qgc3VyZSB0
aGlzIGNhbiB3b3JrIGZvciBhbGwgdHlwZXMgb2YgdkRQQSAoZS5nIGl0IGNvdWxkIG5vdCBiZSBh
Cj4gPiBsZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3dGljaCkuCj4gPiAKPiA+IAo+ID4gPiA+IAo+
ID4gPiBoaSBNaWNoYWVs77yMCj4gPiA+IEkgaGF2ZSB0cmllZCBhcyB5b3VyIHN1Z2dlc3Rpb24s
IHNlZW1zIGV2ZW4gcmVtb3ZlIHRoZQo+ID4gPiBWSVJUSU9fTkVUX0ZfTUFDIHRoZSBxZW11IHdp
bGwgc3RpbGwgY2FsbCBnZXRfY2luZmlnIGFuZCBvdmVyd3JpdGUgdGhlCj4gPiA+IGRlZmF1bHQg
YWRkcmVzcyBpbiAgVk0sCj4gPiAKPiA+IAo+ID4gVGhpcyBsb29rcyBhIGJ1ZyBpbiBxZW11LCBp
biBndWVzdCBkcml2ZXIgd2UgaGFkOgo+ID4gCj4gPiDCoMKgwqAgLyogQ29uZmlndXJhdGlvbiBt
YXkgc3BlY2lmeSB3aGF0IE1BQyB0byB1c2UuwqAgT3RoZXJ3aXNlIHJhbmRvbS4gKi8KPiA+IMKg
wqDCoCBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NQUMpKQo+ID4g
wqDCoMKgIMKgwqDCoCB2aXJ0aW9fY3JlYWRfYnl0ZXModmRldiwKPiA+IMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbWFj
KSwKPiA+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIGRldi0+ZGV2X2FkZHIsIGRl
di0+YWRkcl9sZW4pOwo+ID4gwqDCoMKgIGVsc2UKPiA+IMKgwqDCoCDCoMKgwqAgZXRoX2h3X2Fk
ZHJfcmFuZG9tKGRldik7Cj4gPiAKPiA+IAo+ID4gPiB0aGlzIHByb2Nlc3MgaXMgbGlrZQo+ID4g
PiB2ZHBhIF9pbml0IC0tPnFlbXUgY2FsbCBnZXRfY29uZmlnIC0+bWx4IGRyaXZlciB3aWxsIGdp
dmUgIGFuIG1hYwo+ID4gPiBhZGRyZXNzIHdpdGggYWxsIDAtLT4KPiA+ID4gcWVtdSB3aWxsIG5v
dCBjaGVjayB0aGlzIG1hYyBhZGRyZXNzIGFuZCB1c2UgaXQgLS0+IG92ZXJ3cml0ZSB0aGUgbWFj
Cj4gPiA+IGFkZHJlc3MgaW4gcWVtdQo+ID4gPiAKPiA+ID4gU28gZm9yIG15IHVuZGVyc3RhbmRp
bmcgdGhlcmUgYXJlIHNldmVyYWwgbWV0aG9kIHRvIGZpeCB0aGlzIHByb2JsZW0KPiA+ID4gCj4g
PiA+IDEsIHFlbXUgY2hlY2sgdGhlIG1hYyBhZGRyZXNzLCBpZiB0aGUgbWFjIGFkZHJlc3MgaXMg
YWxsIDAsIHFlbXUgd2lsbAo+ID4gPiBpZ25vcmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBh
ZGRyZXNzIHRvIG1seCBkcml2ZXIuCj4gPiAKPiA+IAo+ID4gU28gbXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0LCBpZiBtYWMgYWRkcmVzcyBpcyBhbGwgMCwgdkRQQSBwYXJlbnQgc2hvdWxkIG5vdAo+
ID4gYWR2ZXJ0aXNlIFZJUlRJT19ORVRfRl9NQUMuIEFuZCBxZW11IHNob3VsZCBlbXVsYXRlIHRo
aXMgZmVhdHVyZSBhcyB5b3UgZGlkOgo+IAo+IFRoaW5raW5nIGl0IG92ZXIsIGF0IGxlYXN0IGlu
IG1seDUsIEkgc2hvdWxkIGFsd2F5cyBhZHZlcnRpc2UKPiBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBz
ZXQgYSBub24gemVybyBNQUMgdmFsdWUuIFRoZSBzb3VyY2Ugb2YgdGhlIE1BQyBjYW4KPiBiZSBl
aXRoZXIgcmFuZG9tbHkgZ2VuZXJhdGVkIHZhbHVlIGJ5IG1seDVfdmRwYSBvciBieSBhIG1hbmFn
ZW1lbnQgdG9vbC4KPiBUaGlzIGlzIGltcG9ydGFudCBiZWNhdWFzZSB3ZSBzaG91bGQgbm90IGxl
dCB0aGUgVk0gbW9kaWZ5IHRoZSBNQUMuIElmCj4gd2UgZG8gaXQgY2FuIHNldCBhIE1BQyB2YWx1
ZSBpZGVudGljYWwgdG8gdGhlIG1seDUgTklDIGRyaXZlciBhbmQgY2FuCj4ga2lkbmFwIHRyYWZm
aWMgdGhhdCB3YXMgbm90IGRlc3RpbmVkIHRvIGl0Lgo+IAo+IEluIGFkZGl0aW9uLCB3aGVuIFZJ
UlRJT19ORVRfRl9NQUMgaXMgcHVibGlzaGVkLCBhdHRlbXB0cyB0byBjaGFuZ2UgdGhlCj4gTUFD
IGFkZHJlc3MgZnJvbSB0aGUgVk0gc2hvdWxkIHJlc3VsdCBpbiBlcnJvci4KClRoYXQgaXMgbm90
IHdoYXQgdGhlIHNwZWMgc2F5cyB0aG91Z2guClZJUlRJT19ORVRfRl9NQUMgb25seSBzYXlzIHdo
ZXRoZXIgbWFjIGlzIHZhbGlkIGluIHRoZSBjb25maWcgc3BhY2UuCldoZXRoZXIgZ3Vlc3QgY2Fu
IGNvbnRyb2wgdGhhdCBkZXBlbmRzIG9uIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSOgoKCVRo
ZSBWSVJUSU9fTkVUX0NUUkxfTUFDX0FERFJfU0VUIGNvbW1hbmQgaXMgdXNlZCB0byBzZXQgdGhl
IGRlZmF1bHQgTUFDIGFkZHJlc3Mgd2hpY2ggcngKCWZpbHRlcmluZyBhY2NlcHRzIChhbmQgaWYg
VklSVElPX05FVF9GX01BQ19BRERSIGhhcyBiZWVuIG5lZ290aWF0ZWQsIHRoaXMgd2lsbCBiZSBy
ZWZsZWN0ZWQgaW4gbWFjIGluCgljb25maWcgc3BhY2UpLgoJVGhlIGNvbW1hbmQtc3BlY2lmaWMt
ZGF0YSBmb3IgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBpcyB0aGUgNi1ieXRlIE1BQyBh
ZGRyZXNzLgoKCgoKPiAKPiA+IAo+ID4gMSkgZ2V0IGEgcmFuZG9tIG1hYwo+ID4gMikgYWR2ZXJ0
aXNlIFZJUlRJT19ORVRfRl9NQUMKPiA+IDMpIHNldCB0aGUgcmFuZG9tIG1hYyB0byB2RFBBIHRo
cm91Z2ggc2V0X2NvbmZpZwo+ID4gNCkgYWR2ZXJ0aXNlIHRoZSByYW5kb20gbWFjIHRvIGVtdWxh
dGVkIGNvbmZpZyB0byBndWVzdAo+ID4gCj4gPiAKPiA+ID4gMi4gbWx4IGRyaXZlciBjaGVja3Mg
dGhlIG1hYyBhZGRyZXNzIGFuZCBpZiB0aGlzIG1hYyBpcyAwLCByZXR1cm4gZmFpbAo+ID4gPiB0
byBxZW11LCBidXQgdGhpcyBuZWVkIHRvIGNoYW5nZSB0aGUgVUFQSS4KPiA+IAo+ID4gCj4gPiB1
QVBJIGlzIHByb2JhYmx5IGZpbmUgc2luY2UgaW9jdGwgY2FuIGZhaWwuwqAgV2UgY2FuIGNoYW5n
ZSB0aGUgdG8gYWxsb3cgdGhlCj4gPiBzZXRfY29uZmlnIHRvIGZhaWwgYnV0IHZpcml0byBzcGVj
IGRvZXNuJ3QgaGF2ZSBhIHdheSB0byBhZHZlcnRpc2UgdGhlIGVycm9yCj4gPiBpbiB0aGlzIGNh
c2UuIEFueXdheSwgdGhlIGRyaXZlciBvbmx5IHJpc2sgaXRzZWxmIGZvciBzZXR0aW5nIGEgd3Jv
bmcgdmFsdWUsCj4gPiBzbyB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+ID4gCj4gPiBUaGFua3MKPiA+
IAo+ID4gCj4gPiA+IDMuIG1seCBkcml2ZXIgaXQgc2hlbGYgc2hvdWxkIGdldCBhbiBjb3JyZWN0
IG1hYyBhZGRyZXNzIHdoaWxlIGl0IGluaXQuCj4gPiA+IDQuIGFkZCBjaGVjayBpbiBxZW11IGdl
dF9jb25maWcgZnVuY3Rpb24gICwgaWYgdGhlcmUgaXMgbm90IEZfTUFDIFRoZW4KPiA+ID4gaWdu
b3JlIHRoZSBtYWMgYWRkcmVzcyBmcm9tIG1seCBkcml2ZXIKPiA+ID4gCj4gPiA+IG5vdCBzdXJl
IHdoaWNoIG1ldGhvZCBpcyBtb3JlIHN1aXRhYmxlID8KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4g
PiBDaW5keQo+ID4gPiAKPiA+ID4gCj4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8
IDUgKy0tLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCA0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBpbmRleCAxZmE2ZmNhYzgyOTkuLjgwZDA2ZDk1OGI4YiAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTk1NSwxMCArMTk1NSw3IEBAIHZvaWQgKm1seDVfdmRwYV9h
ZGRfZGV2KHN0cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgIGlmIChlcnIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICBnb3Rv
IGVycl9tdHU7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0g
ICAgIGVyciA9IG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKG1kZXYsIDAsIDAsIGNv
bmZpZy0+bWFjKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAgIGlmIChlcnIpCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgIGdvdG8gZXJyX210dTsKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIGV0aF9yYW5kb21fYWRkcihjb25m
aWctPm1hYyk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgbXZkZXYtPnZkZXYuZG1hX2Rl
diA9IG1kZXYtPmRldmljZTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICBlcnIgPSBtbHg1
X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICAgaWYgKGVycikKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAyLjI2LjIKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
