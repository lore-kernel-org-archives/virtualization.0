Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD719C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C7E160C00;
	Mon, 10 Jan 2022 07:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BFRlLmS4in7; Mon, 10 Jan 2022 07:41:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 363B9607D1;
	Mon, 10 Jan 2022 07:41:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0767EC0030;
	Mon, 10 Jan 2022 07:41:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A27F2C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E884813A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5e3fXcqYDhzP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAF7381375
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641800501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqt+SxB0DkxPbDtF18iXkH6TYZVZxdgpeWCI/zHaJdw=;
 b=EdHkfkvSrJ1dIn0+VH466a3FfapceCLtzMJtMYbw5EHFODD2joO5deiGyCNFANZsJ6sfX6
 IdkEPC0t2JdxhWwpk+Na/YzpjtbUpyES8dR8iOm6jtCjPev4pGFWnM2q4OpEVmeXN0WuQm
 4aalcQ2eXE615vtQ9ypV++fG7BTWhDE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-bvyQFBUvNtC3wa8O93c1xQ-1; Mon, 10 Jan 2022 02:41:40 -0500
X-MC-Unique: bvyQFBUvNtC3wa8O93c1xQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 bq6-20020a056512150600b0041bf41f5437so6013489lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 23:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bqt+SxB0DkxPbDtF18iXkH6TYZVZxdgpeWCI/zHaJdw=;
 b=6p3kJeNsPeK4Ky6QuqakfEby0VOqCCUF2DQTQWOGgj9atCm8eDtfcx2wJkrI8KJxb8
 Y32vSflBDD51P747SodF8bTA7zlDsHtrBx1b8+9Lt7t9l3H8qg/+wlzQ9AHbecK/UQC1
 i41JNQp4HTFAgSR7zI+FiRAH48MqixcmEJXW1netG3g1IEyMsq47lGqBAT8DDPR9mG/x
 J38twRpSwPOGFe+d6ug3O1btSGQ/8lplLswTpns//Bd7mDnvuE8J7DAosSUlv7wwhVjj
 z3rzZZvIo4HAoUx11j45FuUHaeSR4NLnKM3OjOYPEXdV/rerEWlmV/C2ByRps/HsTMiC
 devA==
X-Gm-Message-State: AOAM533IW6bVITI7isWgLglTlhhfURHObu+ZH5OoxaP8m96kYRlsoZcx
 AnUTTsOjJ2wgAvaSLAG2hKHALZiCAwA7A/J+FhBog1lInIp7Fln0ntLULs1+pQdNV937BB3UC5f
 7jQqNlccd7hbB8lZGzuZvrRR7cxWJcZJ1ocNit/HMhiuVPIfKIo+oU732iQ==
X-Received: by 2002:a05:6512:230f:: with SMTP id
 o15mr61331810lfu.348.1641800498954; 
 Sun, 09 Jan 2022 23:41:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ6MssEqU7H/Y0PFqiyzrvnTPfOApHjJUIezxSaHtd6Oj3c+RXhNJBBNuuHkcw0bB+d/a7ikIUOGKIcPwJUZ0=
X-Received: by 2002:a05:6512:230f:: with SMTP id
 o15mr61331801lfu.348.1641800498778; 
 Sun, 09 Jan 2022 23:41:38 -0800 (PST)
MIME-Version: 1.0
References: <c649faa9-aa1f-e5ff-a448-0abce38eeff9@redhat.com>
 <1641799153.8704977-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1641799153.8704977-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jan 2022 15:41:27 +0800
Message-ID: <CACGkMEsV-GLLUmTnBHBUou_2+urkpaV4A54cD8wwoH-6eoer=w@mail.gmail.com>
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMTAgSmFuIDIwMjIgMTQ6NDM6MzkgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzEvNyDkuIvljYgyOjMzLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiBJbiB0aGUgc2NlbmFy
aW8gd2hlcmUgaW5kaXJlY3QgaXMgbm90IHVzZWQsIGVhY2ggZGVzYyBjb3JyZXNwb25kcyB0byBh
bgo+ID4gPiBleHRyYSwgd2hpY2ggaXMgdXNlZCB0byByZWNvcmQgaW5mb3JtYXRpb24gc3VjaCBh
cyBkbWEsIGZsYWdzLCBhbmQKPiA+ID4gbmV4dC4KPiA+ID4KPiA+ID4gSW4gdGhlIHNjZW5hcmlv
IG9mIHVzaW5nIGluZGlyZWN0LCB0aGUgYXNzaWduZWQgZGVzYyBkb2VzIG5vdCBoYXZlIHRoZQo+
ID4gPiBjb3JyZXNwb25kaW5nIGV4dHJhIHJlY29yZCBkbWEgaW5mb3JtYXRpb24sIGFuZCB0aGUg
ZG1hIGluZm9ybWF0aW9uIG11c3QKPiA+ID4gYmUgb2J0YWluZWQgZnJvbSB0aGUgZGVzYyB3aGVu
IHVubWFwLgo+ID4gPgo+ID4gPiBUaGlzIHBhdGNoIGFsbG9jYXRlcyB0aGUgY29ycmVzcG9uZGlu
ZyBleHRyYSBhcnJheSB3aGVuIGluZGlyZWN0IGRlc2MgaXMKPiA+ID4gYWxsb2NhdGVkLiBUaGlz
IGhhcyB0aGVzZSBhZHZhbnRhZ2VzOgo+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlv
biBvZiBkZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+IDIuIEl0IHdp
bGwgYmUgbW9yZSBjb252ZW5pZW50IGFuZCB1bmlmaWVkIGluIHByb2Nlc3NpbmcKPiA+ID4gMy4g
U29tZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGNhbiBiZSByZWNvcmRlZCBpbiBleHRyYSwgd2hp
Y2ggd2lsbCBiZQo+ID4gPiAgICAgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4gPgo+ID4K
PiA+IFR3byBxdWVzdGlvbnM6Cj4gPgo+ID4gMSkgSXMgdGhlcmUgYW55IHBlcmZvcm1hbmNlIG51
bWJlciBmb3IgdGhpcyBjaGFuZ2U/IEkgZ3Vlc3MgaXQgZ2l2ZXMKPiA+IG1vcmUgc3RyZXNzIG9u
IHRoZSBjYWNoZS4KPgo+IEkgd2lsbCBhZGQgcGVyZm9ybWFuY2UgdGVzdCBkYXRhIGluIHRoZSBu
ZXh0IHZlcnNpb24uCj4KPiA+IDIpIElzIHRoZXJlIGEgcmVxdWlyZW1lbnQgdG8gbWl4IHRoZSBw
cmUgbWFwcGVkIHNnIHdpdGggdW5tYXBwZWQgc2c/IElmCj4gPiBub3QsIGEgcGVyIHZpcnRxdWV1
ZSBmbGFnIGxvb2tzIHN1ZmZpY2llbnQKPgo+IFRoZXJlIGlzIHRoaXMgcmVxdWlyZW1lbnQuIEZv
ciBleGFtcGxlLCBpbiB0aGUgY2FzZSBvZiBBRl9YRFAsIGEgcGF0Y2tldAo+IGNvbnRhaW5zIHR3
byBwYXJ0cywgb25lIGlzIHZpcnRpb19uZXRfaGRyLCBhbmQgdGhlIG90aGVyIGlzIHRoZSBhY3R1
YWwgZGF0YQo+IHBhY2tldCBmcm9tIEFGX1hEUC4gVGhlIGZvcm1lciBpcyB1bm1hcHBlZCBzZywg
YW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBlZCBzZy4KCkFueSBjaGFuY2UgdG8gbWFwIHZpcnRp
b19uZXRfaGRyKCkgbWFudWFsbHkgYnkgQUZfWERQIHJvdXRpbmUgaW4gdGhpcyBjYXNlPwoKVGhh
bmtzCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
