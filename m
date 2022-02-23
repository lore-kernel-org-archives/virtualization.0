Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F56C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E942813E8;
	Wed, 23 Feb 2022 03:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FTUlKTRDYCfA; Wed, 23 Feb 2022 03:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9EDDD812D9;
	Wed, 23 Feb 2022 03:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A9DDC0021;
	Wed, 23 Feb 2022 03:47:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB6DDC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D016F813E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bp9ExAylKjNq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D68F1812D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645588022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mQfvcL2jz6bjxuBt9OWYUuZAHEjpnh9YgPxGBsGS1Y=;
 b=X5UlziOA0QARqi2UTlfw5OO/SOZR+GzWHn1KLzNhYvH/CSDbpZg+69nASH4JBgr2OIVm7V
 pkyby7cJ08Q+slWzoadkSSjtPfWtKoj44W47XAioeLCVsrc8PNCkBvV4YcYd9Xj8bz2WO5
 cm2XCNsspToXAHuJ+ZmmPXacGoyzOyg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Dt6xxAZtMWajEJlH1fhumg-1; Tue, 22 Feb 2022 22:46:59 -0500
X-MC-Unique: Dt6xxAZtMWajEJlH1fhumg-1
Received: by mail-lf1-f70.google.com with SMTP id
 z24-20020a056512371800b0043ea4caa07cso3061731lfr.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1mQfvcL2jz6bjxuBt9OWYUuZAHEjpnh9YgPxGBsGS1Y=;
 b=rPsX3nxC2+q9+lLoyg1B507TRrchi1rPFPAM+l4s06+Cg3fdowweJ1UhQiOhqH7aV2
 Kiz+Xh0HE2/ORzERQHk5ZKSaMmM9Diw8lOkeCiqEnmUKFg8/Tw53pj7gOAKsBH7pIbRb
 cxfF18bANcgiIhSE0+Hkm2T1ZBq7Hy7O5EhQJV6wyEq/e1pdgLwmZqSnlL1PCrhOuCL2
 Mu6seOAP/EUqspdKZFVO6nPOZHK61BACdkh89qtlbwja2cqk01bE4zmFhVrYs6VXOA4/
 Bh+ldxYXuJmr8VuL2cBkaN4dVXj/aph90aYnpOdWrdsUaYncf2FQDv7uu/Gzs8hJziSf
 HKpw==
X-Gm-Message-State: AOAM530w46ol4Hdo7jI4ISLxdoPNZnUjnVCdMJg/VmPu5UL3PNQWn05Q
 g71zpkdlk5WslDXjMR6Kf9fOUVcRNa1BFxUAphOTz4vUfW3/NIBkRHTYvKH+maqRmeY8NnV4CCk
 kscEDLdct0KQIXWNDHyFrFAmtkDfgXxWG2kbgyHIYUPrqgXwsAnMNwaXYPA==
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id
 v21-20020a2e7a15000000b00236deb21f74mr19608610ljc.315.1645588017936; 
 Tue, 22 Feb 2022 19:46:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcfX+yBYN+2Z6qy2ssD7tpMJc7DPW0wfx8zQgbYWkML1Wtwob09Sh0xvyzjmIN6s4zqrF7u69rqnh56fWD/zo=
X-Received: by 2002:a2e:7a15:0:b0:236:deb2:1f74 with SMTP id
 v21-20020a2e7a15000000b00236deb21f74mr19608590ljc.315.1645588017693; Tue, 22
 Feb 2022 19:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
 <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
 <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
 <9b32f664-56a9-3718-cf48-49003f87d430@redhat.com>
 <CAJaqyWcvWjPas0=xp+U-c-kG+e6k73jg=C4phFD7S-tZY=niSQ@mail.gmail.com>
 <CACGkMEtbd9RsE9f-HLnwmhJEFsK++uBHnqG4N0c6qJG0PxDdzw@mail.gmail.com>
 <CAJaqyWdhHmD+tB_bY_YEMnBU1p7-LW=LP8f+3e_ZXDcOfSRiNA@mail.gmail.com>
 <0f0204f1-8b7f-a21e-495e-24443a63f026@redhat.com>
 <CAJaqyWfFC4SgxQ4zQeHgtDDJSd0tBa-W4HmtW0UASA2cVDWDUg@mail.gmail.com>
In-Reply-To: <CAJaqyWfFC4SgxQ4zQeHgtDDJSd0tBa-W4HmtW0UASA2cVDWDUg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 11:46:46 +0800
Message-ID: <CACGkMEukmf35163EDFQ2YQo2g2N0Diby7ffr9=UmOwGPEKj-Eg@mail.gmail.com>
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgNDowNiBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCA4OjQx
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMi8yLzE3IOS4i+WNiDQ6MjIsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+
ID4gT24gVGh1LCBGZWIgMTcsIDIwMjIgYXQgNzowMiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+IE9uIFdlZCwgRmViIDE2LCAyMDIyIGF0IDExOjU0IFBN
IEV1Z2VuaW8gUGVyZXogTWFydGluCj4gPiA+PiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+Pj4gT24gVHVlLCBGZWIgOCwgMjAyMiBhdCA5OjI1IEFNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4+Pgo+ID4gPj4+PiDlnKggMjAyMi8yLzEg5LiL
5Y2INzo0NSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+ID4gPj4+Pj4gT24gU3VuLCBK
YW4gMzAsIDIwMjIgYXQgNzo1MCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4+Pj4+PiDlnKggMjAyMi8xLzIyIOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6
IOWGmemBkzoKPiA+ID4+Pj4+Pj4gU1ZRIGlzIGFibGUgdG8gbG9nIHRoZSBkaXJ0eSBiaXRzIGJ5
IGl0c2VsZiwgc28gbGV0J3MgdXNlIGl0IHRvIG5vdAo+ID4gPj4+Pj4+PiBibG9jayBtaWdyYXRp
b24uCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IEFsc28sIGlnbm9yZSBzZXQgYW5kIGNsZWFyIG9m
IFZIT1NUX0ZfTE9HX0FMTCBvbiBzZXRfZmVhdHVyZXMgaWYgU1ZRIGlzCj4gPiA+Pj4+Pj4+IGVu
YWJsZWQuIEV2ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBpdCwgdGhlIHJlcG9ydHMgd291bGQg
YmUgbm9uc2Vuc2UKPiA+ID4+Pj4+Pj4gYmVjYXVzZSBTVlEgbWVtb3J5IGlzIGluIHRoZSBxZW11
IHJlZ2lvbi4KPiA+ID4+Pj4+Pj4KPiA+ID4+Pj4+Pj4gVGhlIGxvZyByZWdpb24gaXMgc3RpbGwg
YWxsb2NhdGVkLiBGdXR1cmUgY2hhbmdlcyBtaWdodCBza2lwIHRoYXQsIGJ1dAo+ID4gPj4+Pj4+
PiB0aGlzIHNlcmllcyBpcyBhbHJlYWR5IGxvbmcgZW5vdWdoLgo+ID4gPj4+Pj4+Pgo+ID4gPj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4K
PiA+ID4+Pj4+Pj4gLS0tCj4gPiA+Pj4+Pj4+ICAgICBody92aXJ0aW8vdmhvc3QtdmRwYS5jIHwg
MjAgKysrKysrKysrKysrKysrKysrKysKPiA+ID4+Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ID4gPj4+Pj4+PiBp
bmRleCBmYjBhMzM4YmFhLi43NTA5MGQ2NWU4IDEwMDY0NAo+ID4gPj4+Pj4+PiAtLS0gYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+Pj4+Pj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBh
LmMKPiA+ID4+Pj4+Pj4gQEAgLTEwMjIsNiArMTAyMiw5IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRw
YV9nZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50NjRfdCAqZmVhdHVyZXMp
Cj4gPiA+Pj4+Pj4+ICAgICAgICAgaWYgKHJldCA9PSAwICYmIHYtPnNoYWRvd192cXNfZW5hYmxl
ZCkgewo+ID4gPj4+Pj4+PiAgICAgICAgICAgICAvKiBGaWx0ZXIgb25seSBmZWF0dXJlcyB0aGF0
IFNWUSBjYW4gb2ZmZXIgdG8gZ3Vlc3QgKi8KPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgdmhvc3Rf
c3ZxX3ZhbGlkX2d1ZXN0X2ZlYXR1cmVzKGZlYXR1cmVzKTsKPiA+ID4+Pj4+Pj4gKwo+ID4gPj4+
Pj4+PiArICAgICAgICAvKiBBZGQgU1ZRIGxvZ2dpbmcgY2FwYWJpbGl0aWVzICovCj4gPiA+Pj4+
Pj4+ICsgICAgICAgICpmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0ZfTE9HX0FMTCk7Cj4gPiA+
Pj4+Pj4+ICAgICAgICAgfQo+ID4gPj4+Pj4+Pgo+ID4gPj4+Pj4+PiAgICAgICAgIHJldHVybiBy
ZXQ7Cj4gPiA+Pj4+Pj4+IEBAIC0xMDM5LDggKzEwNDIsMjUgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gPiA+Pj4+Pj4+Cj4gPiA+
Pj4+Pj4+ICAgICAgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ID4gPj4+Pj4+PiAg
ICAgICAgICAgICB1aW50NjRfdCBkZXZfZmVhdHVyZXMsIHN2cV9mZWF0dXJlcywgYWNrZWRfZmVh
dHVyZXM7Cj4gPiA+Pj4+Pj4+ICsgICAgICAgIHVpbnQ4X3Qgc3RhdHVzID0gMDsKPiA+ID4+Pj4+
Pj4gICAgICAgICAgICAgYm9vbCBvazsKPiA+ID4+Pj4+Pj4KPiA+ID4+Pj4+Pj4gKyAgICAgICAg
cmV0ID0gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfVkRQQV9HRVRfU1RBVFVTLCAmc3RhdHVz
KTsKPiA+ID4+Pj4+Pj4gKyAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpIHsKPiA+ID4+Pj4+Pj4g
KyAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPiA+Pj4+Pj4+ICsgICAgICAgIH0KPiA+ID4+Pj4+
Pj4gKwo+ID4gPj4+Pj4+PiArICAgICAgICBpZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RS
SVZFUl9PSykgewo+ID4gPj4+Pj4+PiArICAgICAgICAgICAgLyoKPiA+ID4+Pj4+Pj4gKyAgICAg
ICAgICAgICAqIHZob3N0IGlzIHRyeWluZyB0byBlbmFibGUgb3IgZGlzYWJsZSBfRl9MT0csIGFu
ZCB0aGUgZGV2aWNlCj4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgKiB3b3VsZCByZXBvcnQgd3Jv
bmcgZGlydHkgcGFnZXMuIFNWUSBoYW5kbGVzIGl0Lgo+ID4gPj4+Pj4+PiArICAgICAgICAgICAg
ICovCj4gPiA+Pj4+Pj4gSSBmYWlsIHRvIHVuZGVyc3RhbmQgdGhpcyBjb21tZW50LCBJJ2QgdGhp
bmsgdGhlcmUncyBubyB3YXkgdG8gZGlzYWJsZQo+ID4gPj4+Pj4+IGRpcnR5IHBhZ2UgdHJhY2tp
bmcgZm9yIFNWUS4KPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4gdmhvc3RfbG9nX2dsb2JhbF97c3RhcnQs
c3RvcH0gYXJlIGNhbGxlZCBhdCB0aGUgYmVnaW5uaW5nIGFuZCBlbmQgb2YKPiA+ID4+Pj4+IG1p
Z3JhdGlvbi4gVG8gaW5mb3JtIHRoZSBkZXZpY2UgdGhhdCBpdCBzaG91bGQgc3RhcnQgbG9nZ2lu
ZywgdGhleSBzZXQKPiA+ID4+Pj4+IG9yIGNsZWFuIFZIT1NUX0ZfTE9HX0FMTCBhdCB2aG9zdF9k
ZXZfc2V0X2xvZy4KPiA+ID4+Pj4KPiA+ID4+Pj4gWWVzLCBidXQgZm9yIFNWUSwgd2UgY2FuJ3Qg
ZGlzYWJsZSBkaXJ0eSBwYWdlIHRyYWNraW5nLCBpc24ndCBpdD8gVGhlCj4gPiA+Pj4+IG9ubHkg
dGhpbmcgaXMgdG8gaWdub3JlIG9yIGZpbHRlciBvdXQgdGhlIEZfTE9HX0FMTCBhbmQgcHJldGVu
ZCB0byBiZQo+ID4gPj4+PiBlbmFibGVkIGFuZCBkaXNhYmxlZC4KPiA+ID4+Pj4KPiA+ID4+PiBZ
ZXMsIHRoYXQncyB3aGF0IHRoaXMgcGF0Y2ggZG9lcy4KPiA+ID4+Pgo+ID4gPj4+Pj4gV2hpbGUg
U1ZRIGRvZXMgbm90IHVzZSBWSE9TVF9GX0xPR19BTEwsIGl0IGV4cG9ydHMgdGhlIGZlYXR1cmUg
Yml0IHNvCj4gPiA+Pj4+PiB2aG9zdCBkb2VzIG5vdCBibG9jayBtaWdyYXRpb24uIE1heWJlIHdl
IG5lZWQgdG8gbG9vayBmb3IgYW5vdGhlciB3YXkKPiA+ID4+Pj4+IHRvIGRvIHRoaXM/Cj4gPiA+
Pj4+Cj4gPiA+Pj4+IEknbSBmaW5lIHdpdGggZmlsdGVyaW5nIHNpbmNlIGl0J3MgbXVjaCBtb3Jl
IHNpbXBsZXIsIGJ1dCBJIGZhaWwgdG8KPiA+ID4+Pj4gdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCB0
byBjaGVjayBEUklWRVJfT0suCj4gPiA+Pj4+Cj4gPiA+Pj4gT2sgbWF5YmUgSSBjYW4gbWFrZSB0
aGF0IHBhcnQgbW9yZSBjbGVhciwKPiA+ID4+Pgo+ID4gPj4+IFNpbmNlIGJvdGggb3BlcmF0aW9u
cyB1c2Ugdmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMgd2UgbXVzdCBqdXN0IGZpbHRlcgo+ID4gPj4+
IHRoZSBvbmUgdGhhdCBhY3R1YWxseSBzZXRzIG9yIHJlbW92ZXMgVkhPU1RfRl9MT0dfQUxMLCB3
aXRob3V0Cj4gPiA+Pj4gYWZmZWN0aW5nIG90aGVyIGZlYXR1cmVzLgo+ID4gPj4+Cj4gPiA+Pj4g
SW4gcHJhY3RpY2UsIHRoYXQgbWVhbnMgdG8gbm90IGZvcndhcmQgdGhlIHNldCBmZWF0dXJlcyBh
ZnRlcgo+ID4gPj4+IERSSVZFUl9PSy4gVGhlIGRldmljZSBpcyBub3QgZXhwZWN0aW5nIHRoZW0g
YW55bW9yZS4KPiA+ID4+IEkgd29uZGVyIHdoYXQgaGFwcGVucyBpZiB3ZSBkb24ndCBkbyB0aGlz
Lgo+ID4gPj4KPiA+ID4gSWYgd2Ugc2ltcGx5IGRlbGV0ZSB0aGUgY2hlY2sgdmhvc3RfZGV2X3Nl
dF9mZWF0dXJlcyB3aWxsIHJldHVybiBhbgo+ID4gPiBlcnJvciwgZmFpbGluZyB0aGUgc3RhcnQg
b2YgdGhlIG1pZ3JhdGlvbi4gTW9yZSBvbiB0aGlzIGJlbG93Lgo+ID4KPiA+Cj4gPiBPay4KPiA+
Cj4gPgo+ID4gPgo+ID4gPj4gU28ga2VybmVsIGhhZCB0aGlzIGNoZWNrOgo+ID4gPj4KPiA+ID4+
ICAgICAgICAgIC8qCj4gPiA+PiAgICAgICAgICAgKiBJdCdzIG5vdCBhbGxvd2VkIHRvIGNoYW5n
ZSB0aGUgZmVhdHVyZXMgYWZ0ZXIgdGhleSBoYXZlCj4gPiA+PiAgICAgICAgICAgKiBiZWVuIG5l
Z290aWF0ZWQuCj4gPiA+PiAgICAgICAgICAgKi8KPiA+ID4+IGlmIChvcHMtPmdldF9zdGF0dXMo
dmRwYSkgJiBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spCj4gPiA+PiAgICAgICAgICByZXR1
cm4gLUVCVVNZOwo+ID4gPj4KPiA+ID4+IFNvIGlzIGl0IEZFQVRVUkVTX09LIGFjdHVhbGx5Pwo+
ID4gPj4KPiA+ID4gWWVzLCBGRUFUVVJFU19PSyBzZWVtcyBtb3JlIGFwcHJvcHJpYXRlIGFjdHVh
bGx5IHNvIEkgd2lsbCBzd2l0Y2ggdG8KPiA+ID4gaXQgZm9yIHRoZSBuZXh0IHZlcnNpb24uCj4g
PiA+Cj4gPiA+IEJ1dCBpdCBzaG91bGQgYmUgZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQsIHNpbmNl
Cj4gPiA+IHZob3N0LmM6dmhvc3RfZGV2X3N0YXJ0IHNldHMgYm90aCBhbmQgdGhlIHNldHRpbmcg
b2YgX0ZfTE9HX0FMTCBjYW5ub3QKPiA+ID4gYmUgY29uY3VycmVudCB3aXRoIGl0Lgo+ID4KPiA+
Cj4gPiBSaWdodC4KPiA+Cj4gPgo+ID4gPgo+ID4gPj4gRm9yIHRoaXMgcGF0Y2gsIEkgd29uZGVy
IGlmIHRoZSB0aGluZyB3ZSBuZWVkIHRvIGRvIGlzIHRvIHNlZSB3aGV0aGVyCj4gPiA+PiBpdCBp
cyBhIGVuYWJsZS9kaXNhYmxlIEZfTE9HX0FMTCBhbmQgc2ltcGx5IHJldHVybi4KPiA+ID4+Cj4g
PiA+IFllcywgdGhhdCdzIHRoZSBpbnRlbnRpb24gb2YgdGhlIHBhdGNoLgo+ID4gPgo+ID4gPiBX
ZSBoYXZlIDQgY2FzZXMgaGVyZToKPiA+ID4gYSkgV2UncmUgYmVpbmcgY2FsbGVkIGZyb20gdmhv
c3RfZGV2X3N0YXJ0LCB3aXRoIGVuYWJsZV9sb2cgPSBmYWxzZQo+ID4gPiBiKSBXZSdyZSBiZWlu
ZyBjYWxsZWQgZnJvbSB2aG9zdF9kZXZfc3RhcnQsIHdpdGggZW5hYmxlX2xvZyA9IHRydWUKPiA+
Cj4gPgo+ID4gQW5kIHRoaXMgY2FzZSBtYWtlcyB1cyBjYW4ndCBzaW1wbHkgcmV0dXJuIHdpdGhv
dXQgY2FsbGluZyB2aG9zdC12ZHBhLgo+ID4KPgo+IEl0IGNhbGxzIGJlY2F1c2Uge0ZFQVRVUkVT
LERSSVZFUn1fT0sgaXMgc3RpbGwgbm90IHNldCBhdCB0aGF0IHBvaW50Lgo+Cj4gPgo+ID4gPiBj
KSBXZSdyZSBiZWluZyBjYWxsZWQgZnJvbSB2aG9zdF9kZXZfc2V0X2xvZywgd2l0aCBlbmFibGVf
bG9nID0gZmFsc2UKPiA+ID4gZCkgV2UncmUgYmVpbmcgY2FsbGVkIGZyb20gdmhvc3RfZGV2X3Nl
dF9sb2csIHdpdGggZW5hYmxlX2xvZyA9IHRydWUKPiA+ID4KPiA+ID4gVGhlIHdheSB0byB0ZWxs
IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gYS9iIGFuZCBjL2QgaXMgdG8gY2hlY2sgaWYKPiA+ID4g
e0ZFQVRVUkVTLERSSVZFUn1fT0sgaXMgc2V0LiBBbmQsIGFzIHlvdSBwb2ludCBvdXQgaW4gcHJl
dmlvdXMgbWFpbHMsCj4gPiA+IEZfTE9HX0FMTCBtdXN0IGJlIGZpbHRlcmVkIHVuY29uZGl0aW9u
YWxseSBzaW5jZSBTVlEgdHJhY2tzIGRpcnR5Cj4gPiA+IG1lbW9yeSB0aHJvdWdoIHRoZSBtZW1v
cnkgdW5tYXBwaW5nLCBzbyB3ZSBjbGVhciB0aGUgYml0Cj4gPiA+IHVuY29uZGl0aW9uYWxseSBp
ZiB3ZSBkZXRlY3QgdGhhdCBWSE9TVF9TRVRfRkVBVFVSRVMgd2lsbCBiZSBjYWxsZWQKPiA+ID4g
KGNhc2VzIGEgYW5kIGIpLgo+ID4gPgo+ID4gPiBBbm90aGVyIHBvc3NpYmlsaXR5IGlzIHRvIHRy
YWNrIGlmIGZlYXR1cmVzIGhhdmUgYmVlbiBzZXQgd2l0aCBhIGJvb2wKPiA+ID4gaW4gdmhvc3Rf
dmRwYSBvciBzb21ldGhpbmcgbGlrZSB0aGF0LiBCdXQgaXQgc2VlbXMgY2xlYW5lciB0byBtZSB0
bwo+ID4gPiBvbmx5IHN0b3JlIHRoYXQgaW4gdGhlIGFjdHVhbCBkZXZpY2UuCj4gPgo+ID4KPiA+
IFNvIEkgc3VnZ2VzdCB0byBtYWtlIHN1cmUgY29kZXMgbWF0Y2ggdGhlIGNvbW1lbnQ6Cj4gPgo+
ID4gICAgICAgICAgaWYgKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHsKPiA+
ICAgICAgICAgICAgICAvKgo+ID4gICAgICAgICAgICAgICAqIHZob3N0IGlzIHRyeWluZyB0byBl
bmFibGUgb3IgZGlzYWJsZSBfRl9MT0csIGFuZCB0aGUgZGV2aWNlCj4gPiAgICAgICAgICAgICAg
ICogd291bGQgcmVwb3J0IHdyb25nIGRpcnR5IHBhZ2VzLiBTVlEgaGFuZGxlcyBpdC4KPiA+ICAg
ICAgICAgICAgICAgKi8KPiA+ICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ICAgICAgICAgIH0K
PiA+Cj4gPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2hlY2sgd2hldGhlciB0aGUgY2FsbGVyIGlz
IHRvZ2dsaW5nIF9GX0xPR19BTEwgaW4KPiA+IHRoaXMgY2FzZS4KPiA+Cj4KPiBIb3cgdG8gZGV0
ZWN0PyBXZSBjYW4gc2F2ZSBmZWF0dXJlIGZsYWdzIGFuZCBjb21wYXJlLCBidXQgaWdub3Jpbmcg
YWxsCj4gc2V0X2ZlYXR1cmVzIGFmdGVyIEZFQVRVUkVTX09LIHNlZW1zIHNpbXBsZXIgdG8gbWUu
CgpTb21ldGhpbmcgbGlrZToKCihzdGF0dXMgXiBzdGF0dXNfb2xkID09IF9GX0xPR19BTEwpID8K
Ckl0IGhlbHBzIHVzIHRvIHJldHVybiBlcnJvcnMgb24gd3JvbmcgZmVhdHVyZXMgc2V0IGR1cmlu
ZyBEUklWRVJfT0suCgpUaGFua3MKCj4KPiBXb3VsZCBjaGFuZ2luZyB0aGUgY29tbWVudCB3b3Jr
PyBTb21ldGhpbmcgbGlrZSAic2V0X2ZlYXR1cmVzIGFmdGVyCj4gX1NfRkVBVFVSRVNfT0sgbWVh
bnMgdmhvc3QgaXMgdHJ5aW5nIHRvIGVuYWJsZSBvciBkaXNhYmxlIF9GX0xPRywgYW5kCj4gdGhl
IGRldmljZSB3b3VsZCByZXBvcnQgd3JvbmcgZGlydHkgcGFnZXMuIFNWUSBoYW5kbGVzIGl0LiIK
Pgo+IFRoYW5rcyEKPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4KPiA+ID4+IFRoYW5rcwo+ID4g
Pj4KPiA+ID4+PiBEb2VzIHRoYXQgbWFrZSBtb3JlIHNlbnNlPwo+ID4gPj4+Cj4gPiA+Pj4gVGhh
bmtzIQo+ID4gPj4+Cj4gPiA+Pj4+IFRoYW5rcwo+ID4gPj4+Pgo+ID4gPj4+Pgo+ID4gPj4+Pj4g
VGhhbmtzIQo+ID4gPj4+Pj4KPiA+ID4+Pj4+PiBUaGFua3MKPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+
Cj4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICByZXR1cm4gMDsKPiA+ID4+Pj4+Pj4gKyAgICAgICAg
fQo+ID4gPj4+Pj4+PiArCj4gPiA+Pj4+Pj4+ICsgICAgICAgIC8qIFdlIG11c3Qgbm90IGFjayBf
Rl9MT0cgaWYgU1ZRIGlzIGVuYWJsZWQgKi8KPiA+ID4+Pj4+Pj4gKyAgICAgICAgZmVhdHVyZXMg
Jj0gfkJJVF9VTEwoVkhPU1RfRl9MT0dfQUxMKTsKPiA+ID4+Pj4+Pj4gKwo+ID4gPj4+Pj4+PiAg
ICAgICAgICAgICByZXQgPSB2aG9zdF92ZHBhX2dldF9kZXZfZmVhdHVyZXMoZGV2LCAmZGV2X2Zl
YXR1cmVzKTsKPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgaWYgKHJldCAhPSAwKSB7Cj4gPiA+Pj4+
Pj4+ICAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkNhbid0IGdldCB2ZHBhIGRldmljZSBm
ZWF0dXJlcywgZ290ICglZCkiLCByZXQpOwo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
