Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D87C53210
	for <virtualization@archiver.kernel.org>; Tue,  3 Jan 2023 08:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D8F160C0C;
	Tue,  3 Jan 2023 08:15:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D8F160C0C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9fUMxuF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ico6EXQn2I7r; Tue,  3 Jan 2023 08:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7ABD460E39;
	Tue,  3 Jan 2023 08:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7ABD460E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54EF9C0033;
	Tue,  3 Jan 2023 08:15:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A86C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 08:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6DB4416B4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 08:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6DB4416B4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9fUMxuF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P0KhfVJHddm0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 08:15:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1D81416A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1D81416A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672733740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBT39XTMOmL9bhDcTUw+nP4DkA+kGa0L8uAe6X+hHsI=;
 b=i9fUMxuFb2rsUhoj32utrqzFLGkfptBU447keplvilet+Jc5H0RM4EDM6K0e/8fLdF572K
 +eljeA1Ph21SQzL7l6A9P+VtzwD0GiKWV4pCtmiri7ytNSnLcsqdMfjBdvBxkJvsiPUbmg
 kxlSBqaFh70gr53+7B7N2XAh2jwwIcI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-b-QILhgEMfaUFtQXqotraA-1; Tue, 03 Jan 2023 03:15:39 -0500
X-MC-Unique: b-QILhgEMfaUFtQXqotraA-1
Received: by mail-ot1-f69.google.com with SMTP id
 g108-20020a9d12f5000000b006842c75ea63so2467395otg.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 00:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBT39XTMOmL9bhDcTUw+nP4DkA+kGa0L8uAe6X+hHsI=;
 b=gqA/cBMLj66HHSrxx1Sva5pl2poz0BFGM+HFlmB5YHXe1civSDjq7RHV3aCWHJtkFy
 jl444nIKJay/IYwS8nOsUn1pypquihYpgrNFM+y89dpY+V4Zunu25sKUKtnZgL1YrsYw
 okfD3pNOEzH8fF8NbRYuwRNTRHt6d9e+8z4C/BDsWpYav63ekkDpnJ4m/uTGEXESFkcb
 mFrYFskKLn6ppS4bO2cIMIo9a+5iF95yh4TFoFZ7di0udffmqJhpcELU5LfwrUSm0qW+
 hgWjvlrC12k9HHjWGkrLw9CE2u926LUDyGcWQsaug/fMyppOg2bLZrir5RDqY6SrM2rm
 4Jdw==
X-Gm-Message-State: AFqh2krU9mpZ3e4NA7jqjE1EHG3S8I08WG+fKVahs9ghLsh1GfQkz775
 KVfVMosS3FcY7zn02v7iIUbz8IPy91QuxiN0CdywC4Kn3JZYitvusvpqSxFkIIuSga6yw0pSRYu
 8yiDEYBtEXPFO8NN1wTqSxyLU3WmYVUVn1SUNYJlo+ahe1maYQhbivgw2QQ==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr2155880oah.35.1672733738755; 
 Tue, 03 Jan 2023 00:15:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1GGmg1HASqnfcpH0pIPC6Y5Ny3UPmj9l/BMmRYuoACIiumpcxK4Yyf7lIpX4Hm9LZeX5hxpzoMD0D+cVTdXk=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr2155877oah.35.1672733738512; Tue, 03
 Jan 2023 00:15:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
 <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
 <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
 <BY5PR11MB4401D90E9853727F06B309CFEAF79@BY5PR11MB4401.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB4401D90E9853727F06B309CFEAF79@BY5PR11MB4401.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jan 2023 16:15:27 +0800
Message-ID: <CACGkMEuP9DaWq7kiFrkYqt2CxwuTqc4iMpypUOLLLzBzn1rm2Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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

T24gVHVlLCBKYW4gMywgMjAyMyBhdCAxMjo1MiBBTSBCb2V1ZiwgU2ViYXN0aWVuCjxzZWJhc3Rp
ZW4uYm9ldWZAaW50ZWwuY29tPiB3cm90ZToKPgo+IEhpIEphc29uLAo+Cj4gQXJlIHlvdSBzdWdn
ZXN0aW5nIHdlIGRvIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc6Cj4KPiBpZiAoKCF2ZHBh
c2ltLT5ydW5uaW5nKSAmJiAodmRwYXNpbS0+c3RhdHVzID09IERSSVZFUl9PSykpIHsKPiDigILi
gILigILigILigILigIJ2ZHBhc2ltLT5wZW5kaW5nX2tpY2sgPSB0cnVlOwo+IOKAguKAguKAguKA
guKAguKAgnJldHVybjsKPiB9Cj4KPiA/CgpZZXMuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gU2Vi
YXN0aWVuCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBGcm9tOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNywgMjAy
MiA4OjQzIEFNCj4gVG86IEJvZXVmLCBTZWJhc3RpZW4gPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5j
b20+Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyA8
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+OyBtc3RAcmVkaGF0LmNv
bSA8bXN0QHJlZGhhdC5jb20+OyBlcGVyZXptYUByZWRoYXQuY29tIDxlcGVyZXptYUByZWRoYXQu
Y29tPgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNC80XSB2ZHBhX3NpbTogSW1wbGVtZW50IHJl
c3VtZSB2ZHBhIG9wCj4KPiBPbiBXZWQsIE9jdCAyNiwgMjAyMiBhdCAxMTowOSBQTSA8c2ViYXN0
aWVuLmJvZXVmQGludGVsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gRnJvbTogU2ViYXN0aWVuIEJvZXVm
IDxzZWJhc3RpZW4uYm9ldWZAaW50ZWwuY29tPgo+ID4KPiA+IEltcGxlbWVudCByZXN1bWUgb3Bl
cmF0aW9uIGZvciB2ZHBhX3NpbSBkZXZpY2VzLCBzbyB2aG9zdC12ZHBhIHdpbGwKPiA+IG9mZmVy
IHRoYXQgYmFja2VuZCBmZWF0dXJlIGFuZCB1c2Vyc3BhY2UgY2FuIGVmZmVjdGl2ZWx5IHJlc3Vt
ZSB0aGUKPiA+IGRldmljZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpZW4gQm9ldWYg
PHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ICBk
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaCB8ICAxICsKPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDI5IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4g
aW5kZXggYjA3MWYwZDg0MmZiLi44NGZlZThiYjI5MjkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMKPiA+IEBAIC0zNTcsNiArMzU3LDExIEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1f
a2lja192cShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgpCj4gPiAgICAgICAgIHN0
cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gPiAgICAgICAgIHN0
cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2lkeF07Cj4gPgo+ID4g
KyAgICAgICBpZiAoIXZkcGFzaW0tPnJ1bm5pbmcpIHsKPiA+ICsgICAgICAgICAgICAgICB2ZHBh
c2ltLT5wZW5kaW5nX2tpY2sgPSB0cnVlOwo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPgo+
IEkgdGhpbmsgd2UgbWF5IGhpdCBoZXJlIHdoZW4gdGhlIGRyaXZlciBraWNrcyB2cSBiZWZvcmUg
RFJJVkVSX09LLiBEbwo+IHdlIG5lZWQgdG8gY2hlY2sgZGV2aWNlIHN0YXR1cyBpbiB0aGlzIGNh
c2UgYW5kIHJlc3VtZT8KPgo+IFRoYW5rcwo+Cj4gPiArICAgICAgIH0KPiA+ICsKPiA+ICAgICAg
ICAgaWYgKHZxLT5yZWFkeSkKPiA+ICAgICAgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZ2ZHBh
c2ltLT53b3JrKTsKPiA+ICB9Cj4gPiBAQCAtNTI3LDYgKzUzMiwyNyBAQCBzdGF0aWMgaW50IHZk
cGFzaW1fc3VzcGVuZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gPiAgICAgICAgIHJldHVy
biAwOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIGludCB2ZHBhc2ltX3Jlc3VtZShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ID4gKyAgICAgICBpbnQgaTsKPiA+ICsKPiA+ICsgICAg
ICAgc3Bpbl9sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPiA+ICsgICAgICAgdmRwYXNpbS0+cnVubmlu
ZyA9IHRydWU7Cj4gPiArCj4gPiArICAgICAgIGlmICh2ZHBhc2ltLT5wZW5kaW5nX2tpY2spIHsK
PiA+ICsgICAgICAgICAgICAgICAvKiBQcm9jZXNzIHBlbmRpbmcgZGVzY3JpcHRvcnMgKi8KPiA+
ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmRwYXNpbS0+ZGV2X2F0dHIubnZxczsg
KytpKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdmRwYXNpbV9raWNrX3ZxKHZkcGEsIGkp
Owo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgIHZkcGFzaW0tPnBlbmRpbmdfa2ljayA9IGZhbHNl
Owo+ID4gKyAgICAgICB9Cj4gPiArCj4gPiArICAgICAgIHNwaW5fdW5sb2NrKCZ2ZHBhc2ltLT5s
b2NrKTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIDA7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRp
YyBzaXplX3QgdmRwYXNpbV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
KQo+ID4gIHsKPiA+ICAgICAgICAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3Np
bSh2ZHBhKTsKPiA+IEBAIC03MTcsNiArNzQzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgdmRwYXNpbV9jb25maWdfb3BzID0gewo+ID4gICAgICAgICAuc2V0X3N0YXR1
cyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X3N0YXR1cywKPiA+ICAgICAgICAgLnJlc2V0ICAg
ICAgICAgICAgICAgICAgPSB2ZHBhc2ltX3Jlc2V0LAo+ID4gICAgICAgICAuc3VzcGVuZCAgICAg
ICAgICAgICAgICA9IHZkcGFzaW1fc3VzcGVuZCwKPiA+ICsgICAgICAgLnJlc3VtZSAgICAgICAg
ICAgICAgICAgPSB2ZHBhc2ltX3Jlc3VtZSwKPiA+ICAgICAgICAgLmdldF9jb25maWdfc2l6ZSAg
ICAgICAgPSB2ZHBhc2ltX2dldF9jb25maWdfc2l6ZSwKPiA+ICAgICAgICAgLmdldF9jb25maWcg
ICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9jb25maWcsCj4gPiAgICAgICAgIC5zZXRfY29uZmln
ICAgICAgICAgICAgID0gdmRwYXNpbV9zZXRfY29uZmlnLAo+ID4gQEAgLTc1MCw2ICs3NzcsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZp
Z19vcHMgPSB7Cj4gPiAgICAgICAgIC5zZXRfc3RhdHVzICAgICAgICAgICAgID0gdmRwYXNpbV9z
ZXRfc3RhdHVzLAo+ID4gICAgICAgICAucmVzZXQgICAgICAgICAgICAgICAgICA9IHZkcGFzaW1f
cmVzZXQsCj4gPiAgICAgICAgIC5zdXNwZW5kICAgICAgICAgICAgICAgID0gdmRwYXNpbV9zdXNw
ZW5kLAo+ID4gKyAgICAgICAucmVzdW1lICAgICAgICAgICAgICAgICA9IHZkcGFzaW1fcmVzdW1l
LAo+ID4gICAgICAgICAuZ2V0X2NvbmZpZ19zaXplICAgICAgICA9IHZkcGFzaW1fZ2V0X2NvbmZp
Z19zaXplLAo+ID4gICAgICAgICAuZ2V0X2NvbmZpZyAgICAgICAgICAgICA9IHZkcGFzaW1fZ2V0
X2NvbmZpZywKPiA+ICAgICAgICAgLnNldF9jb25maWcgICAgICAgICAgICAgPSB2ZHBhc2ltX3Nl
dF9jb25maWcsCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmggYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+ID4gaW5kZXggMGU3ODczN2Rj
YzE2Li5hNzQ1NjA1NTg5ZTIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uaAo+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiA+
IEBAIC02Nyw2ICs2Nyw3IEBAIHN0cnVjdCB2ZHBhc2ltIHsKPiA+ICAgICAgICAgdTY0IGZlYXR1
cmVzOwo+ID4gICAgICAgICB1MzIgZ3JvdXBzOwo+ID4gICAgICAgICBib29sIHJ1bm5pbmc7Cj4g
PiArICAgICAgIGJvb2wgcGVuZGluZ19raWNrOwo+ID4gICAgICAgICAvKiBzcGlubG9jayB0byBz
eW5jaHJvbml6ZSBpb21tdSB0YWJsZSAqLwo+ID4gICAgICAgICBzcGlubG9ja190IGlvbW11X2xv
Y2s7Cj4gPiAgfTsKPiA+IC0tCj4gPiAyLjM0LjEKPiA+Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IElu
dGVsIENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZpZWQgam9pbnQgc3RvY2sgY29tcGFu
eSkKPiA+IFJlZ2lzdGVyZWQgaGVhZHF1YXJ0ZXJzOiAiTGVzIE1vbnRhbGV0cyItIDIsIHJ1ZSBk
ZSBQYXJpcywKPiA+IDkyMTk2IE1ldWRvbiBDZWRleCwgRnJhbmNlCj4gPiBSZWdpc3RyYXRpb24g
TnVtYmVyOiAgMzAyIDQ1NiAxOTkgUi5DLlMuIE5BTlRFUlJFCj4gPiBDYXBpdGFsOiA1IDIwOCAw
MjYuMTYgRXVyb3MKPiA+Cj4gPiBUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBj
b250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKPiA+IHRoZSBzb2xlIHVzZSBvZiB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbgo+ID4gYnkg
b3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZAo+ID4gcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxs
IGNvcGllcy4KPiA+Cj4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBJbnRlbCBDb3Jwb3JhdGlvbiBTQVMgKEZy
ZW5jaCBzaW1wbGlmaWVkIGpvaW50IHN0b2NrIGNvbXBhbnkpCj4gUmVnaXN0ZXJlZCBoZWFkcXVh
cnRlcnM6ICJMZXMgTW9udGFsZXRzIi0gMiwgcnVlIGRlIFBhcmlzLAo+IDkyMTk2IE1ldWRvbiBD
ZWRleCwgRnJhbmNlCj4gUmVnaXN0cmF0aW9uIE51bWJlcjogIDMwMiA0NTYgMTk5IFIuQy5TLiBO
QU5URVJSRQo+IENhcGl0YWw6IDUgMjA4IDAyNi4xNiBFdXJvcwo+Cj4gVGhpcyBlLW1haWwgYW5k
IGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCj4g
dGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3Ig
ZGlzdHJpYnV0aW9uCj4gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZAo+IHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRl
ciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
