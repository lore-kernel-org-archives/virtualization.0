Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ADDC7619A
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 11:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1789D83EDC;
	Thu, 23 Mar 2023 11:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1789D83EDC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7dWtzTp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qowXPzL_owJM; Thu, 23 Mar 2023 11:44:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9734B8235D;
	Thu, 23 Mar 2023 11:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9734B8235D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1F8C0071;
	Thu, 23 Mar 2023 11:44:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73133C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E8A38235D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E8A38235D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6YQAIIyFRfm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:44:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DED8822D5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DED8822D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679571889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMD7H2kp0eSKoSxfq1PhoExu63Twb+QYc8ILXExIOt0=;
 b=R7dWtzTpD9n2TfgKI/ljFG79xAoZjHEiZfih/5Nz4fBDxChSGZg6lso0FW9ke8c9LLXA6L
 60yE0xFbUT0UGgcFpLXD1JoE4jquUjf5h81cu1qLLrwQrWsx0HUWKLA0h7vayl+Qegjkls
 WGl8W9ZyXDtpEp8AFMEnbmSqXZefkvM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-nZbMY71FNHqJZDjfoeWV4w-1; Thu, 23 Mar 2023 07:44:48 -0400
X-MC-Unique: nZbMY71FNHqJZDjfoeWV4w-1
Received: by mail-ed1-f72.google.com with SMTP id
 a27-20020a50c31b000000b0050047ecf4bfso25778052edb.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679571887;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMD7H2kp0eSKoSxfq1PhoExu63Twb+QYc8ILXExIOt0=;
 b=BOMY6/U7GL8d2J5POWGVhL9hcYg1dijt1nhZBhOr/KD18ivaL575YGJtLYbhH2KAmo
 sD+JPmNuj9b6ywa5tZn+z3ba9aAaa5cQ9NNDp41626zR18Rr03qXR774muX32GiXpaUJ
 HUgVSc7NpriCLmXZJ4g/eYPjy1ojqDcjGRkjbClNGnVEvhX82mEfZBQF8G5sOGbY9lpa
 6hD1indfhyf2PHP2wELfTPWQWN3RrJ/wlf9uwcE+l5ReVqoSi2oFWs/ZihofB8I8+PFQ
 lVzum1DGCeuzQW+KlgoCJkzV4O+jqVhY1+YMt9hGzbV5kqG6jGeDfD9TrMPrpaE9Ro8g
 WRDQ==
X-Gm-Message-State: AO0yUKV701dnjGlf/XUlHvlSZmnTpjsGGX/BBIT74bFDOdebXUzz51e7
 qe3EYmd5O9g4DBMgk2EgFSF2FhgRZpCvCGiiKOSdHlEpwqCa67J+Yu17037+WSjgwICLxO/6vqu
 423dCcO0Ro8JWLVrzpodKLV4LgDuRiISrfvEsVUB1jA==
X-Received: by 2002:a05:6402:2920:b0:500:2cc6:36d5 with SMTP id
 ee32-20020a056402292000b005002cc636d5mr5727067edb.8.1679571887367; 
 Thu, 23 Mar 2023 04:44:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set8uU0070bRsyBjQjpSi08yAtED4W63tVlm60HDGu5Op0XDHfVKzvp9t3BqE4omUQn4yYVC+6A==
X-Received: by 2002:a05:6402:2920:b0:500:2cc6:36d5 with SMTP id
 ee32-20020a056402292000b005002cc636d5mr5727043edb.8.1679571887109; 
 Thu, 23 Mar 2023 04:44:47 -0700 (PDT)
Received: from redhat.com ([2.52.143.71]) by smtp.gmail.com with ESMTPSA id
 w3-20020a50c443000000b004ac54d4da22sm9165128edf.71.2023.03.23.04.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 04:44:46 -0700 (PDT)
Date: Thu, 23 Mar 2023 07:44:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
Message-ID: <20230323074427-mutt-send-email-mst@kernel.org>
References: <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
 <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTA6NTA6MDZBTSArMDEwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+IE9uIFRodSwgTWFyIDIzLCAyMDIzIGF0IDExOjQyOjA3QU0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCAxMTo0OOKAr1BNIFN0
ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4g
PiBUaGUgbmV3ICJ1c2VfdmEiIG1vZHVsZSBwYXJhbWV0ZXIgKGRlZmF1bHQ6IHRydWUpIGlzIHVz
ZWQgaW4KPiA+ID4gdmRwYV9hbGxvY19kZXZpY2UoKSB0byBpbmZvcm0gdGhlIHZEUEEgZnJhbWV3
b3JrIHRoYXQgdGhlIGRldmljZQo+ID4gPiBzdXBwb3J0cyBWQS4KPiA+ID4gCj4gPiA+IHZyaW5n
aCBpcyBpbml0aWFsaXplZCB0byB1c2UgVkEgb25seSB3aGVuICJ1c2VfdmEiIGlzIHRydWUgYW5k
IHRoZQo+ID4gPiB1c2VyJ3MgbW0gaGFzIGJlZW4gYm91bmQuIFNvLCBvbmx5IHdoZW4gdGhlIGJ1
cyBzdXBwb3J0cyB1c2VyIFZBCj4gPiA+IChlLmcuIHZob3N0LXZkcGEpLgo+ID4gPiAKPiA+ID4g
dmRwYXNpbV9tbV93b3JrX2ZuIHdvcmsgaXMgdXNlZCB0byBzZXJpYWxpemUgdGhlIGJpbmRpbmcg
dG8gYSBuZXcKPiA+ID4gYWRkcmVzcyBzcGFjZSB3aGVuIHRoZSAuYmluZF9tbSBjYWxsYmFjayBp
cyBpbnZva2VkLCBhbmQgdW5iaW5kaW5nCj4gPiA+IHdoZW4gdGhlIC51bmJpbmRfbW0gY2FsbGJh
Y2sgaXMgaW52b2tlZC4KPiA+ID4gCj4gPiA+IENhbGwgbW1nZXRfbm90X3plcm8oKS9rdGhyZWFk
X3VzZV9tbSgpIGluc2lkZSB0aGUgd29ya2VyIGZ1bmN0aW9uCj4gPiA+IHRvIHBpbiB0aGUgYWRk
cmVzcyBzcGFjZSBvbmx5IGFzIGxvbmcgYXMgbmVlZGVkLCBmb2xsb3dpbmcgdGhlCj4gPiA+IGRv
Y3VtZW50YXRpb24gb2YgbW1nZXQoKSBpbiBpbmNsdWRlL2xpbnV4L3NjaGVkL21tLmg6Cj4gPiA+
IAo+ID4gPiAgICogTmV2ZXIgdXNlIHRoaXMgZnVuY3Rpb24gdG8gcGluIHRoaXMgYWRkcmVzcyBz
cGFjZSBmb3IgYW4KPiA+ID4gICAqIHVuYm91bmRlZC9pbmRlZmluaXRlIGFtb3VudCBvZiB0aW1l
Lgo+ID4gCj4gPiBJIHdvbmRlciBpZiBldmVyeXRoaW5nIHdvdWxkIGJlIHNpbXBsaWZpZWQgaWYg
d2UganVzdCBhbGxvdyB0aGUgcGFyZW50Cj4gPiB0byBhZHZlcnRpc2Ugd2hldGhlciBvciBub3Qg
aXQgcmVxdWlyZXMgdGhlIGFkZHJlc3Mgc3BhY2UuCj4gPiAKPiA+IFRoZW4gd2hlbiB2aG9zdC12
RFBBIHByb2JlcyB0aGUgZGV2aWNlIGl0IGNhbiBzaW1wbHkgYWR2ZXJ0aXNlCj4gPiB1c2Vfd29y
ayBhcyB0cnVlIHNvIHZob3N0IGNvcmUgY2FuIHVzZSBnZXRfdGFza19tbSgpIGluIHRoaXMgY2Fz
ZT8KPiAKPiBJSVVDIHNldCB1c2VyX3dvcmtlciB0byB0cnVlLCBpdCBhbHNvIGNyZWF0ZXMgdGhl
IGt0aHJlYWQgaW4gdGhlIHZob3N0Cj4gY29yZSAoYnV0IHdlIGNhbiBhZGQgYW5vdGhlciB2YXJp
YWJsZSB0byBhdm9pZCB0aGlzKS4KPiAKPiBNeSBiaWdnZXN0IGNvbmNlcm4gaXMgdGhlIGNvbW1l
bnQgaW4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oLgo+IGdldF90YXNrX21tKCkgdXNlcyBtbWdl
dCgpLCBidXQgaW4gdGhlIGRvY3VtZW50YXRpb24gdGhleSBhZHZpc2UgYWdhaW5zdAo+IHBpbm5p
bmcgdGhlIGFkZHJlc3Mgc3BhY2UgaW5kZWZpbml0ZWx5LCBzbyBJIHByZWZlcnJlZCBpbiBrZWVw
aW5nCj4gbW1ncmFiKCkgaW4gdGhlIHZob3N0IGNvcmUsIHRoZW4gY2FsbCBtbWdldF9ub3RfemVy
bygpIGluIHRoZSB3b3JrZXIKPiBvbmx5IHdoZW4gaXQgaXMgcnVubmluZy4KPiAKPiBJbiB0aGUg
ZnV0dXJlIG1heWJlIG1tIHdpbGwgYmUgdXNlZCBkaWZmZXJlbnRseSBmcm9tIHBhcmVudCBpZiBz
b21laG93Cj4gaXQgaXMgc3VwcG9ydGVkIGJ5IGlvbW11LCBzbyBJIHdvdWxkIGxlYXZlIGl0IHRv
IHRoZSBwYXJlbnQgdG8gaGFuZGxlCj4gdGhpcy4KPiAKPiBUaGFua3MsCj4gU3RlZmFubwoKSSB0
aGluayBpb21tdWZkIGlzIHN1cHBvc2VkIHRvIGhhbmRsZSBhbGwgdGhpcyBkZXRhaWwsIHllcy4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
