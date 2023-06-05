Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A078C7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 14:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72C8F820EE;
	Mon,  5 Jun 2023 14:03:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72C8F820EE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAAqoKIq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkX5b5fYBbm5; Mon,  5 Jun 2023 14:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F01688209B;
	Mon,  5 Jun 2023 14:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F01688209B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9973C007A;
	Mon,  5 Jun 2023 14:03:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46C29C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A6B5402E1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A6B5402E1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAAqoKIq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBFzVKB47rTV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E73614028E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E73614028E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685973793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B58PehwuXtMeIEL2y0lc7ZS8NrC8+e84ndGNxVAvaoQ=;
 b=dAAqoKIqEBp0e5ormHkDrMhlJUEFcr5DjP8JqOs8+FwRCJ/6qqLxQ5pCELP91RT7bsJ/GG
 AelYRx2xjttpCMzq9Go6L6ZPdt114lWdr7y7RqOjWkW1jrbfg5e38ePHONQNC185wW1oPC
 Dwvt9V/Q/UEuwZ7fxeq4Q+peMeqM4bY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-jb95xinRMPKYUHF0h39T-Q-1; Mon, 05 Jun 2023 10:02:30 -0400
X-MC-Unique: jb95xinRMPKYUHF0h39T-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f604687a23so23325045e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 07:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685973745; x=1688565745;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B58PehwuXtMeIEL2y0lc7ZS8NrC8+e84ndGNxVAvaoQ=;
 b=JC6/RIAfAuvkMlaLKFpN6DKuMkewNpMSQjX+NtJnP/TzgreiDboNCXeH0Hu9QaZc3h
 iKKvXh98U8dfsF3q7z85i4B4ZlTCFW0ZDk9DZn1dXNudDduoekY4lIc7YmFPVtkc582G
 ztgZPMUPHUZxD/VH1aiJe36ND2JobIBtf1tyrt04U/yHsGyBeJgUEOG1eSBuPTyIqy1z
 H120/rT2zmGKTKuLtURTLle03V+2glumdL8z7kmQ1KNyF3USKvkR05Hg4VdRczFtgQEP
 6V090rbLeBZQQk/ZbD8y+Urnja5IlesiQxVewVWSgEpyOjjZic5T0rXo5S8aq+wY5B4o
 n1Mg==
X-Gm-Message-State: AC+VfDxDwNyqVFvCVpPutX6beyDb2okuZ/ROzAFVHMWvrSy8QI7yX6LJ
 fVtYJio0PEXwdh2RC9TV3mh9aQ+DlsRja2VmN8FE4wvTFDOu5tUI4OfCoyuzjaPXGHkSCIr/KSY
 vgrPPkrAC6yEYJGkJ0fQh7/VOJnRLXJMxQNkP7Duqjg==
X-Received: by 2002:a05:600c:3785:b0:3f7:376a:ee60 with SMTP id
 o5-20020a05600c378500b003f7376aee60mr2663304wmr.6.1685973745221; 
 Mon, 05 Jun 2023 07:02:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ECn4u3sYYZdjkfmKExSS7ChQAyzZCtTgPSimSRudIaCZ/DB5a+7gesluQS0zPsIOXcs3X9w==
X-Received: by 2002:a05:600c:3785:b0:3f7:376a:ee60 with SMTP id
 o5-20020a05600c378500b003f7376aee60mr2663287wmr.6.1685973744945; 
 Mon, 05 Jun 2023 07:02:24 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 s1-20020a1cf201000000b003f735d6fa74sm6174214wmc.9.2023.06.05.07.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 07:02:24 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:02:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6LW155ub?= <sheng.zhao@bytedance.com>
Subject: Re: [PATCH] vduse: avoid empty string for dev name
Message-ID: <20230605100127-mutt-send-email-mst@kernel.org>
References: <20230530033626.1266794-1-sheng.zhao@bytedance.com>
 <CACycT3sPTZLho19ZRKPmcTmvRYh4NW9QBT6z=dkq1U_Acd2o6g@mail.gmail.com>
 <CA+nqC_FVJS2Fv98ztY=Szbv7KhqZQ1bQxc-6E909u3z1zub9zA@mail.gmail.com>
 <20230605092326-mutt-send-email-mst@kernel.org>
 <CA+nqC_E44t30v8Kjrx3A36kcyEcAesnEHoP7Q_XJbn129wOT1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+nqC_E44t30v8Kjrx3A36kcyEcAesnEHoP7Q_XJbn129wOT1A@mail.gmail.com>
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

T24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDY6NDg6NDNBTSAtMDcwMCwg6LW155ubIHdyb3RlOgo+
IEZpeGVzOiBjOGE2MTUzYjZjNTkgKCJ2ZHVzZTogSW50cm9kdWNlIFZEVVNFIC0gdkRQQSBEZXZp
Y2UgaW4gVXNlcnNwYWNlIikKClRoYW5rcyEgSnVzdCBkb24ndCBkbyB0aGUgbWFuZ2xlZCB0ZXh0
IGFuZCBhdm9pZCB0b3AtcG9zdGluZyBpbiB0aGUKZnV0dXJlLgoKPiBGcm9tOiAiTWljaGFlbCBT
LiBUc2lya2luIjxtc3RAcmVkaGF0LmNvbT4KPiBEYXRlOiBNb24sIEp1biA1LCAyMDIzLCAyMToy
NAo+IFN1YmplY3Q6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSF0gdmR1c2U6IGF2b2lkIGVtcHR5IHN0
cmluZyBmb3IgZGV2IG5hbWUKPiBUbzogIui1teebmyI8c2hlbmcuemhhb0BieXRlZGFuY2UuY29t
Pgo+IENjOiAiWW9uZ2ppIFhpZSI8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+LCAiSmFzb24gV2Fu
ZyI8amFzb3dhbmdAcmVkaGF0LmNvbT4sIAo+ICJ2aXJ0dWFsaXphdGlvbiI8dmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+LCAiWGlhbmp1biBaZW5nIjwKPiB6ZW5neGlh
bmp1bkBieXRlZGFuY2UuY29tPgo+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA2OjE3OjU1QU0g
LTA3MDAsIOi1teebmyB3cm90ZTogPiBIaSBZb25namkswqAgPiBUaGFua3MKPiBmb3IgeW91ciBm
ZWVkYmFjaywgSSdsbCByZXN1Ym1pdCB0aGUgcGF0Y2ggd2l0aCB0aGlzIGNoYW5nZS4gSnVzdCBz
ZW5kIGEgRml4ZXMKPiB0YWcgaW4gYSByZXBseSBubyBuZWVkIHRvIHJlc3VibWl0IC0gSSBxdWV1
ZWQgaXQgYWxyZWFkeS4gPiBTaGVuZyA+IEZyb206Cj4gIllvbmdqaSBYaWUiPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiA+IERhdGU6wqAgVGh1LCBKdW4gMSwgMjAyMywgMTE6MzEgPgo+IFN1Ympl
Y3Q6wqAgUmU6IFtQQVRDSF0gdmR1c2U6IGF2b2lkIGVtcHR5IHN0cmluZyBmb3IgZGV2IG5hbWUg
PiBUbzogIlNoZW5nIFpoYW8iCj4gPHNoZW5nLnpoYW9AYnl0ZWRhbmNlLmNvbT4gPiBDYzogIk1p
Y2hhZWwgUy4gVHNpcmtpbiI8bXN0QHJlZGhhdC5jb20+LCAiSmFzb24KPiBXYW5nIjxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiwgPiAidmlydHVhbGl6YXRpb24iPAo+IHZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnPiwgIlhpYW5qdW4gWmVuZyI8ID4KPiB6ZW5neGlhbmp1bkBi
eXRlZGFuY2UuY29tPiA+IE9uIFR1ZSwgTWF5IDMwLCAyMDIzIGF0IDExOjM34oCvQU0gU2hlbmcg
WmhhbyA8Cj4gc2hlbmcuemhhb0BieXRlZGFuY2UuY29tPiB3cm90ZTogPiA+ID4gPiBTeXprYWxs
ZXIgaGl0cyBhIGtlcm5lbCBXQVJOwqB3aGVuIHRoZQo+IGZpcnN0IGNoYXJhY3RlciBvZiB0aGUg
ZGV2IG5hbWUgPiA+IHByb3ZpZGVkIGlzIE5VTEwuIFNvbHV0aW9uwqBpcyB0byBhZGQgYSBOVUxM
Cj4gY2hlY2sgYmVmb3JlIGNhbGxpbmcgPiA+IGNkZXZfZGV2aWNlX2FkZCgpIGluIHZkdXNlX2Ny
ZWF0ZV9kZXYoKS4gPiA+ID4gPgo+IGtvYmplY3Q6ICgwMDAwMDAwMDcyMDQyMTY5KTogYXR0ZW1w
dGVkIHRvIGJlIHJlZ2lzdGVyZWQgd2l0aCBlbXB0eSBuYW1lISA+ID4KPiBXQVJOSU5HOiBDUFU6
IDAgUElEOiAxMTI2OTUgYXQgbGliL2tvYmplY3QuYzoyMzYgPiA+IENhbGwgVHJhY2U6ID4gPsKg
Cj4ga29iamVjdF9hZGRfdmFyZyBsaW51eC9zcmMvbGliL2tvYmplY3QuYzozOTAgW2lubGluZV0g
PiA+wqAga29iamVjdF9hZGQrMHhmNi8KPiAweDE1MCBsaW51eC9zcmMvbGliL2tvYmplY3QuYzo0
NDIgPiA+wqAgZGV2aWNlX2FkZCsweDI4Zi8weGMyMCBsaW51eC9zcmMvZHJpdmVycwo+IC9iYXNl
L2NvcmUuYzoyMTY3ID4gPsKgIGNkZXZfZGV2aWNlX2FkZCsweDgzLzB4YzAgbGludXgvc3JjL2Zz
L2NoYXJfZGV2LmM6NTQ2ID4KPiA+wqAgdmR1c2VfY3JlYXRlX2RldiBsaW51eC9zcmMvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYzoyMjU0IFtpbmxpbmVdCj4gPiA+wqAgdmR1c2Vf
aW9jdGwrMHg3YjUvMHhmMzAgbGludXgvc3JjL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2Vf
ZGV2LmM6MjMxNgo+ID4gPsKgIHZmc19pb2N0bCBsaW51eC9zcmMvZnMvaW9jdGwuYzo0NyBbaW5s
aW5lXSA+ID7CoCBmaWxlX2lvY3RsIGxpbnV4L3NyYy9mcy8KPiBpb2N0bC5jOjUxMCBbaW5saW5l
XSA+ID7CoCBkb192ZnNfaW9jdGwrMHgxNGIvMHhhODAgbGludXgvc3JjL2ZzL2lvY3RsLmM6Njk3
ID4gPgo+IMKgIGtzeXNfaW9jdGwrMHg3Yy8weGEwIGxpbnV4L3NyYy9mcy9pb2N0bC5jOjcxNCA+
ID7CoCBfX2RvX3N5c19pb2N0bCBsaW51eC9zcmMvCj4gZnMvaW9jdGwuYzo3MjEgW2lubGluZV0g
PiA+wqAgX19zZV9zeXNfaW9jdGwgbGludXgvc3JjL2ZzL2lvY3RsLmM6NzE5IFtpbmxpbmVdID4K
PiA+wqAgX194NjRfc3lzX2lvY3RsKzB4NDIvMHg1MCBsaW51eC9zcmMvZnMvaW9jdGwuYzo3MTkg
PiA+wqAgZG9fc3lzY2FsbF82NCsweDk0Lwo+IDB4MzMwIGxpbnV4L3NyYy9hcmNoL3g4Ni9lbnRy
eS9jb21tb24uYzoyOTEgPiA+wqAKPiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0
NC8weGE5ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IFhpYW5qdW4gWmVuZyA8Cj4gemVuZ3hpYW5qdW5A
Ynl0ZWRhbmNlLmNvbT4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5nIFpoYW8gPAo+IHNoZW5nLnpo
YW9AYnl0ZWRhbmNlLmNvbT4gPiA+IE1pc3MgYSAiRml4ZXMiIHRhZy4gT3RoZXJzIGxvb2sgZ29v
ZCB0byBtZS4gPiA+Cj4gUmV2aWV3ZWQtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPiA+ID4gVGhhbmtzLCA+IFlvbmdqaSA+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
