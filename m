Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BFAC77B75
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 05:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 576CF614D5;
	Mon, 15 May 2023 05:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 576CF614D5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i5UzSEcO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4s6-aY0_mYAu; Mon, 15 May 2023 05:07:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C44F860AE9;
	Mon, 15 May 2023 05:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C44F860AE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D284C0036;
	Mon, 15 May 2023 05:07:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F669C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 075B041DAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:07:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 075B041DAF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i5UzSEcO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TB8NTVlJryH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEEB841DA7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEEB841DA7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684127250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKZHvRmtbGrlB9TiMCKvV90xCw0G0VcCqDjdpolfJIA=;
 b=i5UzSEcOrznNga7+yqlUFdycfWex3Zvbl9UEI/xtBvUv5brNB3gQ+w+7HPPaRPh7p/NQtu
 43qjyo9H2nE0/P3nTXwvMVjag4dwlO9d42b46PUuE7CNtEAotb2w3ERx6IWRZe+Bi7D45h
 5HG/Anz+4AVG91MJpeQncebxl76dBPA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-rF5qyWJAP-SET53bPpg4Ag-1; Mon, 15 May 2023 01:07:29 -0400
X-MC-Unique: rF5qyWJAP-SET53bPpg4Ag-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7406cb5so7300519e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 22:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684127248; x=1686719248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKZHvRmtbGrlB9TiMCKvV90xCw0G0VcCqDjdpolfJIA=;
 b=hpTqTIoF3AkX+oCoUYVGswdZtda2MDDabpDVgtrZHTYTa6siK9GBd24awpSUYYIdMC
 GiL3Wq1ZAKJUEYBx0aignS4YJUKQLKd4PGA7CLqzHEyb77CuErVwwo4C0BC74Quvq66+
 DM6tpJicdt4l8HVPYcU55jumgnkBvXZklZRtNVZdiGpfFTuMLta84AotObtx0tY2TOlE
 qQ2zv6OSprLy4F/Z/ailUNNrgrra++jtagEDtO2+paFDgG134tomxeAuKNu8y4Z1Tv7y
 eRY6ey8fTeiEJ+SkhK7tJ1TRXffNjhlEMpUIwTFcLoSGBiyogtFUO7Tdj4wa2mALDRlR
 FFHw==
X-Gm-Message-State: AC+VfDz+YS2ZOO1EG+GzSvxggZdZq88bsbTvJSOJ3PBJSwU7rPaMrCzV
 PVUhH59NB3NGia7AHILUsw4TvtUzqGkQyEF6MdtdmT2133NuLuym+bgdI6yR9OM+opzijJRPPRR
 svvIdz4lqnAFL6haq7DxDc2Huk5NRxPVAFMO1hQDooIcbqL0gcolcUPQxYg==
X-Received: by 2002:ac2:4a7a:0:b0:4ed:d250:1604 with SMTP id
 q26-20020ac24a7a000000b004edd2501604mr5617080lfp.57.1684127248003; 
 Sun, 14 May 2023 22:07:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5A2Jta/mMxoVzPA48qfPIiuZGYiwTSTn2WlbiarOl+yGNcnMsPx90fz4OXORRJSsuaiKkvKSG2Cxlt63sNtHs=
X-Received: by 2002:ac2:4a7a:0:b0:4ed:d250:1604 with SMTP id
 q26-20020ac24a7a000000b004edd2501604mr5617071lfp.57.1684127247680; Sun, 14
 May 2023 22:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-12-shannon.nelson@amd.com>
In-Reply-To: <20230503181240.14009-12-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 13:07:16 +0800
Message-ID: <CACGkMEvxzRuW2i=3=wv=B7J8UfytxwRoA3SJRexuOgLzJtmZ3Q@mail.gmail.com>
Subject: Re: [PATCH v5 virtio 11/11] pds_vdpa: pds_vdps.rst and Kconfig
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgNCwgMjAyMyBhdCAyOjEz4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGFuZCBLY29u
ZmlnIGVudHJ5IGZvciBwZHNfdmRwYSBkcml2ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9u
IE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPiAtLS0KPiAgLi4uL2RldmljZV9kcml2
ZXJzL2V0aGVybmV0L2FtZC9wZHNfdmRwYS5yc3QgIHwgODUgKysrKysrKysrKysrKysrKysrKwo+
ICAuLi4vZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvaW5kZXgucnN0ICAgICAgICAgfCAgMSArCj4g
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsKPiAg
ZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysKPiAg
NCBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvYW1kL3Bkc192
ZHBhLnJzdAo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2Vf
ZHJpdmVycy9ldGhlcm5ldC9hbWQvcGRzX3ZkcGEucnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2FtZC9wZHNfdmRwYS5yc3QKPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTg3OTI3ZDNkZTkyCj4gLS0tIC9kZXYv
bnVsbAo+ICsrKyBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhl
cm5ldC9hbWQvcGRzX3ZkcGEucnN0Cj4gQEAgLTAsMCArMSw4NSBAQAo+ICsuLiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCsKPiArLi4gbm90ZTogY2FuIGJlIGVkaXRlZCBhbmQgdmll
d2VkIHdpdGggL3Vzci9iaW4vZm9ybWlrby12aW0KPiArCj4gKz09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiArUENJIHZEUEEgZHJpdmVy
IGZvciB0aGUgQU1EL1BlbnNhbmRvKFIpIERTQyBhZGFwdGVyIGZhbWlseQo+ICs9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gKwo+ICtB
TUQvUGVuc2FuZG8gdkRQQSBWRiBEZXZpY2UgRHJpdmVyCj4gKwo+ICtDb3B5cmlnaHQoYykgMjAy
MyBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMKPiArCj4gK092ZXJ2aWV3Cj4gKz09PT09PT09
Cj4gKwo+ICtUaGUgYGBwZHNfdmRwYWBgIGRyaXZlciBpcyBhbiBhdXhpbGlhcnkgYnVzIGRyaXZl
ciB0aGF0IHN1cHBsaWVzCj4gK2EgdkRQQSBkZXZpY2UgZm9yIHVzZSBieSB0aGUgdmlydGlvIG5l
dHdvcmsgc3RhY2suICBJdCBpcyB1c2VkIHdpdGgKPiArdGhlIFBlbnNhbmRvIFZpcnR1YWwgRnVu
Y3Rpb24gZGV2aWNlcyB0aGF0IG9mZmVyIHZEUEEgYW5kIHZpcnRpbyBxdWV1ZQo+ICtzZXJ2aWNl
cy4gIEl0IGRlcGVuZHMgb24gdGhlIGBgcGRzX2NvcmVgYCBkcml2ZXIgYW5kIGhhcmR3YXJlIGZv
ciB0aGUgUEYKPiArYW5kIFZGIFBDSSBoYW5kbGluZyBhcyB3ZWxsIGFzIGZvciBkZXZpY2UgY29u
ZmlndXJhdGlvbiBzZXJ2aWNlcy4KPiArCj4gK1VzaW5nIHRoZSBkZXZpY2UKPiArPT09PT09PT09
PT09PT09PQo+ICsKPiArVGhlIGBgcGRzX3ZkcGFgYCBkZXZpY2UgaXMgZW5hYmxlZCB2aWEgbXVs
dGlwbGUgY29uZmlndXJhdGlvbiBzdGVwcyBhbmQKPiArZGVwZW5kcyBvbiB0aGUgYGBwZHNfY29y
ZWBgIGRyaXZlciB0byBjcmVhdGUgYW5kIGVuYWJsZSBTUi1JT1YgVmlydHVhbAo+ICtGdW5jdGlv
biBkZXZpY2VzLiAgQWZ0ZXIgdGhlIFZGcyBhcmUgZW5hYmxlZCwgd2UgZW5hYmxlIHRoZSB2RFBB
IHNlcnZpY2UKPiAraW4gdGhlIGBgcGRzX2NvcmVgYCBkZXZpY2UgdG8gY3JlYXRlIHRoZSBhdXhp
bGlhcnkgZGV2aWNlcyB1c2VkIGJ5IHBkc192ZHBhLgo+ICsKPiArRXhhbXBsZSBzdGVwczoKPiAr
Cj4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoCj4gKwo+ICsgICMhL2Jpbi9iYXNoCj4gKwo+ICsgIG1v
ZHByb2JlIHBkc19jb3JlCj4gKyAgbW9kcHJvYmUgdmRwYQo+ICsgIG1vZHByb2JlIHBkc192ZHBh
Cj4gKwo+ICsgIFBGX0JERj1gbHMgL3N5cy9tb2R1bGUvcGRzX2NvcmUvZHJpdmVycy9wY2lcOnBk
c19jb3JlLyovc3Jpb3ZfbnVtdmZzIHwgYXdrIC1GIC8gJ3twcmludCAkN30nYAo+ICsKPiArICAj
IEVuYWJsZSB2RFBBIFZGIGF1eGlsaWFyeSBkZXZpY2UocykgaW4gdGhlIFBGCj4gKyAgZGV2bGlu
ayBkZXYgcGFyYW0gc2V0IHBjaS8kUEZfQkRGIG5hbWUgZW5hYmxlX3ZuZXQgY21vZGUgcnVudGlt
ZSB2YWx1ZSB0cnVlCj4gKwo+ICsgICMgQ3JlYXRlIGEgVkYgZm9yIHZEUEEgdXNlCj4gKyAgZWNo
byAxID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvcGRzX2NvcmUvJFBGX0JERi9zcmlvdl9udW12ZnMK
PiArCj4gKyAgIyBGaW5kIHRoZSB2RFBBIHNlcnZpY2VzL2RldmljZXMgYXZhaWxhYmxlCj4gKyAg
UERTX1ZEUEFfTUdNVD1gdmRwYSBtZ210ZGV2IHNob3cgfCBncmVwIHZEUEEgfCBoZWFkIC0xIHwg
Y3V0IC1kOiAtZjFgCj4gKwo+ICsgICMgQ3JlYXRlIGEgdkRQQSBkZXZpY2UgZm9yIHVzZSBpbiB2
aXJ0aW8gbmV0d29yayBjb25maWd1cmF0aW9ucwo+ICsgIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGEx
IG1nbXRkZXYgJFBEU19WRFBBX01HTVQgbWFjIDAwOjExOjIyOjMzOjQ0OjU1Cj4gKwo+ICsgICMg
U2V0IHVwIGFuIGV0aGVybmV0IGludGVyZmFjZSBvbiB0aGUgdmRwYSBkZXZpY2UKPiArICBtb2Rw
cm9iZSB2aXJ0aW9fdmRwYQo+ICsKPiArCj4gKwo+ICtFbmFibGluZyB0aGUgZHJpdmVyCj4gKz09
PT09PT09PT09PT09PT09PT0KPiArCj4gK1RoZSBkcml2ZXIgaXMgZW5hYmxlZCB2aWEgdGhlIHN0
YW5kYXJkIGtlcm5lbCBjb25maWd1cmF0aW9uIHN5c3RlbSwKPiArdXNpbmcgdGhlIG1ha2UgY29t
bWFuZDo6Cj4gKwo+ICsgIG1ha2Ugb2xkY29uZmlnL21lbnVjb25maWcvZXRjLgo+ICsKPiArVGhl
IGRyaXZlciBpcyBsb2NhdGVkIGluIHRoZSBtZW51IHN0cnVjdHVyZSBhdDoKPiArCj4gKyAgLT4g
RGV2aWNlIERyaXZlcnMKPiArICAgIC0+IE5ldHdvcmsgZGV2aWNlIHN1cHBvcnQgKE5FVERFVklD
RVMgWz15XSkKPiArICAgICAgLT4gRXRoZXJuZXQgZHJpdmVyIHN1cHBvcnQKPiArICAgICAgICAt
PiBQZW5zYW5kbyBkZXZpY2VzCj4gKyAgICAgICAgICAtPiBQZW5zYW5kbyBFdGhlcm5ldCBQRFNf
VkRQQSBTdXBwb3J0Cj4gKwo+ICtTdXBwb3J0Cj4gKz09PT09PT0KPiArCj4gK0ZvciBnZW5lcmFs
IExpbnV4IG5ldHdvcmtpbmcgc3VwcG9ydCwgcGxlYXNlIHVzZSB0aGUgbmV0ZGV2IG1haWxpbmcK
PiArbGlzdCwgd2hpY2ggaXMgbW9uaXRvcmVkIGJ5IFBlbnNhbmRvIHBlcnNvbm5lbDo6Cj4gKwo+
ICsgIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKPiArCj4gK0ZvciBtb3JlIHNwZWNpZmljIHN1cHBv
cnQgbmVlZHMsIHBsZWFzZSB1c2UgdGhlIFBlbnNhbmRvIGRyaXZlciBzdXBwb3J0Cj4gK2VtYWls
OjoKPiArCj4gKyAgZHJpdmVyc0BwZW5zYW5kby5pbwo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvaW5kZXgucnN0IGIvRG9jdW1l
bnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdAo+IGlu
ZGV4IDQxN2NhNTE0YTRkMC4uOTRlY2I2N2MwODg1IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbmRleC5yc3QKPiArKysgYi9E
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvaW5kZXgucnN0
Cj4gQEAgLTE1LDYgKzE1LDcgQEAgQ29udGVudHM6Cj4gICAgIGFtYXpvbi9lbmEKPiAgICAgYWx0
ZXJhL2FsdGVyYV90c2UKPiAgICAgYW1kL3Bkc19jb3JlCj4gKyAgIGFtZC9wZHNfdmRwYQo+ICAg
ICBhcXVhbnRpYS9hdGxhbnRpYwo+ICAgICBjaGVsc2lvL2N4Z2IKPiAgICAgY2lycnVzL2NzODl4
MAo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXggZWJkMjZi
M2NhOTBlLi5jNTY1YjcxY2U1NmYgMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiArKysgYi9N
QUlOVEFJTkVSUwo+IEBAIC0yMjIwMCw2ICsyMjIwMCwxMCBAQCBTTkVUIERQVSBWSVJUSU8gREFU
QSBQQVRIIEFDQ0VMRVJBVE9SCj4gIFI6ICAgICBBbHZhcm8gS2Fyc3ogPGFsdmFyby5rYXJzekBz
b2xpZC1ydW4uY29tPgo+ICBGOiAgICAgZHJpdmVycy92ZHBhL3NvbGlkcnVuLwo+Cj4gK1BEUyBE
U0MgVklSVElPIERBVEEgUEFUSCBBQ0NFTEVSQVRPUgo+ICtSOiAgICAgU2hhbm5vbiBOZWxzb24g
PHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gK0Y6ICAgICBkcml2ZXJzL3ZkcGEvcGRzLwo+ICsK
PiAgVklSVElPIEJBTExPT04KPiAgTTogICAgICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVk
aGF0LmNvbT4KPiAgTTogICAgIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZyBiL2RyaXZlcnMvdmRwYS9LY29uZmln
Cj4gaW5kZXggY2Q2YWQ5MmYzZjA1Li4yZWUxYjI4ODY5MWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL0tjb25maWcKPiArKysgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+IEBAIC0xMTYsNCAr
MTE2LDEyIEBAIGNvbmZpZyBBTElCQUJBX0VOSV9WRFBBCj4gICAgICAgICAgIFRoaXMgZHJpdmVy
IGluY2x1ZGVzIGEgSFcgbW9uaXRvciBkZXZpY2UgdGhhdAo+ICAgICAgICAgICByZWFkcyBoZWFs
dGggdmFsdWVzIGZyb20gdGhlIERQVS4KPgo+ICtjb25maWcgUERTX1ZEUEEKPiArICAgICAgIHRy
aXN0YXRlICJ2RFBBIGRyaXZlciBmb3IgQU1EL1BlbnNhbmRvIERTQyBkZXZpY2VzIgo+ICsgICAg
ICAgZGVwZW5kcyBvbiBQRFNfQ09SRQoKTmVlZCB0byBzZWxlY3QgVklSVElPX1BDSV9MSUI/CgpU
aGFua3MKCj4gKyAgICAgICBoZWxwCj4gKyAgICAgICAgIHZEUEEgbmV0d29yayBkcml2ZXIgZm9y
IEFNRC9QZW5zYW5kbydzIFBEUyBDb3JlIGRldmljZXMuCj4gKyAgICAgICAgIFdpdGggdGhpcyBk
cml2ZXIsIHRoZSBWaXJ0SU8gZGF0YXBsYW5lIGNhbiBiZQo+ICsgICAgICAgICBvZmZsb2FkZWQg
dG8gYW4gQU1EL1BlbnNhbmRvIERTQyBkZXZpY2UuCj4gKwo+ICBlbmRpZiAjIFZEUEEKPiAtLQo+
IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
