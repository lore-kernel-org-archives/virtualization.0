Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC140C00140
	for <virtualization@archiver.kernel.org>; Tue,  2 Aug 2022 07:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 451E460AE4;
	Tue,  2 Aug 2022 07:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 451E460AE4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CX74webg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWM-Cfwmei2A; Tue,  2 Aug 2022 07:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C265C6059D;
	Tue,  2 Aug 2022 07:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C265C6059D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8959BC0032;
	Tue,  2 Aug 2022 07:45:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80059C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58DC44017F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58DC44017F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CX74webg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3fZeJfc71XC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21D224017A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21D224017A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659426314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2QKGORUPt90s3M7laRV8rZjur0eTOpV52LUAMCgLrw=;
 b=CX74webgjXgVoV+FwU+TCd/LWA3TvT/jTStfpvx04M0SL+hNz6hOXTEWCitJ33ZgsD3PHV
 oNUMWUFmRWGK3IjwlGionWyaxu6fjsngh0I4otZAHaBWMRCHTfS4gr68l8+UKfoZUVJsI+
 XGLnGlCjBVp+1j/cpia1W0pdbRTGYm4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-65DXzh5-Ne6FcAC3lLo5qg-1; Tue, 02 Aug 2022 03:45:13 -0400
X-MC-Unique: 65DXzh5-Ne6FcAC3lLo5qg-1
Received: by mail-lj1-f200.google.com with SMTP id
 y11-20020a05651c220b00b0025e4bd7731fso1168974ljq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Aug 2022 00:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=n2QKGORUPt90s3M7laRV8rZjur0eTOpV52LUAMCgLrw=;
 b=2KDwkoiLcSqVY8dMyfizi4XWs7Y4q5uJvvHZ9CYuTtkh8pyBujwzrKFGy5b4xFkmF8
 gwAY3MJRGX5JJkfj34ZRT5YBYBFrjVA/CP6bQNf4cvBIfeKyAhcqeHAvm6d1gRpKw/q2
 qIgBtajcKY/zcdGFoT9pL8Ei9zB3a9fV3x3zhQjRFFuN+bSEsgYBlSwSYG6H0SuCl7GD
 w+mivpAzgtunUhD7BnWTYPN052xI7lZwRq0+ZSn9EWcrBhwF1INQaDpkCZT0emhLKJar
 B7i7LvVQzDmksnbelFPrdlMH3lG1yuXX3rbv6R8T7rAgtt3Ke0/3uLy9cevjzvc//vt/
 yYdA==
X-Gm-Message-State: AJIora+U++OhZM13KDbJkbM+peqBI3/nlTFaX/ufZSZ0hK/DHc7Wm0Wd
 EusTV0jzH1k4H05f9Qd7S/SHJpMSqTGnD532KObv0ZVTykuakp2a8fjA81iZddJtrBDcJ3u8M3k
 4p79/sRRgyX5VM5KEXsySyTWEkw5wtDRDVSAPfWWtwBqbeJXpqSDcOJWqQQ==
X-Received: by 2002:a2e:82c6:0:b0:25d:eef5:8096 with SMTP id
 n6-20020a2e82c6000000b0025deef58096mr6288540ljh.201.1659426312321; 
 Tue, 02 Aug 2022 00:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tIVif5PVmN7a8VhTns7vhbkHiwcEFEE4L31UG6gd+2t07IqYSwiB0aIDCfwMP5XF9mr/mf+ZUHXWrTlopG4R8=
X-Received: by 2002:a2e:82c6:0:b0:25d:eef5:8096 with SMTP id
 n6-20020a2e82c6000000b0025deef58096mr6288536ljh.201.1659426312110; Tue, 02
 Aug 2022 00:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
 <20220721084341.24183-4-qtxuning1999@sjtu.edu.cn>
 <CAJaqyWfgUqdP6mkOUdouvQSst=qc7MOTaigC-EiTg9-gojHqzg@mail.gmail.com>
 <1D1ABF88-B503-4BE0-AC83-3326EAA62510@sjtu.edu.cn>
In-Reply-To: <1D1ABF88-B503-4BE0-AC83-3326EAA62510@sjtu.edu.cn>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 2 Aug 2022 09:45:00 +0200
Message-ID: <CAGxU2F4-aBTP=CwzTKutiSqHQL++zfMmK_dCoR+t=BJA9AvhFQ@mail.gmail.com>
Subject: Re: [RFC 3/5] vhost_test: batch used buffer
To: Zhi Guo <qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm list <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gVHVlLCBBdWcgMiwgMjAyMiBhdCA0OjQ1IEFNIFpoaSBHdW8gPHF0eHVuaW5nMTk5OUBzanR1
LmVkdS5jbj4gd3JvdGU6Cj4KPgo+Cj4gMjAyMuW5tDfmnIgyMuaXpSDkuIvljYgzOjEy77yMRXVn
ZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+IOWGmemBk++8mgo+Cj4gT24g
VGh1LCBKdWwgMjEsIDIwMjIgYXQgMTA6NDQgQU0gR3VvIFpoaSA8cXR4dW5pbmcxOTk5QHNqdHUu
ZWR1LmNuPiB3cm90ZToKPgo+Cj4gT25seSBhZGQgdG8gdXNlZCByaW5nIHdoZW4gYSBiYXRjaCBh
IGJ1ZmZlciBoYXZlIGFsbCBiZWVuIHVzZWQuICBBbmQgaWYKPiBpbiBvcmRlciBmZWF0dXJlIG5l
Z290aWF0ZWQsIGFkZCByYW5kb21uZXNzIHRvIHRoZSB1c2VkIGJ1ZmZlcidzIG9yZGVyLAo+IHRl
c3QgdGhlIGFiaWxpdHkgb2Ygdmhvc3QgdG8gcmVvcmRlciBiYXRjaGVkIGJ1ZmZlci4KPgo+IFNp
Z25lZC1vZmYtYnk6IEd1byBaaGkgPHF0eHVuaW5nMTk5OUBzanR1LmVkdS5jbj4KPiAtLS0KPiBk
cml2ZXJzL3Zob3N0L3Rlc3QuYyB8IDE1ICsrKysrKysrKysrKysrLQo+IDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aG9zdC90ZXN0LmMgYi9kcml2ZXJzL3Zob3N0L3Rlc3QuYwo+IGluZGV4IGJjOGU3ZmIxZS4u
MWM5YzQwYzExIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gKysrIGIvZHJp
dmVycy92aG9zdC90ZXN0LmMKPiBAQCAtNDMsNiArNDMsOSBAQCBzdHJ1Y3Qgdmhvc3RfdGVzdCB7
Cj4gc3RhdGljIHZvaWQgaGFuZGxlX3ZxKHN0cnVjdCB2aG9zdF90ZXN0ICpuKQo+IHsKPiAgICAg
ICAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEgPSAmbi0+dnFzW1ZIT1NUX1RFU1RfVlFdOwo+
ICsgICAgICAgc3RydWN0IHZyaW5nX3VzZWRfZWxlbSAqaGVhZHMgPSBrbWFsbG9jKHNpemVvZigq
aGVhZHMpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKiB2cS0+bnVtLCBHRlBfS0VSTkVMKTsK
PiArICAgICAgIGludCBiYXRjaF9pZHggPSAwOwo+ICAgICAgICB1bnNpZ25lZCBvdXQsIGluOwo+
ICAgICAgICBpbnQgaGVhZDsKPiAgICAgICAgc2l6ZV90IGxlbiwgdG90YWxfbGVuID0gMDsKPiBA
QCAtODQsMTEgKzg3LDIxIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV92cShzdHJ1Y3Qgdmhvc3RfdGVz
dCAqbikKPiAgICAgICAgICAgICAgICAgICAgICAgIHZxX2Vycih2cSwgIlVuZXhwZWN0ZWQgMCBs
ZW4gZm9yIFRYXG4iKTsKPiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAg
ICAgICAgIH0KPiAtICAgICAgICAgICAgICAgdmhvc3RfYWRkX3VzZWRfYW5kX3NpZ25hbCgmbi0+
ZGV2LCB2cSwgaGVhZCwgMCk7Cj4gKyAgICAgICAgICAgICAgIGhlYWRzW2JhdGNoX2lkeF0uaWQg
PSBjcHVfdG9fdmhvc3QzMih2cSwgaGVhZCk7Cj4gKyAgICAgICAgICAgICAgIGhlYWRzW2JhdGNo
X2lkeCsrXS5sZW4gPSBjcHVfdG9fdmhvc3QzMih2cSwgbGVuKTsKPiAgICAgICAgICAgICAgICB0
b3RhbF9sZW4gKz0gbGVuOwo+ICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh2aG9zdF9leGNl
ZWRzX3dlaWdodCh2cSwgMCwgdG90YWxfbGVuKSkpCj4gICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKPiAgICAgICAgfQo+ICsgICAgICAgaWYgKGJhdGNoX2lkeCkgewo+ICsgICAgICAgICAg
ICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX0lOX09SREVSKSAmJiBiYXRj
aF9pZHggPj0gMikgewo+Cj4KPiBNYXliZSB0byBhZGQgYSBtb2R1bGUgcGFyYW1ldGVyIHRvIHRl
c3QgdGhpcz8gSW5zdGVhZCBvZiB0cnVzdGluZyBpbgo+IGZlYXR1cmUgbmVnb3RpYXRpb24sICJ1
bm9yZGVyX3VzZWQ9MSIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KPgo+IHZob3N0LmM6dmhvc3Rf
YWRkX3VzZWRfYW5kX3NpZ25hbF9uIHNob3VsZCBzdXBwb3J0IHJlY2VpdmluZyBidWZmZXJzCj4g
aW4gb3JkZXIgb3Igb3V0IG9mIG9yZGVyIHdoZXRoZXIgRl9JTl9PUkRFUiBpcyBuZWdvdGlhdGVk
IG9yIG5vdC4KPgo+IFRoYW5rcyEKPgo+IFRoYXTigJlzIGEgZ29vZCBpZGVhLCBUaGUgcmVvcmRl
ciBmZWF0dXJlIGluIHZob3N0IGlzIGEgIndvcmthcm91bmTigJ0gc29sdXRpb24gZm9yIHRoZSBk
ZXZpY2UgdGhhdCBjYW4ndCBjb25zdW1lIGJ1ZmZlciBpbiBvcmRlciwKPiBJZiB0aGF0IGRldmlj
ZSBzdXBwb3J0IGluIG9yZGVyIGZlYXR1cmUsIFRoZSByZW9yZGVyIGluIHZob3N0IHdpbGwgbm90
IGJlIHVzZWQuCj4gU28gd2UgY2FuIGFkZCBhIHBhcmFtZXRlciBpbiB2aG9zdF90ZXN0IGNhbiBj
b25maWcgaW4gb3JkZXIgb3Igbm90IGluIG9yZGVyIHVzYWdlIGZvciB1c2VkIGRlc2NyaXB0b3Jz
Lgo+IEEgZ2xvYmFsIHBhcmFtZXRlciBpbiB2aG9zdF90ZXN0LmMgaXMgZW5vdWdoPwoKTWF5YmUg
YSBtb2R1bGUgcGFyYW1ldGVyIGlzIGVhc2llciB0byB1c2UgKG9yIGEgc3lzZnMgZmlsZSksIGFu
ZCB0bwp0ZXN0IHdlIGRvbid0IG5lZWQgdG8gcmVjb21waWxlIHRoZSBtb2R1bGUgZXZlcnkgdGlt
ZS4KCkluIHZpZXcgb2YgaGF2aW5nIGEgQ0ksIGl0J3MgZGVmaW5pdGVseSBlYXNpZXIgdG8gc2V0
IHRoZSBtb2R1bGUKcGFyYW1ldGVyIHRoYW4gdG8gcmVjb21waWxlIGl0LgoKVGhhbmtzLApTdGVm
YW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
