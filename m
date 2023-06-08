Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA3C7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 14:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAA4A40283;
	Thu,  8 Jun 2023 14:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAA4A40283
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwPSY0ux
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hMj1xE3D0W2p; Thu,  8 Jun 2023 14:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03BA3401CA;
	Thu,  8 Jun 2023 14:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03BA3401CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE6B1C0037;
	Thu,  8 Jun 2023 14:23:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E56A6C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFB2040283
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFB2040283
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gORa6JHqdL0c
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F38B401CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F38B401CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686234209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ylaz4EsLWG8gT+tyBhiFM3PeWqHKsVLZz02Gzuw52i8=;
 b=AwPSY0uxKrLG5Jz8/ZWgiI56f80sR6oTEaZaI7cB7AvwKILNFV0N7BaOZU0F6b3HKv7p1Y
 r91U1xVfpCPMEm7MHLo9iu/LYuGjEjlHndqHaZLkAERAprUazXVBpdPqmF2xmk7ihJmoTy
 jDnPybOXlONr9BOaf5PQXRGbb+hgaas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-x-0-Kb0_MzyMH6Ek4sZ6WA-1; Thu, 08 Jun 2023 10:23:27 -0400
X-MC-Unique: x-0-Kb0_MzyMH6Ek4sZ6WA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30af6a5b6b0so313003f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 07:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686234206; x=1688826206;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ylaz4EsLWG8gT+tyBhiFM3PeWqHKsVLZz02Gzuw52i8=;
 b=KIyW/Ny3AVMQjSX/ndYwDdk2nN3tZbSROYiblOKXerlniA0PeqGzdSiJrtXOazSPu7
 YyG3pp6Xee9mtNAAnVCjzFaWfbAlLAXoshewgM1r+RMaktT0K1UuNc4nCqzuekiPct2G
 isUSF07dljkJKpByJbZRY1zMpi420HdWqf6RzUoOAJtsATjQ20/UvqbD1VeMXtDBODZ+
 5XG06T6pS4HKBAuF5zBJZ1wsZ9lIJQ7UBzro5cBBaqnUMBroO7NrypfuL0QaeDjUlXHp
 vet144gNpjlCsQL2xOtS7a8RNd5HiZs2jayvgxXBhJ69wSLxJgrmT5TZlo7V5gSw77N3
 lNcQ==
X-Gm-Message-State: AC+VfDwiiHDxtwekQ09C5yBZOekX5QQ8nvuVsU+ui6Tj2Ey4D3Xz8EzK
 UN5GvRCVfEHiefQH6f67eBePBARuNAnTk9Lhj5a2jrVdn9fX+mUtL/pjXz2tP+vCMPoBtMDbpcs
 xDKsGM31tVPhF7Z2YGO+8xTXnwz1BGccDcdKueSjCYw==
X-Received: by 2002:adf:dfc1:0:b0:30e:4886:3533 with SMTP id
 q1-20020adfdfc1000000b0030e48863533mr7800346wrn.34.1686234206023; 
 Thu, 08 Jun 2023 07:23:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c9mr4sGROJv3wpcDBq+xuHW3beEKuX1wsKDRXlb1F7uOxTNYgZiIdVFsqG1xx2NOA7F1/fA==
X-Received: by 2002:adf:dfc1:0:b0:30e:4886:3533 with SMTP id
 q1-20020adfdfc1000000b0030e48863533mr7800329wrn.34.1686234205650; 
 Thu, 08 Jun 2023 07:23:25 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b003f7f475c3c7sm2175514wmi.8.2023.06.08.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 07:23:25 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:23:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230608102259-mutt-send-email-mst@kernel.org>
References: <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
 <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6Mjk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEp1biA4LCAyMDIzIGF0IDU6MjHigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVuIDA4LCAyMDIz
IGF0IDA1OjAwOjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+T24gVGh1LCBKdW4g
OCwgMjAyMyBhdCA0OjAw4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4+Cj4gPiA+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMzo0Njow
MFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPj4KPiA+ID4+IFsuLi5dCj4gPiA+Pgo+
ID4gPj4gPj4gPiA+ID4gPiBJIGhhdmUgYSBxdWVzdGlvbiB0aG91Z2gsIHdoYXQgaWYgZG93biB0
aGUgcm9hZCB0aGVyZQo+ID4gPj4gPj4gPiA+ID4gPiBpcyBhIG5ldyBmZWF0dXJlIHRoYXQgbmVl
ZHMgbW9yZSBjaGFuZ2VzPyBJdCB3aWxsIGJlCj4gPiA+PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28g
anVzdCBsaWtlIFBBQ0tFRCBubz8KPiA+ID4+ID4+ID4gPiA+ID4gU2hvdWxkbid0IHZkcGEgaGF2
ZSBhbiBhbGxvd2xpc3Qgb2YgZmVhdHVyZXMgaXQga25vd3MgaG93Cj4gPiA+PiA+PiA+ID4gPiA+
IHRvIHN1cHBvcnQ/Cj4gPiA+PiA+PiA+ID4gPgo+ID4gPj4gPj4gPiA+ID4gSXQgbG9va3MgbGlr
ZSB3ZSBoYWQgaXQsIGJ1dCB3ZSB0b29rIGl0IG91dCAoYnkgdGhlIHdheSwgd2Ugd2VyZQo+ID4g
Pj4gPj4gPiA+ID4gZW5hYmxpbmcgcGFja2VkIGV2ZW4gdGhvdWdoIHdlIGRpZG4ndCBzdXBwb3J0
IGl0KToKPiA+ID4+ID4+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYyMzRmODA1NzRkNzU2
OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIKPiA+ID4+ID4+ID4gPiA+Cj4gPiA+PiA+PiA+ID4g
PiBUaGUgb25seSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgZm9yIGVhY2ggbmV3IGZlYXR1cmUgd2Ug
aGF2ZSB0byBtb2RpZnkKPiA+ID4+ID4+ID4gPiA+IHRoZSBrZXJuZWwuCj4gPiA+PiA+PiA+ID4g
PiBDb3VsZCB3ZSBoYXZlIG5ldyBmZWF0dXJlcyB0aGF0IGRvbid0IHJlcXVpcmUgaGFuZGxpbmcg
Ynkgdmhvc3QtdmRwYT8KPiA+ID4+ID4+ID4gPiA+Cj4gPiA+PiA+PiA+ID4gPiBUaGFua3MsCj4g
PiA+PiA+PiA+ID4gPiBTdGVmYW5vCj4gPiA+PiA+PiA+ID4KPiA+ID4+ID4+ID4gPiBKYXNvbiB3
aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5nIHRoaXM/Cj4gPiA+PiA+PiA+Cj4gPiA+PiA+PiA+
IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbSB3aXRoIHZE
UEEgY29yZS4KPiA+ID4+ID4+ID4KPiA+ID4+ID4+ID4gSXQncyB0aGUgZHV0eSBvZiB0aGUgcGFy
ZW50cyB0byBhZHZlcnRpc2UgdGhlIGZlYXR1cmVzIGl0IGhhcy4gRm9yIGV4YW1wbGUsCj4gPiA+
PiA+PiA+Cj4gPiA+PiA+PiA+IDEpIElmIHNvbWUga2VybmVsIHZlcnNpb24gdGhhdCBpcyBwYWNr
ZWQgaXMgbm90IHN1cHBvcnRlZCB2aWEKPiA+ID4+ID4+ID4gc2V0X3ZxX3N0YXRlLCBwYXJlbnRz
IHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBBQ0tFRCBmZWF0dXJlcyBpbiB0aGlzCj4gPiA+PiA+PiA+
IGNhc2UuCj4gPiA+PiA+PiA+IDIpIElmIHRoZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFja2VkIHNl
dF92cV9zdGF0ZSgpLCBidXQgaXQncyBlbXVsYXRlZAo+ID4gPj4gPj4gPiBjdnEgZG9lc24ndCBz
dXBwb3J0LCBwYXJlbnRzIHNob3VsZCBub3QgYWR2ZXJ0aXNlIFBBQ0tFRCBhcyB3ZWxsCj4gPiA+
PiA+PiA+Cj4gPiA+PiA+PiA+IElmIGEgcGFyZW50IHZpb2xhdGVzIHRoZSBhYm92ZSAyLCBpdCBs
b29rcyBsaWtlIGEgYnVnIG9mIHRoZSBwYXJlbnRzLgo+ID4gPj4gPj4gPgo+ID4gPj4gPj4gPiBU
aGFua3MKPiA+ID4+ID4+Cj4gPiA+PiA+PiBZZXMgYnV0IHdoYXQgYWJvdXQgdmhvc3RfdmRwYT8g
VGFsa2luZyBhYm91dCB0aGF0IG5vdCB0aGUgY29yZS4KPiA+ID4+ID4KPiA+ID4+ID5Ob3Qgc3Vy
ZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHdvcmthcm91bmQgcGFyZW50IGJ1Z3MgdmlhIHZob3N0LXZE
UEEuCj4gPiA+Pgo+ID4gPj4gU29ycnksIEknbSBnZXR0aW5nIGxvc3QuLi4KPiA+ID4+IFdlIHdl
cmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEgZG9lc24ndCBoYW5kbGUK
PiA+ID4+IFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFIGlvY3RscyB3ZWxsIGZvciBwYWNr
ZWQgdmlydHF1ZXVlIGJlZm9yZQo+ID4gPj4gdGhhdCBzZXJpZXMgWzFdLCBubz8KPiA+ID4+Cj4g
PiA+PiBUaGUgcGFyZW50cyBzZWVtIG9rYXksIGJ1dCBtYXliZSBJIG1pc3NlZCBhIGZldyB0aGlu
Z3MuCj4gPiA+Pgo+ID4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0
aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNvbS8KPiA+ID4K
PiA+ID5ZZXMsIG1vcmUgYmVsb3cuCj4gPiA+Cj4gPiA+Pgo+ID4gPj4gPgo+ID4gPj4gPj4gU2hv
dWxkIHRoYXQgbm90IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKPiA+ID4+ID4+IHNpbmNl
IGl0IGludGVycHJldHMgaW9jdGxzIGRpZmZlcmVudGx5IGRlcGVuZGluZyBvbiB0aGlzPwo+ID4g
Pj4gPgo+ID4gPj4gPklmIHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBm
b2xsb3dpbmcgc2V0dXA6Cj4gPiA+PiA+Cj4gPiA+PiA+U0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5H
X0JBU0UgKyBWRFVTRS4KPiA+ID4+ID4KPiA+ID4+ID5UaGlzIHNlZW1zIHRvIGJlIGJyb2tlbiBz
aW5jZSBWRFVTRSB3YXMgaW50cm9kdWNlZC4gSWYgd2UgcmVhbGx5IHdhbnQKPiA+ID4+ID50byBi
YWNrcG9ydCBzb21ldGhpbmcsIGl0IGNvdWxkIGJlIGEgZml4IHRvIGZpbHRlciBvdXQgUEFDS0VE
IGluCj4gPiA+PiA+VkRVU0U/Cj4gPiA+Pgo+ID4gPj4gbW1tIGl0IGRvZXNuJ3Qgc2VlbSB0byBi
ZSBhIHByb2JsZW0gaW4gVkRVU0UsIGJ1dCBpbiB2aG9zdC12ZHBhLgo+ID4gPj4gSSB0aGluayBW
RFVTRSB3b3JrcyBmaW5lIHdpdGggcGFja2VkIHZpcnRxdWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+
ID4gPj4gKEkgaGF2ZW4ndCB0cmllZCksIHNvIHdoeSBzaG91bGQgd2UgZmlsdGVyIFBBQ0tFRCBp
biBWRFVTRT8KPiA+ID4KPiA+ID5JIGRvbid0IHRoaW5rIHdlIG5lZWQgYW55IGZpbHRlcmluZyBz
aW5jZToKPiA+ID4KPiA+ID5QQUNLRUQgZmVhdHVyZXMgaGFzIGJlZW4gYWR2ZXJ0aXNlZCB0byB1
c2Vyc3BhY2UgdmlhIHVBUEkgc2luY2UKPiA+ID42MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1NWZh
MjgzOGU5MmIxNThiLiBPbmNlIHdlIHJlbGF4IGluIHVBUEksIGl0Cj4gPiA+d291bGQgYmUgdmVy
eSBoYXJkIHRvIHJlc3RyaWN0IGl0IGFnYWluLiBGb3IgdGhlIHVzZXJzcGFjZSB0aGF0IHRyaWVz
Cj4gPiA+dG8gbmVnb3RpYXRlIFBBQ0tFRDoKPiA+ID4KPiA+ID4xKSBpZiBpdCBkb2Vzbid0IHVz
ZSBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSwgZXZlcnl0aGluZyB3b3JrcyB3ZWxsCj4g
PiA+MikgaWYgaXQgdXNlcyBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRS4gaXQgbWlnaHQg
ZmFpbCBvciBicmVhayBzaWxlbnRseQo+ID4gPgo+ID4gPklmIHdlIGJhY2twb3J0IHRoZSBmaXhl
cyB0byAtc3RhYmxlLCB3ZSBtYXkgYnJlYWsgdGhlIGFwcGxpY2F0aW9uIGF0Cj4gPiA+bGVhc3Qg
aW4gdGhlIGNhc2UgMSkuCj4gPgo+ID4gT2theSwgSSBzZWUgbm93LCB0aGFua3MgZm9yIHRoZSBk
ZXRhaWxzIQo+ID4KPiA+IE1heWJlIGluc3RlYWQgb2YgImJyZWFrIHNpbGVudGx5Iiwgd2UgY2Fu
IHJldHVybiBhbiBleHBsaWNpdCBlcnJvciBmb3IKPiA+IFNFVF9WUklOR19CQVNFL0dFVF9WUklO
R19CQVNFIGluIHN0YWJsZSBicmFuY2hlcy4KPiA+IEJ1dCBpZiB0aGVyZSBhcmUgbm90IG1hbnkg
Y2FzZXMsIHdlIGNhbiBsZWF2ZSBpdCBsaWtlIHRoYXQuCj4gCj4gQSBzZWNvbmQgdGhvdWdodCwg
aWYgd2UgbmVlZCB0byBkbyBzb21ldGhpbmcgZm9yIHN0YWJsZS4gaXMgaXQgYmV0dGVyCj4gaWYg
d2UganVzdCBiYWNrcG9ydCBTaGFubm9uJ3Mgc2VyaWVzIHRvIHN0YWJsZT8KPiAKPiA+Cj4gPiBJ
IHdhcyBqdXN0IGNvbmNlcm5lZCBhYm91dCBob3cgZG9lcyB0aGUgdXNlciBzcGFjZSB1bmRlcnN0
YW5kIHRoYXQgaXQKPiA+IGNhbiB1c2UgU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgZm9y
IFBBQ0tFRCB2aXJ0cXVldWVzIGluIGEgZ2l2ZW4KPiA+IGtlcm5lbCBvciBub3QuCj4gCj4gTXkg
dW5kZXJzdGFuZGluZyBpcyB0aGF0IGlmIHBhY2tlZCBpcyBhZHZlcnRpc2VkLCB0aGUgYXBwbGlj
YXRpb24KPiBzaG91bGQgYXNzdW1lIFNFVC9HRVRfVlJJTkdfQkFTRSB3b3JrLgo+IAo+IFRoYW5r
cwoKCkxldCBtZSBhc2sgeW91IHRoaXMuIFRoaXMgaXMgYSBidWdmaXggeWVzPyBXaGF0IGlzIHRo
ZSBhcHByb3ByaWF0ZSBGaXhlcwp0YWc/Cgo+ID4KPiA+IFRoYW5rcywKPiA+IFN0ZWZhbm8KPiA+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
