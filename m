Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E06FC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B433E408C4;
	Tue,  9 Aug 2022 21:32:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B433E408C4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nh9GYT4X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKhtAKS85xuy; Tue,  9 Aug 2022 21:32:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EC2A408A7;
	Tue,  9 Aug 2022 21:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EC2A408A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F576C0032;
	Tue,  9 Aug 2022 21:32:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC68CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5544408A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:32:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5544408A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wHeInF7W-mjt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:32:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 545E9408A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 545E9408A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660080729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiBPmJ48CQoZc0m6Jvy6S/1nWru49rM9QivPLMjHG7U=;
 b=Nh9GYT4XHVUUmj+WMfz+U+PffHlNnFWVRwm7K5Oc7RWha601kRt3CbUQxmirojM8sW8/ct
 LEamgPvHQAzWeDDDvnzm7Bfur7fkDY9sO3ffxhsi/3P3wmvN62n2+D7O//IJ347mpoTkxA
 rQ26rUoxqz6eGMr0Yndkli/bG94ZA/o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-0dou0SDiOxyb1qaHitxZTQ-1; Tue, 09 Aug 2022 17:32:08 -0400
X-MC-Unique: 0dou0SDiOxyb1qaHitxZTQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 oz39-20020a1709077da700b007313bf43f0dso2198304ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 14:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=hiBPmJ48CQoZc0m6Jvy6S/1nWru49rM9QivPLMjHG7U=;
 b=WGAiHod5NT4HQAkxDtROYZcaiJbhyhO6qToVlH20jOU9ze0u6T6bmnN+lxo3st6PbO
 /+gJe1ag1cIzklPVv1/LehRVEnc2Ld5aBmDhT53/SUKJ3AlRz6fO+JYTQhzPTd68Qx6Q
 SSfHaYClRlaE1n1/QtZhV8ukv4nCv/ZdgCvD1TjH36bsYKy3V2ztcTHYDprqZISoFNKC
 RQaF9yQ7/d7HRzeL2KuX0aD4ZxwaT5O3ICg2Kh9ppsnAputa82DAqlWnH1yWkxT2F4G4
 eOpFzWPxHonKik/DjsxRnR8OqhQz7ykIt8JJC/LdmtHpHVBksBO2RjHySZWOxXDevLTK
 59EA==
X-Gm-Message-State: ACgBeo00Y57UkLSV75PysjU91e13rMv2y1jWSfOj3dJVMmi4cHSh5uau
 OlIGRxLs+8eegGr+NwIplv+D/UUglYPzxL4Elex4dmzcCSJY7avFZ2rjpeAQm6FgX+HpOlNVwxc
 22JGa5eXpe/B4W2HXmXjE7+V+8djOtnshaxnaWDW7jg==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id
 wt14-20020a170906ee8e00b007304a24f311mr18975823ejb.420.1660080727347; 
 Tue, 09 Aug 2022 14:32:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49JnZzMIbOtW0i0RxnIdVKiHdxwZb87DJ/K9P6cNpQlfJlh8uubgwQDmA+I7dalCpwWfbfyQ==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id
 wt14-20020a170906ee8e00b007304a24f311mr18975804ejb.420.1660080727116; 
 Tue, 09 Aug 2022 14:32:07 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 2-20020a170906300200b0073093b588besm1553944ejz.170.2022.08.09.14.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 14:32:06 -0700 (PDT)
Date: Tue, 9 Aug 2022 17:32:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809173024-mutt-send-email-mst@kernel.org>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
 <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
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

T24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDk6MTM6NDJQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+ID4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgNDozMyBQTQo+ID4gCj4gPiBPbiA4LzkvMjAyMiAx
MjoxOCBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPj4gRnJvbTogU2ktV2VpIExpdSA8c2kt
d2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gPj4gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIg
MzowOSBQTQo+ID4gPj4+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+
Cj4gPiA+Pj4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDI6MzkgUE0gQ3VycmVudGx5
IGl0IGlzIG5vdC4gTm90IGEKPiA+ID4+Pj4gc2luZ2xlIHBhdGNoIG5vciB0aGlzIHBhdGNoLCBi
dXQgdGhlIGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBnb2FsCj4gPiA+Pj4+IGlzIHRvIGFsbG93
IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiBndWVzdCB1c2VycyBpbnRlbnRpb25hbGx5Cj4g
PiA+Pj4+IGxvd2VyIGRvd24gTVRVIHRvIDE1MDAuCj4gPiA+Pj4gV2hpY2ggYXBwbGljYXRpb24g
YmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0bwo+ID4gPj4+IDE1
MDAKPiA+ID4+IHRvIHNlbmQgcGFja2V0cyBidXQgd2FudCB0byByZWNlaXZlIDlLIHBhY2tldHM/
Cj4gPiA+IEJlbG93IGRldGFpbHMgZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5
bW1ldHJ5LiA6KQo+ID4gPgo+ID4gPj4gSSB0aGluayB2aXJ0aW8tbmV0IGRyaXZlciBkb2Vzbid0
IGRpZmZlcmVudGlhdGUgTVRVIGFuZCBNUlUsIGluIHdoaWNoCj4gPiA+PiBjYXNlIHRoZSByZWNl
aXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVjZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUK
PiA+ID4+IHdoZW4gbXR1IGlzIGxvd2VyZWQgZG93biB0byAxNTAwIGZyb20gOTAwMC4KPiA+ID4g
SG93PyBEcml2ZXIgcmVkdWNlZCB0aGUgbVh1IHRvIDE1MDAsIHNheSBpdCBpcyBpbXByb3ZlZCB0
byBwb3N0IGJ1ZmZlcnMgb2YKPiA+IDE1MDAgYnl0ZXMuCj4gPiBGb3IgYmlnX3BhY2tldCBwYXRo
LCB5ZXMsIHdlIG5lZWQgaW1wcm92ZW1lbnQ7IGZvciBtZXJnZWFibGUsIGl0J3MKPiA+IGFkYXB0
YWJsZSB0byBhbnkgaW5jb21pbmcgcGFja2V0IHNpemUgc28gMTUwMCBpcyB3aGF0IGl0IGlzIHRv
ZGF5Lgo+ID4gPgo+ID4gPiBEZXZpY2UgZG9lc24ndCBrbm93IGFib3V0IGl0IGJlY2F1c2UgbXR1
IGluIGNvbmZpZyBzcGFjZSBpcyBSTyBmaWVsZC4KPiA+ID4gRGV2aWNlIGtlZXAgZHJvcHBpbmcg
OUsgcGFja2V0cyBiZWNhdXNlIGJ1ZmZlcnMgcG9zdGVkIGFyZSAxNTAwIGJ5dGVzLgo+ID4gPiBU
aGlzIGlzIGJlY2F1c2UgZGV2aWNlIGZvbGxvd3MgdGhlIHNwZWMgIiBUaGUgZGV2aWNlIE1VU1Qg
Tk9UIHBhc3MKPiA+IHJlY2VpdmVkIHBhY2tldHMgdGhhdCBleGNlZWQgbXR1Ii4KPiA+IFJpZ2h0
LCB0aGF0J3Mgd2hhdCBpdCBoYXBwZW5zIHRvZGF5IG9uIGRldmljZSBzaWRlIChpLmUuIHZob3N0
LW5ldCwgYnR3Cj4gPiBtbHg1IHZkcGEgZGV2aWNlIHNlZW1zIHRvIGhhdmUgYSBidWcgbm90IHBy
by1hY3RpdmVseSBkcm9wcGluZyBwYWNrZXRzIHRoYXQKPiA+IGV4Y2VlZCB0aGUgTVRVIHNpemUs
IGNhdXNpbmcgZ3Vlc3QgcGFuaWMgaW4gc21hbGwgcGFja2V0IHBhdGgpLgo+ID4gPgo+ID4gPiBT
bywgSSBhbSBsb3N0IHdoYXQgdmlydGlvIG5ldCBkZXZpY2UgdXNlciBhcHBsaWNhdGlvbiBpcyB0
cnlpbmcgdG8gYWNoaWV2ZSBieQo+ID4gc2VuZGluZyBzbWFsbGVyIHBhY2tldHMgYW5kIGRyb3Bw
aW5nIGFsbCByZWNlaXZlIHBhY2tldHMuCj4gPiA+IChpdCBkb2VzbuKAmXQgaGF2ZSBhbnkgcmVs
YXRpb24gdG8gbWVyZ2VhYmxlIG9yIG90aGVyd2lzZSkuCj4gPiAKPiA+IFVzdWFsbHksIHRoZSB1
c2UgY2FzZSBJJ20gYXdhcmUgb2Ygd291bGQgc2V0IHRoZSBwZWVyJ3MgTVRVIHRvIDE1MDAgKGUu
Zy4gb24KPiA+IGEgdmlydHVhbCBuZXR3b3JrIGFwcGxpYW5jZSksIG9yIGl0IHdvdWxkIHJlbHkg
b24gcGF0aCBtdHUgZGlzY292ZXJ5IHRvIGF2b2lkCj4gPiBwYWNrZXQgZHJvcCBhY3Jvc3MgbGlu
a3MuCj4gT2suIFNvbWVob3cgdGhlIGFwcGxpY2F0aW9uIGtub3dzIHRoZSBtdHUgdG8gc2V0IG9u
IChhbGwpIHBlZXIocykgYW5kIGhvcGUgZm9yIHRoZSBiZXN0Lgo+IFVuZGVyc3Rvb2QuCgpUaGF0
J3MgZ2VuZXJhbGx5IHdoYXQgb25lIGhhcyB0byBkbyB3aXRoIG10dSwgeWVzIC0gaXQgaGFzIHRv
IGJlIHNldApjb25zaXN0ZW50bHkgYWNyb3NzIHRoZSBMQU4uIFdoaWxlIGUuZy4gcE1UVSBtaWdo
dCBoZWxwIHdvcmsgYXJvdW5kIHNvbWUKbWlzY29uZmlndXJlZCBMQU5zIHdpdGggYSBtaXggb2Yg
ZGlmZmVyZW50IE1UVXMgaXQgd2FzIG5ldmVyIGRlc2lnbmVkCmZvciB0aGF0LgoKLS0gCk1TVAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
