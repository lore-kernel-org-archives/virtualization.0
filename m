Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE43C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 10:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7390A409A2;
	Mon, 13 Dec 2021 10:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpqQuin39igC; Mon, 13 Dec 2021 10:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 154D54099D;
	Mon, 13 Dec 2021 10:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E09F6C001E;
	Mon, 13 Dec 2021 10:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66B7C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D440060F30
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SbTb1HhD8y7c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE8D060F07
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639392256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
 b=T2f6ML266JmCizc1hiVnlvZTQy8Gu2R7gQQ1Qt7PNgZsD0P1eJUN3IeDJl4G3Pf6iIQkEL
 Zzf/3KpLTgullAXBb13ypLESUz+6l+c28TSda4pfD7tXHyz4eJ8ocljbw3kP8QAVrI1eBA
 72TWDVR46KTMfZX2l+IBz5Jrk5aUbwU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-eFf2tbtsM-6VS8xCVJ-CKg-1; Mon, 13 Dec 2021 05:44:15 -0500
X-MC-Unique: eFf2tbtsM-6VS8xCVJ-CKg-1
Received: by mail-ed1-f70.google.com with SMTP id
 p4-20020aa7d304000000b003e7ef120a37so13473121edq.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 02:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
 b=X1U0cUTGfzQEBxr92Mr4DT6Xe/etfmHYIDq/pPnwfhbgxxQh+S7Fln00lEPoDP2/tF
 V1msnpNJBbR/yXLSfGMFPUxOgv3J5X5YggtqBtDOO/nhx0MMdjxOX1HqkJ1eSfK8qdlR
 Xk/uSfwRMJorP4xXA3RjbyfSZSRYQ6NSfu8BFcyfLr1tsJ8LkykK3q/FT5iZ3Ua5AkG8
 dQc8x89OTZ40tCXJR2RJrE4xWYevyu+Iz7J06hymkPBpD8hqL1tx0t225mrzfHMboMDy
 RO+qCIG186ZKS9JZbl/jnN3XqYJt+kpNpJ4AJjpvjnIxmJWcb9K9WQwAfrOUZVU0B7ZB
 IeRA==
X-Gm-Message-State: AOAM532tsAq64rVqyqIq5WMY1yPRYTRe8Kaq+311Cipe0lm88r/E33yk
 2kqr1TLA4PHeB8EFcCJWx7nCh8lzCoPE7biLcyT4TROrWfk2vJNWfK+YR824G5FhUGZPXOC6e2i
 rrjKTIzJBcIK9Xi/ZAOolBW9cBe4QVmTrhHQt21qEFw==
X-Received: by 2002:a05:6402:3459:: with SMTP id
 l25mr64590643edc.137.1639392254392; 
 Mon, 13 Dec 2021 02:44:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNOaEpqXN+b3HAuKmJouNEtF+PGIf4t0ZSl55UBSuLUkEDHpoVO/YC9kejLGFYbRvvWZpNHg==
X-Received: by 2002:a05:6402:3459:: with SMTP id
 l25mr64590503edc.137.1639392253233; 
 Mon, 13 Dec 2021 02:44:13 -0800 (PST)
Received: from redhat.com ([2.55.148.125])
 by smtp.gmail.com with ESMTPSA id cw5sm5741448ejc.74.2021.12.13.02.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 02:44:12 -0800 (PST)
Date: Mon, 13 Dec 2021 05:44:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211213054357-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211209162149-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDQ6MjI6NThQTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIFRodSwgTm92IDI1LCAyMDIxIGF0IDA5OjAyOjAxUE0gKzAxMDAsIE1h
cmNlbCBIb2x0bWFubiB3cm90ZToKPiA+IEhpIE1pY2hhZWwsCj4gPiAKPiA+ID4gRGV2aWNlIHJl
bW92YWwgaXMgY2xlYXJseSBvdXQgb2YgdmlydGlvIHNwZWM6IGl0IGF0dGVtcHRzIHRvIHJlbW92
ZQo+ID4gPiB1bnVzZWQgYnVmZmVycyBmcm9tIGEgVlEgYmVmb3JlIGludm9raW5nIGRldmljZSBy
ZXNldC4gVG8gZml4LCBtYWtlCj4gPiA+IG9wZW4vY2xvc2UgTk9QcyBhbmQgZG8gYWxsIGNsZWFu
dXAvc2V0dXAgaW4gcHJvYmUvcmVtb3ZlLgo+ID4gCj4gPiBzbyB0aGUgdmlydGJ0X3tvcGVuLGNs
b3NlfSBhcyBOT1AgaXMgbm90IHJlYWxseSB3aGF0IGEgZHJpdmVyIGlzIHN1cHBvc2UKPiA+IHRv
IGJlIGRvaW5nLiBUaGVzZSBhcmUgdHJhbnNwb3J0IGVuYWJsZS9kaXNhYmxlIGNhbGxiYWNrcyBm
cm9tIHRoZSBCVAo+ID4gQ29yZSB0b3dhcmRzIHRoZSBkcml2ZXIuIEl0IG1hcHMgdG8gYSBkZXZp
Y2UgYmVpbmcgZW5hYmxlZC9kaXNhYmxlZCBieQo+ID4gc29tZXRoaW5nIGxpa2UgYmx1ZXRvb3Ro
ZCBmb3IgZXhhbXBsZS4gU28gaWYgZGlzYWJsZWQsIEkgZXhwZWN0IHRoYXQgbm8KPiA+IHJlc291
cmNlcy9xdWV1ZXMgYXJlIGluIHVzZS4KPiA+IAo+ID4gTWF5YmUgSSBtaXN1bmRlcnN0YW5kIHRo
ZSB2aXJ0aW8gc3BlYyBpbiB0aGF0IHJlZ2FyZCwgYnV0IEkgd291bGQgbGlrZQo+ID4gdG8ga2Vl
cCB0aGlzIGZ1bmRhbWVudGFsIGNvbmNlcHQgb2YgYSBCbHVldG9vdGggZHJpdmVyLiBJdCBkb2Vz
IHdvcmsKPiA+IHdpdGggYWxsIG90aGVyIHRyYW5zcG9ydHMgbGlrZSBVU0IsIFNESU8sIFVBUlQg
ZXRjLgo+ID4gCj4gPiA+IFRoZSBjb3N0IGhlcmUgaXMgYSBzaW5nbGUgc2tiIHdhc3RlZCBvbiBh
biB1bnVzZWQgYnQgZGV2aWNlIC0gd2hpY2gKPiA+ID4gc2VlbXMgbW9kZXN0Lgo+ID4gCj4gPiBU
aGVyZSBzaG91bGQgYmUgbm8gYnVmZmVyIHVzZWQgaWYgdGhlIGRldmljZSBpcyBwb3dlcmVkIG9m
Zi4gV2UgYWxzbyBkb27igJl0Cj4gPiBoYXZlIGFueSBVU0IgVVJCcyBpbi1mbGlnaHQgaWYgdGhl
IHRyYW5zcG9ydCBpcyBub3QgYWN0aXZlLgo+ID4gCj4gPiA+IE5COiB3aXRoIHRoaXMgZml4IGlu
IHBsYWNlIGRyaXZlciBzdGlsbCBzdWZmZXJzIGZyb20gYSByYWNlIGNvbmRpdGlvbiBpZgo+ID4g
PiBhbiBpbnRlcnJ1cHQgdHJpZ2dlcnMgd2hpbGUgZGV2aWNlIGlzIGJlaW5nIHJlc2V0LiBXb3Jr
IG9uIGEgZml4IGZvcgo+ID4gPiB0aGF0IGlzc3VlIGlzIGluIHByb2dyZXNzLgo+ID4gCj4gPiBJ
biB0aGUgdmlydGJ0X2Nsb3NlKCkgY2FsbGJhY2sgd2Ugc2hvdWxkIGRlYWN0aXZhdGUgYWxsIGlu
dGVycnVwdHMuCj4gPiAKPiA+IFJlZ2FyZHMKPiA+IAo+ID4gTWFyY2VsCj4gCj4gU28gTWFyY2Vs
LCBkbyBJIHJlYWQgaXQgcmlnaHQgdGhhdCB5b3UgYXJlIHdvcmtpbmcgb24gYSBmaXgKPiBhbmQg
SSBjYW4gZHJvcCB0aGlzIHBhdGNoIGZvciBub3c/CgpwaW5nCgo+IC0tIAo+IE1TVAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
