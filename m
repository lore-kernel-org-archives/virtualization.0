Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA7C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 05:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0D6E427FD;
	Fri, 21 Apr 2023 05:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0D6E427FD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtxCWy8k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9LcuIyoUlLbk; Fri, 21 Apr 2023 05:52:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC311427FC;
	Fri, 21 Apr 2023 05:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC311427FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F454C0036;
	Fri, 21 Apr 2023 05:52:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9370C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 05:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AD8E427FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 05:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AD8E427FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2_UfXbApCbkh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 05:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8F1D427FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8F1D427FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682056315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5I7evANVAfJwuk/ANSR7cqv4R/exMlo0YUcDm4ZAsZk=;
 b=UtxCWy8koms1qCGcMDK9fq4UEboxvZwC4G+44dKwwH8HP9mjQmvj0O3OBdbvhHzmy6QCBv
 QztgHpLY532/EggarORuBZly/Me9hxOImipg8hBYUFHp11Dxh2TsFOeKvf0F6yWVx+nTSa
 tC6pLmGKCrG+rQ2AXTupP/NFQU+kVmw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-huJAWcUSPI6QDjlqh2_47w-1; Fri, 21 Apr 2023 01:51:53 -0400
X-MC-Unique: huJAWcUSPI6QDjlqh2_47w-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-38e08f655e2so586529b6e.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 22:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682056313; x=1684648313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5I7evANVAfJwuk/ANSR7cqv4R/exMlo0YUcDm4ZAsZk=;
 b=QVJ6iYq4ve/D1BT2ip1qMk9A63uJxju4486prFTqLkBIAaJDGVOnW3Y0OsbV1xlek4
 NwoUSbgfb3Z5p2SkGL3B/AwP1aSSwzvJodnHN4oIwJHNKExKQShZB8SkZE+jS7gJaW8C
 7JKL7mkvOCCJ2EL4CNBnveWyepBdeThHhJc+UmCRBQZTJjBdyVm3hx+ITezVEX7EiOU3
 HMiv1g//5QcBJ80u/7MuWNbOUJj5ogqup1HmbT+3uC7QbV4uR8RvtY8KaiN/Wp1pi4FA
 F3219UD2kJzq6twQ+jli7ZHB2wDG0rJFcxuRkM3IPWPAru2OF9NbA0+HzJobCZBhFWWO
 irFQ==
X-Gm-Message-State: AAQBX9cn2xMVE905HG77MzeQgO8zr4JOiGcllg2C6z1H0fuYZvbnt/qb
 B7uL6whR4bkaV9ECCoD6YXRSerXpf5noYaubQY9D/hJMuL7NLQvw8CIDwHKA7VAsFudORjzUvg/
 n9FqubccQRRjlf5ntBamzhnY8C+82j2Njml6mqnH4cewKqo5X9nAe+QkEtA==
X-Received: by 2002:a05:6808:16ab:b0:38c:17a7:5b7b with SMTP id
 bb43-20020a05680816ab00b0038c17a75b7bmr2056935oib.19.1682056313009; 
 Thu, 20 Apr 2023 22:51:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350bchGp1g3M4Oxp2OMGsAtahE5jQNn822SVg525TzI2VQbnv6N9KJLpXdXFbYWo5pLOIS/diFH+MGlS5GPILS4Q=
X-Received: by 2002:a05:6808:16ab:b0:38c:17a7:5b7b with SMTP id
 bb43-20020a05680816ab00b0038c17a75b7bmr2056923oib.19.1682056312733; Thu, 20
 Apr 2023 22:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
 <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
In-Reply-To: <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Apr 2023 13:51:41 +0800
Message-ID: <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

T24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgMTA6MTbigK9QTSBNYXhpbWUgQ29xdWVsaW4KPG1heGlt
ZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA0LzIwLzIzIDA2OjM0LCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gV2VkLCBBcHIgMTksIDIwMjMgYXQgOTo0M+KAr1BNIE1h
eGltZSBDb3F1ZWxpbgo+ID4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPiA+
Pgo+ID4+IFRoaXMgc21hbGwgc2VyaWVzIGVuYWJsZXMgdmlydGlvLW5ldCBkZXZpY2UgdHlwZSBp
biBWRFVTRS4KPiA+PiBXaXRoIGl0LCBiYXNpYyBvcGVyYXRpb24gaGF2ZSBiZWVuIHRlc3RlZCwg
Ym90aCB3aXRoCj4gPj4gdmlydGlvLXZkcGEgYW5kIHZob3N0LXZkcGEgdXNpbmcgRFBESyBWaG9z
dCBsaWJyYXJ5IHNlcmllcwo+ID4+IGFkZGluZyBWRFVTRSBzdXBwb3J0IFswXSB1c2luZyBzcGxp
dCByaW5ncyBsYXlvdXQuCj4gPj4KPiA+PiBDb250cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBt
dWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4gPj4gdGVzdGVkLCBidXQgcmVxdWlyZSBhIEtlcm5l
bCBzZXJpZXMgZnJvbSBKYXNvbiBXYW5nCj4gPj4gcmVsYXhpbmcgY29udHJvbCBxdWV1ZSBwb2xs
aW5nIFsxXSB0byBmdW5jdGlvbiByZWxpYWJseS4KPiA+Pgo+ID4+IE90aGVyIHRoYW4gdGhhdCwg
d2UgaGF2ZSBpZGVudGlmaWVkIGEgZmV3IGdhcHM6Cj4gPj4KPiA+PiAxLiBSZWNvbm5lY3Rpb246
Cj4gPj4gICBhLiBWRFVTRV9WUV9HRVRfSU5GTyBpb2N0bCgpIHJldHVybnMgYWx3YXlzIDAgZm9y
IGF2YWlsCj4gPj4gICAgICBpbmRleCwgZXZlbiBhZnRlciB0aGUgdmlydHF1ZXVlIGhhcyBhbHJl
YWR5IGJlZW4KPiA+PiAgICAgIHByb2Nlc3NlZC4gSXMgdGhhdCBleHBlY3RlZD8gSSBoYXZlIHRy
aWVkIGluc3RlYWQgdG8KPiA+PiAgICAgIGdldCB0aGUgZHJpdmVyJ3MgYXZhaWwgaW5kZXggZGly
ZWN0bHkgZnJvbSB0aGUgYXZhaWwKPiA+PiAgICAgIHJpbmcsIGJ1dCBpdCBkb2VzIG5vdCBzZWVt
IHJlbGlhYmxlIGFzIEkgc29tZXRpbWVzIGdldAo+ID4+ICAgICAgImlkICV1IGlzIG5vdCBhIGhl
YWQhXG4iIHdhcm5pbmdzLiBBbHNvIHN1Y2ggc29sdXRpb24KPiA+PiAgICAgIHdvdWxkIG5vdCBi
ZSBwb3NzaWJsZSB3aXRoIHBhY2tlZCByaW5nLCBhcyB3ZSBuZWVkIHRvCj4gPj4gICAgICBrbm93
IHRoZSB3cmFwIGNvdW50ZXJzIHZhbHVlcy4KPiA+Cj4gPiBMb29raW5nIGF0IHRoZSBjb2Rlcywg
aXQgb25seSByZXR1cm5zIHRoZSB2YWx1ZSB0aGF0IGlzIHNldCB2aWEKPiA+IHNldF92cV9zdGF0
ZSgpLiBJIHRoaW5rIGl0IGlzIGV4cGVjdGVkIHRvIGJlIGNhbGxlZCBiZWZvcmUgdGhlCj4gPiBk
YXRhcGF0aCBydW5zLgo+ID4KPiA+IFNvIHdoZW4gYm91bmQgdG8gdmlydGlvLXZkcGEsIGl0IGlz
IGV4cGVjdGVkIHRvIHJldHVybiAwLiBCdXQgd2UgbmVlZAo+ID4gdG8gZml4IHRoZSBwYWNrZWQg
dmlydHF1ZXVlIGNhc2UsIEkgd29uZGVyIGlmIHdlIG5lZWQgdG8gY2FsbAo+ID4gc2V0X3ZxX3N0
YXRlKCkgZXhwbGljaXRseSBpbiB2aXJ0aW8tdmRwYSBiZWZvcmUgc3RhcnRpbmcgdGhlIGRldmlj
ZS4KPiA+Cj4gPiBXaGVuIGJvdW5kIHRvIHZob3N0LXZkcGEsIFFlbXUgd2lsbCBjYWxsIFZIT1NU
X1NFVF9WUklOR19CQVNFIHdoaWNoCj4gPiB3aWxsIGVuZCB1cCBhIGNhbGwgdG8gc2V0X3ZxX3N0
YXRlKCkuIFVuZm9ydHVuYXRlbHksIGl0IGRvZXNuJ3QKPiA+IHN1cHBvcnQgcGFja2VkIHJpbmcg
d2hpY2ggbmVlZHMgc29tZSBleHRlbnNpb24uCj4gPgo+ID4+Cj4gPj4gICBiLiBNaXNzaW5nIElP
Q1RMczogaXQgd291bGQgYmUgaGFuZHkgdG8gaGF2ZSBuZXcgSU9DVExzIHRvCj4gPj4gICAgICBx
dWVyeSBWaXJ0aW8gZGV2aWNlIHN0YXR1cywKPiA+Cj4gPiBXaGF0J3MgdGhlIHVzZSBjYXNlIG9m
IHRoaXMgaW9jdGw/IEl0IGxvb2tzIHRvIG1lIHVzZXJzcGFjZSBpcwo+ID4gbm90aWZpZWQgb24g
ZWFjaCBzdGF0dXMgY2hhbmdlIG5vdzoKPiA+Cj4gPiBzdGF0aWMgaW50IHZkdXNlX2Rldl9zZXRf
c3RhdHVzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwgdTggc3RhdHVzKQo+ID4gewo+ID4gICAgICAg
ICAgc3RydWN0IHZkdXNlX2Rldl9tc2cgbXNnID0geyAwIH07Cj4gPgo+ID4gICAgICAgICAgbXNn
LnJlcS50eXBlID0gVkRVU0VfU0VUX1NUQVRVUzsKPiA+ICAgICAgICAgIG1zZy5yZXEucy5zdGF0
dXMgPSBzdGF0dXM7Cj4gPgo+ID4gICAgICAgICAgcmV0dXJuIHZkdXNlX2Rldl9tc2dfc3luYyhk
ZXYsICZtc2cpOwo+ID4gfQo+Cj4gVGhlIGlkZWEgd2FzIHRvIGJlIGFibGUgdG8gcXVlcnkgdGhl
IHN0YXR1cyBhdCByZWNvbm5lY3QgdGltZSwgYW5kCj4gbmVpdGhlciBoYXZpbmcgdG8gYXNzdW1l
IGl0cyB2YWx1ZSBub3IgaGF2aW5nIHRvIHN0b3JlIGl0cyB2YWx1ZSBpbiBhCj4gZmlsZSAodGhl
IHN0YXR1cyBjb3VsZCBjaGFuZ2Ugd2hpbGUgdGhlIFZEVVNFIGFwcGxpY2F0aW9uIGlzIHN0b3Bw
ZWQsCj4gYnV0IG1heWJlIGl0IHdvdWxkIHJlY2VpdmUgdGhlIG5vdGlmaWNhdGlvbiBhdCByZWNv
bm5lY3QpLgoKSSBzZWUuCgo+Cj4gSSB3aWxsIHByb3RvdHlwZSB1c2luZyBhIHRtcGZzIGZpbGUg
dG8gc2F2ZSBuZWVkZWQgaW5mb3JtYXRpb24sIGFuZCBzZWUKPiBpZiBpdCB3b3Jrcy4KCkl0IG1p
Z2h0IHdvcmsgYnV0IHRoZW4gdGhlIEFQSSBpcyBub3Qgc2VsZiBjb250YWluZWQuIE1heWJlIGl0
J3MKYmV0dGVyIHRvIGhhdmUgYSBkZWRpY2F0ZWQgaW9jdGwuCgo+Cj4gPj4gYW5kIHJldHJpZXZl
IHRoZSBjb25maWcKPiA+PiAgICAgIHNwYWNlIHNldCBhdCBWRFVTRV9DUkVBVEVfREVWIHRpbWUu
Cj4gPgo+ID4gSW4gb3JkZXIgdG8gYmUgc2FmZSwgVkRVU0UgYXZvaWRzIHdyaXRhYmxlIGNvbmZp
ZyBzcGFjZS4gT3RoZXJ3aXNlCj4gPiBkcml2ZXJzIGNvdWxkIGJsb2NrIG9uIGNvbmZpZyB3cml0
aW5nIGZvcmV2ZXIuIFRoYXQncyB3aHkgd2UgZG9uJ3QgZG8KPiA+IGl0IG5vdy4KPgo+IFRoZSBp
ZGVhIHdhcyBub3QgdG8gbWFrZSB0aGUgY29uZmlnIHNwYWNlIHdyaXRhYmxlLCBidXQganVzdCB0
byBiZSBhYmxlCj4gdG8gZmV0Y2ggd2hhdCB3YXMgZmlsbGVkIGF0IFZEVVNFX0NSRUFURV9ERVYg
dGltZS4KPgo+IFdpdGggdGhlIHRtcGZzIGZpbGUsIHdlIGNhbiBhdm9pZCBkb2luZyB0aGF0IGFu
ZCBqdXN0IHNhdmUgdGhlIGNvbmZpZwo+IHNwYWNlIHRoZXJlLgoKU2FtZSBhcyB0aGUgY2FzZSBm
b3Igc3RhdHVzLgoKVGhhbmtzCgo+Cj4gPiBXZSBuZWVkIHRvIGhhcmRlbiB0aGUgY29uZmlnIHdy
aXRlIGJlZm9yZSB3ZSBjYW4gcHJvY2VlZCB0byB0aGlzIEkgdGhpbmsuCj4gPgo+ID4+Cj4gPj4g
Mi4gVkRVU0UgYXBwbGljYXRpb24gYXMgbm9uLXJvb3Q6Cj4gPj4gICAgV2UgbmVlZCB0byBydW4g
dGhlIFZEVVNFIGFwcGxpY2F0aW9uIGFzIG5vbi1yb290LiBUaGVyZQo+ID4+ICAgIGlzIHNvbWUg
cmFjZSBiZXR3ZWVuIHRoZSB0aW1lIHRoZSBVREVWIHJ1bGUgaXMgYXBwbGllZAo+ID4+ICAgIGFu
ZCB0aGUgdGltZSB0aGUgZGV2aWNlIHN0YXJ0cyBiZWluZyB1c2VkLiBEaXNjdXNzaW5nCj4gPj4g
ICAgd2l0aCBKYXNvbiwgaGUgc3VnZ2VzdGVkIHdlIG1heSBoYXZlIGEgVkRVU0UgZGFlbW9uIHJ1
bgo+ID4+ICAgIGFzIHJvb3QgdGhhdCB3b3VsZCBjcmVhdGUgdGhlIFZEVVNFIGRldmljZSwgbWFu
YWdlcyBpdHMKPiA+PiAgICByaWdodHMgYW5kIHRoZW4gcGFzcyBpdHMgZmlsZSBkZXNjcmlwdG9y
IHRvIHRoZSBWRFVTRQo+ID4+ICAgIGFwcC4gSG93ZXZlciwgd2l0aCBjdXJyZW50IElPQ1RMcywg
aXQgbWVhbnMgdGhlIFZEVVNFCj4gPj4gICAgZGFlbW9uIHdvdWxkIG5lZWQgdG8ga25vdyBzZXZl
cmFsIGluZm9ybWF0aW9uIHRoYXQKPiA+PiAgICBiZWxvbmdzIHRvIHRoZSBWRFVTRSBhcHAgaW1w
bGVtZW50aW5nIHRoZSBkZXZpY2Ugc3VjaAo+ID4+ICAgIGFzIHN1cHBvcnRlZCBWaXJ0aW8gZmVh
dHVyZXMsIGNvbmZpZyBzcGFjZSwgZXRjLi4uCj4gPj4gICAgSWYgd2UgZ28gdGhhdCByb3V0ZSwg
bWF5YmUgd2Ugc2hvdWxkIGhhdmUgYSBjb250cm9sCj4gPj4gICAgSU9DVEwgdG8gY3JlYXRlIHRo
ZSBkZXZpY2Ugd2hpY2ggd291bGQganVzdCBwYXNzIHRoZQo+ID4+ICAgIGRldmljZSB0eXBlLiBU
aGVuIGFub3RoZXIgZGV2aWNlIElPQ1RMIHRvIHBlcmZvcm0gdGhlCj4gPj4gICAgaW5pdGlhbGl6
YXRpb24uIFdvdWxkIHRoYXQgbWFrZSBzZW5zZT8KPiA+Cj4gPiBJIHRoaW5rIHNvLiBXZSBjYW4g
aGVhciBmcm9tIG90aGVycy4KPiA+Cj4gPj4KPiA+PiAzLiBDb3JlZHVtcDoKPiA+PiAgICBJbiBv
cmRlciB0byBiZSBhYmxlIHRvIHBlcmZvcm0gcG9zdC1tb3J0ZW0gYW5hbHlzaXMsIERQREsKPiA+
PiAgICBWaG9zdCBsaWJyYXJ5IG1hcmtzIHBhZ2VzIHVzZWQgZm9yIHZyaW5ncyBhbmQgZGVzY3Jp
cHRvcnMKPiA+PiAgICBidWZmZXJzIGFzIE1BRFZfRE9EVU1QIHVzaW5nIG1hZHZpc2UoKS4gSG93
ZXZlciB3aXRoCj4gPj4gICAgVkRVU0UgaXQgZmFpbHMgd2l0aCAtRUlOVkFMLiBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgd2UKPiA+PiAgICBzZXQgVk1fRE9OVEVYUEFORCBmbGFnIHRvIHRoZSBW
TUFzIGFuZCBtYWR2aXNlJ3MKPiA+PiAgICBNQURWX0RPRFVNUCBmYWlscyBpZiBpdCBpcyBwcmVz
ZW50LiBJJ20gbm90IHN1cmUgdG8KPiA+PiAgICB1bmRlcnN0YW5kIHdoeSBtYWR2aXNlIHdvdWxk
IHByZXZlbnQgTUFEVl9ET0RVTVAgaWYKPiA+PiAgICBWTV9ET05URVhQQU5EIGlzIHNldC4gQW55
IHRob3VnaHRzPwo+ID4KPiA+IEFkZGluZyBQZXRlciB3aG8gbWF5IGtub3cgdGhlIGFuc3dlci4K
Pgo+IFRoYW5rcyEKPiBNYXhpbWUKPgo+ID4gVGhhbmtzCj4gPgo+ID4+Cj4gPj4gWzBdOiBodHRw
czovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvbGlzdC8/c2VyaWVzPTI3NTk0JnN0
YXRlPSUyQSZhcmNoaXZlPWJvdGgKPiA+PiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvQ0FDR2tNRXRncnhOM1BQd3NEbzRvT3Nuc1NMSmZFbUJFWjBXdmpHUnIzd2hVK1Fhc1VnQG1h
aWwuZ21haWwuY29tL1QvCj4gPj4KPiA+PiBNYXhpbWUgQ29xdWVsaW4gKDIpOgo+ID4+ICAgIHZk
dXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sgZGV2aWNlcwo+ID4+
ICAgIHZkdXNlOiBlbmFibGUgVmlydGlvLW5ldCBkZXZpY2UgdHlwZQo+ID4+Cj4gPj4gICBkcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMTEgKysrKysrKy0tLS0KPiA+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPj4KPiA+PiAt
LQo+ID4+IDIuMzkuMgo+ID4+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
