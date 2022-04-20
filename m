Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557EFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 06:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0F68418B7;
	Wed, 20 Apr 2022 06:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRjLkPINPrsq; Wed, 20 Apr 2022 06:35:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00D2A41728;
	Wed, 20 Apr 2022 06:35:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB0EFC002F;
	Wed, 20 Apr 2022 06:35:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A50BC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74F2861160
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nT7OSjZGw6Jt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:35:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BA3461020
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650436554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hSQFDcFoJliXzC6l/dCXOZaMTthfyFp7Qtn7q49rsw=;
 b=GU50fD/NY1bkPz8OeKnxg93PqXaq4FHPEBOlxUeYRzTbUPP5FgtFi4VTi2aPXRYZ4Cr+rK
 6MS8BgtOoWJCb3uW9vUyqWQOeFgwQdpoyGsGxrqlATmbve8AtwEqcNar8kqlDtMbSdHvMo
 lmx/jQw2QosCr6g4RVHjwe22Fd6WpWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-4OzjNZFIObO0VoMwGYXEHA-1; Wed, 20 Apr 2022 02:35:53 -0400
X-MC-Unique: 4OzjNZFIObO0VoMwGYXEHA-1
Received: by mail-wm1-f71.google.com with SMTP id
 d13-20020a05600c3acd00b0038ff865c043so2487550wms.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 23:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5hSQFDcFoJliXzC6l/dCXOZaMTthfyFp7Qtn7q49rsw=;
 b=VmCexlZ3ATvnQiedJedPYvTVwMEcCRZKyS/dtDUQ0OFX1OM7/ZMbE3Lxdm9G85nxdq
 XyuOaNAyxcqeJxb4SOvvmh9MFrc+yq3oc8DKfetGg8HVzTzo1vRF44cdr8OCTvyDpcP+
 lFBsWbwMgSb6rkstM09zpqsytZIF5nddcnHALkjjuV/Qi+pN/FWEo8JrgraCHCgLOnBK
 ULhGIHs2P/wAvQocL85YvNWBU5ZoPLfhL5ajlmDpRBlfvr6+Js0n9Di9cE3nIv1HWPiT
 r++6/nhdX02fI9Jtyt5HF8lnMHb07pPtMAF0c/rmmQsZGKMZYfNZTiEbHFHoDk/9A1FY
 YHPw==
X-Gm-Message-State: AOAM530oK+OrIzPh7GVDOnya1H2ppsV/0hpi3TwDc26Wmxc0Iesjf5Q7
 4PQMPgKsy5rTzAqcivrGQkGCUjA5DiGMKfTIRtMzuaLlPnfbmwSfaizM9lMaMxVfVhjoMzWL7GN
 Af92c9bgjLUZtWDMgmZ5hY0ppU5n+o1ocl55SY1u+mg==
X-Received: by 2002:a05:6000:1869:b0:20a:78e2:522e with SMTP id
 d9-20020a056000186900b0020a78e2522emr14330697wri.340.1650436552249; 
 Tue, 19 Apr 2022 23:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWceEx9tM1Li9LiINDaeGxOLUmYbpQYsZxdWWkUUj0ZwkniPXDFUQZJmJhELMRpwNvNWKf4Q==
X-Received: by 2002:a05:6000:1869:b0:20a:78e2:522e with SMTP id
 d9-20020a056000186900b0020a78e2522emr14330684wri.340.1650436552004; 
 Tue, 19 Apr 2022 23:35:52 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 r10-20020a7bc08a000000b0039049f8b3f9sm15999998wmh.27.2022.04.19.23.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 23:35:50 -0700 (PDT)
Date: Wed, 20 Apr 2022 02:35:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
Message-ID: <20220420023511-mutt-send-email-mst@kernel.org>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 Maciej =?utf-8?Q?Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMTE6MDc6MDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAxMTowMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAw
NDoxMjozMVBNICswMjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90ZToKPiA+ID4gSGVsbG8sCj4g
PiA+Cj4gPiA+IEkndmUgZm91bmQgYSBwcm9ibGVtIGluIHZpcnRpby1uZXQgZHJpdmVyLgo+ID4g
PiBJZiB2aXJ0aW8tbmV0IGJhY2tlbmQgZGV2aWNlIGFkdmVydGlzZXMgZ3Vlc3Qgb2ZmbG9hZCBm
ZWF0dXJlcywgdGhlcmUgaXMKPiA+ID4gYW4gdW5wZXJtaXR0ZWQgdXNhZ2Ugb2YgY29udHJvbCB2
aXJ0cXVldWUgYmVmb3JlIGRyaXZlciBpcyBpbml0aWFsaXplZC4KPiA+ID4gQWNjb3JkaW5nIHRv
IFZJUlRJTyBzcGVjaWZpY2F0aW9uIDIuMS4yIDoKPiA+ID4gIlRoZSBkZXZpY2UgTVVTVCBOT1Qg
Y29uc3VtZSBidWZmZXJzIG9yIHNlbmQgYW55IHVzZWQgYnVmZmVyCj4gPiA+IG5vdGlmaWNhdGlv
bnMgdG8gdGhlIGRyaXZlciBiZWZvcmUgRFJJVkVSX09LLiIKPiA+Cj4gPiBSaWdodC4KPiA+Cj4g
PiA+IER1cmluZyBhbiBpbml0aWFsaXphdGlvbiwgZHJpdmVyIGNhbGxzIHJlZ2lzdGVyX25ldGRl
dmljZSB3aGljaCBpbnZva2VzCj4gPiA+IGNhbGxiYWNrIGZ1bmN0aW9uIHZpcnRuZXRfc2V0X2Zl
YXR1cmVzIGZyb20gX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzLgo+ID4gPiBJZiBndWVzdCBvZmZs
b2FkIGZlYXR1cmVzIGFyZSBhZHZlcnRpc2VkIGJ5IHRoZSBkZXZpY2UsCj4gPiA+IHZpcnRuZXRf
c2V0X2d1ZXN0X29mZmxvYWRzIGlzIHVzaW5nIHZpcnRuZXRfc2VuZF9jb21tYW5kIHRvIHdyaXRl
IGFuZAo+ID4gPiByZWFkIGZyb20gVlEuCj4gPiA+IFRoYXQgbGVhZHMgdG8gaW5pdGlhbGl6YXRp
b24gc3R1Y2sgYXMgZGV2aWNlIGlzIG5vdCBwZXJtaXR0ZWQgeWV0IHRvIHVzZSBWUS4KPiA+Cj4g
Pgo+ID4KPiA+IEhtbSBzbyB3ZSBoYXZlIHRoaXM6Cj4gPgo+ID4KPiA+ICAgICAgICAgaWYgKChk
ZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9HUk9fSFcpIHsKPiA+ICAgICAgICAg
ICAgICAgICBpZiAodmktPnhkcF9lbmFibGVkKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FQlVTWTsKPiA+Cj4gPiAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgTkVU
SUZfRl9HUk9fSFcpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBvZmZsb2FkcyA9IHZpLT5n
dWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+ID4gICAgICAgICAgICAgICAgIGVsc2UKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUg
Jgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+R1VFU1RfT0ZGTE9BRF9H
Uk9fSFdfTUFTSzsKPiA+Cj4gPiAgICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF9zZXRfZ3Vl
c3Rfb2ZmbG9hZHModmksIG9mZmxvYWRzKTsKPiA+ICAgICAgICAgICAgICAgICBpZiAoZXJyKQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiA+ICAgICAgICAgICAgICAg
ICB2aS0+Z3Vlc3Rfb2ZmbG9hZHMgPSBvZmZsb2FkczsKPiA+ICAgICAgICAgfQo+ID4KPiA+IHdo
aWNoIEkgZ3Vlc3Mgc2hvdWxkIGhhdmUgcHJldmVudGVkIHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxv
YWRzIGZyb20gZXZlciBydW5uaW5nLgo+ID4KPiA+IEZyb20geW91ciBkZXNjcmlwdGlvbiBpdCBz
b3VuZHMgbGlrZSB5b3UgaGF2ZSBvYnNlcnZlZCB0aGlzCj4gPiBpbiBwcmFjdGljZSwgcmlnaHQ/
Cj4gPgo+ID4KPiA+Cj4gPiA+IEkgaGF2ZSBhdHRhY2hlZCBhIHBhdGNoIGZvciBrZXJuZWwgNS4x
OC1yYzMgd2hpY2ggZml4ZXMgdGhlIHByb2JsZW0gYnkKPiA+ID4gZGVmZXJyaW5nIGZlYXR1cmUg
c2V0IGFmdGVyIHZpcnRpbyBkcml2ZXIgaW5pdGlhbGl6YXRpb24uCj4gPiA+Cj4gPiA+IEJlc3Qg
UmVnYXJkcywKPiA+ID4KPiA+ID4gLS0KPiA+ID4gTWFjaWVqIFN6eW1hxYRza2kKPiA+ID4gU2Vu
aW9yIFN0YWZmIEVuZ2luZWVyCj4gPiA+Cj4gPiA+IE9wZW5TeW5lcmd5IEdtYkgKPiA+ID4gUm90
aGVyc3RyLiAyMCwgMTAyNDUgQmVybGluCj4gPiA+Cj4gPiA+IFBob25lOiAgICArNDkgMzAgNjAg
OTggNTQgMCAtODYKPiA+ID4gRmF4OiAgICAgICs0OSAzMCA2MCA5OCA1NCAwIC05OQo+ID4gPiBF
LU1haWw6ICAgbWFjaWVqLnN6eW1hbnNraUBvcGVuc3luZXJneS5jb20KPiA+ID4KPiA+ID4gd3d3
Lm9wZW5zeW5lcmd5LmNvbQo+ID4gPgo+ID4gPiBIYW5kZWxzcmVnaXN0ZXIvQ29tbWVyY2lhbCBS
ZWdpc3RyeTogQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcsIEhSQiAxMDg2MTZCCj4gPiA+IEdl
c2Now6RmdHNmw7xocmVyL01hbmFnaW5nIERpcmVjdG9yOiBSZWdpcyBBZGphbWFoCj4gPiA+Cj4g
PiA+IFBsZWFzZSBtaW5kIG91ciBwcml2YWN5IG5vdGljZTxodHRwczovL3d3dy5vcGVuc3luZXJn
eS5jb20vZGF0ZW5zY2h1dHplcmtsYWVydW5nL3ByaXZhY3ktbm90aWNlLWZvci1idXNpbmVzcy1w
YXJ0bmVycy1wdXJzdWFudC10by1hcnRpY2xlLTEzLW9mLXRoZS1nZW5lcmFsLWRhdGEtcHJvdGVj
dGlvbi1yZWd1bGF0aW9uLWdkcHIvPiBwdXJzdWFudCB0byBBcnQuIDEzIEdEUFIuIC8vIFVuc2Vy
ZSBIaW53ZWlzZSB6dW0gRGF0ZW5zY2h1dHogZ2VtLiBBcnQuIDEzIERTR1ZPIGZpbmRlbiBTaWUg
aGllci48aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RlL2RhdGVuc2NodXR6ZXJrbGFlcnVu
Zy9kYXRlbnNjaHV0emhpbndlaXNlLWZ1ZXItZ2VzY2hhZWZ0c3BhcnRuZXItZ2VtLWFydC0xMy1k
c2d2by8+Cj4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDg3ODM4Y2IuLmE0NDQ2MmQgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTI2NCw2ICsyNjQsOCBAQCBzdHJ1Y3Qgdmly
dG5ldF9pbmZvIHsKPiA+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGd1ZXN0X29mZmxvYWRzOwo+
ID4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZ3Vlc3Rfb2ZmbG9hZHNfY2FwYWJsZTsKPiA+ID4K
PiA+ID4gKyAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlczsKPiA+ID4gKwo+ID4KPiA+
IEkgZG9uJ3QgbXVjaCBsaWtlIGhvdyB3ZSBhcmUgZm9yY2VkIHRvIGtlZXAgYSBjb3B5IG9mIGZl
YXR1cmVzCj4gPiBoZXJlIDooIEF0IGxlYXN0IHBscyBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcg
d2hhdCdzIGdvaW5nIG9uLAo+ID4gd2hvIG93bnMgdGhpcyBldGMuCj4gPgo+ID4gPiAgICAgICAg
IC8qIGZhaWxvdmVyIHdoZW4gU1RBTkRCWSBmZWF0dXJlIGVuYWJsZWQgKi8KPiA+ID4gICAgICAg
ICBzdHJ1Y3QgZmFpbG92ZXIgKmZhaWxvdmVyOwo+ID4gPiAgfTsKPiA+ID4gQEAgLTI5NzYsNiAr
Mjk3OCwxNSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfZ2V0X3BoeXNfcG9ydF9uYW1lKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsIGNoYXIgKmJ1ZiwKPiA+ID4KPiA+ID4gIHN0YXRpYyBpbnQgdmlydG5l
dF9zZXRfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlcykKPiA+ID4gK3sK
PiA+ID4gKyAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7
Cj4gPiA+ICsgICAgICAgdmktPmZlYXR1cmVzID0gZmVhdHVyZXM7Cj4gPiA+ICsKPiA+ID4gKyAg
ICAgICByZXR1cm4gMDsKPiA+ID4gK30KPiA+Cj4gPgo+ID4gTG9va3MgbGlrZSB0aGlzIGJyZWFr
cyBjaGFuZ2luZyBmZWF0dXJlcyBhZnRlciBpbml0aWFsaXphdGlvbiAtCj4gPiB0aGVzZSB3aWxs
IG5ldmVyIGJlIHByb3BhZ2F0ZWQgdG8gaGFyZHdhcmUgbm93Lgo+IAo+IFllcywgSSB0aGluayB3
ZSBuZWVkIHRvIGhhdmUgYSBjaGVjayBhbmQgb25seSBkZWZlciB0aGUgc2V0dGluZyB3aGVuCj4g
dmlydGlvIGRldmljZSBpcyBub3QgcmVhZHkuCj4gCj4gVGhhbmtzCgpJIHRoaW5rIHdlIHNob3Vs
ZCBmaXJzdCB1bmRlcnN0YW5kIGhvdyBkb2VzIHRoZSBpc3N1ZSB0cmlnZ2VyLAppcyB0aGlzIGEg
dGhlb3JldGljYWwgb3IgYSBwcmFjdGljYWwgaXNzdWUuCgo+ID4KPiA+ID4gKwo+ID4gPiArc3Rh
dGljIGludCB2aXJ0bmV0X3NldF9mZWF0dXJlc19kZWZlcnJlZChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9mZWF0dXJl
c190IGZlYXR1cmVzKQo+ID4gPiAgewo+ID4gPiAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ID4gICAgICAgICB1NjQgb2ZmbG9hZHM7Cj4gPiA+
IEBAIC0zNjQ0LDYgKzM2NTUsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPgo+ID4gPiAgICAgICAgIHZpcnRpb19kZXZpY2VfcmVh
ZHkodmRldik7Cj4gPiA+Cj4gPiA+ICsgICAgICAgLyogRGVmZXJyZWQgZmVhdHVyZSBzZXQgYWZ0
ZXIgZGV2aWNlIHJlYWR5ICovCj4gPiA+ICsgICAgICAgZXJyID0gdmlydG5ldF9zZXRfZmVhdHVy
ZXNfZGVmZXJyZWQoZGV2LCB2aS0+ZmVhdHVyZXMpOwo+ID4KPiA+Cj4gPiBJdCBzZWVtcyB0aGF0
IGlmIHRoaXMgaXMgY2FsbGVkIGUuZy4gZm9yIGEgZGV2aWNlIHdpdGhvdXQgYSBDVlEgYW5kCj4g
PiB0aGVyZSBhcmUgdGhpbmdzIHRoYXQgYWN0dWFsbHkgbmVlZCB0byBjaGFuZ2UgdGhlbiBpdCB3
aWxsIEJVR19PTi4KPiA+Cj4gPgo+ID4gPiArICAgICAgIGlmIChlcnIpIHsKPiA+ID4gKyAgICAg
ICAgICAgICAgIHByX2RlYnVnKCJ2aXJ0aW9fbmV0OiBzZXQgZmVhdHVyZXMgZmFpbGVkXG4iKTsK
PiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZnJlZV91bnJlZ2lzdGVyX25ldGRldjsKPiA+ID4g
KyAgICAgICB9Cj4gPiA+ICsKPiA+ID4gICAgICAgICBlcnIgPSB2aXJ0bmV0X2NwdV9ub3RpZl9h
ZGQodmkpOwo+ID4gPiAgICAgICAgIGlmIChlcnIpIHsKPiA+ID4gICAgICAgICAgICAgICAgIHBy
X2RlYnVnKCJ2aXJ0aW9fbmV0OiByZWdpc3RlcmluZyBjcHUgbm90aWZpZXIgZmFpbGVkXG4iKTsK
PiA+ID4KPiA+Cj4gPiAtLQo+ID4gTVNUCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
