Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E243C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:17:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E0523A32
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLDw1aLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E0523A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CDE4020458;
	Mon, 16 Nov 2020 10:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KwnFTOUIJHvX; Mon, 16 Nov 2020 10:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 87D2320005;
	Mon, 16 Nov 2020 10:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68F45C0800;
	Mon, 16 Nov 2020 10:17:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F04CC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6CDB285EB8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eRzB5npwx6yB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B1B0D85D6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605521829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8H2Bqogs1J5gueWTa1ZNYeIaGfg76P0inT/06O0WmI=;
 b=eLDw1aLoZSB4FfPOsYEbaV0SfiCTZXs2tKob+tMdZ9sxJq99bBBtUsubmhBnNj39DV7E2d
 B0tbCV6HWB5AAQIyJQllvpZ54HVCONW3bJB1vRVe4RCtpJn3xDA6hkCbBIM2bFJLmep7t6
 pUmQ6H0ZycrA9hOPmKflcPvEEz+8k+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Wiclc0DyPM2MAOp1MDI_PQ-1; Mon, 16 Nov 2020 05:17:07 -0500
X-MC-Unique: Wiclc0DyPM2MAOp1MDI_PQ-1
Received: by mail-wm1-f69.google.com with SMTP id q17so3244816wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 02:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=S8H2Bqogs1J5gueWTa1ZNYeIaGfg76P0inT/06O0WmI=;
 b=UEGAWuoXiqGymTMTcyLNA6zVs68BOBEi85uR9euShpEiWRdUBMQYtcGJniroT+v+GY
 lDZTaX0Vyjs8xxFaWZeDoDVqa9SUydRPomQTtSHjoFtjc7lm2q7Y7lbIH7brLOWXo2wg
 1gFHSxVx5U2NiyNQB26VETfmfDlJcw+XeO57MUmaIfFNHfo8ICus4XnSrs6iQcfYeYRA
 Dd1j1Hfeu+qipqSxqqm1PLpeENczu6S6rIaM/u2K1pju3kN+nzaDqfJgGkcNBDesKq/h
 VHgaPksOfmsoslVexmQ8XVRXTnt4uybsYFBd9bjnIdLpzY8ESmdFmkIeBGx6ycOXaHF2
 YLjA==
X-Gm-Message-State: AOAM533/jgdpXFbP8xwfrjWagbNZlFL2N/1dA8cn5MtTgeMjPKAfOACv
 g6Oa71krw7rsJ6Wqh4pwFPHb2qZmq/zKN1A06wU+6HUGhVERdQpOfktq9XRXjXULoogWum1If+S
 0Ygpez0Un+FQdNM4DoG7SnO+JarGG6Zt2LiP+n0Jg4A==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr18175666wru.216.1605521826535; 
 Mon, 16 Nov 2020 02:17:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx420RhxBNM3R45JOIo3M19vsC37oxfl86iZcNklSUhq2+ppSFKN6ilOZkrtEtxMbhBryd87A==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr18175643wru.216.1605521826323; 
 Mon, 16 Nov 2020 02:17:06 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id v19sm23043208wrf.40.2020.11.16.02.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 02:17:05 -0800 (PST)
Date: Mon, 16 Nov 2020 11:17:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201116101703.3gdazzatvvgqbc3a@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
MIME-Version: 1.0
In-Reply-To: <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MTA6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+RnJvbTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPj4KPj5UaGlzIHdp
bGwgYWxsb3cgcnVubmluZyB2RFBBIGZvciB2aXJ0aW8gYmxvY2sgcHJvdG9jb2wuCj4+Cj4+U2ln
bmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPj5bc2dhcnph
cmU6IHZhcmlvdXMgY2xlYW51cHMvZml4ZXNdCj4+U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+PnYxOgo+Pi0gUmVtb3ZlZCB1bnVz
ZWQgaGVhZGVycwo+Pi0gVXNlZCBjcHVfdG9fdmRwYXNpbSooKSB0byBzdG9yZSBjb25maWcgZmll
bGRzCj4+LSBSZXBsYWNlZCAnc2VsZWN0IFZEUEFfU0lNJyB3aXRoICdkZXBlbmRzIG9uIFZEUEFf
U0lNJyBzaW5jZSBzZWxlY3RlZAo+PiAgIG9wdGlvbiBjYW4gbm90IGRlcGVuZCBvbiBvdGhlciBb
SmFzb25dCj4+LSBTdGFydCB3aXRoIGEgc2luZ2xlIHF1ZXVlIGZvciBub3cgW0phc29uXQo+Pi0g
QWRkIGNvbW1lbnRzIHRvIG1lbW9yeSBiYXJyaWVycwo+Pi0tLQo+PiAgZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgMTI0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
PiAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICA5ICsrCj4+ICBkcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vTWFrZWZpbGUgICAgICAgfCAgIDEgKwo+PiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMzQgaW5zZXJ0aW9ucygrKQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+Pgo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
YmxrLmMKPj5uZXcgZmlsZSBtb2RlIDEwMDY0NAo+PmluZGV4IDAwMDAwMDAwMDAwMC4uMzg2ZGJi
MmY3MTM4Cj4+LS0tIC9kZXYvbnVsbAo+PisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbV9ibGsuYwo+PkBAIC0wLDAgKzEsMTI0IEBACj4+Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkKPj4rLyoKPj4rICogVkRQQSBzaW11bGF0b3IgZm9yIGJsb2NrIGRl
dmljZS4KPj4rICoKPj4rICogQ29weXJpZ2h0IChjKSAyMDIwLCBNZWxsYW5veCBUZWNobm9sb2dp
ZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuCj4+KyAqCj4+KyAqLwo+PisKPj4rI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPgo+PisKPj4rI2luY2x1ZGUgInZkcGFfc2ltLmgiCj4+Kwo+PisjZGVmaW5l
IFZEUEFTSU1fQkxLX0ZFQVRVUkVTCSgoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgpIHwg
XAo+PisJCQkJICgxVUxMIDw8IFZJUlRJT19CTEtfRl9TRUdfTUFYKSAgfCBcCj4+KwkJCQkgKDFV
TEwgPDwgVklSVElPX0JMS19GX0JMS19TSVpFKSB8IFwKPj4rCQkJCSAoMVVMTCA8PCBWSVJUSU9f
QkxLX0ZfVE9QT0xPR1kpIHwgXAo+PisJCQkJICgxVUxMIDw8IFZJUlRJT19CTEtfRl9NUSkpCj4+
Kwo+PisjZGVmaW5lIFZEUEFTSU1fQkxLX0NBUEFDSVRZIDB4NDAwMDAKPj4rI2RlZmluZSBWRFBB
U0lNX0JMS19TSVpFX01BWCAweDEwMDAKPj4rI2RlZmluZSBWRFBBU0lNX0JMS19TRUdfTUFYIDMy
Cj4+KyNkZWZpbmUgVkRQQVNJTV9CTEtfVlFfTlVNIDEKPj4rCj4+K3N0YXRpYyBzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbV9ibGtfZGV2Owo+PisKPj4rc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+K3sKPj4rCXN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2ZHBhc2ltLCB3b3JrKTsKPj4rCXU4IHN0
YXR1cyA9IFZJUlRJT19CTEtfU19PSzsKPj4rCWludCBpOwo+PisKPj4rCXNwaW5fbG9jaygmdmRw
YXNpbS0+bG9jayk7Cj4+Kwo+PisJaWYgKCEodmRwYXNpbS0+c3RhdHVzICYgVklSVElPX0NPTkZJ
R19TX0RSSVZFUl9PSykpCj4+KwkJZ290byBvdXQ7Cj4+Kwo+PisJZm9yIChpID0gMDsgaSA8IFZE
UEFTSU1fQkxLX1ZRX05VTTsgaSsrKSB7Cj4+KwkJc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2
cSA9ICZ2ZHBhc2ltLT52cXNbaV07Cj4+Kwo+PisJCWlmICghdnEtPnJlYWR5KQo+PisJCQljb250
aW51ZTsKPj4rCj4+KwkJd2hpbGUgKHZyaW5naF9nZXRkZXNjX2lvdGxiKCZ2cS0+dnJpbmcsICZ2
cS0+aW92LCAmdnEtPmlvdiwKPj4rCQkJCQkgICAgJnZxLT5oZWFkLCBHRlBfQVRPTUlDKSA+IDAp
IHsKPj4rCj4+KwkJCWludCB3cml0ZTsKPj4rCj4+KwkJCXZxLT5pb3YuaSA9IHZxLT5pb3YudXNl
ZCAtIDE7Cj4+KwkJCXdyaXRlID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsICZ2
cS0+aW92LCAmc3RhdHVzLCAxKTsKPj4rCQkJaWYgKHdyaXRlIDw9IDApCj4+KwkJCQlicmVhazsK
Pj4rCj4+KwkJCS8qIE1ha2Ugc3VyZSBkYXRhIGlzIHdyb3RlIGJlZm9yZSBhZHZhbmNpbmcgaW5k
ZXggKi8KPj4rCQkJc21wX3dtYigpOwo+PisKPj4rCQkJdnJpbmdoX2NvbXBsZXRlX2lvdGxiKCZ2
cS0+dnJpbmcsIHZxLT5oZWFkLCB3cml0ZSk7Cj4+Kwo+PisJCQkvKiBNYWtlIHN1cmUgdXNlZCBp
cyB2aXNpYmxlIGJlZm9yZSByYXNpbmcgdGhlIGludGVycnVwdC4gKi8KPj4rCQkJc21wX3dtYigp
Owo+PisKPj4rCQkJaWYgKHZyaW5naF9uZWVkX25vdGlmeV9pb3RsYigmdnEtPnZyaW5nKSA+IDAp
Cj4+KwkJCQl2cmluZ2hfbm90aWZ5KCZ2cS0+dnJpbmcpOwo+Cj4KPkRvIHdlIGluaXRpYWxpemUg
dnJoLT5ub3RpZnkgYW55d2hlcmU/IEFuZCBUaGlzIHNlZW1zIGR1cGxpY2F0ZWQgd2l0aCAKPnRo
ZSBmb2xsb3dpbmcgdnEtPmNiLgo+Cj5JIHRoaW5rIHRoZSBjb3JyZWN0IHdheSBpcyB0byBpbml0
aWFsaXplIHZyaC0+bm90aWZ5IGFuZCB1c2UgCj52cmluZ2hfbmVlZF9ub3RpZnlfaW90bGIoKS92
cmluZ2hfbm90aWZ5KCkgaW5zdGVhZCBvZiB0aGUgdnEtPmNiIGhlcmUuCgpPa2F5LCBzbyBJJ2xs
IHNldCB2cmgtPm5vdGlmeSBpbiB0aGUgdmRwYXNpbSBjb3JlIHdpdGggYSBmdW5jdGlvbiB0aGF0
IApjYWxscyB2cS0+Y2IoKSAodGhlIGNhbGxiYWNrIHNldCB0aHJvdWdoIC5zZXRfdnFfY2IpLgoK
Pgo+QW5kIHdoaWxlIGF0IGl0LCBpdCdzIGJldHRlciB0byBjb252ZXJ0IG5ldCBzaW11bGF0b3Ig
dG8gZG8gdGhlIHNhbWUuCgpTdXJlLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
