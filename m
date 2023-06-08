Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A14C7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 09:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57F0F61402;
	Thu,  8 Jun 2023 09:21:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57F0F61402
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oa2SKuat
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dj265KJBZ-H; Thu,  8 Jun 2023 09:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD99461095;
	Thu,  8 Jun 2023 09:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD99461095
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91932C007A;
	Thu,  8 Jun 2023 09:21:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB75C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3357B83A92
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:21:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3357B83A92
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oa2SKuat
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EPBS1VNDbbQJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:21:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE6F983A8F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE6F983A8F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686216105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wciZzZhI8oXg7Yuw9Rr2DJCHC9/Z7EBEfdGZiOUWtDk=;
 b=Oa2SKuatqQBqQqYqy2nk4cGd+kmYJTCj06Nk24d48F5lIlvRwKWr9WOclIkHo1Jo+9NzB6
 eVNQWCarWlqcDogEsyZOX1lq/5Si2mqHxtyv8VmgrLjC8bXsHqVwbO28rY4eZ/j6erjErs
 84JnW5waz8/ZLGmUMk35YsHSt665sAI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-D8vuU6LIOuumjq9YZ2On0A-1; Thu, 08 Jun 2023 05:21:43 -0400
X-MC-Unique: D8vuU6LIOuumjq9YZ2On0A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75d6b90f933so56130885a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686216102; x=1688808102;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wciZzZhI8oXg7Yuw9Rr2DJCHC9/Z7EBEfdGZiOUWtDk=;
 b=KPm3+5wMU/M2Zf3dmFbPMqW6GR/FRPWAk72fXPdc0dFVN1feGoXgRKLC7YoLj/Y4S/
 3F1Nh3V6KYs2gsHg/D/OV0VEVCWYYd+igd/Asx/fuzQX4gUvUBM1Ks3pAMtjqvrE1C4F
 xaOnDIFr90gn3eOOhJfsVUF9jME7Dz/6ee6wKKRMKu0lAW1r4s8lss0+jxoyPcIfEn5C
 dSxMH7alrFvkjWPO4pY9CtrgcDI11kO4Lf6xOPFubANyFqonqEH3kv3eeefNH8G281gV
 QdmNF5TeRF/CZY088shmRVMD4itszMHx+kj25bBD3h9TYJatHkD4hNMMw0gLthCkddk1
 piGg==
X-Gm-Message-State: AC+VfDyydmM8acfkqqmZ/pZVgSxhSfbb1GCu5zlXTDxSSAu+ZuwjHHxz
 JiYVHZLbIObIpdlWXV6l1mDVoKJZWH9pDBNhV++2ODuWGezvUxWJLn9EKTazhwV02VJGnZR9uY4
 0Df88/Pu56I4VohOOqaH0O3OHrRVPjtO2KOpVmyFg7A==
X-Received: by 2002:a05:620a:8395:b0:75b:23a1:3668 with SMTP id
 pb21-20020a05620a839500b0075b23a13668mr4482007qkn.41.1686216102500; 
 Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bhyfn7UJWLUNBv8vKAKxl3tIW7+FDTT6J28VyZbWi/o5E0G9yWUmjDAKtkWbyk9CcvIR9Vg==
X-Received: by 2002:a05:620a:8395:b0:75b:23a1:3668 with SMTP id
 pb21-20020a05620a839500b0075b23a13668mr4481995qkn.41.1686216102220; 
 Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it.
 [87.12.25.111]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05620a13c900b007463509f94asm201231qkl.55.2023.06.08.02.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:21:41 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:21:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
References: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6MDA6MDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNDowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0
IDAzOjQ2OjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IFsuLi5dCj4+Cj4+ID4+
ID4gPiA+ID4gSSBoYXZlIGEgcXVlc3Rpb24gdGhvdWdoLCB3aGF0IGlmIGRvd24gdGhlIHJvYWQg
dGhlcmUKPj4gPj4gPiA+ID4gPiBpcyBhIG5ldyBmZWF0dXJlIHRoYXQgbmVlZHMgbW9yZSBjaGFu
Z2VzPyBJdCB3aWxsIGJlCj4+ID4+ID4gPiA+ID4gYnJva2VuIHRvbyBqdXN0IGxpa2UgUEFDS0VE
IG5vPwo+PiA+PiA+ID4gPiA+IFNob3VsZG4ndCB2ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZl
YXR1cmVzIGl0IGtub3dzIGhvdwo+PiA+PiA+ID4gPiA+IHRvIHN1cHBvcnQ/Cj4+ID4+ID4gPiA+
Cj4+ID4+ID4gPiA+IEl0IGxvb2tzIGxpa2Ugd2UgaGFkIGl0LCBidXQgd2UgdG9vayBpdCBvdXQg
KGJ5IHRoZSB3YXksIHdlIHdlcmUKPj4gPj4gPiA+ID4gZW5hYmxpbmcgcGFja2VkIGV2ZW4gdGhv
dWdoIHdlIGRpZG4ndCBzdXBwb3J0IGl0KToKPj4gPj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/
aWQ9NjIzNGY4MDU3NGQ3NTY5NDQ0ZDg3MTgzNTVmYTI4MzhlOTJiMTU4Ygo+PiA+PiA+ID4gPgo+
PiA+PiA+ID4gPiBUaGUgb25seSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgZm9yIGVhY2ggbmV3IGZl
YXR1cmUgd2UgaGF2ZSB0byBtb2RpZnkKPj4gPj4gPiA+ID4gdGhlIGtlcm5lbC4KPj4gPj4gPiA+
ID4gQ291bGQgd2UgaGF2ZSBuZXcgZmVhdHVyZXMgdGhhdCBkb24ndCByZXF1aXJlIGhhbmRsaW5n
IGJ5IHZob3N0LXZkcGE/Cj4+ID4+ID4gPiA+Cj4+ID4+ID4gPiA+IFRoYW5rcywKPj4gPj4gPiA+
ID4gU3RlZmFubwo+PiA+PiA+ID4KPj4gPj4gPiA+IEphc29uIHdoYXQgZG8geW91IHNheSB0byBy
ZXZlcnRpbmcgdGhpcz8KPj4gPj4gPgo+PiA+PiA+IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBJ
IGRvbid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIHZEUEEgY29yZS4KPj4gPj4gPgo+PiA+PiA+IEl0
J3MgdGhlIGR1dHkgb2YgdGhlIHBhcmVudHMgdG8gYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlcyBpdCBo
YXMuIEZvciBleGFtcGxlLAo+PiA+PiA+Cj4+ID4+ID4gMSkgSWYgc29tZSBrZXJuZWwgdmVyc2lv
biB0aGF0IGlzIHBhY2tlZCBpcyBub3Qgc3VwcG9ydGVkIHZpYQo+PiA+PiA+IHNldF92cV9zdGF0
ZSwgcGFyZW50cyBzaG91bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgZmVhdHVyZXMgaW4gdGhpcwo+
PiA+PiA+IGNhc2UuCj4+ID4+ID4gMikgSWYgdGhlIGtlcm5lbCBoYXMgc3VwcG9ydCBwYWNrZWQg
c2V0X3ZxX3N0YXRlKCksIGJ1dCBpdCdzIGVtdWxhdGVkCj4+ID4+ID4gY3ZxIGRvZXNuJ3Qgc3Vw
cG9ydCwgcGFyZW50cyBzaG91bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgYXMgd2VsbAo+PiA+PiA+
Cj4+ID4+ID4gSWYgYSBwYXJlbnQgdmlvbGF0ZXMgdGhlIGFib3ZlIDIsIGl0IGxvb2tzIGxpa2Ug
YSBidWcgb2YgdGhlIHBhcmVudHMuCj4+ID4+ID4KPj4gPj4gPiBUaGFua3MKPj4gPj4KPj4gPj4g
WWVzIGJ1dCB3aGF0IGFib3V0IHZob3N0X3ZkcGE/IFRhbGtpbmcgYWJvdXQgdGhhdCBub3QgdGhl
IGNvcmUuCj4+ID4KPj4gPk5vdCBzdXJlIGl0J3MgYSBnb29kIGlkZWEgdG8gd29ya2Fyb3VuZCBw
YXJlbnQgYnVncyB2aWEgdmhvc3QtdkRQQS4KPj4KPj4gU29ycnksIEknbSBnZXR0aW5nIGxvc3Qu
Li4KPj4gV2Ugd2VyZSB0YWxraW5nIGFib3V0IHRoZSBmYWN0IHRoYXQgdmhvc3QtdmRwYSBkb2Vz
bid0IGhhbmRsZQo+PiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpb2N0bHMgd2VsbCBm
b3IgcGFja2VkIHZpcnRxdWV1ZSBiZWZvcmUKPj4gdGhhdCBzZXJpZXMgWzFdLCBubz8KPj4KPj4g
VGhlIHBhcmVudHMgc2VlbSBva2F5LCBidXQgbWF5YmUgSSBtaXNzZWQgYSBmZXcgdGhpbmdzLgo+
Pgo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0MjQy
MjUwMzEuMTg5NDctMS1zaGFubm9uLm5lbHNvbkBhbWQuY29tLwo+Cj5ZZXMsIG1vcmUgYmVsb3cu
Cj4KPj4KPj4gPgo+PiA+PiBTaG91bGQgdGhhdCBub3QgaGF2ZSBhIHdoaXRlbGlzdCBvZiBmZWF0
dXJlcwo+PiA+PiBzaW5jZSBpdCBpbnRlcnByZXRzIGlvY3RscyBkaWZmZXJlbnRseSBkZXBlbmRp
bmcgb24gdGhpcz8KPj4gPgo+PiA+SWYgdGhlcmUncyBhIGJ1ZywgaXQgbWlnaHQgb25seSBtYXR0
ZXIgdGhlIGZvbGxvd2luZyBzZXR1cDoKPj4gPgo+PiA+U0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5H
X0JBU0UgKyBWRFVTRS4KPj4gPgo+PiA+VGhpcyBzZWVtcyB0byBiZSBicm9rZW4gc2luY2UgVkRV
U0Ugd2FzIGludHJvZHVjZWQuIElmIHdlIHJlYWxseSB3YW50Cj4+ID50byBiYWNrcG9ydCBzb21l
dGhpbmcsIGl0IGNvdWxkIGJlIGEgZml4IHRvIGZpbHRlciBvdXQgUEFDS0VEIGluCj4+ID5WRFVT
RT8KPj4KPj4gbW1tIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBhIHByb2JsZW0gaW4gVkRVU0UsIGJ1
dCBpbiB2aG9zdC12ZHBhLgo+PiBJIHRoaW5rIFZEVVNFIHdvcmtzIGZpbmUgd2l0aCBwYWNrZWQg
dmlydHF1ZXVlIHVzaW5nIHZpcnRpby12ZHBhCj4+IChJIGhhdmVuJ3QgdHJpZWQpLCBzbyB3aHkg
c2hvdWxkIHdlIGZpbHRlciBQQUNLRUQgaW4gVkRVU0U/Cj4KPkkgZG9uJ3QgdGhpbmsgd2UgbmVl
ZCBhbnkgZmlsdGVyaW5nIHNpbmNlOgo+Cj5QQUNLRUQgZmVhdHVyZXMgaGFzIGJlZW4gYWR2ZXJ0
aXNlZCB0byB1c2Vyc3BhY2UgdmlhIHVBUEkgc2luY2UKPjYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4
MzU1ZmEyODM4ZTkyYjE1OGIuIE9uY2Ugd2UgcmVsYXggaW4gdUFQSSwgaXQKPndvdWxkIGJlIHZl
cnkgaGFyZCB0byByZXN0cmljdCBpdCBhZ2Fpbi4gRm9yIHRoZSB1c2Vyc3BhY2UgdGhhdCB0cmll
cwo+dG8gbmVnb3RpYXRlIFBBQ0tFRDoKPgo+MSkgaWYgaXQgZG9lc24ndCB1c2UgU0VUX1ZSSU5H
X0JBU0UvR0VUX1ZSSU5HX0JBU0UsIGV2ZXJ5dGhpbmcgd29ya3Mgd2VsbAo+MikgaWYgaXQgdXNl
cyBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRS4gaXQgbWlnaHQgZmFpbCBvciBicmVhayBz
aWxlbnRseQo+Cj5JZiB3ZSBiYWNrcG9ydCB0aGUgZml4ZXMgdG8gLXN0YWJsZSwgd2UgbWF5IGJy
ZWFrIHRoZSBhcHBsaWNhdGlvbiBhdAo+bGVhc3QgaW4gdGhlIGNhc2UgMSkuCgpPa2F5LCBJIHNl
ZSBub3csIHRoYW5rcyBmb3IgdGhlIGRldGFpbHMhCgpNYXliZSBpbnN0ZWFkIG9mICJicmVhayBz
aWxlbnRseSIsIHdlIGNhbiByZXR1cm4gYW4gZXhwbGljaXQgZXJyb3IgZm9yClNFVF9WUklOR19C
QVNFL0dFVF9WUklOR19CQVNFIGluIHN0YWJsZSBicmFuY2hlcy4KQnV0IGlmIHRoZXJlIGFyZSBu
b3QgbWFueSBjYXNlcywgd2UgY2FuIGxlYXZlIGl0IGxpa2UgdGhhdC4KCkkgd2FzIGp1c3QgY29u
Y2VybmVkIGFib3V0IGhvdyBkb2VzIHRoZSB1c2VyIHNwYWNlIHVuZGVyc3RhbmQgdGhhdCBpdApj
YW4gdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFIGZvciBQQUNLRUQgdmlydHF1ZXVl
cyBpbiBhIGdpdmVuCmtlcm5lbCBvciBub3QuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
