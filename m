Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC71C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E26540546;
	Mon,  5 Jun 2023 13:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E26540546
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dJO0XkgZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8_8CGXGLXHHg; Mon,  5 Jun 2023 13:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D390F404F0;
	Mon,  5 Jun 2023 13:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D390F404F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A594BC007A;
	Mon,  5 Jun 2023 13:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC3F4C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9759360A5F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9759360A5F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dJO0XkgZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNbKlMlb_S6C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:23:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1AE9607FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1AE9607FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685971435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGOFo02ulBobebUUOfbjWdZ9ak0GtrGPlLetdIzCvFI=;
 b=dJO0XkgZOljsY2suvDiKmSzwdvPm5EZbJ0EhCXyfsa4xsGPCPaV3vKfxth/VJHCnUsOkuO
 wl5NbRY7G+0QNUmpuVsSS7KsMh9HD1f0dWnQ/9qXlG6sVW6mVhslxUeAiIrWqD5YvIpCDy
 cFcGWWWSeFTUbJzbDWAMhCgxwZ79peI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-RzlrKP1PPLWIUMjLqgnlyw-1; Mon, 05 Jun 2023 09:23:54 -0400
X-MC-Unique: RzlrKP1PPLWIUMjLqgnlyw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so2560480f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685971433; x=1688563433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGOFo02ulBobebUUOfbjWdZ9ak0GtrGPlLetdIzCvFI=;
 b=ElGeswURKx/aSSH2iOWqfYmGfNCCmyL86HKHWp7E2r59sXVB8tXnKTvyYf7TKI/2mI
 8ywKXXdsHAbkGkkiXRneNgUG/WF65JEjfFUs+XlcQQEpOoEQ/GnDgR/gcM4XwH4FemSD
 txUJTgLwMBa9+E36JWZTMh3o6zCSf7LQSClfNXhPKinyyw9+1xaAE8OT74lGYNYJVjc4
 K5IgblPZnHC1VCbakK2HydvTOgRd5UeyvQvDYnVwz40v4MLifw/098s4PiscZYflkAdp
 sPHqNNKhDkRSsr+sby/UddUi0rtHDyRcl1AREzAekvO22p7HuaZxRDh6EQWEdHCY4iMX
 guHQ==
X-Gm-Message-State: AC+VfDyCc/KAxOirDUDw0pwe85IaMLEZItTkD10K0KT8KYuoWK6Me3mb
 l8WZf42Jd3yaJyKqRiTEbDJ1VTm4CUwodOO6G8tV3UieCj9wzPFKNUjy9PhtAlYIZKu7Lrd6aEk
 9oOBOoIqj22tY6VLsbPuSE8z5+c53GS/kJEWhVd9JDA==
X-Received: by 2002:a5d:4ec2:0:b0:309:3bc3:7d1f with SMTP id
 s2-20020a5d4ec2000000b003093bc37d1fmr4970699wrv.70.1685971433006; 
 Mon, 05 Jun 2023 06:23:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a/WiPW92ZjoJN2DvS/mNJYYs4EN4hrIQiwj5z57IZbREmGjVSPm8829mz70O6pvHwVuc30w==
X-Received: by 2002:a5d:4ec2:0:b0:309:3bc3:7d1f with SMTP id
 s2-20020a5d4ec2000000b003093bc37d1fmr4970691wrv.70.1685971432733; 
 Mon, 05 Jun 2023 06:23:52 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 g8-20020adfe408000000b003078a3f3a24sm9766426wrm.114.2023.06.05.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 06:23:52 -0700 (PDT)
Date: Mon, 5 Jun 2023 09:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6LW155ub?= <sheng.zhao@bytedance.com>
Subject: Re: [PATCH] vduse: avoid empty string for dev name
Message-ID: <20230605092326-mutt-send-email-mst@kernel.org>
References: <20230530033626.1266794-1-sheng.zhao@bytedance.com>
 <CACycT3sPTZLho19ZRKPmcTmvRYh4NW9QBT6z=dkq1U_Acd2o6g@mail.gmail.com>
 <CA+nqC_FVJS2Fv98ztY=Szbv7KhqZQ1bQxc-6E909u3z1zub9zA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+nqC_FVJS2Fv98ztY=Szbv7KhqZQ1bQxc-6E909u3z1zub9zA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Yongji Xie <xieyongji@bytedance.com>,
 Xianjun Zeng <zengxianjun@bytedance.com>,
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

T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDY6MTc6NTVBTSAtMDcwMCwg6LW155ubIHdyb3RlOgo+
IEhpIFlvbmdqaSzCoAo+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjaywgSSdsbCByZXN1Ym1pdCB0
aGUgcGF0Y2ggd2l0aCB0aGlzIGNoYW5nZS4KCgpKdXN0IHNlbmQgYSBGaXhlcyB0YWcgaW4gYSBy
ZXBseSBubyBuZWVkIHRvIHJlc3VibWl0IC0gSSBxdWV1ZWQgaXQKYWxyZWFkeS4KCj4gU2hlbmcK
PiBGcm9tOiAiWW9uZ2ppIFhpZSI8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gRGF0ZTrCoCBU
aHUsIEp1biAxLCAyMDIzLCAxMTozMQo+IFN1YmplY3Q6wqAgUmU6IFtQQVRDSF0gdmR1c2U6IGF2
b2lkIGVtcHR5IHN0cmluZyBmb3IgZGV2IG5hbWUKPiBUbzogIlNoZW5nIFpoYW8iPHNoZW5nLnpo
YW9AYnl0ZWRhbmNlLmNvbT4KPiBDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiI8bXN0QHJlZGhhdC5j
b20+LCAiSmFzb24gV2FuZyI8amFzb3dhbmdAcmVkaGF0LmNvbT4sCj4gInZpcnR1YWxpemF0aW9u
Ijx2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4sICJYaWFuanVuIFpl
bmciPAo+IHplbmd4aWFuanVuQGJ5dGVkYW5jZS5jb20+Cj4gT24gVHVlLCBNYXkgMzAsIDIwMjMg
YXQgMTE6MzfigK9BTSBTaGVuZyBaaGFvIDxzaGVuZy56aGFvQGJ5dGVkYW5jZS5jb20+IHdyb3Rl
Ogo+ID4KPiA+IFN5emthbGxlciBoaXRzIGEga2VybmVsIFdBUk7CoHdoZW4gdGhlIGZpcnN0IGNo
YXJhY3RlciBvZiB0aGUgZGV2IG5hbWUKPiA+IHByb3ZpZGVkIGlzIE5VTEwuIFNvbHV0aW9uwqBp
cyB0byBhZGQgYSBOVUxMIGNoZWNrIGJlZm9yZSBjYWxsaW5nCj4gPiBjZGV2X2RldmljZV9hZGQo
KSBpbiB2ZHVzZV9jcmVhdGVfZGV2KCkuCj4gPgo+ID4ga29iamVjdDogKDAwMDAwMDAwNzIwNDIx
NjkpOiBhdHRlbXB0ZWQgdG8gYmUgcmVnaXN0ZXJlZCB3aXRoIGVtcHR5IG5hbWUhCj4gPiBXQVJO
SU5HOiBDUFU6IDAgUElEOiAxMTI2OTUgYXQgbGliL2tvYmplY3QuYzoyMzYKPiA+IENhbGwgVHJh
Y2U6Cj4gPsKgIGtvYmplY3RfYWRkX3ZhcmcgbGludXgvc3JjL2xpYi9rb2JqZWN0LmM6MzkwIFtp
bmxpbmVdCj4gPsKgIGtvYmplY3RfYWRkKzB4ZjYvMHgxNTAgbGludXgvc3JjL2xpYi9rb2JqZWN0
LmM6NDQyCj4gPsKgIGRldmljZV9hZGQrMHgyOGYvMHhjMjAgbGludXgvc3JjL2RyaXZlcnMvYmFz
ZS9jb3JlLmM6MjE2Nwo+ID7CoCBjZGV2X2RldmljZV9hZGQrMHg4My8weGMwIGxpbnV4L3NyYy9m
cy9jaGFyX2Rldi5jOjU0Ngo+ID7CoCB2ZHVzZV9jcmVhdGVfZGV2IGxpbnV4L3NyYy9kcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jOjIyNTQgW2lubGluZV0KPiA+wqAgdmR1c2VfaW9j
dGwrMHg3YjUvMHhmMzAgbGludXgvc3JjL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2
LmM6MjMxNgo+ID7CoCB2ZnNfaW9jdGwgbGludXgvc3JjL2ZzL2lvY3RsLmM6NDcgW2lubGluZV0K
PiA+wqAgZmlsZV9pb2N0bCBsaW51eC9zcmMvZnMvaW9jdGwuYzo1MTAgW2lubGluZV0KPiA+wqAg
ZG9fdmZzX2lvY3RsKzB4MTRiLzB4YTgwIGxpbnV4L3NyYy9mcy9pb2N0bC5jOjY5Nwo+ID7CoCBr
c3lzX2lvY3RsKzB4N2MvMHhhMCBsaW51eC9zcmMvZnMvaW9jdGwuYzo3MTQKPiA+wqAgX19kb19z
eXNfaW9jdGwgbGludXgvc3JjL2ZzL2lvY3RsLmM6NzIxIFtpbmxpbmVdCj4gPsKgIF9fc2Vfc3lz
X2lvY3RsIGxpbnV4L3NyYy9mcy9pb2N0bC5jOjcxOSBbaW5saW5lXQo+ID7CoCBfX3g2NF9zeXNf
aW9jdGwrMHg0Mi8weDUwIGxpbnV4L3NyYy9mcy9pb2N0bC5jOjcxOQo+ID7CoCBkb19zeXNjYWxs
XzY0KzB4OTQvMHgzMzAgbGludXgvc3JjL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjI5MQo+ID7C
oCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cj4gPgo+ID4gUmVwb3J0
ZWQtYnk6IFhpYW5qdW4gWmVuZyA8emVuZ3hpYW5qdW5AYnl0ZWRhbmNlLmNvbT4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoZW5nIFpoYW8gPHNoZW5nLnpoYW9AYnl0ZWRhbmNlLmNvbT4KPiAKPiBNaXNz
IGEgIkZpeGVzIiB0YWcuIE90aGVycyBsb29rIGdvb2QgdG8gbWUuCj4gCj4gUmV2aWV3ZWQtYnk6
IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IAo+IFRoYW5rcywKPiBZb25n
amkKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
