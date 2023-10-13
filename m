Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C57BCDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 01:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C299541EF3;
	Fri, 13 Oct 2023 01:31:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C299541EF3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FI3lIh+s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UyKEFk8XfjgY; Fri, 13 Oct 2023 01:31:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33BE34151B;
	Fri, 13 Oct 2023 01:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33BE34151B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 044A3C0071;
	Fri, 13 Oct 2023 01:31:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC55C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D0CE81D34
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D0CE81D34
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FI3lIh+s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rVBs2dHJ5XeS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:31:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1E5A81D2D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1E5A81D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697160691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfWYWAwCX7LJ7OAKx05DbET8kNiueRfh4oxLj+++dOo=;
 b=FI3lIh+sdQrcoQJ2TfngPuX3mvTkQ9cPp4s7m0+KJFZ6anPcexTMs8hSEEy4RW38SrEGj/
 TCoEIPFOvoHeinQrPxb/flVwpBdjNGF/aGYP9GozhD1QI++nZ/Y3980s9VWsh3yqsnzf3o
 DFOGuclO9lp+H8uf6rVuMgnQoIDhFDs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-u9adySDbMQiTN6WPkYXt_A-1; Thu, 12 Oct 2023 21:31:29 -0400
X-MC-Unique: u9adySDbMQiTN6WPkYXt_A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50796a717f7so670714e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 18:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697160688; x=1697765488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfWYWAwCX7LJ7OAKx05DbET8kNiueRfh4oxLj+++dOo=;
 b=cc8k8t29XOA/sj2MqO6R1jYuDvLFVcM/HaaSq1ymBVQpeM746QSnezO3Urz8sRN7Od
 MXIhJ/welZ+3M3s9c1yOSAcsxtnUm3LTTglQVe1uVRf9HI5725KOEh2vofxNH4NaIdsf
 g71rj3YVW3vIjpCZKNXUM+6ZGcKgDLE+u/KYLdlp/J/46PKXmtPxREb8X3Int4oH1FJ3
 fAMzBOIJiyVKSGTcaaKhDpHNVqL0Ergq3eD65qsBur6/0yGXEuV4Ng0DPQBHLmahm0ow
 vgCxvGgYZM48NhQGwQ8ktJg97hTbAReLRav6yAoS3QCQ4oQQCGw3LKW2Xtcx67HJySF/
 G2Lw==
X-Gm-Message-State: AOJu0YyttaHm/RFc1aARRTdXNrJ69tb2eZne5k9PsqAQesF2pXTJFBna
 CKDfPrAIXr2ZCM5pSeqxpeJQUxBQ8SLYRPbZM2Oe0JCpkNlxoHzTQPxwNbtvE5jXjNiD2mf2MSG
 0sJ1dWxhW5SaBL1FNoS4Mp37IYjx/CZWtUbve+0ViMNhitCI1e5xbinDnnQ==
X-Received: by 2002:a05:6512:3146:b0:500:bbd4:970f with SMTP id
 s6-20020a056512314600b00500bbd4970fmr19077678lfi.5.1697160688436; 
 Thu, 12 Oct 2023 18:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm1Sao7Yt+CcRynBtPZliOxHabGNUJFfz92I/8ZDwhyjn0eXdi7dihdQ5XKlXPUKWjmN1lzFK6qNBYcZqEXcM=
X-Received: by 2002:a05:6512:3146:b0:500:bbd4:970f with SMTP id
 s6-20020a056512314600b00500bbd4970fmr19077668lfi.5.1697160688096; Thu, 12 Oct
 2023 18:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <a8dadf64-7723-926d-290f-945df04df194@linux.alibaba.com>
 <CACGkMEswHqyR0F3K9wibgEyKDh=7T6=93ZUKgAnNZsOZnu4KsA@mail.gmail.com>
 <b51b8498-c7de-2946-fee2-beee058e1e41@linux.alibaba.com>
In-Reply-To: <b51b8498-c7de-2946-fee2-beee058e1e41@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 09:31:17 +0800
Message-ID: <CACGkMEu4G3_w6qHLo_baRjpt7E_JBh49JnGu-qqwgqFmAzuQGQ@mail.gmail.com>
Subject: Re: Report a possible vhost bug in stable branches
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org,
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgNjo0NOKAr1BNIFhpYW50aW5nIFRpYW4KPHhpYW50aW5n
LnRpYW5AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMy8xMC8xMiDkuIvl
jYgzOjU1LCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+IE9uIFRodSwgT2N0IDEyLCAyMDIzIGF0IDk6
NDPigK9BTSBYaWFudGluZyBUaWFuCj4gPiA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPj4gY2dyb3VwIGF0dGFjaCB3b3JrIGFuZCBkZXYgZmx1c2ggd29yayB3aWxs
IGJvdGggYmUgYWRkZWQgdG8gZGV2IHdvcmsKPiA+PiBsaXN0IGluIHZob3N0X2F0dGFjaF9jZ3Jv
dXBzKCkgd2hlbiBzZXQgZGV2IG93bmVyOgo+ID4+ICAgICAgICAgICAgICAgc3RhdGljIGludCB2
aG9zdF9hdHRhY2hfY2dyb3VwcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPj4gICAgICAgICAg
ICAgICB7Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9hdHRhY2hfY2dy
b3Vwc19zdHJ1Y3QgYXR0YWNoOwo+ID4+Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgIGF0dGFj
aC5vd25lciA9IGN1cnJlbnQ7Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3dvcmtf
aW5pdCgmYXR0YWNoLndvcmssCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZob3N0X2F0dGFjaF9jZ3JvdXBzX3dvcmspOwo+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICB2aG9zdF93b3JrX3F1ZXVlKGRldiwgJmF0dGFjaC53b3JrKTsgLy8gYWRkIGNncm91cAo+ID4+
IGF0dGFjaCB3b3JrCj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3dvcmtfZGV2X2Zs
dXNoKGRldik7ICAgICAgICAgICAvLyBhZGQgZGV2Cj4gPj4gZmx1c2ggd29yawo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gYXR0YWNoLnJldDsKPiA+PiAgICAgICAgICAgICAgIH0K
PiA+Pgo+ID4+ICAgICBBbmQgZGV2IGt3b3JrZXIgd2lsbCBiZSB3YWtlbiB1cCB0byBoYW5kbGUg
dGhlIHR3byB3b3JrcyBpbgo+ID4+IHZob3N0X3dvcmtlcigpOgo+ID4+ICAgICAgICAgICAgICAg
bm9kZSA9IGxsaXN0X2RlbF9hbGwoJmRldi0+d29ya19saXN0KTsKPiA+PiAgICAgICAgICAgICAg
IG5vZGUgPSBsbGlzdF9yZXZlcnNlX29yZGVyKG5vZGUpOwo+ID4+ICAgICAgICAgICAgICAgbGxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZXsKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgd29yay0+
Zm4od29yayk7Cj4gPj4gICAgICAgICAgICAgICB9Cj4gPj4KPiA+PiAgICAgQXMgdGhlIGxpc3Qg
aXMgcmV2ZXJzZWQgYmVmb3JlIHByb2Nlc3NpbmcgaW4gdmhvc3Rfd29ya2VyKCksIHNvIGl0IGlz
Cj4gPj4gcG9zc2libGUKPiA+PiAgICAgdGhhdCBkZXYgZmx1c2ggd29yayBpcyBwcm9jZXNzZWQg
YmVmb3JlIGNncm91cCBhdHRhY2ggd29yay4KPiA+IFRoaXMgc291bmRzIHdlaXJkLiBJdCdzIGxs
aXN0IG5vdCBsaXN0IHNvIHdoZW4gYWRkaW5nIHRoZSBuZXcgZW50cnkKPiA+IHdhcyBhZGRlZCB0
byB0aGUgaGVhZCB0aGF0IHdoeSB3ZSBuZWVkIGxsaXN0X3JldmVyc2Vfb3JkZXIoKSB0bwo+ID4g
cmVjb3ZlciB0aGUgb3JkZXIuCj4gPgo+ID4gICBIYXZlIHlvdSBldmVyIHJlcHJvZHVjZWQgdGhl
c2UgaXNzdWVzPwo+Cj4gU29ycnkgZm9yIHRoZSBkaXN0dXJiLCBObyBpc3N1ZSBub3cuCj4KPiBJ
dCBjYXVzZWQgYnkgb3VyIGludGVybmFsIGNoYW5nZXMuCgpJZiBpdCdzIGFuIG9wdGltaXphdGlv
biBvciBmZWF0dXJlcywgeW91IGFyZSB3ZWxjb21lZCB0byBwb3N0IHRoZW0uCgpEZXZlbG9waW5n
IG5ldyBmZWF0dXJlcyB1cHN0cmVhbSBoYXMgYSBsb3Qgb2YgYmVuZWZpdHMuCgpUaGFua3MKCgo+
Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4+IElmIHNvLAo+ID4+IHZob3N0X2F0dGFjaF9jZ3JvdXBz
Cj4gPj4gICAgIG1heSByZXR1cm4gImF0dGFjaC5yZXQiIGJlZm9yZSBjZ3JvdXAgYXR0YWNoIHdv
cmsgaXMgaGFuZGxlZCwgYnV0Cj4gPj4gImF0dGFjaC5yZXQiIGlzIHJhbmRvbQo+ID4+ICAgICB2
YWx1ZSBhcyBpdCBpcyBpbiBzdGFjay4KPiA+Pgo+ID4+IFRoZSBwb3NzaWJsZSBmaXggbWF5YmU6
Cj4gPj4KPiA+PiBzdGF0aWMgaW50IHZob3N0X2F0dGFjaF9jZ3JvdXBzKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldikKPiA+PiB7Cj4gPj4gICAgICAgICAgIHN0cnVjdCB2aG9zdF9hdHRhY2hfY2dyb3Vw
c19zdHJ1Y3QgYXR0YWNoOwo+ID4+Cj4gPj4gICAgICAgICAgIGF0dGFjaC5yZXQgPSAwOwo+ID4+
ICAgICAgICAgICBhdHRhY2gub3duZXIgPSBjdXJyZW50Owo+ID4+ICAgICAgICAgICB2aG9zdF93
b3JrX2luaXQoJmF0dGFjaC53b3JrLCB2aG9zdF9hdHRhY2hfY2dyb3Vwc193b3JrKTsKPiA+PiAg
ICAgICAgICAgdmhvc3Rfd29ya19xdWV1ZShkZXYsICZhdHRhY2gud29yayk7Cj4gPj4gICAgICAg
ICAgIHZob3N0X3dvcmtfZGV2X2ZsdXNoKGRldik7Cj4gPj4gICAgICAgICAgIHJldHVybiBhdHRh
Y2gucmV0Owo+ID4+IH0KPiA+Pgo+ID4+ICAgIFNvIHRoaXMgZml4IGlzIGp1c3QgdG8gaW5pdGlh
bGl6ZSB0aGUgYXR0YWNoLnJldCB0byAwLCB0aGlzIGZpeCBtYXkKPiA+PiBub3QgdGhlIGZpbmFs
IGZpeCwKPiA+PiAgICBXZSBqdXN0IHdhbnQgeW91IGV4cGVydHMga25vdyB0aGlzIGlzc3VlIGV4
aXN0cywgYW5kIHdlIG1ldCBpdAo+ID4+IHJlY2VudGx5IGluIG91ciB0ZXN0Lgo+ID4+Cj4gPj4g
QW5kIHRoZSBpc3N1ZSBleGlzdHMgaW4gbWF5IHN0YWJsZSBicmFuY2hlcy4KPiA+Pgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
