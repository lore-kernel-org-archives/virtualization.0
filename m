Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBF0C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 02:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2ECF8401B;
	Fri, 24 Mar 2023 02:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2ECF8401B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yi1EsPyV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7I-TX8s5fcD1; Fri, 24 Mar 2023 02:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45A0B8400F;
	Fri, 24 Mar 2023 02:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45A0B8400F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE669C0035;
	Fri, 24 Mar 2023 02:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7837AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B7238400F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B7238400F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-56n5LHE1oc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:54:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F29F983FFF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F29F983FFF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679626493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uAUlOWmnaNVo/VWoXQNmQTS2u7vnkE353p3vcNlNhc=;
 b=Yi1EsPyVBvI0hkrRYM3GszLSgDJNbK2UFGDw2WxUtIObPLdEME6sbKDoEsk12gAEYCc8pA
 VCPitFti9zLqjMRdgdqdQyp5wqPPDNlMNE+aDnxJ+FF5lgOYiGeMW5aC/sA0rG0F3kuc33
 2OAn1mD5TRVxycVcC33yekc39qelhoA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-SnfAWw_mOiKFHsP-KKTg2Q-1; Thu, 23 Mar 2023 22:54:51 -0400
X-MC-Unique: SnfAWw_mOiKFHsP-KKTg2Q-1
Received: by mail-ot1-f71.google.com with SMTP id
 j16-20020a9d7390000000b0069fa749a693so176006otk.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 19:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679626491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uAUlOWmnaNVo/VWoXQNmQTS2u7vnkE353p3vcNlNhc=;
 b=7KPNR8evXI/6ipgZPDKTPPCORF1pTIMQruazz1azSa8D8upXzb3o1CJRtLH8RmwNkT
 BvofTKvl7KVm9EU77GWG+P7HIh8usGCqgSpnNjDbG+2pbaGUJmp28rgdNBE8Ijb5qgxz
 mpKlcgIMXMDUi792QLmeekkjtf9d1KKkG3MzAuNwk8YxBPAmD/zEjE4qB+gZu3nxp6hq
 //xyufsuPFkETOEEy1z/5+bWOXEtDgImlFAFcXOS8y9j3NWAaY9zXSHnhZs31PdMxchk
 uINOiu33sxpmOpZZ7BkizCxek+Dwkpdh0/JQhzRziM3IEuBd4UbaATmHdYEmfQp2Nly7
 dC+Q==
X-Gm-Message-State: AO0yUKXS+HfHpPLh3GTLOzV24jB0IUbHiAgbWs0oeGvXoL+aKyZ5EVMk
 qwGGQMS1vO6h9/BP6+PHw3GHJrFKfw7s6H0KPdOx3lF1i3P3g8jmzvmZWtAAGCo3Ny3CksEmIEZ
 V7ok4cJP2e8WpULgpZJSYRHp67rUUvYshdsNjzk/n6vo+QajVo4r5IpDb1A==
X-Received: by 2002:a05:6871:b19b:b0:177:9f9c:dc5 with SMTP id
 an27-20020a056871b19b00b001779f9c0dc5mr512922oac.9.1679626491035; 
 Thu, 23 Mar 2023 19:54:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set9fm4WXoQhc8oPxzAxZzgWX14feJUPEMiSJPQgN0rubtFNZsrLMc1kcr+QSYvWg5YQ6SKRhX2omEeiDY+P3wck=
X-Received: by 2002:a05:6871:b19b:b0:177:9f9c:dc5 with SMTP id
 an27-20020a056871b19b00b001779f9c0dc5mr512917oac.9.1679626490818; Thu, 23 Mar
 2023 19:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
 <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
In-Reply-To: <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Mar 2023 10:54:39 +0800
Message-ID: <CACGkMEveMGEzX7bCPuQuqm=9q7Ut-k=MLrRYM3Bq6cMpaw9fVQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgNTo1MOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxMTo0
MjowN0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID5PbiBUdWUsIE1hciAyMSwgMjAyMyBh
dCAxMTo0OOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPj4KPiA+PiBUaGUgbmV3ICJ1c2VfdmEiIG1vZHVsZSBwYXJhbWV0ZXIgKGRlZmF1bHQ6
IHRydWUpIGlzIHVzZWQgaW4KPiA+PiB2ZHBhX2FsbG9jX2RldmljZSgpIHRvIGluZm9ybSB0aGUg
dkRQQSBmcmFtZXdvcmsgdGhhdCB0aGUgZGV2aWNlCj4gPj4gc3VwcG9ydHMgVkEuCj4gPj4KPiA+
PiB2cmluZ2ggaXMgaW5pdGlhbGl6ZWQgdG8gdXNlIFZBIG9ubHkgd2hlbiAidXNlX3ZhIiBpcyB0
cnVlIGFuZCB0aGUKPiA+PiB1c2VyJ3MgbW0gaGFzIGJlZW4gYm91bmQuIFNvLCBvbmx5IHdoZW4g
dGhlIGJ1cyBzdXBwb3J0cyB1c2VyIFZBCj4gPj4gKGUuZy4gdmhvc3QtdmRwYSkuCj4gPj4KPiA+
PiB2ZHBhc2ltX21tX3dvcmtfZm4gd29yayBpcyB1c2VkIHRvIHNlcmlhbGl6ZSB0aGUgYmluZGlu
ZyB0byBhIG5ldwo+ID4+IGFkZHJlc3Mgc3BhY2Ugd2hlbiB0aGUgLmJpbmRfbW0gY2FsbGJhY2sg
aXMgaW52b2tlZCwgYW5kIHVuYmluZGluZwo+ID4+IHdoZW4gdGhlIC51bmJpbmRfbW0gY2FsbGJh
Y2sgaXMgaW52b2tlZC4KPiA+Pgo+ID4+IENhbGwgbW1nZXRfbm90X3plcm8oKS9rdGhyZWFkX3Vz
ZV9tbSgpIGluc2lkZSB0aGUgd29ya2VyIGZ1bmN0aW9uCj4gPj4gdG8gcGluIHRoZSBhZGRyZXNz
IHNwYWNlIG9ubHkgYXMgbG9uZyBhcyBuZWVkZWQsIGZvbGxvd2luZyB0aGUKPiA+PiBkb2N1bWVu
dGF0aW9uIG9mIG1tZ2V0KCkgaW4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOgo+ID4+Cj4gPj4g
ICAqIE5ldmVyIHVzZSB0aGlzIGZ1bmN0aW9uIHRvIHBpbiB0aGlzIGFkZHJlc3Mgc3BhY2UgZm9y
IGFuCj4gPj4gICAqIHVuYm91bmRlZC9pbmRlZmluaXRlIGFtb3VudCBvZiB0aW1lLgo+ID4KPiA+
SSB3b25kZXIgaWYgZXZlcnl0aGluZyB3b3VsZCBiZSBzaW1wbGlmaWVkIGlmIHdlIGp1c3QgYWxs
b3cgdGhlIHBhcmVudAo+ID50byBhZHZlcnRpc2Ugd2hldGhlciBvciBub3QgaXQgcmVxdWlyZXMg
dGhlIGFkZHJlc3Mgc3BhY2UuCj4gPgo+ID5UaGVuIHdoZW4gdmhvc3QtdkRQQSBwcm9iZXMgdGhl
IGRldmljZSBpdCBjYW4gc2ltcGx5IGFkdmVydGlzZQo+ID51c2Vfd29yayBhcyB0cnVlIHNvIHZo
b3N0IGNvcmUgY2FuIHVzZSBnZXRfdGFza19tbSgpIGluIHRoaXMgY2FzZT8KPgo+IElJVUMgc2V0
IHVzZXJfd29ya2VyIHRvIHRydWUsIGl0IGFsc28gY3JlYXRlcyB0aGUga3RocmVhZCBpbiB0aGUg
dmhvc3QKPiBjb3JlIChidXQgd2UgY2FuIGFkZCBhbm90aGVyIHZhcmlhYmxlIHRvIGF2b2lkIHRo
aXMpLgo+Cj4gTXkgYmlnZ2VzdCBjb25jZXJuIGlzIHRoZSBjb21tZW50IGluIGluY2x1ZGUvbGlu
dXgvc2NoZWQvbW0uaC4KPiBnZXRfdGFza19tbSgpIHVzZXMgbW1nZXQoKSwgYnV0IGluIHRoZSBk
b2N1bWVudGF0aW9uIHRoZXkgYWR2aXNlIGFnYWluc3QKPiBwaW5uaW5nIHRoZSBhZGRyZXNzIHNw
YWNlIGluZGVmaW5pdGVseSwgc28gSSBwcmVmZXJyZWQgaW4ga2VlcGluZwo+IG1tZ3JhYigpIGlu
IHRoZSB2aG9zdCBjb3JlLCB0aGVuIGNhbGwgbW1nZXRfbm90X3plcm8oKSBpbiB0aGUgd29ya2Vy
Cj4gb25seSB3aGVuIGl0IGlzIHJ1bm5pbmcuCgpPay4KCj4KPiBJbiB0aGUgZnV0dXJlIG1heWJl
IG1tIHdpbGwgYmUgdXNlZCBkaWZmZXJlbnRseSBmcm9tIHBhcmVudCBpZiBzb21laG93Cj4gaXQg
aXMgc3VwcG9ydGVkIGJ5IGlvbW11LCBzbyBJIHdvdWxkIGxlYXZlIGl0IHRvIHRoZSBwYXJlbnQg
dG8gaGFuZGxlCj4gdGhpcy4KClRoaXMgc2hvdWxkIGJlIHBvc3NpYmxlLCBJIHdhcyB0b2xkIGJ5
IEludGVsIHRoYXQgdGhlaXIgSU9NTVUgY2FuCmFjY2VzcyB0aGUgcHJvY2VzcyBwYWdlIHRhYmxl
IGZvciBzaGFyZWQgdmlydHVhbCBtZW1vcnkuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gU3RlZmFu
bwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
