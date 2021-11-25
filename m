Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EF7C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 08:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B0FC6060F;
	Thu, 25 Nov 2021 08:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgVkcfI9ptWH; Thu, 25 Nov 2021 08:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0820260613;
	Thu, 25 Nov 2021 08:44:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC268C001C;
	Thu, 25 Nov 2021 08:44:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9567CC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8476480D24
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qz6ZTPtbyy1N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:44:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01F0C80CAD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 08:44:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321708898"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="321708898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 00:44:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; d="scan'208";a="571796921"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2021 00:44:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:43:59 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:43:57 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 25 Nov 2021 16:43:55 +0800
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5gD8LVgAADoZqGACr3WnAAAUmcgA
Date: Thu, 25 Nov 2021 08:43:55 +0000
Message-ID: <58911901bd7b4bc3a99642214106bc2f@intel.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
 <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
In-Reply-To: <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "srutherford@google.com" <srutherford@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDI6MzggUE0sIEphc29uIFdhbmcgd3JvdGU6
DQo+ID4gV2UgdGhvdWdodCBhYm91dCB2aXJ0aW8tbW1pby4gVGhlcmUgYXJlIHNvbWUgYmFycmll
cnM6DQo+ID4gMSkgSXQgd2Fzbid0IG9yaWdpbmFsbHkgaW50ZW5kZWQgZm9yIHg4NiBtYWNoaW5l
cy4gVGhlIG9ubHkgbWFjaGluZQ0KPiA+IHR5cGUgaW4gUUVNVSB0aGF0IHN1cHBvcnRzIGl0ICh0
byBydW4gb24geDg2KSBpcyBtaWNyb3ZtLiBCdXQNCj4gPiAibWljcm92bSIgZG9lc27igJl0IHN1
cHBvcnQgVERYIGN1cnJlbnRseSwgYW5kIGFkZGluZyB0aGlzIHN1cHBvcnQgbWlnaHQNCj4gbmVl
ZCBsYXJnZXIgZWZmb3J0Lg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSBtaWNyb3ZtIG5lZWRz
IGxhcmdlciBlZmZvcnQ/IEl0IGxvb2tzIHRvIG1lIGl0IGZpdHMgZm9yIFREWA0KPiBwZXJmZWN0
bHkgc2luY2UgaXQgaGFzIGxlc3MgYXR0YWNrIHN1cmZhY2UuDQoNClRoZSBtYWluIHRoaW5nIGlz
IFREVkYgZG9lc27igJl0IHN1cHBvcnQgbWljcm92bSBzbyBmYXIgKHRoZSBiYXNlZCBPVk1GDQpz
dXBwb3J0IGZvciBtaWNyb3ZtIGlzIHN0aWxsIHVuZGVyIHRoZWlyIGNvbW11bml0eSBkaXNjdXNz
aW9uKS4NCg0KRG8geW91IGd1eXMgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gYWRkIHZpcnRpby1t
bWlvIHN1cHBvcnQgZm9yIHEzNT8NCihlLmcuIGNyZWF0ZSBhIHNwZWNpYWwgcGxhdGZvcm0gYnVz
IGluIHNvbWUgZmFzaGlvbiBmb3IgbWVtb3J5IG1hcHBlZCBkZXZpY2VzKQ0KTm90IHN1cmUgaWYg
dGhlIGVmZm9ydCB3b3VsZCBiZSBsYXJnZXIuDQoNClRoYW5rcywNCldlaQ0KDQoNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
