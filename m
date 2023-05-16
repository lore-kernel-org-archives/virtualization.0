Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87410C7EE22
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 03:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD829417BA;
	Tue, 16 May 2023 03:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD829417BA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Db+M6leN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIiMuZaECVPn; Tue, 16 May 2023 03:30:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4CE841739;
	Tue, 16 May 2023 03:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4CE841739
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4AC4C0036;
	Tue, 16 May 2023 03:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E315C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 117B340BCB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 117B340BCB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Db+M6leN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zA460vPWw3R1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 258F840489
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 258F840489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684207808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyyXDgBCIDdmCinicR4vCNg8vFj4fP6c+Ugcp/1OuMg=;
 b=Db+M6leNfnBG3hTPb78jCSacYSVN+I6qEQGLXGzFMTxag1KjHDuQHyzs8TYa/tBBMdcSCu
 zIqG/gAR1K3x2A18TwmSDE8OO6RBaD0bFjNT1uCmKRS49Wj259fG+8qET45abunIjnw8sy
 oEg6G/XjcPPc3epWcY3/n9O1ldG8ZpE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-4bFnoyo9Md-iUlpPd7-Ycw-1; Mon, 15 May 2023 23:30:07 -0400
X-MC-Unique: 4bFnoyo9Md-iUlpPd7-Ycw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f38a1dfb07so170097e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684207805; x=1686799805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyyXDgBCIDdmCinicR4vCNg8vFj4fP6c+Ugcp/1OuMg=;
 b=lrD1HO1UyflxFFIBJ7JxH5HJlugUlVtZnDlRPx4yeWukq/SCWVfUTwziUiU6Rn2PhB
 atKHF7heKup0+Yp0fFFzG3vCDK0Q5Dw9wcNF47cW0LG+gkzZ+HOSab94XJj7adHpoDTj
 2xj3K0cdqtPEYrWpeNHAfEt4iiI+sfK0Pru1GReeVusFw8PxVBL9FQ+3CBfwV2f7SUVQ
 jBWJdcP43oVqBW1n0eVZM4bovHSl8dC1tA7+CqN5O9tENjyJKmN4fjeHtQ2Gq7zaUBej
 qJ584hKMMBYNjh1OYtzkb4Ro14WID1V7HWv7ODCD0HxwDNfvi3XJYcJiemvXJZeKEa2X
 UQ3g==
X-Gm-Message-State: AC+VfDxKxT7PXZy3hDoU9bs9ZtdtsV4Xa2sAnqoLpQA11wRCUmSk+PjO
 fzK3JT2uxCK7lDBc+EAL/gZgJaWZcsBGbVEDD3e2OLCpopQ1vxcGco73PUzlVsVhNu5X24H4waP
 suDnT6ld2FSUyw6tKk6z++ly3250X73gEfPZjSdDAAo6nmIiut8KU2fM1xw==
X-Received: by 2002:ac2:528c:0:b0:4eb:52c8:5ce0 with SMTP id
 q12-20020ac2528c000000b004eb52c85ce0mr6736955lfm.12.1684207805478; 
 Mon, 15 May 2023 20:30:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MK3Mi3Admnfq4O5YdXSIZMlnVO14BWtTmfpBzZHlr343EDVaSKWGF63IvhAluNvegcpthIQ8iwH26hf//+qk=
X-Received: by 2002:ac2:528c:0:b0:4eb:52c8:5ce0 with SMTP id
 q12-20020ac2528c000000b004eb52c85ce0mr6736947lfm.12.1684207805185; Mon, 15
 May 2023 20:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230516025521.43352-1-shannon.nelson@amd.com>
 <20230516025521.43352-12-shannon.nelson@amd.com>
In-Reply-To: <20230516025521.43352-12-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 11:29:54 +0800
Message-ID: <CACGkMEtFKSSFOAmoHJZE+0ZotR=GOA3y4sf8YbjJ=vR1rvyEBg@mail.gmail.com>
Subject: Re: [PATCH v6 virtio 11/11] pds_vdpa: pds_vdps.rst and Kconfig
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTA6NTbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBBZGQgdGhlIGRvY3VtZW50YXRpb24gYW5kIEtj
b25maWcgZW50cnkgZm9yIHBkc192ZHBhIGRyaXZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5u
b24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIC4uLi9kZXZpY2VfZHJpdmVy
cy9ldGhlcm5ldC9hbWQvcGRzX3ZkcGEucnN0ICB8IDg1ICsrKysrKysrKysrKysrKysrKysKPiAg
Li4uL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdCAgICAgICAgIHwgIDEgKwo+ICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArCj4gIGRy
aXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKwo+ICA0
IGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
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
MAo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4gaW5kZXggZTJmZDY0
YzJlYmRjLi5jM2Y1MDllZWFmMWQgMTAwNjQ0Cj4gLS0tIGEvTUFJTlRBSU5FUlMKPiArKysgYi9N
QUlOVEFJTkVSUwo+IEBAIC0yMjI5Niw2ICsyMjI5NiwxMCBAQCBGOiAgICAgaW5jbHVkZS9saW51
eC92cmluZ2guaAo+ICBGOiAgICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb18qLmgKPiAgRjog
ICAgIHRvb2xzL3ZpcnRpby8KPgo+ICtQRFMgRFNDIFZJUlRJTyBEQVRBIFBBVEggQUNDRUxFUkFU
T1IKPiArUjogICAgIFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ICtG
OiAgICAgZHJpdmVycy92ZHBhL3Bkcy8KPiArCj4gIFZJUlRJTyBDUllQVE8gRFJJVkVSCj4gIE06
ICAgICBHb25nbGVpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT4KPiAgTDogICAgIHZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9LY29uZmlnIGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiBpbmRleCBjZDZhZDkyZjNmMDUu
LjY1NmMxY2I1NDFkZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+ICsrKyBi
L2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gQEAgLTExNiw0ICsxMTYsMTQgQEAgY29uZmlnIEFMSUJB
QkFfRU5JX1ZEUEEKPiAgICAgICAgICAgVGhpcyBkcml2ZXIgaW5jbHVkZXMgYSBIVyBtb25pdG9y
IGRldmljZSB0aGF0Cj4gICAgICAgICAgIHJlYWRzIGhlYWx0aCB2YWx1ZXMgZnJvbSB0aGUgRFBV
Lgo+Cj4gK2NvbmZpZyBQRFNfVkRQQQo+ICsgICAgICAgdHJpc3RhdGUgInZEUEEgZHJpdmVyIGZv
ciBBTUQvUGVuc2FuZG8gRFNDIGRldmljZXMiCj4gKyAgICAgICBzZWxlY3QgVklSVElPX1BDSV9M
SUIKPiArICAgICAgIGRlcGVuZHMgb24gUENJX01TSQo+ICsgICAgICAgZGVwZW5kcyBvbiBQRFNf
Q09SRQo+ICsgICAgICAgaGVscAo+ICsgICAgICAgICB2RFBBIG5ldHdvcmsgZHJpdmVyIGZvciBB
TUQvUGVuc2FuZG8ncyBQRFMgQ29yZSBkZXZpY2VzLgo+ICsgICAgICAgICBXaXRoIHRoaXMgZHJp
dmVyLCB0aGUgVmlydElPIGRhdGFwbGFuZSBjYW4gYmUKPiArICAgICAgICAgb2ZmbG9hZGVkIHRv
IGFuIEFNRC9QZW5zYW5kbyBEU0MgZGV2aWNlLgo+ICsKPiAgZW5kaWYgIyBWRFBBCj4gLS0KPiAy
LjE3LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
