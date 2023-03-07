Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86E6C6FD1A
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 18:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A21E4056E;
	Tue,  7 Mar 2023 18:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A21E4056E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ghNeLR6A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYrb1vtQOSUS; Tue,  7 Mar 2023 18:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BEBCB403A7;
	Tue,  7 Mar 2023 18:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEBCB403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96153C0035;
	Tue,  7 Mar 2023 18:09:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0844C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 18:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76DC6812D0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 18:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76DC6812D0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=ghNeLR6A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1H4O4n6wrhV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 18:09:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B5FB8129D
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B5FB8129D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 18:09:07 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-536af432ee5so260676667b3.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678212546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPM190mWLLkc07dSqy28s11Zcwbxf5IPd1Jdgp0CgOE=;
 b=ghNeLR6Ak9VAOjLD39wV4MjLb6xPIWr3hbQoyqUD50LpZgS5BYAF91Cc5jy/Slun3D
 gcJFdgGLoJIhSbQ8SNt2uC5HEemGRrWuCUkeEBAPJOvQL6ph3ub3ljb3F69TujRkRu/o
 Vm139/mowJHqvVXXDf4HO3LHnGsMS8d6WDtfQDcVA1BQRi2872fwamNKb/XBHLvbAK5P
 dNFdnWExnRcCSVHSQ/SFKh5IxI/1yLf4oU8uDugv5jKy2X5wVlrRNpg6QnVWE1fLbREX
 aLqPL1TAmiRBd1oSU7Ad7NVBNNoImI+q4jQoQKibBE6easr9zAgCxyN5RG+Jh5cK/twS
 1LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678212546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPM190mWLLkc07dSqy28s11Zcwbxf5IPd1Jdgp0CgOE=;
 b=i7RgEOhv4nr2HGoqjFrJ1VQF2+9eMoXFJowQuhTlblbE+XIMEYHVDh4XYnRKT5IxlY
 ++PVXYEbZ6OKYFd8wTFSVFWCutaSp7JoX9Vw8OULNybKCNJYgfzlxZzuR503qe5gIy2R
 /BOMf/mFzWI2H9czvwTEjJxGfMRgnRcoIBw8OSJxvl3jAK+sERaR5HgPcAd8LUGs3iZR
 EzUCb///mASFh/OPsllVtt9ofuNaqlpQUspnopRLmKOMzuAiiUGi5nQKru/lB3RRGESS
 VWgbA11E9JkSe5gDPgxND8d9VQVO15LLjDiYJmT8rsev4ZoIjxUakRfhiHR5LerQkoVM
 ppKA==
X-Gm-Message-State: AO0yUKX5pwWO9DHDwvzTPLUHrTsfgv1CMIFgJF1iSSH6mGtyAJKbnOEj
 Z+prk1t1RGHpzCI6xmhkxgeHce9F123/LAW047s=
X-Google-Smtp-Source: AK7set+zX2rluBwJh50Ty9wiKIeQaVf+J6OP4bqn5EEBFhTdKRbejtoGapg0eBHCGfp7r+DCU79YjdHmoY7o8hC1vVs=
X-Received: by 2002:a81:ad44:0:b0:52a:92e9:27c1 with SMTP id
 l4-20020a81ad44000000b0052a92e927c1mr9818472ywk.10.1678212546451; Tue, 07 Mar
 2023 10:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
In-Reply-To: <20230307130332.53029-1-daniel.almeida@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Mar 2023 19:08:55 +0100
Message-ID: <CANiq72nkBAfM_b50DsuoJjy3hXhBxNRK0oeU_kyQHaMnnjvGJA@mail.gmail.com>
Subject: Re: [PATCH] rust: virtio: add virtio support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: wedsonaf@gmail.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 ojeda@kernel.org, kernel@collabora.com
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

T24gVHVlLCBNYXIgNywgMjAyMyBhdCAyOjA04oCvUE0gRGFuaWVsIEFsbWVpZGEKPGRhbmllbC5h
bG1laWRhQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Cj4gRmVlbCBmcmVlIHRvIHBvaW50IG1lIHRv
IHRoZSBiZXN0IHByYWN0aWNlcyBhcm91bmQgUnVzdCBwYXRjaAo+IHN1Ym1pc3Npb24sIGFzIHRo
ZSBDIHN0dWZmIGxpa2UgY2hlY2twYXRjaCBldGMgcHJvYmFibHkgZG9lcyBub3QgYXBwbHkKPiB5
ZXQuIEkgZGlkIHRha2UgY2FyZSB0byBydW4gY2xpcHB5IHRob3VnaC4KClllYWgsIHNvbWUgbml0
cyBiZWxvdyBhcyBpZiB5b3UgaGFkIHJ1biBhIHNjcmlwdCBsaWtlIHRoYXQgOikKCj4gICNpbmNs
dWRlIDxsaW51eC91YWNjZXNzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW8uaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3Vpby5oPgoK
UGxlYXNlIHNvcnQgdGhlc2UuCgo+ICsjIVthbGxvdyhtaXNzaW5nX2RvY3MpXQoKVW5sZXNzIHRo
ZXJlIGlzIGEgdmVyeSBnb29kIHJlYXNvbiAod2hpY2ggc2hvdWxkIG1vc3QgbGlrZWx5IGJlCmRv
Y3VtZW50ZWQgaW4gdGhhdCBjYXNlKSwgcGxlYXNlIGluc3RlYWQgZG9jdW1lbnQgZXZlcnl0aGlu
Zy4gV2Uga2VlcApsaW50cyAiZGVueSIgaW5zdGVhZCBvZiBgLUZtaXNzaW5nX2RvY3NgIGp1c3Qg
aW4gY2FzZSB0aGVyZSBpcyBhIG5lZWQKc29tZXdoZXJlLCBidXQgdGhhdCBkb2VzIG5vdCBtZWFu
IG5vdCBkb2N1bWVudGluZyBpcyBPSyBpbiBnZW5lcmFsLgoKKEFsc28sIHRoZSBtb2R1bGUtbGV2
ZWwgYXR0cmlidXRlcyB3b3VsZCBiZSBwbGFjZWQgYWZ0ZXIgdGhlIGRvY3MpLgoKPiArLy8vISBW
aXJ0aW8gYWJzdHJhY3Rpb25zCj4gKy8vLyEKPiArLy8vISBDIGhlYWRlcjogW2BpbmNsdWRlL2xp
bnV4L3ZpcnRpby5oYF0oLi4vLi4vLi4vLi4vaW5jbHVkZS9tZWRpYS92aXJ0aW8uaCkKClBsZWFz
ZSBhZGQgYSBibGFuayBsaW5lIGFmdGVyIHRoZSBtb2R1bGUtbGV2ZWwgZG9jcy4KCj4gK3Vuc2Fm
ZSBpbXBsIGNvbnN0IGNyYXRlOjpkcml2ZXI6OlJhd0RldmljZUlkIGZvciBEZXZpY2VJZCB7Cgpg
dW5zYWZlIGltcGxgIG5lZWQgYFNBRkVUWWAgY29tbWVudHMgdG9vLCBqdXN0IGxpa2UgZm9yIGJs
b2NrcyAod2hpY2gKQmrDtnJuIG1lbnRpb25lZCkuIEkgc2VlIHlvdSBkaWQgb25lIGVsc2V3aGVy
ZSwgdGhvdWdoLgoKPiArICAgIC8vIE5vIGBkYXRhYCBwb2ludGVyLgo+ICsgICAgZm4gdG9fcmF3
aWQoJnNlbGYsIF9vZmZzZXQ6IGlzaXplKSAtPiBTZWxmOjpSYXdUeXBlIHsKCkkgc2VlIHRoZXJl
IGlzIG5vIGBkYXRhYCBwb2ludGVyIGNvbXBhcmVkIHRvIGUuZy4gYW4gYGFtYmFfaWRgLCBidXQK
d2hhdCB0aGUgY29tbWVudCBtZWFucz8gSXMgaXQgYWJvdXQgdGhhdCB0aGF0IGlzIHRoZSByZWFz
b24gZm9yCmBfb2Zmc2V0YCBiZWluZyB1bnVzZWQ/IE9yIHNvbWV0aGluZyBlbHNlPwoKPiArICAg
ICAgICBmcm9tX2tlcm5lbF9yZXN1bHQhIHsKCldlIHdpbGwgYmUgZ29pbmcgYXdheSBmcm9tIGBm
cm9tX2tlcm5lbF9yZXN1bHQhYCAoaW4gY2FzZSB5b3Ugd29uZGVyCndoZW4gcmViYXNpbmcgaW4g
dGhlIGZ1dHVyZSkuCgo+ICsgICAgICAgIC8vIFNBRkVUWTogYHZpcnRpb19kZXZpY2VgIGlzIGd1
YXJhbnRlZWQgdG8gYmUgYSB2YWxpZCwgbm9uLW51bGwKPiArICAgICAgICAvLyBwb2ludGVyLiBg
cHJpdl9gIHdhcyBzZXQgb24gcHJvYmUoKS4KCk1hcmtkb3duOiBwcm9iZSgpIC0+IGBwcm9iZSgp
YC4gU2FtZSBlbHNld2hlcmUgd2hlcmUgcG9zc2libGUgdG8gYmUgY29uc2lzdGVudC4KCj4gKyAg
ICAgICAgLy8gU0FGRVRZOgo+ICsgICAgICAgIC8vICAgLSB3ZSBhbGxvY2F0ZWQgdGhpcyBwb2lu
dGVyIHVzaW5nIGBUOjpEYXRhOjppbnRvX2ZvcmVpZ25gLAo+ICsgICAgICAgIC8vICAgICBzbyBp
dCBpcyBzYWZlIHRvIHR1cm4gYmFjayBpbnRvIGEgYFQ6OkRhdGFgLgoKUGxlYXNlIHN0YXJ0IHRo
ZSBzZW50ZW5jZXMgd2l0aCB1cHBlcmNhc2UgKHNhbWUgZWxzZXdoZXJlKS4KCj4gKyAgICAvLy8g
VGhlIHRhYmxlIG9mIGRldmljZSBpZHMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuCgpNYXliZSAi
ZGV2aWNlIGlkcyIgLT4gImBEZXZpY2VJZGBzIj8KClNvbWV3aGVyZSBlbHNlIHlvdSB1c2VkIGFu
IGludHJhLWRvYyBsaW5rLCB3aGljaCBpcyBncmVhdC4gUGxlYXNlIHVzZQp0aGVtIHdoZXJldmVy
IHBvc3NpYmxlLCBlLmcuIGlmIHlvdSBnbyBmb3IgdGhlIHR5cGUgaGVyZSwgbWF5YmUgaXQKd29y
a3MgdG9vIGkuZS4gW2BEZXZpY2VJZGBdCgo+ICsgICAgLy8vIEEgd3JhcHBlciBvdmVyIHZpcnRx
dWV1ZV9hZGRfc2dzKCkKCklmIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHRoZSBDIG9uZSwgbm9ybWFs
bHkgd2Ugbm90ZSB0aGF0IChpLmUuIGluCm9yZGVyIHRvIGRpc3Rpbmd1aXNoIGl0IGZyb20gYSBS
dXN0IG9uZSkuIEFsc28gcGVyaW9kIGF0IHRoZSBlbmQuCgpGb3IgaW5zdGFuY2U6CgogICAgLy8v
IEEgd3JhcHBlciBvdmVyIHRoZSBDIHNpZGUgYHZpcnRxdWV1ZV9hZGRfc2dzKClgLgoKSG93ZXZl
ciwgdGhlIGZ1bmN0aW9uIHNob3VsZCBpbnN0ZWFkIGRvY3VtZW50IHdoYXQgaXQgZG9lcywgcmF0
aGVyCnRoYW4ganVzdCByZWZlciB0byB0aGUgQyBvbmUuIFNhbWUgZWxzZXdoZXJlLgoKPiArICAg
ICAgICAgICAgaWYgYnVmLmlzX251bGwoKSB7Cj4gKyAgICAgICAgICAgICAgICByZXR1cm4gTm9u
ZTsKPiArICAgICAgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgIC8vIFNBRkVUWTog
aWYgdGhlcmUgaXMgYSBidWZmZXIgdG9rZW4sIGl0IGNhbWUgZnJvbQo+ICsgICAgICAgICAgICAg
ICAgLy8gaW50b19mb3JlaWduKCkgYXMgY2FsbGVkIGluIGFkZF9zZ3MuCj4gKyAgICAgICAgICAg
ICAgICA8VDo6UHJpdmF0ZURhdGEgYXMgRm9yZWlnbk93bmFibGU+Ojpmcm9tX2ZvcmVpZ24oYnVm
KQo+ICsgICAgICAgICAgICB9CgpObyBuZWVkIGZvciBgZWxzZWAgYWZ0ZXIgYHJldHVybmAsIHNv
IHlvdSBjYW4gcmVtb3ZlIHRoZSBpbmRlbnRhdGlvbgp0b28uIEFsc28gTWFya2Rvd24uCgo+ICsg
ICAgcHViKGNyYXRlKSB1bnNhZmUgZXh0ZXJuICJDIiBmbiB2cV9jYWxsYmFjayh2cTogKm11dCBi
aW5kaW5nczo6dmlydHF1ZXVlKSB7Cj4gKyAgICAgICAgLy8gU0FGRVRZOiB0aGUgY2FsbGVyIHNo
b3VsZCBndWFyYW50ZWUgdGhhdCB2cSBpcyB2YWxpZCBmb3IgdGhlIGxpZmV0aW1lCj4gKyAgICAg
ICAgLy8gb2YgU2VsZi4KCk1hcmtkb3duIGFuZCB1cHBlcmNhc2UgLS0gaGVyZSBhbmQgZWxzZXdo
ZXJlLCBlLmcuCgogICAgLy8gU0FGRVRZOiBUaGUgY2FsbGVyIHNob3VsZCBndWFyYW50ZWUgdGhh
dCBgdnFgIGlzIHZhbGlkIGZvciB0aGUgbGlmZXRpbWUKICAgIC8vIG9mIGBTZWxmYC4KCj4gKyAg
ICAgICAgICAgIGRldmljZTogMCwgLy8gVGhlIHByb3RvY29sIElELgoKUGxlYXNlIHBsYWNlIHRo
ZSBjb21tZW50IG9uIHRvcC4KCj4gKyAgICAgICAgLy8gbGV0IHZpcnRxdWV1ZSA9IHZpcnRpb19k
ZXYuZmluZF92aXJ0cXVldWU6OjxWaXJ0cXVldWVDYWxsYmFjaz4oa2VybmVsOjpjX3N0ciEoIiIp
KT87CgogICAgLy8gYGBgcnVzdAogICAgLy8gbGV0IC4uLgogICAgLy8gYGBgCgpUaGFua3MgZm9y
IHRoZSBwYXRjaCEKCkNoZWVycywKTWlndWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
