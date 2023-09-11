Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4822DEE7FF4
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 06:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D52A3408E8;
	Mon, 11 Sep 2023 06:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D52A3408E8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFiG/Q3g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6SnwWpcxs3O; Mon, 11 Sep 2023 06:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2989B408E3;
	Mon, 11 Sep 2023 06:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2989B408E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF46BC0039;
	Mon, 11 Sep 2023 06:43:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA17BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8485760E8F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8485760E8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFiG/Q3g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLeXEh5ygroc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:43:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2F0160E8A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 06:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2F0160E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694414636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hacwB6iiq5NY+zYgApjaYmWieDtA5HxzGnTlc1HzvW0=;
 b=PFiG/Q3g0T7IDgH8CctMlz3nSn6uBAjOw3geC4NG6YxropyZVWiD9WxadMOXTCD6xV/vx1
 rBgp7mEafKGfdV+WeGI03lnzghLNVh9gOkAmaPeS4t1PUIJ8iHHINqCgT9+8itu+dAvs0N
 NmFB3KU1PP4DscmbDS5btEAEaR1xqwg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-PIvPt_AhM4-kvVnVCbU-Zw-1; Mon, 11 Sep 2023 02:43:54 -0400
X-MC-Unique: PIvPt_AhM4-kvVnVCbU-Zw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500b575b32dso3272189e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Sep 2023 23:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414633; x=1695019433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hacwB6iiq5NY+zYgApjaYmWieDtA5HxzGnTlc1HzvW0=;
 b=IsQUYi5Kzymf7FdU0lomKNDYnk0cY3e+1qNG1x94pHOzWwwETPVz+7CJZEGu+Lab5t
 8c0EGjekh+wT+8zpxPbuZhbjwxz8p2ZXzuLdsFsOkW+xupEodSYKTinT6hmho+SOvQYF
 b1MRZXKXaAUG6zfhUUNwPvL6M1D0irGm6aI7+a1Y2Wup97uE9Dgi+3mvm/FuXXQEQDkO
 tyAn4bPO1DUNzHx/SI2gxYrNAMrvEgcgnemOy/GWWt6nBG5PQPhDLflVZLzd9ar1825h
 t1ZPBGbbjvn5pXenc8e5jptugdBOSdMrOjR5Dt6St/3s+k2HQUxoC4YSNfkiMmd2XyPj
 ncBw==
X-Gm-Message-State: AOJu0YzN5a1NxOrnc/9/nNH1qgWz5aPEOAEO0uil+ng/wPR8paNF4Ibr
 SzLZGEsVCtkbXsn7zdKsPWlAmldr4vgD0ZbmcGR4guuwj6+IEGJNyG2gvWKbpvJiOlO9Uxrzu8a
 Zv/5pkg12qGdP9w9WiZVOm6OoWIkg4pGnyX9b9HUJK3ahGqOZ96tevhdb2g==
X-Received: by 2002:a05:6512:360f:b0:4f8:5e62:b94b with SMTP id
 f15-20020a056512360f00b004f85e62b94bmr2710809lfs.9.1694414633465; 
 Sun, 10 Sep 2023 23:43:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLzUFwsIrDFyfnYuYHZP+FwLoDDFXQlrNWYigvCohi+xe6qmFJwSweDmXOOQ2Yc0gUu0W/lEBAIwJsfoaqfis=
X-Received: by 2002:a05:6512:360f:b0:4f8:5e62:b94b with SMTP id
 f15-20020a056512360f00b004f85e62b94bmr2710800lfs.9.1694414633102; Sun, 10 Sep
 2023 23:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Sep 2023 14:43:42 +0800
Message-ID: <CACGkMEumYw5NKGfakjm=QGxTX0JH71owt240=y0WGxQzGipXGA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] vdpa: dedicated descriptor table group
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

T24gU2F0LCBTZXAgOSwgMjAyMyBhdCA0OjQ14oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPgo+IEZvbGxvd2luZyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRlZGlj
YXRlZCBncm91cCBmb3IgZGVzY3JpcHRvciB0YWJsZSB0bwo+IHJlZHVjZSBsaXZlIG1pZ3JhdGlv
biBkb3dudGltZSB3aGVuIHBhc3N0aHJvdWdoIFZRIGlzIGJlaW5nIHN3aXRjaGVkCj4gdG8gc2hh
ZG93IFZRLiBUaGlzIFJGQyB2MiBpcyBzZW50IHRvIGluY29ycG9yYXRlIHRoZSBlYXJseSBmZWVk
YmFjawo+IGZyb20gcmV2aWV3ZXJzIG9uIHRoZSB1QVBJIGFuZCBkcml2ZXIgQVBJIHBhcnQgb2Yg
Y2hhbmdlcywgdGhlCj4gYXNzb2NpYXRlZCBkcml2ZXIgcGF0Y2ggc2V0IGNvbnN1bWluZyB0aHMg
QVBJIHdpbGwgY29tZSBhcm91bmQKPiBzb29uIGFsb25nIHdpdGggZm9ybWFsIHN1Ym1pc3Npb24g
b2YgdGhpcyBzZXJpZXMuCj4KPiBTb21lIGluaXRpYWwgcGVyZm9ybWFuY2UgZGF0YSB3aWxsIGJl
IGdhdGhlcmVkIHVzaW5nIHRoZSByZWFsCj4gaGFyZHdhcmUgZGV2aWNlIHdpdGggbWx4NV92ZHBh
LiBUaGUgdGFyZ2V0IGdvYWwgb2YgdGhpcyBzZXJpZXMgaXMgdG8KPiByZWR1Y2UgdGhlIFNWUSBz
d2l0Y2hpbmcgb3ZlcmhlYWQgdG8gbGVzcyB0aGFuIDMwMG1zIG9uIGEgfjEwMEdCCj4gZ3Vlc3Qg
d2l0aCAyIG5vbi1tcSB2aG9zdC12ZHBhIGRldmljZXMuIFRoZSByZWR1Y3Rpb24gaW4gdGhlIGRv
d250aW1lCj4gaXMgdGhhbmtzIHRvIGF2b2lkaW5nIHRoZSBmdWxsIHJlbWFwIGluIHRoZSBzd2l0
Y2hpbmcuCj4KPiBUaGUgcGxhbiBvZiB0aGUgaW50ZW5kZWQgZHJpdmVyIGltcGxlbWVudGF0aW9u
IGlzIHRvIHVzZSBhIGRlZGljYXRlZAo+IGdyb3VwIChzcGVjaWZpY2FsbHksIDIgaW4gYmVsb3cg
dGFibGUpIHRvIGhvc3QgdGhlIGRlc2NyaXB0b3IgdGFibGVzCj4gZm9yIGRhdGEgdnFzLCBkaWZm
ZXJlbnQgZnJvbSB3aGVyZSBidWZmZXIgYWRkcmVzc2VzIGFyZSBjb250YWluZWQgKGluCj4gZ3Jv
dXAgMCBhcyBiZWxvdykuIGN2cSBkb2VzIG5vdCBoYXZlIHRvIGFsbG9jYXRlIGRlZGljYXRlZCBn
cm91cCBmb3IKPiBkZXNjcmlwdG9yIHRhYmxlLCBzbyBpdHMgYnVmZmVycyBhbmQgZGVzY3JpcHRv
ciB0YWJsZSB3b3VsZCBhbHdheXMKPiBiZWxvbmcgdG8gdGhlIHNhbWUgZ3JvdXAgKDEgaW4gdGFi
bGUgYmVsb3cpLgo+Cj4KPiAgICAgICAgICAgICAgIHwgIGRhdGEgdnEgfCBjdHJsIHZxCj4gPT09
PT09PT09PT09PT0rPT09PT09PT09PSs9PT09PT09PT09PQo+IHZxX2dyb3VwICAgICAgfCAgICAw
ICAgICB8ICAgIDEKPiB2cV9kZXNjX2dyb3VwIHwgICAgMiAgICAgfCAgICAxCj4KPgo+IC0tLQo+
Cj4gU2ktV2VpIExpdSAoMyk6Cj4gICB2ZHBhOiBpbnRyb2R1Y2UgZGVkaWNhdGVkIGRlc2NyaXB0
b3IgZ3JvdXAgZm9yIHZpcnRxdWV1ZQo+ICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0
b3IgZ3JvdXAgYmFja2VuZCBmZWF0dXJlCj4gICB2aG9zdC12ZHBhOiB1QVBJIHRvIGdldCBkZWRp
Y2F0ZWQgZGVzY3JpcHRvciBncm91cCBpZAoKTG9va3MgZ29vZCB0byBtZSBidXQgSSdkIGV4cGVj
dCBleGFtcGxlIGltcGxlbWVudGF0aW9ucyBpbiB0aGUgcGFyZW50LgoKVGhhbmtzCgo+Cj4gIGRy
aXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgIHwgMTEgKysrKysrKysr
KysKPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggICAgICAgfCAgOCArKysrKysrKwo+ICBp
bmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8ICA1ICsrKysrCj4gIDQgZmlsZXMgY2hh
bmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+Cj4gLS0KPiAxLjguMy4xCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
