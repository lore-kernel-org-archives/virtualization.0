Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30B2C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 07:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28A9C41855;
	Tue, 21 Mar 2023 07:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28A9C41855
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZ6B2ADL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmcEfoqVInlK; Tue, 21 Mar 2023 07:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C43741847;
	Tue, 21 Mar 2023 07:13:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C43741847
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BC9C0071;
	Tue, 21 Mar 2023 07:13:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87052C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54D5540B5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:13:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54D5540B5C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZ6B2ADL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fQb5KHh0dpbD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 942BD40B60
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 942BD40B60
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679382835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuTFG9ab3u7R1jpb31bRtm51snrAor/YhsIuMOJ3A2I=;
 b=LZ6B2ADLK8ZTGLVnohGRp8i2/LgVlupCvL7tmJ4j5dYYB9C8kj44cfLqrzu88LYwwABZ32
 +m4YYlan27J63LryuQn5KgW6wMXZBJxvrRvcZBPlfSH5ABq/AHqJY53x0pakBuOroe4h9P
 7qTuVD8RiYTKBwycqQopzSQumT4dDS8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ZmIAklKVNzuuMqX2rKo2fw-1; Tue, 21 Mar 2023 03:13:54 -0400
X-MC-Unique: ZmIAklKVNzuuMqX2rKo2fw-1
Received: by mail-wm1-f72.google.com with SMTP id
 fl22-20020a05600c0b9600b003ed26ca6206so9574471wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 00:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679382833;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nuTFG9ab3u7R1jpb31bRtm51snrAor/YhsIuMOJ3A2I=;
 b=efjAgDW9EmUYnD0ANdJrnUnXb1einX4Ra8HZDhOD/bPDOqeg7C5QaEYcvJgu/PLB8g
 4Kx5m8TWtC0nYgtxOMlan102qpPT3sDY85hGX9UhVw03UghxrgYz8du9KoNrTmMHHEf5
 4cL31saxm4wyQ9Kvm4C41OtExwIks52LqnFjskJvmy5ESyWIo5ItrWTF0Hw/AE1YF73k
 yUXjAYW1S+tUgImO8xOsBGvaHjhOqNnyXXuprOQru6cLwajUuzHSepce//M2LKWua4wA
 LuAhePvAJPzY/NeUuv4Em047AcU5bMqMmEkagO14nsjWR80oQbYrvr6899JwAqfPXh+I
 KP7Q==
X-Gm-Message-State: AO0yUKW7UqQ0nS+mvluyHt5WYJBozyh/KFORB1vZGz6vgjwtS0Owu7rb
 T+Qm+CaAEG+yyq3YXlIcfNdJiMmfSqK4CL+Vd1LyEpGJmKSdl06wdWv2ayk1kaai+Hw/aIn1eFO
 oAAp2pyhazbuTFS8ET/wSZvjbcL925kn4HI8Onv7wjQ==
X-Received: by 2002:a5d:65c4:0:b0:2ce:a899:2293 with SMTP id
 e4-20020a5d65c4000000b002cea8992293mr1412886wrw.5.1679382833022; 
 Tue, 21 Mar 2023 00:13:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set8KbQmL98dbtoe1oAsaweQtFdB3Ts7JtWE2aDdoQilOLg6IOnVYsFOh/EJ1qessZOqW8oHHZA==
X-Received: by 2002:a5d:65c4:0:b0:2ce:a899:2293 with SMTP id
 e4-20020a5d65c4000000b002cea8992293mr1412874wrw.5.1679382832726; 
 Tue, 21 Mar 2023 00:13:52 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 a10-20020a056000050a00b002d78a96cf5fsm3384706wrf.70.2023.03.21.00.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 00:13:52 -0700 (PDT)
Date: Tue, 21 Mar 2023 03:13:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321031310-mutt-send-email-mst@kernel.org>
References: <20230320232115.1940587-1-viktor@daynix.com>
 <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 cohuck@redhat.com, Viktor Prutyanov <viktor@daynix.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTA6Mjk6MTFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCA3OjIx4oCvQU0gVmlrdG9yIFBydXR5YW5vdiA8
dmlrdG9yQGRheW5peC5jb20+IHdyb3RlOgo+ID4KPiA+IEFjY29yZGluZyB0byBWaXJ0SU8gc3Bl
YyB2MS4yLCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlCj4gPiBpbmRpY2F0ZXMg
dGhhdCB0aGUgZHJpdmVyIHBhc3NlcyBleHRyYSBkYXRhIGFsb25nIHdpdGggdGhlIHF1ZXVlCj4g
PiBub3RpZmljYXRpb25zLgo+ID4KPiA+IEluIGEgc3BsaXQgcXVldWUgY2FzZSwgdGhlIGV4dHJh
IGRhdGEgaXMgMTYtYml0IGF2YWlsYWJsZSBpbmRleC4gSW4gYQo+ID4gcGFja2VkIHF1ZXVlIGNh
c2UsIHRoZSBleHRyYSBkYXRhIGlzIDEtYml0IHdyYXAgY291bnRlciBhbmQgMTUtYml0Cj4gPiBh
dmFpbGFibGUgaW5kZXguCj4gPgo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoaXMgZmVhdHVyZSBmb3Ig
TU1JTyBhbmQgUENJIHRyYW5zcG9ydHMuIENoYW5uZWwgSS9PCj4gPiB0cmFuc3BvcnQgd2lsbCBu
b3QgYWNjZXB0IHRoaXMgZmVhdHVyZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWt0b3IgUHJ1
dHlhbm92IDx2aWt0b3JAZGF5bml4LmNvbT4KPiA+IC0tLQo+ID4KPiA+ICB2MjogcmVqZWN0IHRo
ZSBmZWF0dXJlIGluIHZpcnRpb19jY3csIHJlcGxhY2UgX19sZTMyIHdpdGggdTMyCj4gPgo+ID4g
IGRyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jICAgfCAgNCArLS0tCj4gPiAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX21taW8uYyAgICAgICB8IDE1ICsrKysrKysrKysrKysrLQo+ID4gIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAxMCArKysrKysrKysrCj4gPiAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCB8ICA0ICsrKysKPiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDIgKy0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jIHwgIDIgKy0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
ICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysKPiA+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19y
aW5nLmggICAgICAgIHwgIDIgKysKPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZp
Zy5oIHwgIDYgKysrKysrCj4gPiAgOSBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3MzOTAvdmlydGlvL3Zp
cnRpb19jY3cuYyBiL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4gPiBpbmRleCBh
MTBkYmU2MzJlZjkuLmQ3MmE1OTQxNTUyNyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvczM5MC92
aXJ0aW8vdmlydGlvX2Njdy5jCj4gPiArKysgYi9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19j
Y3cuYwo+ID4gQEAgLTc4OSw5ICs3ODksNyBAQCBzdGF0aWMgdTY0IHZpcnRpb19jY3dfZ2V0X2Zl
YXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4KPiA+ICBzdGF0aWMgdm9pZCBj
Y3dfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gIHsK
PiA+IC0gICAgICAgLyoKPiA+IC0gICAgICAgICogQ3VycmVudGx5IG5vdGhpbmcgdG8gZG8gaGVy
ZS4KPiA+IC0gICAgICAgICovCj4gPiArICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBW
SVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSk7Cj4gCj4gSXMgdGhlcmUgYW55IHJlc3RyaWN0aW9u
IHRoYXQgcHJldmVudHMgdXMgZnJvbSBpbXBsZW1lbnRpbmcKPiBWSVJUSU9fRl9OT1RJRklDQVRJ
T05fREFUQT8gKFNwZWMgc2VlbXMgZG9lc24ndCBsaW1pdCB1cyBmcm9tIHRoaXMpCgpSaWdodCwg
c3BlYyBhY3R1YWxseSB0ZWxscyB5b3Ugd2hhdCB0byBkby4KCj4gPiAgfQo+ID4KPiA+ICBzdGF0
aWMgaW50IHZpcnRpb19jY3dfZmluYWxpemVfZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYpCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiA+IGluZGV4IDNmZjc0NmUzZjI0YS4uMGUxM2Rh
MTdmZTBhIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+ID4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+ID4gQEAgLTI4NSw2ICsyODUsMTkg
QEAgc3RhdGljIGJvb2wgdm1fbm90aWZ5KHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4gICAgICAg
ICByZXR1cm4gdHJ1ZTsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRpYyBib29sIHZtX25vdGlmeV93aXRo
X2RhdGEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3Qgdmly
dGlvX21taW9fZGV2aWNlICp2bV9kZXYgPSB0b192aXJ0aW9fbW1pb19kZXZpY2UodnEtPnZkZXYp
Owo+ID4gKyAgICAgICB1MzIgZGF0YSA9IHZyaW5nX2ZpbGxfbm90aWZpY2F0aW9uX2RhdGEodnEp
Owo+IAo+IENhbiB3ZSBtb3ZlIHRoaXMgdG8gdGhlIGluaXRpYWxpemF0aW9uPwo+IAo+IFRoYW5r
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
