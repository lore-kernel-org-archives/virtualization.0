Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC44C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A754A81E2D;
	Thu, 23 Mar 2023 05:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A754A81E2D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ApzVK0mo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GpjCAt0luaWU; Thu, 23 Mar 2023 05:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0879B81D47;
	Thu, 23 Mar 2023 05:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0879B81D47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E03F4C0035;
	Thu, 23 Mar 2023 05:22:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FBDAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1450241C0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1450241C0B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ApzVK0mo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W0ce7ufbSw7Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:22:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0107A41BD6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0107A41BD6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679548938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLcxbzzhY9zGwedJgHXfBjK4zUokcCkg7Ykgylsb7+g=;
 b=ApzVK0moMrBoRKdtAOqaADAktmQvQ8GdXpr+Moyy+pyCQFDYN5+Tg+Qyns+NoTfp5LkVq5
 Phfz11WM7TnKc645sJ0vq/lvojHACNZOXaVS46WfOGU0OOvRbAxk1KhZWgqgcKr6hnw5PO
 5mPrBE9BCRi0ixn1HKKE2OIsg+VL8VY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-BLxQJUtLOVq4tjDplEiMaw-1; Thu, 23 Mar 2023 01:22:16 -0400
X-MC-Unique: BLxQJUtLOVq4tjDplEiMaw-1
Received: by mail-oo1-f69.google.com with SMTP id
 z133-20020a4a498b000000b0053b5c4e33c5so2650176ooa.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 22:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679548936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLcxbzzhY9zGwedJgHXfBjK4zUokcCkg7Ykgylsb7+g=;
 b=uET76DVC5lI4wVo994ygiRcFQ6HU+fJkLYqy8YhkY+fKFheZPD8HRD1XUpO0lgTudV
 lFxs1U5O9kLzp6XS9Pg5ZjcPMU6ytWk7yc3Xa53/tT1L+EUeXrb/5PmVWwRRo4bXu6CL
 sQvjOERas4PHoHJP6xj84B2TsO8sT57Ve67gZ96kT22KbHH+N7alc/VqH/yXzu4nIbiw
 SFW1aP/22vIxCxy1SiP6Vt4EIyThfaX19Sr41/axX4YmJXJpJ9HnY3hVHtyKAbNFk7pR
 bRlLfucN4vNn1tF2I4f6vXi4hbA4orQkyK1OrY+QKMh3mxo6tks4fU369HNFbKnUbPZX
 ubVQ==
X-Gm-Message-State: AAQBX9cIe/8zUxk2pTH3cYmMQTjEt1OEE2Ixtp51cvQVqBXPFoJqAiQ6
 doxbAhnqIdbKGufLaY+qmSr+4HUZO72Cx1VZ5BNrAMUOWZaFbNKOplFHB5wsJAmCUh7O4FlCMSd
 b8e02p8/6XEg9wg3PzpXd1LuExhBThso5vKLetj5/z8zAQuWoVJ9LiYp1CA==
X-Received: by 2002:a05:6871:6c97:b0:17e:7674:8df0 with SMTP id
 zj23-20020a0568716c9700b0017e76748df0mr715179oab.9.1679548936188; 
 Wed, 22 Mar 2023 22:22:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set8DG9LPnymTQpgsBkm0pxZvr9CPs3Ycm4lzdZUZn6krhMr5nVyrzyrCLHp+9uix7Q5huyJOIaDBOOxdFVqhhLA=
X-Received: by 2002:a05:6871:6c97:b0:17e:7674:8df0 with SMTP id
 zj23-20020a0568716c9700b0017e76748df0mr715177oab.9.1679548935799; Wed, 22 Mar
 2023 22:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191038.44037-1-shannon.nelson@amd.com>
 <20230322191038.44037-9-shannon.nelson@amd.com>
In-Reply-To: <20230322191038.44037-9-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 13:22:04 +0800
Message-ID: <CACGkMEvnZY8x+Wmz48ULBWsT4xEKtdW0Tyx+MOE+OGoca74Owg@mail.gmail.com>
Subject: Re: [PATCH v3 virtio 8/8] pds_vdpa: pds_vdps.rst and Kconfig
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMzoxMeKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IEFkZCB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgS2Nv
bmZpZyBlbnRyeSBmb3IgcGRzX3ZkcGEgZHJpdmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2hhbm5v
biBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gLS0tCj4gIC4uLi9kZXZpY2VfZHJp
dmVycy9ldGhlcm5ldC9hbWQvcGRzX3ZkcGEucnN0ICB8IDg0ICsrKysrKysrKysrKysrKysrKysK
PiAgLi4uL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdCAgICAgICAgIHwgIDEgKwoK
SSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8gaGF2ZSBhIGRlZGljYXRlZCBkaXJlY3RvcnkgZm9y
IHZEUEEuCgo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNCArCj4gIGRyaXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA4ICsrCj4gIDQgZmlsZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0
L2FtZC9wZHNfdmRwYS5yc3QKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL25ldHdvcmtp
bmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvYW1kL3Bkc192ZHBhLnJzdCBiL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9hbWQvcGRzX3ZkcGEucnN0Cj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ0MWY2ZGQ2NmUzZQo+
IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2aWNlX2Ry
aXZlcnMvZXRoZXJuZXQvYW1kL3Bkc192ZHBhLnJzdAo+IEBAIC0wLDAgKzEsODQgQEAKPiArLi4g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArCj4gKy4uIG5vdGU6IGNhbiBiZSBlZGl0
ZWQgYW5kIHZpZXdlZCB3aXRoIC91c3IvYmluL2Zvcm1pa28tdmltCj4gKwo+ICs9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gK1BDSSB2
RFBBIGRyaXZlciBmb3IgdGhlIEFNRC9QZW5zYW5kbyhSKSBEU0MgYWRhcHRlciBmYW1pbHkKPiAr
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQo+ICsKPiArQU1EL1BlbnNhbmRvIHZEUEEgVkYgRGV2aWNlIERyaXZlcgo+ICtDb3B5cmlnaHQo
YykgMjAyMyBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMKPiArCj4gK092ZXJ2aWV3Cj4gKz09
PT09PT09Cj4gKwo+ICtUaGUgYGBwZHNfdmRwYWBgIGRyaXZlciBpcyBhbiBhdXhpbGlhcnkgYnVz
IGRyaXZlciB0aGF0IHN1cHBsaWVzCj4gK2EgdkRQQSBkZXZpY2UgZm9yIHVzZSBieSB0aGUgdmly
dGlvIG5ldHdvcmsgc3RhY2suICBJdCBpcyB1c2VkIHdpdGgKPiArdGhlIFBlbnNhbmRvIFZpcnR1
YWwgRnVuY3Rpb24gZGV2aWNlcyB0aGF0IG9mZmVyIHZEUEEgYW5kIHZpcnRpbyBxdWV1ZQo+ICtz
ZXJ2aWNlcy4gIEl0IGRlcGVuZHMgb24gdGhlIGBgcGRzX2NvcmVgYCBkcml2ZXIgYW5kIGhhcmR3
YXJlIGZvciB0aGUgUEYKPiArYW5kIFZGIFBDSSBoYW5kbGluZyBhcyB3ZWxsIGFzIGZvciBkZXZp
Y2UgY29uZmlndXJhdGlvbiBzZXJ2aWNlcy4KPiArCj4gK1VzaW5nIHRoZSBkZXZpY2UKPiArPT09
PT09PT09PT09PT09PQo+ICsKPiArVGhlIGBgcGRzX3ZkcGFgYCBkZXZpY2UgaXMgZW5hYmxlZCB2
aWEgbXVsdGlwbGUgY29uZmlndXJhdGlvbiBzdGVwcyBhbmQKPiArZGVwZW5kcyBvbiB0aGUgYGBw
ZHNfY29yZWBgIGRyaXZlciB0byBjcmVhdGUgYW5kIGVuYWJsZSBTUi1JT1YgVmlydHVhbAo+ICtG
dW5jdGlvbiBkZXZpY2VzLgo+ICsKPiArU2hvd24gYmVsb3cgYXJlIHRoZSBzdGVwcyB0byBiaW5k
IHRoZSBkcml2ZXIgdG8gYSBWRiBhbmQgYWxzbyB0byB0aGUKPiArYXNzb2NpYXRlZCBhdXhpbGlh
cnkgZGV2aWNlIGNyZWF0ZWQgYnkgdGhlIGBgcGRzX2NvcmVgYCBkcml2ZXIuCj4gKwo+ICsuLiBj
b2RlLWJsb2NrOjogYmFzaAo+ICsKPiArICAjIS9iaW4vYmFzaAo+ICsKPiArICBtb2Rwcm9iZSBw
ZHNfY29yZQo+ICsgIG1vZHByb2JlIHZkcGEKPiArICBtb2Rwcm9iZSBwZHNfdmRwYQo+ICsKPiAr
ICBQRl9CREY9YGdyZXAgLUggInZEUEEuKjEiIC9zeXMva2VybmVsL2RlYnVnL3Bkc19jb3JlLyov
dmlmdHlwZXMgfCBoZWFkIC0xIHwgYXdrIC1GIC8gJ3twcmludCAkNn0nYAoKVGhpcyBzZWVtcyB0
byByZXF1aXJlIGRlYnVnZnMsIEkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvIHN3aXRjaCB0bwp1
c2luZyAvc3lzL2J1cy9wY2kgPwoKT3RoZXJzIGxvb2sgZ29vZC4KClRoYW5rcwoKPiArCj4gKyAg
IyBFbmFibGUgdkRQQSBWRiBhdXhpbGlhcnkgZGV2aWNlKHMpIGluIHRoZSBQRgo+ICsgIGRldmxp
bmsgZGV2IHBhcmFtIHNldCBwY2kvJFBGX0JERiBuYW1lIGVuYWJsZV92bmV0IHZhbHVlIHRydWUg
Y21vZGUgcnVudGltZQo+ICsKPiArICAjIENyZWF0ZSBhIFZGIGZvciB2RFBBIHVzZQo+ICsgIGVj
aG8gMSA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzL3Bkc19jb3JlLyRQRl9CREYvc3Jpb3ZfbnVtdmZz
Cj4gKwo+ICsgICMgRmluZCB0aGUgdkRQQSBzZXJ2aWNlcy9kZXZpY2VzIGF2YWlsYWJsZQo+ICsg
IFBEU19WRFBBX01HTVQ9YHZkcGEgbWdtdGRldiBzaG93IHwgZ3JlcCB2RFBBIHwgaGVhZCAtMSB8
IGN1dCAtZDogLWYxYAo+ICsKPiArICAjIENyZWF0ZSBhIHZEUEEgZGV2aWNlIGZvciB1c2UgaW4g
dmlydGlvIG5ldHdvcmsgY29uZmlndXJhdGlvbnMKPiArICB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBh
MSBtZ210ZGV2ICRQRFNfVkRQQV9NR01UIG1hYyAwMDoxMToyMjozMzo0NDo1NQo+ICsKPiArICAj
IFNldCB1cCBhbiBldGhlcm5ldCBpbnRlcmZhY2Ugb24gdGhlIHZkcGEgZGV2aWNlCj4gKyAgbW9k
cHJvYmUgdmlydGlvX3ZkcGEKPiArCj4gKwo+ICsKPiArRW5hYmxpbmcgdGhlIGRyaXZlcgo+ICs9
PT09PT09PT09PT09PT09PT09Cj4gKwo+ICtUaGUgZHJpdmVyIGlzIGVuYWJsZWQgdmlhIHRoZSBz
dGFuZGFyZCBrZXJuZWwgY29uZmlndXJhdGlvbiBzeXN0ZW0sCj4gK3VzaW5nIHRoZSBtYWtlIGNv
bW1hbmQ6Ogo+ICsKPiArICBtYWtlIG9sZGNvbmZpZy9tZW51Y29uZmlnL2V0Yy4KPiArCj4gK1Ro
ZSBkcml2ZXIgaXMgbG9jYXRlZCBpbiB0aGUgbWVudSBzdHJ1Y3R1cmUgYXQ6Cj4gKwo+ICsgIC0+
IERldmljZSBEcml2ZXJzCj4gKyAgICAtPiBOZXR3b3JrIGRldmljZSBzdXBwb3J0IChORVRERVZJ
Q0VTIFs9eV0pCj4gKyAgICAgIC0+IEV0aGVybmV0IGRyaXZlciBzdXBwb3J0Cj4gKyAgICAgICAg
LT4gUGVuc2FuZG8gZGV2aWNlcwo+ICsgICAgICAgICAgLT4gUGVuc2FuZG8gRXRoZXJuZXQgUERT
X1ZEUEEgU3VwcG9ydAo+ICsKPiArU3VwcG9ydAo+ICs9PT09PT09Cj4gKwo+ICtGb3IgZ2VuZXJh
bCBMaW51eCBuZXR3b3JraW5nIHN1cHBvcnQsIHBsZWFzZSB1c2UgdGhlIG5ldGRldiBtYWlsaW5n
Cj4gK2xpc3QsIHdoaWNoIGlzIG1vbml0b3JlZCBieSBQZW5zYW5kbyBwZXJzb25uZWw6Ogo+ICsK
PiArICBuZXRkZXZAdmdlci5rZXJuZWwub3JnCj4gKwo+ICtGb3IgbW9yZSBzcGVjaWZpYyBzdXBw
b3J0IG5lZWRzLCBwbGVhc2UgdXNlIHRoZSBQZW5zYW5kbyBkcml2ZXIgc3VwcG9ydAo+ICtlbWFp
bDo6Cj4gKwo+ICsgIGRyaXZlcnNAcGVuc2FuZG8uaW8KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdCBiL0RvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbmRleC5yc3QKPiBp
bmRleCBlYWFmMjg0ZTY5ZTYuLjg4ZGQzOGM3ZWI2ZCAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvaW5kZXgucnN0Cj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJz
dAo+IEBAIC0xNCw2ICsxNCw3IEBAIENvbnRlbnRzOgo+ICAgICAzY29tL3ZvcnRleAo+ICAgICBh
bWF6b24vZW5hCj4gICAgIGFtZC9wZHNfY29yZQo+ICsgICBhbWQvcGRzX3ZkcGEKPiAgICAgYWx0
ZXJhL2FsdGVyYV90c2UKPiAgICAgYXF1YW50aWEvYXRsYW50aWMKPiAgICAgY2hlbHNpby9jeGdi
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCA5NWI1ZjI1
YTJjMDYuLjJhZjEzMzg2MTA2OCAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01B
SU5UQUlORVJTCj4gQEAgLTIyMTA4LDYgKzIyMTA4LDEwIEBAIFNORVQgRFBVIFZJUlRJTyBEQVRB
IFBBVEggQUNDRUxFUkFUT1IKPiAgUjogICAgIEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNv
bGlkLXJ1bi5jb20+Cj4gIEY6ICAgICBkcml2ZXJzL3ZkcGEvc29saWRydW4vCj4KPiArUERTIERT
QyBWSVJUSU8gREFUQSBQQVRIIEFDQ0VMRVJBVE9SCj4gK1I6ICAgICBTaGFubm9uIE5lbHNvbiA8
c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPiArRjogICAgIGRyaXZlcnMvdmRwYS9wZHMvCj4gKwo+
ICBWSVJUSU8gQkFMTE9PTgo+ICBNOiAgICAgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRo
YXQuY29tPgo+ICBNOiAgICAgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9LY29uZmlnIGIvZHJpdmVycy92ZHBhL0tjb25maWcK
PiBpbmRleCBjZDZhZDkyZjNmMDUuLmM5MTBjYjExOWMxYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gQEAgLTExNiw0ICsx
MTYsMTIgQEAgY29uZmlnIEFMSUJBQkFfRU5JX1ZEUEEKPiAgICAgICAgICAgVGhpcyBkcml2ZXIg
aW5jbHVkZXMgYSBIVyBtb25pdG9yIGRldmljZSB0aGF0Cj4gICAgICAgICAgIHJlYWRzIGhlYWx0
aCB2YWx1ZXMgZnJvbSB0aGUgRFBVLgo+Cj4gK2NvbmZpZyBQRFNfVkRQQQo+ICsgICAgICAgdHJp
c3RhdGUgInZEUEEgZHJpdmVyIGZvciBBTUQvUGVuc2FuZG8gRFNDIGRldmljZXMiCj4gKyAgICAg
ICBkZXBlbmRzIG9uIFBEU19DT1JFCj4gKyAgICAgICBoZWxwCj4gKyAgICAgICAgIFZEUEEgbmV0
d29yayBkcml2ZXIgZm9yIEFNRC9QZW5zYW5kbydzIFBEUyBDb3JlIGRldmljZXMuCj4gKyAgICAg
ICAgIFdpdGggdGhpcyBkcml2ZXIsIHRoZSBWaXJ0SU8gZGF0YXBsYW5lIGNhbiBiZQo+ICsgICAg
ICAgICBvZmZsb2FkZWQgdG8gYW4gQU1EL1BlbnNhbmRvIERTQyBkZXZpY2UuCj4gKwo+ICBlbmRp
ZiAjIFZEUEEKPiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
