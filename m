Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B2CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A8E880B06;
	Wed, 23 Feb 2022 03:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bd1ix2rjie6D; Wed, 23 Feb 2022 03:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D30FD80AF6;
	Wed, 23 Feb 2022 03:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 946A5C0021;
	Wed, 23 Feb 2022 03:53:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 983F2C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8671780AFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkK7Cohrvg_f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D089380AF6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645588432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uuENq0mwZK3ocIAxn7hRMdyfy5YF/bh1dVB+AAu0W0=;
 b=JyZzjG0y97hELvKz5mQ7Yxw4WJ/2rF6lSqM5Td3wQYG1FGZnpCH494oRXxDrX5GVPyYCIG
 BrmNqLpbO1V6GWwFoWf6TklQ5M/ORqy5lgH1ND4Om+Z2xX2mQ+3tUCzigsRjnAy2Alc8kG
 S+GY1UGkzOE8yGHQHmlXlzuppGQMPYI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-tNN0dgtJMRK3jmK8Px4avQ-1; Tue, 22 Feb 2022 22:53:49 -0500
X-MC-Unique: tNN0dgtJMRK3jmK8Px4avQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 d1-20020a0565123d0100b004433d2e2fd0so3064318lfv.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3uuENq0mwZK3ocIAxn7hRMdyfy5YF/bh1dVB+AAu0W0=;
 b=jbC3Ftgcs2F0qxrMkmacinkpls+iHzV75igrynSHmDUDieR8c1q9BmN81z0AFqpoUt
 TymIQOVWBV53enwgnpgqGuMaTytdpeIBSLw2MujnMP0aVvamVMnIQH6l+PMTj2b6rZ3R
 fpL42k9ygz15yqFy3V9+hHs85ZPK8vPQ5it67f5X+KU/GYSPaNNZRTtxHad57O9ZCQKT
 CtrNn1iUlhtX/E8KxPIambra7UXQVoLa/Wan5nc8EqEPVENTnlEred4es896wg5e+QF5
 aVmvEaxIOmVPbAdmYY/Y8tyFa9jcMxxSFRkDi9cJTUq0BfUmP9xrtfv+uk954CQ0VPg3
 mCpw==
X-Gm-Message-State: AOAM530kffmaIvGVtUR+GNj/t/XZRrzc1yFj/Efuq0T8sue1oa+UhkSB
 OLEmzh5q6VoMIa8UAcolUJXwvFxND/cmJJhwRubmvGnI6gVna3Psg2o7HE+hr9wUy52FbkdeHyv
 A/XIVST2gXcHUkz7GD8nlRbqZzLD9paEoZt5wLCrFerPVu5OFN8syaGPHOA==
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id
 s7-20020a056512314700b00443323d179dmr19783727lfi.98.1645588427957; 
 Tue, 22 Feb 2022 19:53:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTg1800Nq5+wExhYu7GSgkaGsiqwidtasywKGX7t1ujuxR3LE5nhHs54UMgx2PMMT6JvevH9IePF5C2GpdOuA=
X-Received: by 2002:a05:6512:3147:b0:443:323d:179d with SMTP id
 s7-20020a056512314700b00443323d179dmr19783713lfi.98.1645588427730; Tue, 22
 Feb 2022 19:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-2-andrew@daynix.com>
 <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
 <CABcq3pH7HnH_-nCHcX7eet_ouqocQEptp6A9GCbs3=9guArhPA@mail.gmail.com>
In-Reply-To: <CABcq3pH7HnH_-nCHcX7eet_ouqocQEptp6A9GCbs3=9guArhPA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 11:53:36 +0800
Message-ID: <CACGkMEu3biQ+BM29nDu82jP8y+p4iiL4K=GzM6px+yktU5Zqjw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
To: Andrew Melnichenko <andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgOToyOCBQTSBBbmRyZXcgTWVsbmljaGVua28gPGFuZHJl
d0BkYXluaXguY29tPiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IE9uIFdlZCwgRmViIDksIDIwMjIg
YXQgNjoyNiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4g
Pgo+ID4g5ZyoIDIwMjIvMS8yNSDkuIvljYg0OjQ2LCBBbmRyZXcgTWVsbnljaGVua28g5YaZ6YGT
Ogo+ID4gPiBBZGRlZCBUVU5HRVRTVVBQT1JURURPRkZMT0FEUyB0aGF0IHNob3VsZCBhbGxvdwo+
ID4gPiB0byBnZXQgYml0cyBvZiBzdXBwb3J0ZWQgb2ZmbG9hZHMuCj4gPgo+ID4KPiA+IFNvIHdl
IGRvbid0IHVzZSBkZWRpY2F0ZWQgaW9jdGxzIGluIHRoZSBwYXN0LCBpbnN0ZWFkLCB3ZSBqdXN0
IHByb2JpbmcKPiA+IGJ5IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgVFVOU0VUT0ZGTE9B
RFMuCj4gPgo+ID4gRS5nIHFlbXUgaGFzIHRoZSBmb2xsb3dpbmcgY29kZXM6Cj4gPgo+ID4gaW50
IHRhcF9wcm9iZV9oYXNfdWZvKGludCBmZCkKPiA+IHsKPiA+ICAgICAgdW5zaWduZWQgb2ZmbG9h
ZDsKPiA+Cj4gPiAgICAgIG9mZmxvYWQgPSBUVU5fRl9DU1VNIHwgVFVOX0ZfVUZPOwo+ID4KPiA+
ICAgICAgaWYgKGlvY3RsKGZkLCBUVU5TRVRPRkZMT0FELCBvZmZsb2FkKSA8IDApCj4gPiAgICAg
ICAgICByZXR1cm4gMDsKPiA+Cj4gPiAgICAgIHJldHVybiAxOwo+ID4gfQo+ID4KPiA+IEFueSBy
ZWFzb24gd2UgY2FuJ3Qga2VlcCB1c2luZyB0aGF0Pwo+ID4KPiA+IFRoYW5rcwo+ID4KPgo+IFdl
bGwsIGV2ZW4gaW4gdGhpcyBleGFtcGxlLiBUbyBjaGVjayB0aGUgdWZvIGZlYXR1cmUsIHdlIHRy
eWluZyB0byBzZXQgaXQuCj4gV2hhdCBpZiB3ZSBkb24ndCBuZWVkIHRvICJlbmFibGUiIFVGTyBh
bmQvb3IgZG8gbm90IGNoYW5nZSBpdHMgc3RhdGU/CgpTbyBhdCBsZWFzdCBRZW11IGRvZXNuJ3Qg
aGF2ZSBzdWNoIGEgcmVxdWlyZW1lbnQgc2luY2UgZHVyaW5nIHRoZQpwcm9iZSB0aGUgdmlydHVh
bCBuZXR3b3JraW5nIGJhY2tlbmQgaXMgbm90IGV2ZW4gc3RhcnRlZC4KCj4gSSB0aGluayBpdCdz
IGEgZ29vZCBpZGVhIHRvIGhhdmUgdGhlIGFiaWxpdHkgdG8gZ2V0IHN1cHBvcnRlZCBvZmZsb2Fk
cwo+IHdpdGhvdXQgY2hhbmdpbmcgZGV2aWNlIGJlaGF2aW9yLgoKRG8geW91IHNlZSBhIHJlYWwg
dXNlciBmb3IgdGhpcz8KCkJ0dywgd2Ugc3RpbGwgbmVlZCB0byBwcm9iZSB0aGlzIG5ldyBpb2N0
bCBhbnl3YXkuCgpUaGFua3MKCj4KPiA+Cj4gPiA+IEFkZGVkIDIgYWRkaXRpb25hbCBvZmZsbG9h
ZHMgZm9yIFVTTyhJUHY0ICYgSVB2NikuCj4gPiA+IFNlcGFyYXRlIG9mZmxvYWRzIGFyZSByZXF1
aXJlZCBmb3IgV2luZG93cyBWTSBndWVzdHMsCj4gPiA+IGcuZS4gV2luZG93cyBtYXkgc2V0IFVT
TyByeCBvbmx5IGZvciBJUHY0Lgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWVs
bnljaGVua28gPGFuZHJld0BkYXluaXguY29tPgo+ID4gPiAtLS0KPiA+ID4gICBpbmNsdWRlL3Vh
cGkvbGludXgvaWZfdHVuLmggfCAzICsrKwo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9pZl90
dW4uaCBiL2luY2x1ZGUvdWFwaS9saW51eC9pZl90dW4uaAo+ID4gPiBpbmRleCA0NTRhZTMxYjkz
YzcuLjA3NjgwZmFlNmUxOCAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2lm
X3R1bi5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9pZl90dW4uaAo+ID4gPiBAQCAt
NjEsNiArNjEsNyBAQAo+ID4gPiAgICNkZWZpbmUgVFVOU0VURklMVEVSRUJQRiBfSU9SKCdUJywg
MjI1LCBpbnQpCj4gPiA+ICAgI2RlZmluZSBUVU5TRVRDQVJSSUVSIF9JT1coJ1QnLCAyMjYsIGlu
dCkKPiA+ID4gICAjZGVmaW5lIFRVTkdFVERFVk5FVE5TIF9JTygnVCcsIDIyNykKPiA+ID4gKyNk
ZWZpbmUgVFVOR0VUU1VQUE9SVEVET0ZGTE9BRFMgX0lPUignVCcsIDIyOCwgdW5zaWduZWQgaW50
KQo+ID4gPgo+ID4gPiAgIC8qIFRVTlNFVElGRiBpZnIgZmxhZ3MgKi8KPiA+ID4gICAjZGVmaW5l
IElGRl9UVU4gICAgICAgICAgICAgMHgwMDAxCj4gPiA+IEBAIC04OCw2ICs4OSw4IEBACj4gPiA+
ICAgI2RlZmluZSBUVU5fRl9UU082ICAweDA0ICAgIC8qIEkgY2FuIGhhbmRsZSBUU08gZm9yIElQ
djYgcGFja2V0cyAqLwo+ID4gPiAgICNkZWZpbmUgVFVOX0ZfVFNPX0VDTiAgICAgICAweDA4ICAg
IC8qIEkgY2FuIGhhbmRsZSBUU08gd2l0aCBFQ04gYml0cy4gKi8KPiA+ID4gICAjZGVmaW5lIFRV
Tl9GX1VGTyAgIDB4MTAgICAgLyogSSBjYW4gaGFuZGxlIFVGTyBwYWNrZXRzICovCj4gPiA+ICsj
ZGVmaW5lIFRVTl9GX1VTTzQgICAweDIwICAgIC8qIEkgY2FuIGhhbmRsZSBVU08gZm9yIElQdjQg
cGFja2V0cyAqLwo+ID4gPiArI2RlZmluZSBUVU5fRl9VU082ICAgMHg0MCAgICAvKiBJIGNhbiBo
YW5kbGUgVVNPIGZvciBJUHY2IHBhY2tldHMgKi8KPiA+ID4KPiA+ID4gICAvKiBQcm90b2NvbCBp
bmZvIHByZXBlbmRlZCB0byB0aGUgcGFja2V0cyAod2hlbiBJRkZfTk9fUEkgaXMgbm90IHNldCkg
Ki8KPiA+ID4gICAjZGVmaW5lIFRVTl9QS1RfU1RSSVAgICAgICAgMHgwMDAxCj4gPgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
