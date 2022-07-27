Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B521C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 06:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2935F402BB;
	Wed, 27 Jul 2022 06:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2935F402BB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EobJJzM2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yy9gPKRpcdUn; Wed, 27 Jul 2022 06:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2014C402BA;
	Wed, 27 Jul 2022 06:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2014C402BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9ADFC0035;
	Wed, 27 Jul 2022 06:56:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 571B5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DB0160AC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DB0160AC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EobJJzM2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkTLO-tf6eRH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:56:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D156E605E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D156E605E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658904996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APkoBX4cQj/9DCAu9+1UJTMMx3KoQtqmKQn9C5jb7ac=;
 b=EobJJzM2+0OQ3+AooI3NTnrjR70vybcJgj0OindOkmscRI/bmQS0496mRKf6P2y8zmW6XE
 WgUkM8l8xV2KPIWW2VijEoG78Or9Bt8HvHC/QQAcmETyuHDMDKl/X1mehGGSBKjZ612gMD
 whj0L6ORT2UffrDhA8zS4RLmLhUv3wg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-nOP9W5HJOR6id9sTv0ItYQ-1; Wed, 27 Jul 2022 02:56:35 -0400
X-MC-Unique: nOP9W5HJOR6id9sTv0ItYQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 q16-20020a056402519000b0043bd73ad1baso7538657edd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 23:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=APkoBX4cQj/9DCAu9+1UJTMMx3KoQtqmKQn9C5jb7ac=;
 b=rEbnqWbBoEjye1vJ96pZPcYrn/t072MYYshZLI30I/wmlcvMOz+TnsVd59l0UORdcA
 ggaj3DxdvQ3mMYwEefgQo02uGjmQW8/5HbfRRyrMSabme1CqnZWaa9Qis1SAk+1NdhaO
 DO107SUj/9LDHRqrQ1pXMjJ8DhhMtGtvdnWBmcZjGMa7dmNGTIs0P/tbW2F0SmdWYiz9
 K7M8llWuqKLKSEvahph2F700La32MJniIQGHk/Mx8D0P8OViv/4GF0BAWsNmaRUzPAOU
 UXUJ0XV6f3sxU9XDX7aNWd+AxvfFR3PzYljf14prb6wE9epZQlh2Pb+wTPzJd+S8TnWg
 n6YA==
X-Gm-Message-State: AJIora/zl9UrcJKXLVVUMbR8G+bMapomgFfndNHOeUZcqKa7nruXYWc5
 2d4iearu1uJoEkSOPhvwWvprUQHeqkUnRdSMmgrmdJdw1ERpzxwIUSI0JqxkKi4OEGutdo4De/c
 CsCvWyNr8ABDxehotOGZkjWHyVqi6b/ZAuWe3MQ+3Qg1xiuUfqKxjQMfHpQ==
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr16931233ejc.740.1658904993344; 
 Tue, 26 Jul 2022 23:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1scCDeYSSG44gop/1/rwLxefBodsTh0sh15M1i+xTC+eNc9SkxzgG/fuzFlLCjkb+b91KSsVBYkPZFhgRi2GH0=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr16931172ejc.740.1658904992006; Tue, 26
 Jul 2022 23:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
 <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <4925d1db-51d1-148a-72e0-2347b20e82f4@intel.com>
In-Reply-To: <4925d1db-51d1-148a-72e0-2347b20e82f4@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Jul 2022 14:56:20 +0800
Message-ID: <CACGkMEsXLhhLhyfPwc=Sif=iy1wE3zm6sKWQxvO3cyuM547+zw@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMjoyNiBQTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA3LzI3LzIwMjIgMjowMSBQTSwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+ID4gT24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDM6NDc6MzVB
TSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIy
IDEwOjUzIFBNCj4gPj4+Cj4gPj4+IE9uIDcvMjcvMjAyMiAxMDoxNyBBTSwgUGFyYXYgUGFuZGl0
IHdyb3RlOgo+ID4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+Cj4gPj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+ID4+Pj4+
Cj4gPj4+Pj4gT24gNy8yNi8yMDIyIDExOjU2IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPj4+
Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4+Pj4+
Pj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+ID4+Pj4+Pj4+IFdoZW4g
dGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52b2tlcyBuZXRsaW5rIGNvbW1hbmRzLCBkZXRlY3RzIHRo
YXQKPiA+Pj4+PiBfTVEKPiA+Pj4+Pj4+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2Vz
IG1heF9xdWV1ZV9wYWlyID0gMSBieSBpdHNlbGYuCj4gPj4+Pj4+PiBJIHRoaW5rIHRoZSBrZXJu
ZWwgbW9kdWxlIGhhdmUgYWxsIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMKPiA+Pj4+
Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZp
Y2UsIHNvIGl0Cj4gPj4+Pj4+PiBzaG91bGQgYW5zd2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUg
dXNlciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+ID4+Pj4+Pj4gbW9kdWxlIHNob3VsZCBiZSBy
ZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50LCBsZWF2ZSB0aGUgcXVlc3Rpb24gdG8KPiA+Pj4+Pj4+
IHRoZSB1c2VyIHNwYWNlCj4gPj4+Pj4gdG9vbC4KPiA+Pj4+Pj4gS2VybmVsIGlzIHJlbGlhYmxl
LiBJdCBkb2VzbuKAmXQgZXhwb3NlIGEgY29uZmlnIHNwYWNlIGZpZWxkIGlmIHRoZQo+ID4+Pj4+
PiBmaWVsZCBkb2VzbuKAmXQKPiA+Pj4+PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3Vs
ZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVmYXVsdC4KPiA+Pj4+PiBzbyB3aGVuIHlvdSBrbm93IGl0
IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ugc2hvdWxkIGFuc3dlciBvbmUsIG5vdCB0cnkKPiA+Pj4+
PiB0byBndWVzcy4KPiA+Pj4+Pj4gVXNlciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4g
VXNlciBzcGFjZSBnZXRzIHRvIHNlZSBpZiBfTVEKPiA+Pj4+PiBwcmVzZW50L25vdCBwcmVzZW50
LiBJZiBfTVEgcHJlc2VudCB0aGFuIGdldCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+ID4+
Pj4+PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEg
cGFpci4KPiA+Pj4+PiBpdCBpcyBzdGlsbCBhIGd1ZXNzLCByaWdodD8gQW5kIGFsbCB1c2VyIHNw
YWNlIHRvb2xzIGltcGxlbWVudGVkIHRoaXMKPiA+Pj4+PiBmZWF0dXJlIG5lZWQgdG8gZ3Vlc3MK
PiA+Pj4+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPiA+Pj4+IEl0IGlzIGV4cGxpY2l0bHkgY2hl
Y2tpbmcgdGhlIF9NUSBmZWF0dXJlIGFuZCBkZXJpdmluZyB0aGUgdmFsdWUuCj4gPj4+PiBUaGUg
Y29kZSB5b3UgcHJvcG9zZWQgd2lsbCBiZSBwcmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+ID4+
Pj4gSXQgd2lsbCBiZSB1bmlmb3JtIGZvciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQg
YXJlIHByZXNlbnQgbm93IGFuZAo+ID4+PiBpbiB0aGUgZnV0dXJlLgo+ID4+PiBNUSBhbmQgb3Ro
ZXIgZmVhdHVyZXMgbGlrZSBSU1MgYXJlIGRpZmZlcmVudC4gSWYgdGhlcmUgaXMgbm8gX1JTU19Y
WCwgdGhlcmUKPiA+Pj4gYXJlIG5vIGF0dHJpYnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBh
bmQgdGhlcmUgaXMgbm90IGEgZGVmYXVsdCB2YWx1ZS4KPiA+Pj4gQnV0IGZvciBNUSwgd2Uga25v
dyBpdCBoYXMgdG8gYmUgMSB3aWh0b3V0IF9NUS4KPiA+PiAid2UiID0gdXNlciBzcGFjZS4KPiA+
PiBUbyBrZWVwIHRoZSBjb25zaXN0ZW5jeSBhbW9uZyBhbGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVs
ZHMuCj4gPiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFuZCBJJ20g
cHV6emxlZDoKPiBJIGNhbiBzdWJtaXQgYSBmaXggaW4gbXkgbmV4dCB2ZXJzaW9uIHBhdGNoIGZv
ciB0aGVzZSBpc3N1ZS4KPiA+Cj4gPgo+ID4gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY29uZmln
IGNvbmZpZyA9IHt9Owo+ID4gICAgICAgdTY0IGZlYXR1cmVzOwo+ID4gICAgICAgdTE2IHZhbF91
MTY7Cj4gPgo+ID4gICAgICAgdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25m
aWcsIHNpemVvZihjb25maWcpKTsKPiA+Cj4gPiAgICAgICBpZiAobmxhX3B1dChtc2csIFZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NQUNBRERSLCBzaXplb2YoY29uZmlnLm1hYyksCj4gPiAgICAgICAg
ICAgICAgICAgICBjb25maWcubWFjKSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0la
RTsKPiA+Cj4gPgo+ID4gTWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTUFD
Cj4gaWYgbm8gVklSVElPX05FVF9GX01BQywgd2Ugc2hvdWxkIG5vdCBubGFfcHV0Cj4gVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BQ19BRERSLCB0aGUgc3BlYyBzYXlzIHRoZSBkcml2ZXIgc2hvdWxk
IGdlbmVyYXRlCj4gYSByYW5kb20gbWFjLgoKSXQncyBwcm9iYWJseSB0b28gbGF0ZSB0byBkbyB0
aGlzLiBNb3N0IG9mIHRoZSBwYXJlbnRzIGhhdmUgdGhpcwpmZWF0dXJlIHN1cHBvcnQsIHNvIHBy
b2JhYmx5IG5vdCBhIHJlYWwgaXNzdWUuCgo+ID4KPiA+Cj4gPiAgICAgICB2YWxfdTE2ID0gbGUx
Nl90b19jcHUoY29uZmlnLnN0YXR1cyk7Cj4gPiAgICAgICBpZiAobmxhX3B1dF91MTYobXNnLCBW
RFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+ID4gICAgICAgICAgICAgICByZXR1
cm4gLUVNU0dTSVpFOwo+ID4KPiA+Cj4gPiBzdGF0dXMgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJ
UlRJT19ORVRfRl9TVEFUVVMKPiBpZiBubyBWSVJUSU9fTkVUX0ZfU1RBVFVTLCB3ZSBzaG91bGQg
bm90IG5sYV9wdXQKPiBWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHRoZSBzcGVjIHNheXMgdGhl
IGRyaXZlciBzaG91bGQgYXNzdW1lIHRoZQo+IGxpbmsgaXMgYWN0aXZlLgoKU29tZWhvdyBzaW1p
bGFyIHRvIEZfTUFDLiBCdXQgd2UgY2FuIHJlcG9ydCBpZiBGX01BQyBpcyBub3QgbmVnb3RpYXRl
ZC4KCgo+ID4KPiA+ICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25maWcubXR1KTsKPiA+
ICAgICAgIGlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZh
bF91MTYpKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVNU0dTSVpFOwo+ID4KPiA+Cj4gPiBN
VFUgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NVFUKPiBzYW1lIGFzIGFib3Zl
LCB0aGUgc3BlYyBzYXlzIGNvbmZpZy5tdHUgZGVwZW5kcyBvbiBWSVJUSU9fTkVUX0ZfTVRVLCBz
bwo+IHdpdGhvdXQgdGhpcyBmZWF0dXJlIGJpdCwgd2Ugc2hvdWxkIG5vdCByZXR1cm4gTVRVIHRv
IHRoZSB1c2Vyc3BhY2UuCgpOb3QgYSBiaWcgaXNzdWUsIHdlIGp1c3QgbmVlZCB0byBtYWtlIHN1
cmUgdGhlIHBhcmVudCBjYW4gcmVwb3J0IGEKY29ycmVjdCBNVFUgaGVyZS4KClRoYW5rcwoKPgo+
IERvZXMgdGhlc2UgZml4IGxvb2sgZ29vZCB0byB5b3U/Cj4KPiBBbmQgSSB0aGluayB3ZSBtYXkg
bmVlZCB5b3VyIGFkanVkaWNhdGlvbiBmb3IgdGhlIHR3byBpc3N1ZXM6Cj4gKDEpIFNoYWxsIHdl
IGFuc3dlciBtYXhfdnFfcGFyaXMgPSAxIHdoZW4gX01RIG5vdCBleGlzdCwgSSBrbm93IHlvdSBo
YXZlCj4gYWdyZWVkIG9uIHRoaXMgaW4gYSBwcmV2aW91cyB0aHJlYWQsIGl0cyBuaWNlIHRvIGNs
YXJpZnkKPiAoMikgSSB0aGluayB3ZSBzaG91bGQgbm90IHJlLXVzZSB0aGUgbmV0bGluayBhdHRy
IHRvIHJlcG9ydCBmZWF0dXJlIGJpdHMKPiBvZiBib3RoIHRoZSBtYW5hZ2VtZW50IGRldmljZSBh
bmQgdGhlIHZEUEEgZGV2aWNlLAo+IHRoaXMgY2FuIGxlYWQgdG8gYSBuZXcgcmFjZSBjb25kaXRp
b24sIHRoZXJlIGFyZSBubyBsb2Nrcyhlc3BlY2lhbGx5Cj4gZGlzdHJpYnV0ZWQgbG9ja3MgZm9y
IGtlcm5lbF9zcGFjZSBhbmQgdXNlcl9zcGFjZSkgaW4gdGhlIG5sYV9wdXQKPiBmdW5jdGlvbnMu
IFJlLXVzaW5nIHRoZSBhdHRyIGlzIHNvbWUga2luZCBvZiBicmVha2luZyB0aGUgbmV0bGluawo+
IGxvY2tsZXNzIGRlc2lnbi4KPgo+IFRoYW5rcywKPiBaaHUgTGluZ3NoYW4KPiA+Cj4gPgo+ID4g
V2hhdCdzIGdvaW5nIG9uIGhlcmU/Cj4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
