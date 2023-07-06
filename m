Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E34C001B0
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 13:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AD8D8120A;
	Thu,  6 Jul 2023 13:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AD8D8120A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=jW8fZyoU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jh2bBZ_oLE3l; Thu,  6 Jul 2023 13:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CB5B80E9F;
	Thu,  6 Jul 2023 13:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CB5B80E9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA2D2C0072;
	Thu,  6 Jul 2023 13:58:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE43AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 13:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BBD560634
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 13:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BBD560634
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=jW8fZyoU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YyZ9Vqs1wrHs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 13:58:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5DED600B6
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5DED600B6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 13:58:38 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a04e5baffcso746745b6e.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688651917; x=1691243917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Hp8tU9cWu6R6f3sn+8A1XNNoAmV3ki5dbuL76Q7q/g=;
 b=jW8fZyoU3DO00/VknLBRC1h6kBMu8XI1LsUcKUKbG7uS5K1zHOZBpp0CDxgpvDTFKw
 +5FkbPG7Q9BwXmE1ZYHxTwB7BM4JadMfceYFtCn07I0gnGEOHbDw3Y4g3euxTJn17A6G
 NmkXaQsNHQ20wcd9dWE9ayH70yxcuwfl3TonKln0gWcCqgO3A7voL187FesbmfRYIg1b
 WIQvbCmy5b2Lo2HrqAjcbhWboCl225wSoQ+oL8U5+yMAKgb5dagv5oGgo7zCR0T9aWKy
 jRrdwXUITSOIUq9BgJvgnuKEX8bW1agbSp6/6Og0vPnJD79JI5iigu9n5yVyvcg3sRv9
 BPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688651917; x=1691243917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Hp8tU9cWu6R6f3sn+8A1XNNoAmV3ki5dbuL76Q7q/g=;
 b=GP72+y9p1YtVQ+2Nvy81XseuYhGUmZfzCM5WoxALsz1WnW8pISLLUzYKRzvytFvujt
 fv9x6lyCSSt4oZ5BLkpuatKJ41up7oHxpWqbkM4jjMpVK+XvvsXBzgthghTF9m6jlpdk
 FX10IidsIH6BvKYF5CXLr4VsMyFnFCSWCzGbaOW86F1TpHutAHvVSBw63arJ7TqNqz6o
 wNGDlY50BoCZXHpwEOg8e8IA7Vyqu4jfqNPo6YSiOFzCfgcIRjbdmvYqOCzl/XSqh61K
 6sBp3VNk4mIx/4m+2q1Ab3k/otxm3W3y/ObVevQfSBptc+IKEJ50dRP2H85VdTFWfy4B
 s3AA==
X-Gm-Message-State: ABy/qLaz5Kzq3r+Mw3WIpkY4vlWmfm8k+drnn/rTUFylDO1RaOJcLH3c
 Vi58zL4zFND3o5t6WrSSbdhcGcjp13t7ofhsqm8=
X-Google-Smtp-Source: APBJJlHwWrHIAzdFBa636bFDMNRZF9RFGE1HyH/tDHgJxsmdjuaeJ2kJEJRRwYbbDY70pb0vxaKHA7rj0kFXbVJUIRU=
X-Received: by 2002:a05:6808:1d6:b0:3a0:4dc3:25ff with SMTP id
 x22-20020a05680801d600b003a04dc325ffmr2199089oic.7.1688651917567; Thu, 06 Jul
 2023 06:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230706021102.2066-1-yangrong@vivo.com>
In-Reply-To: <20230706021102.2066-1-yangrong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 09:58:26 -0400
Message-ID: <CADnq5_MSkJf=-QMPYNQp03=6mbb+OEHnPFW0=WKiS0VMc6ricQ@mail.gmail.com>
Subject: Re: [PATCH] Fix max/min warnings in virtio_net, amd/display,
 and io_uring
To: Yang Rong <yangrong@vivo.com>
Cc: Max Tseng <Max.Tseng@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jun Lei <Jun.Lei@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 Alvin Lee <Alvin.Lee2@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Harry Wentland <harry.wentland@amd.com>,
 opensource.kernel@vivo.com, Leo Li <sunpeng.li@amd.com>,
 Cruise Hung <cruise.hung@amd.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>, luhongfei@vivo.com,
 "David S. Miller" <davem@davemloft.net>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCAzOjM34oCvQU0gWWFuZyBSb25nIDx5YW5ncm9uZ0B2aXZv
LmNvbT4gd3JvdGU6Cj4KPiBUaGUgZmlsZXMgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jLCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYywgYW5kIGlvX3VyaW5nL2lv
X3VyaW5nLmMgd2VyZSBtb2RpZmllZCB0byBmaXggd2FybmluZ3MuCj4gU3BlY2lmaWNhbGx5LCB0
aGUgb3Bwb3J0dW5pdGllcyBmb3IgbWF4KCkgYW5kIG1pbigpIHdlcmUgdXRpbGl6ZWQgdG8gYWRk
cmVzcyB0aGUgd2FybmluZ3MuCgpQbGVhc2Ugc3BsaXQgdGhpcyBpbnRvIDMgcGF0Y2hlcywgb25l
IGZvciBlYWNoIGNvbXBvbmVudC4KCkFsZXgKCj4KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFJvbmcg
PHlhbmdyb25nQHZpdm8uY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNfZG11Yl9zcnYuYyB8IDYgKysrLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAg
ICAgICAgICAgICAgICAgICAgIHwgMyArKy0KPiAgaW9fdXJpbmcvaW9fdXJpbmcuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAzICsrLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY19kbXViX3Nydi5jCj4gaW5kZXggYzc1M2M2ZjMwZGQ3Li5kZjc5YWVhNDlhM2MgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuYwo+IEBAIC0y
Miw3ICsyMiw3IEBACj4gICAqIEF1dGhvcnM6IEFNRAo+ICAgKgo+ICAgKi8KPiAtCj4gKyNpbmNs
dWRlIDxsaW51eC9taW5tYXguaD4KPiAgI2luY2x1ZGUgImRjLmgiCj4gICNpbmNsdWRlICJkY19k
bXViX3Nydi5oIgo+ICAjaW5jbHVkZSAiLi4vZG11Yi9kbXViX3Nydi5oIgo+IEBAIC00ODEsNyAr
NDgxLDcgQEAgc3RhdGljIHZvaWQgcG9wdWxhdGVfc3VidnBfY21kX2Rycl9pbmZvKHN0cnVjdCBk
YyAqZGMsCj4gICAgICAgICBtYXhfZHJyX3ZibGFua191cyA9IGRpdjY0X3U2NCgoc3VidnBfYWN0
aXZlX3VzIC0gcHJlZmV0Y2hfdXMgLQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRjLT5jYXBz
LnN1YnZwX2Z3X3Byb2Nlc3NpbmdfZGVsYXlfdXMgLSBkcnJfYWN0aXZlX3VzKSwgMikgKyBkcnJf
YWN0aXZlX3VzOwo+ICAgICAgICAgbWF4X2Rycl9tYWxscmVnaW9uX3VzID0gc3VidnBfYWN0aXZl
X3VzIC0gcHJlZmV0Y2hfdXMgLSBtYWxsX3JlZ2lvbl91cyAtIGRjLT5jYXBzLnN1YnZwX2Z3X3By
b2Nlc3NpbmdfZGVsYXlfdXM7Cj4gLSAgICAgICBtYXhfZHJyX3N1cHBvcnRlZF91cyA9IG1heF9k
cnJfdmJsYW5rX3VzID4gbWF4X2Rycl9tYWxscmVnaW9uX3VzID8gbWF4X2Rycl92YmxhbmtfdXMg
OiBtYXhfZHJyX21hbGxyZWdpb25fdXM7Cj4gKyAgICAgICBtYXhfZHJyX3N1cHBvcnRlZF91cyA9
IG1heChtYXhfZHJyX3ZibGFua191cywgbWF4X2Rycl9tYWxscmVnaW9uX3VzKTsKPiAgICAgICAg
IG1heF92dG90YWxfc3VwcG9ydGVkID0gZGl2NjRfdTY0KCgodWludDY0X3QpZHJyX3RpbWluZy0+
cGl4X2Nsa18xMDBoeiAqIDEwMCAqIG1heF9kcnJfc3VwcG9ydGVkX3VzKSwKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAoKCh1aW50NjRfdClkcnJfdGltaW5nLT5oX3RvdGFsICogMTAwMDAwMCkp
KTsKPgo+IEBAIC03NzEsNyArNzcxLDcgQEAgdm9pZCBkY19kbXViX3NldHVwX3N1YnZwX2RtdWJf
Y29tbWFuZChzdHJ1Y3QgZGMgKmRjLAo+ICAgICAgICAgICAgICAgICB3bV92YWxfcmVmY2xrID0g
Y29udGV4dC0+YndfY3R4LmJ3LmRjbi53YXRlcm1hcmtzLmEuY3N0YXRlX3BzdGF0ZS5wc3RhdGVf
Y2hhbmdlX25zICoKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChkYy0+cmVzX3Bv
b2wtPnJlZl9jbG9ja3MuZGNodWJfcmVmX2Nsb2NrX2luS2h6IC8gMTAwMCkgLyAxMDAwOwo+Cj4g
LSAgICAgICAgICAgICAgIGNtZC5md19hc3Npc3RlZF9tY2xrX3N3aXRjaF92Mi5jb25maWdfZGF0
YS53YXRlcm1hcmtfYV9jYWNoZSA9IHdtX3ZhbF9yZWZjbGsgPCAweEZGRkYgPyB3bV92YWxfcmVm
Y2xrIDogMHhGRkZGOwo+ICsgICAgICAgICAgICAgICBjbWQuZndfYXNzaXN0ZWRfbWNsa19zd2l0
Y2hfdjIuY29uZmlnX2RhdGEud2F0ZXJtYXJrX2FfY2FjaGUgPSBtaW4od21fdmFsX3JlZmNsaywg
MHhGRkZGKTsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgZG1fZXhlY3V0ZV9kbXViX2NtZChkYy0+
Y3R4LCAmY21kLCBETV9ETVVCX1dBSVRfVFlQRV9XQUlUKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggOWIz
NzIxNDI0ZTcxLi41YmI3ZGE4ODVmMDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTIyLDYgKzIyLDcg
QEAKPiAgI2luY2x1ZGUgPG5ldC9yb3V0ZS5oPgo+ICAjaW5jbHVkZSA8bmV0L3hkcC5oPgo+ICAj
aW5jbHVkZSA8bmV0L25ldF9mYWlsb3Zlci5oPgo+ICsjaW5jbHVkZSA8bGludXgvbWlubWF4Lmg+
Cj4KPiAgc3RhdGljIGludCBuYXBpX3dlaWdodCA9IE5BUElfUE9MTF9XRUlHSFQ7Cj4gIG1vZHVs
ZV9wYXJhbShuYXBpX3dlaWdodCwgaW50LCAwNDQ0KTsKPiBAQCAtMTI5MSw3ICsxMjkyLDcgQEAg
c3RhdGljIHN0cnVjdCBza19idWZmICpidWlsZF9za2JfZnJvbV94ZHBfYnVmZihzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+ICAgICAgICAgX19za2JfcHV0KHNrYiwgZGF0YV9sZW4pOwo+Cj4gICAg
ICAgICBtZXRhc2l6ZSA9IHhkcC0+ZGF0YSAtIHhkcC0+ZGF0YV9tZXRhOwo+IC0gICAgICAgbWV0
YXNpemUgPSBtZXRhc2l6ZSA+IDAgPyBtZXRhc2l6ZSA6IDA7Cj4gKyAgICAgICBtZXRhc2l6ZSA9
IG1heChtZXRhc2l6ZSwgMCk7Cj4gICAgICAgICBpZiAobWV0YXNpemUpCj4gICAgICAgICAgICAg
ICAgIHNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4KPiBkaWZmIC0tZ2l0IGEvaW9f
dXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKPiBpbmRleCBlODA5NmQ1MDJh
N2MuLjg3NWNhNjU3MjI3ZCAxMDA2NDQKPiAtLS0gYS9pb191cmluZy9pb191cmluZy5jCj4gKysr
IGIvaW9fdXJpbmcvaW9fdXJpbmcuYwo+IEBAIC00Nyw2ICs0Nyw3IEBACj4gICNpbmNsdWRlIDxs
aW51eC9yZWZjb3VudC5oPgo+ICAjaW5jbHVkZSA8bGludXgvdWlvLmg+Cj4gICNpbmNsdWRlIDxs
aW51eC9iaXRzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9taW5tYXguaD4KPgo+ICAjaW5jbHVkZSA8
bGludXgvc2NoZWQvc2lnbmFsLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9mcy5oPgo+IEBAIC0yNjYw
LDcgKzI2NjEsNyBAQCBzdGF0aWMgdm9pZCAqX19pb191YWRkcl9tYXAoc3RydWN0IHBhZ2UgKioq
cGFnZXMsIHVuc2lnbmVkIHNob3J0ICpucGFnZXMsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBhZ2VfYXJyYXkpOwo+ICAgICAgICAgaWYgKHJldCAhPSBucl9wYWdl
cykgewo+ICBlcnI6Cj4gLSAgICAgICAgICAgICAgIGlvX3BhZ2VzX2ZyZWUoJnBhZ2VfYXJyYXks
IHJldCA+IDAgPyByZXQgOiAwKTsKPiArICAgICAgICAgICAgICAgaW9fcGFnZXNfZnJlZSgmcGFn
ZV9hcnJheSwgbWF4KHJldCwgMCkpOwo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0IDwgMCA/
IEVSUl9QVFIocmV0KSA6IEVSUl9QVFIoLUVGQVVMVCk7Cj4gICAgICAgICB9Cj4gICAgICAgICAv
Kgo+IC0tCj4gMi4zNS4zCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YaF5a655Y+v6IO95ZCr5pyJ5py65a+G5ZKML+aIlumakOen
geS/oeaBr++8jOS7heS+m+aMh+WumuS4quS6uuaIluacuuaehOS9v+eUqOOAguiLpeaCqOmdnuWP
keS7tuS6uuaMh+WumuaUtuS7tuS6uuaIluWFtuS7o+eQhuS6uu+8jOivt+WLv+S9v+eUqOOAgeS8
oOaSreOAgeWkjeWItuaIluWtmOWCqOatpOmCruS7tuS5i+S7u+S9leWGheWuueaIluWFtumZhOS7
tuOAguWmguaCqOivr+aUtuacrOmCruS7tu+8jOivt+WNs+S7peWbnuWkjeaIlueUteivneaWueW8
j+mAmuefpeWPkeS7tuS6uu+8jOW5tuWwhuWOn+Wni+mCruS7tuOAgemZhOS7tuWPiuWFtuaJgOac
ieWkjeacrOWIoOmZpOOAguiwouiwouOAggo+IFRoZSBjb250ZW50cyBvZiB0aGlzIG1lc3NhZ2Ug
YW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kL29yIHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gYW5kIGFyZSBpbnRlbmRlZCBleGNsdXNpdmVseSBmb3IgdGhlIGFk
ZHJlc3NlZShzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlz
IG1lc3NhZ2Ugb3IgdGhlaXIgYWdlbnQsIHBsZWFzZSBub3RlIHRoYXQgYW55IHVzZSwgZGlzc2Vt
aW5hdGlvbiwgY29weWluZywgb3Igc3RvcmFnZSBvZiB0aGlzIG1lc3NhZ2Ugb3IgaXRzIGF0dGFj
aG1lbnRzIGlzIG5vdCBhbGxvd2VkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIG1lc3NhZ2UgaW4gZXJy
b3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSB0aGUgbWVzc2FnZSBvciBwaG9u
ZSBhbmQgZGVsZXRlIHRoaXMgbWVzc2FnZSwgYW55IGF0dGFjaG1lbnRzIGFuZCBhbnkgY29waWVz
IGltbWVkaWF0ZWx5Lgo+IFRoYW5rIHlvdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
