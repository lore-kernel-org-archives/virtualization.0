Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF99C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 23:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EED8F4009E;
	Tue,  9 Aug 2022 23:03:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EED8F4009E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4v13WVt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNVITWNtgICQ; Tue,  9 Aug 2022 23:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFF8E40334;
	Tue,  9 Aug 2022 23:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFF8E40334
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DFEAC0033;
	Tue,  9 Aug 2022 23:03:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B165AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 723738195C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 723738195C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4v13WVt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GM1zVsMtka0P
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:03:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F14481926
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F14481926
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660086195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dB8DtdFIR5845rfyCyVPy/T7oF4TwroIO3oXHVl5Zr0=;
 b=b4v13WVtiT0j2fPk7mWZJpaldzehmboSOiFbmoAba6LrGn/+QPP7tAlbwfs11Sh/yJA5fS
 We7nn4ehvSwICo/+hqm1eXJq2ATq8RVlOwbbOyvqjA/KX6AVCIsT5KZQV+v5B6ekNJeDcb
 3aB0rB+erVbGadT3Gy/k5fVRkBdasNg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-50Sw2JQ1PXiKbvo7CxvbcA-1; Tue, 09 Aug 2022 19:03:14 -0400
X-MC-Unique: 50Sw2JQ1PXiKbvo7CxvbcA-1
Received: by mail-ej1-f71.google.com with SMTP id
 nb10-20020a1709071c8a00b006e8f89863ceso3741635ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 16:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=dB8DtdFIR5845rfyCyVPy/T7oF4TwroIO3oXHVl5Zr0=;
 b=Nt4Nnr7kL0IBVzykoc3x/cIyaUcwRj/Ln5dn3zZENcaB78jb8nh0dlM+/dt5LOPel7
 dzhXy1C4BmYFUaXjhtYb3SuFzIv0qSPZQtj1HANOsdLxSFWmLxQhHF8cCIsX2XGr0JME
 qoedrrK04DaVXHuGKSvF85E0/rw+9R+I63wX/GO8kYChn7vTWfsc208zWXwgxygISNI5
 92c/HXzwm6e1qoEC9wBR7Izw16u01teZmBeaEJ9prNhyJQYicf9mjxkpOT8+iPPZwUGo
 qI5ShyhGVeqiY5jkqaYT0BLuqGc3eq4/GvrgRCqCWmbStDwWpLzFj3MX051UmzeHsZ1Y
 hNCA==
X-Gm-Message-State: ACgBeo01qtvDbHdkkwHunoWx4GlujCHl6jAvVVqpS66kwPelM960CgxJ
 kkVzzowm3wqZTUBZl4hWU1fmHxQMvqz+lfirlANXXnoXKo4Hy2jvUTbJYGLW3Rus1wLu6xu0uYp
 PghLhD3Z5kTNt164uRnH7nVT63nVaCP2+MhM1RaYK4w==
X-Received: by 2002:a05:6402:1cc4:b0:440:5af8:41c9 with SMTP id
 ds4-20020a0564021cc400b004405af841c9mr15748673edb.339.1660086193654; 
 Tue, 09 Aug 2022 16:03:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5MEzi986rayK1XTUXbjmF0RPHv5oqNxgBKGzDfDMZHVnEEHEobmn6ENnLyh93SNSwv6im8HA==
X-Received: by 2002:a05:6402:1cc4:b0:440:5af8:41c9 with SMTP id
 ds4-20020a0564021cc400b004405af841c9mr15748662edb.339.1660086193486; 
 Tue, 09 Aug 2022 16:03:13 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 da13-20020a056402176d00b00442b388c743sm377956edb.14.2022.08.09.16.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 16:03:12 -0700 (PDT)
Date: Tue, 9 Aug 2022 19:03:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809190206-mutt-send-email-mst@kernel.org>
References: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
 <20220809183516-mutt-send-email-mst@kernel.org>
 <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDM6NTQ6NTdQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA4LzkvMjAyMiAzOjM3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBUdWUsIEF1ZyAwOSwgMjAyMiBhdCAwMzozMjoyNlBNIC0wNzAwLCBTaS1XZWkgTGl1
IHdyb3RlOgo+ID4gPiAKPiA+ID4gT24gOC85LzIwMjIgMjozNyBQTSwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgQXVnIDA5LCAyMDIyIGF0IDA3OjE4OjMwUE0gKzAw
MDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4gPiA+ID4gRnJvbTogU2ktV2VpIExpdSA8c2kt
d2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgOSwg
MjAyMiAzOjA5IFBNCj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+Cj4gPiA+ID4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgOSwgMjAy
MiAyOjM5IFBNIEN1cnJlbnRseSBpdCBpcyBub3QuIE5vdCBhCj4gPiA+ID4gPiA+ID4gPiBzaW5n
bGUgcGF0Y2ggbm9yIHRoaXMgcGF0Y2gsIGJ1dCB0aGUgY29udGV4dCBmb3IgdGhlIGV2ZW50dWFs
IGdvYWwgaXMKPiA+ID4gPiA+ID4gPiA+IHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsg
d2hlbiBndWVzdCB1c2VycyBpbnRlbnRpb25hbGx5IGxvd2VyCj4gPiA+ID4gPiA+ID4gPiBkb3du
IE1UVSB0byAxNTAwLgo+ID4gPiA+ID4gPiA+IFdoaWNoIGFwcGxpY2F0aW9uIGJlbmVmaXQgYnkg
aGF2aW5nIGFzeW1tZXRyeSBieSBsb3dlcmluZyBtdHUgdG8gMTUwMAo+ID4gPiA+ID4gPiB0byBz
ZW5kIHBhY2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPwo+ID4gPiA+ID4gQmVs
b3cgZGV0YWlscyBkb2VzbuKAmXQgYW5zd2VyIHRoZSBxdWVzdGlvbiBvZiBhc3ltbWV0cnkuIDop
Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSSB0aGluayB2aXJ0aW8tbmV0IGRyaXZlciBkb2Vzbid0
IGRpZmZlcmVudGlhdGUgTVRVIGFuZCBNUlUsIGluIHdoaWNoIGNhc2UKPiA+ID4gPiA+ID4gdGhl
IHJlY2VpdmUgYnVmZmVyIHdpbGwgYmUgcmVkdWNlZCB0byBmaXQgdGhlIDE1MDBCIHBheWxvYWQg
c2l6ZSB3aGVuIG10dSBpcwo+ID4gPiA+ID4gPiBsb3dlcmVkIGRvd24gdG8gMTUwMCBmcm9tIDkw
MDAuCj4gPiA+ID4gPiBIb3c/IERyaXZlciByZWR1Y2VkIHRoZSBtWHUgdG8gMTUwMCwgc2F5IGl0
IGlzIGltcHJvdmVkIHRvIHBvc3QgYnVmZmVycyBvZiAxNTAwIGJ5dGVzLgo+ID4gPiA+ID4gCj4g
PiA+ID4gPiBEZXZpY2UgZG9lc24ndCBrbm93IGFib3V0IGl0IGJlY2F1c2UgbXR1IGluIGNvbmZp
ZyBzcGFjZSBpcyBSTyBmaWVsZC4KPiA+ID4gPiA+IERldmljZSBrZWVwIGRyb3BwaW5nIDlLIHBh
Y2tldHMgYmVjYXVzZSBidWZmZXJzIHBvc3RlZCBhcmUgMTUwMCBieXRlcy4KPiA+ID4gPiA+IFRo
aXMgaXMgYmVjYXVzZSBkZXZpY2UgZm9sbG93cyB0aGUgc3BlYyAiIFRoZSBkZXZpY2UgTVVTVCBO
T1QgcGFzcyByZWNlaXZlZCBwYWNrZXRzIHRoYXQgZXhjZWVkIG10dSIuCj4gPiA+ID4gVGhlICJt
dHUiIGhlcmUgaXMgdGhlIGRldmljZSBjb25maWcgZmllbGQsIHdoaWNoIGlzCj4gPiA+ID4gCj4g
PiA+ID4gICAgICAgICAgIC8qIERlZmF1bHQgbWF4aW11bSB0cmFuc21pdCB1bml0IGFkdmljZSAq
Lwo+ID4gPiA+IAo+ID4gPiA+IHRoZXJlIGlzIG5vIGd1YXJhbnRlZSBkZXZpY2Ugd2lsbCBub3Qg
Z2V0IGEgYmlnZ2VyIHBhY2tldC4KPiA+ID4gPiBBbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHN1
Y2ggYSBwYWNrZXQgd2lsbCBiZSBkcm9wcGVkCj4gPiA+ID4gYXMgb3Bwb3NlZCB0byB3ZWRnaW5n
IHRoZSBkZXZpY2UgaWYgdXNlcnNwYWNlIGluc2lzdHMgb24KPiA+ID4gPiBhZGRpbmcgc21hbGxl
ciBidWZmZXJzLgo+ID4gPiBJdCdkIGJlIG5pY2UgdG8gZG9jdW1lbnQgdGhpcyByZXF1aXJlbWVu
dCBvciBzdGF0ZW1lbnQgdG8gdGhlIHNwZWMgZm9yCj4gPiA+IGNsYXJpdHkgcHVycG9zZS4KPiA+
IEl0J3Mgbm90IGEgcmVxdWlyZW1lbnQsIG1vcmUgb2YgYSBidWcuIEJ1dCBpdCdzIGJlZW4gbGlr
ZSB0aGlzIGZvcgo+ID4geWVhcnMuCj4gV2VsbCwgSSdtIG5vdCBzdXJlIGhvdyBpdCBtYXkgd2Vk
Z2UgdGhlIGRldmljZSBpZiBub3QgY2FwYWJsZSBvZiBwb3N0aW5nIHRvCj4gc21hbGxlciBidWZm
ZXJzLCBpcyB0aGVyZSBvdGhlciBvcHRpb24gdGhhbiBkcm9wPyBUcnVuY2F0ZSB0byB3aGF0IHRo
ZQo+IGJ1ZmZlciBzaXplIG1heSBmaXQgYW5kIGRlbGl2ZXIgdXA/IFNlZW1zIGV2ZW4gd29yc2Ug
dGhhbiBkcm9wLi4uCj4gCj4gPiAKPiA+ID4gT3RoZXJ3aXNlIHZhcmlvdXMgZGV2aWNlIGltcGxl
bWVudGF0aW9ucyBhcmUgaGFyZCB0bwo+ID4gPiBmb2xsb3cuIFRoZSBjYXB0dXJlIGlzIHRoYXQg
dmhvc3QtbmV0IGRyb3BzIGJpZ2dlciBwYWNrZXRzIHdoaWxlIHRoZSBkcml2ZXIKPiA+ID4gb25s
eSBzdXBwbGllZCBzbWFsbGVyIGJ1ZmZlcnMuIFRoaXMgaXMgdGhlIHN0YXR1cyBxdW8sIGFuZCB1
c2VycyBzZWVtaW5nbHkKPiA+ID4gaGF2ZSByZWxpZWQgb24gdGhpcyBiZWhhdmlvciBmb3Igc29t
ZSB3aGlsZS4KPiA+ID4gCj4gPiA+IC1TaXdlaQo+ID4gV2VpcmQgd2hlcmUgZG8geW91IHNlZSB0
aGlzIGluIGNvZGU/IEkgc2VlCj4gPiAKPiA+ICAgICAgICAgICAgICAgICAgc29ja19sZW4gPSB2
aG9zdF9uZXRfcnhfcGVla19oZWFkX2xlbihuZXQsIHNvY2stPnNrLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZidXN5bG9vcF9pbnRy
KTsKPiA+ICAgICAgICAgICAgICAgICAgaWYgKCFzb2NrX2xlbikKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiA+ICAgICAgICAgICAgICAgICAgc29ja19sZW4gKz0gc29ja19o
bGVuOwo+ID4gICAgICAgICAgICAgICAgICB2aG9zdF9sZW4gPSBzb2NrX2xlbiArIHZob3N0X2hs
ZW47Cj4gPiAgICAgICAgICAgICAgICAgIGhlYWRjb3VudCA9IGdldF9yeF9idWZzKHZxLCB2cS0+
aGVhZHMgKyBudnEtPmRvbmVfaWR4LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aG9zdF9sZW4sICZpbiwgdnFfbG9nLCAmbG9nLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWtlbHkobWVyZ2VhYmxlKSA/IFVJT19NQVhJ
T1YgOiAxKTsKPiA+ICAgICAgICAgICAgICAgICAgLyogT24gZXJyb3IsIHN0b3AgaGFuZGxpbmcg
dW50aWwgdGhlIG5leHQga2ljay4gKi8KPiA+ICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5
KGhlYWRjb3VudCA8IDApKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+
ID4gCj4gPiAKPiA+IHNvIGl0IGRvZXMgbm90IGRyb3AgYSBwYWNrZXQsIGl0IGp1c3Qgc3RvcHMg
cHJvY2Vzc2luZyB0aGUgcXVldWUuCj4gSGVyZQo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBPbiBvdmVycnVuLCB0cnVuY2F0ZSBhbmQgZGlzY2FyZCAqLwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoaGVhZGNvdW50ID4gVUlPX01BWElP
VikpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlv
dl9pdGVyX2luaXQoJm1zZy5tc2dfaXRlciwgUkVBRCwgdnEtPmlvdiwgMSwgMSk7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBzb2NrLT5vcHMt
PnJlY3Ztc2coc29jaywgJm1zZywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMSwgTVNHX0RPTlRXQUlUIHwKPiBNU0dfVFJVTkMpOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZGVidWcoIkRpc2NhcmRlZCByeCBwYWNr
ZXQ6IGxlbiAlemRcbiIsCj4gc29ja19sZW4pOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPiAKPiByZWN2bXNnKCwgLCAxLCApIGlzIGVzc2VudGlhbGx5IHRvIGRyb3AgdGhl
IG92ZXJzaXplZCBwYWNrZXQuCj4gCj4gCj4gSW4gZ2V0X3J4X2J1ZnMoKSwgb3ZlcnJ1biBkZXRl
Y3Rpb24gd2lsbCByZXR1cm4gc29tZXRoaW5nIGxhcmdlciB0aGFuCj4gVUlPX01BWElPViBhcyBp
bmRpY2F0b3I6Cj4gCj4gc3RhdGljIGludCBnZXRfcnhfYnVmcygpCj4gewo+IDoKPiA7Cj4gwqDC
oMKgwqDCoMKgwqAgLyogRGV0ZWN0IG92ZXJydW4gKi8KPiDCoMKgwqDCoMKgwqDCoCBpZiAodW5s
aWtlbHkoZGF0YWxlbiA+IDApKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIg
PSBVSU9fTUFYSU9WICsgMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnI7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+IDoKPiA6Cj4gCj4gCj4gLVNpd2VpCgoKSG1tIHlvdSBh
cmUgcmlnaHQuIEknbGwgY2hlY2sgYnV0IGl0IHNlZW1zIEkgaGF2ZSBtaXNyZWFkIHRoZSBjb2Rl
LgpTb3JyeSBhYm91dCB3YXN0aW5nIHlvdXIgdGltZSBvbiB0aGlzLgpTbyBtYXliZSB0aGUgYXBw
cm9hY2ggaXMgb2sgdGhlbi4KSXQncyBsYXRlLCBJJ2xsIHJlY2hlY2sgdG9tb3Jyb3cuCgoKPiA+
IAo+ID4gCj4gPiA+ID4gCj4gPiA+ID4gPiBTbywgSSBhbSBsb3N0IHdoYXQgdmlydGlvIG5ldCBk
ZXZpY2UgdXNlciBhcHBsaWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNoaWV2ZSBieSBzZW5kaW5nIHNt
YWxsZXIgcGFja2V0cyBhbmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUgcGFja2V0cy4KPiA+ID4gPiA+
IChpdCBkb2VzbuKAmXQgaGF2ZSBhbnkgcmVsYXRpb24gdG8gbWVyZ2VhYmxlIG9yIG90aGVyd2lz
ZSkuCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gVG8gdW5zdWJzY3JpYmUsIGUtbWFpbDog
dmlydGlvLWRldi11bnN1YnNjcmliZUBsaXN0cy5vYXNpcy1vcGVuLm9yZwo+ID4gPiA+IEZvciBh
ZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1v
cGVuLm9yZwo+ID4gPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
