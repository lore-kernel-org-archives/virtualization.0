Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E78C77B7C
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 03:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13E0840383;
	Fri,  5 May 2023 03:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13E0840383
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dryACXac
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xvj6w6wsNhys; Fri,  5 May 2023 03:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ABDC140278;
	Fri,  5 May 2023 03:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABDC140278
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76362C0037;
	Fri,  5 May 2023 03:28:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 441BDC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A7D860BD7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A7D860BD7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dryACXac
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPe0Z-s2QKNr
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:28:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA4A60BB3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEA4A60BB3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683257320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtGTOV4w8H+HmedJBYfP7zUt+D2uJS6ykp/9DQHbib8=;
 b=dryACXacK7uRTKssh7c0+0kPyq98/16rMWUDDJN0uK544AaCTYl0xBMoaWwgq5+tgwdJg1
 X1y3t0Nr2id7zbVmFH2bBCsFdYo1Yx5M3yAsUqvC9UEh5CvgWUWVeEk2UFEbVAqXI+rbiv
 niNCZjxuq4DAduFREy+zIzzRpuLQWdk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-squpGq42P5KD1GnYwsa_oA-1; Thu, 04 May 2023 23:28:38 -0400
X-MC-Unique: squpGq42P5KD1GnYwsa_oA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f002e0e567so691779e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 May 2023 20:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683257317; x=1685849317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtGTOV4w8H+HmedJBYfP7zUt+D2uJS6ykp/9DQHbib8=;
 b=dj+WQUlAyLdhvHcdwe5oXjNnXOeio2uMo8CXvC0MYQlLAWZvjedjVTfgH6Y90Z4cXd
 RXMh3pJ4CTNvZ5b8zVqAmiPI5/OPaoJXSxeVs2Jghc8TyikPnn5dJcJLO+VhOPL2MGtY
 k0srcPRoWH9cAMkP3kb6VQNMpE4CrRfav5y87XBlQGpFN6CWsNbxh0liF5idtqRbgdx9
 M0z/kUhCUiHv66K+BeXvlj3aEj5Uxxw5gGA/G4yanLsYtpidJ6UGOy6NeIRpxgQztAwa
 pRrK4+EZpxn6iDNLatjgEcu2zSDziIcG2gGm9XKtykZDvA0iCpRm/8Um0t/mKGFDIY+L
 SKjQ==
X-Gm-Message-State: AC+VfDxMxcATobyOQ6z0ElvIa80Lb2smITTB4cbVYe9LCrU1rKSdAUJf
 pf47/7fcYqFpYLqtsZ2Tsj/LF5xR6VYsk0sp6LwuwhSzrlTQwEyCCz9LDkf67N8FOXPTlnjHQzs
 Xwv6jbJIifSQbFM4bvcSTLnL0M60qju3EmD8R+iwtGUkE5W0zo97Ch2buKg==
X-Received: by 2002:ac2:4d1a:0:b0:4ec:363a:5f24 with SMTP id
 r26-20020ac24d1a000000b004ec363a5f24mr132439lfi.23.1683257317337; 
 Thu, 04 May 2023 20:28:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ipOT60VlicZnRmQ8NuJpg74uxqB+3AiqJuLc3hm+sdWRslDFolnCBok9HRcDycod3TakBwcUmh99tPZ15x4I=
X-Received: by 2002:ac2:4d1a:0:b0:4ec:363a:5f24 with SMTP id
 r26-20020ac24d1a000000b004ec363a5f24mr132425lfi.23.1683257317049; Thu, 04 May
 2023 20:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
In-Reply-To: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 May 2023 11:28:25 +0800
Message-ID: <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengqi.arch@bytedance.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBNYXkgNCwgMjAyMyBhdCAxMDoyN+KAr0FNIFdlbmxpYW5nIFdhbmcKPHdhbmd3ZW5s
aWFuZy4xOTk1QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gRm9yIG11bHRpLXF1ZXVlIGFuZCBs
YXJnZSByaW5nLXNpemUgdXNlIGNhc2UsIHRoZSBmb2xsb3dpbmcgZXJyb3IKPiBvY2N1cnJlZCB3
aGVuIGZyZWVfdW51c2VkX2J1ZnM6Cj4gcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3Rl
ZCBzdGFsbCBvbiBDUFUuCj4KPiBGaXhlczogOTg2YTRmNGQ0NTJkICgidmlydGlvX25ldDogbXVs
dGlxdWV1ZSBzdXBwb3J0IikKPiBTaWduZWQtb2ZmLWJ5OiBXZW5saWFuZyBXYW5nIDx3YW5nd2Vu
bGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPgo+IC0tLQo+IHYyOgo+IC1hZGQgbmVlZF9yZXNjaGVk
IGNoZWNrLgo+IC1hcHBseSBzYW1lIGxvZ2ljIHRvIHNxLgo+IHYzOgo+IC11c2UgY29uZF9yZXNj
aGVkIGluc3RlYWQuCj4gdjQ6Cj4gLWFkZCBmaXhlcyB0YWcKPiAtLS0KPiAgZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggOGQ4MDM4NTM4ZmM0Li5hMTJhZTI2ZGIwZTIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTM1NjAsMTIgKzM1NjAsMTQgQEAgc3RhdGljIHZvaWQgZnJlZV91bnVzZWRfYnVm
cyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRx
dWV1ZSAqdnEgPSB2aS0+c3FbaV0udnE7Cj4gICAgICAgICAgICAgICAgIHdoaWxlICgoYnVmID0g
dmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkKPiAgICAgICAgICAgICAg
ICAgICAgICAgICB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1Zih2cSwgYnVmKTsKPiArICAgICAg
ICAgICAgICAgY29uZF9yZXNjaGVkKCk7CgpEb2VzIHRoaXMgcmVhbGx5IGFkZHJlc3MgdGhlIGNh
c2Ugd2hlbiB0aGUgdmlydHF1ZXVlIGlzIHZlcnkgbGFyZ2U/CgpUaGFua3MKCj4gICAgICAgICB9
Cj4KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsK
PiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2aS0+cnFbaV0udnE7Cj4g
ICAgICAgICAgICAgICAgIHdoaWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVm
KHZxKSkgIT0gTlVMTCkKPiAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0bmV0X3JxX2ZyZWVf
dW51c2VkX2J1Zih2cSwgYnVmKTsKPiArICAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4g
ICAgICAgICB9Cj4gIH0KPgo+IC0tCj4gMi4yMC4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
