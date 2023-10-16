Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F9CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 06:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C79B6101D;
	Mon, 16 Oct 2023 06:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C79B6101D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpjGzhL9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lcQbhzu_cT3c; Mon, 16 Oct 2023 06:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3187260BEC;
	Mon, 16 Oct 2023 06:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3187260BEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 059EDC0071;
	Mon, 16 Oct 2023 06:33:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF74C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 06:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 294E181CAD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 06:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 294E181CAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpjGzhL9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tbceveOVxj-J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 06:33:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FAAD81584
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 06:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FAAD81584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIO4upB/BF6e1PX85KFwo9jmaAkfIMsZHKTqfiZlcqM=;
 b=BpjGzhL9c9Lpd8AjydBwkcahoGHnN6NrdsLiFArZGP0/pNq/aeZpdnr879vV/WMB/4Cbaq
 jX4+UF5VHJpVDXD7eDVI9vae+PYK0KQiiRRyqlW/bsu+BQH7A1ylzAO5ubnr7n5QZvUcCP
 5Wxy8b89sR2Iwz1KyrPKKCFK+EfmgU8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-5AAB8YwWNHKOWHYqFix4iQ-1; Mon, 16 Oct 2023 02:33:11 -0400
X-MC-Unique: 5AAB8YwWNHKOWHYqFix4iQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079a8c68c6so2494013e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Oct 2023 23:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437990; x=1698042790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIO4upB/BF6e1PX85KFwo9jmaAkfIMsZHKTqfiZlcqM=;
 b=JsbqAR9LwuuWDg3h3LR1iU/dwhO8nZd37vfP6oi0CyEDNPHix0dJ3A8ZEzPnOXQ5b4
 VJpw7Af4pB375KBFmNvmT1xyuoy+W2h+lwo6BZA16O0AM8U6spEM/a+e+Zf8/VfOirSq
 82r29QdiY899nAbGdTomxut7s7hVPvxxfSlT8j6MmWCdPRvFMggGOcfbNMjROC9/a/nc
 wPa4jKgeu/CJX2W8aItqixG14YbgnJv3As7ok/MWs8B9/jMBK2JLlr7ar8DS6hpWISpz
 UjL0h2QLqWAy+r0FqY8oAd4B0IyCe97S2ylvDWDWOyhKyURY7L0qK9quVLgKBQvPq9lH
 ZLOw==
X-Gm-Message-State: AOJu0YzH2cHgxFFMyXJwe2OOi3e1QgREGHhDN6Rklz3ZAsFBdRp8hvRe
 nPo1DASX9jqL1nvpXuFTep54QnCf9sTOchcvJh6yerOxXIrw9cC76+OFta7j1LcfsIoCPKRJFMx
 X644n2Dpi0aHAXHzYY/hZlRyNo9W3n+GS/oaZH8q5igPR6l5iKBc9Woj5yg==
X-Received: by 2002:ac2:4bce:0:b0:503:1722:bf3a with SMTP id
 o14-20020ac24bce000000b005031722bf3amr31051861lfq.1.1697437989909; 
 Sun, 15 Oct 2023 23:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf+okbHXZCetyLViIwBUNQtjMg4ABshwSuCPClAVcR8pYJDLEG5PO/UXZu3YXSOWb3p14YEHoLnqVCYU77CA8=
X-Received: by 2002:ac2:4bce:0:b0:503:1722:bf3a with SMTP id
 o14-20020ac24bce000000b005031722bf3amr31051849lfq.1.1697437989582; Sun, 15
 Oct 2023 23:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
In-Reply-To: <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Oct 2023 14:32:58 +0800
Message-ID: <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMzozNuKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMTAvMTIvMjAyMyA4OjAxIFBNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPj4gRGV2aWNlcyB3aXRoIG9uLWNo
aXAgSU9NTVUgb3IgdmVuZG9yIHNwZWNpZmljIElPVExCIGltcGxlbWVudGF0aW9uCj4gPj4gbWF5
IG5lZWQgdG8gcmVzdG9yZSBpb3RsYiBtYXBwaW5nIHRvIHRoZSBpbml0aWFsIG9yIGRlZmF1bHQg
c3RhdGUKPiA+PiB1c2luZyB0aGUgLnJlc2V0X21hcCBvcCwgYXMgaXQncyBkZXNpcmFibGUgZm9y
IHNvbWUgcGFyZW50IGRldmljZXMKPiA+PiB0byBzb2xlbHkgbWFuaXB1bGF0ZSBtYXBwaW5ncyBi
eSBpdHMgb3duLCBpbmRlcGVuZGVudCBvZiB2aXJ0aW8gZGV2aWNlCj4gPj4gc3RhdGUuIEZvciBp
bnN0YW5jZSwgZGV2aWNlIHJlc2V0IGRvZXMgbm90IGNhdXNlIG1hcHBpbmcgZ28gYXdheSBvbgo+
ID4+IHN1Y2ggSU9UTEIgbW9kZWwgaW4gbmVlZCBvZiBwZXJzaXN0ZW50IG1hcHBpbmcuIEJlZm9y
ZSB2aG9zdC12ZHBhCj4gPj4gaXMgZ29pbmcgYXdheSwgZ2l2ZSB0aGVtIGEgY2hhbmNlIHRvIHJl
c2V0IGlvdGxiIGJhY2sgdG8gdGhlIGluaXRpYWwKPiA+PiBzdGF0ZSBpbiB2aG9zdF92ZHBhX2Ns
ZWFudXAoKS4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTYgKysr
KysrKysrKysrKysrKwo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPiA+
Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gPj4gaW5kZXggODUxNTM1Zi4uYTNmODE2MCAxMDA2NDQKPiA+PiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+ID4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4gQEAg
LTEzMSw2ICsxMzEsMTUgQEAgc3RhdGljIHN0cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBh
X2ZpbmRfYWxsb2NfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPj4gICAgICAgICAgcmV0dXJu
IHZob3N0X3ZkcGFfYWxsb2NfYXModiwgYXNpZCk7Cj4gPj4gICB9Cj4gPj4KPiA+PiArc3RhdGlj
IHZvaWQgdmhvc3RfdmRwYV9yZXNldF9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lk
KQo+ID4+ICt7Cj4gPj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBh
Owo+ID4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+
Y29uZmlnOwo+ID4+ICsKPiA+PiArICAgICAgIGlmIChvcHMtPnJlc2V0X21hcCkKPiA+PiArICAg
ICAgICAgICAgICAgb3BzLT5yZXNldF9tYXAodmRwYSwgYXNpZCk7Cj4gPj4gK30KPiA+PiArCj4g
Pj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2
LCB1MzIgYXNpZCkKPiA+PiAgIHsKPiA+PiAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAq
YXMgPSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+ID4+IEBAIC0xNDAsNiArMTQ5LDEzIEBAIHN0YXRp
YyBpbnQgdmhvc3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lk
KQo+ID4+Cj4gPj4gICAgICAgICAgaGxpc3RfZGVsKCZhcy0+aGFzaF9saW5rKTsKPiA+PiAgICAg
ICAgICB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKHYsICZhcy0+aW90bGIsIDBVTEwsIDBVTEwgLSAx
LCBhc2lkKTsKPiA+PiArICAgICAgIC8qCj4gPj4gKyAgICAgICAgKiBEZXZpY2VzIHdpdGggdmVu
ZG9yIHNwZWNpZmljIElPTU1VIG1heSBuZWVkIHRvIHJlc3RvcmUKPiA+PiArICAgICAgICAqIGlv
dGxiIHRvIHRoZSBpbml0aWFsIG9yIGRlZmF1bHQgc3RhdGUgd2hpY2ggaXMgbm90IGRvbmUKPiA+
PiArICAgICAgICAqIHRocm91Z2ggZGV2aWNlIHJlc2V0LCBhcyB0aGUgSU9UTEIgbWFwcGluZyBt
YW5pcHVsYXRpb24KPiA+PiArICAgICAgICAqIGNvdWxkIGJlIGRlY291cGxlZCBmcm9tIHRoZSB2
aXJ0aW8gZGV2aWNlIGxpZmUgY3ljbGUuCj4gPj4gKyAgICAgICAgKi8KPiA+IFNob3VsZCB3ZSBk
byB0aGlzIGFjY29yZGluZyB0byB3aGV0aGVyIElPVExCX1BSRVNJU1QgaXMgc2V0Pwo+IFdlbGws
IGluIHRoZW9yeSB0aGlzIHNlZW1zIGxpa2Ugc28gYnV0IGl0J3MgdW5uZWNlc3NhcnkgY29kZSBj
aGFuZ2UKPiBhY3R1YWxseSwgYXMgdGhhdCBpcyB0aGUgd2F5IGhvdyB2RFBBIHBhcmVudCBiZWhp
bmQgcGxhdGZvcm0gSU9NTVUgd29ya3MKPiB0b2RheSwgYW5kIHVzZXJzcGFjZSBkb2Vzbid0IGJy
ZWFrIGFzIG9mIHRvZGF5LiA6KQoKV2VsbCwgdGhpcyBpcyBvbmUgcXVlc3Rpb24gSSd2ZSBldmVy
IGFza2VkIGJlZm9yZS4gWW91IGhhdmUgZXhwbGFpbmVkCnRoYXQgb25lIG9mIHRoZSByZWFzb24g
dGhhdCB3ZSBkb24ndCBicmVhayB1c2Vyc3BhY2UgaXMgdGhhdCB0aGV5IG1heQpjb3VwbGUgSU9U
TEIgcmVzZXQgd2l0aCB2RFBBIHJlc2V0IGFzIHdlbGwuIE9uZSBleGFtcGxlIGlzIHRoZSBRZW11
LgoKPgo+IEFzIGV4cGxhaW5lZCBpbiBwcmV2aW91cyB0aHJlYWRzIFsxXVsyXSwgd2hlbiBJT1RM
Ql9QRVJTSVNUIGlzIG5vdCBzZXQKPiBpdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IG1lYW4gdGhlIGlv
dGxiIHdpbGwgZGVmaW5pdGVseSBiZSBkZXN0cm95ZWQKPiBhY3Jvc3MgcmVzZXQgKHRoaW5rIGFi
b3V0IHRoZSBwbGF0Zm9ybSBJT01NVSBjYXNlKSwgc28gdXNlcnNwYWNlIHRvZGF5Cj4gaXMgYWxy
ZWFkeSB0b2xlcmF0aW5nIGVub3VnaCB3aXRoIGVpdGhlciBnb29kIG9yIGJhZCBJT01NVS4gVGhp
cyBjb2RlIG9mCj4gbm90IGNoZWNraW5nIElPVExCX1BFUlNJU1QgYmVpbmcgc2V0IGlzIGludGVu
dGlvbmFsLCB0aGVyZSdzIG5vIHBvaW50IHRvCj4gZW11bGF0ZSBiYWQgSU9NTVUgYmVoYXZpb3Ig
ZXZlbiBmb3Igb2xkZXIgdXNlcnNwYWNlICh3aXRoIGltcHJvcGVyCj4gZW11bGF0aW9uIHRvIGJl
IGRvbmUgaXQgd291bGQgcmVzdWx0IGluIGV2ZW4gd29yc2UgcGVyZm9ybWFuY2UpLgoKRm9yIHR3
byByZWFzb25zOgoKMSkgYmFja2VuZCBmZWF0dXJlcyBuZWVkIGFja2VkIGJ5IHVzZXJzcGFjZSB0
aGlzIGlzIGJ5IGRlc2lnbgoyKSBrZWVwIHRoZSBvZGQgYmVoYXZpb3VyIHNlZW1zIHRvIGJlIG1v
cmUgc2FmZSBhcyB3ZSBjYW4ndCBhdWRpdApldmVyeSB1c2Vyc3BhY2UgcHJvZ3JhbQoKVGhhbmtz
Cgo+IEkgdGhpbmsKPiB0aGUgcHVycG9zZSBvZiB0aGUgSU9UTEJfUEVSU0lTVCBmbGFnIGlzIGp1
c3QgdG8gZ2l2ZSB1c2Vyc3BhY2UgMTAwJQo+IGNlcnRhaW50eSBvZiBwZXJzaXN0ZW50IGlvdGxi
IG1hcHBpbmcgbm90IGdldHRpbmcgbG9zdCBhY3Jvc3MgdmRwYSByZXNldC4KPgo+IFRoYW5rcywK
PiAtU2l3ZWkKPgo+IFsxXQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9u
LzlmMTE4ZmM5LTRmNmYtZGQ2Ny1hMjkxLWJlNzgxNTJlNDdmZEBvcmFjbGUuY29tLwo+IFsyXQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzMzNjRhZGZkLTFlYjctOGJj
ZS00MWY5LWJmZTU0NzNmMWYyZUBvcmFjbGUuY29tLwo+ID4gICBPdGhlcndpc2UKPiA+IHdlIG1h
eSBicmVhayBvbGQgdXNlcnNwYWNlLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+PiArICAgICAgIHZo
b3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+ID4+ICAgICAgICAgIGtmcmVlKGFzKTsKPiA+
Pgo+ID4+ICAgICAgICAgIHJldHVybiAwOwo+ID4+IC0tCj4gPj4gMS44LjMuMQo+ID4+Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
