Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E80BC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5223821A6;
	Tue, 28 Mar 2023 06:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5223821A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BcUIZsCe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMRe8MtczMoZ; Tue, 28 Mar 2023 06:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 394B58219E;
	Tue, 28 Mar 2023 06:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 394B58219E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15DA9C0036;
	Tue, 28 Mar 2023 06:31:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04AAAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3C0F60BBE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3C0F60BBE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BcUIZsCe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Klnnws5fi9nd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BB0B6114F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BB0B6114F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679985070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRG6B4+czq4eoI7Xt9v2emyqQ9AhCGwxkkBwMdXYjU=;
 b=BcUIZsCeKLmwRXCM6HC2QTPmI0hMzBVa3PeBGQBnrJoxpBb6R2JYxGHM3Tl7suiqLM+Hed
 Y8YOh8oRjvWGdLrl9JEPpPEUZ3rJ1QJKtuHyWKFE8+p/bNNy8MA5UVUCaUi+/gge727xV6
 k1YxI/wGMVr+AAbLPCPhCvsr1eRkg7k=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-HVAkTRqfPv6Rl7nPWjybdg-1; Tue, 28 Mar 2023 02:31:08 -0400
X-MC-Unique: HVAkTRqfPv6Rl7nPWjybdg-1
Received: by mail-ot1-f71.google.com with SMTP id
 o3-20020a9d7183000000b00697e5dc461bso761213otj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679985067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoRG6B4+czq4eoI7Xt9v2emyqQ9AhCGwxkkBwMdXYjU=;
 b=VbzBHLM8XAiMgAOkqCq6u4PNTQDfYevUYQ4BhKFJfwvE0CEsJsOLYMpLfjQen+gWwP
 +VDswOixfup9jl3S3x/oyvz2rQZQwj4mtch74Es/vXyt4Sxw0+evkj6wD3zHesbHzUOM
 H0tczy0n3lS2T/U/SPfn57PVofy+0YdJhAeNuafk5Zk4bTJziNiNYTXilxSL4DJ3d/1F
 ss4LQ63RvDQx0HqPFv+oyQIv16RWwHOtYgi8MTHT7WfVcv6CjIdWvtq/idiLIQU+P/D3
 zJZkio6+KZ9TIV1CPguLf7E1WbpytC7skuh8RtRSV2mi2dT1/G0cehko6uMAcYajQCB6
 Ld3g==
X-Gm-Message-State: AAQBX9c963RCjfO/taZj/v+G5EPlE+jLfqy9GGHB/vVigkF/+OF78OlY
 IJ1vwzZmCbyw+eIv+gkzsKnRqPpTpJi6vM9EEY+l7/pEW1oAJaxBGT/2F201Zy1A0gBLyJxWW+h
 KUgRjkuqElvyUtCNnBPYpRN1gUAwTmsd95VjuVhKT8tCIhmGoCCOH21vDqg==
X-Received: by 2002:a05:6870:57:b0:17e:e396:cce0 with SMTP id
 23-20020a056870005700b0017ee396cce0mr4276492oaz.9.1679985067525; 
 Mon, 27 Mar 2023 23:31:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8GK9E/TtNxSf6PCmLDIPSWrKmtP9ykz433Fuluh98IIy953QhctAFb80P8FvZakDEL4Slk/A99mRAf2xzNZbw=
X-Received: by 2002:a05:6870:57:b0:17e:e396:cce0 with SMTP id
 23-20020a056870005700b0017ee396cce0mr4276488oaz.9.1679985067294; Mon, 27 Mar
 2023 23:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230327040536.48338-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 14:30:56 +0800
Message-ID: <CACGkMEvdpYX9xozvrV4oNoP291nT_KtFxPnviPmvmzMLROKjLQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 07/11] virtio_ring: update document for
 virtqueue_add_*
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMTI6MDXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFVwZGF0ZSB0aGUgZG9jdW1lbnQgb2YgdmlydHF1
ZXVlX2FkZF8qIHNlcmllcyBBUEksIGFsbG93aW5nIHRoZSBjYWxsZXJzIHRvCj4gdXNlIHNnLT5k
bWFfYWRkcmVzcyB0byBwYXNzIHRoZSBkbWEgYWRkcmVzcyB0byBWaXJ0aW8gQ29yZS4KPgo+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAg
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE2ICsrKysrKysrKysrKysrKysKPiAgMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4
IGQ1ZGZmYmU1MDA3MC4uMGIxOThlYzNmZjkyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAg
LTIyMDIsNiArMjIwMiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkKHN0cnVj
dCB2aXJ0cXVldWUgKl92cSwKPiAgICogQ2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNhbGwg
dGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4gICAqIGF0IHRoZSBzYW1lIHRp
bWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gICAqCj4gKyAqIElmIHRoZSBjYWxsZXIgaGFzIGRv
bmUgZG1hIG1hcCB0aGVuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyBkbWEgYWRkcmVzcy4K
PiArICogSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBpcyB1c2VkLCB0aGVuIGFsbCBzZ3MgbXVzdCB1
c2Ugc2ctPmRtYV9hZGRyZXNzOwo+ICsgKiBvdGhlcndpc2UgYWxsIHNnLT5kbWFfYWRkcmVzcyBt
dXN0IGJlIE5VTEwuCj4gKyAqCj4gICAqIFJldHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9y
IChpZS4gRU5PU1BDLCBFTk9NRU0sIEVJTykuCj4gICAqLwo+ICBpbnQgdmlydHF1ZXVlX2FkZF9z
Z3Moc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+IEBAIC0yMjM2LDYgKzIyNDAsMTAgQEAgRVhQT1JU
X1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9zZ3MpOwo+ICAgKiBDYWxsZXIgbXVzdCBlbnN1cmUg
d2UgZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiAgICog
YXQgdGhlIHNhbWUgdGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiAgICoKPiArICogSWYgdGhl
IGNhbGxlciBoYXMgZG9uZSBkbWEgbWFwIHRoZW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNz
IGRtYSBhZGRyZXNzLgo+ICsgKiBJZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQsIHRoZW4g
YWxsIHNncyBtdXN0IHVzZSBzZy0+ZG1hX2FkZHJlc3M7Cj4gKyAqIG90aGVyd2lzZSBhbGwgc2ct
PmRtYV9hZGRyZXNzIG11c3QgYmUgTlVMTC4KPiArICoKPiAgICogUmV0dXJucyB6ZXJvIG9yIGEg
bmVnYXRpdmUgZXJyb3IgKGllLiBFTk9TUEMsIEVOT01FTSwgRUlPKS4KPiAgICovCj4gIGludCB2
aXJ0cXVldWVfYWRkX291dGJ1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwKPiBAQCAtMjI1OCw2ICsy
MjY2LDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfb3V0YnVmKTsKPiAgICog
Q2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1
ZSBvcGVyYXRpb25zCj4gICAqIGF0IHRoZSBzYW1lIHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCku
Cj4gICAqCj4gKyAqIElmIHRoZSBjYWxsZXIgaGFzIGRvbmUgZG1hIG1hcCB0aGVuIHVzZSBzZy0+
ZG1hX2FkZHJlc3MgdG8gcGFzcyBkbWEgYWRkcmVzcy4KPiArICogSWYgb25lIHNnLT5kbWFfYWRk
cmVzcyBpcyB1c2VkLCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2Ugc2ctPmRtYV9hZGRyZXNzOwo+ICsg
KiBvdGhlcndpc2UgYWxsIHNnLT5kbWFfYWRkcmVzcyBtdXN0IGJlIE5VTEwuCj4gKyAqCj4gICAq
IFJldHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yIChpZS4gRU5PU1BDLCBFTk9NRU0sIEVJ
TykuCj4gICAqLwo+ICBpbnQgdmlydHF1ZXVlX2FkZF9pbmJ1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2
cSwKPiBAQCAtMjI4MSw2ICsyMjkzLDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9h
ZGRfaW5idWYpOwo+ICAgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlzIHdp
dGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiAgICogYXQgdGhlIHNhbWUgdGltZSAoZXhj
ZXB0IHdoZXJlIG5vdGVkKS4KPiAgICoKPiArICogSWYgdGhlIGNhbGxlciBoYXMgZG9uZSBkbWEg
bWFwIHRoZW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIGRtYSBhZGRyZXNzLgo+ICsgKiBJ
ZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQsIHRoZW4gYWxsIHNncyBtdXN0IHVzZSBzZy0+
ZG1hX2FkZHJlc3M7Cj4gKyAqIG90aGVyd2lzZSBhbGwgc2ctPmRtYV9hZGRyZXNzIG11c3QgYmUg
TlVMTC4KPiArICoKPiAgICogUmV0dXJucyB6ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IgKGllLiBF
Tk9TUEMsIEVOT01FTSwgRUlPKS4KPiAgICovCj4gIGludCB2aXJ0cXVldWVfYWRkX2luYnVmX2N0
eChzdHJ1Y3QgdmlydHF1ZXVlICp2cSwKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
