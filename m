Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE54C433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 02:35:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1B861165
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 02:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B1B861165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C9F60BAA;
	Fri,  5 Nov 2021 02:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yt9tTPel3WTJ; Fri,  5 Nov 2021 02:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D90E6086D;
	Fri,  5 Nov 2021 02:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA8D4C0019;
	Fri,  5 Nov 2021 02:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EDC3C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47A6F405BC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6-P9tDy21yA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:35:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 854384059E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636079731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKBsGL0N95B/IgJqo+QGVJ0yA+4yb0e6eNgdYWHMsBE=;
 b=K8RV/dTY8Bo183c3S9N29ZlHezb3H0lwgxXHNs1esGRY3GyXO7tq5LJM9hSiUqEJsbLa7h
 NqrWira8FR8u+HGq3knv54dcKqAuVuMKYp60G4qMMPttxFDvo8W3QptLe1VhrWwOHRQ7Ce
 Aex+/JJwDM88lAzlLGZtS6mEOUsnBrU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-zlK9CbL3P6SCy1CD2TNBeg-1; Thu, 04 Nov 2021 22:35:30 -0400
X-MC-Unique: zlK9CbL3P6SCy1CD2TNBeg-1
Received: by mail-lf1-f69.google.com with SMTP id
 d10-20020a0565123d0a00b004002359a671so2880041lfv.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Nov 2021 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VKBsGL0N95B/IgJqo+QGVJ0yA+4yb0e6eNgdYWHMsBE=;
 b=G4/yViZ1HlWilKMdFRBbIVjPDwA4Z1+2HuQJ6X0VCtW5zbxb48U5uK5GKIMVetNn2m
 joJpP+h8WEY0VLL7ThU3k2J2Qt12Bwqs4e1f8RCCMtI81E6DmnYs8WcHfbqLLdxM7iKG
 e/8U2CfKQ+BDmtJzvB66NseKBycEqd7jcgO+C3evtxvDca4i5f/tcZE4K8nEZ6knoLFW
 yTl/pbjuCYoKAkXx3z6HrBy1Ar7+k+qZjSYVJowgFD9zmsxL51y806P7lEWLQOmoE+Dd
 VidbCCjWQiBvlCFgBwpczsBlrX0J5kKm6OjDQbTe2gI8OxI4V42qobWCMvLmob0NRh/r
 1M9w==
X-Gm-Message-State: AOAM531wQMApqo1Y3iT6/GJ8zrGJ++9QRqTE7WVDwRNRIcHbGhXppTU8
 8X9FeCMr+Vl8r0z3YwtKGiROXcRRpV9oGED2NIX0v5dxdjA6k0bBTJF5bXRa5R1HZwDTn4eUd3V
 P8K0xqCHcirwgY1O4HW82G3q/oRHbDvJejS12LoQLEa7izuUVqyMHrMGEDw==
X-Received: by 2002:a05:6512:3b26:: with SMTP id
 f38mr50855193lfv.629.1636079728605; 
 Thu, 04 Nov 2021 19:35:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZx/L+SiFE1oxYrHCOr1l/Atr1jABgM7xE0CVioPICzfc1cQLBOiIXWL6UFK3ppv8MQuqic1nbF0kue0ka3h8=
X-Received: by 2002:a05:6512:3b26:: with SMTP id
 f38mr50855185lfv.629.1636079728426; 
 Thu, 04 Nov 2021 19:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211104195248.2088904-1-eperezma@redhat.com>
In-Reply-To: <20211104195248.2088904-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Nov 2021 10:35:17 +0800
Message-ID: <CACGkMEvURdieU_i_XOYH-Gab9M_wfT4apXNLpHHF+KGiPNCEVQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Mark vdpa_config_ops.get_vq_notification as optional
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBOb3YgNSwgMjAyMSBhdCAzOjUzIEFNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IFNpbmNlIHZob3N0X3ZkcGFfbW1hcCBjaGVja3MgZm9yIGl0
cyBleGlzdGVuY2UgYmVmb3JlIGNhbGxpbmcgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKPiAtLS0KPiAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRl
eCBjMzAxMWNjZGE0MzAuLjBiZGM3Zjc4NTM5NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3ZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTE1NSw3ICsxNTUsNyBA
QCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7Cj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBAdmRldjogdmRwYSBkZXZpY2UKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBp
ZHg6IHZpcnRxdWV1ZSBpbmRleAo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHN0
YXRlOiBwb2ludGVyIHRvIHJldHVybmVkIHN0YXRlIChsYXN0X2F2YWlsX2lkeCkKPiAtICogQGdl
dF92cV9ub3RpZmljYXRpb246ICAgICAgIEdldCB0aGUgbm90aWZpY2F0aW9uIGFyZWEgZm9yIGEg
dmlydHF1ZXVlCj4gKyAqIEBnZXRfdnFfbm90aWZpY2F0aW9uOiAgICAgICBHZXQgdGhlIG5vdGlm
aWNhdGlvbiBhcmVhIGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpCj4gICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEBpZHg6IHZpcnRxdWV1ZSBpbmRleAo+ICAgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUmV0dXJucyB0aGUgbm90aWZjYXRpb24gYXJlYQo+IC0tCj4gMi4yNy4wCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
