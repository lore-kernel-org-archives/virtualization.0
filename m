Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D375C25B67
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 08:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0932484D4C;
	Fri, 27 Oct 2023 08:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0932484D4C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHwZZeYw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u467fKNC4agJ; Fri, 27 Oct 2023 08:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38CE68495A;
	Fri, 27 Oct 2023 08:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38CE68495A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF1BC0071;
	Fri, 27 Oct 2023 08:18:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79D69C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5502484973
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5502484973
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhkzoR7hgxbB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:18:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3151C8495A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3151C8495A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698394716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfITEsiltCW1D4ziBTO0kE6Y9MiSeu2U9dsQlUHf3Iw=;
 b=bHwZZeYwiQEsRRfU/d4epJ2XH0PNd2JCFMsIOJamEKycoDEVrKBHYbz/TrjPAI+vU6y1cR
 UBhJpqaJFKOSgWN4bDw7FxNhSronpR2SrEho/9cJzok7uEaud4balYSYh5mI/z6xfU86Ha
 GecFEiEQCXN+zS5oSF0/APdWI4kPLXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-D6k8u6E4M9e-ePlz59-Grw-1; Fri, 27 Oct 2023 04:18:34 -0400
X-MC-Unique: D6k8u6E4M9e-ePlz59-Grw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40845fe2d1cso13823085e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 01:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698394713; x=1698999513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfITEsiltCW1D4ziBTO0kE6Y9MiSeu2U9dsQlUHf3Iw=;
 b=Pv0p5sZkRzqYbcG25/594nSpe3e0M7bqF6d0d75mSbL95TZZp7ZIvFXpW1r4yoAxQD
 feNK6ghpbkaWQB6swSiMtmlSdvrDfemrwnFkD593P3wsfIA4Pck3lzON8L0qqGYwcTf1
 Dmrj+IL+/o380YIelebh6gOGHdEAcHBnAmjVxDgfu0qZ7e0fBANZHPU8jKMMtDWAqhfs
 KacHaUkcvavuPdAuptkNLUfqUr/4rb2CM9M9+FEJhLUVCwitvBovNYpPDgQH7aoowgTr
 PbDyj1MFvd2smMcvgk+LGm8e3MwKpZiWsMMTWl5mFmRzWTm4pvnfT0WkTvWSvn1wwh/8
 NGZA==
X-Gm-Message-State: AOJu0YwsbZvlWdwgXPboIY6g1od/chJtOu4HCpV7rlwU1PG94lwtJQnG
 xFI1PmoswwyemKw1sRfMR/1MFHTiFCsCCgI1kkNEOIbofjOa8a6AYJ4kn+/vg8xCSKan6zSOTA9
 pDyeDTQgfM8Ohm20M4jatYLN20/DyloOT2etHWi/d/g==
X-Received: by 2002:a05:600c:259:b0:407:5a7d:45a8 with SMTP id
 25-20020a05600c025900b004075a7d45a8mr1874913wmj.31.1698394713567; 
 Fri, 27 Oct 2023 01:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd30H/q/ARe1qEofpRvdVhPCQXiC4/86WnpM7ULemfc8NYPGWUdTDK3eFZJVoncrARpqPh2Q==
X-Received: by 2002:a05:600c:259:b0:407:5a7d:45a8 with SMTP id
 25-20020a05600c025900b004075a7d45a8mr1874889wmj.31.1698394713124; 
 Fri, 27 Oct 2023 01:18:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 d17-20020adff851000000b0031ad5fb5a0fsm1211238wrq.58.2023.10.27.01.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:18:32 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:18:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <CAGxU2F6VAzdi4-Qs6DmabpPx+JKVHtCP1FJ2sSZ9730Kq-KLuQ@mail.gmail.com>
References: <20231026150154.3536433-1-syoshida@redhat.com>
 <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
MIME-Version: 1.0
In-Reply-To: <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bobbyeshleman@gmail.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 stefanha@redhat.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgMTA6MDHigK9BTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgMTI6
MDE6NTRBTSArMDkwMCwgU2hpZ2VydSBZb3NoaWRhIHdyb3RlOgo+ID5LTVNBTiByZXBvcnRlZCB0
aGUgZm9sbG93aW5nIHVuaW5pdC12YWx1ZSBhY2Nlc3MgaXNzdWU6Cj4gPgo+ID49PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID5CVUc6IEtNU0FO
OiB1bmluaXQtdmFsdWUgaW4gdmlydGlvX3RyYW5zcG9ydF9yZWN2X3BrdCsweDFkZmIvMHgyNmEw
IG5ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYzoxNDIxCj4gPiB2aXJ0aW9f
dHJhbnNwb3J0X3JlY3ZfcGt0KzB4MWRmYi8weDI2YTAgbmV0L3Ztd192c29jay92aXJ0aW9fdHJh
bnNwb3J0X2NvbW1vbi5jOjE0MjEKPiA+IHZzb2NrX2xvb3BiYWNrX3dvcmsrMHgzYmIvMHg1YTAg
bmV0L3Ztd192c29jay92c29ja19sb29wYmFjay5jOjEyMAo+ID4gcHJvY2Vzc19vbmVfd29yayBr
ZXJuZWwvd29ya3F1ZXVlLmM6MjYzMCBbaW5saW5lXQo+ID4gcHJvY2Vzc19zY2hlZHVsZWRfd29y
a3MrMHhmZjYvMHgxZTYwIGtlcm5lbC93b3JrcXVldWUuYzoyNzAzCj4gPiB3b3JrZXJfdGhyZWFk
KzB4ZWNhLzB4MTRkMCBrZXJuZWwvd29ya3F1ZXVlLmM6Mjc4NAo+ID4ga3RocmVhZCsweDNjYy8w
eDUyMCBrZXJuZWwva3RocmVhZC5jOjM4OAo+ID4gcmV0X2Zyb21fZm9yaysweDY2LzB4ODAgYXJj
aC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDcKPiA+IHJldF9mcm9tX2ZvcmtfYXNtKzB4MTEvMHgy
MCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjMwNAo+ID4KPiA+VW5pbml0IHdhcyBzdG9yZWQg
dG8gbWVtb3J5IGF0Ogo+ID4gdmlydGlvX3RyYW5zcG9ydF9zcGFjZV91cGRhdGUgbmV0L3Ztd192
c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jOjEyNzQgW2lubGluZV0KPiA+IHZpcnRpb190
cmFuc3BvcnRfcmVjdl9wa3QrMHgxZWU4LzB4MjZhMCBuZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFu
c3BvcnRfY29tbW9uLmM6MTQxNQo+ID4gdnNvY2tfbG9vcGJhY2tfd29yaysweDNiYi8weDVhMCBu
ZXQvdm13X3Zzb2NrL3Zzb2NrX2xvb3BiYWNrLmM6MTIwCj4gPiBwcm9jZXNzX29uZV93b3JrIGtl
cm5lbC93b3JrcXVldWUuYzoyNjMwIFtpbmxpbmVdCj4gPiBwcm9jZXNzX3NjaGVkdWxlZF93b3Jr
cysweGZmNi8weDFlNjAga2VybmVsL3dvcmtxdWV1ZS5jOjI3MDMKPiA+IHdvcmtlcl90aHJlYWQr
MHhlY2EvMHgxNGQwIGtlcm5lbC93b3JrcXVldWUuYzoyNzg0Cj4gPiBrdGhyZWFkKzB4M2NjLzB4
NTIwIGtlcm5lbC9rdGhyZWFkLmM6Mzg4Cj4gPiByZXRfZnJvbV9mb3JrKzB4NjYvMHg4MCBhcmNo
L3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0Nwo+ID4gcmV0X2Zyb21fZm9ya19hc20rMHgxMS8weDIw
IGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MzA0Cj4gPgo+ID5VbmluaXQgd2FzIGNyZWF0ZWQg
YXQ6Cj4gPiBzbGFiX3Bvc3RfYWxsb2NfaG9vaysweDEwNS8weGFkMCBtbS9zbGFiLmg6NzY3Cj4g
PiBzbGFiX2FsbG9jX25vZGUgbW0vc2x1Yi5jOjM0NzggW2lubGluZV0KPiA+IGttZW1fY2FjaGVf
YWxsb2Nfbm9kZSsweDVhMi8weGFmMCBtbS9zbHViLmM6MzUyMwo+ID4ga21hbGxvY19yZXNlcnZl
KzB4MTNjLzB4NGEwIG5ldC9jb3JlL3NrYnVmZi5jOjU1OQo+ID4gX19hbGxvY19za2IrMHgyZmQv
MHg3NzAgbmV0L2NvcmUvc2tidWZmLmM6NjUwCj4gPiBhbGxvY19za2IgaW5jbHVkZS9saW51eC9z
a2J1ZmYuaDoxMjg2IFtpbmxpbmVdCj4gPiB2aXJ0aW9fdnNvY2tfYWxsb2Nfc2tiIGluY2x1ZGUv
bGludXgvdmlydGlvX3Zzb2NrLmg6NjYgW2lubGluZV0KPiA+IHZpcnRpb190cmFuc3BvcnRfYWxs
b2Nfc2tiKzB4OTAvMHgxMWUwIG5ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24u
Yzo1OAo+ID4gdmlydGlvX3RyYW5zcG9ydF9yZXNldF9ub19zb2NrIG5ldC92bXdfdnNvY2svdmly
dGlvX3RyYW5zcG9ydF9jb21tb24uYzo5NTcgW2lubGluZV0KPiA+IHZpcnRpb190cmFuc3BvcnRf
cmVjdl9wa3QrMHgxMjc5LzB4MjZhMCBuZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnRfY29t
bW9uLmM6MTM4Nwo+ID4gdnNvY2tfbG9vcGJhY2tfd29yaysweDNiYi8weDVhMCBuZXQvdm13X3Zz
b2NrL3Zzb2NrX2xvb3BiYWNrLmM6MTIwCj4gPiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3Jr
cXVldWUuYzoyNjMwIFtpbmxpbmVdCj4gPiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGZmNi8w
eDFlNjAga2VybmVsL3dvcmtxdWV1ZS5jOjI3MDMKPiA+IHdvcmtlcl90aHJlYWQrMHhlY2EvMHgx
NGQwIGtlcm5lbC93b3JrcXVldWUuYzoyNzg0Cj4gPiBrdGhyZWFkKzB4M2NjLzB4NTIwIGtlcm5l
bC9rdGhyZWFkLmM6Mzg4Cj4gPiByZXRfZnJvbV9mb3JrKzB4NjYvMHg4MCBhcmNoL3g4Ni9rZXJu
ZWwvcHJvY2Vzcy5jOjE0Nwo+ID4gcmV0X2Zyb21fZm9ya19hc20rMHgxMS8weDIwIGFyY2gveDg2
L2VudHJ5L2VudHJ5XzY0LlM6MzA0Cj4gPgo+ID5DUFU6IDEgUElEOiAxMDY2NCBDb21tOiBrd29y
a2VyLzE6NSBOb3QgdGFpbnRlZCA2LjYuMC1yYzMtMDAxNDYtZzlmM2ViYmVmNzQ2ZiAjMwo+ID5I
YXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklP
UyAxLjE2LjItMS5mYzM4IDA0LzAxLzIwMTQKPiA+V29ya3F1ZXVlOiB2c29jay1sb29wYmFjayB2
c29ja19sb29wYmFja193b3JrCj4gPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Cj4gPgo+ID5UaGUgZm9sbG93aW5nIHNpbXBsZSByZXByb2R1Y2Vy
IGNhbiBjYXVzZSB0aGUgaXNzdWUgZGVzY3JpYmVkIGFib3ZlOgo+ID4KPiA+aW50IG1haW4odm9p
ZCkKPiA+ewo+ID4gIGludCBzb2NrOwo+ID4gIHN0cnVjdCBzb2NrYWRkcl92bSBhZGRyID0gewo+
ID4gICAgLnN2bV9mYW1pbHkgPSBBRl9WU09DSywKPiA+ICAgIC5zdm1fY2lkID0gVk1BRERSX0NJ
RF9BTlksCj4gPiAgICAuc3ZtX3BvcnQgPSAxMjM0LAo+ID4gIH07Cj4gPgo+ID4gIHNvY2sgPSBz
b2NrZXQoQUZfVlNPQ0ssIFNPQ0tfU1RSRUFNLCAwKTsKPiA+ICBjb25uZWN0KHNvY2ssIChzdHJ1
Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKTsKPiA+ICByZXR1cm4gMDsKPiA+fQo+
ID4KPiA+VGhpcyBpc3N1ZSBvY2N1cnMgYmVjYXVzZSB0aGUgYGJ1Zl9hbGxvY2AgYW5kIGBmd2Rf
Y250YCBmaWVsZHMgb2YgdGhlCj4gPmBzdHJ1Y3QgdmlydGlvX3Zzb2NrX2hkcmAgYXJlIG5vdCBp
bml0aWFsaXplZCB3aGVuIGEgbmV3IHNrYiBpcyBhbGxvY2F0ZWQKPiA+aW4gYHZpcnRpb190cmFu
c3BvcnRfYWxsb2Nfc2tiKClgLiBUaGlzIHBhdGNoIHJlc29sdmVzIHRoZSBpc3N1ZSBieQo+ID5p
bml0aWFsaXppbmcgdGhlc2UgZmllbGRzIGR1cmluZyBhbGxvY2F0aW9uLgo+ID4KPiA+Rml4ZXM6
IDcxZGM5ZWM5YWM3ZCAoInZpcnRpby92c29jazogcmVwbGFjZSB2aXJ0aW9fdnNvY2tfcGt0IHdp
dGggc2tfYnVmZiIpCj4KPiBDQ2luIEJvYmJ5LCB0aGUgb3JpZ2luYWwgYXV0aG9yLCBmb3IgYW55
IGFkZGl0aW9uYWwgY29tbWVudHMvY2hlY2tzLgo+Cj4gWWVhaCwgSSBzZWUsIGJlZm9yZSB0aGF0
IGNvbW1pdCB3ZSB1c2VkIGt6YWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUKPiBoZWFkZXIgc28gd2Ug
Zm9yZ290IHRvIHJlc2V0IHRoZXNlIDIgZmllbGRzLCBhbmQgY2hlY2tpbmcgdGhleSBhcmUKPiB0
aGUgb25seSAyIG1pc3NpbmcuCj4KPiBJIHdhcyB0aGlua2luZyBvZiBwdXR0aW5nIGEgbWVtc2V0
KGhkciwgMCwgc2l6ZW9mKCpoZHIpKSBpbgo+IHZpcnRpb192c29ja19hbGxvY19za2IoKSBidXQg
SSB0aGluayBpdCdzIGp1c3QgZXh0cmEgdW5uZWNlc3Nhcnkgd29yaywKPiBzaW5jZSBoZXJlIHdl
IHNldCBhbGwgdGhlIGZpZWxkcyAodGhhbmtzIHRvIHRoaXMgZml4KSwgaW4gdmhvc3QvdnNvY2su
Ywo+IHdlIGNvcHkgYWxsIHRoZSBoZWFkZXIgd2UgcmVjZWl2ZSBmcm9tIHRoZSBndWVzdCBhbmQg
aW4KPiB2aXJ0aW9fdHJhbnNwb3J0LmMgd2UgYWxyZWFkeSBzZXQgaXQgYWxsIHRvIDAgYmVjYXVz
ZSB3ZSBhcmUKPiBwcmVhbGxvY2F0aW5nIHRoZSByZWNlaXZlIGJ1ZmZlcnMuCj4KPiBTbyBJJ20g
ZmluZSB3aXRoIHRoaXMgZml4IQo+Cj4gPlNpZ25lZC1vZmYtYnk6IFNoaWdlcnUgWW9zaGlkYSA8
c3lvc2hpZGFAcmVkaGF0LmNvbT4KPiA+LS0tCj4gPiBuZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFu
c3BvcnRfY29tbW9uLmMgfCAyICsrCj4gPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
Cj4gPgo+ID5kaWZmIC0tZ2l0IGEvbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1v
bi5jIGIvbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jCj4gPmluZGV4IDM1
MmQwNDJiMTMwYi4uMTAyNjczYmVmMTg5IDEwMDY0NAo+ID4tLS0gYS9uZXQvdm13X3Zzb2NrL3Zp
cnRpb190cmFuc3BvcnRfY29tbW9uLmMKPiA+KysrIGIvbmV0L3Ztd192c29jay92aXJ0aW9fdHJh
bnNwb3J0X2NvbW1vbi5jCj4gPkBAIC02OCw2ICs2OCw4IEBAIHZpcnRpb190cmFuc3BvcnRfYWxs
b2Nfc2tiKHN0cnVjdCB2aXJ0aW9fdnNvY2tfcGt0X2luZm8gKmluZm8sCj4gPiAgICAgICBoZHIt
PmRzdF9wb3J0ICAgPSBjcHVfdG9fbGUzMihkc3RfcG9ydCk7Cj4gPiAgICAgICBoZHItPmZsYWdz
ICAgICAgPSBjcHVfdG9fbGUzMihpbmZvLT5mbGFncyk7Cj4gPiAgICAgICBoZHItPmxlbiAgICAg
ICAgPSBjcHVfdG9fbGUzMihsZW4pOwo+ID4rICAgICAgaGRyLT5idWZfYWxsb2MgID0gY3B1X3Rv
X2xlMzIoMCk7Cj4gPisgICAgICBoZHItPmZ3ZF9jbnQgICAgPSBjcHVfdG9fbGUzMigwKTsKPiA+
Cj4gPiAgICAgICBpZiAoaW5mby0+bXNnICYmIGxlbiA+IDApIHsKPiA+ICAgICAgICAgICAgICAg
cGF5bG9hZCA9IHNrYl9wdXQoc2tiLCBsZW4pOwo+ID4tLQo+ID4yLjQxLjAKPiA+Cj4KPiBSZXZp
ZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKc3l6Ym90
IGp1c3QgcmVwb3J0ZWQgdGhlIHNhbWUgWzFdLCBzaG91bGQgd2UgYWRkIHRoZSBmb2xsb3dpbmcg
dGFnPwoKUmVwb3J0ZWQtYnk6IHN5emJvdCswYzhjZTFkYTBhYzMxYWJiYWRjZEBzeXprYWxsZXIu
YXBwc3BvdG1haWwuY29tCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzAwMDAw
MDAwMDAwMDA4YjI5NDA2MDhhZTNjZTlAZ29vZ2xlLmNvbS8KClRoYW5rcywKU3RlZmFubwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
