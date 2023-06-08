Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF12C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 13:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 654A583BEB;
	Thu,  8 Jun 2023 13:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 654A583BEB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QW7DacbZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-WWgiPCyscB; Thu,  8 Jun 2023 13:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B634683BE8;
	Thu,  8 Jun 2023 13:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B634683BE8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B5AC007A;
	Thu,  8 Jun 2023 13:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E05C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9001B40494
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9001B40494
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QW7DacbZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xf2FRJc6sQEy
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:46:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82067402E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82067402E8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686231996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73nshEeWhw2n5gdRpaAAi9lUSo+UIEZBfmddmf0WSo8=;
 b=QW7DacbZLKltZ0A87clNL628uRPcUz25ngxSTalGoe4kh7W4hThrZprVZLTvrIdxlZUHY6
 a8WjDEgQNGAeZG5Aqw4qqIt77yKZeliVZY+QfZ89uZI3X7orHm3cTBfUL6At2rRJmZIQVB
 srdwxCfB446gOJaEpjTBRohRdZOixrs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-TomWzKzTOgyBrHz2sh1R5Q-1; Thu, 08 Jun 2023 09:46:35 -0400
X-MC-Unique: TomWzKzTOgyBrHz2sh1R5Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso253186f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 06:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231994; x=1688823994;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73nshEeWhw2n5gdRpaAAi9lUSo+UIEZBfmddmf0WSo8=;
 b=aj2a5ZAuzXaASeMmRJ/Ecs1bykWbUXFzBA6V/OKaPCKVRGdByRSBhDlniJvpXHBE3k
 W9lyNn8kJhjWUDlkDvvXVaasS5ctl++fWp/t/uqJygMShtg8IvpnZ05lmRig/4ffRRh1
 ULBSfoVIrz0RziOkAVSaBzVd2rbKKU/KfoQacNlshoL1xoRKIHmvItK5oBJfeQnOP8+F
 GiuW5O8DHNFscCb+acBKLFTi/Pu8IKtHnjxhvXgHD7WK9WWSlKI1SBgfnQCcTejS2GOC
 5fckhpS6oBYL7LJSV5i3e2YmG6P1DUJw6YSjKXV+BBiuHPnY25/48n+OnU59Fv2APsQZ
 UDSw==
X-Gm-Message-State: AC+VfDwVRkgqP8dlDKjpti+vVa0tDE1jP6jcVqiv2FuEImMsV5OZNVEE
 nPnklE0i9D3ds5/jQlY+WRkhXl/KX44GfO59QN6LXjzYEkv038k4s6qXopRl5zEzMRXmUyU21Du
 LPSEkxWvw+v0cCJ2AWycp01is73tLtLQD9GKAT0DQ7g==
X-Received: by 2002:adf:f547:0:b0:309:38af:91c6 with SMTP id
 j7-20020adff547000000b0030938af91c6mr7519232wrp.68.1686231994184; 
 Thu, 08 Jun 2023 06:46:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nvd4pWYZsLG/t7CXB3KRL7ulTzo9Pl/yJm2BKU29KvWQFi9FA8ZY1S13xxeI6s5mULDgI/w==
X-Received: by 2002:adf:f547:0:b0:309:38af:91c6 with SMTP id
 j7-20020adff547000000b0030938af91c6mr7519218wrp.68.1686231993887; 
 Thu, 08 Jun 2023 06:46:33 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 i1-20020adfefc1000000b0030647449730sm1671162wrp.74.2023.06.08.06.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:46:33 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:46:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230608094528-mutt-send-email-mst@kernel.org>
References: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6MDA6MDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEp1biA4LCAyMDIzIGF0IDQ6MDDigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVuIDA4LCAyMDIz
IGF0IDAzOjQ2OjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPgo+ID4gWy4uLl0KPiA+
Cj4gPiA+PiA+ID4gPiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRo
ZSByb2FkIHRoZXJlCj4gPiA+PiA+ID4gPiA+IGlzIGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBt
b3JlIGNoYW5nZXM/IEl0IHdpbGwgYmUKPiA+ID4+ID4gPiA+ID4gYnJva2VuIHRvbyBqdXN0IGxp
a2UgUEFDS0VEIG5vPwo+ID4gPj4gPiA+ID4gPiBTaG91bGRuJ3QgdmRwYSBoYXZlIGFuIGFsbG93
bGlzdCBvZiBmZWF0dXJlcyBpdCBrbm93cyBob3cKPiA+ID4+ID4gPiA+ID4gdG8gc3VwcG9ydD8K
PiA+ID4+ID4gPiA+Cj4gPiA+PiA+ID4gPiBJdCBsb29rcyBsaWtlIHdlIGhhZCBpdCwgYnV0IHdl
IHRvb2sgaXQgb3V0IChieSB0aGUgd2F5LCB3ZSB3ZXJlCj4gPiA+PiA+ID4gPiBlbmFibGluZyBw
YWNrZWQgZXZlbiB0aG91Z2ggd2UgZGlkbid0IHN1cHBvcnQgaXQpOgo+ID4gPj4gPiA+ID4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGlu
dXguZ2l0L2NvbW1pdC8/aWQ9NjIzNGY4MDU3NGQ3NTY5NDQ0ZDg3MTgzNTVmYTI4MzhlOTJiMTU4
Ygo+ID4gPj4gPiA+ID4KPiA+ID4+ID4gPiA+IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaXMgdGhh
dCBmb3IgZWFjaCBuZXcgZmVhdHVyZSB3ZSBoYXZlIHRvIG1vZGlmeQo+ID4gPj4gPiA+ID4gdGhl
IGtlcm5lbC4KPiA+ID4+ID4gPiA+IENvdWxkIHdlIGhhdmUgbmV3IGZlYXR1cmVzIHRoYXQgZG9u
J3QgcmVxdWlyZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwo+ID4gPj4gPiA+ID4KPiA+ID4+ID4g
PiA+IFRoYW5rcywKPiA+ID4+ID4gPiA+IFN0ZWZhbm8KPiA+ID4+ID4gPgo+ID4gPj4gPiA+IEph
c29uIHdoYXQgZG8geW91IHNheSB0byByZXZlcnRpbmcgdGhpcz8KPiA+ID4+ID4KPiA+ID4+ID4g
SSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIHdpdGggdkRQ
QSBjb3JlLgo+ID4gPj4gPgo+ID4gPj4gPiBJdCdzIHRoZSBkdXR5IG9mIHRoZSBwYXJlbnRzIHRv
IGFkdmVydGlzZSB0aGUgZmVhdHVyZXMgaXQgaGFzLiBGb3IgZXhhbXBsZSwKPiA+ID4+ID4KPiA+
ID4+ID4gMSkgSWYgc29tZSBrZXJuZWwgdmVyc2lvbiB0aGF0IGlzIHBhY2tlZCBpcyBub3Qgc3Vw
cG9ydGVkIHZpYQo+ID4gPj4gPiBzZXRfdnFfc3RhdGUsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZl
cnRpc2UgUEFDS0VEIGZlYXR1cmVzIGluIHRoaXMKPiA+ID4+ID4gY2FzZS4KPiA+ID4+ID4gMikg
SWYgdGhlIGtlcm5lbCBoYXMgc3VwcG9ydCBwYWNrZWQgc2V0X3ZxX3N0YXRlKCksIGJ1dCBpdCdz
IGVtdWxhdGVkCj4gPiA+PiA+IGN2cSBkb2Vzbid0IHN1cHBvcnQsIHBhcmVudHMgc2hvdWxkIG5v
dCBhZHZlcnRpc2UgUEFDS0VEIGFzIHdlbGwKPiA+ID4+ID4KPiA+ID4+ID4gSWYgYSBwYXJlbnQg
dmlvbGF0ZXMgdGhlIGFib3ZlIDIsIGl0IGxvb2tzIGxpa2UgYSBidWcgb2YgdGhlIHBhcmVudHMu
Cj4gPiA+PiA+Cj4gPiA+PiA+IFRoYW5rcwo+ID4gPj4KPiA+ID4+IFllcyBidXQgd2hhdCBhYm91
dCB2aG9zdF92ZHBhPyBUYWxraW5nIGFib3V0IHRoYXQgbm90IHRoZSBjb3JlLgo+ID4gPgo+ID4g
Pk5vdCBzdXJlIGl0J3MgYSBnb29kIGlkZWEgdG8gd29ya2Fyb3VuZCBwYXJlbnQgYnVncyB2aWEg
dmhvc3QtdkRQQS4KPiA+Cj4gPiBTb3JyeSwgSSdtIGdldHRpbmcgbG9zdC4uLgo+ID4gV2Ugd2Vy
ZSB0YWxraW5nIGFib3V0IHRoZSBmYWN0IHRoYXQgdmhvc3QtdmRwYSBkb2Vzbid0IGhhbmRsZQo+
ID4gU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgaW9jdGxzIHdlbGwgZm9yIHBhY2tlZCB2
aXJ0cXVldWUgYmVmb3JlCj4gPiB0aGF0IHNlcmllcyBbMV0sIG5vPwo+ID4KPiA+IFRoZSBwYXJl
bnRzIHNlZW0gb2theSwgYnV0IG1heWJlIEkgbWlzc2VkIGEgZmV3IHRoaW5ncy4KPiA+Cj4gPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0MjQyMjUwMzEu
MTg5NDctMS1zaGFubm9uLm5lbHNvbkBhbWQuY29tLwo+IAo+IFllcywgbW9yZSBiZWxvdy4KPiAK
PiA+Cj4gPiA+Cj4gPiA+PiBTaG91bGQgdGhhdCBub3QgaGF2ZSBhIHdoaXRlbGlzdCBvZiBmZWF0
dXJlcwo+ID4gPj4gc2luY2UgaXQgaW50ZXJwcmV0cyBpb2N0bHMgZGlmZmVyZW50bHkgZGVwZW5k
aW5nIG9uIHRoaXM/Cj4gPiA+Cj4gPiA+SWYgdGhlcmUncyBhIGJ1ZywgaXQgbWlnaHQgb25seSBt
YXR0ZXIgdGhlIGZvbGxvd2luZyBzZXR1cDoKPiA+ID4KPiA+ID5TRVRfVlJJTkdfQkFTRS9HRVRf
VlJJTkdfQkFTRSArIFZEVVNFLgo+ID4gPgo+ID4gPlRoaXMgc2VlbXMgdG8gYmUgYnJva2VuIHNp
bmNlIFZEVVNFIHdhcyBpbnRyb2R1Y2VkLiBJZiB3ZSByZWFsbHkgd2FudAo+ID4gPnRvIGJhY2tw
b3J0IHNvbWV0aGluZywgaXQgY291bGQgYmUgYSBmaXggdG8gZmlsdGVyIG91dCBQQUNLRUQgaW4K
PiA+ID5WRFVTRT8KPiA+Cj4gPiBtbW0gaXQgZG9lc24ndCBzZWVtIHRvIGJlIGEgcHJvYmxlbSBp
biBWRFVTRSwgYnV0IGluIHZob3N0LXZkcGEuCj4gPiBJIHRoaW5rIFZEVVNFIHdvcmtzIGZpbmUg
d2l0aCBwYWNrZWQgdmlydHF1ZXVlIHVzaW5nIHZpcnRpby12ZHBhCj4gPiAoSSBoYXZlbid0IHRy
aWVkKSwgc28gd2h5IHNob3VsZCB3ZSBmaWx0ZXIgUEFDS0VEIGluIFZEVVNFPwo+IAo+IEkgZG9u
J3QgdGhpbmsgd2UgbmVlZCBhbnkgZmlsdGVyaW5nIHNpbmNlOgo+IAo+IFBBQ0tFRCBmZWF0dXJl
cyBoYXMgYmVlbiBhZHZlcnRpc2VkIHRvIHVzZXJzcGFjZSB2aWEgdUFQSSBzaW5jZQo+IDYyMzRm
ODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIuIE9uY2Ugd2UgcmVsYXggaW4gdUFQ
SSwgaXQKPiB3b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gcmVzdHJpY3QgaXQgYWdhaW4uIEZvciB0aGUg
dXNlcnNwYWNlIHRoYXQgdHJpZXMKPiB0byBuZWdvdGlhdGUgUEFDS0VEOgo+IAo+IDEpIGlmIGl0
IGRvZXNuJ3QgdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFLCBldmVyeXRoaW5nIHdv
cmtzIHdlbGwKPiAyKSBpZiBpdCB1c2VzIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFLiBp
dCBtaWdodCBmYWlsIG9yIGJyZWFrIHNpbGVudGx5Cj4gCj4gSWYgd2UgYmFja3BvcnQgdGhlIGZp
eGVzIHRvIC1zdGFibGUsIHdlIG1heSBicmVhayB0aGUgYXBwbGljYXRpb24gYXQKPiBsZWFzdCBp
biB0aGUgY2FzZSAxKS4KPiAKPiBUaGFua3MKCgpJIGFtIGxlc3MgY29uY2VybmVkIGFib3V0IHN0
YWJsZSwgYW5kIG11Y2ggbW9yZSBjb25jZXJuZWQgYWJvdXQgdGhlCmZ1dHVyZS4gQXNzdW1lIHdl
IGFkZCBhIG5ldyByaW5nIGZvcm1hdC4gSXQgd2lsbCBiZSBzaWxlbnRseSBwYXNzZWQKdG8gdmhv
c3QtdmRwYSBhbmQgdGhpbmdzIGJyZWFrIGFnYWluLgpUaGlzIGlzIHdoeSBJIHRoaW5rIHdlIG5l
ZWQgYW4gYWxsb3dsaXN0IGluIHZob3N0LXZkcGEuCgoKPiA+Cj4gPiBUaGFua3MsCj4gPiBTdGVm
YW5vCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
