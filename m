Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A04C54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 10:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81602415DF;
	Mon, 30 Jan 2023 10:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81602415DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HTMI6ZnW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2m5kQbfevNHV; Mon, 30 Jan 2023 10:29:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B8F94159F;
	Mon, 30 Jan 2023 10:29:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B8F94159F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71EB2C0033;
	Mon, 30 Jan 2023 10:29:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE275C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 10:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87C35415DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 10:29:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87C35415DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKKKKUnWdRnv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 10:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B0C74159F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B0C74159F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675074590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUnPVEBBxIK0dhVU8A6ATxwGvwjkqSeEKSc364XgM28=;
 b=HTMI6ZnWoI360Yk5TTh/hsCMDHrzh+MbfnXetRtDy91fp7+KwTXo/sRUSoQKV+Bef1o+el
 r4g/NVj0bDjF+4Wy31idE5pD1n9enkmVlN4o79EqzFtwRBkDERePqGvHImFCYWnlnbE+BB
 nG2i2tqV/Ie2tkvIISYF2J1Rw+ZjSyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-3DQuJMdTOjKgJ4YZAzR1Yw-1; Mon, 30 Jan 2023 05:29:49 -0500
X-MC-Unique: 3DQuJMdTOjKgJ4YZAzR1Yw-1
Received: by mail-ed1-f69.google.com with SMTP id
 l17-20020a056402255100b00472d2ff0e59so7913809edb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 02:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NUnPVEBBxIK0dhVU8A6ATxwGvwjkqSeEKSc364XgM28=;
 b=Fg2lMxpVWXRiEDHtKx4hEEJ8etz2v2oyDpVTM/Vad6r+XI3nvfl2FVHVJCVQt5g/9y
 DDaEVHO4OuZh9fJ9vL8wy22U1cik5R5wLCJkAWBhuM8r0yqS93bzEvZhV2emsitQ21KJ
 313I3EBsGQqkW4RKOpetz2tdxmEI69XRq2u3xugbFr2VUGnNHf4p62MLmX8OKP6cAhlv
 pRpjic3I354hQ4PsXNy8vf4wTjsi12U4wo6h6bsUIMnTd5zUy2k4vHu4RovxG/Gv1zHz
 6SeX27vjKgHfjqV8mk3MGRj3pVTrGgBqppCCZ4ibNAUwdbSwCJyaFu4NOQ+m4k0/+t0B
 3m/w==
X-Gm-Message-State: AO0yUKXcPvaiYumIJ3G8w9IM2tmYeyBg/11jSDnQ/1jOAhpMkb4Z3rMV
 A0lmNSpiOro2q+Ou4w8j3t/gw+X+7s3G9tCeHusU3loDrTIVwZXw/GhHVsRIIOCmgiUH6DvTqa+
 FwOtDNAdWalCltmsmKMImosXiKVg/8tUyEUCdagUvoQ==
X-Received: by 2002:a17:907:1c11:b0:889:5861:ad1e with SMTP id
 nc17-20020a1709071c1100b008895861ad1emr2966819ejc.72.1675074586094; 
 Mon, 30 Jan 2023 02:29:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9vr6xJ4tOlsEGn0tpljaQxv0SWAz4CKUa/rlY4lr4aGez7CA131y4YgeYOklFXYHFLfxVV9g==
X-Received: by 2002:a17:907:1c11:b0:889:5861:ad1e with SMTP id
 nc17-20020a1709071c1100b008895861ad1emr2966802ejc.72.1675074585807; 
 Mon, 30 Jan 2023 02:29:45 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 n21-20020a170906089500b0087ba1ed4a58sm5439689eje.191.2023.01.30.02.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 02:29:45 -0800 (PST)
Date: Mon, 30 Jan 2023 05:29:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vhost-net: support VIRTIO_F_RING_RESET
Message-ID: <20230130052929-mutt-send-email-mst@kernel.org>
References: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
 <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
 <1675064346.4139252-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675064346.4139252-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Kangjie Xu <kangjie.xu@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hengqi@linux.alibaba.com,
 bpf@vger.kernel.org
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMDM6Mzk6MDZQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIE1vbiwgNSBTZXAgMjAyMiAxNjozMjoxOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIwMjIvOC8yNSAxNjo1NiwgS2FuZ2pp
ZSBYdSDlhpnpgZM6Cj4gPiA+IEFkZCBWSVJUSU9fRl9SSU5HX1JFU0VULCB3aGljaCBpbmRpY2F0
ZXMgdGhhdCB0aGUgZHJpdmVyIGNhbiByZXNldCBhCj4gPiA+IHF1ZXVlIGluZGl2aWR1YWxseS4K
PiA+ID4KPiA+ID4gVklSVElPX0ZfUklOR19SRVNFVCBmZWF0dXJlIGlzIGFkZGVkIHRvIHZpcnRp
by1zcGVjIDEuMi4gVGhlIHJlbGV2YW50Cj4gPiA+IGluZm9ybWF0aW9uIGlzIGluCj4gPiA+ICAg
ICAgb2FzaXMtdGNzL3ZpcnRpby1zcGVjIzEyNAo+ID4gPiAgICAgIG9hc2lzLXRjcy92aXJ0aW8t
c3BlYyMxMzkKPiA+ID4KPiA+ID4gVGhlIGltcGxlbWVudGF0aW9uIG9ubHkgYWRkcyB0aGUgZmVh
dHVyZSBiaXQgaW4gc3VwcG9ydGVkIGZlYXR1cmVzLiBJdAo+ID4gPiBkb2VzIG5vdCByZXF1aXJl
IGFueSBvdGhlciBjaGFuZ2VzIGJlY2F1c2Ugd2UgcmV1c2UgdGhlIGV4aXN0aW5nIHZob3N0Cj4g
PiA+IHByb3RvY29sLgo+ID4gPgo+ID4gPiBUaGUgdmlydHF1ZXVlIHJlc2V0IHByb2Nlc3MgY2Fu
IGJlIGNvbmNsdWRlZCBhcyB0d28gcGFydHM6Cj4gPiA+IDEuIFRoZSBkcml2ZXIgY2FuIHJlc2V0
IGEgdmlydHF1ZXVlLiBXaGVuIGl0IGlzIHRyaWdnZXJlZCwgd2UgdXNlIHRoZQo+ID4gPiBzZXRf
YmFja2VuZCB0byBkaXNhYmxlIHRoZSB2aXJ0cXVldWUuCj4gPiA+IDIuIEFmdGVyIHRoZSB2aXJ0
cXVldWUgaXMgZGlzYWJsZWQsIHRoZSBkcml2ZXIgbWF5IG9wdGlvbmFsbHkgcmUtZW5hYmxlCj4g
PiA+IGl0LiBUaGUgcHJvY2VzcyBpcyBiYXNpY2FsbHkgc2ltaWxhciB0byB3aGVuIHRoZSBkZXZp
Y2UgaXMgc3RhcnRlZCwKPiA+ID4gZXhjZXB0IHRoYXQgdGhlIHJlc3RhcnQgcHJvY2VzcyBkb2Vz
IG5vdCBuZWVkIHRvIHNldCBmZWF0dXJlcyBhbmQgc2V0Cj4gPiA+IG1lbSB0YWJsZSBzaW5jZSB0
aGV5IGRvIG5vdCBjaGFuZ2UuIFFFTVUgd2lsbCBzZW5kIG1lc3NhZ2VzIGNvbnRhaW5pbmcKPiA+
ID4gc2l6ZSwgYmFzZSwgYWRkciwga2lja2ZkIGFuZCBjYWxsZmQgb2YgdGhlIHZpcnRxdWV1ZSBp
biBvcmRlci4KPiA+ID4gU3BlY2lmaWNhbGx5LCB0aGUgaG9zdCBrZXJuZWwgd2lsbCByZWNlaXZl
IHRoZXNlIG1lc3NhZ2VzIGluIG9yZGVyOgo+ID4gPiAgICAgIGEuIFZIT1NUX1NFVF9WUklOR19O
VU0KPiA+ID4gICAgICBiLiBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+ID4gPiAgICAgIGMuIFZIT1NU
X1NFVF9WUklOR19BRERSCj4gPiA+ICAgICAgZC4gVkhPU1RfU0VUX1ZSSU5HX0tJQ0sKPiA+ID4g
ICAgICBlLiBWSE9TVF9TRVRfVlJJTkdfQ0FMTAo+ID4gPiAgICAgIGYuIFZIT1NUX05FVF9TRVRf
QkFDS0VORAo+ID4gPiBGaW5hbGx5LCBhZnRlciB3ZSB1c2Ugc2V0X2JhY2tlbmQgdG8gYXR0YWNo
IHRoZSB2aXJ0cXVldWUsIHRoZSB2aXJ0cXVldWUKPiA+ID4gd2lsbCBiZSBlbmFibGVkIGFuZCBz
dGFydCB0byB3b3JrLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5namllIFh1IDxrYW5n
amllLnh1QGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4KPiA+Cj4gPiBBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAKPiBAbXN0Cj4gCj4gRG8gd2UgbWlzcyB0aGlz
Pwo+IAo+IFRoYW5rcy4KCkkgZGlkLCB0aGFua3MhIHRhZ2dlZCBub3cuCgo+ID4KPiA+Cj4gPiA+
IC0tLQo+ID4gPgo+ID4gPiBUZXN0IGVudmlyb25tZW50IGFuZCBtZXRob2Q6Cj4gPiA+ICAgICAg
SG9zdDogNS4xOS4wLXJjMwo+ID4gPiAgICAgIFFlbXU6IFFFTVUgZW11bGF0b3IgdmVyc2lvbiA3
LjAuNTAgKFdpdGggdnEgcnNldCBzdXBwb3J0KQo+ID4gPiAgICAgIEd1ZXN0OiA1LjE5LjAtcmMz
IChXaXRoIHZxIHJlc2V0IHN1cHBvcnQpCj4gPiA+ICAgICAgVGVzdCBDbWQ6IGV0aHRvb2wgLWcg
ZXRoMTsgZXRodG9vbCAtRyBldGgxIHJ4ICQxIHR4ICQyOyBldGh0b29sIC1nIGV0aDE7Cj4gPiA+
Cj4gPiA+ICAgICAgVGhlIGRydmllciBjYW4gcmVzaXplIHRoZSB2aXJ0aW8gcXVldWUsIHRoZW4g
dmlydGlvIHF1ZXVlIHJlc2V0IGZ1bmN0aW9uIHNob3VsZAo+ID4gPiAgICAgIGJlIHRyaWdnZXJl
ZC4KPiA+ID4KPiA+ID4gICAgICBUaGUgZGVmYXVsdCBpcyBzcGxpdCBtb2RlLCBtb2RpZnkgUWVt
dSB2aXJ0aW8tbmV0IHRvIGFkZCBQQUNLRUQgZmVhdHVyZSB0bwo+ID4gPiAgICAgIHRlc3QgcGFj
a2VkIG1vZGUuCj4gPiA+Cj4gPiA+IEd1ZXN0IEtlcm5lbCBQYXRjaDoKPiA+ID4gICAgICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9icGYvMjAyMjA4MDEwNjM5MDIuMTI5MzI5LTEteHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20vCj4gPiA+Cj4gPiA+IFFFTVUgUGF0Y2g6Cj4gPiA+ICAgICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jb3Zlci4xNjYxNDE0MzQ1LmdpdC5rYW5n
amllLnh1QGxpbnV4LmFsaWJhYmEuY29tLwo+ID4gPgo+ID4gPiBMb29raW5nIGZvcndhcmQgdG8g
eW91ciByZXZpZXcgYW5kIGNvbW1lbnRzLiBUaGFua3MuCj4gPiA+Cj4gPiA+ICAgZHJpdmVycy92
aG9zdC9uZXQuYyB8IDMgKystCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9u
ZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+ID4gaW5kZXggNjhlNGVjZDFjYzBlLi44YTM0
OTI4ZDRmZWYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+ID4gKysr
IGIvZHJpdmVycy92aG9zdC9uZXQuYwo+ID4gPiBAQCAtNzMsNyArNzMsOCBAQCBlbnVtIHsKPiA+
ID4gICAJVkhPU1RfTkVUX0ZFQVRVUkVTID0gVkhPU1RfRkVBVFVSRVMgfAo+ID4gPiAgIAkJCSAo
MVVMTCA8PCBWSE9TVF9ORVRfRl9WSVJUSU9fTkVUX0hEUikgfAo+ID4gPiAgIAkJCSAoMVVMTCA8
PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSB8Cj4gPiA+IC0JCQkgKDFVTEwgPDwgVklSVElPX0Zf
QUNDRVNTX1BMQVRGT1JNKQo+ID4gPiArCQkJICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSkgfAo+ID4gPiArCQkJICgxVUxMIDw8IFZJUlRJT19GX1JJTkdfUkVTRVQpCj4gPiA+ICAg
fTsKPiA+ID4KPiA+ID4gICBlbnVtIHsKPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
