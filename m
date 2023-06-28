Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14432EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 08:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FDA0409AD;
	Wed, 28 Jun 2023 08:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FDA0409AD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=URtF3tLw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g7r7_SeRfoL1; Wed, 28 Jun 2023 08:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB19B409A4;
	Wed, 28 Jun 2023 08:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB19B409A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8277EC0072;
	Wed, 28 Jun 2023 08:04:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE77BC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84BF8813EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84BF8813EE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=URtF3tLw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8t85hFDfu3dC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB1F5813E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB1F5813E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687939437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofwo3P8uKOaWvV1X+hYEb8hA8CV2BceFbJ10PxbVumI=;
 b=URtF3tLwdRM9WJ6bcSTsm/l4hb6vbR5AyxDqReXTFl5m7R4rBDT2tlYu0Ujh0WOPMgRUwZ
 5ApN4Po9BmxkLCZNa1evqVi07B7mEfyNAE4On2wPSX2VNNcmKJnWCdho0q2hFJ78P0s3w7
 YAklYPmDTWkCxNPFGQ6TLdW1rdo2svw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-0huYTOAHM-S-E6YDdj8_Jw-1; Wed, 28 Jun 2023 04:03:53 -0400
X-MC-Unique: 0huYTOAHM-S-E6YDdj8_Jw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb3f3a87d4so452288e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687939432; x=1690531432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofwo3P8uKOaWvV1X+hYEb8hA8CV2BceFbJ10PxbVumI=;
 b=kOKD0P9CT+2S+nALbgy+svegGwxgWtyOw4B/5saUuQow2ZZKwiOdixcru8UrmjPhPk
 OrAgr/UOQa23Aj842S3Fnnocm1txSNFgtYoCMV1Ar+33FGCg8kHMUtGdd1OoX7PWbMLH
 LMu3CjCwGDzRcnkWgcgs5alGq239uX1GERk6+DCncoc89F1hb3x91dg78ssC7NevdLU2
 vVc529HIxQGO7/JlCb8orSzBmBxKzFwExzqex8OkZ2U3c5p2igL+9aCFT+0jDICrGU4Q
 bNoizWUMhlUO8+Z+crWlQZ//kswzRYfIYCwJSojZMXEaLw4NRFuOe6a+bT+IN9jz2Mhb
 jFhg==
X-Gm-Message-State: AC+VfDxNEoMw5XTcrsCHdRP047Lrd0igkFE7tmbdiZfvEIliJX4sP9u8
 N4kuowKDEJUmg8jMiXLzMI0U+J+5HnEZObIRkyuOGQZkFoh2sdA32Dp5EJdZ7BmInVDFWsrchFC
 YDpTSSKjA9XDmOBC8g6NraMU8wk1a0B7e8oG/b3foQIh4koE6BaSnM8lojQ==
X-Received: by 2002:a05:6512:2828:b0:4f8:75d5:e14f with SMTP id
 cf40-20020a056512282800b004f875d5e14fmr206452lfb.28.1687939432276; 
 Wed, 28 Jun 2023 01:03:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+VHNhq6OsMLyItLK9e1q5NqGMrmykMJR0HIs4eAUBTfGZ9IUjxcd7L2s5r2cSDn4Ra3WnvvHrOmw346uihVA=
X-Received: by 2002:a05:6512:2828:b0:4f8:75d5:e14f with SMTP id
 cf40-20020a056512282800b004f875d5e14fmr206443lfb.28.1687939431925; Wed, 28
 Jun 2023 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-2-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 16:03:40 +0800
Message-ID: <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, maxime.coquelin@redhat.com
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

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMjo1OeKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gRnJvbTogWW91ciBOYW1lIDx5b3VAZXhhbXBsZS5jb20+CgpJdCBsb29r
cyB0byBtZSB5b3VyIGdpdCBpcyBub3QgcHJvcGVybHkgY29uZmlndXJlZC4KCj4KPiB0aGlzIHN0
cnVjdCBpcyB0byBzYXZlIHRoZSByZWNvbm5lY3QgaW5mbyBzdHJ1Y3QsIGluIHRoaXMKPiBzdHJ1
Y3Qgc2F2ZWQgdGhlIHBhZ2UgaW5mbyB0aGF0IGFsbG9jIHRvIHNhdmUgdGhlCj4gcmVjb25uZWN0
IGluZm8KPgo+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA3ICsrKysrKysKPiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jCj4gaW5kZXggMjZiN2UyOWNiOTAwLi5mODQ1ZGM0NmIxZGIgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtNzIsNiArNzIsMTIgQEAgc3RydWN0IHZkdXNlX3VtZW0g
ewo+ICAgICAgICAgc3RydWN0IHBhZ2UgKipwYWdlczsKPiAgICAgICAgIHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tOwo+ICB9Owo+ICtzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyB7Cj4gKyAgICAgICB1
MzIgaW5kZXg7Cj4gKyAgICAgICBwaHlzX2FkZHJfdCBhZGRyOwo+ICsgICAgICAgdW5zaWduZWQg
bG9uZyB2YWRkcjsKPiArICAgICAgIHBoeXNfYWRkcl90IHNpemU7Cj4gK307CgpQbGVhc2UgYWRk
IGNvbW1lbnRzIHRvIGV4cGxhaW4gZWFjaCBmaWVsZC4gQW5kIEkgdGhpbmsgdGhpcyBzaG91bGQg
YmUKYSBwYXJ0IG9mIHVBUEk/CgpUaGFua3MKCj4KPiAgc3RydWN0IHZkdXNlX2RldiB7Cj4gICAg
ICAgICBzdHJ1Y3QgdmR1c2VfdmRwYSAqdmRldjsKPiBAQCAtMTA2LDYgKzExMiw3IEBAIHN0cnVj
dCB2ZHVzZV9kZXYgewo+ICAgICAgICAgdTMyIHZxX2FsaWduOwo+ICAgICAgICAgc3RydWN0IHZk
dXNlX3VtZW0gKnVtZW07Cj4gICAgICAgICBzdHJ1Y3QgbXV0ZXggbWVtX2xvY2s7Cj4gKyAgICAg
ICBzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyByZWNvbm5lY3RfaW5mb1s2NF07Cj4gIH07Cj4K
PiAgc3RydWN0IHZkdXNlX2Rldl9tc2cgewo+IC0tCj4gMi4zNC4zCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
