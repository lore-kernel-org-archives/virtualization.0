Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BAC64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:17:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5D72084C
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csSIqQPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5D72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 50C442288F;
	Mon, 30 Nov 2020 14:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tracRevM0EV; Mon, 30 Nov 2020 14:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7CB7822882;
	Mon, 30 Nov 2020 14:17:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F997C163C;
	Mon, 30 Nov 2020 14:17:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 641C4C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 50F092288F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uTAQXGAyFQnw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:17:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3ED0222882
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606745862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9prsWoGXCRXLL1OI4BrWzM/wk3x2f0Z7sUXp0RoUalg=;
 b=csSIqQPwal7NoSZjj1YXMoQg5vE+1oxRC5jEjNYSVsexQv7TuRQsk4IB5LSi1NwlSjE22h
 s7J5LdggBgLuHXqqMT312utqnIYlyyez3pIL/5BUmp+lmwRxCQxIPJKD1o+4aDqRWO2ocB
 zCBZpedQAWtLHiFwa6XXoPZ9ix8fv24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-p6eWYiF7MyKMNofHPXDPfw-1; Mon, 30 Nov 2020 09:17:31 -0500
X-MC-Unique: p6eWYiF7MyKMNofHPXDPfw-1
Received: by mail-wm1-f69.google.com with SMTP id q1so4457569wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 06:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9prsWoGXCRXLL1OI4BrWzM/wk3x2f0Z7sUXp0RoUalg=;
 b=aS1G508KfdFse/J4e257ulvGVhahsY351THVEVl7Oo1H+xxHNm14NyDofgj89q2Zsy
 /dLqVxjF0mTwvq1p31wMB2qd1Jmg6jLM7TOORlYW8f8XVCPZXUF9E37bDpFN4gHFbHc9
 MUvwyowyw1/VH34CbKGRwqWIumn09BfCtnEVWpROgA97xp/S9ZP1TdoyeeV9r9raqa3/
 T7muHMAt0W7nMAg713KQ+AOp8FIfCtdI91jE51Sdh7DwJ1DPlWFVVk43MluZYRvQMYuY
 c+PikD3J05WUrn/Ru3v3nPwF0q6+TGHOXMpW6QAtcFki3GcT0nW/zF3zTuO+4ZvSLqm4
 lRng==
X-Gm-Message-State: AOAM5313CnYs0LEKHni6Bw3maydUw6sk+Bk0hO/N0kj7xea2yI0IGNZQ
 zPYy9igq62AkCK0K6PmquBS8ZScQ/QDbXPQ25iN1d3luwt0RD0XmlsslnGgZrtRHewnH+x7WO3E
 qhX/WOU6s1vc4ejyrX6j0E98WLBkNo/ri4XxIqYh4AA==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr8353725wmj.16.1606745850164; 
 Mon, 30 Nov 2020 06:17:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytEilOYibEaRt1OubviG1B2ypJ06x22ayeguT4QXkdSoR5ocTTJpdRPmZfnCl2gZgvNpyKSA==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr8353700wmj.16.1606745849962; 
 Mon, 30 Nov 2020 06:17:29 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id x10sm21703399wro.0.2020.11.30.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 06:17:29 -0800 (PST)
Date: Mon, 30 Nov 2020 15:17:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 17/17] vdpa: split vdpasim to core and net modules
Message-ID: <20201130141726.wm732gw4khvbgm34@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-18-sgarzare@redhat.com>
 <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
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

T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MzE6NDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8yNiDkuIvljYgxMDo0OSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+PkZyb206IE1heCBHdXJ0b3ZveTxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPj4KPj5JbnRyb2R1
Y2UgbmV3IHZkcGFfc2ltX25ldCBhbmQgdmRwYV9zaW0gKGNvcmUpIGRyaXZlcnMuIFRoaXMgaXMg
YQo+PnByZXBhcmF0aW9uIGZvciBhZGRpbmcgYSB2ZHBhIHNpbXVsYXRvciBtb2R1bGUgZm9yIGJs
b2NrIGRldmljZXMuCj4+Cj4+U2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95PG1ndXJ0b3ZveUBu
dmlkaWEuY29tPgo+PltzZ2FyemFyZTogdmFyaW91cyBjbGVhbnVwcy9maXhlc10KPj5TaWduZWQt
b2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGE8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0KPj52
MjoKPj4tIEZpeGVkICJ3YXJuaW5nOiB2YXJpYWJsZSAnZGV2JyBpcyB1c2VkIHVuaW5pdGlhbGl6
ZWQiIHJlcG9ydGVkIGJ5Cj4+ICAgJ2tlcm5lbCB0ZXN0IHJvYm90JyBhbmQgRGFuIENhcnBlbnRl
cgo+Pi0gcmViYXNlZCBvbiB0b3Agb2Ygb3RoZXIgY2hhbmdlcyAoZGV2X2F0dHIsIGdldF9jb25m
aWcoKSwgbm90aWZ5KCksIGV0Yy4pCj4+LSBsZWZ0IGJhdGNoX21hcHBpbmcgbW9kdWxlIHBhcmFt
ZXRlciBpbiB0aGUgY29yZSBbSmFzb25dCj4+Cj4+djE6Cj4+LSBSZW1vdmVkIHVudXNlZCBoZWFk
ZXJzCj4+LSBSZW1vdmVkIGVtcHR5IG1vZHVsZV9pbml0KCkgbW9kdWxlX2V4aXQoKQo+Pi0gTW92
ZWQgdmRwYXNpbV9pc19saXR0bGVfZW5kaWFuKCkgaW4gdmRwYV9zaW0uaAo+Pi0gTW92ZWQgdmRw
YXNpbTE2X3RvX2NwdS9jcHVfdG9fdmRwYXNpbTE2KCkgaW4gdmRwYV9zaW0uaAo+Pi0gQWRkZWQg
dmRwYXNpbSpfdG9fY3B1L2NwdV90b192ZHBhc2ltKigpIGFsc28gZm9yIDMyIGFuZCA2NAo+Pi0g
UmVwbGFjZWQgJ3NlbGVjdCBWRFBBX1NJTScgd2l0aCAnZGVwZW5kcyBvbiBWRFBBX1NJTScgc2lu
Y2Ugc2VsZWN0ZWQKPj4gICBvcHRpb24gY2FuIG5vdCBkZXBlbmQgb24gb3RoZXIgW0phc29uXQo+
Pi0tLQo+PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggICAgIHwgMTAzICsrKysr
KysrKysrKysKPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICAgICB8IDIyMiAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbV9uZXQuYyB8IDE3MSArKysrKysrKysrKysrKysrKysrKysKPj4gIGRyaXZlcnMvdmRwYS9L
Y29uZmlnICAgICAgICAgICAgICAgICB8ICAxMyArLQo+PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L01ha2VmaWxlICAgICAgIHwgICAxICsKPj4gIDUgZmlsZXMgY2hhbmdlZCwgMjkwIGluc2VydGlv
bnMoKyksIDIyMCBkZWxldGlvbnMoLSkKPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYwo+Cj4KPkxvb2tzIGdvb2QsIGNvbnNpZGVyIHRoZXJl
IGFyZSBzb21lIHN0aWxsIHNvbWUgcXVlc3Rpb25zIGxlZnQuIEkgd2lsbCAKPnByb2JhYmx5IGFj
ayBmb3IgdGhlIG5leHQgdmVyc2lvbi4KPgoKU3VyZSwgdGhhbmtzIGZvciB5b3VyIGZlZWRiYWNr
IQoKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
