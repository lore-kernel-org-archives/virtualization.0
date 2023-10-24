Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B49C07545
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 07:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C0380E87;
	Tue, 24 Oct 2023 07:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64C0380E87
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k7T7jclh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uW-UeSyKhU1H; Tue, 24 Oct 2023 07:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B688B80ECA;
	Tue, 24 Oct 2023 07:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B688B80ECA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C34BC0039;
	Tue, 24 Oct 2023 07:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40AADC0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F39A842EFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F39A842EFD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=k7T7jclh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gYWSYRlCDs0P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:35:16 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FF4C42EFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:35:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FF4C42EFC
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso6455216a12.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698132914; x=1698737714;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32gTUUjXU68PR9X7xQzHlV1yrbdzrrt47OwobaK/im0=;
 b=k7T7jclhWp5w5ZE53jYy580kfcisSSzdRz1rWMBrFMkuSBUPICmcpKDrJLPObM15Ql
 zmwj6QS0T5Nl1jTIi8/TjdUdCQP609Ek3qee/+5sqIjMKqQ10sk0rANvBsNvrCvyOkII
 GBt7wA2mfMINuQg3WytHJle8GIjPQ/YsOFOLk+/bMwDJ/Zq/tPTFNKFCMmLw5iNlV28k
 Q88GKRw9Cu1dbW36Noy/rjQy97ZWsBVQHW1wxnQL8nV9o3mp87C9WonrunxNvgCCEJol
 afdWwjzqDYIosm/NSLL2fcrmosxjHGDAXW+m8LiF9azvOe3KPhR7/LSj1kHfvAww45EZ
 UyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698132914; x=1698737714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32gTUUjXU68PR9X7xQzHlV1yrbdzrrt47OwobaK/im0=;
 b=aNCnCBQT5TQhZRUosec3aLPb0JtkR3mAI5rqGYlKzronts50Ltt7DjCmULudaa82aL
 nskCK3sFv26AtM3AZZbZV3tBWFm3r880Ij9vnqWIOntdKS3kvGzz1Q7zVBhOY8p1LiTm
 eBbJ++D6ODrmW1Y8BODgIlHJqUXLuoJzf+vZ7IO+4kPj9vcYDizfQveegHR3HyWWwtEe
 Y6OMcLp9Bzcy8eEqhFwvrYTZz8r087fZMehu9PfRTcgyciF8IOR5bUFk6HgnJVQF2TNa
 0sAwiv1/uZoj73RgKN11dA1aG5t8uphJk6djeAB4HVXlgiDtqZCyR51ebIezAbY1QxHa
 QSGg==
X-Gm-Message-State: AOJu0YwZlmrsql3GtN3gwQkCdR22ryZPbtrgukkunHFgopqXpIkfwzck
 ikLSkDpRGN/sSUf5vyBhAZT/I1gZxX+zQdCwyWvf3y2W194=
X-Google-Smtp-Source: AGHT+IFp/uHv1l5CsH7+HTAoEjLJtzfXtxhv7dKkZ5shtUpJb8zM76imNnUO0v5NgMklFtDN30DwcDyk6Az5xeql/wE=
X-Received: by 2002:a05:6402:5111:b0:540:7e8:dd4f with SMTP id
 m17-20020a056402511100b0054007e8dd4fmr5895340edd.20.1698132914306; Tue, 24
 Oct 2023 00:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKhg4tKSWLood9aFo7r1j-a3sXvf+WraFV_xUcKOMLq9sxrPXA@mail.gmail.com>
 <CACGkMEufrJfM7bw7s76gq_3S5oSgx4w5KjxO_oReMg34bCy5hA@mail.gmail.com>
In-Reply-To: <CACGkMEufrJfM7bw7s76gq_3S5oSgx4w5KjxO_oReMg34bCy5hA@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 24 Oct 2023 15:35:02 +0800
Message-ID: <CAKhg4t+OZBAt8modbysXvdCAEwui=bnV9dcSZoZNZwCf_rcAYw@mail.gmail.com>
Subject: Re: [RFC] vhost: vmap virtio descriptor table kernel/kvm
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMTI6NDXigK9QTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDExOjE34oCvQU0g
TGlhbmcgQ2hlbiA8bGlhbmdjaGVuLmxpbnV4QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhl
IGN1cnJlbnQgdmhvc3QgY29kZSB1c2VzICdjb3B5X2Zyb21fdXNlcicgdG8gY29weSBkZXNjcmlw
dG9ycyBmcm9tCj4gPiB1c2Vyc3BhY2UgdG8gdmhvc3QuIFdlIGF0dGVtcHRlZCB0byAndm1hcCcg
dGhlIGRlc2NyaXB0b3IgdGFibGUgdG8KPiA+IHJlZHVjZSB0aGUgb3ZlcmhlYWQgYXNzb2NpYXRl
ZCB3aXRoICdjb3B5X2Zyb21fdXNlcicgZHVyaW5nIGRlc2NyaXB0b3IKPiA+IGFjY2VzcywgYmVj
YXVzZSBpdCBjYW4gYmUgYWNjZXNzZWQgcXVpdGUgZnJlcXVlbnRseS4gVGhpcyBjaGFuZ2UKPiA+
IHJlc3VsdGVkIGluIGEgbW9kZXJhdGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgKGFwcHJveGlt
YXRlbHkgMyUpIGluCj4gPiBvdXIgcGt0Z2VuIHRlc3QsIGFzIHNob3duIGJlbG93LiBBZGRpdGlv
bmFsbHksIHRoZSBsYXRlbmN5IGluIHRoZQo+ID4gJ3Zob3N0X2dldF92cV9kZXNjJyBmdW5jdGlv
biBzaG93cyBhIG5vdGljZWFibGUgZGVjcmVhc2UuCj4gPgo+ID4gY3VycmVudCBjb2RlOgo+ID4g
ICAgICAgICAgICAgICAgIElGQUNFICAgcnhwY2svcyAgIHR4cGNrL3MgICAgcnhrQi9zICAgIHR4
a0Ivcwo+ID4gcnhjbXAvcyAgIHR4Y21wL3MgIHJ4bWNzdC9zICAgJWlmdXRpbAo+ID4gQXZlcmFn
ZTogICAgICAgIHZuZXQwICAgICAgMC4zMSAxMzMwODA3LjAzICAgICAgMC4wMiAgNzc5NzYuOTgK
PiA+IDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDYuMzkKPiA+ICMgL3Vzci9zaGFyZS9i
Y2MvdG9vbHMvZnVuY2xhdGVuY3kgLWQgMTAgdmhvc3RfZ2V0X3ZxX2Rlc2MKPiA+IGF2ZyA9IDE0
NSBuc2VjcywgdG90YWw6IDE0NTU5ODAzNDEgbnNlY3MsIGNvdW50OiA5OTg1MjI0Cj4gPgo+ID4g
dm1hcDoKPiA+ICAgICAgICAgICAgICAgICBJRkFDRSAgIHJ4cGNrL3MgICB0eHBjay9zICAgIHJ4
a0IvcyAgICB0eGtCL3MKPiA+IHJ4Y21wL3MgICB0eGNtcC9zICByeG1jc3QvcyAgICVpZnV0aWwK
PiA+IEF2ZXJhZ2U6ICAgICAgICB2bmV0MCAgICAgIDAuMDcgMTM3MTg3MC40OSAgICAgIDAuMDAg
IDgwMzgzLjA0Cj4gPiAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICA2LjU4Cj4gPiAjIC91
c3Ivc2hhcmUvYmNjL3Rvb2xzL2Z1bmNsYXRlbmN5IC1kIDEwIHZob3N0X2dldF92cV9kZXNjCj4g
PiBhdmcgPSAxMjIgbnNlY3MsIHRvdGFsOiAxMjg2OTgzOTI5IG5zZWNzLCBjb3VudDogMTA0Nzgx
MzQKPiA+Cj4gPiBXZSBhcmUgdW5jZXJ0YWluIGlmIHRoZXJlIGFyZSBhbnkgYXNwZWN0cyB3ZSBt
YXkgaGF2ZSBvdmVybG9va2VkIGFuZAo+ID4gd291bGQgYXBwcmVjaWF0ZSBhbnkgYWR2aWNlIGJl
Zm9yZSB3ZSBzdWJtaXQgYW4gYWN0dWFsIHBhdGNoLgo+Cj4gU28gdGhlIGlkZWEgaXMgdG8gdXNl
IGEgc2hhZG93IHBhZ2UgdGFibGUgaW5zdGVhZCBvZiB0aGUgdXNlcnNwYWNlIG9uZQo+IHRvIGF2
b2lkIHRoaW5ncyBsaWtlIHNwZWMgYmFycmllcnMgb3IgU01BUC4KPgo+IEkndmUgdHJpZWQgdGhp
cyBpbiB0aGUgcGFzdDoKPgo+IGNvbW1pdCA3ZjQ2NjAzMmRjOWU1YTYxMjE3ZjIyZWEzNGIyZGY5
MzI3ODZiYmZjIChIRUFEKQo+IEF1dGhvcjogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPiBEYXRlOiAgIEZyaSBNYXkgMjQgMDQ6MTI6MTggMjAxOSAtMDQwMAo+Cj4gICAgIHZob3N0
OiBhY2Nlc3MgdnEgbWV0YWRhdGEgdGhyb3VnaCBrZXJuZWwgdmlydHVhbCBhZGRyZXNzCj4KPiAg
ICAgSXQgd2FzIG5vdGljZWQgdGhhdCB0aGUgY29weV90by9mcm9tX3VzZXIoKSBmcmllbmRzIHRo
YXQgd2FzIHVzZWQgdG8KPiAgICAgYWNjZXNzIHZpcnRxdWV1ZSBtZXRkYXRhIHRlbmRzIHRvIGJl
IHZlcnkgZXhwZW5zaXZlIGZvciBkYXRhcGxhbmUKPiAgICAgaW1wbGVtZW50YXRpb24gbGlrZSB2
aG9zdCBzaW5jZSBpdCBpbnZvbHZlcyBsb3RzIG9mIHNvZnR3YXJlIGNoZWNrcywKPiAgICAgc3Bl
Y3VsYXRpb24gYmFycmllcnMsIGhhcmR3YXJlIGZlYXR1cmUgdG9nZ2xpbmcgKGUuZyBTTUFQKS4g
VGhlCj4gICAgIGV4dHJhIGNvc3Qgd2lsbCBiZSBtb3JlIG9idmlvdXMgd2hlbiB0cmFuc2ZlcnJp
bmcgc21hbGwgcGFja2V0cyBzaW5jZQo+ICAgICB0aGUgdGltZSBzcGVudCBvbiBtZXRhZGF0YSBh
Y2Nlc3NpbmcgYmVjb21lIG1vcmUgc2lnbmlmaWNhbnQuCj4gLi4uCj4KPiBOb3RlIHRoYXQgaXQg
dHJpZXMgdG8gdXNlIGEgZGlyZWN0IG1hcCBpbnN0ZWFkIG9mIGEgVk1BUCBhcyBBbmRyZWEKPiBz
dWdnZXN0cy4gQnV0IGl0IGxlZCB0byBzZXZlcmFsIGZhbGxvdXRzIHdoaWNoIHdlcmUgdHJpY2t5
IHRvIGJlCj4gZml4ZWRbMV0gKGxpa2UgdGhlIHVzZSBvZiBNTVUgbm90aWZpZXJzIHRvIGRvIHN5
bmNocm9uaXphdGlvbikuIFNvIGl0Cj4gaXMgcmV2ZXJ0ZWQgZmluYWxseS4KPgo+IEknbSBub3Qg
c2F5aW5nIGl0J3MgYSBkZWFkIGVuZC4gQnV0IHdlIG5lZWQgdG8gZmluZCBhIHdheSB0byBzb2x2
ZSB0aGUKPiBpc3N1ZXMgb3IgdXNlIHNvbWV0aGluZyBkaWZmZXJlbnQuIEknbSBoYXBweSB0byBv
ZmZlciBoZWxwLgo+Cj4gMSkgQXZvaWQgdXNpbmcgU01BUCBmb3Igdmhvc3Qga3RocmVhZCwgZm9y
IGV4YW1wbGUgdXNpbmcgc2hlZAo+IG5vdGlmaWVyLCBJJ20gbm90IHN1cmUgdGhpcyBpcyBwb3Nz
aWJsZSBvciBub3QKPiAyKSBBIG5ldyBpb3YgaXRlcmF0b3IgdGhhdCBkb2Vzbid0IGRvIFNNQVAg
YXQgYWxsLCB0aGlzIGxvb2tzCj4gZGFuZ2Vyb3VzIGFuZCBBbCBtaWdodCBub3QgbGlrZSBpdAo+
IDMpIChSZSl1c2luZyBITU0KPiAuLi4KPgo+IFlvdSBtYXkgd2FudCB0byBzZWUgYXJjaGl2ZXMg
Zm9yIG1vcmUgaW5mb3JtYXRpb24uIFdlJ3ZlIGhhZCBhIGxvdCBvZgo+IGRpc2N1c3Npb25zLgo+
Cj4gVGhhbmtzCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDczMTA4
NDY1NS43MDI0LTEtamFzb3dhbmdAcmVkaGF0LmNvbS8KPgoKVGhhbmtzIGEgbG90IGZvciB0aGUg
aGVscC4gV2Ugd2lsbCB0YWtlIGEgZGVlcGVyIGxvb2sgYW5kIHJlYWNoIG91dCBpZgp3ZSBoYXZl
IGFueSBxdWVzdGlvbnMgb3Igb25jZSB3ZSd2ZSBmaW5hbGl6ZWQgdGhlIHBhdGNoLgoKVGhhbmtz
LApMaWFuZwoKPiA+Cj4gPgo+ID4gVGhhbmtzLAo+ID4gTGlhbmcKPiA+Cj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
