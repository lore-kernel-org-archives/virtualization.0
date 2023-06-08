Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46EBC77B7A
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 00:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1726541E1C;
	Thu,  8 Jun 2023 00:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1726541E1C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lfo3or5s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFcLlUjZMbmv; Thu,  8 Jun 2023 00:42:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC8A841BF7;
	Thu,  8 Jun 2023 00:42:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC8A841BF7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D04AC007A;
	Thu,  8 Jun 2023 00:42:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92037C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 547FE60EFC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 547FE60EFC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lfo3or5s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkGoZ99scUYD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C33160B6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C33160B6C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686184951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEl6t5FZvqqMGtRao10LY7MIqY+vo/3jnIQEpVR8PDs=;
 b=Lfo3or5sDow8pWN6GCTJFHEMjZcg8HAwSdCpRB873BKkdljvgiWoiZ289OpfUIHvvttszZ
 BInRT56/vSxgAw3jl9bytt/8lTIePGFaJo+C0Bt0NYr8a9YupQA8eMHk8bCcikplZl5OcI
 sX1psIQgQz05N8J94b5lX78a05i7p+E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-OJo_6NNUOqSC4kap4ZiMAw-1; Wed, 07 Jun 2023 20:42:29 -0400
X-MC-Unique: OJo_6NNUOqSC4kap4ZiMAw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ecb00906d0so49068e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 17:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686184947; x=1688776947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEl6t5FZvqqMGtRao10LY7MIqY+vo/3jnIQEpVR8PDs=;
 b=aH96aAD5QGtR4ZsYTLxjxP+VtxINF+M5bhKitfmHD1SCRuJ7dRttnfLzyOtqTN5OGv
 L7+lN/k1peVfw0stT3hoErRmkcOqfFybLfSooCjJhKw7SNAm+dco4simJIrr8MvVElcu
 ZlFagX29XRwC79ynPwy2KobZe/jgwfnObLxR+JWDznJ39VbPt8hmwhPZpwjaiqGPJPQq
 zxuPJPDlPhpYNWe/orJGJc68q3lQyEf3w1rCIkKOaAu0h3QvZQmnb7Qi/euGORsFBjAQ
 Wa+yfRBC6Nd4foLQzSeYL0iHSG6QVwWBXTB4CE0xoNtuxPreM4YWr+jNdewVI9eaCtAL
 k0MA==
X-Gm-Message-State: AC+VfDwqk9gRAk/xhz5IgOH1AGv1q32tAS8L5lWI515ckHzaQ6FJizR8
 rIeZFSdFVuLez9uMWQ+bxKHsmZU2Yu2OQipf+T9pKlXgws98+IgCM0uhYmNd9z6pjN5rWZVaTHH
 yI44WkPZnUJfQJQlUIM4QCVw6/9iPq+8czC1zGruajKWoi1/RBQXdrV0S/w==
X-Received: by 2002:ac2:592b:0:b0:4f2:5ef9:45fb with SMTP id
 v11-20020ac2592b000000b004f25ef945fbmr2270037lfi.52.1686184947248; 
 Wed, 07 Jun 2023 17:42:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Jagu8jFL3Tk7QBl5bX84sKkwXDyc0yqpe5DjC3wP0g8RxkLKVB46KhsINWWUbRs14XNdausmTmzDN1x+iH7M=
X-Received: by 2002:ac2:592b:0:b0:4f2:5ef9:45fb with SMTP id
 v11-20020ac2592b000000b004f25ef945fbmr2270024lfi.52.1686184946912; Wed, 07
 Jun 2023 17:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230607054246-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jun 2023 08:42:15 +0800
Message-ID: <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

T24gV2VkLCBKdW4gNywgMjAyMyBhdCA1OjQz4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1biAwNywgMjAyMyBhdCAxMDozOToxNUFN
ICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiBPbiBUdWUsIEp1biA2LCAyMDIz
IGF0IDI6NTjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToK
PiA+ID4KPiA+ID4gT24gVHVlLCBKdW4gMDYsIDIwMjMgYXQgMDk6Mjk6MjJBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPiA+ID4gPiBPbiBNb24sIEp1biA1LCAyMDIzIGF0IDEwOjU44oCvUE0g
U3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
Cj4gPiA+ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwOTo1NDo1N0FNIC0wNDAwLCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQg
MDM6MzA6MzVQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPj4g
T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDk6MDA6MjVBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+ID4gPiA+ID4gPj4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwMjo1NDoy
MFBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+ID4gPiA+PiA+ID4gT24g
TW9uLCBKdW4gMDUsIDIwMjMgYXQgMDg6NDE6NTRBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gPiA+ID4gPj4gPiA+ID4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDE6MDY6
NDRQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPj4gPiA+ID4g
PiB2aG9zdC12ZHBhIElPQ1RMcyAoZWcuIFZIT1NUX0dFVF9WUklOR19CQVNFLCBWSE9TVF9TRVRf
VlJJTkdfQkFTRSkKPiA+ID4gPiA+ID4+ID4gPiA+ID4gZG9uJ3Qgc3VwcG9ydCBwYWNrZWQgdmly
dHF1ZXVlIHdlbGwgeWV0LCBzbyBsZXQncyBmaWx0ZXIgdGhlCj4gPiA+ID4gPiA+PiA+ID4gPiA+
IFZJUlRJT19GX1JJTkdfUEFDS0VEIGZlYXR1cmUgZm9yIG5vdyBpbiB2aG9zdF92ZHBhX2dldF9m
ZWF0dXJlcygpLgo+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPj4gPiA+ID4gPiBUaGlz
IHdheSwgZXZlbiBpZiB0aGUgZGV2aWNlIHN1cHBvcnRzIGl0LCB3ZSBkb24ndCByaXNrIGl0IGJl
aW5nCj4gPiA+ID4gPiA+PiA+ID4gPiA+IG5lZ290aWF0ZWQsIHRoZW4gdGhlIFZNTSBpcyB1bmFi
bGUgdG8gc2V0IHRoZSB2cmluZyBzdGF0ZSBwcm9wZXJseS4KPiA+ID4gPiA+ID4+ID4gPiA+ID4K
PiA+ID4gPiA+ID4+ID4gPiA+ID4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1
Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPiA+ID4gPiA+ID4+ID4gPiA+ID4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiA+ID4+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+ID4gPiA+ID4gPj4gPiA+ID4gPiAt
LS0KPiA+ID4gPiA+ID4+ID4gPiA+ID4KPiA+ID4gPiA+ID4+ID4gPiA+ID4gTm90ZXM6Cj4gPiA+
ID4gPiA+PiA+ID4gPiA+ICAgICBUaGlzIHBhdGNoIHNob3VsZCBiZSBhcHBsaWVkIGJlZm9yZSB0
aGUgIltQQVRDSCB2MiAwLzNdIHZob3N0X3ZkcGE6Cj4gPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBi
ZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHNlcmllcyBbMV0gYW5kIGJhY2twb3J0ZWQgaW4gc3RhYmxl
IGJyYW5jaGVzLgo+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAg
V2UgY2FuIHJldmVydCBpdCB3aGVuIHdlIGFyZSBzdXJlIHRoYXQgZXZlcnl0aGluZyBpcyB3b3Jr
aW5nIHdpdGgKPiA+ID4gPiA+ID4+ID4gPiA+ID4gICAgIHBhY2tlZCB2aXJ0cXVldWVzLgo+ID4g
PiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4gPj4gPiA+ID4gPiAgICAgVGhhbmtzLAo+ID4gPiA+
ID4gPj4gPiA+ID4gPiAgICAgU3RlZmFubwo+ID4gPiA+ID4gPj4gPiA+ID4gPgo+ID4gPiA+ID4g
Pj4gPiA+ID4gPiAgICAgWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9u
LzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNvbS8KPiA+ID4gPiA+
ID4+ID4gPiA+Cj4gPiA+ID4gPiA+PiA+ID4gPiBJJ20gYSBiaXQgbG9zdCBoZXJlLiBTbyB3aHkg
YW0gSSBtZXJnaW5nICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHRoZW4/Cj4gPiA+ID4gPiA+PiA+
ID4KPiA+ID4gPiA+ID4+ID4gPiBUbyByZWFsbHkgc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIHdp
dGggdmhvc3QtdmRwYSwgYXQgdGhhdCBwb2ludCB3ZSB3b3VsZAo+ID4gPiA+ID4gPj4gPiA+IGFs
c28gaGF2ZSB0byByZXZlcnQgdGhpcyBwYXRjaC4KPiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4g
Pj4gPiA+IEkgd2Fzbid0IHN1cmUgaWYgeW91IHdhbnRlZCB0byBxdWV1ZSB0aGUgc2VyaWVzIGZv
ciB0aGlzIG1lcmdlIHdpbmRvdy4KPiA+ID4gPiA+ID4+ID4gPiBJbiB0aGF0IGNhc2UgZG8geW91
IHRoaW5rIGl0IGlzIGJldHRlciB0byBzZW5kIHRoaXMgcGF0Y2ggb25seSBmb3Igc3RhYmxlCj4g
PiA+ID4gPiA+PiA+ID4gYnJhbmNoZXM/Cj4gPiA+ID4gPiA+PiA+ID4gPiBEb2VzIHRoaXMgcGF0
Y2ggbWFrZSB0aGVtIGEgTk9QPwo+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+PiA+ID4gWWVw
LCBhZnRlciBhcHBseWluZyB0aGUgImJldHRlciBQQUNLRUQgc3VwcG9ydCIgc2VyaWVzIGFuZCBi
ZWluZwo+ID4gPiA+ID4gPj4gPiA+IHN1cmUgdGhhdAo+ID4gPiA+ID4gPj4gPiA+IHRoZSBJT0NU
THMgb2Ygdmhvc3QtdmRwYSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUsIHdlIHNob3VsZCByZXZl
cnQgdGhpcwo+ID4gPiA+ID4gPj4gPiA+IHBhdGNoLgo+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4g
PiA+PiA+ID4gTGV0IG1lIGtub3cgaWYgeW91IHByZWZlciBhIGRpZmZlcmVudCBhcHByb2FjaC4K
PiA+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4gPj4gPiA+IEknbSBjb25jZXJuZWQgdGhhdCBRRU1V
IHVzZXMgdmhvc3QtdmRwYSBJT0NUTHMgdGhpbmtpbmcgdGhhdCB0aGUga2VybmVsCj4gPiA+ID4g
PiA+PiA+ID4gaW50ZXJwcmV0cyB0aGVtIHRoZSByaWdodCB3YXksIHdoZW4gaXQgZG9lcyBub3Qu
Cj4gPiA+ID4gPiA+PiA+ID4KPiA+ID4gPiA+ID4+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiA+PiA+
ID4gU3RlZmFubwo+ID4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPiA+PiA+Cj4gPiA+ID4gPiA+PiA+
IElmIHRoaXMgZml4ZXMgYSBidWcgY2FuIHlvdSBhZGQgRml4ZXMgdGFncyB0byBlYWNoIG9mIHRo
ZW0/IFRoZW4gaXQncyBvawo+ID4gPiA+ID4gPj4gPiB0byBtZXJnZSBpbiB0aGlzIHdpbmRvdy4g
UHJvYmFibHkgZWFzaWVyIHRoYW4gdGhlIGVsYWJvcmF0ZQo+ID4gPiA+ID4gPj4gPiBtYXNrL3Vu
bWFzayBkYW5jZS4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBDQ2luZyBTaGFubm9uICh0aGUg
b3JpZ2luYWwgYXV0aG9yIG9mIHRoZSAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0Igo+ID4gPiA+ID4g
Pj4gc2VyaWVzKS4KPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBJSVVDIFNoYW5ub24gaXMgZ29p
bmcgdG8gc2VuZCBhIHYzIG9mIHRoYXQgc2VyaWVzIHRvIGZpeCB0aGUKPiA+ID4gPiA+ID4+IGRv
Y3VtZW50YXRpb24sIHNvIFNoYW5ub24gY2FuIHlvdSBhbHNvIGFkZCB0aGUgRml4ZXMgdGFncz8K
PiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+PiBUaGFua3MsCj4gPiA+ID4gPiA+PiBTdGVmYW5vCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+V2VsbCB0aGlzIGlzIGluIG15IHRyZWUgYWxyZWFkeS4gSnVz
dCByZXBseSB3aXRoCj4gPiA+ID4gPiA+Rml4ZXM6IDw+Cj4gPiA+ID4gPiA+dG8gZWFjaCBhbmQg
SSB3aWxsIGFkZCB0aGVzZSB0YWdzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgdHJpZWQsIGJ1dCBp
dCBpcyBub3QgZWFzeSBzaW5jZSB3ZSBhZGRlZCB0aGUgc3VwcG9ydCBmb3IgcGFja2VkCj4gPiA+
ID4gPiB2aXJ0cXVldWUgaW4gdmRwYSBhbmQgdmhvc3QgaW5jcmVtZW50YWxseS4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBJbml0aWFsbHkgSSB3YXMgdGhpbmtpbmcgb2YgYWRkaW5nIHRoZSBzYW1lIHRh
ZyB1c2VkIGhlcmU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZo
b3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPiA+ID4gPiA+Cj4gPiA+ID4gPiBU
aGVuIEkgZGlzY292ZXJlZCB0aGF0IHZxX3N0YXRlIHdhc24ndCB0aGVyZSwgc28gSSB3YXMgdGhp
bmtpbmcgb2YKPiA+ID4gPiA+Cj4gPiA+ID4gPiBGaXhlczogNTMwYTU2NzhiYzAwICgidmRwYTog
c3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIGZvciBzZXQvZ2V0X3ZxX3N0YXRlKCkiKQo+ID4gPiA+
ID4KPiA+ID4gPiA+IFNvIHdlIHdvdWxkIGhhdmUgdG8gYmFja3BvcnQgcXVpdGUgYSBmZXcgcGF0
Y2hlcyBpbnRvIHRoZSBzdGFibGUgYnJhbmNoZXMuCj4gPiA+ID4gPiBJIGRvbid0IGtub3cgaWYg
aXQncyB3b3J0aCBpdC4uLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgc3RpbGwgdGhpbmsgaXQgaXMg
YmV0dGVyIHRvIGRpc2FibGUgcGFja2VkIGluIHRoZSBzdGFibGUgYnJhbmNoZXMsCj4gPiA+ID4g
PiBvdGhlcndpc2UgSSBoYXZlIHRvIG1ha2UgYSBsaXN0IG9mIGFsbCB0aGUgcGF0Y2hlcyB3ZSBu
ZWVkLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFueSBvdGhlciBpZGVhcz8KPiA+ID4gPgo+ID4gPiA+
IEFGQUlLLCBleGNlcHQgZm9yIHZwX3ZkcGEsIHBkcyBzZWVtcyB0byBiZSB0aGUgZmlyc3QgcGFy
ZW50IHRoYXQKPiA+ID4gPiBzdXBwb3J0cyBwYWNrZWQgdmlydHF1ZXVlLiBVc2VycyBzaG91bGQg
bm90IG5vdGljZSBhbnl0aGluZyB3cm9uZyBpZgo+ID4gPiA+IHRoZXkgZG9uJ3QgdXNlIHBhY2tl
ZCB2aXJ0cXVldWUuIEFuZCB0aGUgcHJvYmxlbSBvZiB2cF92ZHBhICsgcGFja2VkCj4gPiA+ID4g
dmlydHF1ZXVlIGNhbWUgc2luY2UgdGhlIGRheTAgb2YgdnBfdmRwYS4gSXQgc2VlbXMgZmluZSB0
byBkbyBub3RoaW5nCj4gPiA+ID4gSSBndWVzcy4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4g
Pgo+ID4gPgo+ID4gPiBJIGhhdmUgYSBxdWVzdGlvbiB0aG91Z2gsIHdoYXQgaWYgZG93biB0aGUg
cm9hZCB0aGVyZQo+ID4gPiBpcyBhIG5ldyBmZWF0dXJlIHRoYXQgbmVlZHMgbW9yZSBjaGFuZ2Vz
PyBJdCB3aWxsIGJlCj4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPiA+ID4g
U2hvdWxkbid0IHZkcGEgaGF2ZSBhbiBhbGxvd2xpc3Qgb2YgZmVhdHVyZXMgaXQga25vd3MgaG93
Cj4gPiA+IHRvIHN1cHBvcnQ/Cj4gPgo+ID4gSXQgbG9va3MgbGlrZSB3ZSBoYWQgaXQsIGJ1dCB3
ZSB0b29rIGl0IG91dCAoYnkgdGhlIHdheSwgd2Ugd2VyZQo+ID4gZW5hYmxpbmcgcGFja2VkIGV2
ZW4gdGhvdWdoIHdlIGRpZG4ndCBzdXBwb3J0IGl0KToKPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lk
PTYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIKPiA+Cj4gPiBUaGUgb25s
eSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgZm9yIGVhY2ggbmV3IGZlYXR1cmUgd2UgaGF2ZSB0byBt
b2RpZnkKPiA+IHRoZSBrZXJuZWwuCj4gPiBDb3VsZCB3ZSBoYXZlIG5ldyBmZWF0dXJlcyB0aGF0
IGRvbid0IHJlcXVpcmUgaGFuZGxpbmcgYnkgdmhvc3QtdmRwYT8KPiA+Cj4gPiBUaGFua3MsCj4g
PiBTdGVmYW5vCj4KPiBKYXNvbiB3aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5nIHRoaXM/CgpJ
IG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSBkb24ndCBzZWUgYW55IHByb2JsZW0gd2l0aCB2RFBB
IGNvcmUuCgpJdCdzIHRoZSBkdXR5IG9mIHRoZSBwYXJlbnRzIHRvIGFkdmVydGlzZSB0aGUgZmVh
dHVyZXMgaXQgaGFzLiBGb3IgZXhhbXBsZSwKCjEpIElmIHNvbWUga2VybmVsIHZlcnNpb24gdGhh
dCBpcyBwYWNrZWQgaXMgbm90IHN1cHBvcnRlZCB2aWEKc2V0X3ZxX3N0YXRlLCBwYXJlbnRzIHNo
b3VsZCBub3QgYWR2ZXJ0aXNlIFBBQ0tFRCBmZWF0dXJlcyBpbiB0aGlzCmNhc2UuCjIpIElmIHRo
ZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFja2VkIHNldF92cV9zdGF0ZSgpLCBidXQgaXQncyBlbXVs
YXRlZApjdnEgZG9lc24ndCBzdXBwb3J0LCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBB
Q0tFRCBhcyB3ZWxsCgpJZiBhIHBhcmVudCB2aW9sYXRlcyB0aGUgYWJvdmUgMiwgaXQgbG9va3Mg
bGlrZSBhIGJ1ZyBvZiB0aGUgcGFyZW50cy4KClRoYW5rcwoKPgo+IC0tCj4gTVNUCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
