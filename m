Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44077C7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 03:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2058415C9;
	Mon, 27 Mar 2023 03:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2058415C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X0D0VflU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id npxkDcbKpzlH; Mon, 27 Mar 2023 03:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8BB94152D;
	Mon, 27 Mar 2023 03:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8BB94152D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96249C0035;
	Mon, 27 Mar 2023 03:12:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55BBAC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 03:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BA4581DFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 03:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BA4581DFC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X0D0VflU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13yUSt_csPSh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 03:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F29381DD8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F29381DD8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679886767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7jMSq1Oqt89DeEKZ9wwG6GQzFOitJhSi8FbGeviIdQ=;
 b=X0D0VflUZgQOpDxzlXFn4QIc1o5YnE+tOhqmSMPS6dLMm4t295i2TOL20IeP54Yh+bObe3
 8Tze6Oo3lBUGD2a1xVI5BHxCQh89sI7kpJNjYq+/l1+Xqrx1UrKgtQkienmtERKeoDpCqA
 Ry74K9hvA38nv1+QliW5uCpiBwI0A6k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-R-UiJdAzMK-ZWhx_G6l2IQ-1; Sun, 26 Mar 2023 23:12:46 -0400
X-MC-Unique: R-UiJdAzMK-ZWhx_G6l2IQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 s63-20020acadb42000000b00388f0de0c51so618934oig.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 20:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679886765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7jMSq1Oqt89DeEKZ9wwG6GQzFOitJhSi8FbGeviIdQ=;
 b=dixQnXDuTqgq7MZOPwo1QvPMunn5sGz0SqaKScNlepP8j+6mZjJ+juack/e3UMon0A
 UNYWyVZAf577LTS79kxpCjXbh4iRmk1oeb8zzdH7WzLvdzDrJMwXzsrj3jwDvX3pjXCH
 ay5pll3dgQs3p0Z9N5OpkaIClaqqYS/y2VLGlSuoMWFPlYo5Z4hdRrlBuQfzzJ6+kDNZ
 aVzx6Cpq921cZoecfLNVss50Bo3KtePiFPfiUnnXeT9ZP7ivxrdSLEt9cj02B+ObDfcF
 E9NawPpzfb5Y3DAjq44wATVKx1Z7KVKfqYvDJCrvd8xBqY0ODi8KU015JghYwDMH6d1P
 kZ2Q==
X-Gm-Message-State: AAQBX9eIovy2w/ob/Cs8aneq+s5mL9EQ6bbvA7ZJt0fhE8pxpOgv3zsp
 zcL3VN8LWitpNuBaZuan/PG+7E8Y5LhGcsl1hezodreO+S9peMyFgP9LWAqOTA3Fb49Od4BbpYp
 nCthS5tT+V+xJLqN9XbmDWzYXRug56tFCkOXKhgqrloRajF9iD8Y7wSHR8A==
X-Received: by 2002:a05:6870:8f4a:b0:177:83f7:351c with SMTP id
 vc10-20020a0568708f4a00b0017783f7351cmr2311952oab.9.1679886764959; 
 Sun, 26 Mar 2023 20:12:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/emaj9r+Vxf+kzhwxYeXBBP9ZYc2AJ2G4IeDWGc0VKHvSlfscQfpo+8V4vu4wuKne4BrxS4VXeDZqMOFGn7Ds=
X-Received: by 2002:a05:6870:8f4a:b0:177:83f7:351c with SMTP id
 vc10-20020a0568708f4a00b0017783f7351cmr2311941oab.9.1679886764731; Sun, 26
 Mar 2023 20:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
 <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
 <CACGkMEveMGEzX7bCPuQuqm=9q7Ut-k=MLrRYM3Bq6cMpaw9fVQ@mail.gmail.com>
 <j6d2b5zqbb7rlrem76wopsabyy344wwnkbutvacebcig5fupnu@a2xkhywajwta>
In-Reply-To: <j6d2b5zqbb7rlrem76wopsabyy344wwnkbutvacebcig5fupnu@a2xkhywajwta>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Mar 2023 11:12:33 +0800
Message-ID: <CACGkMEugnjm4U1h9JTzMh0yJ1MnsgJR=pYEO96YsTNEYLoiR-g@mail.gmail.com>
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6NDPigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6
NTQ6MzlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+T24gVGh1LCBNYXIgMjMsIDIwMjMg
YXQgNTo1MOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPj4KPiA+PiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxMTo0MjowN0FNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4+ID5PbiBUdWUsIE1hciAyMSwgMjAyMyBhdCAxMTo0OOKAr1BN
IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4gPj4K
PiA+PiA+PiBUaGUgbmV3ICJ1c2VfdmEiIG1vZHVsZSBwYXJhbWV0ZXIgKGRlZmF1bHQ6IHRydWUp
IGlzIHVzZWQgaW4KPiA+PiA+PiB2ZHBhX2FsbG9jX2RldmljZSgpIHRvIGluZm9ybSB0aGUgdkRQ
QSBmcmFtZXdvcmsgdGhhdCB0aGUgZGV2aWNlCj4gPj4gPj4gc3VwcG9ydHMgVkEuCj4gPj4gPj4K
PiA+PiA+PiB2cmluZ2ggaXMgaW5pdGlhbGl6ZWQgdG8gdXNlIFZBIG9ubHkgd2hlbiAidXNlX3Zh
IiBpcyB0cnVlIGFuZCB0aGUKPiA+PiA+PiB1c2VyJ3MgbW0gaGFzIGJlZW4gYm91bmQuIFNvLCBv
bmx5IHdoZW4gdGhlIGJ1cyBzdXBwb3J0cyB1c2VyIFZBCj4gPj4gPj4gKGUuZy4gdmhvc3QtdmRw
YSkuCj4gPj4gPj4KPiA+PiA+PiB2ZHBhc2ltX21tX3dvcmtfZm4gd29yayBpcyB1c2VkIHRvIHNl
cmlhbGl6ZSB0aGUgYmluZGluZyB0byBhIG5ldwo+ID4+ID4+IGFkZHJlc3Mgc3BhY2Ugd2hlbiB0
aGUgLmJpbmRfbW0gY2FsbGJhY2sgaXMgaW52b2tlZCwgYW5kIHVuYmluZGluZwo+ID4+ID4+IHdo
ZW4gdGhlIC51bmJpbmRfbW0gY2FsbGJhY2sgaXMgaW52b2tlZC4KPiA+PiA+Pgo+ID4+ID4+IENh
bGwgbW1nZXRfbm90X3plcm8oKS9rdGhyZWFkX3VzZV9tbSgpIGluc2lkZSB0aGUgd29ya2VyIGZ1
bmN0aW9uCj4gPj4gPj4gdG8gcGluIHRoZSBhZGRyZXNzIHNwYWNlIG9ubHkgYXMgbG9uZyBhcyBu
ZWVkZWQsIGZvbGxvd2luZyB0aGUKPiA+PiA+PiBkb2N1bWVudGF0aW9uIG9mIG1tZ2V0KCkgaW4g
aW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOgo+ID4+ID4+Cj4gPj4gPj4gICAqIE5ldmVyIHVzZSB0
aGlzIGZ1bmN0aW9uIHRvIHBpbiB0aGlzIGFkZHJlc3Mgc3BhY2UgZm9yIGFuCj4gPj4gPj4gICAq
IHVuYm91bmRlZC9pbmRlZmluaXRlIGFtb3VudCBvZiB0aW1lLgo+ID4+ID4KPiA+PiA+SSB3b25k
ZXIgaWYgZXZlcnl0aGluZyB3b3VsZCBiZSBzaW1wbGlmaWVkIGlmIHdlIGp1c3QgYWxsb3cgdGhl
IHBhcmVudAo+ID4+ID50byBhZHZlcnRpc2Ugd2hldGhlciBvciBub3QgaXQgcmVxdWlyZXMgdGhl
IGFkZHJlc3Mgc3BhY2UuCj4gPj4gPgo+ID4+ID5UaGVuIHdoZW4gdmhvc3QtdkRQQSBwcm9iZXMg
dGhlIGRldmljZSBpdCBjYW4gc2ltcGx5IGFkdmVydGlzZQo+ID4+ID51c2Vfd29yayBhcyB0cnVl
IHNvIHZob3N0IGNvcmUgY2FuIHVzZSBnZXRfdGFza19tbSgpIGluIHRoaXMgY2FzZT8KPiA+Pgo+
ID4+IElJVUMgc2V0IHVzZXJfd29ya2VyIHRvIHRydWUsIGl0IGFsc28gY3JlYXRlcyB0aGUga3Ro
cmVhZCBpbiB0aGUgdmhvc3QKPiA+PiBjb3JlIChidXQgd2UgY2FuIGFkZCBhbm90aGVyIHZhcmlh
YmxlIHRvIGF2b2lkIHRoaXMpLgo+ID4+Cj4gPj4gTXkgYmlnZ2VzdCBjb25jZXJuIGlzIHRoZSBj
b21tZW50IGluIGluY2x1ZGUvbGludXgvc2NoZWQvbW0uaC4KPiA+PiBnZXRfdGFza19tbSgpIHVz
ZXMgbW1nZXQoKSwgYnV0IGluIHRoZSBkb2N1bWVudGF0aW9uIHRoZXkgYWR2aXNlIGFnYWluc3QK
PiA+PiBwaW5uaW5nIHRoZSBhZGRyZXNzIHNwYWNlIGluZGVmaW5pdGVseSwgc28gSSBwcmVmZXJy
ZWQgaW4ga2VlcGluZwo+ID4+IG1tZ3JhYigpIGluIHRoZSB2aG9zdCBjb3JlLCB0aGVuIGNhbGwg
bW1nZXRfbm90X3plcm8oKSBpbiB0aGUgd29ya2VyCj4gPj4gb25seSB3aGVuIGl0IGlzIHJ1bm5p
bmcuCj4gPgo+ID5Pay4KPiA+Cj4gPj4KPiA+PiBJbiB0aGUgZnV0dXJlIG1heWJlIG1tIHdpbGwg
YmUgdXNlZCBkaWZmZXJlbnRseSBmcm9tIHBhcmVudCBpZiBzb21laG93Cj4gPj4gaXQgaXMgc3Vw
cG9ydGVkIGJ5IGlvbW11LCBzbyBJIHdvdWxkIGxlYXZlIGl0IHRvIHRoZSBwYXJlbnQgdG8gaGFu
ZGxlCj4gPj4gdGhpcy4KPiA+Cj4gPlRoaXMgc2hvdWxkIGJlIHBvc3NpYmxlLCBJIHdhcyB0b2xk
IGJ5IEludGVsIHRoYXQgdGhlaXIgSU9NTVUgY2FuCj4gPmFjY2VzcyB0aGUgcHJvY2VzcyBwYWdl
IHRhYmxlIGZvciBzaGFyZWQgdmlydHVhbCBtZW1vcnkuCj4KPiBDb29sLCB3ZSBzaG91bGQgaW52
ZXN0aWdhdGUgdGhpcy4gRG8geW91IGhhdmUgYW55IHBvaW50ZXJzIHRvIHRoZWlyCj4gZG9jdW1l
bnRhdGlvbj8KClRoZSB2dGQtc3BlYyBJIHRoaW5rLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IFN0
ZWZhbm8KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
