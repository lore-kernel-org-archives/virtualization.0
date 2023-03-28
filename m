Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A03C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6C1160D59;
	Tue, 28 Mar 2023 09:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6C1160D59
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1asiPV6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6ahi0rran3y; Tue, 28 Mar 2023 09:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FB9361160;
	Tue, 28 Mar 2023 09:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FB9361160
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECDE3C0037;
	Tue, 28 Mar 2023 09:41:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D020C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 498A1418E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:41:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 498A1418E4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1asiPV6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWFbFX2koSkh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:41:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6D4441895
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6D4441895
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679996477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmyGwthrGrNGtqcedPWh2+q6nW2x4B+d0rjKglHKKz4=;
 b=c1asiPV6x+mVS9wxqZSQj8/yDcsVwjTtLB7bX+e9j5Mz+XIkIlCrrsRtTjR+M+CcfH9EZI
 LgI4spVcAMMKc4DGCpGBD0Nmn+jhLJ/UgsGFruklyrAzcY/sV2kivON7CLDVXztZcKNzF8
 B+bKPlB6lg3ifi6DP4ykgVNl1yHrK7c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-sZgJkQiBOjqiUg26JiKYhw-1; Tue, 28 Mar 2023 05:41:16 -0400
X-MC-Unique: sZgJkQiBOjqiUg26JiKYhw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3-20020a250b03000000b00b5f1fab9897so11534445ybl.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679996476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmyGwthrGrNGtqcedPWh2+q6nW2x4B+d0rjKglHKKz4=;
 b=W59r3UAE3bYNaF5ZEY3ddx01uV450UI9yG9olH1pvy1mxzfc/ervyqV6NTFXx4kCuc
 9Td3xLcN3Re92thsi/3Jhc7i8+5xe8kk4r4M7eSqqgXy/mZmCzgkKObu6Lls05Z3OE3v
 ewPSsfecj2lZDvmkmADRxZ7nDsmFUNh7I3yX+2jIfdwq17x070HhGmVENESoyDr76BKJ
 cgTGbAkbmqDYk1S6ur5nlf1TjVxbQxzZLVLWlV9ccQGIv0NZp+BShpwusXi8UeGMZkjY
 o8nsJeLax24ta4edd8v1KacmHvyYcs67Dn29GAw7TR0THzN3iWm2S7ha9yyfxq+v+tvm
 1UxQ==
X-Gm-Message-State: AAQBX9dqfDwEtqtClKVqmIdr6NVxUoTK+qLm5ey50fGey+Rkzj1kUZ5d
 Qxq8s3hA9jZ9qOjrpRCVwYpnL9cvadOGHdS+TFW954Xi/4Y1rXstxqe6rBA5zCEbmq7U8NBfg+Q
 ooftvGYAwtQ8WimTeDJxw4boxWVgw+ywvl9fkI6D8mEDTbW1827s0fs+j9A==
X-Received: by 2002:a81:b721:0:b0:545:3f42:2d97 with SMTP id
 v33-20020a81b721000000b005453f422d97mr5919432ywh.3.1679996475820; 
 Tue, 28 Mar 2023 02:41:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUolOHwAe56CecNd0CABkiuSrZUxDa3K0A8CszJ088fIp7QTXcDxgWE91uDzPEPSrBDT7cUYobpC//OMoAK54=
X-Received: by 2002:a81:b721:0:b0:545:3f42:2d97 with SMTP id
 v33-20020a81b721000000b005453f422d97mr5919429ywh.3.1679996475584; Tue, 28 Mar
 2023 02:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <30aa2604-77c0-322e-44fd-ff99fc25e388@sberdevices.ru>
 <lgpswwclsuiukh2q5couf33jytf6abneazmwkty6fevoxcgh5p@3dzfbmenjhco>
 <d91ac5f0-1f47-58b3-d033-f492d0e17da7@sberdevices.ru>
In-Reply-To: <d91ac5f0-1f47-58b3-d033-f492d0e17da7@sberdevices.ru>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 28 Mar 2023 11:41:03 +0200
Message-ID: <CAGxU2F707_88UGt1w9pp_KLrg8EY7-BjceM+N1S6YHXSmBC+eQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] virtio/vsock: WARN_ONCE() for invalid state of
 socket
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTE6MzXigK9BTSBBcnNlbml5IEtyYXNub3YKPGF2a3Jh
c25vdkBzYmVyZGV2aWNlcy5ydT4gd3JvdGU6Cj4KPgo+Cj4gT24gMjguMDMuMjAyMyAxMjoyOSwg
U3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gT24gU3VuLCBNYXIgMjYsIDIwMjMgYXQgMDE6
MDk6MjVBTSArMDMwMCwgQXJzZW5peSBLcmFzbm92IHdyb3RlOgo+ID4+IFRoaXMgYWRkcyBXQVJO
X09OQ0UoKSBhbmQgcmV0dXJuIGZyb20gc3RyZWFtIGRlcXVldWUgY2FsbGJhY2sgd2hlbgo+ID4+
IHNvY2tldCdzIHF1ZXVlIGlzIGVtcHR5LCBidXQgJ3J4X2J5dGVzJyBzdGlsbCBub24temVyby4K
PiA+Cj4gPiBOaXQ6IEkgd291bGQgZXhwbGFpbiB3aHkgd2UgYWRkIHRoaXMsIGZvciBleGFtcGxl
Ogo+ID4KPiA+IFRoaXMgYWxsb3dzIHRoZSBkZXRlY3Rpb24gb2YgcG90ZW50aWFsIGJ1Z3MgZHVl
IHRvIHBhY2tldCBtZXJnaW5nCj4gPiAoc2VlIHByZXZpb3VzIHBhdGNoKS4KPiA+Cj4gPj4KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBBcnNlbml5IEtyYXNub3YgPEFWS3Jhc25vdkBzYmVyZGV2aWNlcy5y
dT4KPiA+PiAtLS0KPiA+PiBuZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnRfY29tbW9uLmMg
fCA3ICsrKysrKysKPiA+PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4gPgo+ID4+
Cj4gPj4gZGlmZiAtLWdpdCBhL25ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24u
YyBiL25ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYwo+ID4+IGluZGV4IGI5
MTQ0YWY3MTU1My4uYWQ3MDUzMWRlMTMzIDEwMDY0NAo+ID4+IC0tLSBhL25ldC92bXdfdnNvY2sv
dmlydGlvX3RyYW5zcG9ydF9jb21tb24uYwo+ID4+ICsrKyBiL25ldC92bXdfdnNvY2svdmlydGlv
X3RyYW5zcG9ydF9jb21tb24uYwo+ID4+IEBAIC0zOTgsNiArMzk4LDEzIEBAIHZpcnRpb190cmFu
c3BvcnRfc3RyZWFtX2RvX2RlcXVldWUoc3RydWN0IHZzb2NrX3NvY2sgKnZzaywKPiA+PiAgICAg
dTMyIGZyZWVfc3BhY2U7Cj4gPj4KPiA+PiAgICAgc3Bpbl9sb2NrX2JoKCZ2dnMtPnJ4X2xvY2sp
Owo+ID4+ICsKPiA+PiArICAgIGlmIChXQVJOX09OQ0Uoc2tiX3F1ZXVlX2VtcHR5KCZ2dnMtPnJ4
X3F1ZXVlKSAmJiB2dnMtPnJ4X2J5dGVzLAo+ID4+ICsgICAgICAgICAgICAgICJObyBza2J1ZmZz
IHdpdGggbm9uLXplcm8gJ3J4X2J5dGVzJ1xuIikpIHsKPiA+Cj4gPiBOaXQ6IEkgd291bGQgcmVw
aHJhc2UgaXQgdGhpcyB3YXk6Cj4gPiAicnhfcXVldWUgaXMgZW1wdHksIGJ1dCByeF9ieXRlcyBp
cyBub24temVybyIKPiA+Cj4gPj4gKyAgICAgICAgc3Bpbl91bmxvY2tfYmgoJnZ2cy0+cnhfbG9j
ayk7Cj4gPj4gKyAgICAgICAgcmV0dXJuIGVycjsKPiA+PiArICAgIH0KPiA+PiArCj4gPj4gICAg
IHdoaWxlICh0b3RhbCA8IGxlbiAmJiAhc2tiX3F1ZXVlX2VtcHR5KCZ2dnMtPnJ4X3F1ZXVlKSkg
ewo+ID4+ICAgICAgICAgc2tiID0gc2tiX3BlZWsoJnZ2cy0+cnhfcXVldWUpOwo+ID4+Cj4gPj4g
LS0KPiA+PiAyLjI1LjEKPiA+Pgo+ID4KPiA+IEFueXdheSB0aGUgcGF0Y2ggTEdUTSEKPgo+IFRo
YW5rcyBmb3IgcmV2aWV3ISBTaW5jZSBvbmx5IHN0cmluZyB2YWx1ZSBhbmQgY29tbWl0IG1lc3Nh
Z2Ugc2hvdWxkIGJlCj4gdXBkYXRlZCwgaSBjYW4gcmVzZW5kIGl0IHdpdGggJ25ldCcgKGFzIGl0
IGlzIGZpeCkgYW5kIHVwZGF0ZSB0d28gdGhpbmcKPiBhYm92ZSBpbiAnbmV0JyB2ZXJzaW9uPwoK
WWVwLCBzdXJlIQoKQW5kIHlvdSBjYW4gYWxyZWFkeSBhZGQgbXkgUi1iIDstKQoKVGhhbmtzLApT
dGVmYW5vCgo+Cj4gVGhhbmtzLCBBcnNlbml5Cj4gPgo+ID4gUmV2aWV3ZWQtYnk6IFN0ZWZhbm8g
R2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
