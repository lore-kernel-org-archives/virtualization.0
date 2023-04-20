Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA005C77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 04:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5998881DA3;
	Thu, 20 Apr 2023 04:34:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5998881DA3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dHzkENLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3IhuUEAYWSQg; Thu, 20 Apr 2023 04:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C346581D72;
	Thu, 20 Apr 2023 04:34:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C346581D72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99CFBC0036;
	Thu, 20 Apr 2023 04:34:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18918C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D382C60D4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D382C60D4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dHzkENLv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qCmTECPn5Vwt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:34:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4957F60B0F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4957F60B0F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681965260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06+jY2WKqPo86RHuMKHK8QGzTcFzztaHII/d8uwl6SA=;
 b=dHzkENLv9gtb2tQlO2jORZA3qZ+Uz1/+csTAgko8ee5jYGbi0J4E0D4IxaPit1wAwaU+di
 LFh5gcvopUEX1wvqT1adNhpIaov4B6lbte+U8OLDxHYhRvKOD4mviH95MYvDzPi43Cuy9N
 4bM26vkDBpBTPaUTxYTJfwlgxxEDcOc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-MVRociRAPSuG7U91syexdw-1; Thu, 20 Apr 2023 00:34:19 -0400
X-MC-Unique: MVRociRAPSuG7U91syexdw-1
Received: by mail-oo1-f71.google.com with SMTP id
 f33-20020a4a8924000000b00541bb3b5b70so41321ooi.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 21:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681965258; x=1684557258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06+jY2WKqPo86RHuMKHK8QGzTcFzztaHII/d8uwl6SA=;
 b=l4RTMQQVOdXYBoobug6lny2Uuxq7qnrZXli2Ka3bJ2B3rkRb8QoiCYCEMcQvfgHA5K
 iVwFMf6p9+/mitTgqvlJWkp5RkRoM0IrzwPjmqs0NnUgOQboKei8DhGA4+oQhs7vM+Uh
 WsydnbTukRyf6kyMh63NDqawHwUkkThU5msC8Gj2XyG2M8pZNlNVDLh1/tN0dJA1yBnK
 0XHNFY7eiKRaUETSVZOk5puhakicrdzt7IRQ7sip8IWNz8T0PExmO5W4wsw2wgrpsYeh
 9ks99s+TdgHztC+r2mhhSQLfxdGGYjvUZNa+mxRpnQl2a4deUhPUBDXNUsYcE9W6hXIN
 aYgg==
X-Gm-Message-State: AAQBX9fRppP+nm+BBqSZvT8dnnXMtJF43NO+8DYf0+Ul8I50D66qPrFB
 JtMlzdY3feDr/A1z7sl4e914PmzOlzfs6gFem13UgIaOWHQmlP2PExDC1sCyMwKfawZIebwTVnn
 bTRqKiSXqhXeAi/YFVieAoZMc6WhlMs0p9893U/C+ccSssklmXdMF+2Vggw==
X-Received: by 2002:a4a:528c:0:b0:546:645b:7f61 with SMTP id
 d134-20020a4a528c000000b00546645b7f61mr300314oob.4.1681965258338; 
 Wed, 19 Apr 2023 21:34:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD284CqNILld+XSMSEBz3nzQ4d3US7QOWy0beso8yjDxZePaEXv/7wU5hBQK4fMwng5DxENIegnx4pWyrKcrI=
X-Received: by 2002:a4a:528c:0:b0:546:645b:7f61 with SMTP id
 d134-20020a4a528c000000b00546645b7f61mr300300oob.4.1681965258041; Wed, 19 Apr
 2023 21:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230419134329.346825-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 12:34:06 +0800
Message-ID: <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgOTo0M+KAr1BNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBzbWFsbCBzZXJpZXMgZW5hYmxl
cyB2aXJ0aW8tbmV0IGRldmljZSB0eXBlIGluIFZEVVNFLgo+IFdpdGggaXQsIGJhc2ljIG9wZXJh
dGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3RoIHdpdGgKPiB2aXJ0aW8tdmRwYSBhbmQgdmhvc3Qt
dmRwYSB1c2luZyBEUERLIFZob3N0IGxpYnJhcnkgc2VyaWVzCj4gYWRkaW5nIFZEVVNFIHN1cHBv
cnQgWzBdIHVzaW5nIHNwbGl0IHJpbmdzIGxheW91dC4KPgo+IENvbnRyb2wgcXVldWUgc3VwcG9y
dCAoYW5kIHNvIG11bHRpcXVldWUpIGhhcyBhbHNvIGJlZW4KPiB0ZXN0ZWQsIGJ1dCByZXF1aXJl
IGEgS2VybmVsIHNlcmllcyBmcm9tIEphc29uIFdhbmcKPiByZWxheGluZyBjb250cm9sIHF1ZXVl
IHBvbGxpbmcgWzFdIHRvIGZ1bmN0aW9uIHJlbGlhYmx5Lgo+Cj4gT3RoZXIgdGhhbiB0aGF0LCB3
ZSBoYXZlIGlkZW50aWZpZWQgYSBmZXcgZ2FwczoKPgo+IDEuIFJlY29ubmVjdGlvbjoKPiAgYS4g
VkRVU0VfVlFfR0VUX0lORk8gaW9jdGwoKSByZXR1cm5zIGFsd2F5cyAwIGZvciBhdmFpbAo+ICAg
ICBpbmRleCwgZXZlbiBhZnRlciB0aGUgdmlydHF1ZXVlIGhhcyBhbHJlYWR5IGJlZW4KPiAgICAg
cHJvY2Vzc2VkLiBJcyB0aGF0IGV4cGVjdGVkPyBJIGhhdmUgdHJpZWQgaW5zdGVhZCB0bwo+ICAg
ICBnZXQgdGhlIGRyaXZlcidzIGF2YWlsIGluZGV4IGRpcmVjdGx5IGZyb20gdGhlIGF2YWlsCj4g
ICAgIHJpbmcsIGJ1dCBpdCBkb2VzIG5vdCBzZWVtIHJlbGlhYmxlIGFzIEkgc29tZXRpbWVzIGdl
dAo+ICAgICAiaWQgJXUgaXMgbm90IGEgaGVhZCFcbiIgd2FybmluZ3MuIEFsc28gc3VjaCBzb2x1
dGlvbgo+ICAgICB3b3VsZCBub3QgYmUgcG9zc2libGUgd2l0aCBwYWNrZWQgcmluZywgYXMgd2Ug
bmVlZCB0bwo+ICAgICBrbm93IHRoZSB3cmFwIGNvdW50ZXJzIHZhbHVlcy4KCkxvb2tpbmcgYXQg
dGhlIGNvZGVzLCBpdCBvbmx5IHJldHVybnMgdGhlIHZhbHVlIHRoYXQgaXMgc2V0IHZpYQpzZXRf
dnFfc3RhdGUoKS4gSSB0aGluayBpdCBpcyBleHBlY3RlZCB0byBiZSBjYWxsZWQgYmVmb3JlIHRo
ZQpkYXRhcGF0aCBydW5zLgoKU28gd2hlbiBib3VuZCB0byB2aXJ0aW8tdmRwYSwgaXQgaXMgZXhw
ZWN0ZWQgdG8gcmV0dXJuIDAuIEJ1dCB3ZSBuZWVkCnRvIGZpeCB0aGUgcGFja2VkIHZpcnRxdWV1
ZSBjYXNlLCBJIHdvbmRlciBpZiB3ZSBuZWVkIHRvIGNhbGwKc2V0X3ZxX3N0YXRlKCkgZXhwbGlj
aXRseSBpbiB2aXJ0aW8tdmRwYSBiZWZvcmUgc3RhcnRpbmcgdGhlIGRldmljZS4KCldoZW4gYm91
bmQgdG8gdmhvc3QtdmRwYSwgUWVtdSB3aWxsIGNhbGwgVkhPU1RfU0VUX1ZSSU5HX0JBU0Ugd2hp
Y2gKd2lsbCBlbmQgdXAgYSBjYWxsIHRvIHNldF92cV9zdGF0ZSgpLiBVbmZvcnR1bmF0ZWx5LCBp
dCBkb2Vzbid0CnN1cHBvcnQgcGFja2VkIHJpbmcgd2hpY2ggbmVlZHMgc29tZSBleHRlbnNpb24u
Cgo+Cj4gIGIuIE1pc3NpbmcgSU9DVExzOiBpdCB3b3VsZCBiZSBoYW5keSB0byBoYXZlIG5ldyBJ
T0NUTHMgdG8KPiAgICAgcXVlcnkgVmlydGlvIGRldmljZSBzdGF0dXMsCgpXaGF0J3MgdGhlIHVz
ZSBjYXNlIG9mIHRoaXMgaW9jdGw/IEl0IGxvb2tzIHRvIG1lIHVzZXJzcGFjZSBpcwpub3RpZmll
ZCBvbiBlYWNoIHN0YXR1cyBjaGFuZ2Ugbm93OgoKc3RhdGljIGludCB2ZHVzZV9kZXZfc2V0X3N0
YXR1cyhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsIHU4IHN0YXR1cykKewogICAgICAgIHN0cnVjdCB2
ZHVzZV9kZXZfbXNnIG1zZyA9IHsgMCB9OwoKICAgICAgICBtc2cucmVxLnR5cGUgPSBWRFVTRV9T
RVRfU1RBVFVTOwogICAgICAgIG1zZy5yZXEucy5zdGF0dXMgPSBzdGF0dXM7CgogICAgICAgIHJl
dHVybiB2ZHVzZV9kZXZfbXNnX3N5bmMoZGV2LCAmbXNnKTsKfQoKPiBhbmQgcmV0cmlldmUgdGhl
IGNvbmZpZwo+ICAgICBzcGFjZSBzZXQgYXQgVkRVU0VfQ1JFQVRFX0RFViB0aW1lLgoKSW4gb3Jk
ZXIgdG8gYmUgc2FmZSwgVkRVU0UgYXZvaWRzIHdyaXRhYmxlIGNvbmZpZyBzcGFjZS4gT3RoZXJ3
aXNlCmRyaXZlcnMgY291bGQgYmxvY2sgb24gY29uZmlnIHdyaXRpbmcgZm9yZXZlci4gVGhhdCdz
IHdoeSB3ZSBkb24ndCBkbwppdCBub3cuCgpXZSBuZWVkIHRvIGhhcmRlbiB0aGUgY29uZmlnIHdy
aXRlIGJlZm9yZSB3ZSBjYW4gcHJvY2VlZCB0byB0aGlzIEkgdGhpbmsuCgo+Cj4gMi4gVkRVU0Ug
YXBwbGljYXRpb24gYXMgbm9uLXJvb3Q6Cj4gICBXZSBuZWVkIHRvIHJ1biB0aGUgVkRVU0UgYXBw
bGljYXRpb24gYXMgbm9uLXJvb3QuIFRoZXJlCj4gICBpcyBzb21lIHJhY2UgYmV0d2VlbiB0aGUg
dGltZSB0aGUgVURFViBydWxlIGlzIGFwcGxpZWQKPiAgIGFuZCB0aGUgdGltZSB0aGUgZGV2aWNl
IHN0YXJ0cyBiZWluZyB1c2VkLiBEaXNjdXNzaW5nCj4gICB3aXRoIEphc29uLCBoZSBzdWdnZXN0
ZWQgd2UgbWF5IGhhdmUgYSBWRFVTRSBkYWVtb24gcnVuCj4gICBhcyByb290IHRoYXQgd291bGQg
Y3JlYXRlIHRoZSBWRFVTRSBkZXZpY2UsIG1hbmFnZXMgaXRzCj4gICByaWdodHMgYW5kIHRoZW4g
cGFzcyBpdHMgZmlsZSBkZXNjcmlwdG9yIHRvIHRoZSBWRFVTRQo+ICAgYXBwLiBIb3dldmVyLCB3
aXRoIGN1cnJlbnQgSU9DVExzLCBpdCBtZWFucyB0aGUgVkRVU0UKPiAgIGRhZW1vbiB3b3VsZCBu
ZWVkIHRvIGtub3cgc2V2ZXJhbCBpbmZvcm1hdGlvbiB0aGF0Cj4gICBiZWxvbmdzIHRvIHRoZSBW
RFVTRSBhcHAgaW1wbGVtZW50aW5nIHRoZSBkZXZpY2Ugc3VjaAo+ICAgYXMgc3VwcG9ydGVkIFZp
cnRpbyBmZWF0dXJlcywgY29uZmlnIHNwYWNlLCBldGMuLi4KPiAgIElmIHdlIGdvIHRoYXQgcm91
dGUsIG1heWJlIHdlIHNob3VsZCBoYXZlIGEgY29udHJvbAo+ICAgSU9DVEwgdG8gY3JlYXRlIHRo
ZSBkZXZpY2Ugd2hpY2ggd291bGQganVzdCBwYXNzIHRoZQo+ICAgZGV2aWNlIHR5cGUuIFRoZW4g
YW5vdGhlciBkZXZpY2UgSU9DVEwgdG8gcGVyZm9ybSB0aGUKPiAgIGluaXRpYWxpemF0aW9uLiBX
b3VsZCB0aGF0IG1ha2Ugc2Vuc2U/CgpJIHRoaW5rIHNvLiBXZSBjYW4gaGVhciBmcm9tIG90aGVy
cy4KCj4KPiAzLiBDb3JlZHVtcDoKPiAgIEluIG9yZGVyIHRvIGJlIGFibGUgdG8gcGVyZm9ybSBw
b3N0LW1vcnRlbSBhbmFseXNpcywgRFBESwo+ICAgVmhvc3QgbGlicmFyeSBtYXJrcyBwYWdlcyB1
c2VkIGZvciB2cmluZ3MgYW5kIGRlc2NyaXB0b3JzCj4gICBidWZmZXJzIGFzIE1BRFZfRE9EVU1Q
IHVzaW5nIG1hZHZpc2UoKS4gSG93ZXZlciB3aXRoCj4gICBWRFVTRSBpdCBmYWlscyB3aXRoIC1F
SU5WQUwuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB3ZQo+ICAgc2V0IFZNX0RPTlRFWFBBTkQg
ZmxhZyB0byB0aGUgVk1BcyBhbmQgbWFkdmlzZSdzCj4gICBNQURWX0RPRFVNUCBmYWlscyBpZiBp
dCBpcyBwcmVzZW50LiBJJ20gbm90IHN1cmUgdG8KPiAgIHVuZGVyc3RhbmQgd2h5IG1hZHZpc2Ug
d291bGQgcHJldmVudCBNQURWX0RPRFVNUCBpZgo+ICAgVk1fRE9OVEVYUEFORCBpcyBzZXQuIEFu
eSB0aG91Z2h0cz8KCkFkZGluZyBQZXRlciB3aG8gbWF5IGtub3cgdGhlIGFuc3dlci4KClRoYW5r
cwoKPgo+IFswXTogaHR0cHM6Ly9wYXRjaHdvcmsuZHBkay5vcmcvcHJvamVjdC9kcGRrL2xpc3Qv
P3Nlcmllcz0yNzU5NCZzdGF0ZT0lMkEmYXJjaGl2ZT1ib3RoCj4gWzFdOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL0NBQ0drTUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVowV3ZqR1Jy
M3doVStRYXNVZ0BtYWlsLmdtYWlsLmNvbS9ULwo+Cj4gTWF4aW1lIENvcXVlbGluICgyKToKPiAg
IHZkdXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sgZGV2aWNlcwo+
ICAgdmR1c2U6IGVuYWJsZSBWaXJ0aW8tbmV0IGRldmljZSB0eXBlCj4KPiAgZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDExICsrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuMzkuMgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
