Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE95C433E1
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE472080C
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UU4Lq2Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE472080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3074487CEE;
	Wed, 26 Aug 2020 11:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oybyo3oGp6Hi; Wed, 26 Aug 2020 11:12:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C72887C11;
	Wed, 26 Aug 2020 11:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8935BC07FF;
	Wed, 26 Aug 2020 11:12:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E084DC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C986585751
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V8szCH8mxT8s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:12:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E88308560E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598440333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lR+U00Oaa72ALhBmgywIm4H6+XPgRieMfQDwiYXJfM0=;
 b=UU4Lq2ZzmqXCeX5AIxPtAcaoejY3a7a9fxeMbFjLCVkzPmwD/jnyIoLi43YfjEKY+BHYnY
 hLVWHyN1fhu34oi1sXuejKeVr/AGQlBim/qRpmcvkcziBQ/y4wvDu4I6EeUlCgmgpov8/B
 Q5sabOQg4ofS9HJMuBf6lSRJhBadY9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-vyKuG4HzPPijLcIkDbyQmg-1; Wed, 26 Aug 2020 07:12:12 -0400
X-MC-Unique: vyKuG4HzPPijLcIkDbyQmg-1
Received: by mail-wr1-f72.google.com with SMTP id 89so398318wrr.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 04:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lR+U00Oaa72ALhBmgywIm4H6+XPgRieMfQDwiYXJfM0=;
 b=qfQZ0Gi9WvQOhjJjZIwu0gTL4qg64Am1lzO7pqEJgKkeIkR6G7ClYcOHW0GHe+o7zz
 1xjm189nUvx0/WEXHg09Czb6OFCww8+ngoC4xO/Q7GPOYUuc1WBmeuDpvX78ZIBReA6C
 kIDKLzB49YQhw4+Ew4OhKGtUkV8YqWc10XWia/pZBvdXoeKPw/xNloqdwfxHvEGG5Xgk
 b2ayqgkUk3TumMSQdefABTSL9RcgjWa7v+fXrUR2pPeVJArZITGh5ggNUWesPOoZuOrB
 1kF0+IzzEZjuSUIGpCYFG2Cyk7lBCosU9FZA5WaPXqUiUvcmxKT8WSknvKDIdcG4FWqz
 owAA==
X-Gm-Message-State: AOAM533/QqpaZGpghGIFRL2B2Ajto4LS5oXngRwpotKOoU4l2V5kxgIh
 3muDA8sA8t+N5487XgIX1ii1/QYBT5Ko7nUoWybSMCCU/7KPMvVP6gXQ7Tpd5LyW7XP5vTcq2SU
 gfujKNibBaiB8nzqDLnsuagVk/f4qRer1aEoDVKPFQg==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr11854989wrr.365.1598440330948; 
 Wed, 26 Aug 2020 04:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0rObmmQMjGOaXLjfOhZSPZT6w5SFheSV59yGDYZ9gFY089eygMzryPx1d3YNhKUDJ9uAvUg==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr11854967wrr.365.1598440330699; 
 Wed, 26 Aug 2020 04:12:10 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id 128sm4844463wmz.43.2020.08.26.04.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:12:09 -0700 (PDT)
Date: Wed, 26 Aug 2020 07:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: ifcvf: return err when fail to request config
 irq
Message-ID: <20200826071200-mutt-send-email-mst@kernel.org>
References: <20200723091254.20617-1-jasowang@redhat.com>
 <87ec5f62-4d99-e7b4-00dc-28664f8eb111@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ec5f62-4d99-e7b4-00dc-28664f8eb111@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, linux-kernel@vger.kernel.org,
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

T24gRnJpLCBBdWcgMDcsIDIwMjAgYXQgMTE6NTI6MDlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzcvMjMg5LiL5Y2INToxMiwgSmFzb24gV2FuZyB3cm90ZToKPiA+IFdl
IGlnbm9yZSB0aGUgZXJyIG9mIHJlcXVlc3RpbmcgY29uZmlnIGludGVycnVwdCwgZml4IHRoaXMu
Cj4gPiAKPiA+IEZpeGVzOiBlNzk5MWYzNzZhNGQgKCJpZmN2ZjogaW1wbGVtZW50IGNvbmZpZyBp
bnRlcnJ1cHQgaW4gSUZDVkYiKQo+ID4gQ2M6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQgKysr
Kwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX21haW4uYwo+ID4gaW5kZXggZjVhNjBjMTRiOTc5Li5hZTcxMTA5NTVhNDQgMTAwNjQ0
Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPiArKysgYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPiBAQCAtNzYsNiArNzYsMTAgQEAgc3RhdGlj
IGludCBpZmN2Zl9yZXF1ZXN0X2lycShzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikKPiA+
ICAgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxLAo+ID4gICAJCQkgICAg
ICAgaWZjdmZfY29uZmlnX2NoYW5nZWQsIDAsCj4gPiAgIAkJCSAgICAgICB2Zi0+Y29uZmlnX21z
aXhfbmFtZSwgdmYpOwo+ID4gKwlpZiAocmV0KSB7Cj4gPiArCQlJRkNWRl9FUlIocGRldiwgIkZh
aWxlZCB0byByZXF1ZXN0IGNvbmZpZyBpcnFcbiIpOwo+ID4gKwkJcmV0dXJuIHJldDsKPiA+ICsJ
fQo+ID4gICAJZm9yIChpID0gMDsgaSA8IElGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDI7IGkrKykg
ewo+ID4gICAJCXNucHJpbnRmKHZmLT52cmluZ1tpXS5tc2l4X25hbWUsIDI1NiwgImlmY3ZmWyVz
XS0lZFxuIiwKPiAKPiAKPiBIaSBNaWNoYWVsOgo+IAo+IEFueSBjb21tZW50cyBvbiB0aGlzIHNl
cmllcz8KPiAKPiBUaGFua3MKPiAKCkFwcGxpZWQsIHRoYW5rcyEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
