Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D768C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 15:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08F9D415B6;
	Wed, 27 Jul 2022 15:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08F9D415B6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TA2/9pdG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUzwRzYsPhkC; Wed, 27 Jul 2022 15:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E38BA4156D;
	Wed, 27 Jul 2022 15:45:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E38BA4156D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0CBDC0035;
	Wed, 27 Jul 2022 15:45:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9E43C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 773C760E1B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 773C760E1B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TA2/9pdG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gayvf1m_Hy_O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:45:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F0BA606BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F0BA606BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658936750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5Z5mK4bBTNHE1Hrnus23LuaetCSMzbXo8U4tgW3Uug=;
 b=TA2/9pdGJJX0pcsVWYvRsepW2DvnE3HMOUepvJFf0/ItQQWmjbD5qwxzOQPExoZM14rLEN
 3lH1+YcgF3hPS0F1181Ir7uQLFyL/H5+zWDTHDxFzEZKa9o+pW0JxxiKcXIKxUcsSrWWjx
 zJWJ7ye7ouaOqEp+qLTui/YFVZFd+h8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-vVZGsJ52NQO1WXjJEaaqdA-1; Wed, 27 Jul 2022 11:45:49 -0400
X-MC-Unique: vVZGsJ52NQO1WXjJEaaqdA-1
Received: by mail-wr1-f70.google.com with SMTP id
 c11-20020adfa30b000000b0021e4e471279so3130551wrb.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=o5Z5mK4bBTNHE1Hrnus23LuaetCSMzbXo8U4tgW3Uug=;
 b=MeYpsZV49BQZtRWFX29kfqQQImgsGejUm3aZNPhyiZMCZ8FAuRQEFxPvKjLlYgv+Yu
 6tophTjqeQGsB0HFxoOVKDsGlBzFgK2TwU/fdj2raRgC3yqJr3pGFVnp5NaplI6/8Znt
 Ycc+4LMF/HffF4W2xYrqvBSxfAqzslmKbvTXbB94dCky+iazTqeCDHDdANOl89cMJd8H
 lZybD0cMhdsM95ZgENFuyHyREmJCFMp3NKpDC0fXnA/GGlRnf3YP+v//wZ/TiLhTs8ok
 faPQ9Bqra/qiP0gRLhYL6JGbIW71fUkwb0UkXXXj/LiqlfLVP9xejM57XoLTXf8Qp1Fo
 hq4w==
X-Gm-Message-State: AJIora/0mQtRT4bXpzQLrZrefFvuAFPBLahLPpGRGfrgMipbwgGgsMIb
 XpPgdkcUxH69W01dkQdwz/XF5JNHZh8zdYcGCShtaNkYwQ+4kvtFu3uOoQIXQD6nVYYccFal6BS
 r68hkcqax+N53JzC6zVeSY8Xu5vbkfkNCZAr1a71CTA==
X-Received: by 2002:adf:fd42:0:b0:21e:4357:3f38 with SMTP id
 h2-20020adffd42000000b0021e43573f38mr14305534wrs.620.1658936747690; 
 Wed, 27 Jul 2022 08:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sn2LcWK0FEjuooFusX6mom51Dfi0VsB51W4X3fJT9i5PzY53tHwJhmFAZ9La2UW1Hd6GOjJw==
X-Received: by 2002:adf:fd42:0:b0:21e:4357:3f38 with SMTP id
 h2-20020adffd42000000b0021e43573f38mr14305507wrs.620.1658936747379; 
 Wed, 27 Jul 2022 08:45:47 -0700 (PDT)
Received: from redhat.com ([2.52.132.243]) by smtp.gmail.com with ESMTPSA id
 f11-20020adfe90b000000b0021e43650e6asm17825915wrm.86.2022.07.27.08.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 08:45:46 -0700 (PDT)
Date: Wed, 27 Jul 2022 11:45:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220727114419-mutt-send-email-mst@kernel.org>
References: <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
 <20220727050222-mutt-send-email-mst@kernel.org>
 <CACGkMEtDFUGX17giwYdF58QJ1ccZJDJg1nFVDkSeB27sfZz28g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtDFUGX17giwYdF58QJ1ccZJDJg1nFVDkSeB27sfZz28g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDU6NTA6NTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCA1OjAzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAy
OjU0OjEzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFdlZCwgSnVsIDI3LCAy
MDIyIGF0IDI6MDEgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAw
LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiBGcm9tOiBaaHUsIExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4gPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDI2LCAyMDIyIDEwOjUzIFBNCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIDcvMjcv
MjAyMiAxMDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+ID4gPiA+PiBGcm9tOiBa
aHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4gPiA+PiBTZW50
OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjE1IFBNCj4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4g
PiA+ID4+IE9uIDcvMjYvMjAyMiAxMTo1NiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+
ID4gPiA+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4g
PiA+ID4gPiA+ID4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+ID4g
PiA+ID4gPiA+Pj4+PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMgbmV0bGluayBj
b21tYW5kcywgZGV0ZWN0cyB0aGF0Cj4gPiA+ID4gPiA+ID4+IF9NUQo+ID4gPiA+ID4gPiA+Pj4+
IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1ZV9wYWlyID0gMSBieSBp
dHNlbGYuCj4gPiA+ID4gPiA+ID4+Pj4gSSB0aGluayB0aGUga2VybmVsIG1vZHVsZSBoYXZlIGFs
bCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIGl0IGlzCj4gPiA+ID4gPiA+ID4+Pj4gdGhlIG9u
bHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlvbiBvZiBhIGRldmljZSwgc28gaXQK
PiA+ID4gPiA+ID4gPj4+PiBzaG91bGQgYW5zd2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUgdXNl
ciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+ID4gPiA+ID4gPiA+Pj4+IG1vZHVsZSBzaG91bGQg
YmUgcmVsaWFibGUgdGhhbiBzdGF5IHNpbGVudCwgbGVhdmUgdGhlIHF1ZXN0aW9uIHRvCj4gPiA+
ID4gPiA+ID4+Pj4gdGhlIHVzZXIgc3BhY2UKPiA+ID4gPiA+ID4gPj4gdG9vbC4KPiA+ID4gPiA+
ID4gPj4+IEtlcm5lbCBpcyByZWxpYWJsZS4gSXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBz
cGFjZSBmaWVsZCBpZiB0aGUKPiA+ID4gPiA+ID4gPj4+IGZpZWxkIGRvZXNu4oCZdAo+ID4gPiA+
ID4gPiA+PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQgb3Ig
bm8gZGVmYXVsdC4KPiA+ID4gPiA+ID4gPj4gc28gd2hlbiB5b3Uga25vdyBpdCBpcyBvbmUgcXVl
dWUgcGFpciwgeW91IHNob3VsZCBhbnN3ZXIgb25lLCBub3QgdHJ5Cj4gPiA+ID4gPiA+ID4+IHRv
IGd1ZXNzLgo+ID4gPiA+ID4gPiA+Pj4gVXNlciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhl
ci4gVXNlciBzcGFjZSBnZXRzIHRvIHNlZSBpZiBfTVEKPiA+ID4gPiA+ID4gPj4gcHJlc2VudC9u
b3QgcHJlc2VudC4gSWYgX01RIHByZXNlbnQgdGhhbiBnZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtl
cm5lbC4KPiA+ID4gPiA+ID4gPj4+IElmIF9NUSBub3QgcHJlc2VudCwgaXQgbWVhbnMgdGhpcyBk
ZXZpY2UgaGFzIG9uZSBWUSBwYWlyLgo+ID4gPiA+ID4gPiA+PiBpdCBpcyBzdGlsbCBhIGd1ZXNz
LCByaWdodD8gQW5kIGFsbCB1c2VyIHNwYWNlIHRvb2xzIGltcGxlbWVudGVkIHRoaXMKPiA+ID4g
PiA+ID4gPj4gZmVhdHVyZSBuZWVkIHRvIGd1ZXNzCj4gPiA+ID4gPiA+ID4gTm8uIGl0IGlzIG5v
dCBhIGd1ZXNzLgo+ID4gPiA+ID4gPiA+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9N
USBmZWF0dXJlIGFuZCBkZXJpdmluZyB0aGUgdmFsdWUuCj4gPiA+ID4gPiA+ID4gVGhlIGNvZGUg
eW91IHByb3Bvc2VkIHdpbGwgYmUgcHJlc2VudCBpbiB0aGUgdXNlciBzcGFjZS4KPiA+ID4gPiA+
ID4gPiBJdCB3aWxsIGJlIHVuaWZvcm0gZm9yIF9NUSBhbmQgMTAgb3RoZXIgZmVhdHVyZXMgdGhh
dCBhcmUgcHJlc2VudCBub3cgYW5kCj4gPiA+ID4gPiA+IGluIHRoZSBmdXR1cmUuCj4gPiA+ID4g
PiA+IE1RIGFuZCBvdGhlciBmZWF0dXJlcyBsaWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0aGVy
ZSBpcyBubyBfUlNTX1hYLCB0aGVyZQo+ID4gPiA+ID4gPiBhcmUgbm8gYXR0cmlidXRlcyBsaWtl
IG1heF9yc3Nfa2V5X3NpemUsIGFuZCB0aGVyZSBpcyBub3QgYSBkZWZhdWx0IHZhbHVlLgo+ID4g
PiA+ID4gPiBCdXQgZm9yIE1RLCB3ZSBrbm93IGl0IGhhcyB0byBiZSAxIHdpaHRvdXQgX01RLgo+
ID4gPiA+ID4gIndlIiA9IHVzZXIgc3BhY2UuCj4gPiA+ID4gPiBUbyBrZWVwIHRoZSBjb25zaXN0
ZW5jeSBhbW9uZyBhbGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4gPiA+ID4KPiA+ID4gPiBB
Y3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFuZCBJJ20gcHV6emxlZDoK
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcg
Y29uZmlnID0ge307Cj4gPiA+ID4gICAgICAgICB1NjQgZmVhdHVyZXM7Cj4gPiA+ID4gICAgICAg
ICB1MTYgdmFsX3UxNjsKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgdmRwYV9nZXRfY29uZmlnX3Vu
bG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPiA+ID4gPgo+ID4gPiA+
ICAgICAgICAgaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwg
c2l6ZW9mKGNvbmZpZy5tYWMpLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgY29uZmlnLm1h
YykpCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU1TR1NJWkU7Cj4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IE1hYyByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01BQwo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgIHZhbF91MTYgPSBsZTE2X3RvX2NwdShjb25m
aWcuc3RhdHVzKTsKPiA+ID4gPiAgICAgICAgIGlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRU
Ul9ERVZfTkVUX1NUQVRVUywgdmFsX3UxNikpCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVy
biAtRU1TR1NJWkU7Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IHN0YXR1cyByZXR1cm5lZCBldmVu
IHdpdGhvdXQgVklSVElPX05FVF9GX1NUQVRVUwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICB2YWxf
dTE2ID0gbGUxNl90b19jcHUoY29uZmlnLm10dSk7Cj4gPiA+ID4gICAgICAgICBpZiAobmxhX3B1
dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KSkKPiA+ID4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
TVRVIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IFdoYXQncyBnb2luZyBvbiBoZXJlPwo+ID4gPgo+ID4gPiBQcm9iYWJseSB0b28g
bGF0ZSB0byBmaXgsIGJ1dCB0aGlzIHNob3VsZCBiZSBmaW5lIGFzIGxvbmcgYXMgYWxsCj4gPiA+
IHBhcmVudHMgc3VwcG9ydCBTVEFUVVMvTVRVL01BQy4KPiA+Cj4gPiBXaHkgaXMgdGhpcyB0b28g
bGF0ZSB0byBmaXguCj4gCj4gSWYgd2UgbWFrZSB0aGlzIGNvbmRpdGlvbmFsIG9uIHRoZSBmZWF0
dXJlcy4gVGhpcyBtYXkgYnJlYWsgdGhlCj4gdXNlcnNwYWNlIHRoYXQgYWx3YXlzIGV4cGVjdHMg
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVT8KPiAKPiBUaGFua3MKCldlbGwgb25seSBvbiBkZXZp
Y2VzIHdpdGhvdXQgTVRVLiBJJ20gc2F5aW5nIHNhaWQgdXNlcnNwYWNlCndhcyByZWFkaW5nIHRy
YXNoIG9uIHN1Y2ggZGV2aWNlcyBhbnl3YXkuCldlIGRvbid0IGdlbmVyYWxseSBtYWludGFpbiBi
dWcgZm9yIGJ1ZyBjb21wYXRpYmxpdHkgb24gYSB3aGltLApvbmx5IGlmIHVzZXJzcGFjZSBpcyBh
Y3R1YWxseSBrbm93biB0byBicmVhayBpZiB3ZSBmaXggYSBidWcuCgoKPiA+Cj4gPiA+IEkgd29u
ZGVyIGlmIHdlIGNhbiBhZGQgYSBjaGVjayBpbiB0aGUgY29yZSBhbmQgZmFpbCB0aGUgZGV2aWNl
Cj4gPiA+IHJlZ2lzdHJhdGlvbiBpbiB0aGlzIGNhc2UuCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IE1TVAo+ID4gPiA+Cj4gPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
