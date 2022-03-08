Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0078C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 17:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89F48402B1;
	Tue,  8 Mar 2022 17:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3uSlp9w0XsW; Tue,  8 Mar 2022 17:17:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9730E400FB;
	Tue,  8 Mar 2022 17:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E942C0012;
	Tue,  8 Mar 2022 17:17:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D65CC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 17:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BD2C60F45
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 17:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7q4ipEb-whY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 17:17:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 094EF60BE9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646759874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XS0ZDRJdbTaFXTIodebwWZ2Zs2A9XDPYU7p1D6O1mf0=;
 b=dIjGTYSRPyf8AKazEXlpGRVbebGC4btXDfmoHeC6Jbfb4GwJKy6OTd0MbJrNk3IXt7ZHIN
 t6hK+yMw9CuSIWM0adhzdFOofgGPMwX9hSfJ1P7dS+utshUS0kBaXTWP2CZLf12kIfbtQE
 Fgh4bVS8xZ6RSnA9G1ApWvI7QHwsKeY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-vwPMyZGnOYSgVcHrZtqI8g-1; Tue, 08 Mar 2022 12:17:53 -0500
X-MC-Unique: vwPMyZGnOYSgVcHrZtqI8g-1
Received: by mail-wm1-f71.google.com with SMTP id
 l13-20020a7bcf0d000000b0038982c6bf8fso1369240wmg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 09:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XS0ZDRJdbTaFXTIodebwWZ2Zs2A9XDPYU7p1D6O1mf0=;
 b=3FW8vp73BX4d9z7Jo6H+uZ1/FxwdoqDansufwGtf7ca5DTqRgtULgapqpD9YJ4haaI
 UM0PKPazOEQwwx24FoCPgQYjnkEE4U8QFqFQUNskp+S2GhbRNYpoUBazRPy5Y8hoPXi6
 fI9nVzPlHJELnKHuGf6CrfmKW2jcaZSSKolBfkaYg+nd/H2eAJKysjQvODd/7GJW+esg
 coTK6F9VryNFlg2OtdVTr4R4XH+ZBD9qTOHczMveyW8bfUdjdLLqsiX87abnfElDVi8u
 kHbogh/YeHGfyQJJpxyFjdW5+8t8D6OMDjKPizHoPRVE3rfDMbimEaLj2UOQptuU8ozp
 eaHA==
X-Gm-Message-State: AOAM531WIVGnpBtQHk9+klXxo9GEy0S+JJvI5w+r3MMJeqyk9K06Fsa+
 7caZK9kMoqcn0bXx36DrrtP74LwjSkI3oJV+EN/YC/93/NS/BfWHizIZ3JuizyIx+H0r0UzLBWS
 2Pwj8XFR2bB38ts6lqeJVtmWfjZ7J9N9GLEx68+bhkw==
X-Received: by 2002:a5d:6d88:0:b0:1e3:37c1:3633 with SMTP id
 l8-20020a5d6d88000000b001e337c13633mr13694517wrs.484.1646759870731; 
 Tue, 08 Mar 2022 09:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaK2eVHRi2q7VHFxDpXED+f3vKvPZuHUTcfgXWJzM+PfGD7TWOts3SCW6T6OiVKQsiFqgzBw==
X-Received: by 2002:a5d:6d88:0:b0:1e3:37c1:3633 with SMTP id
 l8-20020a5d6d88000000b001e337c13633mr13694505wrs.484.1646759870390; 
 Tue, 08 Mar 2022 09:17:50 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 u18-20020adfdd52000000b001f04e9f215fsm13950204wrm.53.2022.03.08.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 09:17:49 -0800 (PST)
Date: Tue, 8 Mar 2022 12:17:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308120858-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
 <20220308055003-mutt-send-email-mst@kernel.org>
 <YidBz7SxED2ii1Lh@kroah.com>
 <20220308071718-mutt-send-email-mst@kernel.org>
 <YidXT6zP1QN5KZUs@google.com>
MIME-Version: 1.0
In-Reply-To: <YidXT6zP1QN5KZUs@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
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

T24gVHVlLCBNYXIgMDgsIDIwMjIgYXQgMDE6MTc6MDNQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIFR1ZSwgMDggTWFyIDIwMjIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiAKPiA+
IE9uIFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDEyOjQ1OjE5UE0gKzAxMDAsIEdyZWcgS0ggd3JvdGU6
Cj4gPiA+IE9uIFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDA1OjU1OjU4QU0gLTA1MDAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIE1hciAwOCwgMjAyMiBhdCAxMDo1Nzo0
MkFNICswMTAwLCBHcmVnIEtIIHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCBNYXIgMDgsIDIwMjIg
YXQgMDk6MTU6MjdBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUs
IDA4IE1hciAyMDIyLCBHcmVnIEtIIHdyb3RlOgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBP
biBUdWUsIE1hciAwOCwgMjAyMiBhdCAwODoxMDowNkFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIDA3IE1hciAyMDIyLCBHcmVnIEtIIHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTWFyIDA3LCAyMDIyIGF0IDA3
OjE3OjU3UE0gKzAwMDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiB2aG9z
dF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmluZyBp
dHMgY2FsbAo+ID4gPiA+ID4gPiA+ID4gPiA+IHRvIHZob3N0X2dldF92cV9kZXNjKCkuICBBbGwg
d2UgaGF2ZSB0byBkbyBoZXJlIGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gPiA+ID4gPiA+ID4g
PiA+IGR1cmluZyB2aXJ0cXVldWUgY2xlYW4tdXAgYW5kIHdlIG1pdGlnYXRlIHRoZSByZXBvcnRl
ZCBpc3N1ZXMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gQWxzbyBX
QVJOKCkgYXMgYSBwcmVjYXV0aW9uYXJ5IG1lYXN1cmUuICBUaGUgcHVycG9zZSBvZiB0aGlzIGlz
IHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gY2FwdHVyZSBwb3NzaWJsZSBmdXR1cmUgcmFjZSBjb25k
aXRpb25zIHdoaWNoIG1heSBwb3AgdXAgb3ZlciB0aW1lLgo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiA+ID4gPiA+IExpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1
Zz9leHRpZD0yNzk0MzJkMzBkODI1ZTYzYmEwMAo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiA+ID4gPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+
ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2FkYzNjYjMyMzg1NTg2YmVjODU5QHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20KPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+
ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxMCArKysrKysrKysrCj4gPiA+
ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4gPiA+ID4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gPiA+ID4gPiA+ID4gPiA+IGlu
ZGV4IDU5ZWRiNWExZmZlMjguLmVmN2UzNzFlM2U2NDkgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTY5Myw2ICs2OTMs
MTUgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gPiA+
ID4gPiA+ID4gPiA+ID4gIAlpbnQgaTsKPiA+ID4gPiA+ID4gPiA+ID4gPiAgCj4gPiA+ID4gPiA+
ID4gPiA+ID4gIAlmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiA+ID4gPiA+ID4g
PiA+ID4gPiArCQkvKiBObyB3b3JrZXJzIHNob3VsZCBydW4gaGVyZSBieSBkZXNpZ24uIEhvd2V2
ZXIsIHJhY2VzIGhhdmUKPiA+ID4gPiA+ID4gPiA+ID4gPiArCQkgKiBwcmV2aW91c2x5IG9jY3Vy
cmVkIHdoZXJlIGRyaXZlcnMgaGF2ZSBiZWVuIHVuYWJsZSB0byBmbHVzaAo+ID4gPiA+ID4gPiA+
ID4gPiA+ICsJCSAqIGFsbCB3b3JrIHByb3Blcmx5IHByaW9yIHRvIGNsZWFuLXVwLiAgV2l0aG91
dCBhIHN1Y2Nlc3NmdWwKPiA+ID4gPiA+ID4gPiA+ID4gPiArCQkgKiBmbHVzaCB0aGUgZ3Vlc3Qg
d2lsbCBtYWxmdW5jdGlvbiwgYnV0IGF2b2lkaW5nIGhvc3QgbWVtb3J5Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gKwkJICogY29ycnVwdGlvbiBpbiB0aG9zZSBjYXNlcyBkb2VzIHNlZW0gcHJlZmVyYWJs
ZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiArCQkgKi8KPiA+ID4gPiA+ID4gPiA+ID4gPiArCQlXQVJO
X09OKG11dGV4X2lzX2xvY2tlZCgmZGV2LT52cXNbaV0tPm11dGV4KSk7Cj4gPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBTbyB5b3UgYXJlIHRyYWRpbmcgb25lIHN5emJvdCB0cmln
Z2VyZWQgaXNzdWUgZm9yIGFub3RoZXIgb25lIGluIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiBmdXR1
cmU/ICA6KQo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gSWYgdGhpcyBldmVy
IGNhbiBoYXBwZW4sIGhhbmRsZSBpdCwgYnV0IGRvbid0IGxvZyBpdCB3aXRoIGEgV0FSTl9PTigp
IGFzCj4gPiA+ID4gPiA+ID4gPiA+IHRoYXQgd2lsbCB0cmlnZ2VyIHRoZSBwYW5pYy1vbi13YXJu
IGJveGVzLCBhcyB3ZWxsIGFzIHN5emJvdC4gIFVubGVzcwo+ID4gPiA+ID4gPiA+ID4gPiB5b3Ug
d2FudCB0aGF0IHRvIGhhcHBlbj8KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gTm8s
IFN5emJvdCBkb2Vzbid0IHJlcG9ydCB3YXJuaW5ncywgb25seSBCVUdzIGFuZCBtZW1vcnkgY29y
cnVwdGlvbi4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBIYXMgaXQgY2hhbmdlZD8gIExh
c3QgSSBsb29rZWQsIGl0IGRpZCB0cmlnZ2VyIG9uIFdBUk5fKiBjYWxscywgd2hpY2gKPiA+ID4g
PiA+ID4gPiBoYXMgcmVzdWx0ZWQgaW4gYSBodWdlIG51bWJlciBvZiBrZXJuZWwgZml4ZXMgYmVj
YXVzZSBvZiB0aGF0Lgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gRXZlcnl0aGluZyBpcyBjdXN0
b21pc2FibGUgaW4gc3l6a2FsbGVyLCBzbyBtYXliZSB0aGVyZSBhcmUgc3BlY2lmaWMKPiA+ID4g
PiA+ID4gYnVpbGRzIHdoaWNoIHBhbmljX29uX3dhcm4gZW5hYmxlZCwgYnV0IG5vbmUgdGhhdCBJ
J20gaW52b2x2ZWQgd2l0aAo+ID4gPiA+ID4gPiBkby4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gTWFu
eSBzeXN0ZW1zIHJ1biB3aXRoIHBhbmljLW9uLXdhcm4gKGkuZS4gdGhlIGNsb3VkKSwgYXMgdGhl
eSB3YW50IHRvCj4gPiA+ID4gPiBkcm9wIGEgYm94IGFuZCByZXN0YXJ0IGl0IGlmIGFueXRoaW5n
IGdvZXMgd3JvbmcuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoYXQncyB3aHkgc3l6Ym90IHJlcG9y
dHMgb24gV0FSTl8qIGNhbGxzLiAgVGhleSBzaG91bGQgbmV2ZXIgYmUKPiA+ID4gPiA+IHJlYWNo
YWJsZSBieSB1c2Vyc3BhY2UgYWN0aW9ucy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBIZXJlIGZv
bGxvd3MgYSB0b3BpY2FsIGV4YW1wbGUuICBUaGUgcmVwb3J0IGFib3ZlIGluIHRoZSBMaW5rOiB0
YWcKPiA+ID4gPiA+ID4gY29tZXMgd2l0aCBhIGNyYXNobG9nIFswXS4gIEluIHRoZXJlIHlvdSBj
YW4gc2VlIHRoZSBXQVJOKCkgYXQgdGhlCj4gPiA+ID4gPiA+IGJvdHRvbSBvZiB2aG9zdF9kZXZf
Y2xlYW51cCgpIHRyaWdnZXIgbWFueSB0aW1lcyBkdWUgdG8gYSBwb3B1bGF0ZWQKPiA+ID4gPiA+
ID4gKG5vbi1mbHVzaGVkKSB3b3JrZXIgbGlzdCwgYmVmb3JlIGZpbmFsbHkgdHJpcHBpbmcgdGhl
IEJVRygpIHdoaWNoCj4gPiA+ID4gPiA+IHRyaWdnZXJzIHRoZSByZXBvcnQ6Cj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiBbMF0gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vdGV4dD90YWc9
Q3Jhc2hMb2cmeD0xNmE2MWZjZTcwMDAwMAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBPaywgc28gYm90
aCBoYXBwZW5zIGhlcmUuICBCdXQgZG9uJ3QgYWRkIGEgd2FybmluZyBmb3Igc29tZXRoaW5nIHRo
YXQKPiA+ID4gPiA+IGNhbid0IGhhcHBlbi4gIEp1c3QgaGFuZGxlIGl0IGFuZCBtb3ZlIG9uLiAg
SXQgbG9va3MgbGlrZSB5b3UgYXJlCj4gPiA+ID4gPiBoYW5kbGluZyBpdCBpbiB0aGlzIGNvZGUs
IHNvIHBsZWFzZSBkcm9wIHRoZSBXQVJOX09OKCkuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IHRoYW5r
cywKPiA+ID4gPiA+IAo+ID4gPiA+ID4gZ3JlZyBrLWgKPiA+ID4gPiAKPiA+ID4gPiBIbW0uIFdl
bGwgdGhpcyB3aWxsIG1lYW4gaWYgd2UgZXZlciByZWludHJvZHVjZSB0aGUgYnVnIHRoZW4KPiA+
ID4gPiBzeXprYWxsZXIgd2lsbCBub3QgY2F0Y2ggaXQgZm9yIHVzIDooIEFuZCB0aGUgYnVnIGlz
IHRoZXJlLAo+ID4gPiA+IGl0IGp1c3QgcmVzdWx0cyBpbiBhIGhhcmQgdG8gcmVwcm9kdWNlIGVy
cm9yIGZvciB1c2Vyc3BhY2UuCj4gPiA+IAo+ID4gPiBJcyB0aGlzIGFuIGVycm9yIHlvdSBjYW4g
cmVjb3ZlciBmcm9tIGluIHRoZSBrZXJuZWw/Cj4gPiA+ICBXaGF0IGlzIHVzZXJzcGFjZQo+ID4g
PiBzdXBwb3NlZCB0byBrbm93IHdpdGggdGhpcyBpbmZvcm1hdGlvbiB3aGVuIGl0IHNlZXMgaXQ/
Cj4gPiAKPiA+IElJVUMgd2UgYXJlIHRhbGtpbmcgYWJvdXQgYSB1c2UgYWZ0ZXIgZnJlZSBoZXJl
IHNpbmNlIHdlIHNvbWVob3cKPiA+IG1hbmFnZWQgdG8gaGF2ZSBhIHBvaW50ZXIgdG8gdGhlIGRl
dmljZSBpbiBhIHdvcmtlciB3aGlsZQo+ID4gZGV2aWNlIGlzIGJlaW5nIGRlc3Ryb3llZC4KPiA+
IAo+ID4gVGhhdCdzIHRoZSBwb2ludCBvZiB0aGUgd2FybmluZyBhcyB1c2UgYWZ0ZXIgZnJlZSBp
cyBoYXJkIHRvIGRlYnVnLiBZb3UKPiA+IGFzayBjYW4gd2UgcmVjb3ZlciBmcm9tIGEgdXNlIGFm
dGVyIGZyZWU/IAo+ID4gCj4gPiBBcyByZWdhcmRzIHRvIHRoZSBhZGRlZCBsb2NrLCBJSVVDIGl0
IGtpbmQgb2Ygc2hpZnRzIHRoZSB1c2UgYWZ0ZXIgZnJlZQo+ID4gd2luZG93IHRvIGxhdGVyIGFu
ZCBzaW5jZSB3ZSB6ZXJvIG91dCBzb21lIG9mIHRoZSBtZW1vcnkganVzdCBiZWZvcmUgd2UKPiA+
IGZyZWUgaXQsIGl0J3MgYSBiaXQgbW9yZSBsaWtlbHkgdG8gcmVjb3Zlci4gIEkgd291bGQgc3Rp
bGwgbGlrZSB0byBzZWUKPiA+IHNvbWUgbW9yZSBhbmFseXNpcyBvbiB3aHkgdGhlIHNpdHVhdGlv
biBpcyBhbHdheXMgYmV0dGVyIHRoYW4gaXQgd2FzCj4gPiBiZWZvcmUgdGhvdWdoLgo+IAo+IFdp
dGggdGhlIGxvY2tzIGluIHBsYWNlLCB0aGUgVUFGIHNob3VsZCBub3Qgb2NjdXIuCgpUaGlzIHJl
YWxseSBkZXBlbmRzIHdoaWNoIFVBRi4gWWVzIHVzZSBvZiB2cS0+cHJpdmF0ZV9kYXRhIGlzIHBy
b3RlY3RlZApieSBhIGxvY2sgaW5zaWRlIHRoZSBWUS4KCkhvd2V2ZXIsIHdlIGFyZSB0YWxraW5n
IGFib3V0IHZob3N0X25ldF9yZWxlYXNlLCB3aGljaCBlbmRzIHVwIGRvaW5nCgogICAgICAgIGtm
cmVlKG4tPmRldi52cXMpOwouLi4KICAgICAgICBrdmZyZWUobik7CgppZiBzb21lb25lIGlzIGhv
bGRpbmcgYSBwb2ludGVyIHRvIGEgdnEgb3IgdGhlIGRldmljZSBpdHNlbGYgYXQgdGhpcwpwb2lu
dCwgbm8gbG9ja3MgdGhhdCBhcmUgcGFydCBvZiBvbmUgb2Ygc2FpZCBzdHJ1Y3R1cmVzIHdpbGwg
YmUKZWZmZWN0aXZlIGluIHByZXZlbnRpbmcgYSB1c2UgYWZ0ZXIgZnJlZSwgYW5kIHVzaW5nIGEg
bG9jayB0byBkZWxheSBzdWNoCmFjY2Vzc2VzIHRvIHRoaXMgcG9pbnQganVzdCBtaWdodCBtYWtl
IGl0IG1vcmUgbGlrZWx5IHRoZXJlJ3MgYSB1c2UKYWZ0ZXIgZnJlZS4KCgpBbGwgb2YgdGhlIGFi
b3ZlIGlzIHdoeSB3ZSBkaWRuJ3QgcnVzaCB0byBhcHBseSB0aGUgbG9ja2luZyBwYXRjaCBpbiB0
aGUKZmlyc3QgcGxhY2UsIGZvciBhbGwgdGhhdCBpdCBzZWVtZWQgdG8gZml4IHRoZSBzeXNib3og
Y3Jhc2guCgoKCj4gVGhlIGlzc3VlIGhlcmUgaXMgdGhhdCB5b3UgaGF2ZSAyIGRpZmZlcmVudCB0
YXNrcyBwcm9jZXNzaW5nIHRoZQo+IHNhbWUgYXJlYSBvZiBtZW1vcnkgKHZpYSBwb2ludGVycyB0
byBzdHJ1Y3RzKS4gIEluIHRoZXNlIHNjZW5hcmlvcyB5b3UKPiBzaG91bGQgYWx3YXlzIHByb3Zp
ZGUgbG9ja2luZyBhbmQvb3IgcmVmZXJlbmNlIGNvdW50aW5nIHRvIHByZXZlbnQKPiBtZW1vcnkg
Y29ycnVwdGlvbiBvciBVQUYuCgpCdXQgd2Ugc2hvdWxkIG5vdCBoYXZlIDIgdGFza3MgZG9pbmcg
dGhhdCwgYW5kIGlmIHdlIGRvIHRoZW4gbG9jawpqdXN0IG1pZ2h0IGJlIGluZWZmZWN0aXZlIHNp
bmNlIHRoZSBsb2NrIGl0c2VsZiBpcyByZWxlYXNlZC4KCkFnYWluIG1heWJlIGluIHRoaXMgY2Fz
ZSBpdCBtYWtlcyBzZW5zZSBidXQgaXQgbmVlZHMgYSBtb3JlIGRldGFpbGVkCmFuYWx5c2lzIHRv
IHNob3cgaXQncyBhIG5ldCB3aW4gdGhhbiBqdXN0ICJ3ZSBoYXZlIHR3byB0YXNrcyBlcmdvIHdl
Cm5lZWQgbG9ja2luZyIuCgo+IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pavXQo+IFByaW5jaXBh
bCBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwo+IExpbmFyby5vcmcg4pSCIE9w
ZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29r
IHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
