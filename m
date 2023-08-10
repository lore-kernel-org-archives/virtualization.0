Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16386C001B0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 09:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A329441A42;
	Thu, 10 Aug 2023 09:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A329441A42
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCqHvLZl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vLlAOND6z6c; Thu, 10 Aug 2023 09:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 701FE4194E;
	Thu, 10 Aug 2023 09:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 701FE4194E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48620C0072;
	Thu, 10 Aug 2023 09:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5AAAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 09:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B93D419D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 09:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B93D419D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5kfYxoomBi_D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 09:00:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E66E4194E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 09:00:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E66E4194E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691657999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nKyPrvxOKqENhpjoZF1fWfducNpAl/tgriHmOVfHW4=;
 b=eCqHvLZl+v3uJfy9v1F1PGbY2325LbSeGQQGE3iJPpN/9UMG43aC/PxzLla3fHgaGG8Mf1
 ePHSmZ5GS51We67Io7JRoeWdZS0KYPgMpp8u0nR9U1h8TXxV/zJKeVadNiCpMuKLu+m6K1
 +AykEsN6ExiJQ0cBcxO1w20J9QWJXkA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-x4R-mSrmMOel9eBWuldvSA-1; Thu, 10 Aug 2023 04:59:58 -0400
X-MC-Unique: x4R-mSrmMOel9eBWuldvSA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9c5cba6d1so7307941fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691657996; x=1692262796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nKyPrvxOKqENhpjoZF1fWfducNpAl/tgriHmOVfHW4=;
 b=KSFgQOHX+Ct46G04OYTlDsObJ3LG7he+j0B4nTZccI+6AuNvp30RB5ELrYozoCmQNY
 kTMNx0yhkQZNFowUpczHK4BiEcAUJtUd2sYVKTwVmREHG0K/m4uN7uJuuFlv1ms1PSyN
 eVeGKvP6o6agFqS83ndYeuJCeCrgQN+6FEHwt/yqdM408EXhZCGiRSGf6Xlq8gPPlmsH
 WbCLptf0TN/WlkmE+Sj81AWxNjD8LFFgEBueLhlt7ARdeNScEJBHTHyAtWNi8oNHIKj3
 BnZon2LI/w4vAlJHyxpUin1vxdqthjwHhE7mU0r3zFH95+MPIwiFBVdIqAc5lnGHgAJk
 5Uhw==
X-Gm-Message-State: AOJu0YyOgY97mBZXgvgxZvRmCazxOsZ0Rmal85aSfKzLycysijOWveNG
 gtgZoLdg/5d68RfuIjDaUKt+FRDje/t9pHcHYwZGT1dtXDkhn6FIZeQ5xbJIXnjd5gLIDI/HCO3
 OQFaKEo8yAWHTaHOfMRQS2IkE/qS5tbFpwL3VoFvcp7MPWMyR+7YYYi9/fA==
X-Received: by 2002:a2e:9988:0:b0:2b1:ad15:fe38 with SMTP id
 w8-20020a2e9988000000b002b1ad15fe38mr1294166lji.3.1691657996726; 
 Thu, 10 Aug 2023 01:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErTTpEI2vZq9rET0Cw/qHN+pTIeRy3QhOlPdBylyLuwsK9G5DMgUIJj2wRiA/+NWIhUcJx/tEumeoY9qvUFME=
X-Received: by 2002:a2e:9988:0:b0:2b1:ad15:fe38 with SMTP id
 w8-20020a2e9988000000b002b1ad15fe38mr1294149lji.3.1691657996352; Thu, 10 Aug
 2023 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230810045328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810045328-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 16:59:45 +0800
Message-ID: <CACGkMEtM+PJkZ09iYZ-wZaGNa-4aEJktGeCZX3U5hmAYjVp9oA@mail.gmail.com>
Subject: Re: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgNDo1NOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBBdWcgMDIsIDIwMjMgYXQgMDg6MTI6MTZQ
TSArMDMwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpcyBi
YXNlZCBvbiBFdWdlbmlvJ3MgZml4IGZvciBoYW5kbGluZyBDVlFzIGluCj4gPiBhIGRpZmZlcmVu
dCBBU0lEIFswXS4KPiA+Cj4gPiBUaGUgZmlyc3QgcGF0Y2ggaXMgdGhlIGFjdHVhbCBmaXguCj4g
Pgo+ID4gVGhlIG5leHQgMiBwYXRjaGVzIGFyZSBmaXhpbmcgYSBwb3NzaWJsZSBpc3N1ZSB0aGF0
IEkgZm91bmQgd2hpbGUKPiA+IGltcGxlbWVudGluZyBwYXRjaCAxLiBUaGUgcGF0Y2hlcyBhcmUg
b3JkZXJlZCBsaWtlIHRoaXMgZm9yIGNsYXJpdHkuCj4gPgo+ID4gWzBdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyMzAxMTIxNDIyMTguNzI1NjIyLTEtZXBlcmV6bWFAcmVkaGF0LmNv
bS8KPgo+Cj4gU28gd2hhdCBhcmUgd2UgZG9pbmcgd2l0aCB0aGlzIHBhdGNoc2V0PyBJZiB3ZSBh
cmUgbWVyZ2luZyBhbnl0aGluZwo+IGZvciB0aGlzIHJlbGVhc2UgaXQgaGFzIHRvIGhhcHBlbiBu
b3cuCgpJIHRoaW5rIHdlIGNhbiBtZXJnZSB0aGlzIGFuZCBkbyBvcHRpbWl6YXRpb24gb24gdG9w
LgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4K
PiA+IERyYWdvcyBUYXR1bGVhICgxKToKPiA+ICAgdmRwYS9tbHg1OiBGaXggbXItPmluaXRpYWxp
emVkIHNlbWFudGljcwo+ID4KPiA+IEV1Z2VuaW8gUMOpcmV6ICgxKToKPiA+ICAgdmRwYS9tbHg1
OiBEZWxldGUgY29udHJvbCB2cSBpb3RsYiBpbiBkZXN0cm95X21yIG9ubHkgd2hlbiBuZWNlc3Nh
cnkKPiA+Cj4gPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICAyICsKPiA+
ICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgIHwgOTcgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tCj4gPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8
ICA0ICstCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlv
bnMoLSkKPiA+Cj4gPiAtLQo+ID4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
