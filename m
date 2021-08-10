Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6AC4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 15:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3A660EBD
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 15:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA3A660EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CA08356E;
	Tue, 10 Aug 2021 15:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o1ij0X4bO-_2; Tue, 10 Aug 2021 15:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0EFA835B9;
	Tue, 10 Aug 2021 15:31:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBC4CC0010;
	Tue, 10 Aug 2021 15:31:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBAAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38189606DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyDUrfCrk176
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:31:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 063CB606C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628609486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ek3uLQSZrCriUzWHCL0/JBZZlXPCCqDxDWWZFiApoRQ=;
 b=TrsvzD9HO21mV9KG4j6aH9RRMaAwNVKxTHsJSkG0jwHkyyJDmYv02Qdtl0DTwQa83t3p3G
 Ni3xPL34VDrx1AU3JtKVMdB9dLXwO2SxobcI61VevPHwpNCw1Oec3L0o35kK1tVrJfM/Hu
 mJI6V8dsvEeFCnUFeXdPH0f/Dv8nQNg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38--zqioIgSPZS0wRq2irgO2Q-1; Tue, 10 Aug 2021 11:31:22 -0400
X-MC-Unique: -zqioIgSPZS0wRq2irgO2Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 ju25-20020a17090798b9b029058c24b55273so132908ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 08:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ek3uLQSZrCriUzWHCL0/JBZZlXPCCqDxDWWZFiApoRQ=;
 b=lnPM4ijdxvJ8rVq+Gwuobxhfh/6TSO90nMsG4lve1P9d8/+t9iR+tKNOM6Ni8eIxL4
 BC1xNi05421S2eKuXa84e9GzDNwNSVNjBGhJXI+5/qDQspxF9hQK4dUl7U0vgk4pXpXI
 hGMpIQMctyDIdL/h1OnjDCwgaSYr6xPIbSn75IukPR6PM7vwRVfToXN+7LWaSLwuYQCM
 ZYCXAyXu5Ard/8UcpAm6Fs4DeJLQ/LuZI8sVbD2arKek9pAh4nNejdwlWT8YVkjcpnz3
 V8CP/edMZro9xod4onWUI6l1DoS7LR/7ChP6jzFgfLmmNkxTRQIk06uDzNIyobZ8rNcx
 /P8A==
X-Gm-Message-State: AOAM53135SuoszsrvnvAQsuwGw7nbN/RI5xBXyBUf3UMeT6/ZuslTqm8
 PyLFa9Y5v3NwdOlMueT0p2/11Hfw5l2zXd09FeRYznAEi+aaqJywabJp9HTQQ7McFGIoWcVeD40
 WRzlgH5bhSqOz9OUfncVAoA9qQ1m7QTANtkMdaFmEsQ==
X-Received: by 2002:a17:906:c085:: with SMTP id
 f5mr29013632ejz.250.1628609481522; 
 Tue, 10 Aug 2021 08:31:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJToxLuejQEu3HhmGj4YJvUxXZBWfGJHIAGJ+quum1uOvbzJIzqC+tNpowNawxKsigGlFjTQ==
X-Received: by 2002:a17:906:c085:: with SMTP id
 f5mr29013598ejz.250.1628609481215; 
 Tue, 10 Aug 2021 08:31:21 -0700 (PDT)
Received: from redhat.com ([2.55.156.103])
 by smtp.gmail.com with ESMTPSA id h10sm9414352edb.74.2021.08.10.08.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 08:31:20 -0700 (PDT)
Date: Tue, 10 Aug 2021 11:31:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210810112147-mutt-send-email-mst@kernel.org>
References: <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
 <20210723080924-mutt-send-email-mst@kernel.org>
 <CACFia2en0JJDFyz3Umk-JTnMT=kjvRogt4PudED4kiLeMjcHFg@mail.gmail.com>
 <CACFia2fx7Lt-4o_uqDznvk-VgdsMtD64qv6RYkrCjKLu2yt8bg@mail.gmail.com>
 <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
 <20210727050944-mutt-send-email-mst@kernel.org>
 <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
 <20210802154901-mutt-send-email-mst@kernel.org>
 <CACFia2f8xmOwB69Cj+OUNobNSurVnrLrJFdrxnmurww9aSzJMw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2f8xmOwB69Cj+OUNobNSurVnrLrJFdrxnmurww9aSzJMw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBBdWcgMDIsIDIwMjEgYXQgMDQ6MjM6MTJQTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBNb24sIEF1ZyAyLCAyMDIxIGF0IDI6NTIgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBBdWcgMDIsIDIwMjEgYXQgMDE6MzI6MDVQ
TSAtMDUwMCwgSXZhbiB3cm90ZToKPiA+ID4gT24gVHVlLCBKdWwgMjcsIDIwMjEgYXQgNDoxMSBB
TSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4g
PiA+IE9uIE1vbiwgSnVsIDI2LCAyMDIxIGF0IDA3OjQ0OjQzUE0gLTA1MDAsIEl2YW4gd3JvdGU6
Cj4gPiA+ID4gPiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCAxMToxOCBQTSBJdmFuIDxpdmFuQHBy
ZXN0aWdldHJhbnNwb3J0YXRpb24uY29tPiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
T24gU2F0LCBKdWwgMjQsIDIwMjEgYXQgNzoxNyBQTSBJdmFuIDxpdmFuQHByZXN0aWdldHJhbnNw
b3J0YXRpb24uY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9uIEZyaSwg
SnVsIDIzLCAyMDIxIGF0IDc6MzMgQU0gSXZhbiA8aXZhbkBwcmVzdGlnZXRyYW5zcG9ydGF0aW9u
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4+IE9uIEZyaSwgSnVsIDIz
LCAyMDIxIGF0IDc6MTAgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+Pj4gT24gRnJpLCBKdWwgMjMsIDIwMjEg
YXQgMDM6MDY6MDRBTSAtMDUwMCwgSXZhbiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+ID4gT24gRnJp
LCBKdWwgMjMsIDIwMjEgYXQgMjo1OSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+ID4gPgo+ID4gPiA+ID4gPiA+Pj4gPiA+IE9uIFRo
dSwgSnVsIDIyLCAyMDIxIGF0IDExOjUwOjExUE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4gPiA+ID4g
PiA+ID4+PiA+ID4gPiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMToyNSBQTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4g5Zyo
IDIwMjEvNy8yMyDkuIrljYgxMDo1NCwgSXZhbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4+PiA+ID4g
PiA+ID4gT24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgOTozNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPj4gRG9lcyBpdCB3
b3JrIGlmIHlvdSB0dXJuIG9mZiBscm8gYmVmb3JlIGVuYWJsaW5nIHRoZSBmb3J3YXJkaW5nPwo+
ID4gPiA+ID4gPiA+Pj4gPiA+ID4gPiA+IDAgcm9vdEBOdVJhaWQ6fiMgZXRodG9vbCAtSyBldGgw
IGxybyBvZmYKPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gPiBBY3R1YWwgY2hhbmdlczoKPiA+ID4g
PiA+ID4gPj4+ID4gPiA+ID4gPiByeC1scm86IG9uIFtyZXF1ZXN0ZWQgb2ZmXQo+ID4gPiA+ID4g
PiA+Pj4gPiA+ID4gPiA+IENvdWxkIG5vdCBjaGFuZ2UgYW55IGRldmljZSBmZWF0dXJlcwo+ID4g
PiA+ID4gPiA+Pj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Pj4gPiA+ID4gPiBPaywgaXQgbG9va3Mg
bGlrZSB0aGUgZGV2aWNlIG1pc3NlcyB0aGUgVklSVElPX05FVF9GX0NUUkxfR1VFU1RfT0ZGTE9B
RFMKPiA+ID4gPiA+ID4gPj4+ID4gPiA+ID4gd2hpY2ggbWFrZXMgaXQgaW1wb3NzaWJsZSB0byBj
aGFuZ2UgdGhlIExSTyBzZXR0aW5nLgo+ID4gPiA+ID4gPiA+Pj4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+Pj4gPiA+ID4gPiBEaWQgeW91IHVzZSBxZW11PyBJZiB5ZXMsIHdoYXQncyB0aGUgcWVtdSB2
ZXJzaW9uIHlvdSd2ZSB1c2VkPwo+ID4gPiA+ID4gPiA+Pj4gPiA+ID4KPiA+ID4gPiA+ID4gPj4+
ID4gPiA+IFRoZXNlIGFyZSBWaXJ0dWFsQm94IG1hY2hpbmVzLCB3aGljaCBJJ3ZlIGJlZW4gdXNp
bmcgZm9yIHllYXJzIHdpdGgKPiA+ID4gPiA+ID4gPj4+ID4gPiA+IGxvbmd0ZXJtIGtlcm5lbHMg
NC4xOSwgYW5kIEkgbmV2ZXIgaGFkIHN1Y2ggYSBwcm9ibGVtLiAgQnV0IG5vdyB0aGF0IEkKPiA+
ID4gPiA+ID4gPj4+ID4gPiA+IHRyaWVkIHVwZ3JhZGluZyB0byBrZXJuZWxzIDUuMTAgb3IgNS4x
MyAtLSB0aGUgcGFuaWNzIHN0YXJ0ZWQuICBUaGVzZQo+ID4gPiA+ID4gPiA+Pj4gPiA+ID4gYXJl
IGp1c3QgZ2VuZXJpYyBrZXJuZWwgYnVpbGRzLCBhbmQgYSBtaW5pbWFsaXN0aWMgdXNlcnNwYWNl
Lgo+ID4gPiA+ID4gPiA+Pj4gPiA+Cj4gPiA+ID4gPiA+ID4+PiA+ID4gSSB3b3VsZCBiZSB1c2Vm
dWwgdG8gc2VlIHRoZSBmZWF0dXJlcyB5b3VyIHZpcnR1YWxib3ggaW5zdGFuY2UgcHJvdmlkZXMK
PiA+ID4gPiA+ID4gPj4+ID4gPgo+ID4gPiA+ID4gPiA+Pj4gPiA+IGNhdCAvc3lzL2NsYXNzL25l
dC9ldGgwL2RldmljZS9mZWF0dXJlcwo+ID4gPiA+ID4gPiA+Pj4gPgo+ID4gPiA+ID4gPiA+Pj4g
PiAjIGNhdCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwo+ID4gPiA+ID4gPiA+
Pj4gPiAxMTAwMDEwMTEwMTExMDExMTExMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwCj4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+Pj4gSSB3YXMgYWJsZSB0
byByZXByb2R1Y2UgdGhlIHdhcm5pbmcgYnV0IG5vdCB0aGUgcGFuaWMuCj4gPiA+ID4gPiA+ID4+
PiBPVE9IIGlmIExSTyBzdGF5cyBvbiB3aGVuIGVuYWJsaW5nIGZvcndhcmRpbmcgdGhhdAo+ID4g
PiA+ID4gPiA+Pj4gaXMgYWxyZWFkeSBhIHByb2JsZW0uIEFueSBjaGFuY2UgeW91IGNhbiBiaXNl
Y3QgdG8KPiA+ID4gPiA+ID4gPj4+IGZpbmQgb3V0IHdoaWNoIGNoYW5nZSBpbnRyb2R1Y2VkIHRo
ZSBwYW5pYz8KPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPj4gQW55
IGtlcm5lbHMgdXAgdG8gNC4xOS4xOTggZG9uJ3QgcGFuaWMuCj4gPiA+ID4gPiA+ID4+IEFueSBr
ZXJuZWxzIDUuMTArIHBhbmljIGltbWVkaWF0ZWx5IHVwb24gc3RhcnRpbmcgZm9yd2FyZGluZy4K
PiA+ID4gPiA+ID4gPj4gSSBoYXZlIG5vdCB0ZXN0ZWQgYW55IGtlcm5lbHMgYmV0d2VlbiA0LjE5
IGFuZCA1LjEwLgo+ID4gPiA+ID4gPiA+PiBJIGd1ZXNzIEkgY2FuIGJ1aWxkIGEgZmV3IGtlcm5l
bHMgaW5iZXR3ZWVuLCBhbmQgdHJ5IHBpbnBvaW50IHdoZXJlIGl0IHN0YXJ0cy4KPiA+ID4gPiA+
ID4gPj4gVGhhdCBtYXkgdGFrZSBhIGRheSBvciBzby4gIEknbGwgZ2V0IG9uIHdpdGggaXQgbm93
LCBhbmQgcmVwb3J0IG15IGZpbmRpbmdzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU28s
IEkgbmFycm93ZWQgIGl0IGRvd246IHRoZSBwYW5pY3Mgc3RhcnQgd2l0aCBrZXJuZWwgNS4wLXJj
Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBNb3JlIG5hcm93bHksIHRoZSBwcm9ibGVtIHNlZW1z
IGJlIGNvbWluZyBmcm9tIGNvbW1pdAo+ID4gPiA+ID4gPiBhMDJlODk2NGVhZjkyNzFhOGE1ZmNj
MGM1NWJkMTNmOTMzYmFmYzU2Lgo+ID4gPiA+ID4gPiBKdXN0IHRvIHRlc3QgbXkgc3VzcGljaW9u
LCBJIGRlbGV0ZWQgYSBmZXcgbGluZXMgZnJvbSB0aGF0IGNvZGUsCj4gPiA+ID4gPiA+IGFuZCB0
aGUgcGFuaWMgd2VudCBhd2F5LiAgSG9wZSB0aGF0IGhlbHBzIHlvdSBndXlzIGZpZ3VyZSBvdXQK
PiA+ID4gPiA+ID4gd2hhdCB0aGUgcHJvYmxlbSBtaWdodCBiZS4KPiA+ID4gPgo+ID4gPiA+IFdl
bGwgaXQgZGlzYWJsZXMgTFJPIGJ1dCB3ZSBrbmV3IHRoaXMgOiggSSdkIGhlbHAgaWYgd2Uga25l
dwo+ID4gPiA+IHdoZXJlIGRvZXMgaXQgcGFuaWMsIGFsbCB3ZSBzZWUgaXQgdGhlIHdhcm5pbmcg
d2hpY2ggaXMKPiA+ID4gPiByZWxhdGVkIGZvciBzdXJlIGJ1dCBub3QgdGhlIGltbWVkaWF0ZSBy
b290Y2F1c2UgLi4uCj4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gPiA+ID4gPiBAQCAtMjk3OCwxMSArMjk3OCw2IEBACj4gPiA+ID4gPiA+ICAgfQo+
ID4gPiA+ID4gPiAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dV
RVNUX0NTVU0pKQo+ID4gPiA+ID4gPiAgICAgIGRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9SWENT
VU07Cj4gPiA+ID4gPiA+IC0gaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVU
X0ZfR1VFU1RfVFNPNCkgfHwKPiA+ID4gPiA+ID4gLSAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRl
diwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gPiA+ID4gPiAtICAgIGRldi0+ZmVhdHVy
ZXMgfD0gTkVUSUZfRl9MUk87Cj4gPiA+ID4gPiA+IC0gaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2
ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpCj4gPiA+ID4gPiA+IC0gICAg
ZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
ICBkZXYtPnZsYW5fZmVhdHVyZXMgPSBkZXYtPmZlYXR1cmVzOwo+ID4gPiA+ID4KPiA+ID4gPiA+
IEp1c3QgRllJLCBHb29nbGUgdHVybmVkIHVwIHR3byBzaW1pbGFyIGJ1ZyByZXBvc3RzLi4uCj4g
PiA+ID4gPiBBcHIgMTQsIDIwMjAgLS0gaHR0cHM6Ly9naXRodWIuY29tL2NvbnRhaW5lcnMvcG9k
bWFuL2lzc3Vlcy81ODE1Cj4gPiA+ID4gPiBPY3QgMDkuIDIwMjAgLS0gaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDk1OTMKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJ
cyB0aGVyZSBhbnkgc2Vuc2libGUgdGhpbmcgSSBjb3VsZCBkbywgdGVtcG9yYXJpbHksIHVudGls
IHRoaXMKPiA+ID4gPiA+IHByb2JsZW0gaXMgc29ydGVkIG91dD8KPiA+ID4gPiA+IE9yIGFtIEkg
c2ltcGx5IHN0dWNrIHRvIGtlcm5lbHMgNC4xOSBvbiB0aGVzZSBtYWNoaW5lcyBmb3Igbm93Pwo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBTb21ldGhpbmcgbGlrZSB0aGlzIEkgZ3Vlc3M6Cj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBpbmRleCA4YTU4YTJmMDEzYWYuLmNj
NTk4MjE5M2E0MCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBAQCAtMzA2Myw2
ICszMDYzLDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3ZhbGlkYXRlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFy
X2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPgo+
ID4gPiA+ICsgICAgICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9HVUVT
VF9UU080KTsKPiA+ID4gPiArICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9f
TkVUX0ZfR1VFU1RfVFNPNik7Cj4gPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4gPiAgfQo+
ID4gPgo+ID4gPiBXaGVuIEkgYXBwbHkgeW91ciBwYXRjaCwgdGhlbiBJIHNlZSBkcmFzdGljICht
b3JlIHRoYW4gaGFsZikKPiA+ID4gcmVkdWN0aW9ucyBpbiBzcGVlZC4gKGNvbmZpcm1lZCB3aXRo
IGlwZXJmKS4KPiA+ID4KPiA+ID4gQnV0IGlmIGluc3RlYWQgSSBqdXN0IHJlbW92ZSBhIGZldyBs
aW5lcyBmcm9tIGNvbW1pdAo+ID4gPiBhMDJlODk2NGVhZjkyNzFhOGE1ZmNjMGM1NWJkMTNmOTMz
YmFmYzU2Cj4gPiA+IGFzIGluIG15IGVhcmxpZXIgcG9zdCwgdGhlbiBJJ20gYmFjayB0byBmdWxs
IHNwZWVkCj4gPiA+Cj4gPiA+IEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgaXMganVzdCB0ZW1wb3Jh
cnkgd29ya2Fyb3VuZCwgdW50aWwgd2UgZmlndXJlIHRoaXMgb3V0Lgo+ID4KPiA+Cj4gPiBPaCB3
ZWlyZC4gU28gaXQncyBub3QgYWJvdXQgZ2V0dGluZyBzb21lIHdlaXJkIExSTyBwYWNrZXQuIFdl
IHdpbGwgZ2V0IGl0IHdpdGgKPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9UU080IGFueXdheS4gSXQn
cyBhYm91dCB0aGUgTFJPIGZsYWcgYmVpbmcgc2V0IGluCj4gPiBmZWF0dXJlcy4KPiA+Cj4gPiBI
b3cgYWJvdXQgdGhpcyB0aGVuPyBKdXN0IHByZXRlbmQgdG8gTGludXggdGhhdCB3ZSBkaXNhYmxl
ZCBMUk8uCj4gPgo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDhhNThhMmYwMTNhZi4uOGU3ZTRj
ZWExNzZiIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0yNjUxLDggKzI2NTEsOSBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5HVUVTVF9PRkZMT0FEX0xST19NQVNL
Owo+ID4KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2Fk
cyh2aSwgb2ZmbG9hZHMpOwo+ID4gLSAgICAgICAgICAgICAgIGlmIChlcnIpCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+ID4gKyAgICAgICAgICAgICAgIFdBUk5fT04o
ZXJyKTsKPiA+ICsgICAgICAgICAgICAgICAvL2lmIChlcnIpCj4gPiArICAgICAgICAgICAgICAg
Ly8gICAgICByZXR1cm4gZXJyOwo+ID4gICAgICAgICAgICAgICAgIHZpLT5ndWVzdF9vZmZsb2Fk
cyA9IG9mZmxvYWRzOwo+ID4gICAgICAgICB9Cj4gCj4gTm8uIFdpdGggdGhpcyBhcHBsaWVkLCB0
aGUgcHJvYmxlbSBwZXJzaXN0czoKPiAKPiAjIGVjaG8gIjEiID4gL3Byb2Mvc3lzL25ldC9pcHY0
L2lwX2ZvcndhcmQKPiAKPiBrZXJuZWw6IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0t
LS0tLQo+IGtlcm5lbDogbmV0ZGV2aWNlOiBldGgwOiBmYWlsZWQgdG8gZGlzYWJsZSBMUk8hCj4g
a2VybmVsOiBXQVJOSU5HOiBDUFU6IDAgUElEOiA0NTIgYXQgbmV0L2NvcmUvZGV2LmM6MTc2OAo+
IGRldl9kaXNhYmxlX2xybysweDEwOC8weDE1MAo+IGtlcm5lbDogTW9kdWxlcyBsaW5rZWQgaW46
IHNnIG5sc19pc284ODU5XzEgbmxzX2NwNDM3IHZmYXQgZmF0Cj4gaGlkX2dlbmVyaWMgdXNiaGlk
IGhpZCB2aXJ0aW9fbmV0IG5ldF9mYWlsb3ZlciBmYWlsb3ZlciBhZXNuaV9pbnRlbAo+IGxpYmFl
cyBjcnlwdG9fc2ltZCBvaGNpX3BjaSBhaGNpIGxpYmFoY2kgY3J5cHRkIHJhcGwgZWhjaV9wY2kg
b2hjaV9oY2QKPiBlaGNpX2hjZCB1c2Jjb3JlIHVzYl9jb21tb24gbGliYXRhIGV2ZGV2IGxwY19p
Y2ggbWZkX2NvcmUgcm5nX2NvcmUKPiBpMmNfcGlpeDQgaTJjX2NvcmUgdmlydGlvX3BjaSB2aXJ0
aW9fcGNpX21vZGVybl9kZXYgdmlydGlvX3JpbmcgdmlydGlvCj4gcnRjX2Ntb3MgYXRrYmQgbGli
cHMyIGk4MDQyIHNlcmlvIGJhdHRlcnkgYWMgYnV0dG9uIGxvb3AgdW5peAo+IGtlcm5lbDogQ1BV
OiAwIFBJRDogNDUyIENvbW06IGJhc2ggTm90IHRhaW50ZWQgNS4xMy43LWdudS4xLU51TWluaSAj
MQo+IGtlcm5lbDogSGFyZHdhcmUgbmFtZTogaW5ub3RlayBHbWJIIFZpcnR1YWxCb3gvVmlydHVh
bEJveCwgQklPUwo+IFZpcnR1YWxCb3ggMTIvMDEvMjAwNgo+IGtlcm5lbDogUklQOiAwMDEwOmRl
dl9kaXNhYmxlX2xybysweDEwOC8weDE1MAoKQWdhaW4gdGhlIHdhcm5pbmcgaXNuJ3QgYSBiaWcg
ZGVhbC4gSSBhZ3JlZSB3ZSBzaG91bGQgYWRkcmVzcyAtIEphc29uCmFueSB1cGRhdGU/IEJ1dCB0
aGUgbWFpbiBpc3N1ZSBpcyB5b3UgbG9zZSBjb25uZWN0aXZpdHkuIFRoYXQgc3RpbGwKcGVyc2lz
dHMgd2l0aCB0aGlzPyBDYW4ndCB5b3UgZ2V0IGEgc2VyaWFsIGNvbm5lY3Rpb24Kb3V0PyBJIGtu
b3cgcWVtdSBEaWQgdGhlIGtlcm5lbCBvb3BzIGFmdGVyd2FyZHM/CgotLSAKTVNUCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
