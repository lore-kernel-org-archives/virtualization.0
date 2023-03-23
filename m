Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C22AC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 02:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DCD16140B;
	Thu, 23 Mar 2023 02:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DCD16140B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNT2x2zK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7IRQeL7R991; Thu, 23 Mar 2023 02:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20B79605D5;
	Thu, 23 Mar 2023 02:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20B79605D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2940C0071;
	Thu, 23 Mar 2023 02:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E007C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3980982259
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3980982259
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eNT2x2zK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qodMh-KGu_vp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FDA38226F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FDA38226F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/qsCFMvtGzxMwDlZlcV3X7hKMuAnwRu2Ss4FRo2KMA=;
 b=eNT2x2zKIM4aF1j4ms6tzQ3had7ebmfp48A7cBuaAQ998GTQnOCWDF+Ho3BaT0fOO7pR5C
 5j6eMJGU/A9kQYM3l6S1QkPIi4ApLCkKPsvxKUEVLrnJes7fH3JfrtqzJuTIyT/OvZ2Y3M
 QcnJDPDWnEPVpjERnb34LKLw5FQn5Fc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-EicX06GROySYDMaGcN5ylg-1; Wed, 22 Mar 2023 22:56:10 -0400
X-MC-Unique: EicX06GROySYDMaGcN5ylg-1
Received: by mail-ot1-f70.google.com with SMTP id
 q6-20020a05683022c600b0069f96cb2758so1742787otc.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 19:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/qsCFMvtGzxMwDlZlcV3X7hKMuAnwRu2Ss4FRo2KMA=;
 b=oZ+sXk9U8isPvnzta+s8ntRQQkvlaDENgNzaupRkcEnwiW46XwVIlUNIJlup5RWgKj
 UJPb2my8cDaF8TphZ1rt7A96yBZq0rYaVmBqeLkcqvoIm2vSPQn1D1LolYhnZQJtE3Ff
 Ip6CkPYOmiOGTcYuj7+HvzDNOMETBz23WM0EF5m7jj1uOxQ0P8SqUbRQRDN3V540x+cn
 3+c7Wzv/yWl+egs/ssdDJ/W7alH54rKhVkqleDn2nubaW1cTz1LBMDmQU3PFDeZ+dSuH
 HhmrLDHh/64hndzX424AD95d0DGLlvKy11V6hv07eQTSVYhgxEOZRZXo+GKnQk7MclcI
 mzrw==
X-Gm-Message-State: AO0yUKX6+5bO3HeYsXHesg7Vy0N57Vex3+B5pm+jqlFo3EJU0+UPKoHN
 dVfLSsJ5P9PpwjgmirPXO+iGvRr5o+gKvIz8QKNECCO2vO1UzqGswqxhYRSMvL2Dalmzb/sBzQY
 pv6FQWCD14m2+IzDgbBW+ofOyl2r4HZJ5lwO1r6eRh5PlSnzRp6u0w8Tqig==
X-Received: by 2002:a05:6808:1a1d:b0:383:fef9:6cac with SMTP id
 bk29-20020a0568081a1d00b00383fef96cacmr1787189oib.9.1679540169612; 
 Wed, 22 Mar 2023 19:56:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set9noyAsjOH96uOfUq4CF3ag8Nl5EVp7ceqxb/wR9F7JpBkcqtVxS/4IGqLCOKbCtujc3yR7SWmrEopJqMgLe0k=
X-Received: by 2002:a05:6808:1a1d:b0:383:fef9:6cac with SMTP id
 bk29-20020a0568081a1d00b00383fef96cacmr1787183oib.9.1679540169378; Wed, 22
 Mar 2023 19:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
 <20230322025701.2955-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230322025701.2955-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 10:55:58 +0800
Message-ID: <CACGkMEtzkRZ8n4GVnzApBNwTUcWZETZiGo4bq3598WLu-NanWQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/11] virtio_ring: packed-indirect: separate dma
 codes
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMTA6NTfigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IERNQS1yZWxhdGVkIGxvZ2ljIGlzIHNlcGFyYXRl
ZCBmcm9tIHRoZSB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZCgpLgo+Cj4gRE1BIGFkZHJl
c3Mgd2lsbCBiZSBzYXZlZCBhcyBzZy0+ZG1hX2FkZHJlc3MsIHRoZW4KPiB2aXJ0cXVldWVfYWRk
X2luZGlyZWN0X3BhY2tlZCgpIHdpbGwgdXNlIGl0IGRpcmVjdGx5LiBVbm1hcCBvcGVyYXRpb24K
PiB3aWxsIGJlIHNpbXBsZXIuCj4KPiBUaGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvIGZhY2lsaXRh
dGUgc3Vic2VxdWVudCBzdXBwb3J0IHRvIHJlY2VpdmUKPiBkbWEgYWRkcmVzcyBtYXBwZWQgYnkg
ZHJpdmVycy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKCj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNyArKysrKyst
LS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDQyZThjOWQ0NDE2MS4uYzhlZDRhZWY5
NDYyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTEzMTQsNyArMTMxNCw3IEBAIHN0YXRp
YyBpbnQgdmlydHF1ZXVlX2FkZF9pbmRpcmVjdF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqZGVzYzsKPiAg
ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2c7Cj4gLSAgICAgICB1bnNpZ25lZCBpbnQgaSwg
biwgZXJyX2lkeDsKPiArICAgICAgIHVuc2lnbmVkIGludCBpLCBuOwo+ICAgICAgICAgdTE2IGhl
YWQsIGlkOwo+ICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+Cj4gQEAgLTEzMzQsMTYgKzEzMzQs
MTQgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwKPiAgICAgICAgIGlkID0gdnEtPmZyZWVfaGVhZDsKPiAgICAgICAg
IEJVR19PTihpZCA9PSB2cS0+cGFja2VkLnZyaW5nLm51bSk7Cj4KPiArICAgICAgIGlmICh2aXJ0
cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKSkKPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gKwo+ICAgICAgICAgZm9yIChuID0gMDsgbiA8
IG91dF9zZ3MgKyBpbl9zZ3M7IG4rKykgewo+ICAgICAgICAgICAgICAgICBmb3IgKHNnID0gc2dz
W25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+IC0gICAgICAgICAgICAgICAgICAgICAgIGFk
ZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfVE9fREVWSUNFIDogRE1BX0ZST01fREVW
SUNFKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2
cSwgYWRkcikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3Jl
bGVhc2U7Cj4gLQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NbaV0uZmxhZ3MgPSBjcHVf
dG9fbGUxNihuIDwgb3V0X3NncyA/Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMCA6IFZSSU5HX0RFU0NfRl9XUklURSk7Cj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgZGVzY1tpXS5hZGRyID0gY3B1X3RvX2xlNjQoYWRkcik7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZGVzY1tpXS5hZGRyID0gY3B1X3RvX2xlNjQodnJpbmdfc2dfYWRkcmVzcyhz
ZykpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NbaV0ubGVuID0gY3B1X3RvX2xlMzIo
c2ctPmxlbmd0aCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaSsrOwo+ICAgICAgICAgICAg
ICAgICB9Cj4gQEAgLTE0MDcsMTAgKzE0MDUsNyBAQCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRf
aW5kaXJlY3RfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgcmV0
dXJuIDA7Cj4KPiAgdW5tYXBfcmVsZWFzZToKPiAtICAgICAgIGVycl9pZHggPSBpOwo+IC0KPiAt
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBlcnJfaWR4OyBpKyspCj4gLSAgICAgICAgICAgICAgIHZy
aW5nX3VubWFwX2Rlc2NfcGFja2VkKHZxLCAmZGVzY1tpXSk7Cj4gKyAgICAgICB2aXJ0cXVldWVf
dW5tYXBfc2dzKHZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpOwo+Cj4gICAgICAg
ICBrZnJlZShkZXNjKTsKPgo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
