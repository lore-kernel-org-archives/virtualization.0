Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3FC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:16:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477BD6108D
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 477BD6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 137D1401E3;
	Thu, 19 Aug 2021 07:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dPMQeTpCnr8L; Thu, 19 Aug 2021 07:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8FFC5400AE;
	Thu, 19 Aug 2021 07:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6447CC0010;
	Thu, 19 Aug 2021 07:16:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 305EEC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C75760BD4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZaOsF5O23qL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:16:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49EE060BF4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629357364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UALzSo2GrJ9j01xCRrcgLejUq52T/7G8b3s1/Jyjb3g=;
 b=N8/qErVXUTeMJQCcEwbNY07Cap7bml9xZbiwsRqBDURhu962bv+FK4S5KtI9foN+lAZewk
 F8c74mdRulpVr8pBHX65BFL52n14wmu3C3etLX9cZ71b8boCe60Y+suDGIjwlZm2fM0CbW
 zAAwWgT0sL6YevRoNh0CewFCpl2u4zI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-IycTf-CzOUSvIcxQ5NUyAQ-1; Thu, 19 Aug 2021 03:16:02 -0400
X-MC-Unique: IycTf-CzOUSvIcxQ5NUyAQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 x7-20020ac259c70000b02903c7883796e9so1627542lfn.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UALzSo2GrJ9j01xCRrcgLejUq52T/7G8b3s1/Jyjb3g=;
 b=WSAGX0SDLsql8V8nLRTIGYLt20eo/4YlXnMJAeEsMageMjpS8SPtb7S3f1eMDWqtqx
 RK6jcvbAnf774uctAWnUIZ9AtglRaY407KH5arp5AuyYEeRvXwdNrxCfZU7UqaFHap4M
 PqZkKvxP5rJTkFP0Wp5pxX7AO2mpV35fBD3PIhK5u3y6woq8GvTe7tpyTO2PpYOlkUpw
 Thlx8UYcrcXZlGpB9f7PLZkmbBZwvp60RY2CBpUM3kxHcJilPg1/uN4obBsuQYzNTRaX
 nJeO7/6dhnsP6MdQNRpsDpZx0rLJs6CU86tO6fZTfSyNSObST0EbTRzT361+ZBesVo9K
 HFVA==
X-Gm-Message-State: AOAM532SVbmhzMkD1GQKoE5LDxqQF0sAlY0Xs7AwMzsetoCWULA+IDvc
 UHoA8OQ3tlIKo0LA2NKs54kn+ueq9QJ/Vxud9qiwCoRlZECrD7MT6LHuEPQfZq01bIz5kBUO579
 o1BrWNtfVUX0h0Xc7/IR2Ikc9PY9TmTkinLzVadwVcKew9J8ErYOoIjRI0g==
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr9462711lfr.312.1629357361348; 
 Thu, 19 Aug 2021 00:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3IoEfD4gxn0Nr+TIGTIxAc4ooYHxWzFw8gFQUry5zBtizmgIUWjSZFiLRaGMqdxMlUDGirI0BKaxr54b0YkA=
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr9462701lfr.312.1629357361197; 
 Thu, 19 Aug 2021 00:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210818095714.3220-1-lingshan.zhu@intel.com>
 <e3ec8ed7-84ac-73cc-0b74-4de1bb6c0030@redhat.com>
 <9e6f6cb0-eaed-9d83-c297-3a89f5cc9efd@intel.com>
In-Reply-To: <9e6f6cb0-eaed-9d83-c297-3a89f5cc9efd@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Aug 2021 15:15:50 +0800
Message-ID: <CACGkMEsjyx9GDwm1tNtRozC4ooN_QFXBGL20yqc029PKVH2L-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] vDPA/ifcvf: enable multiqueue and control vq
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

T24gVGh1LCBBdWcgMTksIDIwMjEgYXQgMjo1MCBQTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA4LzE5LzIwMjEgMTI6MTEgUE0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPgo+ID4g5ZyoIDIwMjEvOC8xOCDkuIvljYg1OjU3LCBaaHUgTGluZ3No
YW4g5YaZ6YGTOgo+ID4+IFRoaXMgc2VyaWVzIGVuYWJsZXMgbXVsdGktcXVldWUgYW5kIGNvbnRy
b2wgdnEgZmVhdHVyZXMKPiA+PiBmb3IgaWZjdmYuCj4gPj4KPiA+PiBUaGVzZSBwYXRjaGVzIGFy
ZSBiYXNlZCBvbiBteSBwcmV2aW91cyB2RFBBL2lmY3ZmIG1hbmFnZW1lbnQgbGluawo+ID4+IGlt
cGxlbWVudGF0aW9uIHNlcmllczoKPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAy
MTA4MTIwMzI0NTQuMjQ0ODYtMi1saW5nc2hhbi56aHVAaW50ZWwuY29tL1QvCj4gPj4KPiA+Pgo+
ID4+IFRoYW5rcyEKPiA+Pgo+ID4+IFpodSBMaW5nc2hhbiAoMik6Cj4gPj4gICAgdkRQQS9pZmN2
ZjogZGV0ZWN0IGFuZCB1c2UgdGhlIG9uYm9hcmQgbnVtYmVyIG9mIHF1ZXVlcyBkaXJlY3RseQo+
ID4+ICAgIHZEUEEvaWZjdmY6IGVuYWJsZSBtdWx0aXF1ZXVlIGFuZCBjb250cm9sIHZxCj4gPj4K
PiA+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfCAgOCArKysrKy0tLQo+ID4+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDE5ICsrKystLS0tLS0tLS0tLS0t
LS0KPiA+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAzMiArKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLQo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspLCAzNSBkZWxldGlvbnMoLSkKPiA+Pgo+ID4KPiA+IFBhdGNoIGxvb2tzIGdvb2QuCj4g
Pgo+ID4gSSB3b25kZXIgdGhlIGNvbXBhdGliaWxpdHkuIEUuZyBkb2VzIGl0IHdvcmsgb24gdGhl
IHFlbXUgbWFzdGVyCj4gPiB3aXRob3V0IGN2cSBzdXBwb3J0PyAobXE9b2ZmIG9yIG5vdCBzcGVj
aWZpZWQpCj4gSGkgSmFzb24sCj4KPiBZZXMsIGl0IHdvcmtzIHdpdGggcWVtdSBtYXN0ZXIuIFdo
ZW4gbm8gY3ZxL21xIHN1cHBvcnQsIG9ubHkgb25lIHF1ZXVlCj4gcGFpciBzaG93bi4KCkdvb2Qg
dG8ga25vdyB0aGlzLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IFpodSBMaW5nc2hhbgo+ID4KPiA+
IFRoYW5rcwo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
