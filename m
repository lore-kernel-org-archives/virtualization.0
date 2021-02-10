Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC8C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 02:37:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDD664D5D
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 02:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDD664D5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18F00858BA;
	Wed, 10 Feb 2021 02:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kNgqfJtO8q9l; Wed, 10 Feb 2021 02:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7870685633;
	Wed, 10 Feb 2021 02:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D5F4C0174;
	Wed, 10 Feb 2021 02:37:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C336C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 578958564D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4AOfn5pdYeN7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:37:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1BD3785633
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 02:37:36 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id b9so1207641ejy.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 18:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X3d0m+efZXIn0whUV4akrtWMQvxr38fSqzQd0PRb69g=;
 b=vN8ErVKh6rcmv52Mxc2Z6dNyclkNbP6a7G/2SAvZec+h+gFHyUx5Her3+algJyUFMa
 ReZAwcN9vFcjTD+36++0XF26paz8093o2mk0X3Af9q16xx7hpMum8NzoFPznhVqkEc42
 JYaVPJYXv8nx3BJQ/k7garHZJrtstZtTFHIkDvwwcl3b4SCdMgYsolzOp6jpd2R7pdoj
 ea3IwhgX9HAfosn8ryZJtFLo6hc1BUq4aHdxfnbzn4Xun3wlu/CXpGiNMEFhoVw4GGkV
 BinkNr+ThJWNXbgyywFiD2onUoI5o6BLlReGL0wcPoUPZhFMB10HEDm8kerOEB5cHLIA
 bX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X3d0m+efZXIn0whUV4akrtWMQvxr38fSqzQd0PRb69g=;
 b=a1PXpwfo8v7UsJGIheVyyTuRNmV9lg+44HukRAEylsHr1Amx3tiewWTtd7qqiLCBgK
 YG4vKAdrUILzksyMAtgVB6Udohfj1kxWwOWN4KsjV+OIjqkMjpqT32gDbxOmaMC+EQuH
 fr9QJhBlXwUxM0On5e6Xy5muwk8QpHKGi/nWtq2U1BhUXxe2p4qQLuyBmiQn+qVgiHz5
 UJvscIyH4E7a7bFANxpzyDIo8G9f1TXvxKLmOsn02IHbgMrgX5kupyh5cIhwDwXuUXZx
 s+gEEfe3LRkJZiDjuTK41DsICQUqRJZyrWU8DpyIuM5+WO330rSrD/+pJByzDd2NmotQ
 n6yw==
X-Gm-Message-State: AOAM531XJszkrwMXexlQB/aErgwB64F2O6KqE6f58LdoHRXhl+ec5rQG
 48QST3Q5OmOhiBcwg+3kscad76OU1Nx1yKJwpLk=
X-Google-Smtp-Source: ABdhPJw+o+kLvC8cfCTnc7cqIx3d4z2fdh8QVgJPjSOULc6+oCFuOxTmqDuO7tgYJSvQPoCI2H/DoY6mM95RrdurARg=
X-Received: by 2002:a17:906:158c:: with SMTP id
 k12mr733211ejd.119.1612924654561; 
 Tue, 09 Feb 2021 18:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-4-willemdebruijn.kernel@gmail.com>
 <6bfdf48d-c780-bc65-b0b9-24a33f18827b@redhat.com>
 <20210209113643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210209113643-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 9 Feb 2021 21:36:58 -0500
Message-ID: <CAF=yD-Lw7LKypTLEfQmcqR9SwcL6f9wH=_yjQdyGak4ORegRug@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] virtio-net: support transmit timestamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCBGZWIgOSwgMjAyMSBhdCAxMTozOSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgRmViIDA5LCAyMDIxIGF0IDAxOjQ1OjExUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPgo+ID4gT24gMjAyMS8yLzkg5LiK5Y2IMjo1NSwg
V2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+ID4gRnJvbTogV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtYkBnb29nbGUuY29tPgo+ID4gPgo+ID4gPiBBZGQgb3B0aW9uYWwgUFRQIGhhcmR3YXJlIHR4
IHRpbWVzdGFtcCBvZmZsb2FkIGZvciB2aXJ0aW8tbmV0Lgo+ID4gPgo+ID4gPiBBY2N1cmF0ZSBS
VFQgbWVhc3VyZW1lbnQgcmVxdWlyZXMgdGltZXN0YW1wcyBjbG9zZSB0byB0aGUgd2lyZS4KPiA+
ID4gSW50cm9kdWNlIHZpcnRpbyBmZWF0dXJlIFZJUlRJT19ORVRfRl9UWF9UU1RBTVAsIHRoZSB0
cmFuc21pdAo+ID4gPiBlcXVpdmFsZW50IHRvIFZJUlRJT19ORVRfRl9SWF9UU1RBTVAuCj4gPiA+
Cj4gPiA+IFRoZSBkcml2ZXIgc2V0cyBWSVJUSU9fTkVUX0hEUl9GX1RTVEFNUCB0byByZXF1ZXN0
IGEgdGltZXN0YW1wCj4gPiA+IHJldHVybmVkIG9uIGNvbXBsZXRpb24uIElmIHRoZSBmZWF0dXJl
IGlzIG5lZ290aWF0ZWQsIHRoZSBkZXZpY2UKPiA+ID4gZWl0aGVyIHBsYWNlcyB0aGUgdGltZXN0
YW1wIG9yIGNsZWFycyB0aGUgZmVhdHVyZSBiaXQuCj4gPiA+Cj4gPiA+IFRoZSB0aW1lc3RhbXAg
c3RyYWRkbGVzICh2aXJ0dWFsKSBoYXJkd2FyZSBkb21haW5zLiBMaWtlIFBUUCwgdXNlCj4gPiA+
IGludGVybmF0aW9uYWwgYXRvbWljIHRpbWUgKENMT0NLX1RBSSkgYXMgZ2xvYmFsIGNsb2NrIGJh
c2UuIFRoZSBkcml2ZXIKPiA+ID4gbXVzdCBzeW5jIHdpdGggdGhlIGRldmljZSwgZS5nLiwgdGhy
b3VnaCBrdm0tY2xvY2suCj4gPiA+Cj4gPiA+IE1vZGlmeSBjYW5fcHVzaCB0byBlbnN1cmUgdGhh
dCBvbiB0eCBjb21wbGV0aW9uIHRoZSBoZWFkZXIsIGFuZCB0aHVzCj4gPiA+IHRpbWVzdGFtcCwg
aXMgaW4gYSBwcmVkaWNhdGFibGUgbG9jYXRpb24gYXQgc2tiX3ZuZXRfaGRyLgo+ID4gPgo+ID4g
PiBSRkM6IHRoaXMgaW1wbGVtZW50YXRpb24gcmVsaWVzIG9uIHRoZSBkZXZpY2Ugd3JpdGluZyB0
byB0aGUgYnVmZmVyLgo+ID4gPiBUaGF0IGJyZWFrcyBETUFfVE9fREVWSUNFIHNlbWFudGljcy4g
Rm9yIG5vdywgZGlzYWJsZSB3aGVuIERNQSBpcyBvbi4KPiA+ID4gVGhlIHZpcnRpbyBjaGFuZ2Vz
IHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoIGF0IHRoZSBsZWFzdC4KPiA+ID4KPiA+ID4gVGVz
dGVkOiBtb2RpZmllZCB0eHRpbWVzdGFtcC5jIHRvIHdpdGggaC93IHRpbWVzdGFtcGluZzoKPiA+
ID4gICAgLSAgICAgICBzb2NrX29wdCA9IFNPRl9USU1FU1RBTVBJTkdfU09GVFdBUkUgfAo+ID4g
PiAgICArICAgICAgIHNvY2tfb3B0ID0gU09GX1RJTUVTVEFNUElOR19SQVdfSEFSRFdBUkUgfAo+
ID4gPiAgICArIGRvX3Rlc3QoZmFtaWx5LCBTT0ZfVElNRVNUQU1QSU5HX1RYX0hBUkRXQVJFKTsK
PiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtYkBnb29n
bGUuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgICAgICAg
IHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gPiA+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyAgICB8ICAzICstCj4gPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0
aW8uaCAgICAgICAgICB8ICAxICsKPiA+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25l
dC5oIHwgIDEgKwo+ID4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gaW5kZXggYWM0NGM1ZWZhMGJj
Li5mYzhlY2QzYTMzM2EgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTIxMCw2ICsy
MTAsMTIgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gPiA+ICAgICAvKiBEZXZpY2Ugd2lsbCBw
YXNzIHJ4IHRpbWVzdGFtcC4gUmVxdWlyZXMgaGFzX3J4X3RzdGFtcCAqLwo+ID4gPiAgICAgYm9v
bCBlbmFibGVfcnhfdHN0YW1wOwo+ID4gPiArICAgLyogRGV2aWNlIGNhbiBwYXNzIENMT0NLX1RB
SSB0cmFuc21pdCB0aW1lIHRvIHRoZSBkcml2ZXIgKi8KPiA+ID4gKyAgIGJvb2wgaGFzX3R4X3Rz
dGFtcDsKPiA+ID4gKwo+ID4gPiArICAgLyogRGV2aWNlIHdpbGwgcGFzcyB0eCB0aW1lc3RhbXAu
IFJlcXVpcmVzIGhhc190eF90c3RhbXAgKi8KPiA+ID4gKyAgIGJvb2wgZW5hYmxlX3R4X3RzdGFt
cDsKPiA+ID4gKwo+ID4gPiAgICAgLyogSGFzIGNvbnRyb2wgdmlydHF1ZXVlICovCj4gPiA+ICAg
ICBib29sIGhhc19jdnE7Cj4gPiA+IEBAIC0xNDAxLDYgKzE0MDcsMjAgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3JlY2VpdmUoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCBpbnQgYnVkZ2V0LAo+ID4g
PiAgICAgcmV0dXJuIHN0YXRzLnBhY2tldHM7Cj4gPiA+ICAgfQo+ID4gPiArc3RhdGljIHZvaWQg
dmlydG5ldF9yZWNvcmRfdHhfdHN0YW1wKGNvbnN0IHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwKPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYikK
PiA+ID4gK3sKPiA+ID4gKyAgIGNvbnN0IHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9oYXNoX3RzICpo
ID0gc2tiX3ZuZXRfaGRyX2h0KHNrYik7Cj4gPiA+ICsgICBjb25zdCBzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSA9IHNxLT52cS0+dmRldi0+cHJpdjsKPiA+ID4gKyAgIHN0cnVjdCBza2Jfc2hhcmVk
X2h3dHN0YW1wcyB0czsKPiA+ID4gKwo+ID4gPiArICAgaWYgKGgtPmhkci5mbGFncyAmIFZJUlRJ
T19ORVRfSERSX0ZfVFNUQU1QICYmCj4gPiA+ICsgICAgICAgdmktPmVuYWJsZV90eF90c3RhbXAp
IHsKPiA+ID4gKyAgICAgICAgICAgdHMuaHd0c3RhbXAgPSBuc190b19rdGltZShsZTY0X3RvX2Nw
dShoLT50c3RhbXApKTsKPiA+ID4gKyAgICAgICAgICAgc2tiX3RzdGFtcF90eChza2IsICZ0cyk7
Cj4gPgo+ID4KPiA+IFRoaXMgcHJvYmFibHkgd29uJ3Qgd29yayBzaW5jZSB0aGUgYnVmZmVyIGlz
IHJlYWQtb25seSBmcm9tIHRoZSBkZXZpY2UuIChTZWUKPiA+IHZpcnRxdWV1ZV9hZGRfb3V0YnVm
KCkpLgo+ID4KPiA+IEFub3RoZXIgaXNzdWUgdGhhdCBJIHZhZ3VlbHkgcmVtZW1iZXIgdGhhdCB0
aGUgdmlydGlvIHNwZWMgZm9yYmlkcyBvdXQKPiA+IGJ1ZmZlciBhZnRlciBpbiBidWZmZXIuCj4K
PiBCb3RoIERyaXZlciBSZXF1aXJlbWVudHM6IE1lc3NhZ2UgRnJhbWluZyBhbmQgRHJpdmVyIFJl
cXVpcmVtZW50czogU2NhdHRlci1HYXRoZXIgU3VwcG9ydAo+IGhhdmUgdGhpcyBzdGF0ZW1lbnQ6
Cj4KPiAgICAgICAgIFRoZSBkcml2ZXIgTVVTVCBwbGFjZSBhbnkgZGV2aWNlLXdyaXRhYmxlIGRl
c2NyaXB0b3IgZWxlbWVudHMgYWZ0ZXIgYW55IGRldmljZS1yZWFkYWJsZSBkZXNjcmlwdG9yIGVs
ZS0KPiAgICAgICAgIG1lbnRzLgo+Cj4KPiBzaW1pbGFybHkKPgo+IERldmljZSBSZXF1aXJlbWVu
dHM6IFRoZSBWaXJ0cXVldWUgRGVzY3JpcHRvciBUYWJsZQo+ICAgICAgICAgQSBkZXZpY2UgTVVT
VCBOT1Qgd3JpdGUgdG8gYSBkZXZpY2UtcmVhZGFibGUgYnVmZmVyLCBhbmQgYSBkZXZpY2UgU0hP
VUxEIE5PVCByZWFkIGEgZGV2aWNlLXdyaXRhYmxlCj4gICAgICAgICBidWZmZXIuCgpUaGFua3Mu
IFRoYXQncyBjbGVhci4gU28gdGhlIGNsZWFuIHNvbHV0aW9uIHdvdWxkIGJlIHRvIGFkZCBhCmRl
dmljZS13cml0YWJsZSBkZXNjcmlwdG9yIGFmdGVyIHRoZSBleGlzdGluZyBkZXZpY2UtcmVhZGFi
bGUgb25lcy4KCkFuZCB0aGUgZGV2aWNlIG11c3QgYmUgYXdhcmUgdGhhdCB0aGlzIGlzIHRvIHJl
dHVybiB0aGUgdHN0YW1wIG9ubHkuCkluIHRoZSBleGFtcGxlIGltcGxlbWVudGF0aW9uIG9mIHZo
b3N0LCBpdCBoYXMgdG8gZXhjbHVkZSB0aGlzIGxhc3QKZGVzY3JpcHRvciBmcm9tIHRoZSBtc2ct
Pm1zZ19pdGVyIGlvdmVjIGFycmF5IHdpdGggcGFja2V0IGRhdGEKaW5pdGlhbGl6ZWQgYXQgZ2V0
X3R4X2J1ZnMvaW5pdF9pb3ZfaXRlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
