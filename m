Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C28C64ED6
	for <virtualization@archiver.kernel.org>; Fri, 24 Feb 2023 03:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57B0F400EF;
	Fri, 24 Feb 2023 03:17:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57B0F400EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQN9SEy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHc3ggnJOIXS; Fri, 24 Feb 2023 03:17:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9879340002;
	Fri, 24 Feb 2023 03:17:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9879340002
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63AEBC0033;
	Fri, 24 Feb 2023 03:17:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B1A6C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4199408F7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4199408F7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQN9SEy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mm0_eYAOrW2f
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:16:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B527408F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B527408F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677208618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9Uwq5X3ng+CNozrNFpwjxJg2YpeqwTpzc4faJ5/49o=;
 b=iQN9SEy/TlwkaYr+huSL+HwNA1vkFCoCz389cYA/5iPk/ognUg9bEwRg+VMIpYDTXPTeSS
 88b2HXUZhBNEfCeaduDlDY8sp8ILik2x2383YHqf+wiUmiE0XLuygJY3PosA2QfkGzrTKh
 PnbcDMIi7lGxAjpRgbGE+PFJ6xkYz3s=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-2RLTVHaqNPSmigq1qGQ7ng-1; Thu, 23 Feb 2023 22:16:54 -0500
X-MC-Unique: 2RLTVHaqNPSmigq1qGQ7ng-1
Received: by mail-ot1-f71.google.com with SMTP id
 h6-20020a056830164600b0068d17bf4c93so4290671otr.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 19:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9Uwq5X3ng+CNozrNFpwjxJg2YpeqwTpzc4faJ5/49o=;
 b=vdbH4UCQkRD4Q7bEfzyDyOcrGgb4Koo/0vZCrQg9+F05tDJ6s5Icglgs24F0Fu5IgX
 mECD3Pm9iW3Ktcq3WdWHHwQJ6IKY236xlc5bm9w+iGiKYBIbinyw3AphndIgv0ZaAd6Z
 YlVnPBkUfnaCwbDkRm/ja+dKIxsmRmT9Gi+NHJMrBTb5UljXxXx6jk6iocGbiDJR/uXL
 XjR9h+9rwPUYms0Yqr62MLrcR6CTAe4ZoV4ZvRzRQKR17w1abYyYmxrrB9XyszGL6Wrb
 Zf6Cs4Rkq7Vs7tD0cunh5cknHsQ+ced7bT4D5gitNN9CPH4Cpf3KB6TDlm19NTRfbPI4
 F+UQ==
X-Gm-Message-State: AO0yUKXNHtsOeu84H7XXN7g0hKjeKqA/WgA6vrRUy8bAVveMdYjfelrw
 u0txxOCduYQShMARWVPQhzu5E6ZeDHq5SXQ7TuK2dEEYq7bs9zbPuteWtKwovydvPGQDP/QDbE6
 G8PCs38w82CJsjU3TjVf0UmTsNqA3JCfKUnQhaXGCZ5EFyJJm6XXeQg0KBw==
X-Received: by 2002:a05:6870:1aa8:b0:16e:3585:dbf2 with SMTP id
 ef40-20020a0568701aa800b0016e3585dbf2mr562887oab.9.1677208613611; 
 Thu, 23 Feb 2023 19:16:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/rJdL9L8qM2lGjrttiHBU2qF/0MU0BysFZIWmyQ4BGE4Kp8M/J/Rf52OyEtK3h+KIfPHpe3kwb7QvpeXGr/30=
X-Received: by 2002:a05:6870:1aa8:b0:16e:3585:dbf2 with SMTP id
 ef40-20020a0568701aa800b0016e3585dbf2mr562885oab.9.1677208613403; Thu, 23 Feb
 2023 19:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-12-eperezma@redhat.com>
 <c8d6ecc3-87f6-986e-e78d-003000e8a51e@redhat.com>
 <CAJaqyWdhK7QEHECP7qJP9tPA69e8uTuJtqLPNq_mUUhRDG_2Aw@mail.gmail.com>
 <81762a3b-b01f-2c3a-be63-531ac5b6976c@redhat.com>
 <CAJaqyWcScVMnkf+gXHZTAXrE2dbdzJXQM39BUv7Mm19kzRagqA@mail.gmail.com>
In-Reply-To: <CAJaqyWcScVMnkf+gXHZTAXrE2dbdzJXQM39BUv7Mm19kzRagqA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Feb 2023 11:16:42 +0800
Message-ID: <CACGkMEvk8AjscednP8FQqgk+GZn-kz4WJZycG9b6yv1=U-c+TQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] vdpa: block migration if dev does not have
 _F_SUSPEND
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

T24gVGh1LCBGZWIgMjMsIDIwMjMgYXQgNzowNyBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEZlYiAyMywgMjAyMyBhdCAzOjM4
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMy8yLzIyIDIyOjI1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4gPiA+IE9u
IFdlZCwgRmViIDIyLCAyMDIzIGF0IDU6MDUgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+Pgo+ID4gPj4g5ZyoIDIwMjMvMi84IDE3OjQyLCBFdWdlbmlvIFDD
qXJleiDlhpnpgZM6Cj4gPiA+Pj4gTmV4dCBwYXRjaGVzIGVuYWJsZSBkZXZpY2VzIHRvIGJlIG1p
Z3JhdGVkIGV2ZW4gaWYgdmRwYSBuZXRkZXYgaGFzIG5vdAo+ID4gPj4+IGJlZW4gc3RhcnRlZCB3
aXRoIHgtc3ZxLiBIb3dldmVyLCBub3QgYWxsIGRldmljZXMgYXJlIG1pZ3JhdGFibGUsIHNvIHdl
Cj4gPiA+Pj4gbmVlZCB0byBibG9jayBtaWdyYXRpb24gaWYgd2UgZGV0ZWN0IHRoYXQuCj4gPiA+
Pj4KPiA+ID4+PiBCbG9jayB2aG9zdC12ZHBhIGRldmljZSBtaWdyYXRpb24gaWYgaXQgZG9lcyBu
b3Qgb2ZmZXIgX0ZfU1VTUEVORCBhbmQgaXQKPiA+ID4+PiBoYXMgbm90IGJlZW4gc3RhcnRlZCB3
aXRoIHgtc3ZxLgo+ID4gPj4+Cj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+Pj4gLS0tCj4gPiA+Pj4gICAgaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ID4gPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4gPiA+Pj4KPiA+ID4+PiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiA+ID4+PiBpbmRl
eCA4NGE2Yjk2OTBiLi45ZDMwY2Y5YjNjIDEwMDY0NAo+ID4gPj4+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMKPiA+ID4+PiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+Pj4g
QEAgLTQ0Miw2ICs0NDIsMjcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2luaXQoc3RydWN0IHZo
b3N0X2RldiAqZGV2LCB2b2lkICpvcGFxdWUsIEVycm9yICoqZXJycCkKPiA+ID4+PiAgICAgICAg
ICAgIHJldHVybiAwOwo+ID4gPj4+ICAgICAgICB9Cj4gPiA+Pj4KPiA+ID4+PiArICAgIC8qCj4g
PiA+Pj4gKyAgICAgKiBJZiBkZXYtPnNoYWRvd192cXNfZW5hYmxlZCBhdCBpbml0aWFsaXphdGlv
biB0aGF0IG1lYW5zIHRoZSBkZXZpY2UgaGFzCj4gPiA+Pj4gKyAgICAgKiBiZWVuIHN0YXJ0ZWQg
d2l0aCB4LXN2cT1vbiwgc28gZG9uJ3QgYmxvY2sgbWlncmF0aW9uCj4gPiA+Pj4gKyAgICAgKi8K
PiA+ID4+PiArICAgIGlmIChkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyID09IE5VTEwgJiYgIXYtPnNo
YWRvd192cXNfZW5hYmxlZCkgewo+ID4gPj4+ICsgICAgICAgIHVpbnQ2NF90IGJhY2tlbmRfZmVh
dHVyZXM7Cj4gPiA+Pj4gKwo+ID4gPj4+ICsgICAgICAgIC8qIFdlIGRvbid0IGhhdmUgZGV2LT5i
YWNrZW5kX2ZlYXR1cmVzIHlldCAqLwo+ID4gPj4+ICsgICAgICAgIHJldCA9IHZob3N0X3ZkcGFf
Y2FsbChkZXYsIFZIT1NUX0dFVF9CQUNLRU5EX0ZFQVRVUkVTLAo+ID4gPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYmFja2VuZF9mZWF0dXJlcyk7Cj4gPiA+Pj4gKyAgICAgICAg
aWYgKHVubGlrZWx5KHJldCkpIHsKPiA+ID4+PiArICAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJu
byhlcnJwLCAtcmV0LCAiQ291bGQgbm90IGdldCBiYWNrZW5kIGZlYXR1cmVzIik7Cj4gPiA+Pj4g
KyAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPiA+Pj4gKyAgICAgICAgfQo+ID4gPj4+ICsKPiA+
ID4+PiArICAgICAgICBpZiAoIShiYWNrZW5kX2ZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNL
RU5EX0ZfU1VTUEVORCkpKSB7Cj4gPiA+Pj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoJmRldi0+
bWlncmF0aW9uX2Jsb2NrZXIsCj4gPiA+Pj4gKyAgICAgICAgICAgICAgICAidmhvc3QtdmRwYSBi
YWNrZW5kIGxhY2tzIFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EIGZlYXR1cmUuIik7Cj4gPiA+Pj4g
KyAgICAgICAgfQo+ID4gPj4KPiA+ID4+IEkgd29uZGVyIHdoeSBub3QgbGV0IHRoZSBkZXZpY2Ug
dG8gZGVjaWRlPyBGb3IgbmV0d29ya2luZyBkZXZpY2UsIHdlIGNhbgo+ID4gPj4gbGl2ZSB3aXRo
b3V0IHN1c3BlbmQgcHJvYmFibHkuCj4gPiA+Pgo+ID4gPiBSaWdodCwgYnV0IGhvdyBjYW4gd2Ug
a25vdyBpZiB0aGlzIGlzIGEgbmV0IGRldmljZSBpbiBpbml0PyBJIGRvbid0Cj4gPiA+IHRoaW5r
IGEgc3dpdGNoICh2aG9zdF92ZHBhX2dldF9kZXZpY2VfaWQoZGV2KSkgaXMgZWxlZ2FudC4KPiA+
Cj4gPgo+ID4gSSBtZWFudCB0aGUgY2FsbGVyIG9mIHZob3N0X3ZkcGFfaW5pdCgpIHdoaWNoIGlz
IG5ldF9pbml0X3Zob3N0X3ZkcGEoKS4KPiA+Cj4KPiBUaGF0J3MgZG9hYmxlIGJ1dCBJJ20gbm90
IHN1cmUgaWYgaXQgaXMgY29udmVuaWVudC4KClNvIGl0J3MgYSBxdWVzdGlvbiB3aGV0aGVyIG9y
IG5vdCB3ZSB0cnkgdG8gbGV0IG1pZ3JhdGlvbiB3b3JrIHdpdGhvdXQKc3VzcGVuZGluZy4gSWYg
d2UgZG9uJ3QsIHRoZXJlJ3Mgbm8gbmVlZCB0byBib3RoZXIuIExvb2tpbmcgYXQgdGhlCmN1cnJl
bnQgdmhvc3QtbmV0IGltcGxlbWVudGF0aW9uLCBpdCB0cmllcyB0byBtYWtlIG1pZ3JhdGlvbiB3
b3JrIHVwb24KdGhlIGVycm9yIG9mIGdldF92cmluZ19iYXNlKCkgc28gbWF5YmUgaXQncyB3b3J0
aCBhIHRyeSBpZiBpdCBkb2Vzbid0CmJvdGhlciB0b28gbXVjaC4gQnV0IEknbSBmaW5lIHRvIGdv
IGVpdGhlciB3YXkuCgo+Cj4gU2luY2Ugd2UncmUgYWx3YXlzIG9mZmVyaW5nIF9GX0xPRyBJIHRo
b3VnaHQgb2YgdGhlIGxhY2sgb2YgX0ZfU1VTUEVORAo+IGFzIHRoZSBkZWZhdWx0IG1pZ3JhdGlv
biBibG9ja2VyIGZvciBvdGhlciBraW5kcyBvZiBkZXZpY2VzIGxpa2UgYmxrLgoKT3Igd2UgY2Fu
IGhhdmUgdGhpcyBieSBkZWZhdWx0IGFuZCBhbGxvdyBhIHNwZWNpZmljIHR5cGUgb2YgZGV2aWNl
IHRvIGNsZWFyPwoKPiBJZiB3ZSBtb3ZlIHRoaXMgY29kZSB0byBuZXRfaW5pdF92aG9zdF92ZHBh
LCBhbGwgb3RoZXIgZGV2aWNlcyBhcmUgaW4KPiBjaGFyZ2Ugb2YgYmxvY2sgbWlncmF0aW9uIGJ5
IHRoZW1zZWx2ZXMuCj4KPiBJIGd1ZXNzIHRoZSByaWdodCBhY3Rpb24gaXMgdG8gdXNlIGEgdmFy
aWFibGUgc2ltaWxhciB0bwo+IHZob3N0X3ZkcGEtPmZfbG9nX2FsbC4gSXQgZGVmYXVsdHMgdG8g
ZmFsc2UsIGFuZCB0aGUgZGV2aWNlIGNhbiBjaG9vc2UKPiBpZiBpdCBzaG91bGQgZXhwb3J0IGl0
IG9yIG5vdC4gVGhpcyB3YXksIHRoZSBkZXZpY2UgZG9lcyBub3QgbWlncmF0ZQo+IGJ5IGRlZmF1
bHQsIGFuZCB0aGUgZXF1aXZhbGVudCBvZiBuZXRfaW5pdF92aG9zdF92ZHBhIGNvdWxkIGNob29z
ZQo+IHdoZXRoZXIgdG8gb2ZmZXIgX0ZfTE9HIHdpdGggU1ZRIG9yIG5vdC4KCkxvb2tzIHNpbWls
YXIgdG8gd2hhdCBJIHRoaW5rIGFib3ZlLgoKPgo+IE9UT0ggSSBndWVzcyBvdGhlciBraW5kcyBv
ZiBkZXZpY2VzIGFscmVhZHkgbXVzdCBwbGFjZSBibG9ja2VycyBiZXlvbmQKPiBfRl9MT0csIHNv
IG1heWJlIGl0IG1ha2VzIHNlbnNlIHRvIGFsd2F5cyBvZmZlciBfRl9MT0cgZXZlbiBpZgo+IF9G
X1NVU1BFTkQgaXMgbm90IG9mZmVyZWQ/CgpJIGRvbid0IHNlZSBhbnkgZGVwZW5kZW5jeSBiZXR3
ZWVuIHRoZSB0d28gZmVhdHVyZXMuIFRlY2huaWNhbGx5LAp0aGVyZSBjb3VsZCBiZSBkZXZpY2Vz
IHRoYXQgaGF2ZSBuZWl0aGVyIF9GX0xPRyBub3IgX0ZfU1VTUEVORC4KClRoYW5rcwoKPiBTdGVm
YW5vIEcuLCB3b3VsZCB0aGF0IGJyZWFrIHZob3N0LXZkcGEtYmxrCj4gc3VwcG9ydD8KPgo+IFRo
YW5rcyEKPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4KPiA+ID4gSWYgdGhlIHBhcmVudCBkZXZp
Y2UgZG9lcyBub3QgbmVlZCB0byBiZSBzdXNwZW5kZWQgaSdkIGdvIHdpdGgKPiA+ID4gZXhwb3Np
bmcgYSBzdXNwZW5kIGlvY3RsIGJ1dCBkbyBub3RoaW5nIGluIHRoZSBwYXJlbnQgZGV2aWNlLiBB
ZnRlcgo+ID4gPiB0aGF0LCBpdCBjb3VsZCBldmVuIGNob29zZSB0byByZXR1cm4gYW4gZXJyb3Ig
Zm9yIEdFVF9WUklOR19CQVNFLgo+ID4gPgo+ID4gPiBJZiB3ZSB3YW50IHRvIGltcGxlbWVudCBp
dCBhcyBhIGZhbGxiYWNrIGluIHFlbXUsIEknZCBnbyBmb3IKPiA+ID4gaW1wbGVtZW50aW5nIGl0
IG9uIHRvcCBvZiB0aGlzIHNlcmllcy4gVGhlcmUgYXJlIGEgZmV3IG9wZXJhdGlvbnMgd2UKPiA+
ID4gY291bGQgbW92ZSB0byBhIGRldmljZS1raW5kIHNwZWNpZmljIG9wcy4KPiA+ID4KPiA+ID4g
V291bGQgaXQgbWFrZSBzZW5zZSB0byB5b3U/Cj4gPiA+Cj4gPiA+IFRoYW5rcyEKPiA+ID4KPiA+
ID4KPiA+ID4+IFRoYW5rcwo+ID4gPj4KPiA+ID4+Cj4gPiA+Pj4gKyAgICB9Cj4gPiA+Pj4gKwo+
ID4gPj4+ICAgICAgICAvKgo+ID4gPj4+ICAgICAgICAgKiBTaW1pbGFyIHRvIFZGSU8sIHdlIGVu
ZCB1cCBwaW5uaW5nIGFsbCBndWVzdCBtZW1vcnkgYW5kIGhhdmUgdG8KPiA+ID4+PiAgICAgICAg
ICogZGlzYWJsZSBkaXNjYXJkaW5nIG9mIFJBTS4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
