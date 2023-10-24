Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD2C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 04:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7F6E42468;
	Tue, 24 Oct 2023 04:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7F6E42468
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWhIzqxE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8pMIL1-WWJy; Tue, 24 Oct 2023 04:45:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A38ED40193;
	Tue, 24 Oct 2023 04:45:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A38ED40193
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71B5CC0071;
	Tue, 24 Oct 2023 04:45:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9E9FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4472421E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4472421E0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MWhIzqxE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqu1B--4IZQk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:45:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E953421B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E953421B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698122702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6wKDdkCVWVI+YJGwvEF7/3p32/fl+T2zF7AbVVtpxE=;
 b=MWhIzqxEZh57IDJBmx5QS2YhhpnTFcZ1FLZappF9KfK2NgVd7d5KbQDzvqM36L89QZdWSm
 4YqapIKku+Skf8eK6S4pD+qDrjggeb0gCvRJLLEakHWxq+eY9Zw6pHk1unc9BBZuxosCBW
 KZn9wDonBoMIpZVjk7+GRmRVRZWDIi8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-swFR0GJ9NticvFnHLvJf1A-1; Tue, 24 Oct 2023 00:45:00 -0400
X-MC-Unique: swFR0GJ9NticvFnHLvJf1A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507cee14477so4155357e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 21:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698122699; x=1698727499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6wKDdkCVWVI+YJGwvEF7/3p32/fl+T2zF7AbVVtpxE=;
 b=Ru/Wu49Rx6BIemPqA6Wd1Ak7EKioGQxKejgkf+xaHRpa2bGqu7QyoEPFOUnXuoDPls
 SFEzRPhZSKDKBxcvar9oQi+RtP2ZnGHdlSdDvMVMOlHUMS1DfS4l4yIwvXz4R2S36gps
 C45FevOuiX9Z7fGK2eVJ2l14bOIBRBI65ZCNynuas2ZmOO9EFSxF2hdKoKTDdcFvoQ9y
 CpGXubwiJUsSLesoVg2XIFduas2EqEsGdeesVqfx6a8gqNn5u/KbwVmCUIdy9fi4oTTY
 yHAhGu6navvZhPrUfCE8LPQfs1F5/DIVqoAAoXajFKGp1jq6o3Nht8DW1QZck7rmrnA8
 oGiA==
X-Gm-Message-State: AOJu0YwT4zTpffp69cXH9IS3ZHaXRr8j4LLTKEUC8xF5M/E2+8cDb1oa
 n+DjeHe2HIhXzShnMwoZnyfCD2fMOOeMGycorGsPYIF9h1jlzHA9pQ5svb6EojtZssuyrxd7UYy
 J4CWezyQVUm/zCpzEQ4Ssrd2Wy+xditlwVX5sk2QVB2PTjZJ2lS4KYgl9xg==
X-Received: by 2002:ac2:48ac:0:b0:503:2e6:6862 with SMTP id
 u12-20020ac248ac000000b0050302e66862mr7717002lfg.32.1698122699054; 
 Mon, 23 Oct 2023 21:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdEbyvQwDHVj3MFSMFvxMf8SZFaaIUF0Bce0KCFOSPWwogHByPw2z1aoaFc1EveRwVlf/73Ooq22G7ATU18dM=
X-Received: by 2002:ac2:48ac:0:b0:503:2e6:6862 with SMTP id
 u12-20020ac248ac000000b0050302e66862mr7716995lfg.32.1698122698696; Mon, 23
 Oct 2023 21:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKhg4tKSWLood9aFo7r1j-a3sXvf+WraFV_xUcKOMLq9sxrPXA@mail.gmail.com>
In-Reply-To: <CAKhg4tKSWLood9aFo7r1j-a3sXvf+WraFV_xUcKOMLq9sxrPXA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Oct 2023 12:44:47 +0800
Message-ID: <CACGkMEufrJfM7bw7s76gq_3S5oSgx4w5KjxO_oReMg34bCy5hA@mail.gmail.com>
Subject: Re: [RFC] vhost: vmap virtio descriptor table kernel/kvm
To: Liang Chen <liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMTE6MTfigK9BTSBMaWFuZyBDaGVuIDxsaWFuZ2NoZW4u
bGludXhAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoZSBjdXJyZW50IHZob3N0IGNvZGUgdXNlcyAn
Y29weV9mcm9tX3VzZXInIHRvIGNvcHkgZGVzY3JpcHRvcnMgZnJvbQo+IHVzZXJzcGFjZSB0byB2
aG9zdC4gV2UgYXR0ZW1wdGVkIHRvICd2bWFwJyB0aGUgZGVzY3JpcHRvciB0YWJsZSB0bwo+IHJl
ZHVjZSB0aGUgb3ZlcmhlYWQgYXNzb2NpYXRlZCB3aXRoICdjb3B5X2Zyb21fdXNlcicgZHVyaW5n
IGRlc2NyaXB0b3IKPiBhY2Nlc3MsIGJlY2F1c2UgaXQgY2FuIGJlIGFjY2Vzc2VkIHF1aXRlIGZy
ZXF1ZW50bHkuIFRoaXMgY2hhbmdlCj4gcmVzdWx0ZWQgaW4gYSBtb2RlcmF0ZSBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudCAoYXBwcm94aW1hdGVseSAzJSkgaW4KPiBvdXIgcGt0Z2VuIHRlc3QsIGFz
IHNob3duIGJlbG93LiBBZGRpdGlvbmFsbHksIHRoZSBsYXRlbmN5IGluIHRoZQo+ICd2aG9zdF9n
ZXRfdnFfZGVzYycgZnVuY3Rpb24gc2hvd3MgYSBub3RpY2VhYmxlIGRlY3JlYXNlLgo+Cj4gY3Vy
cmVudCBjb2RlOgo+ICAgICAgICAgICAgICAgICBJRkFDRSAgIHJ4cGNrL3MgICB0eHBjay9zICAg
IHJ4a0IvcyAgICB0eGtCL3MKPiByeGNtcC9zICAgdHhjbXAvcyAgcnhtY3N0L3MgICAlaWZ1dGls
Cj4gQXZlcmFnZTogICAgICAgIHZuZXQwICAgICAgMC4zMSAxMzMwODA3LjAzICAgICAgMC4wMiAg
Nzc5NzYuOTgKPiAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICA2LjM5Cj4gIyAvdXNyL3No
YXJlL2JjYy90b29scy9mdW5jbGF0ZW5jeSAtZCAxMCB2aG9zdF9nZXRfdnFfZGVzYwo+IGF2ZyA9
IDE0NSBuc2VjcywgdG90YWw6IDE0NTU5ODAzNDEgbnNlY3MsIGNvdW50OiA5OTg1MjI0Cj4KPiB2
bWFwOgo+ICAgICAgICAgICAgICAgICBJRkFDRSAgIHJ4cGNrL3MgICB0eHBjay9zICAgIHJ4a0Iv
cyAgICB0eGtCL3MKPiByeGNtcC9zICAgdHhjbXAvcyAgcnhtY3N0L3MgICAlaWZ1dGlsCj4gQXZl
cmFnZTogICAgICAgIHZuZXQwICAgICAgMC4wNyAxMzcxODcwLjQ5ICAgICAgMC4wMCAgODAzODMu
MDQKPiAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICA2LjU4Cj4gIyAvdXNyL3NoYXJlL2Jj
Yy90b29scy9mdW5jbGF0ZW5jeSAtZCAxMCB2aG9zdF9nZXRfdnFfZGVzYwo+IGF2ZyA9IDEyMiBu
c2VjcywgdG90YWw6IDEyODY5ODM5MjkgbnNlY3MsIGNvdW50OiAxMDQ3ODEzNAo+Cj4gV2UgYXJl
IHVuY2VydGFpbiBpZiB0aGVyZSBhcmUgYW55IGFzcGVjdHMgd2UgbWF5IGhhdmUgb3Zlcmxvb2tl
ZCBhbmQKPiB3b3VsZCBhcHByZWNpYXRlIGFueSBhZHZpY2UgYmVmb3JlIHdlIHN1Ym1pdCBhbiBh
Y3R1YWwgcGF0Y2guCgpTbyB0aGUgaWRlYSBpcyB0byB1c2UgYSBzaGFkb3cgcGFnZSB0YWJsZSBp
bnN0ZWFkIG9mIHRoZSB1c2Vyc3BhY2Ugb25lCnRvIGF2b2lkIHRoaW5ncyBsaWtlIHNwZWMgYmFy
cmllcnMgb3IgU01BUC4KCkkndmUgdHJpZWQgdGhpcyBpbiB0aGUgcGFzdDoKCmNvbW1pdCA3ZjQ2
NjAzMmRjOWU1YTYxMjE3ZjIyZWEzNGIyZGY5MzI3ODZiYmZjIChIRUFEKQpBdXRob3I6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkRhdGU6ICAgRnJpIE1heSAyNCAwNDoxMjoxOCAy
MDE5IC0wNDAwCgogICAgdmhvc3Q6IGFjY2VzcyB2cSBtZXRhZGF0YSB0aHJvdWdoIGtlcm5lbCB2
aXJ0dWFsIGFkZHJlc3MKCiAgICBJdCB3YXMgbm90aWNlZCB0aGF0IHRoZSBjb3B5X3RvL2Zyb21f
dXNlcigpIGZyaWVuZHMgdGhhdCB3YXMgdXNlZCB0bwogICAgYWNjZXNzIHZpcnRxdWV1ZSBtZXRk
YXRhIHRlbmRzIHRvIGJlIHZlcnkgZXhwZW5zaXZlIGZvciBkYXRhcGxhbmUKICAgIGltcGxlbWVu
dGF0aW9uIGxpa2Ugdmhvc3Qgc2luY2UgaXQgaW52b2x2ZXMgbG90cyBvZiBzb2Z0d2FyZSBjaGVj
a3MsCiAgICBzcGVjdWxhdGlvbiBiYXJyaWVycywgaGFyZHdhcmUgZmVhdHVyZSB0b2dnbGluZyAo
ZS5nIFNNQVApLiBUaGUKICAgIGV4dHJhIGNvc3Qgd2lsbCBiZSBtb3JlIG9idmlvdXMgd2hlbiB0
cmFuc2ZlcnJpbmcgc21hbGwgcGFja2V0cyBzaW5jZQogICAgdGhlIHRpbWUgc3BlbnQgb24gbWV0
YWRhdGEgYWNjZXNzaW5nIGJlY29tZSBtb3JlIHNpZ25pZmljYW50LgouLi4KCk5vdGUgdGhhdCBp
dCB0cmllcyB0byB1c2UgYSBkaXJlY3QgbWFwIGluc3RlYWQgb2YgYSBWTUFQIGFzIEFuZHJlYQpz
dWdnZXN0cy4gQnV0IGl0IGxlZCB0byBzZXZlcmFsIGZhbGxvdXRzIHdoaWNoIHdlcmUgdHJpY2t5
IHRvIGJlCmZpeGVkWzFdIChsaWtlIHRoZSB1c2Ugb2YgTU1VIG5vdGlmaWVycyB0byBkbyBzeW5j
aHJvbml6YXRpb24pLiBTbyBpdAppcyByZXZlcnRlZCBmaW5hbGx5LgoKSSdtIG5vdCBzYXlpbmcg
aXQncyBhIGRlYWQgZW5kLiBCdXQgd2UgbmVlZCB0byBmaW5kIGEgd2F5IHRvIHNvbHZlIHRoZQpp
c3N1ZXMgb3IgdXNlIHNvbWV0aGluZyBkaWZmZXJlbnQuIEknbSBoYXBweSB0byBvZmZlciBoZWxw
LgoKMSkgQXZvaWQgdXNpbmcgU01BUCBmb3Igdmhvc3Qga3RocmVhZCwgZm9yIGV4YW1wbGUgdXNp
bmcgc2hlZApub3RpZmllciwgSSdtIG5vdCBzdXJlIHRoaXMgaXMgcG9zc2libGUgb3Igbm90CjIp
IEEgbmV3IGlvdiBpdGVyYXRvciB0aGF0IGRvZXNuJ3QgZG8gU01BUCBhdCBhbGwsIHRoaXMgbG9v
a3MKZGFuZ2Vyb3VzIGFuZCBBbCBtaWdodCBub3QgbGlrZSBpdAozKSAoUmUpdXNpbmcgSE1NCi4u
LgoKWW91IG1heSB3YW50IHRvIHNlZSBhcmNoaXZlcyBmb3IgbW9yZSBpbmZvcm1hdGlvbi4gV2Un
dmUgaGFkIGEgbG90IG9mCmRpc2N1c3Npb25zLgoKVGhhbmtzCgpbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDE5MDczMTA4NDY1NS43MDI0LTEtamFzb3dhbmdAcmVkaGF0LmNvbS8K
Cj4KPgo+IFRoYW5rcywKPiBMaWFuZwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
