Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1702C001DE
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 11:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DEC341C54;
	Wed, 26 Jul 2023 11:47:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DEC341C54
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dM2xfu81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTw3Zu-sg0Wl; Wed, 26 Jul 2023 11:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77A414190E;
	Wed, 26 Jul 2023 11:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77A414190E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF22C0072;
	Wed, 26 Jul 2023 11:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C425C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7B616118F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7B616118F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dM2xfu81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kFLscRxkm2_j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:47:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1296961105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 11:47:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1296961105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690372065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3mFhfUODa9AHBePAn5JuvXf3BuDvAQZgN52GslCR8I=;
 b=dM2xfu81KMF4FlSeqvHetkUyNHPi9egJgaLUgy1ylaYR6RA91KpUy0IoRUdagqzIq3MqRg
 kvf36QcM0M/shVUBqcAKx9I+pHWw5G1U6CcSIPRCRIE2JTHTy0G3m/SzQrJpu7nRwusBEY
 t1t4kz7oytWN0dfzFx6yXfOWWGtzwjQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-h3p7kmx5MxCbkEouN9yIkA-1; Wed, 26 Jul 2023 07:47:43 -0400
X-MC-Unique: h3p7kmx5MxCbkEouN9yIkA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fbcdca9080so6017810e87.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 04:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690372062; x=1690976862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3mFhfUODa9AHBePAn5JuvXf3BuDvAQZgN52GslCR8I=;
 b=ClDmjCVdri3RENd6FrhgicrObLtMWi4IX3H+IezPAbnxZ/+M6+SKvs2mOlSDNdvxWU
 Gt1rlv/gCUlUSPmNR30UujzA8UeEadL2UqWWzjVckEdf5DDAUATbqRgPak3BYjqyi5m3
 G+Xnus+U6WXdAk9f96Cc0rPVpi3AXv9LzUo8aqhyE7blwbLvvs7AlW96YhuiZSDNlFka
 WxcIz3NrKCBuD01vTcjswJ3tVmp4+8p+3RA53Dgl6YcGR3vWbI7XFUk993fYCOowyd6a
 2diExksoWQDO2tS6U8syixyECSYIBzzEgJ0VWXYmIYy9qdZD2PvClM5UmrzKPm0l9avc
 dwXw==
X-Gm-Message-State: ABy/qLbTvzLwD7Y3F2aRuZchJyssKKUZ1AAclxkhT2BLG5fLijCmbHp5
 uXFmyxAz+z924+Z85CzGFtEWEl2aj+Gkjoeoxy5WsfEuBCuOE4/JMjzVjphNduEu4tRyd1/1GsV
 tqNoOvrlC1qtSbBPiLPMbHthHkmgqoUyOWAUNwIBq5Q==
X-Received: by 2002:a2e:9010:0:b0:2b6:df71:cff1 with SMTP id
 h16-20020a2e9010000000b002b6df71cff1mr1183832ljg.52.1690372061940; 
 Wed, 26 Jul 2023 04:47:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZIYBUdk56Yixlv7wviIYYWzDYfAykO70CSNJ5wRKXhKuZmsrVQQWEhJ444sYuY777oK81Vg==
X-Received: by 2002:a2e:9010:0:b0:2b6:df71:cff1 with SMTP id
 h16-20020a2e9010000000b002b6df71cff1mr1183817ljg.52.1690372061563; 
 Wed, 26 Jul 2023 04:47:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a2e8557000000b002b6e13fcedcsm4149437ljj.122.2023.07.26.04.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 04:47:36 -0700 (PDT)
Date: Wed, 26 Jul 2023 07:47:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230726074710-mutt-send-email-mst@kernel.org>
References: <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
 <20230724050005-mutt-send-email-mst@kernel.org>
 <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
 <20230724160836-mutt-send-email-mst@kernel.org>
 <00e14bc9e9a1f3749be62cbefc7adfaa1ba2d81c.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <00e14bc9e9a1f3749be62cbefc7adfaa1ba2d81c.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMDg6MjY6MzJBTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEg
d3JvdGU6Cj4gT24gTW9uLCAyMDIzLTA3LTI0IGF0IDE2OjA4IC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAxMTo0Mjo0MkFNICswMDAw
LCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPiA+ID4gT24gTW9uLCAyMDIzLTA3LTI0IGF0IDA1OjE2
IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBKdWwgMjQs
IDIwMjMgYXQgMDg6Mzg6MDRBTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4gPiA+ID4g
PiAKPiA+ID4gPiA+IE9uIE1vbiwgMjAyMy0wNy0yNCBhdCAxNToxMSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gT24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgNjowMuKAr1BNIE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDA1OjQ4OjQ2
UE0gKzA4MDAsIExpbiBNYSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
PiBTdXJlLCB0aGF0IGlzIGFub3RoZXIgdW5kZXJnb2luZyB0YXNrIEknbSB3b3JraW5nIG9uLiBJ
ZiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gbmxhdHRyCj4gPiA+ID4gPiA+ID4gPiA+IGlzCj4gPiA+
ID4gPiA+ID4gPiA+IHBhcnNlZCB3aXRoCj4gPiA+ID4gPiA+ID4gPiA+IE5MX1ZBTElEQVRFX1VO
U1BFQywgYW55IGZvcmdvdHRlbiBubGF0dHIgd2lsbCBiZSByZWplY3RlZCwKPiA+ID4gPiA+ID4g
PiA+ID4gdGhlcmVmb3JlCj4gPiA+ID4gPiA+ID4gPiA+ICh3aGljaCBpcyB0aGUgZGVmYXVsdAo+
ID4gPiA+ID4gPiA+ID4gPiBmb3IgbW9kZXJuIG5sYV9wYXJzZSkuCj4gPiA+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gPiA+IEZvciB0aGUgZ2VuZXJhbCBuZXRsaW5rIGludGVyZmFjZSwgdGhlIGRl
Y2lkaW5nIGZsYWcgc2hvdWxkIGJlCj4gPiA+ID4gPiA+ID4gPiBnZW5sX29wcy52YWxpZGF0ZSBk
ZWZpbmVkIGluCj4gPiA+ID4gPiA+ID4gPiBlYWNoIG9wcy4gVGhlIGRlZmF1bHQgdmFsaWRhdGUg
ZmxhZyBpcyBzdHJpY3QsIHdoaWxlIHRoZSBkZXZlbG9wZXIKPiA+ID4gPiA+ID4gPiA+IGNhbgo+
ID4gPiA+ID4gPiA+ID4gb3ZlcndyaXRlIHRoZSBmbGFnCj4gPiA+ID4gPiA+ID4gPiB3aXRoIEdF
TkxfRE9OVF9WQUxJREFURV9TVFJJQ1QgdG8gZWFzZSB0aGUgdmFsaWRhdGlvbi4gVGhhdCBpcyB0
bwo+ID4gPiA+ID4gPiA+ID4gc2F5LAo+ID4gPiA+ID4gPiA+ID4gc2FmZXIgY29kZSBzaG91bGQK
PiA+ID4gPiA+ID4gPiA+IGVuZm9yY2UgTkxfVkFMSURBVEVfU1RSSUNUIGJ5IG5vdCBvdmVyd3Jp
dGluZyB0aGUgdmFsaWRhdGUgZmxhZy4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
UmVncmFkcwo+ID4gPiA+ID4gPiA+ID4gTGluCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gT2ggSSBzZWUuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gSXQg
c3RhcnRlZCBoZXJlOgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IGNvbW1pdCAzM2IzNDc1
MDNmMDE0ZWJmNzYyNTczMjdjYmM3MDAxYzZiNzIxOTU2Cj4gPiA+ID4gPiA+ID4gQXV0aG9yOiBQ
YXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gPiA+ID4gPiA+ID4gRGF0ZTrCoMKgIFR1
ZSBKYW4gNSAxMjozMjowMCAyMDIxICswMjAwCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
wqDCoMKgIHZkcGE6IERlZmluZSB2ZHBhIG1nbXQgZGV2aWNlLCBvcHMgYW5kIGEgbmV0bGluayBp
bnRlcmZhY2UKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiB3aGljaCBkaWQ6Cj4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnZhbGlk
YXRlID0gR0VOTF9ET05UX1ZBTElEQVRFX1NUUklDVCB8Cj4gPiA+ID4gPiA+ID4gR0VOTF9ET05U
X1ZBTElEQVRFX0RVTVAsCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gd2hpY2ggd2FzIG1vc3QgbGlrZWx5IGp1c3QgYSBjb3B5IHBhc3RlIGZyb20gc29tZXdoZXJl
LCByaWdodCBQYXJhdj8KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBhbmQgdGhlbiBldmVy
eW9uZSBrZXB0IGNvcHlpbmcgdGhpcyBhcm91bmQuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gUGFyYXYsIEVsaSBjYW4gd2UgZHJvcCB0aGVzZT8gVGhlcmUncyBhIHRpbnkgY2hhbmNlIG9m
IGJyZWFraW5nCj4gPiA+ID4gPiA+ID4gc29tZXRoaW5nCj4gPiA+ID4gPiA+ID4gYnV0IEkgZmVl
bCB0aGVyZSBhcmVuJ3QgdGhhdCBtYW55IHVzZXJzIG91dHNpZGUgbWx4NSB5ZXQsIHNvIGlmIHlv
dQo+ID4gPiA+ID4gPiA+IGd1eXMgY2FuIHRlc3Qgb24gbWx4NSBhbmQgY29uZmlybSBubyBicmVh
a2FnZSwgSSB0aGluayB3ZSBhcmUgZ29vZC4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEFkZGlu
ZyBEcmFnb3MuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gSSB3aWxsIGNoZWNrLiBKdXN0IHRvIG1h
a2Ugc3VyZSBJIHVuZGVyc3RhbmQgY29ycmVjdGx5OiB5b3Ugd2FudCBtZSB0bwo+ID4gPiA+ID4g
ZHJvcAo+ID4gPiA+ID4gdGhlCj4gPiA+ID4gPiAudmFsaWRhdGUgZmxhZ3MgYWxsIHRvZ2V0aGVy
IGluIGFsbCB2ZHBhIG9wcyBhbmQgY2hlY2ssIHJpZ2h0Pwo+ID4gPiA+ID4gCj4gPiA+ID4gPiBU
aGFua3MsCj4gPiA+ID4gPiBEcmFnb3MKPiA+ID4gPiAKPiA+ID4gPiB5ZXMgLSBJIHN1c3BlY3Qg
eW91IHdpbGwgdGhlbiBuZWVkIHRoaXMgcGF0Y2ggdG8gbWFrZSB0aGluZ3Mgd29yay4KPiA+ID4g
PiAKPiA+ID4gWWVwLiBBZGRpbmcgdGhlIHBhdGNoIGFuZCByZW1vdmluZyB0aGUgLnZhbGlkYXRl
IGNvbmZpZyBvbiB0aGUgdmRwYV9ubF9vcHMKPiA+ID4gc2VlbXMgdG8gd29yayBqdXN0IGZpbmUu
Cj4gPiA+IAo+ID4gPiBUaGFua3MsCj4gPiA+IERyYWdvcwo+ID4gCj4gPiBPSywgcG9zdCBhIHBh
dGNoPwo+ID4gCj4gU3VyZSwgYnV0IGhvdyBkbyBJIG1ha2UgaXQgZGVwZW5kIG9uIHRoaXMgcGF0
Y2g/IE90aGVyd2lzZSBpdCB3aWxsIGJyZWFrIHRoaW5ncy4KPiAKPiBUaGFua3MsCj4gRHJhZ29z
CgpTZW5kIGEgcGF0Y2ggc2VyaWVzIHdpdGggdGhpcyBhcyBwYXRjaCAxLzIgdGhhdCBvbmUgMi8y
LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
