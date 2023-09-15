Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE54AEE6424
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 07:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7285F41030;
	Fri, 15 Sep 2023 07:04:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7285F41030
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qzf5fZVX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvRt59kuctRZ; Fri, 15 Sep 2023 07:04:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3B8040105;
	Fri, 15 Sep 2023 07:04:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3B8040105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEB5C0039;
	Fri, 15 Sep 2023 07:04:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16392C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 07:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0E136102C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 07:04:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0E136102C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qzf5fZVX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KCea4gEVHIc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 07:04:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A797E60EA1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 07:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A797E60EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694761459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0ZKX9+ZDfk8TG2B9BpARJtWjXCRBlMo1JDLbdvybKk=;
 b=Qzf5fZVX+gVQ18fxWHy9bzwTEUHsz0JXk8zNAXaH336MUCntgCL/9aMwd6UVKx4MrF+He7
 LSpr3AUQpK7xS16Nh8eYYpM/e3x0L2uhEk4LsAojnXD4tZAl0H9bxVHZSup2dSITE3EdSo
 1NVYEGVQkxJXffFNTCRrNSAP/Nh9qDg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-zvpRxDOpP7iWxD4bKUVv4A-1; Fri, 15 Sep 2023 03:04:17 -0400
X-MC-Unique: zvpRxDOpP7iWxD4bKUVv4A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5009121067cso2142341e87.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 00:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694761456; x=1695366256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0ZKX9+ZDfk8TG2B9BpARJtWjXCRBlMo1JDLbdvybKk=;
 b=rICpf092Phse/hPaEyOMoKeldubv2J6n9mt2//CN34xm0bP+4900cWRe4PMjOqgw9G
 E+ONR48pEsqJBwdG0x3UdiBHzircbso3L7cRdlBtzA1cKbcVNaTDTUH6vozI0nBAbOE/
 5jU4W9p9AKZuBAB5sXJnO8vIPp7nGm4hB0TGcMuxjtqkJn7oKi1am+losGdWdaezdLlw
 XfOithawrc2/P3AHA/v9hboOiDiW7kUvPfmBrZwP6avyZ3XYNn3ebORy/RsJE2rs+/Hu
 0gDdQb6d/Xkp+O+bsVa25tqLTmxGDHuveR6jZkMkXSPJW/JqQXMpNy8fHPtF8BV4CcOM
 dcIg==
X-Gm-Message-State: AOJu0YxYOMZJb3xprerqa/nfX1om2UbDDZCq6n7H+GwgdE1dTXUJ13jZ
 uKi84SvdE1wIGDBv534ONQrZ2s8+q/g1kKvPgTeGGSiN4H8MNiSTVWFR7T5NMn8EV8gHaWqVBGj
 3WKKnVvQOSP0IEvlSEASUt7c6aSu8h+K0uLJiAXuSm8jS5fTm80PE9VyLVA==
X-Received: by 2002:a05:6512:2149:b0:4fd:d002:ddad with SMTP id
 s9-20020a056512214900b004fdd002ddadmr643740lfr.12.1694761456390; 
 Fri, 15 Sep 2023 00:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtta3SijY3RzwwYuYFpIpWRyB53UbRzdNZ6fENanosL+1QizYjo1V+WEDWxW8bolgTjIL8Pmv4Uv9BVbuxiSY=
X-Received: by 2002:a05:6512:2149:b0:4fd:d002:ddad with SMTP id
 s9-20020a056512214900b004fdd002ddadmr643715lfr.12.1694761456031; Fri, 15 Sep
 2023 00:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230908093009.540763-1-ming.lei@redhat.com>
 <58227846-6b73-46ef-957f-d9b1e0451899@kernel.dk>
 <ZPsxCYFgZjIIeaBk@fedora> <0f85a6b5-3ba6-4b77-bb7d-79f365dbb44c@kernel.dk>
 <ZPs81IAYfB8J78Pv@fedora>
In-Reply-To: <ZPs81IAYfB8J78Pv@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Sep 2023 15:04:05 +0800
Message-ID: <CACGkMEvP=f1mB=01CDOhHaDLNL9espKPrUffgHEdBVkW4fo=pw@mail.gmail.com>
Subject: Re: [PATCH V3] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
To: Ming Lei <ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
 mst@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org, io-uring@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
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

T24gRnJpLCBTZXAgOCwgMjAyMyBhdCAxMToyNeKAr1BNIE1pbmcgTGVpIDxtaW5nLmxlaUByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgU2VwIDA4LCAyMDIzIGF0IDA4OjQ0OjQ1QU0gLTA2
MDAsIEplbnMgQXhib2Ugd3JvdGU6Cj4gPiBPbiA5LzgvMjMgODozNCBBTSwgTWluZyBMZWkgd3Jv
dGU6Cj4gPiA+IE9uIEZyaSwgU2VwIDA4LCAyMDIzIGF0IDA3OjQ5OjUzQU0gLTA2MDAsIEplbnMg
QXhib2Ugd3JvdGU6Cj4gPiA+PiBPbiA5LzgvMjMgMzozMCBBTSwgTWluZyBMZWkgd3JvdGU6Cj4g
PiA+Pj4gZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmlu
Zy5jCj4gPiA+Pj4gaW5kZXggYWQ2MzY5NTRhYmFlLi45NWEzZDMxYTFlZjEgMTAwNjQ0Cj4gPiA+
Pj4gLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYwo+ID4gPj4+ICsrKyBiL2lvX3VyaW5nL2lvX3Vy
aW5nLmMKPiA+ID4+PiBAQCAtMTkzMCw2ICsxOTMwLDEwIEBAIHZvaWQgaW9fd3Ffc3VibWl0X3dv
cmsoc3RydWN0IGlvX3dxX3dvcmsgKndvcmspCj4gPiA+Pj4gICAgICAgICAgIH0KPiA+ID4+PiAg
IH0KPiA+ID4+Pgo+ID4gPj4+ICsgLyogSXQgaXMgZnJhZ2lsZSB0byBibG9jayBQT0xMRUQgSU8s
IHNvIHN3aXRjaCB0byBOT05fQkxPQ0sgKi8KPiA+ID4+PiArIGlmICgocmVxLT5jdHgtPmZsYWdz
ICYgSU9SSU5HX1NFVFVQX0lPUE9MTCkgJiYgZGVmLT5pb3BvbGxfcXVldWUpCj4gPiA+Pj4gKyAg
ICAgICAgIGlzc3VlX2ZsYWdzIHw9IElPX1VSSU5HX0ZfTk9OQkxPQ0s7Cj4gPiA+Pj4gKwo+ID4g
Pj4KPiA+ID4+IEkgdGhpbmsgdGhpcyBjb21tZW50IGRlc2VydmVzIHRvIGJlIG1vcmUgZGVzY3Jp
cHRpdmUuIE5vcm1hbGx5IHdlCj4gPiA+PiBhYnNvbHV0ZWx5IGNhbm5vdCBibG9jayBmb3IgcG9s
bGVkIElPLCBpdCdzIG9ubHkgT0sgaGVyZSBiZWNhdXNlIGlvLXdxCj4gPiA+Cj4gPiA+IFllYWgs
IHdlIGRvbid0IGRvIHRoYXQgdW50aWwgY29tbWl0IDJiYzA1NzY5MjU5OSAoImJsb2NrOiBkb24n
dCBtYWtlIFJFUV9QT0xMRUQKPiA+ID4gaW1wbHkgUkVRX05PV0FJVCIpIHdoaWNoIGFjdHVhbGx5
IHB1c2ggdGhlIHJlc3BvbnNpYmlsaXR5L3Jpc2sgdXAgdG8KPiA+ID4gaW9fdXJpbmcuCj4gPiA+
Cj4gPiA+PiBpcyB0aGUgaXNzdWVyIGFuZCBub3QgbmVjZXNzYXJpbHkgdGhlIHBvbGxlciBvZiBp
dC4gVGhhdCBnZW5lcmFsbHkgZmFsbHMKPiA+ID4+IHVwb24gdGhlIG9yaWdpbmFsIGlzc3VlciB0
byBwb2xsIHRoZXNlIHJlcXVlc3RzLgo+ID4gPj4KPiA+ID4+IEkgdGhpbmsgdGhpcyBzaG91bGQg
YmUgYSBzZXBhcmF0ZSBjb21taXQsIGNvbWluZyBiZWZvcmUgdGhlIG1haW4gZml4Cj4gPiA+PiB3
aGljaCBpcyBiZWxvdy4KPiA+ID4KPiA+ID4gTG9va3MgZmluZSwgYWN0dWFsbHkgSU9fVVJJTkdf
Rl9OT05CTE9DSyBjaGFuZ2UgaXNuJ3QgYSBtdXN0LCBhbmQgdGhlCj4gPiA+IGFwcHJvYWNoIGlu
IFYyIGRvZXNuJ3QgbmVlZCB0aGlzIGNoYW5nZS4KPiA+ID4KPiA+ID4+Cj4gPiA+Pj4gQEAgLTMz
NjMsNiArMzM2NywxMiBAQCBfX2NvbGQgdm9pZCBpb191cmluZ19jYW5jZWxfZ2VuZXJpYyhib29s
IGNhbmNlbF9hbGwsIHN0cnVjdCBpb19zcV9kYXRhICpzcWQpCj4gPiA+Pj4gICAgICAgICAgIGZp
bmlzaF93YWl0KCZ0Y3R4LT53YWl0LCAmd2FpdCk7Cj4gPiA+Pj4gICB9IHdoaWxlICgxKTsKPiA+
ID4+Pgo+ID4gPj4+ICsgLyoKPiA+ID4+PiArICAqIFJlYXAgZXZlbnRzIGZyb20gZWFjaCBjdHgs
IG90aGVyd2lzZSB0aGVzZSByZXF1ZXN0cyBtYXkgdGFrZQo+ID4gPj4+ICsgICogcmVzb3VyY2Vz
IGFuZCBwcmV2ZW50IG90aGVyIGNvbnRleHRzIGZyb20gYmVpbmcgbW92ZWQgb24uCj4gPiA+Pj4g
KyAgKi8KPiA+ID4+PiArIHhhX2Zvcl9lYWNoKCZ0Y3R4LT54YSwgaW5kZXgsIG5vZGUpCj4gPiA+
Pj4gKyAgICAgICAgIGlvX2lvcG9sbF90cnlfcmVhcF9ldmVudHMobm9kZS0+Y3R4KTsKPiA+ID4+
Cj4gPiA+PiBUaGUgbWFpbiBpc3N1ZSBoZXJlIGlzIHRoYXQgaWYgc29tZW9uZSBpc24ndCBwb2xs
aW5nIGZvciB0aGVtLCB0aGVuIHdlCj4gPiA+Cj4gPiA+IFRoYXQgaXMgYWN0dWFsbHkgd2hhdCB0
aGlzIHBhdGNoIGlzIGFkZHJlc3NpbmcsIDotKQo+ID4KPiA+IFJpZ2h0LCB0aGF0IHBhcnQgaXMg
b2J2aW91cyA6KQo+ID4KPiA+ID4+IGdldCB0byB3YWl0IGZvciBhIHRpbWVvdXQgYmVmb3JlIHRo
ZXkgY29tcGxldGUuIFRoaXMgY2FuIGRlbGF5IGV4aXQsIGZvcgo+ID4gPj4gZXhhbXBsZSwgYXMg
d2UncmUgbm93IGp1c3Qgd2FpdGluZyAzMCBzZWNvbmRzIChvciB3aGF0ZXZlciB0aGUgdGltZW91
dAo+ID4gPj4gaXMgb24gdGhlIHVuZGVybHlpbmcgZGV2aWNlKSBmb3IgdGhlbSB0byBnZXQgdGlt
ZWQgb3V0IGJlZm9yZSBleGl0IGNhbgo+ID4gPj4gZmluaXNoLgo+ID4gPgo+ID4gPiBGb3IgdGhl
IGlzc3VlIG9uIG51bGxfYmxrLCBkZXZpY2UgdGltZW91dCBoYW5kbGVyIHByb3ZpZGVzCj4gPiA+
IGZvcndhcmQtcHJvZ3Jlc3MsIHN1Y2ggYXMgcmVxdWVzdHMgYXJlIHJlbGVhc2VkLCBzbyBuZXcg
SU8gY2FuIGJlCj4gPiA+IGhhbmRsZWQuCj4gPiA+Cj4gPiA+IEhvd2V2ZXIsIG5vdCBhbGwgZGV2
aWNlcyBzdXBwb3J0IHRpbWVvdXQsIHN1Y2ggYXMgdmlydGlvIGRldmljZS4KPiA+Cj4gPiBUaGF0
J3MgYSBidWcgaW4gdGhlIGRyaXZlciwgeW91IGNhbm5vdCBzYW5lbHkgc3VwcG9ydCBwb2xsZWQg
SU8gYW5kIG5vdAo+ID4gYmUgYWJsZSB0byBkZWFsIHdpdGggdGltZW91dHMuIFNvbWVvbmUgSEFT
IHRvIHJlYXAgdGhlIHJlcXVlc3RzIGFuZAo+ID4gdGhlcmUgYXJlIG9ubHkgdHdvIHRoaW5ncyB0
aGF0IGNhbiBkbyB0aGF0IC0gdGhlIGFwcGxpY2F0aW9uIGRvaW5nIHRoZQo+ID4gcG9sbGVkIElP
LCBvciBpZiB0aGF0IGRvZXNuJ3QgaGFwcGVuLCBhIHRpbWVvdXQuCj4KPiBPSywgdGhlbiBkZXZp
Y2UgZHJpdmVyIHRpbWVvdXQgaGFuZGxlciBoYXMgbmV3IHJlc3BvbnNpYmlsaXR5IG9mIGNvdmVy
aW5nCj4gdXNlcnNwYWNlIGFjY2lkZW50LCA6LSkKPgo+IFdlIG1heSBkb2N1bWVudCB0aGlzIHJl
cXVpcmVtZW50IGZvciBkcml2ZXIuCj4KPiBTbyBmYXIgdGhlIG9ubHkgb25lIHNob3VsZCBiZSB2
aXJ0aW8tYmxrLCBhbmQgdGhlIHR3byB2aXJ0aW8gc3RvcmFnZQo+IGRyaXZlcnMgbmV2ZXIgaW1w
bGVtZW50IHRpbWVvdXQgaGFuZGxlci4KPgoKQWRkaW5nIFN0ZWZhbiBmb3IgbW9yZSBjb21tZW50
cy4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
