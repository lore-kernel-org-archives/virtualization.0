Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D9CC433E1
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:37:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81004206E9
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByifV7Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81004206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38D5488256;
	Mon, 10 Aug 2020 13:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em2NaJl-I93t; Mon, 10 Aug 2020 13:37:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC2B38823A;
	Mon, 10 Aug 2020 13:37:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91EABC0864;
	Mon, 10 Aug 2020 13:37:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2277C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ABEC488253
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1g8r9b-0S0ze
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06D128823A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597066627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/qxK5C6ePLAWVdlOOgywCTwX3DZjSUnV1UIiKmwyDg=;
 b=ByifV7GicXk5g52Pd+PddF/ZmZK90SKpSc/SKRlwYM/GN8KH32yHm/6q2oqeWaLLDBSCvl
 SUiU2qsPS8uc7juaP78BHWvoJvgx7ZkRQGSvE+NBUpgSJvHtHdZq3Qo5gZyuKRN5KOgd9+
 300ONfMR68viGohDoqV31stCwn6QHSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-pmauXpVFOca4Lekzv7kGfA-1; Mon, 10 Aug 2020 09:37:05 -0400
X-MC-Unique: pmauXpVFOca4Lekzv7kGfA-1
Received: by mail-wm1-f71.google.com with SMTP id z1so2868217wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b/qxK5C6ePLAWVdlOOgywCTwX3DZjSUnV1UIiKmwyDg=;
 b=Rd7YkKgVBO/eaEJFUd8vBN1xgUUOou6SiZ+aXeVUXLA46oe3FVmDki1wwI5c19yUeu
 LTk1BMTj1E92gggknsZFpSl/p+OzGuzZZQsKZMV8B9kIp5Tq45DEAnJIQ7+qwcRjb7gx
 jOTpxm22blol/WR1WvIxqUhAkWxnOnTOPmCOIVdnpb64Ww2t9fRlL3e+X0uXngOARJ1S
 xPFb3UBeiAUashyy6qCQ58eB3Ij/EYinJMXyZf2Szfeap3GTODIbIbiGykoi/kVWAZps
 FgiMtt/xubYFsylGJl6RzxCr2Ohci+GGhsDAPzv7Yfbe9r7e3mkvUeGYYYNMy3cSksLW
 mTyQ==
X-Gm-Message-State: AOAM530LhKF4+OHiK+khYWGDAHsLHYq/BIrG2ZEs6+0nxQIeBKGDCE2J
 YlTWvMdmD+fzNEIbOAWI7LrVyJkwN6BlF/qzgH+eil6lFjXeonqwNjvWGscMQUFYuU2rNLF1WWi
 yjqXq1tGSwQoF1G1ZQT/MNueNrPLgG//kbEAqQRuRYg==
X-Received: by 2002:a1c:5f44:: with SMTP id t65mr23851983wmb.99.1597066624611; 
 Mon, 10 Aug 2020 06:37:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyntbXKihSaGm5opEK+za7CdlaF4OJ93oO4OKkytJl8FaoN1WxNcKI6KM/HsYZNiaqGUVp/wQ==
X-Received: by 2002:a1c:5f44:: with SMTP id t65mr23851960wmb.99.1597066624455; 
 Mon, 10 Aug 2020 06:37:04 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
 by smtp.gmail.com with ESMTPSA id
 f12sm21591802wmc.46.2020.08.10.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 06:37:03 -0700 (PDT)
Date: Mon, 10 Aug 2020 09:37:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
Message-ID: <20200810093630-mutt-send-email-mst@kernel.org>
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
 <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
 <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
 <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
 <20200804052050-mutt-send-email-mst@kernel.org>
 <14fd2bf1-e9c1-a192-bd6c-f1ee5fd227f6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <14fd2bf1-e9c1-a192-bd6c-f1ee5fd227f6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, wanpengli@tencent.com, parav@mellanox.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, sean.j.christopherson@intel.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 pbonzini@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
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

T24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMTA6MTY6MTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNCDkuIvljYg1OjIxLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiA+ID4gPiA+ICDCoCArc3RydWN0IHZob3N0X3ZyaW5nX2NhbGwgewo+ID4gPiA+ID4gPiAr
wqDCoMKgIHN0cnVjdCBldmVudGZkX2N0eCAqY3R4Owo+ID4gPiA+ID4gPiArwqDCoMKgIHN0cnVj
dCBpcnFfYnlwYXNzX3Byb2R1Y2VyIHByb2R1Y2VyOwo+ID4gPiA+ID4gPiArwqDCoMKgIHNwaW5s
b2NrX3QgY3R4X2xvY2s7Cj4gPiA+ID4gPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aHkgd2UgbmVl
ZCBjdHhfbG9jayBoZXJlLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiBIaSBK
YXNvbiwKPiA+ID4gPiAKPiA+ID4gPiB3ZSB1c2UgdGhpcyBsb2NrIHRvIHByb3RlY3QgdGhlIGV2
ZW50ZmRfY3R4IGFuZCBpcnEgZnJvbSByYWNlIGNvbmRpdGlvbnMsCj4gPiA+IFdlIGRvbid0IHN1
cHBvcnQgaXJxIG5vdGlmaWNhdGlvbiBmcm9tIHZEUEEgZGV2aWNlIGRyaXZlciBpbiB0aGlzIHZl
cnNpb24sCj4gPiA+IGRvIHdlIHN0aWxsIGhhdmUgcmFjZSBjb25kaXRpb24/Cj4gPiA+IAo+ID4g
PiBUaGFua3MKPiA+IEphc29uIEknbSBub3Qgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNh
eSBoZXJlLgo+IAo+IAo+IEkgbWVhbnQgd2UgY2hhbmdlIHRoZSBBUEkgZnJvbSBWNCBzbyBkcml2
ZXIgd29uJ3Qgbm90aWZ5IHVzIGlmIGlycSBpcwo+IGNoYW5nZWQuCj4gCj4gVGhlbiBpdCBsb29r
cyB0byBtZSB0aGVyZSdzIG5vIG5lZWQgZm9yIHRoZSBjdHhfbG9jaywgZXZlcnloaW5nIGNvdWxk
IGJlCj4gc3luY2hyb25pemVkIHdpdGggdnEgbXV0ZXguCj4gCj4gVGhhbmtzCgpKYXNvbiBkbyB5
b3Ugd2FudCB0byBwb3N0IGEgY2xlYW51cCBwYXRjaCBzaW1wbGlmeWluZyBjb2RlIGFsb25nIHRo
ZXNlCmxpbmVzPwoKVGhhbmtzLAoKCj4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
