Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747F6C05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 06:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09AF940159;
	Sun, 29 Jan 2023 06:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09AF940159
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q2ZmKugp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6m_Nc4Wx8Md; Sun, 29 Jan 2023 06:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 832E7400F6;
	Sun, 29 Jan 2023 06:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 832E7400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5107DC0033;
	Sun, 29 Jan 2023 06:01:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB034C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5527140129
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5527140129
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PcXZL1G_nhg4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78AFA400F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78AFA400F6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674972066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNte/epZiic5eC+qCjYGlwvstqynHQ526X6mXWyY2rg=;
 b=Q2ZmKugpaY+xK+dMZMUVQh5cbcYAs+qjX5aG1p6hxh9IAJS56XRhQCnENZjAP7atvUHnuW
 Fa6pCNs7FIgj+Fwn1lC9hp6FVMwEQytWsj4pXDSIeyYxuV2JCbMmuNzz8bbgBhDAz1F44U
 XM7oi1WwHWIIMzm30wdOdTWkY2FbNrE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-JJks2wcuNBe9i8EaGDcHow-1; Sun, 29 Jan 2023 01:01:03 -0500
X-MC-Unique: JJks2wcuNBe9i8EaGDcHow-1
Received: by mail-oi1-f198.google.com with SMTP id
 k2-20020a544402000000b0037806f41283so1382808oiw.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 22:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNte/epZiic5eC+qCjYGlwvstqynHQ526X6mXWyY2rg=;
 b=7SjnQ09B0P3xMcMF0rrxRBrw/kRYGRfCFlGp/J6ZWUdNoGCnJORwu33uCEUKMGtnYr
 NYrynBOrk3zQX7D8Vz05rKk+Og8sO5KHR9C9FFq+uPjZhdvdz25DU1Kw8RFTaN9Q15eq
 Gnr5vkY8GzENWDhQRI5pd09G3J5hWs/njzaNOSm5YcOZjrmetvr0ASnUQPSvSSS/DTo0
 62KIxYBttlrRlGy/YFKs069FIhYl9iSDWDv6uCD3FocTdkkQQtNkOewmRPViluLxiTTL
 6hds5Egtg9ljDhvfcMVQ/wjCvDzOOokRNjiy7i7hZzIyMQnFleNBaq4wNq5jXJoDxZNM
 pKIg==
X-Gm-Message-State: AFqh2kpFodjevS6rzQgB+l74fO1xTCE9XCLb9mZTYBCJX6hsSqQrNYAG
 AunXMHUwdbcqlJtBCJxsnbc8Lh55s6hDkD4pyRaC+eKwSbVQtslr7Ly7tbHEuVlqCGGOd19MUNC
 mlOniXje9YTFnFLpyLXHqBgWAD3C24+Bwu0jn81N8BaLcIOccth1vxmskKQ==
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr790404oia.35.1674972063215; 
 Sat, 28 Jan 2023 22:01:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBzcCdXZc7bwOwz3areMJGTSfIiWdbhghFTG36ykYsyjKjmQmJuRCs5BcZgYBNJ5opYdriLWh+zpc/ToYbCng=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr790402oia.35.1674972062940; Sat, 28
 Jan 2023 22:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
 <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
 <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
In-Reply-To: <CAJaqyWetovvndcU=pu_kPNUNYkgao=HsENnrKCzoHdK7RBjyAQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 14:00:51 +0800
Message-ID: <CACGkMEvX5Li3c8oW2ARc0OAutfDK2=cckjuEf4KQRuNKfH1hfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

T24gVGh1LCBKYW4gMTksIDIwMjMgYXQgNDoxMSBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEphbiAxOSwgMjAyMyBhdCA0OjIw
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRo
dSwgSmFuIDE5LCAyMDIzIGF0IDEyOjQ0IEFNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gU3RhcnRpbmcgZnJvbSBhbiB1c2VkX2lkeCBkaWZm
ZXJlbnQgdGhhbiAwIGlzIG5lZWRlZCBpbiB1c2UgY2FzZXMgbGlrZQo+ID4gPiB2aXJ0dWFsIG1h
Y2hpbmUgbWlncmF0aW9uLiAgTm90IGRvaW5nIHNvIGFuZCBsZXR0aW5nIHRoZSBjYWxsZXIgc2V0
IGFuCj4gPiA+IGF2YWlsIGlkeCBkaWZmZXJlbnQgdGhhbiAwIGNhdXNlcyBkZXN0aW5hdGlvbiBk
ZXZpY2UgdG8gdHJ5IHRvIHVzZSBvbGQKPiA+ID4gYnVmZmVycyB0aGF0IHNvdXJjZSBkcml2ZXIg
YWxyZWFkeSByZWNvdmVyIGFuZCBhcmUgbm90IGF2YWlsYWJsZQo+ID4gPiBhbnltb3JlLgo+ID4g
Pgo+ID4gPiBXaGlsZSBjYWxsZXJzIGxpa2UgdmRwYV9zaW0gc2V0IGF2YWlsX2lkeCBkaXJlY3Rs
eSBpdCBkb2VzIG5vdCBzZXQKPiA+ID4gdXNlZF9pZHguICBJbnN0ZWFkIG9mIGxldCB0aGUgY2Fs
bGVyIGRvIHRoZSBhc3NpZ25tZW50LCBmZXRjaCBpdCBmcm9tCj4gPiA+IHRoZSBndWVzdCBhdCBp
bml0aWFsaXphdGlvbiBsaWtlIHZob3N0LWtlcm5lbCBkby4KPiA+ID4KPiA+ID4gVG8gcGVyZm9y
bSB0aGUgc2FtZSBhdCB2cmluZ19rZXJuZWxfaW5pdCBhbmQgdnJpbmdfdXNlcl9pbml0IGlzIGxl
ZnQgZm9yCj4gPiA+IHRoZSBmdXR1cmUuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2Vu
aW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMv
dmhvc3QvdnJpbmdoLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKy0tCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5n
aC5jCj4gPiA+IGluZGV4IDMzZWI5NDFmY2YxNS4uMGVlZDgyNTE5N2YyIDEwMDY0NAo+ID4gPiAt
LS0gYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJp
bmdoLmMKPiA+ID4gQEAgLTEzMDEsNiArMTMwMSwxNyBAQCBzdGF0aWMgaW5saW5lIGludCBwdXR1
c2VkX2lvdGxiKGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiA+ID4gICAgICAgICByZXR1cm4g
MDsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gKy8qKgo+ID4gPiArICogdnJpbmdoX3VwZGF0ZV91c2Vk
X2lkeCAtIGZldGNoIHVzZWQgaWR4IGZyb20gZHJpdmVyJ3MgdXNlZCBzcGxpdCB2cmluZwo+ID4g
PiArICogQHZyaDogVGhlIHZyaW5nLgo+ID4gPiArICoKPiA+ID4gKyAqIFJldHVybnMgLWVycm5v
IG9yIDAuCj4gPiA+ICsgKi8KPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHZyaW5naF91cGRhdGVf
dXNlZF9pZHgoc3RydWN0IHZyaW5naCAqdnJoKQo+ID4gPiArewo+ID4gPiArICAgICAgIHJldHVy
biBnZXR1MTZfaW90bGIodnJoLCAmdnJoLT5sYXN0X3VzZWRfaWR4LCAmdnJoLT52cmluZy51c2Vk
LT5pZHgpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICAvKioKPiA+ID4gICAqIHZyaW5naF9pbml0
X2lvdGxiIC0gaW5pdGlhbGl6ZSBhIHZyaW5naCBmb3IgYSByaW5nIHdpdGggSU9UTEIuCj4gPiA+
ICAgKiBAdnJoOiB0aGUgdnJpbmdoIHRvIGluaXRpYWxpemUuCj4gPiA+IEBAIC0xMzE5LDggKzEz
MzAsMTggQEAgaW50IHZyaW5naF9pbml0X2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwgdTY0IGZl
YXR1cmVzLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZyaW5nX2F2YWlsICph
dmFpbCwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ191c2VkICp1c2Vk
KQo+ID4gPiAgewo+ID4KPiA+IFdoaWxlIGF0IHRoaXMsIEkgd29uZGVyIGlmIGl0J3MgYmV0dGVy
IHRvIGhhdmUgYSBkZWRpY2F0ZWQgcGFyYW1ldGVyCj4gPiBmb3IgbGFzdF9hdmFpbF9pZHg/Cj4g
Pgo+Cj4gSSBhbHNvIGhhZCB0aGF0IHRob3VnaHQuIFRvIGRpcmVjdGx5IGFzc2lnbiBsYXN0X2F2
YWlsX2lkeCBpcyBub3QgYQo+IHNwZWNpYWxseSBlbGVnYW50IEFQSSBJTU8uCj4KPiBNYXliZSBl
eHBvc2UgYSB3YXkgdG8gZmV0Y2ggdXNlZF9pZHggZnJvbSBkZXZpY2UgdnJpbmcgYW5kIHBhc3MK
PiB1c2VkX2lkeCBhcyBwYXJhbWV0ZXIgdG9vPwoKSWYgSSB3YXMgbm90IHdyb25nLCB3ZSBjYW4g
c3RhcnQgZnJvbSBsYXN0X2F2YWlsX2lkeCwgZm9yIHVzZWRfaWR4IGl0CmlzIG9ubHkgbmVlZGVk
IGZvciBpbmZsaWdodCBkZXNjcmlwdG9ycyB3aGljaCBtaWdodCByZXF1aXJlIG90aGVyCkFQSXM/
CgooQWxsIHRoZSBjdXJyZW50IHZEUEEgdXNlciBvZiB2cmluZ2ggaXMgZG9pbmcgaW4gb3JkZXIg
cHJvY2Vzc2luZykKCj4KPiA+ID4gLSAgICAgICByZXR1cm4gdnJpbmdoX2luaXRfa2Vybih2cmgs
IGZlYXR1cmVzLCBudW0sIHdlYWtfYmFycmllcnMsCj4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGVzYywgYXZhaWwsIHVzZWQpOwo+ID4gPiArICAgICAgIGludCByID0gdnJp
bmdoX2luaXRfa2Vybih2cmgsIGZlYXR1cmVzLCBudW0sIHdlYWtfYmFycmllcnMsIGRlc2MsCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF2YWlsLCB1c2VkKTsKPiA+ID4g
Kwo+ID4gPiArICAgICAgIGlmIChyICE9IDApCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
cjsKPiA+ID4gKwo+ID4gPiArICAgICAgIC8qIENvbnNpZGVyIHRoZSByaW5nIG5vdCBpbml0aWFs
aXplZCAqLwo+ID4gPiArICAgICAgIGlmICgodm9pZCAqKWRlc2MgPT0gdXNlZCkKPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+ID4KPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGVuIHdl
IGNhbiBnZXQgdGhpcyAoYWN0dWFsbHkgaXQgc2hvdWxkIGJlIGEgYnVnCj4gPiBvZiB0aGUgY2Fs
bGVyKS4KPiA+Cj4KPiBZb3UgY2FuIHNlZSBpdCBpbiB2ZHBhc2ltX3ZxX3Jlc2V0Lgo+Cj4gTm90
ZSB0aGF0IHRvIGNvbnNpZGVyIGRlc2MgPT0gMCB0byBiZSBhbiB1bmluaXRpYWxpemVkIHJpbmcg
aXMgYSBidWcKPiBJTU8uIFFFTVUgY29uc2lkZXJzIGl0IHRoYXQgd2F5IGFsc28sIGJ1dCB0aGUg
c3RhbmRhcmQgZG9lcyBub3QgZm9yYmlkCj4gYW55IHJpbmcgdG8gYmUgYXQgYWRkcmVzcyAwLiBF
c3BlY2lhbGx5IGlmIHdlIHVzZSB2SU9NTVUuCj4KPiBTbyBJIHRoaW5rIHRoZSBiZXN0IHdheSB0
byBrbm93IGlmIHdlIGNhbiB1c2UgdGhlIHZyaW5naCBpcyBlaXRoZXIKPiB0aGlzIHdheSwgb3Ig
cHJvdmlkZSBhbiBleHBsaWNpdCAiaW5pdGlhbGl6ZWQiIGJvb2xlYW4gYXR0cmlidXRlLgo+IE1h
eWJlIGEgbmV3ICJib29sIGlzX2luaXRpYWxpemVkKHZyaCkiIGlzIGVub3VnaCwgaWYgd2UgZG9u
J3Qgd2FudCB0bwo+IGFkZCBuZXcgYXR0cmlidXRlcy4KCkkgd29uZGVyIGlmIHdlIGNhbiBhdm9p
ZCB0aGlzIGluIHRoZSBzaW11bGF0b3IgbGV2ZWwgaW5zdGVhZCBvZiB0aGUKdnJpbmdoIChhbnlo
b3cgaXQgb25seSBleHBvc2VzIGEgdnJpbmdoX2luaXRfeHh4KCkgaGVscGVyIG5vdykuCgpUaGFu
a3MKCj4KPiBUaGFua3MhCj4KPiA+IFRoYW5rcwo+ID4KPiA+ID4gKwo+ID4gPiArICAgICAgIHJl
dHVybiB2cmluZ2hfdXBkYXRlX3VzZWRfaWR4KHZyaCk7Cj4gPiA+ICsKPiA+ID4gIH0KPiA+ID4g
IEVYUE9SVF9TWU1CT0wodnJpbmdoX2luaXRfaW90bGIpOwo+ID4gPgo+ID4gPiAtLQo+ID4gPiAy
LjMxLjEKPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
