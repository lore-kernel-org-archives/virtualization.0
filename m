Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C2C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 07:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8B3941EB6;
	Fri, 24 Mar 2023 07:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8B3941EB6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NgzGk64e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lokZtumqz-l; Fri, 24 Mar 2023 07:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D74E41727;
	Fri, 24 Mar 2023 07:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D74E41727
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50F3CC0035;
	Fri, 24 Mar 2023 07:00:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A535BC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B41583FFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B41583FFB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NgzGk64e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9zUkwPB1GKZm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAD8383FF6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAD8383FF6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679641214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ7MkMIkN7lvSOZvIITGhL1ZHsdpsx64jjjlRFP63dg=;
 b=NgzGk64eE8FbF1Wlrf4+WF0SvGTPYe8PCAX6hYJUPCxQljdVjFBNoyuLqnEHAnPDzisVb8
 BSGW4WrGSFcjop3nCeYwZvrV75J3xxQ3gq/aIWNk1g9koo0tppM6sWRYNDKYFfKfpsmVT/
 oiHp91lm7IsQHvRvgV7DHrApa2g9U8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-CSPZ9AE2PAejp_e11R77bQ-1; Fri, 24 Mar 2023 03:00:13 -0400
X-MC-Unique: CSPZ9AE2PAejp_e11R77bQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 bg13-20020a05600c3c8d00b003ed40f09355so568553wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 00:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679641212;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQ7MkMIkN7lvSOZvIITGhL1ZHsdpsx64jjjlRFP63dg=;
 b=Z5GfDyZQ2k8a7zUNd9t34d+uAUhcdyqhybREaPc30YXnQl4ZgvUvymMbnDf54zfwsz
 TFOKN76d/6d6lICNYz///nQ0OmwIGLiX41xx+P74UlEs5o+9xwTGZqUW9riUU3UELjhb
 wvs8y2T+PeV39pwvqXiENdbm1ce/D4lv+/U6AYcEgzjvk5yP/iWCCBf6GaF6dA8EYqWd
 j8J+Fd6QN4qqzBLRElZRN1K1rcvSmFb7kRVgvHCJNNmiH1KEW0/L3gThIWOazffCzrwc
 GUn4SAPMeLudBHlQjy4Vp4kNclwBOZlNukwcFpStiw2wGG+0bJGuiF9MI/DcEOkV86XY
 tGcA==
X-Gm-Message-State: AO0yUKXXAJBETq5shN7mkNjMCH3qLBblAsPBMEp+KCLhc5Uwsq6g7oMh
 7kYk1no0uuaC+YKcSv0tvJrdybRYMceBCW1xMhUaWrhROUsLj5Cn4fwK5yRh6Sw81kXW1/8XUv9
 hcvPVGbhpd+CO7/Wqm0JlyYrurhh3e694Q/WcxVFKtQ==
X-Received: by 2002:a05:600c:2199:b0:3ee:a492:e973 with SMTP id
 e25-20020a05600c219900b003eea492e973mr1486273wme.28.1679641211771; 
 Fri, 24 Mar 2023 00:00:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set/mI/NUtiMUPXa+mgpTIj6mdgN3HWgUHp61BEAIPTu6Q5CnRSCyOru4C0wdkqtFngQMi8oGZQ==
X-Received: by 2002:a05:600c:2199:b0:3ee:a492:e973 with SMTP id
 e25-20020a05600c219900b003eea492e973mr1486251wme.28.1679641211353; 
 Fri, 24 Mar 2023 00:00:11 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 w13-20020a1cf60d000000b003ed4f6c6234sm3985904wmc.23.2023.03.24.00.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 00:00:10 -0700 (PDT)
Date: Fri, 24 Mar 2023 03:00:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324025937-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
 <20230324013805-mutt-send-email-mst@kernel.org>
 <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
 <20230324024155-mutt-send-email-mst@kernel.org>
 <CACGkMEtBYVUrKFaMJYJrkrF3y2eu7r6ige6z+uRbHY_jotq80Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtBYVUrKFaMJYJrkrF3y2eu7r6ige6z+uRbHY_jotq80Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMDI6NDc6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAyOjQy4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQg
MDI6MzI6NDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBNYXIgMjQs
IDIwMjMgYXQgMTo1OeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTE6NDE6MTJBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIFRodSwgTWFyIDIzLCAyMDIzIGF0
IDQ6MDHigK9QTSDpu4TmnbAgPGh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPiB3cm90ZToK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
5LqOMjAyM+W5tDPmnIgyMuaXpeWRqOS4iSAxMDozN+WGmemBk++8mgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNTowMOKAr1BNIEFsYmVydCBIdWFu
Zwo+ID4gPiA+ID4gPiA+IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gRnJvbTogImh1YW5namllLmFsYmVydCIgPGh1
YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+IGZpeCBjb21taXQgOGQ2MjJkMjFkMjQ4ICgidmlydGlvOiBmaXggdXAgdmlydGlvX2Rpc2Fi
bGVfY2IiKQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IGlmIHdlIGRpc2FibGUgdGhl
IG5hcGlfdHguIHdoZW4gd2UgdHJpZ2VyIGEgdHggaW50ZXJydXB0LCB0aGUKPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IHR5cG8gc2hvdWxkIGJlICJ0cmlnZ2VyIgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9LLCB0aGFua3MgZm9yIHRoaXMuIEkgd2lsbCBjb3JyZWN0
IGl0IGluIHRoZSBuZXh0IHZlcnNpb24KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IHZxLT5l
dmVudF90cmlnZ2VyZWQgd2lsbCBiZSBzZXQgdG8gdHJ1ZS4gSXQgd2lsbCBubyBsb25nZXIgYmUK
PiA+ID4gPiA+ID4gPiA+IHNldCB0byBmYWxzZS4gVW5sZXNzIHdlIGV4cGxpY2l0bHkgY2FsbCB2
aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQKPiA+ID4gPiA+ID4gPiA+IG9yIHZpcnRxdWV1ZV9l
bmFibGVfY2JfcHJlcGFyZQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IGlmIHdlIGRp
c2FibGUgdGhlIG5hcGlfdHgsIEl0IHdpbGwgb25seSBiZSBjYWxsZWQgd2hlbiB0aGUgdHggcmlu
Zwo+ID4gPiA+ID4gPiA+ID4gYnVmZmVyIGlzIHJlbGF0aXZlbHkgc21hbGw6Cj4gPiA+ID4gPiA+
ID4gPiB2aXJ0aW9fbmV0LT5zdGFydF94bWl0Ogo+ID4gPiA+ID4gPiA+ID4gICAgICAgICBpZiAo
c3EtPnZxLT5udW1fZnJlZSA8IDIrTUFYX1NLQl9GUkFHUykgewo+ID4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgIG5ldGlmX3N0b3Bfc3VicXVldWUoZGV2LCBxbnVtKTsKPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICBpZiAoIXVzZV9uYXBpICYmCj4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgIHVubGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3Et
PnZxKSkpIHsKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE1vcmUg
anVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRoZW4gcmVjaGVjay4gKi8KPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ticyhzcSwgZmFsc2UpOwo+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNxLT52cS0+bnVtX2Zy
ZWUgPj0gMitNQVhfU0tCX0ZSQUdTKSB7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxl
X2NiKHNxLT52cSk7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGUgY29kZSBleGFtcGxlIGhlcmUgaXMgb3V0IG9m
IGRhdGUsIG1ha2Ugc3VyZSB5b3VyIHRyZWUgaGFzIHRoaXM6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IGFsc28sIEkgd2lsbCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb27vvIx0aGlzIGlz
IGZyb20ga2VybmVsIDUuMTUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiBjb21taXQgZDcxZWJlODExNGI0YmY2MjI4MDRiODEwZjVlMjc0MDY5MDYwYTE3NAo+ID4gPiA+
ID4gPiA+IEF1dGhvcjogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+
ID4gPiBEYXRlOiAgIFR1ZSBKYW4gMTcgMTE6NDc6MDcgMjAyMyArMDgwMAo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gICAgIHZpcnRpby1uZXQ6IGNvcnJlY3RseSBlbmFibGUgY2FsbGJhY2sg
ZHVyaW5nIHN0YXJ0X3htaXQKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgIH0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4gPiA+ID4gQmVjYXVz
ZSBldmVudF90cmlnZ2VyZWQgaXMgdHJ1ZS5UaGVyZWZvcmUsIFZSSU5HX0FWQUlMX0ZfTk9fSU5U
RVJSVVBUIG9yCj4gPiA+ID4gPiA+ID4gPiBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxF
IHdpbGwgbm90IGJlIHNldC5TbyB3ZSB1cGRhdGUKPiA+ID4gPiA+ID4gPiA+IHZyaW5nX3VzZWRf
ZXZlbnQoJnZxLT5zcGxpdC52cmluZykgb3IgdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPm9mZl93
cmFwCj4gPiA+ID4gPiA+ID4gPiBldmVyeSB0aW1lIHdlIGNhbGwgdmlydHF1ZXVlX2dldF9idWZf
Y3R4LlRoaXMgd2lsbCBicmluZyBtb3JlIGludGVycnVwdGlvbnMuCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBDYW4geW91IHBsZWFzZSBwb3N0IGhvdyB0byB0ZXN0IHdpdGggdGhlIHBlcmZv
cm1hbmNlIG51bWJlcnM/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gaXBl
cmYzIHRjcCBzdHJlYW06Cj4gPiA+ID4gPiA+IHZtMSAtLS0tLS0tLS0tLS0tLS0tLT4gdm0yCj4g
PiA+ID4gPiA+IHZtMiBqdXN0IHJlY2VpdmUgdGNwIGRhdGEgc3RyZWFtIGZyb20gdm0xLCBhbmQg
c2VuZCB0aGUgYWNrIHRvIHZtMSwKPiA+ID4gPiA+ID4gdGhlcmUgYXJlIHNvCj4gPiA+ID4gPiA+
IG1hbnkgdHggaW50ZXJydXB0aW9ucyAgaW4gdm0yLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBi
dXQgd2l0aG91dCBldmVudF90cmlnZ2VyZWQgdGhlcmUgYXJlIGp1c3QgYSBmZXcgdHggaW50ZXJy
dXB0aW9ucy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBpZiBl
dmVudF90cmlnZ2VyZWQgaXMgc2V0IHRvIHRydWUsIGRvIG5vdCB1cGRhdGUgdnJpbmdfdXNlZF9l
dmVudCgmdnEtPnNwbGl0LnZyaW5nKQo+ID4gPiA+ID4gPiA+ID4gb3IgdnEtPnBhY2tlZC52cmlu
Zy5kcml2ZXItPm9mZl93cmFwCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogaHVhbmdqaWUuYWxiZXJ0IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4K
PiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCA2ICsrKystLQo+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiBpbmRleCAzMDdlMTM5Y2IxMWQuLmY0
ODZjY2NhZGJlYiAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiA+ID4gPiA+ID4gPiA+IEBAIC03OTUsNyArNzk1LDggQEAgc3RhdGljIHZvaWQgKnZp
cnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ID4g
PiA+ID4gPiAgICAgICAgIC8qIElmIHdlIGV4cGVjdCBhbiBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0
IGVudHJ5LCB0ZWxsIGhvc3QKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICogYnkgd3JpdGluZyBl
dmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUKPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICogdGhlIHJlYWQgaW4gdGhlIG5leHQgZ2V0X2J1ZiBjYWxsLiAqLwo+ID4gPiA+
ID4gPiA+ID4gLSAgICAgICBpZiAoISh2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ICYgVlJJ
TkdfQVZBSUxfRl9OT19JTlRFUlJVUFQpKQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoISh2
cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ICYgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQp
Cj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAmJiAodnEtPmV2ZW50X3Ry
aWdnZXJlZCA9PSBmYWxzZSkpCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJJ20gbm90IHN1
cmUgdGhpcyBjYW4gd29yaywgd2hlbiBldmVudF90cmlnZ2VyZWQgaXMgdHJ1ZSBpdCBtZWFucwo+
ID4gPiA+ID4gPiA+IHdlJ3ZlIGdvdCBhbiBpbnRlcnJ1cHQsIGluIHRoaXMgY2FzZSBpZiB3ZSB3
YW50IGFub3RoZXIgaW50ZXJydXB0IGZvcgo+ID4gPiA+ID4gPiA+IHRoZSBuZXh0IGVudHJ5LCB3
ZSBzaG91bGQgdXBkYXRlIHVzZWRfZXZlbnQgb3RoZXJ3aXNlIHdlIHdpbGwgbG9zZQo+ID4gPiA+
ID4gPiA+IHRoYXQgaW50ZXJydXB0Pwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE5vcm1hbGx5LCBpZiB3ZSByZWNlaXZlIGFuIGludGVy
cnVwdCwgd2Ugc2hvdWxkIGRpc2FibGUgdGhlIGludGVycnVwdAo+ID4gPiA+ID4gPiBpbiB0aGUg
aW50ZXJydXB0IGNhbGxiYWNrIGhhbmRsZXIuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU28gdGhlIHBy
b2JsZW0gaXM6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gMSkgZXZlbnRfdHJpZ2dlcmVkIHdhcyBzZXQg
dG8gdHJ1ZSBpbiB2cmluZ19pbnRlcnJ1cHQoKQo+ID4gPiA+ID4KPiA+ID4gPiA+IDIpIGFmdGVy
IHRoaXMgbm90aGluZyB3aWxsIGhhcHBlbiBmb3IgdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBzbwo+
ID4gPiA+ID4gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgaXMgbm90IHNldCBpbiBhdmFpbF9m
bGFnc19zaGFkb3cKPiA+ID4gPiA+IDMpIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdCgpIHdp
bGwgc3RpbGwgdGhpbmsgdGhlIGNiIGlzIGVuYWJsZWQKPiA+ID4gPiA+IHRoZW4gaXQgdHJpZXMg
dG8gcHVibGlzaCBuZXcgZXZlbnQKPiA+ID4gPgo+ID4gPiA+IE9oLiBHb29kIHBvaW50ISBJIHRo
aW5rIHdoZW4gSSB3cm90ZSB1cAo+ID4gPiA+IDhkNjIyZDIxZDI0OCAoInZpcnRpbzogZml4IHVw
IHZpcnRpb19kaXNhYmxlX2NiIikKPiA+ID4gPiBJIG1pc3NlZCB0aGlzIGNvcm5lciBjYXNlLgo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBtYWtlcyBtZSB0aGluayBhYm91
dCB3aGV0aGVyIG9yIG5vdCB3ZSByZWFsbHkgbmVlZAo+ID4gPiA+ID4gZXZlbnRfdHJpZ2dlcmVk
LiBUaGUgYXNzdW1wdGlvbiBpbiB0aGUgdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBzZWVtcwo+ID4g
PiA+ID4gd3Jvbmc6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gLyogSWYgZGV2aWNlIHRyaWdnZXJlZCBh
biBldmVudCBhbHJlYWR5IGl0IHdvbid0IHRyaWdnZXIgb25lIGFnYWluOgo+ID4gPiA+ID4gICog
bm8gbmVlZCB0byBkaXNhYmxlLgo+ID4gPiA+ID4gICovCj4gPiA+ID4gPiBpZiAodnEtPmV2ZW50
X3RyaWdnZXJlZCkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gVGhpcyBpcyB3cm9uZyBpZiB0aGVyZSdzIG5vIGV2ZW50IGluZGV4IHN1cHBvcnQu
Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEkgZG9uJ3QgZ2V0IGl0LiAgaG93IGRvZXMgdGhpcyBn
ZXQgdHJpZ2dlcmVkPwo+ID4gPiA+Cj4gPiA+ID4gWW91IGFyZSB0YWxraW5nIGFib3V0IGRldmlj
ZSB3aXRob3V0IGV2ZW50IGluZGV4Pwo+ID4gPiA+IEhlcmUncyBjb2RlIGZyb20gdnJpbmdfaW50
ZXJydXB0KCk6Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgIC8qIEp1c3QgYSBoaW50IGZvciBwZXJm
b3JtYW5jZTogc28gaXQncyBvayB0aGF0IHRoaXMgY2FuIGJlIHJhY3khICovCj4gPiA+ID4gICAg
ICAgICBpZiAodnEtPmV2ZW50KQo+ID4gPiA+ICAgICAgICAgICAgICAgICB2cS0+ZXZlbnRfdHJp
Z2dlcmVkID0gdHJ1ZTsKPiA+ID4KPiA+ID4gQnV0IHdlIGhhdmUgdGhlIGZvbGxvd2luZyBpbiB2
aXJ0cXVldWVfZGlzYWJsZV9jYigpOgo+ID4gPgo+ID4gPiAgICAgICAgIC8qIElmIGRldmljZSB0
cmlnZ2VyZWQgYW4gZXZlbnQgYWxyZWFkeSBpdCB3b24ndCB0cmlnZ2VyIG9uZSBhZ2FpbjoKPiA+
ID4gICAgICAgICAgKiBubyBuZWVkIHRvIGRpc2FibGUuCj4gPiA+ICAgICAgICAgICovCj4gPiA+
ICAgICAgICAgaWYgKHZxLT5ldmVudF90cmlnZ2VyZWQpCj4gPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm47Cj4gPiA+Cj4gPiA+ICAgICAgICAgaWYgKHZxLT5wYWNrZWRfcmluZykKPiA+ID4gICAg
ICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3BhY2tlZChfdnEpOwo+ID4gPiAgICAg
ICAgIGVsc2UKPiA+ID4gICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3NwbGl0
KF92cSk7Cj4gPiA+Cj4gPiA+IFRoaXMgbWVhbnMsIHdpdGhvdXQgYW4gZXZlbnQgaW5kZXgsIHdl
IGRvbid0IHNldCBhdmFpbCBmbGFncy4gU28gdGhlCj4gPiA+IGludGVycnVwdCBpcyBub3QgZGlz
YWJsZWQgYWN0dWFsbHkgaW4gdGhpcyBjYXNlLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiBP
bmx5IGlmIGV2ZW50X3RyaWdnZXJlZCBpcyB0cnVlLCB3aGljaCB3aXRob3V0IGV2ZW50IGluZGV4
IGl0IG5ldmVyIGlzLgo+IAo+IEknbSBub3Qgc3VyZSBJIHdpbGwgZ2V0IGhlcmUuIEkgbWVhbnQg
Zm9yIGV4YW1wbGUgdGhlIGNvbW1pdAo+IHN1cHByZXNzZXMgdGhlIGVmZm9ydCBvZiBza2JfeG1p
dF9kb25lKCk6Cj4gCj4gc3RhdGljIHZvaWQgc2tiX3htaXRfZG9uZShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSkKPiB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHZxLT52ZGV2LT5w
cml2Owo+ICAgICAgICAgc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpID0gJnZpLT5zcVt2cTJ0eHEo
dnEpXS5uYXBpOwo+IAo+ICAgICAgICAgLyogU3VwcHJlc3MgZnVydGhlciBpbnRlcnJ1cHRzLiAq
Lwo+ICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2IodnEpOwo+IAo+IFRoZSB2aXJ0cXVldWVf
ZGlzYWJsZV9jYigpIGRvZXNuJ3QgZGlzYWJsZSBmdXJ0aGVyIGludGVycnVwdHMgd2hlbiB0aGUK
PiBldmVudCBpbmRleCBpcyBub3QgdGhlcmUuCj4gCj4gVGhhbmtzCgpDaGVjayB3aGF0IGNhbiBz
ZXQgZXZlbnRfdHJpZ2dlcmVkLCB5b3Ugd2lsbCBzZWUuCgoKCj4gPgo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgdGhlCj4gPiA+ID4gPiBldmVudF90cmlnZ2Vy
ZWQgaXMgc29tZWhvdyBkdXBsaWNhdGVkIHdpdGggdGhlCj4gPiA+ID4gPiBWUklOR19BVkFJTF9G
X05PX0lOVEVSUlVQVCBpbiB0aGUgY2FzZSBvZiBldmVudCBpbmRleC4gVGhlIGNvcnJlY3QgZml4
Cj4gPiA+ID4gPiBtaWdodCBiZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiAxKSByZW1vdmUgZXZlbnRf
dHJpZ2dlcmVkCj4gPiA+ID4gPiAyKSBzZXQgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgaW4g
YXZhaWxfZmxhZ3Nfc2hhZG93IGluCj4gPiA+ID4gPiB2cmluZ19pbnRlcnJydXB0IGlmIGV2ZW50
IGluZGV4IGlzIHN1cHBvcnRlZAo+ID4gPiA+ID4KPiA+ID4gPiA+ID8KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+IEkgYW0gbm90IHN1cmUgYWxsIHRoaXMgaXMgcmln
aHQgYW5kIEknZCByYXRoZXIgd2UgZm9jdXNlZAo+ID4gPiA+IHBlcmZvcm1hbmNlL2NvcnJlY3Ru
ZXNzIGFuZCBjbGVhbnVwcyBzZXBhcmF0ZWx5Lgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiBCdXQgYmVjYXVzZSBvZiB0aGUgaW50cm9kdWN0aW9u
IG9mIGV2ZW50X3RyaWdnZXJlZCwgaGVyZSwKPiA+ID4gPiA+ID4gdmlydHF1ZXVlX2dldF9idWZf
Y3R4X3NwbGl0ICBjYW5ub3QgYmUgcmVjb2duaXplZAo+ID4gPiA+ID4gPiB0aGF0IHRoZSBpbnRl
cnJ1cHQgaGFzIGJlZW4gdHVybmVkIG9mZi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gaWYgd2Ug
d2FudCAgYW5vdGhlciBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0IGVudHJ5LCBXZSBzaG91bGQgcHJv
YmFibHkKPiA+ID4gPiA+ID4gY2FsbCB2aXJ0cXVldWVfZW5hYmxlX2Ni77yfCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFrX2JhcnJpZXJzLAo+
ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdnJpbmdfdXNl
ZF9ldmVudCgmdnEtPnNwbGl0LnZyaW5nKSwKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY3B1X3RvX3ZpcnRpbzE2KF92cS0+dmRldiwgdnEtPmxhc3RfdXNl
ZF9pZHgpKTsKPiA+ID4gPiA+ID4gPiA+IEBAIC0xNTI5LDcgKzE1MzAsOCBAQCBzdGF0aWMgdm9p
ZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4g
PiA+ID4gPiA+ID4gPiAgICAgICAgICAqIGJ5IHdyaXRpbmcgZXZlbnQgaW5kZXggYW5kIGZsdXNo
IG91dCB0aGUgd3JpdGUgYmVmb3JlCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAqIHRoZSByZWFk
IGluIHRoZSBuZXh0IGdldF9idWYgY2FsbC4KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICovCj4g
PiA+ID4gPiA+ID4gPiAtICAgICAgIGlmICh2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9
PSBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ERVNDKQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBp
ZiAodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPT0gVlJJTkdfUEFDS0VEX0VWRU5UX0ZM
QUdfREVTQwo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJiYgKHZxLT5l
dmVudF90cmlnZ2VyZWQgPT0gZmFsc2UpKQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
IHZpcnRpb19zdG9yZV9tYih2cS0+d2Vha19iYXJyaWVycywKPiA+ID4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5vZmZf
d3JhcCwKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1
X3RvX2xlMTYodnEtPmxhc3RfdXNlZF9pZHgpKTsKPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiA+ID4gPiAyLjMxLjEKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4K
PiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
