Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C334DC6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 16:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A2558190B;
	Tue, 21 Mar 2023 16:04:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A2558190B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzVRwKOt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FY6GZ8jgybaF; Tue, 21 Mar 2023 16:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95694813F9;
	Tue, 21 Mar 2023 16:04:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95694813F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7967EC0071;
	Tue, 21 Mar 2023 16:04:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C235C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2990160E31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:04:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2990160E31
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzVRwKOt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdWaJyywwGtr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE3A260B79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE3A260B79
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679414686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvuo6+gbLS66U9JgpxqS8Rw/48nBbSnJ5zKf6oE7jWc=;
 b=PzVRwKOt8msBlVhJZdjZODQw/OokHVqNd0jmd2eLpvS57vxNq4WqNqyYSZdspwR50T00Zb
 KwalmZQqDMyUpbg9/pp0a0cATA5ftDA9XuZe5X/2NuSGcaObDby0i7gLAB1fI/YrBTNOGL
 0XzU0mlLBXBcQdU4Vw0RF1TVtZnT+xA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-omV_OSFsNK2361m_DDQwfA-1; Tue, 21 Mar 2023 12:04:45 -0400
X-MC-Unique: omV_OSFsNK2361m_DDQwfA-1
Received: by mail-wm1-f72.google.com with SMTP id
 k29-20020a05600c1c9d00b003ee3a8d547eso988881wms.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679414684;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lvuo6+gbLS66U9JgpxqS8Rw/48nBbSnJ5zKf6oE7jWc=;
 b=yAype8vuUlhcGwOtksuOSxTlTsg2t3vHzuOVFuNmRsea2GIYwEk3tWuVIQkBCEn2dA
 2YGAXY0UEz+CLQBobpXByuq2tAotDjaSR/7F0QvZYI2LReN3Vw3EFPrw/a0isst5N/5I
 wMs/e06RLQylv28lv/0JZbxJqDTU4LCzRwGPLkXQ3ZoNdBlQ14sHeVJ7zSh3bx5V3OsQ
 wmAjXa7GxGfsa99+7K8K5ymT7eDSnJNlinMRDfvVVhO9+ixH2iCE7w2ctVgLRNAl+D01
 +9vQyDnxpd/nOJfDjICqQJ7n6+BzUwDRO0eEftjgQSRnCekuuFypV9fKA5WINdByH4Rp
 cxVQ==
X-Gm-Message-State: AO0yUKXUTpohpapuAkb9kndDU58arPn2MEAGsF3mjLIQJ108uB5n56l2
 /t5Lyy9M+nKwZIj/AKwBLXyFI1kKKxwfT6IivzQA0fapDrjXEqSuuAE3Nh4Qd+lFPOOOKF8bEGU
 8aWtW43WcuJUmgGWyvpl2NFroHGGP7WJMMzne43V65g==
X-Received: by 2002:adf:ec44:0:b0:2c6:85ef:4086 with SMTP id
 w4-20020adfec44000000b002c685ef4086mr2641065wrn.32.1679414684066; 
 Tue, 21 Mar 2023 09:04:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/qpBy5hLFiDKHRejykyhei5GGgmayXQki0xtcMTXtMaW6+qKHkyL/mZoulIXdg9Sh2mNKc+w==
X-Received: by 2002:adf:ec44:0:b0:2c6:85ef:4086 with SMTP id
 w4-20020adfec44000000b002c685ef4086mr2641036wrn.32.1679414683733; 
 Tue, 21 Mar 2023 09:04:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 j10-20020a5d464a000000b002cea8f07813sm11737981wrs.81.2023.03.21.09.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 09:04:43 -0700 (PDT)
Date: Tue, 21 Mar 2023 12:04:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321115854-mutt-send-email-mst@kernel.org>
References: <20230321134410.2097163-1-viktor@daynix.com>
 <87h6uem9qc.fsf@redhat.com>
 <CAPv0NP6Ep4-B7cMc285E3d3vYjgwO7O1pq5sG3OYYAoZd3EAYQ@mail.gmail.com>
 <87bkkmm89a.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bkkmm89a.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 Viktor Prutyanov <viktor@daynix.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMDQ6MzA6NTdQTSArMDEwMCwgQ29ybmVsaWEgSHVjayB3
cm90ZToKPiBPbiBUdWUsIE1hciAyMSAyMDIzLCBWaWt0b3IgUHJ1dHlhbm92IDx2aWt0b3JAZGF5
bml4LmNvbT4gd3JvdGU6Cj4gCj4gPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCA1OjU54oCvUE0g
Q29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24gVHVl
LCBNYXIgMjEgMjAyMywgVmlrdG9yIFBydXR5YW5vdiA8dmlrdG9yQGRheW5peC5jb20+IHdyb3Rl
Ogo+ID4+Cj4gPj4gPiBBY2NvcmRpbmcgdG8gVmlydElPIHNwZWMgdjEuMiwgVklSVElPX0ZfTk9U
SUZJQ0FUSU9OX0RBVEEgZmVhdHVyZQo+ID4+ID4gaW5kaWNhdGVzIHRoYXQgdGhlIGRyaXZlciBw
YXNzZXMgZXh0cmEgZGF0YSBhbG9uZyB3aXRoIHRoZSBxdWV1ZQo+ID4+ID4gbm90aWZpY2F0aW9u
cy4KPiA+PiA+Cj4gPj4gPiBJbiBhIHNwbGl0IHF1ZXVlIGNhc2UsIHRoZSBleHRyYSBkYXRhIGlz
IDE2LWJpdCBhdmFpbGFibGUgaW5kZXguIEluIGEKPiA+PiA+IHBhY2tlZCBxdWV1ZSBjYXNlLCB0
aGUgZXh0cmEgZGF0YSBpcyAxLWJpdCB3cmFwIGNvdW50ZXIgYW5kIDE1LWJpdAo+ID4+ID4gYXZh
aWxhYmxlIGluZGV4Lgo+ID4+ID4KPiA+PiA+IEFkZCBzdXBwb3J0IGZvciB0aGlzIGZlYXR1cmUg
Zm9yIE1NSU8sIFBDSSBhbmQgY2hhbm5lbCBJL08gdHJhbnNwb3J0cy4KPiA+PiA+Cj4gPj4gPiBT
aWduZWQtb2ZmLWJ5OiBWaWt0b3IgUHJ1dHlhbm92IDx2aWt0b3JAZGF5bml4LmNvbT4KPiA+PiA+
IC0tLQo+ID4+ID4gIHYzOiBzdXBwb3J0IGZlYXR1cmUgaW4gdmlydGlvX2NjdywgcmVtb3ZlIFZN
X05PVElGWSwgdXNlIGF2YWlsX2lkeF9zaGFkb3csCj4gPj4gPiAgICAgcmVtb3ZlIGJ5dGUgc3dh
cCwgcmVuYW1lIHRvIHZyaW5nX25vdGlmaWNhdGlvbl9kYXRhCj4gPj4gPiAgdjI6IHJlamVjdCB0
aGUgZmVhdHVyZSBpbiB2aXJ0aW9fY2N3LCByZXBsYWNlIF9fbGUzMiB3aXRoIHUzMgo+ID4+ID4K
PiA+PiA+ICBkcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgIHwgIDQgKysrLQo+ID4+
ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMgICAgICAgfCAxNCArKysrKysrKysrKysr
LQo+ID4+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAxMCArKysrKysr
KysrCj4gPj4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCB8ICA0ICsrKysK
PiA+PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDIgKy0KPiA+PiA+
ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIHwgIDIgKy0KPiA+PiA+ICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysKPiA+
PiA+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5nLmggICAgICAgIHwgIDIgKysKPiA+PiA+ICBp
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgIDYgKysrKysrCj4gPj4gPiAgOSBm
aWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4+ID4KPiA+
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyBiL2RyaXZl
cnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4gPj4gPiBpbmRleCA5NTRmYzMxYjRiYzcuLmMz
MzE3MmM1YjhkNSAxMDA2NDQKPiA+PiA+IC0tLSBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlv
X2Njdy5jCj4gPj4gPiArKysgYi9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+ID4+
ID4gQEAgLTM5NiwxMyArMzk2LDE1IEBAIHN0YXRpYyBib29sIHZpcnRpb19jY3dfa3ZtX25vdGlm
eShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+PiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fY2N3X3Zx
X2luZm8gKmluZm8gPSB2cS0+cHJpdjsKPiA+PiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fY2N3X2Rl
dmljZSAqdmNkZXY7Cj4gPj4gPiAgICAgICBzdHJ1Y3Qgc3ViY2hhbm5lbF9pZCBzY2hpZDsKPiA+
PiA+ICsgICAgIHUzMiBkYXRhID0gX192aXJ0aW9fdGVzdF9iaXQodnEtPnZkZXYsIFZJUlRJT19G
X05PVElGSUNBVElPTl9EQVRBKSA/Cj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgdnJpbmdf
bm90aWZpY2F0aW9uX2RhdGEodnEpIDogdnEtPmluZGV4Owo+ID4+ID4KPiA+PiA+ICAgICAgIHZj
ZGV2ID0gdG9fdmNfZGV2aWNlKGluZm8tPnZxLT52ZGV2KTsKPiA+PiA+ICAgICAgIGNjd19kZXZp
Y2VfZ2V0X3NjaGlkKHZjZGV2LT5jZGV2LCAmc2NoaWQpOwo+ID4+ID4gICAgICAgQlVJTERfQlVH
X09OKHNpemVvZihzdHJ1Y3Qgc3ViY2hhbm5lbF9pZCkgIT0gc2l6ZW9mKHVuc2lnbmVkIGludCkp
Owo+ID4+ID4gICAgICAgaW5mby0+Y29va2llID0ga3ZtX2h5cGVyY2FsbDMoS1ZNX1MzOTBfVklS
VElPX0NDV19OT1RJRlksCj4gPj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqKCh1bnNpZ25lZCBpbnQgKikmc2NoaWQpLAo+ID4+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdnEtPmluZGV4LCBpbmZvLT5jb29raWUpOwo+ID4+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSwgaW5mby0+Y29va2llKTsKPiA+PiA+ICAg
ICAgIGlmIChpbmZvLT5jb29raWUgPCAwKQo+ID4+ID4gICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7Cj4gPj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPiA+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+ID4+
ID4gaW5kZXggM2ZmNzQ2ZTNmMjRhLi43YzE2ZTYyMmMzM2QgMTAwNjQ0Cj4gPj4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gPj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fbW1pby5jCj4gPj4gPiBAQCAtMjg1LDYgKzI4NSwxNiBAQCBzdGF0aWMgYm9vbCB2bV9u
b3RpZnkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPiA+
PiA+ICB9Cj4gPj4gPgo+ID4+ID4gK3N0YXRpYyBib29sIHZtX25vdGlmeV93aXRoX2RhdGEoc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEpCj4gPj4gPiArewo+ID4+ID4gKyAgICAgc3RydWN0IHZpcnRpb19t
bWlvX2RldmljZSAqdm1fZGV2ID0gdG9fdmlydGlvX21taW9fZGV2aWNlKHZxLT52ZGV2KTsKPiA+
PiA+ICsgICAgIHUzMiBkYXRhID0gdnJpbmdfbm90aWZpY2F0aW9uX2RhdGEodnEpOwo+ID4+ID4g
Kwo+ID4+ID4gKyAgICAgd3JpdGVsKGRhdGEsIHZtX2Rldi0+YmFzZSArIFZJUlRJT19NTUlPX1FV
RVVFX05PVElGWSk7Cj4gPj4KPiA+PiBDYW4ndCB5b3Ugc2ltcGx5IHVzZSB0aGUgc2FtZSBtZXRo
b2QgYXMgZm9yIGNjdywgaS5lLiB1c2Ugb25lIGNhbGxiYWNrCj4gPj4gZnVuY3Rpb24gdGhhdCBz
aW1wbHkgd3JpdGVzIG9uZSB2YWx1ZSBvciB0aGUgb3RoZXI/Cj4gPgo+ID4gVGhlIGlkZWEgaXMg
dG8gZWxpbWluYXRlIHRoZSBjb25kaXRpb25hbCBicmFuY2ggaW5kdWNlZCBieSBmZWF0dXJlIGJp
dAo+ID4gdGVzdGluZyBmcm9tIHRoZSBub3RpZmljYXRpb24gZnVuY3Rpb24uIFByb2JhYmx5LCB0
aGlzIGNhbiBiZSBkb25lIGluCj4gPiB0aGUgc2FtZSB3YXkgaW4gY2N3Lgo+IAo+IEhtLCBob3cg
bm90aWNhYmxlIGlzIHRoYXQgYnJhbmNoPyBJT1csIGlzIGl0IHdvcnRoIG1ha2luZyB0aGUgY29k
ZSBsZXNzCj4gcmVhZGFibGUgZm9yIHRoaXM/CgpJJ20gbm90IHN1cmUgYnV0IHRoZXNlIHRoaW5n
cyBhZGQgdXAuIEknbSB3aXRoIFZpa3RvciBoZXJlIGxldCdzIGp1c3QKYXZvaWQgdGhlIGJyYW5j
aCBhbmQgbm90IHdvcnJ5IGFib3V0IHdoZXRoZXIgaXQncyBpbXBvcnRhbnQgb3Igbm90LgpTbyBs
ZXQncyB1c2UgdGhlIHNhbWUgdGhpbmcgaGVyZSB0aGVuPyBBbmQgd2UgY2FuIHVzZSBhIHN1YmZ1
bmN0aW9uCnRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24uCgo+IChJbiBhbnkgY2FzZSwgYWxsIHRy
YW5zcG9ydHMgcHJvYmFibHkgc2hvdWxkIHVzZSB0aGUgc2FtZSBtZXRob2QuKQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
