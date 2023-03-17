Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AE3C6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B4C661410;
	Fri, 17 Mar 2023 03:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B4C661410
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0sDY3x/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MkPPdaH3NK1R; Fri, 17 Mar 2023 03:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B731E60AC0;
	Fri, 17 Mar 2023 03:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B731E60AC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81FBCC0035;
	Fri, 17 Mar 2023 03:54:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F932C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14744408CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14744408CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0sDY3x/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lFH6f9CZv1lU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:54:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AECD3408BA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AECD3408BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679025268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNiiXyLRN4+3GNHiN/Qpks6nZCViksZo2O1kEdEX10A=;
 b=a0sDY3x/jZraOrjidO8Fz47T0skM9Jso+FWqwFNPowg/1qxCjCcnR60+/HZ0T+CEVgiJFn
 zPAEUzsu8ba9T39QQarDea3UJLR8FJEhdLtfWyV/qCIM9GcBSxUPgTmoCyQOrxDi1k/QWk
 o6fh5LEzsSF30JOVmK3oSStfOGgSil8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-GPJJKGrVO6Ci5_UC5W9oSw-1; Thu, 16 Mar 2023 23:54:27 -0400
X-MC-Unique: GPJJKGrVO6Ci5_UC5W9oSw-1
Received: by mail-oi1-f198.google.com with SMTP id
 3-20020aca1003000000b003845588afd5so1759666oiq.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679025266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNiiXyLRN4+3GNHiN/Qpks6nZCViksZo2O1kEdEX10A=;
 b=oOTCZG8iD0lydmbGt8EHkcAebqucFTewzpfOCjjhloL0WPyxtAjjPiBQbq0VUoEXtF
 Wmq8AX0K97RZjhqzVO7/lR7PbLztMZU4L47UDFFPWxQd4j30Zi4ibpq75J4lcEUf5M/u
 dpQztjCcmC2VmfrV6qHX3UTJoSCHVIAU7zfx8f+GtkVnGvqRW5SevpA6tFasd8luBjGV
 0emJn3aRz39DR58dvx7F3zb8hZYUKMUZbEvMwFIGeof+j/OpCFhnNshXypAqbmxvlx5J
 dm0o1kNASAzFBEW4JlYZ8tp8oiqHdDU4AmKBeHompTacRkIc0JB/iNxgIYg3spwW+rhF
 zjWg==
X-Gm-Message-State: AO0yUKWDwVOGJZ2QZDT7E1geawoKj4pvKBPuCRLwLEBVXN0czCa714cU
 A1yerXGmrT+NEhqnECzgvQva2wSpPLAfwKdCN/TcFgBZXKiqpT5vdrF9xFXldBYhjASkKpFfebk
 jNHZCtwUNbOk2ruIlJ/eB9Zurrt9wJBB01JjPLJ3XibYlc+Bp2PPomjDMYA==
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id
 101-20020a9d016e000000b0069d23ff3316mr1465731otu.2.1679025266347; 
 Thu, 16 Mar 2023 20:54:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set9TBoaC44hcOch8wUd8zHnLW3Mu4+ivVVknKxv99iXX0ryv3uk7saIfBtW3eq4rsnehZdVhL0+R9NnKEhb7Jww=
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id
 101-20020a9d016e000000b0069d23ff3316mr1465721otu.2.1679025266080; Thu, 16 Mar
 2023 20:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230309013046.23523-1-shannon.nelson@amd.com>
 <20230309013046.23523-8-shannon.nelson@amd.com>
 <CACGkMEsuG98ASnuS2zjfro3ZkBhAr5KnhWYWqBkyT9ZzPvLXiw@mail.gmail.com>
 <fda7a918-342b-bdf9-7845-2863056290fc@amd.com>
In-Reply-To: <fda7a918-342b-bdf9-7845-2863056290fc@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:54:15 +0800
Message-ID: <CACGkMEtvgGvdB1VDyv=V36SQEw+cBrrq91vhcGtHCk1ZiwhcMg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 virtio 7/7] pds_vdpa: pds_vdps.rst and Kconfig
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMTE6MjXigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAzLzE1LzIzIDEyOjA1IEFNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVGh1LCBNYXIgOSwgMjAyMyBhdCA5OjMx4oCvQU0gU2hhbm5vbiBO
ZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gQWRkIHRoZSBk
b2N1bWVudGF0aW9uIGFuZCBLY29uZmlnIGVudHJ5IGZvciBwZHNfdmRwYSBkcml2ZXIuCj4gPj4K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNv
bT4KPiA+PiAtLS0KPiA+PiAgIC4uLi9ldGhlcm5ldC9wZW5zYW5kby9wZHNfdmRwYS5yc3QgICAg
ICAgICAgICB8IDg0ICsrKysrKysrKysrKysrKysrKysKPiA+PiAgIE1BSU5UQUlORVJTICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsKPiA+PiAgIGRyaXZlcnMvdmRwYS9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrCj4gPj4gICAzIGZpbGVzIGNo
YW5nZWQsIDk2IGluc2VydGlvbnMoKykKPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvcGVuc2FuZG8vcGRzX3Zk
cGEucnN0Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Rl
dmljZV9kcml2ZXJzL2V0aGVybmV0L3BlbnNhbmRvL3Bkc192ZHBhLnJzdCBiL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9wZW5zYW5kby9wZHNfdmRwYS5y
c3QKPiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDQx
ZjZkZDY2ZTNlCj4gPj4gLS0tIC9kZXYvbnVsbAo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vbmV0
d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9wZW5zYW5kby9wZHNfdmRwYS5yc3QKPiA+
PiBAQCAtMCwwICsxLDg0IEBACj4gPj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wKwo+ID4+ICsuLiBub3RlOiBjYW4gYmUgZWRpdGVkIGFuZCB2aWV3ZWQgd2l0aCAvdXNyL2Jp
bi9mb3JtaWtvLXZpbQo+ID4+ICsKPiA+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+ICtQQ0kgdkRQQSBkcml2ZXIgZm9yIHRo
ZSBBTUQvUGVuc2FuZG8oUikgRFNDIGFkYXB0ZXIgZmFtaWx5Cj4gPj4gKz09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+PiArCj4gPj4g
K0FNRC9QZW5zYW5kbyB2RFBBIFZGIERldmljZSBEcml2ZXIKPiA+PiArQ29weXJpZ2h0KGMpIDIw
MjMgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jCj4gPj4gKwo+ID4+ICtPdmVydmlldwo+ID4+
ICs9PT09PT09PQo+ID4+ICsKPiA+PiArVGhlIGBgcGRzX3ZkcGFgYCBkcml2ZXIgaXMgYW4gYXV4
aWxpYXJ5IGJ1cyBkcml2ZXIgdGhhdCBzdXBwbGllcwo+ID4+ICthIHZEUEEgZGV2aWNlIGZvciB1
c2UgYnkgdGhlIHZpcnRpbyBuZXR3b3JrIHN0YWNrLiAgSXQgaXMgdXNlZCB3aXRoCj4gPj4gK3Ro
ZSBQZW5zYW5kbyBWaXJ0dWFsIEZ1bmN0aW9uIGRldmljZXMgdGhhdCBvZmZlciB2RFBBIGFuZCB2
aXJ0aW8gcXVldWUKPiA+PiArc2VydmljZXMuICBJdCBkZXBlbmRzIG9uIHRoZSBgYHBkc19jb3Jl
YGAgZHJpdmVyIGFuZCBoYXJkd2FyZSBmb3IgdGhlIFBGCj4gPj4gK2FuZCBWRiBQQ0kgaGFuZGxp
bmcgYXMgd2VsbCBhcyBmb3IgZGV2aWNlIGNvbmZpZ3VyYXRpb24gc2VydmljZXMuCj4gPj4gKwo+
ID4+ICtVc2luZyB0aGUgZGV2aWNlCj4gPj4gKz09PT09PT09PT09PT09PT0KPiA+PiArCj4gPj4g
K1RoZSBgYHBkc192ZHBhYGAgZGV2aWNlIGlzIGVuYWJsZWQgdmlhIG11bHRpcGxlIGNvbmZpZ3Vy
YXRpb24gc3RlcHMgYW5kCj4gPj4gK2RlcGVuZHMgb24gdGhlIGBgcGRzX2NvcmVgYCBkcml2ZXIg
dG8gY3JlYXRlIGFuZCBlbmFibGUgU1ItSU9WIFZpcnR1YWwKPiA+PiArRnVuY3Rpb24gZGV2aWNl
cy4KPiA+PiArCj4gPj4gK1Nob3duIGJlbG93IGFyZSB0aGUgc3RlcHMgdG8gYmluZCB0aGUgZHJp
dmVyIHRvIGEgVkYgYW5kIGFsc28gdG8gdGhlCj4gPj4gK2Fzc29jaWF0ZWQgYXV4aWxpYXJ5IGRl
dmljZSBjcmVhdGVkIGJ5IHRoZSBgYHBkc19jb3JlYGAgZHJpdmVyLgo+ID4+ICsKPiA+PiArLi4g
Y29kZS1ibG9jazo6IGJhc2gKPiA+PiArCj4gPj4gKyAgIyEvYmluL2Jhc2gKPiA+PiArCj4gPj4g
KyAgbW9kcHJvYmUgcGRzX2NvcmUKPiA+PiArICBtb2Rwcm9iZSB2ZHBhCj4gPj4gKyAgbW9kcHJv
YmUgcGRzX3ZkcGEKPiA+PiArCj4gPj4gKyAgUEZfQkRGPWBncmVwIC1IICJ2RFBBLioxIiAvc3lz
L2tlcm5lbC9kZWJ1Zy9wZHNfY29yZS8qL3ZpZnR5cGVzIHwgaGVhZCAtMSB8IGF3ayAtRiAvICd7
cHJpbnQgJDZ9J2AKPiA+PiArCj4gPj4gKyAgIyBFbmFibGUgdkRQQSBWRiBhdXhpbGlhcnkgZGV2
aWNlKHMpIGluIHRoZSBQRgo+ID4+ICsgIGRldmxpbmsgZGV2IHBhcmFtIHNldCBwY2kvJFBGX0JE
RiBuYW1lIGVuYWJsZV92bmV0IHZhbHVlIHRydWUgY21vZGUgcnVudGltZQo+ID4+ICsKPiA+Cj4g
PiBEb2VzIHRoaXMgbWVhbiB3ZSBjYW4ndCBkbyBwZXIgVkYgY29uZmlndXJhdGlvbiBmb3IgdkRQ
QSBlbmFibGVtZW50Cj4gPiAoZS5nIFZGMCBmb3IgdmRwYSBWRjEgdG8gb3RoZXIgdHlwZSk/Cj4K
PiBGb3Igbm93LCB5ZXMsIGEgUEYgb25seSBzdXBwb3J0cyBvbmUgVkYgdHlwZSBhdCBhIHRpbWUu
ICBXZSd2ZSB0aG91Z2h0Cj4gYWJvdXQgcG9zc2liaWxpdGllcyBmb3Igc29tZSBoZXRlcm9nZW5l
b3VzIGNvbmZpZ3VyYXRpb25zLCBhbmQgdHJpZWQgdG8KPiBkbyBzb21lIHBsYW5uaW5nIGZvciBm
dXR1cmUgZmxleGliaWxpdHksIGJ1dCBvdXIgY3VycmVudCBuZWVkcyBkb24ndCBnbwo+IHRoYXQg
ZmFyLiAgSWYgYW5kIHdoZW4gd2UgZ2V0IHRoZXJlLCB3ZSBtaWdodCBsb29rIGF0IGhvdyBHdWF0
YW0ncyBncm91cAo+IGRpZCB0aGVpciBWRiBwZXJzb25hbGl0aWVzIGluIHRoZWlyIEVGMTAwIGRy
aXZlciwgb3Igc29tZSBvdGhlcgo+IHBvc3NpYmlsaXRpZXMuCgpUaGF0J3MgZmluZS4KCgo+Cj4g
VGhhbmtzIGZvciBsb29raW5nIHRocm91Z2ggdGhlc2UsIEkgYXBwcmVjaWF0ZSB5b3VyIHRpbWUg
YW5kIGNvbW1lbnRzLgoKWW91IGFyZSB3ZWxjb21lLgoKVGhhbmtzCgo+Cj4gc2xuCj4KPgo+ID4K
PiA+IFRoYW5rcwo+ID4KPiA+Cj4gPj4gKyAgIyBDcmVhdGUgYSBWRiBmb3IgdkRQQSB1c2UKPiA+
PiArICBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvZHJpdmVycy9wZHNfY29yZS8kUEZfQkRGL3NyaW92
X251bXZmcwo+ID4+ICsKPiA+PiArICAjIEZpbmQgdGhlIHZEUEEgc2VydmljZXMvZGV2aWNlcyBh
dmFpbGFibGUKPiA+PiArICBQRFNfVkRQQV9NR01UPWB2ZHBhIG1nbXRkZXYgc2hvdyB8IGdyZXAg
dkRQQSB8IGhlYWQgLTEgfCBjdXQgLWQ6IC1mMWAKPiA+PiArCj4gPj4gKyAgIyBDcmVhdGUgYSB2
RFBBIGRldmljZSBmb3IgdXNlIGluIHZpcnRpbyBuZXR3b3JrIGNvbmZpZ3VyYXRpb25zCj4gPj4g
KyAgdmRwYSBkZXYgYWRkIG5hbWUgdmRwYTEgbWdtdGRldiAkUERTX1ZEUEFfTUdNVCBtYWMgMDA6
MTE6MjI6MzM6NDQ6NTUKPiA+PiArCj4gPj4gKyAgIyBTZXQgdXAgYW4gZXRoZXJuZXQgaW50ZXJm
YWNlIG9uIHRoZSB2ZHBhIGRldmljZQo+ID4+ICsgIG1vZHByb2JlIHZpcnRpb192ZHBhCj4gPj4g
Kwo+ID4+ICsKPiA+PiArCj4gPj4gK0VuYWJsaW5nIHRoZSBkcml2ZXIKPiA+PiArPT09PT09PT09
PT09PT09PT09PQo+ID4+ICsKPiA+PiArVGhlIGRyaXZlciBpcyBlbmFibGVkIHZpYSB0aGUgc3Rh
bmRhcmQga2VybmVsIGNvbmZpZ3VyYXRpb24gc3lzdGVtLAo+ID4+ICt1c2luZyB0aGUgbWFrZSBj
b21tYW5kOjoKPiA+PiArCj4gPj4gKyAgbWFrZSBvbGRjb25maWcvbWVudWNvbmZpZy9ldGMuCj4g
Pj4gKwo+ID4+ICtUaGUgZHJpdmVyIGlzIGxvY2F0ZWQgaW4gdGhlIG1lbnUgc3RydWN0dXJlIGF0
Ogo+ID4+ICsKPiA+PiArICAtPiBEZXZpY2UgRHJpdmVycwo+ID4+ICsgICAgLT4gTmV0d29yayBk
ZXZpY2Ugc3VwcG9ydCAoTkVUREVWSUNFUyBbPXldKQo+ID4+ICsgICAgICAtPiBFdGhlcm5ldCBk
cml2ZXIgc3VwcG9ydAo+ID4+ICsgICAgICAgIC0+IFBlbnNhbmRvIGRldmljZXMKPiA+PiArICAg
ICAgICAgIC0+IFBlbnNhbmRvIEV0aGVybmV0IFBEU19WRFBBIFN1cHBvcnQKPiA+PiArCj4gPj4g
K1N1cHBvcnQKPiA+PiArPT09PT09PQo+ID4+ICsKPiA+PiArRm9yIGdlbmVyYWwgTGludXggbmV0
d29ya2luZyBzdXBwb3J0LCBwbGVhc2UgdXNlIHRoZSBuZXRkZXYgbWFpbGluZwo+ID4+ICtsaXN0
LCB3aGljaCBpcyBtb25pdG9yZWQgYnkgUGVuc2FuZG8gcGVyc29ubmVsOjoKPiA+PiArCj4gPj4g
KyAgbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+ID4+ICsKPiA+PiArRm9yIG1vcmUgc3BlY2lmaWMg
c3VwcG9ydCBuZWVkcywgcGxlYXNlIHVzZSB0aGUgUGVuc2FuZG8gZHJpdmVyIHN1cHBvcnQKPiA+
PiArZW1haWw6Ogo+ID4+ICsKPiA+PiArICBkcml2ZXJzQHBlbnNhbmRvLmlvCj4gPj4gZGlmZiAt
LWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiA+PiBpbmRleCBjYjIxZGNkM2EwMmEu
LmRhOTgxYzViYzgzMCAxMDA2NDQKPiA+PiAtLS0gYS9NQUlOVEFJTkVSUwo+ID4+ICsrKyBiL01B
SU5UQUlORVJTCj4gPj4gQEAgLTIyMTIwLDYgKzIyMTIwLDEwIEBAIFNORVQgRFBVIFZJUlRJTyBE
QVRBIFBBVEggQUNDRUxFUkFUT1IKPiA+PiAgIFI6ICAgICBBbHZhcm8gS2Fyc3ogPGFsdmFyby5r
YXJzekBzb2xpZC1ydW4uY29tPgo+ID4+ICAgRjogICAgIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi8K
PiA+Pgo+ID4+ICtQRFMgRFNDIFZJUlRJTyBEQVRBIFBBVEggQUNDRUxFUkFUT1IKPiA+PiArUjog
ICAgIFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4+ICtGOiAgICAg
ZHJpdmVycy92ZHBhL3Bkcy8KPiA+PiArCj4gPj4gICBWSVJUSU8gQkFMTE9PTgo+ID4+ICAgTTog
ICAgICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KPiA+PiAgIE06ICAgICBE
YXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL0tjb25maWcgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+ID4+IGluZGV4IGNkNmFk
OTJmM2YwNS4uYzkxMGNiMTE5YzFiIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS9LY29u
ZmlnCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiA+PiBAQCAtMTE2LDQgKzExNiwx
MiBAQCBjb25maWcgQUxJQkFCQV9FTklfVkRQQQo+ID4+ICAgICAgICAgICAgVGhpcyBkcml2ZXIg
aW5jbHVkZXMgYSBIVyBtb25pdG9yIGRldmljZSB0aGF0Cj4gPj4gICAgICAgICAgICByZWFkcyBo
ZWFsdGggdmFsdWVzIGZyb20gdGhlIERQVS4KPiA+Pgo+ID4+ICtjb25maWcgUERTX1ZEUEEKPiA+
PiArICAgICAgIHRyaXN0YXRlICJ2RFBBIGRyaXZlciBmb3IgQU1EL1BlbnNhbmRvIERTQyBkZXZp
Y2VzIgo+ID4+ICsgICAgICAgZGVwZW5kcyBvbiBQRFNfQ09SRQo+ID4+ICsgICAgICAgaGVscAo+
ID4+ICsgICAgICAgICBWRFBBIG5ldHdvcmsgZHJpdmVyIGZvciBBTUQvUGVuc2FuZG8ncyBQRFMg
Q29yZSBkZXZpY2VzLgo+ID4+ICsgICAgICAgICBXaXRoIHRoaXMgZHJpdmVyLCB0aGUgVmlydElP
IGRhdGFwbGFuZSBjYW4gYmUKPiA+PiArICAgICAgICAgb2ZmbG9hZGVkIHRvIGFuIEFNRC9QZW5z
YW5kbyBEU0MgZGV2aWNlLgo+ID4+ICsKPiA+PiAgIGVuZGlmICMgVkRQQQo+ID4+IC0tCj4gPj4g
Mi4xNy4xCj4gPj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
