Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF17C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 08:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CF33605EB;
	Tue, 23 Nov 2021 08:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGt-_XeSGZAO; Tue, 23 Nov 2021 08:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0727E6059D;
	Tue, 23 Nov 2021 08:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD05FC001E;
	Tue, 23 Nov 2021 08:20:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0FEDC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE7A740182
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiYf4PAmadGj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:20:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2FA8400C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637655642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7XRq3vNH3PzZeNBVWMZlpinWUJL5ZXviLeVhQetTPs=;
 b=FA7kHmGaHOW4KrA/cFJFnNCYV6yVNlJrGTpDY0q5ExJXkj2EoqpuaC0xnxBLLiGsnZ4ivC
 PdsMTzKQ7B/+6sIXmvtKAnHFWdNYUOqMSs9vk29bedggkN2qKkRyf88eN6KFob6LAxSB8W
 o9Rt6NqfKhEXh/oEiKVlv6D8jO7qsnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-bQi7hsg-NXisQ21kcuKxAA-1; Tue, 23 Nov 2021 03:20:41 -0500
X-MC-Unique: bQi7hsg-NXisQ21kcuKxAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99ED88799E0;
 Tue, 23 Nov 2021 08:20:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 324975DF5E;
 Tue, 23 Nov 2021 08:20:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6B30D1800936; Tue, 23 Nov 2021 09:20:38 +0100 (CET)
Date: Tue, 23 Nov 2021 09:20:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Kvm virtual machine uses virtio graphics card, the rotating
 screen is stuck
Message-ID: <20211123082038.vmoyyqfkd3kvcwhp@sirius.home.kraxel.org>
References: <tencent_38FA65E45E1BD89E5C1965C5@qq.com>
 <CACGkMEv-eZEa1aC+F7-uo_b36q55ar=O-8b_B7Lx7Y-09kKuNQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv-eZEa1aC+F7-uo_b36q55ar=O-8b_B7Lx7Y-09kKuNQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 =?utf-8?B?6Iuf5rWp?= <gouhao@uniontech.com>, mst <mst@redhat.com>
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

T24gVHVlLCBOb3YgMjMsIDIwMjEgYXQgMDM6NDk6MjhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAzOjAwIFBNIOiLn+a1qSA8Z291aGFvQHVuaW9u
dGVjaC5jb20+IHdyb3RlOgo+ID4KPiA+IEhlbGxvLAo+ID4KPiA+IEkgdXNlIGB4cmFuZHIgLW8g
bGVmdGAgdG8gcm90YXRlIHRoZSBzY3JlZW4gaW4gdGhlIGt2bSB2aXJ0dWFsIG1hY2hpbmUuCj4g
PiBXaGVuIGNvbmZpZ3VyZWQgYXMgYSBWaXJ0aW8gZ3JhcGhpY3MgY2FyZCwgdGhlIHNjcmVlbiB3
aWxsIGZyZWV6ZSBhZnRlciByb3RhdGluZyB0aGUgc2NyZWVuLCBhbmQgdGhlIGtleWJvYXJkIGFu
ZCBtb3VzZSB3aWxsIG5vdCByZXNwb25kLgo+ID4gV2hlbiBjb25maWd1cmVkIGFzIGEgVkdBIGdy
YXBoaWNzIGNhcmQsIGl0IGlzIG5vcm1hbCBhZnRlciByb3RhdGluZyB0aGUgc2NyZWVuLgo+ID4K
PiA+IElzIHRoZSBWaXJ0aW8gZ3JhcGhpY3MgY2FyZCBub3Qgc3VwcG9ydGluZyByb3RhdGluZz8K
PiAKPiBBZGRpbmcgbGlzdCBhbmQgR2VyZCBmb3IgdGhlIGFuc3dlci4KCkhtbSBkdW5uby4gIE5l
dmVyIHRyaWVkIHRoYXQuICBDYW4ndCBzZWUgYW4gb2J2aW91cyByZWFzb24gd2h5IHZpcnRpbwpz
aG91bGQgc2hvdyBkaWZmZXJlbnQgYmVoYXZpb3IgdGhhbiBzdGR2Z2EsIHNvIHByb2JhYmx5IGEg
YnVnIHNvbWV3aGVyZS4KCkknbSB3b25kZXJpbmcgd2h5IHlvdSB3YW50IHJvdGF0ZSB0aGUgc2Ny
ZWVuIGluIHRoZSBmaXJzdCBwbGFjZSB0aG91Z2guCllvdSBjYW4gYWRkIGFueSByZXNvbHV0aW9u
IHlvdSB3YW50IHVzaW5nIHhyYW5kciwgaW5jbHVkaW5nIHBvcnRyYWl0Cm1vZGVzIGxpa2UgNzY4
eDEwMjQgLi4uCgp0YWtlIGNhcmUsCiAgR2VyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gY3V0IGhlcmUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMhL2Jpbi9zaAoKd2lkdGg9IiQx
IgpoZWlnaHQ9IiQyIgoKaWYgdGVzdCAiJHdpZHRoIiA9ICIiIC1vICIkaGVpZ2h0IiA9ICIiOyB0
aGVuCgllY2hvICJ1c2FnZTogJDAgd2lkdGggaGVpZ2h0IgoJZXhpdCAxCmZpCgpvdXRwdXQ9JCh4
cmFuZHIgLS1xdWVyeSB8IGF3ayAnLyBjb25uZWN0ZWQvIHsgcHJpbnQgJDE7IGV4aXQgfScpCm1v
ZGU9IiR7d2lkdGh9eCR7aGVpZ2h0fSIKZWNobyAiIyBzZXR0aW5nIG1vZGUgJG1vZGUgb24gb3V0
cHV0ICRvdXRwdXQiCgppZiB4cmFuZHIgLS1xdWVyeSB8IGdyZXAgLXEgLWUgIiAkbW9kZSAiOyB0
aGVuCgl0cnVlICMgbW9kZSBhbHJlYWR5IHRoZXJlCmVsc2UKCW1vZGVsaW5lPSQoY3Z0ICR3aWR0
aCAkaGVpZ2h0IHwgZ3JlcCBNb2RlbGluZSB8IGN1dCAtZCIgIiAtZjMtKQoJKHNldCAteDsgeHJh
bmRyIC0tbmV3bW9kZSAiJG1vZGUiICRtb2RlbGluZTsKCQkgeHJhbmRyIC0tYWRkbW9kZSAiJG91
dHB1dCIgIiRtb2RlIikKZmkKKHNldCAteDsgeHJhbmRyIC0tb3V0cHV0ICIkb3V0cHV0IiAtLW1v
ZGUgIiRtb2RlIikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
