Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1DFEB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 10:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4BE840A74;
	Thu,  6 Jul 2023 10:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4BE840A74
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeVRFWYn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqSsKqg5Ts4U; Thu,  6 Jul 2023 10:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44BD74011D;
	Thu,  6 Jul 2023 10:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44BD74011D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D687C0072;
	Thu,  6 Jul 2023 10:02:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90963C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 10:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FC9D81F8F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 10:02:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FC9D81F8F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeVRFWYn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TV2gEyg-ZIDk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 10:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A28481F21
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A28481F21
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688637716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
 b=XeVRFWYnIg/4BtQwO/unA4jYMcnsazcfvBBz/DVLAvXM5GX9Jk6+oiHed7ACMTH30pnV25
 IovesE5dbqETjdN+hf2vUy9teAmFf9uhPmxcvRNplXm5AWZ3nO0aH6hMACQKmAHnBaUI48
 Xof3wIrh32BdmekNX4LjRYQtt5LI5ME=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-RT7vqFaVMFKQLkrAmJjYRw-1; Thu, 06 Jul 2023 06:01:50 -0400
X-MC-Unique: RT7vqFaVMFKQLkrAmJjYRw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-576d63dfc1dso6049517b3.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688637710; x=1691229710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
 b=CIoNdHLgWslUaWUdVIzF4DSm4JdasuR7hKiTPrjHi8nxQX70bmfjMAON7x0DelsTRD
 NjjB/KgaAk9Ujzu1nF5WZ/pK0DWNi7kYvlI0A0dy4mpc/dc/d1lR662kFoQP+34JzKgN
 thEhkB3BZlySJ36cbGp0UREKbIDaKNLvxceH10KRag0idnv0Qm4TeJB2Xnsxo6kRScR4
 Q5hJxyfg7wkSesohBNGKK/PVMo19ALItA7o21xeiYuevp7sL6RovBUfuAt4qktXG/W7F
 hiL15qrE4aLpOi3kJNI9LY8wZ74D9g3GNF1+lj4JS0BmPMxarzVovkJ3oQ3O2TmQCzNU
 kDxQ==
X-Gm-Message-State: ABy/qLYTuvUujkfa4NFenNrqFsrO9D7Se7vSjmqIdXj5AyuIYP2Dc1Gi
 WuZb7yeu+GyV/HGtAUZYHfp3Ct+vdwrZA+Nq+x3yEHA7hm/kEP5WjwF31h27XcntRmL5Lh39n0V
 q5iu+BOYptQKtAh+oFymfifREyolzzRgbIuSebcpUWppmsTv3Zn5IPX4uqw==
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id
 t126-20020a818384000000b0056d0c9739f4mr1424685ywf.8.1688637709730; 
 Thu, 06 Jul 2023 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnS8DTGuBigSC1cOUEhrHGP3AjZEn+XIDZR976mIx9TGjJA3wYtGsoU6qHdLxp+gcwyMWCUHKwipRzaY/ylEo=
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id
 t126-20020a818384000000b0056d0c9739f4mr1424668ywf.8.1688637709450; Thu, 06
 Jul 2023 03:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704234532.532c8ee7.gary@garyguo.net>
In-Reply-To: <20230704234532.532c8ee7.gary@garyguo.net>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Jul 2023 12:01:38 +0200
Message-ID: <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
Subject: Re: Hyper-V vsock streams do not fill the supplied buffer in full
To: Gary Guo <gary@garyguo.net>, Dexuan Cui <decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

SGkgR2FyeSwKCk9uIFdlZCwgSnVsIDUsIDIwMjMgYXQgMTI6NDXigK9BTSBHYXJ5IEd1byA8Z2Fy
eUBnYXJ5Z3VvLm5ldD4gd3JvdGU6Cj4KPiBXaGVuIGEgdnNvY2sgc3RyZWFtIGlzIGNhbGxlZCB3
aXRoIHJlY3Ztc2cgd2l0aCBhIGJ1ZmZlciwgaXQgb25seSBmaWxscwo+IHRoZSBidWZmZXIgd2l0
aCBkYXRhIGZyb20gdGhlIGZpcnN0IHNpbmdsZSBWTSBwYWNrZXQuIEV2ZW4gaWYgdGhlcmUgYXJl
Cj4gbW9yZSBWTSBwYWNrZXRzIGF0IHRoZSB0aW1lIGFuZCB0aGUgYnVmZmVyIGlzIHN0aWxsIG5v
dCBjb21wbGV0ZWx5Cj4gZmlsbGVkLCBpdCB3aWxsIGp1c3QgbGVhdmUgdGhlIGJ1ZmZlciBwYXJ0
aWFsbHkgZmlsbGVkLgo+Cj4gVGhpcyBjYXVzZXMgc29tZSBpc3N1ZXMgd2hlbiBpbiBXU0xEIHdo
aWNoIHVzZXMgdGhlIHZzb2NrIGluCj4gbm9uLWJsb2NraW5nIG1vZGUgYW5kIHVzZXMgZXBvbGwu
Cj4KPiBGb3Igc3RyZWFtLW9yaWVudGVkIHNvY2tldHMsIHRoZSBlcG9sbCBtYW4gcGFnZSBbMV0g
c2F5cyB0aGF0Cj4KPiA+IEZvciBzdHJlYW0tb3JpZW50ZWQgZmlsZXMgKGUuZy4sIHBpcGUsIEZJ
Rk8sIHN0cmVhbSBzb2NrZXQpLAo+ID4gdGhlIGNvbmRpdGlvbiB0aGF0IHRoZSByZWFkL3dyaXRl
IEkvTyBzcGFjZSBpcyBleGhhdXN0ZWQgY2FuCj4gPiBhbHNvIGJlIGRldGVjdGVkIGJ5IGNoZWNr
aW5nIHRoZSBhbW91bnQgb2YgZGF0YSByZWFkIGZyb20gLwo+ID4gd3JpdHRlbiB0byB0aGUgdGFy
Z2V0IGZpbGUgZGVzY3JpcHRvci4gIEZvciBleGFtcGxlLCBpZiB5b3UKPiA+IGNhbGwgcmVhZCgy
KSBieSBhc2tpbmcgdG8gcmVhZCBhIGNlcnRhaW4gYW1vdW50IG9mIGRhdGEgYW5kCj4gPiByZWFk
KDIpIHJldHVybnMgYSBsb3dlciBudW1iZXIgb2YgYnl0ZXMsIHlvdSBjYW4gYmUgc3VyZSBvZgo+
ID4gaGF2aW5nIGV4aGF1c3RlZCB0aGUgcmVhZCBJL08gc3BhY2UgZm9yIHRoZSBmaWxlIGRlc2Ny
aXB0b3IuCj4KPiBUaGlzIGhhcyBiZWVuIHVzZWQgYXMgYW4gb3B0aW1pc2F0aW9uIGluIHRoZSB3
aWxkIGZvciByZWR1Y2luZyBudW1iZXIKPiBvZiBzeXNjYWxscyByZXF1aXJlZCBmb3Igc3RyZWFt
IHNvY2tldHMgKGJ5IGFzc2VydGluZyB0aGF0IHRoZSBzb2NrZXQKPiB3aWxsIG5vdCBoYXZlIHRv
IHBvbGxlZCB0byBFQUdBSU4gaW4gZWRnZS10cmlnZ2VyIG1vZGUsIGlmIHRoZSBidWZmZXIKPiBn
aXZlbiB0byByZWN2bXNnIGlzIG5vdCBmaWxsZWQgY29tcGxldGVseSkuIEFuIGV4YW1wbGUgaXMg
VG9raW8sIHdoaWNoCj4gc3RhcnRpbmcgaW4gdjEuMjEuMCBbMl0uCj4KPiBXaGVuIHRoaXMgb3B0
aW1pc2F0aW9uIGNvbWJpbmVzIHdpdGggdGhlIGJlaGF2aW91ciBvZiBIeXBlci1WIHZzb2NrLCBp
dAo+IGNhdXNlcyBpc3N1ZSBpbiB0aGlzIHNjZW5hcmlvOgo+ICogdGhlIFZNIGhvc3Qgc2VuZCBk
YXRhIHRvIHRoZSBndWVzdCwgYW5kIGl0J3Mgc3BsaXR0ZWQgaW50byBtdWx0aXBsZQo+ICAgVk0g
cGFja2V0cwo+ICogc2tfZGF0YV9yZWFkeSBpcyBjYWxsZWQgYW5kIGVwb2xsIHJldHVybnMsIG5v
dGlmeWluZyB0aGUgdXNlcnNwYWNlCj4gICB0aGF0IHRoZSBzb2NrZXQgaXMgcmVhZHkKPiAqIHVz
ZXJzcGFjZSBjYWxsIHJlY3Ztc2cgd2l0aCBhIGJ1ZmZlciwgYW5kIGl0J3MgcGFydGlhbGx5IGZp
bGxlZAo+ICogdXNlcnNwYWNlIGFzc3VtZXMgdGhhdCB0aGUgc3RyZWFtIHNvY2tldCBpcyBkZXBs
ZXRlZCwgYW5kIGlmIG5ldyBkYXRhCj4gICBhcnJpdmVzIGVwb2xsIHdpbGwgbm90aWZ5IGl0IGFn
YWluLgo+ICoga2VybmVsIGFsd2F5cyBjb25zaWRlcnMgdGhlIHNvY2tldCB0byBiZSByZWFkeSwg
YW5kIHNpbmNlIGl0J3MgaW4KPiAgIGVkZ2UtdHJpZ2dlciBtb2RlLCB0aGUgZXBvbGwgaW5zdGFu
Y2Ugd2lsbCBuZXZlciBiZSBub3RpZmllZCBhZ2Fpbi4KPgo+IFRoaXMgZGlmZmVyZW50IHJlYWxp
c2F0aW9uIG9mIHRoZSByZWFkaW5lc3MgY2F1c2VzIHRoZSB1c2Vyc3BhY2UgdG8KPiBibG9jayBm
b3JldmVyLgoKVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZGVzY3JpcHRpb24gb2YgdGhlIHByb2Js
ZW0uCgpJIHRoaW5rIHdlIHNob3VsZCBmaXggdGhlIGh2c19zdHJlYW1fZGVxdWV1ZSgpIGluCm5l
dC92bXdfdnNvY2svaHlwZXJ2X3RyYW5zcG9ydC5jLgpXZSBjYW4gZG8gc29tZXRoaW5nIHNpbWls
YXIgdG8gd2hhdCB3ZSBkbyBpbgp2aXJ0aW9fdHJhbnNwb3J0X3N0cmVhbV9kb19kZXF1ZXVlKCkg
aW4KbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jCgpARGV4dWFuIFdEWVQ/
CgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
