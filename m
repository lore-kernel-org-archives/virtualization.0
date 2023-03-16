Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66188C6FD19
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C69261025;
	Thu, 16 Mar 2023 09:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C69261025
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRQUsuLJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDzGv18vr5Cs; Thu, 16 Mar 2023 09:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB20860608;
	Thu, 16 Mar 2023 09:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB20860608
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84D6AC0035;
	Thu, 16 Mar 2023 09:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B91B4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9443F81ED2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9443F81ED2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRQUsuLJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LGzNmbxPKJjK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:31:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F03B281EA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F03B281EA4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678959080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CS1wqtcOK2buYZ6heyq67kcFUemEQNu97cyhCyrzUp4=;
 b=fRQUsuLJR7PqKDq9bQgWwZVPcYGePnrgXZRdC1ZeyK9ozk18wReFusLnQxwU59BfD8bQBc
 mbxTcffrP+bmu8fihosKyfzJ0nfGy+dsu2G4OYWA//dxz8pwv4TkqXBgBb8s3o1p90JX5z
 2l8QaQEKPk1C26Z7CV9KpVa4xb1Th3A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-h45FhyCcM1SiRrlYtJdeGA-1; Thu, 16 Mar 2023 05:31:19 -0400
X-MC-Unique: h45FhyCcM1SiRrlYtJdeGA-1
Received: by mail-oi1-f200.google.com with SMTP id
 bo7-20020a056808228700b00384412d3db5so663736oib.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678959079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CS1wqtcOK2buYZ6heyq67kcFUemEQNu97cyhCyrzUp4=;
 b=dfwkEc5XRQfd1ILJc90Et4RxJ8iafVsnYIr4IFNu19XKy+HEalOQxPJ5bFydw5J4Kv
 A9Cn2JJLpwdN+AGeVIVQ9FymU5hIrhhyB3HwMXQbVB4vQ+7i+fYIRKvcsAoeuZ4ambsW
 eB2CxU6tl62rmcBZPNSq5UimzdprQTe3t7X7HWhlFy7V2z1byykM+4czXMkhCo7zb6R1
 lwrEb7w3ksgIXKVm/tArc6WOApX3MhDS0nrW0KNgG5LiCQq4Sjvusvt73UMTIecaGLnD
 2BNvvCtha1pnpf77/0XSXnUhtv+rXt0Fxsubnx5mgWiPP01ogtpwgqPjbTuVvKd8shMh
 jTsQ==
X-Gm-Message-State: AO0yUKWR/4qgqdNol46o7OEk0geVxdRWlNeOAlx6qYVmAv1E32IQbrck
 aNUh0h3qeQwZma+QE6FUcRWEjCEJcgMA8nG1GRuc5Bvbz3O6CKaEjCRQVES0sHcUM9tP7MzJwZz
 nPC7JmEGqIDsligGIXNan4VIEnjxuYV6TUPMyFi2RQ3HoBJmThIqVub6iXg==
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id
 dq5-20020a056808428500b00383fad30d19mr1815812oib.9.1678959079003; 
 Thu, 16 Mar 2023 02:31:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9pBzOokvEbcx6aOLA28L4vBQN4JkIIhkDIzzehrOEGVuar/34lDJFkgZD2rtlQCkDjH1qP1S+BEyo4gJ/aWZA=
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id
 dq5-20020a056808428500b00383fad30d19mr1815808oib.9.1678959078836; Thu, 16 Mar
 2023 02:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-2-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Mar 2023 17:31:07 +0800
Message-ID: <CACGkMEsak_C1TTdq4PRXx46HHw42hjvcbZM+B_mGS-kJ6AA4eA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] lib/group_cpus: Export group_cpus_evenly()
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

T24gVHVlLCBGZWIgMjgsIDIwMjMgYXQgNTo0MuKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IEV4cG9ydCBncm91cF9jcHVzX2V2ZW5seSgpIHNvIHRo
YXQgc29tZSBtb2R1bGVzCj4gY2FuIG1ha2UgdXNlIG9mIGl0IHRvIGdyb3VwIENQVXMgZXZlbmx5
IGFjY29yZGluZwo+IHRvIE5VTUEgYW5kIENQVSBsb2NhbGl0eS4KPgo+IFNpZ25lZC1vZmYtYnk6
IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGxpYi9ncm91cF9jcHVz
LmMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0
IGEvbGliL2dyb3VwX2NwdXMuYyBiL2xpYi9ncm91cF9jcHVzLmMKPiBpbmRleCA5YzgzN2EzNWZl
ZjcuLmFhM2Y2ODE1YmIxMiAxMDA2NDQKPiAtLS0gYS9saWIvZ3JvdXBfY3B1cy5jCj4gKysrIGIv
bGliL2dyb3VwX2NwdXMuYwo+IEBAIC00MjYsMyArNDI2LDQgQEAgc3RydWN0IGNwdW1hc2sgKmdy
b3VwX2NwdXNfZXZlbmx5KHVuc2lnbmVkIGludCBudW1ncnBzKQo+ICAgICAgICAgcmV0dXJuIG1h
c2tzOwo+ICB9Cj4gICNlbmRpZiAvKiBDT05GSUdfU01QICovCj4gK0VYUE9SVF9TWU1CT0xfR1BM
KGdyb3VwX2NwdXNfZXZlbmx5KTsKPiAtLQo+IDIuMjAuMQo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
