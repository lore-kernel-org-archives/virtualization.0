Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1782BE95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 06:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F04161133;
	Mon,  9 Oct 2023 06:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F04161133
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7uvfs72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrCheJxH6Hti; Mon,  9 Oct 2023 06:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0252260D77;
	Mon,  9 Oct 2023 06:39:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0252260D77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC694C0039;
	Mon,  9 Oct 2023 06:39:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AEA3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 06:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23D2A81447
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 06:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23D2A81447
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7uvfs72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ToPybf7yNejQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 06:39:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 380C281444
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 06:39:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 380C281444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvnO/n22PQxXlIkcz3AgTqPmh7n0aoPnNFBUSJHK9yA=;
 b=V7uvfs72HIAihBt5qUdm2gfSL8sPk0x/GtjhayNjwFk1MSBoMigRejAsn9x2pgoUJTvDaW
 h7Hw2emkWTbnP6o3gEfDVgeEwEJzrhIyhZE3Ip9+FZjZMnLTy8XHE66tUzULn+MK6OmOfb
 UuszGwbMS+0N8BmK+V4D5OhhTSvTQA8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597---t1njeLMAKoZiXyOTiZEw-1; Mon, 09 Oct 2023 02:39:49 -0400
X-MC-Unique: --t1njeLMAKoZiXyOTiZEw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5056cc81e30so3577579e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 23:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696833588; x=1697438388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvnO/n22PQxXlIkcz3AgTqPmh7n0aoPnNFBUSJHK9yA=;
 b=bsLq7B64AAen5dNOTuTShhBLQmkRzIJUoPW/M5dVNl59tAGXtvB3i3eer/49yT7ENl
 dT6T4PDht0anK6OvedlZ+ed143fJxEfCHN3F9SvSRTALbLT187GoNFf0Qc6MKQkH6hAf
 y1E5Amx9D3U9NkkvahB3KkK6kK2j7iKgKaktqyq1tYuRdLa07Q42taHf766gEUdANdBg
 4ytvvq4XccWHx7565M4VgahKAnib0x/oAnE6kjQ6Dd6JcvFulpGDGSNv6GOphzQfa5il
 rqPSGyqANCC3xjVY6wFZdL7MLBId0BLmHeTRtpwcpUQSjLpPEs/kAhsjOH9qtp8IXd4H
 4Xcg==
X-Gm-Message-State: AOJu0YyxTCyLt38VuQsXvHSWTXaxuMlGR0hF0ZWFTyRG0UmsDNbtoIlq
 LfctpS5ABDno8hOap6hZ0Z6H2y8Oy9VSBkkR6IP7PseNEHs7QfpJJ1bcyjx4XoG3NQmpKlM7hUu
 ON+3IhoiyYudge3hhLJwBM8rJ4NSL167SC1QzDZOO1U9uSZ+uyUL0X5u2Yg==
X-Received: by 2002:a19:7906:0:b0:503:3cc:cd39 with SMTP id
 u6-20020a197906000000b0050303cccd39mr8935724lfc.8.1696833588081; 
 Sun, 08 Oct 2023 23:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9g2cnceBAdSDWl6fXeO15stoCAkJ0V/vOyY78DevlBHKAFwm8a1POknf9dcOirlNw3Ehtu0JGjOiVYMzlHEI=
X-Received: by 2002:a19:7906:0:b0:503:3cc:cd39 with SMTP id
 u6-20020a197906000000b0050303cccd39mr8935712lfc.8.1696833587765; Sun, 08 Oct
 2023 23:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-10-dtatulea@nvidia.com>
 <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
 <c42db8942523afe8bbf54815f672acd9e47cfa67.camel@nvidia.com>
 <CACGkMEvZESDuOiX_oOvMUh0YqCWYqvmD3Ve9YEJW3+RXXyvGew@mail.gmail.com>
 <4f9759182636f7bb3cb15bc8b6ec6afbe0d6053d.camel@nvidia.com>
In-Reply-To: <4f9759182636f7bb3cb15bc8b6ec6afbe0d6053d.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Oct 2023 14:39:36 +0800
Message-ID: <CACGkMEvt5B_3i1wOs2yt0KmEYPpSMd_DRJ2==xzp9eMCwww4oQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr
 struct
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCA4OjA14oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCAyMDIzLTEwLTA4IGF0IDEyOjI1ICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMzoyMeKAr1BN
IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4g
T24gVHVlLCAyMDIzLTA5LTI2IGF0IDEyOjQ0ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4g
PiA+IE9uIFR1ZSwgU2VwIDEyLCAyMDIzIGF0IDk6MDLigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRh
dHVsZWFAbnZpZGlhLmNvbT4KPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGlz
IHBhdGNoIGFkYXB0cyB0aGUgbXIgY3JlYXRpb24vZGVsZXRpb24gY29kZSB0byBiZSBhYmxlIHRv
IHdvcmsgd2l0aAo+ID4gPiA+ID4gYW55IGdpdmVuIG1yIHN0cnVjdCBwb2ludGVyLiBBbGwgdGhl
IEFQSXMgYXJlIGFkYXB0ZWQgdG8gdGFrZSBhbiBleHRyYQo+ID4gPiA+ID4gcGFyYW1ldGVyIGZv
ciB0aGUgbXIuCj4gPiA+ID4gPgo+ID4gPiA+ID4gbWx4NV92ZHBhX2NyZWF0ZS9kZWxldGVfbXIg
ZG9lc24ndCBuZWVkIGEgQVNJRCBwYXJhbWV0ZXIgYW55bW9yZS4gVGhlCj4gPiA+ID4gPiBjaGVj
ayBpcyBkb25lIGluIHRoZSBjYWxsZXIgaW5zdGVhZCAobWx4NV9zZXRfbWFwKS4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBUaGlzIGNoYW5nZSBpcyBuZWVkZWQgZm9yIGEgZm9sbG93dXAgcGF0Y2ggd2hp
Y2ggd2lsbCBpbnRyb2R1Y2UgYW4KPiA+ID4gPiA+IGFkZGl0aW9uYWwgbXIgZm9yIHRoZSB2cSBk
ZXNjcmlwdG9yIGRhdGEuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29z
IFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPgo+ID4g
PiA+IFRoaW5raW5nIG9mIHRoaXMgZGVjb3VwbGluZyBJIHRoaW5rIEkgaGF2ZSBhIHF1ZXN0aW9u
Lgo+ID4gPiA+Cj4gPiA+ID4gV2UgYWR2ZXJ0aXNlIDIgYWRkcmVzcyBzcGFjZXMgYW5kIDIgZ3Jv
dXBzLiBTbyB3ZSBhY3R1YWxseSBkb24ndCBrbm93Cj4gPiA+ID4gZm9yIGV4YW1wbGUgd2hpY2gg
YWRkcmVzcyBzcGFjZXMgd2lsbCBiZSB1c2VkIGJ5IGR2cS4KPiA+ID4gPgo+ID4gPiA+IEFuZCBh
Y3R1YWxseSB3ZSBhbGxvdyB0aGUgdXNlciBzcGFjZSB0byBkbyBzb21ldGhpbmcgbGlrZQo+ID4g
PiA+Cj4gPiA+ID4gc2V0X2dyb3VwX2FzaWQoZHZxX2dyb3VwLCAwKQo+ID4gPiA+IHNldF9tYXAo
MCkKPiA+ID4gPiBzZXRfZ3JvdXBfYXNpZChkdnFfZ3JvdXAsIDEpCj4gPiA+ID4gc2V0X21hcCgx
KQo+ID4gPiA+Cj4gPiA+ID4gSSB3b25kZXIgaWYgdGhlIGRlY291cGxpbmcgbGlrZSB0aGlzIHBh
dGNoIGNhbiB3b3JrIGFuZCB3aHkuCj4gPiA+ID4KPiA+ID4gVGhpcyBzY2VuYXJpbyBjb3VsZCBp
bmRlZWQgd29yay4gRXNwZWNpYWxseSBpZiB5b3UgbG9vayBhdCB0aGUgMTMndGggcGF0Y2gKPiA+
ID4gWzBdCj4gPiA+IHdoZXJlIGh3IHN1cHBvcnQgaXMgYWRkZWQuIEFyZSB5b3Ugd29uZGVyaW5n
IGlmIHRoaXMgc2hvdWxkIHdvcmsgYXQgYWxsIG9yCj4gPiA+IGlmIGl0Cj4gPiA+IHNob3VsZCBi
ZSBibG9ja2VkPwo+ID4KPiA+IEl0IHdvdWxkIGJlIGdyZWF0IGlmIGl0IGNhbiB3b3JrIHdpdGgg
dGhlIGZvbGxvd2luZyBwYXRjaGVzLiBCdXQgYXQKPiA+IGxlYXN0IGZvciB0aGlzIHBhdGNoLCBp
dCBzZWVtcyBub3Q6Cj4gPgo+ID4gRm9yIGV4YW1wbGUsIHdoYXQgaGFwcGVucyBpZiB3ZSBzd2l0
Y2ggYmFjayB0byBncm91cCAwIGZvciBkdnE/Cj4gPgo+ID4gc2V0X2dyb3VwX2FzaWQoZHZxX2dy
b3VwLCAwKQo+ID4gc2V0X21hcCgwKQo+ID4gc2V0X2dyb3VwX2FzaWQoZHZxX2dyb3VwLCAxKQo+
ID4gc2V0X21hcCgxKQo+ID4gLy8gaGVyZSB3ZSBkZXN0cm95IHRoZSBtciBjcmVhdGVkIGZvciBh
c2lkIDAKPiA+IHNldF9ncm91cF9hc2lkKGR2cV9ncm91cCwgMCkKPiA+Cj4gSWYgYnkgZGVzdHJv
eSB5b3UgbWVhbiAucmVzZXQsCgpJdCdzIG5vdCByZXN0LiBEdXJpbmcgdGhlIHNlY29uZCBtYXAs
IHRoZSBtciBpcyBkZXN0cm95ZWQgYnkKbWx4NV92ZHBhX2NoYW5nZV9tYXAoKS4KCiBJIHRoaW5r
IGl0IHdvcmtzOiBEdXJpbmcgLnJlc2V0IHRoZSBtYXBwaW5nIGluCj4gQVNJRCAwIGlzIHJlc2V0
IGJhY2sgdG8gdGhlIERNQS9weXNpY2FsIG1hcCAobWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIpLiBB
bSBJCj4gbWlzc2luZyBzb21ldGhpbmc/Cj4KPiA+IEJ0dywgaWYgdGhpcyBpcyBhIG5ldyBpc3N1
ZSwgSSBoYXZlbid0IGNoZWNrZWQgd2hldGhlciBvciBub3QgaXQKPiA+IGV4aXN0cyBiZWZvcmUg
dGhpcyBzZXJpZXMgKGlmIHllcywgd2UgY2FuIGZpeCBvbiB0b3ApLgo+Cj4gPiA+Cj4gPiA+ID4g
SXQgbG9va3MgdG8gbWUgdGhlIG1vc3QgZWFzeSB3YXkgaXMgdG8gbGV0IGVhY2ggQVMgYmUgYmFj
a2VkIGJ5IGFuIE1SLgo+ID4gPiA+IFRoZW4gd2UgZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJv
dXQgdGhlIGR2cSwgY3ZxLgo+ID4gPiBUaGF0J3Mgd2hhdCB0aGlzIHBhdGNoIHNlcmllcyBkb3dl
cy4KPiA+Cj4gPiBHb29kIHRvIGtub3cgdGhpcywgSSB3aWxsIHJldmlldyB0aGUgc2VyaWVzLgo+
ID4KPiBJIHdhcyBwbGFubmluZyB0byBzcGluIGEgdjMgd2l0aCBFdWdlbmlvJ3Mgc3VnZ2VzdGlv
bnMuIFNob3VsZCBJIHdhaXQgZm9yIHlvdXIKPiBmZWVkYmFjayBiZWZvcmUgZG9pbmcgdGhhdD8K
CllvdSBjYW4gcG9zdCB2MyBhbmQgd2UgY2FuIG1vdmUgdGhlIGRpc2N1c3Npb24gdGhlcmUgaWYg
eW91IHdpc2guCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gRHJhZ29zCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
