Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3FC4742C
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 21:53:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BBD20838
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 21:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACeulROf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BBD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7B0987441;
	Thu, 29 Oct 2020 21:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U+fSQ8w0UnZd; Thu, 29 Oct 2020 21:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62485872C7;
	Thu, 29 Oct 2020 21:53:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52204C088B;
	Thu, 29 Oct 2020 21:53:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27E9DC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 15AE8872F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XO4MRO6qfajo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:53:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 30548872C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604008399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyA/z9GmL/SPGNqgdbe5v/AJExbTh9xMmKh6pW57qzk=;
 b=ACeulROf4XBYbLrtSbf8WZp1o9g3TZsgbYTxfbR8XRXQNtjNjA7P/LRvHu/w1LWVdqjgG3
 yNBtNyRr3lOhnIO7c3eCGduEpmKK6RPtC1NtPnlQafDLkvrRz7jk5svT7ypl2GXf5oahHq
 EweDLcGPNKUV/2ahsn74qomTd21tHVo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-9MJfQsGYP7270O2T2zkP_g-1; Thu, 29 Oct 2020 17:53:17 -0400
X-MC-Unique: 9MJfQsGYP7270O2T2zkP_g-1
Received: by mail-wr1-f71.google.com with SMTP id i6so1806403wrx.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 14:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MyA/z9GmL/SPGNqgdbe5v/AJExbTh9xMmKh6pW57qzk=;
 b=kve/19rnDwQxv3mUzZKoOaWbnh0gfrjkWpTIN3nKDiKCQ7K9E49uarlu1vf71kCwz4
 W6MhkCxSNovNq5ysEjjD5GyPfnFscYxnPqSdjyuWpV+TM9dE+xzWqIgLrvbA6zMJC8Ss
 UxQMVFa+KpaBEu9qkFnJ8H8XCBysC72xOk5E/hBgWqoBvfgl9GLSefEzxh1JIiYE/RFc
 zO8P9VXdPqTE+xgMRiZXDzRWQ2YvyqIR3m3smJQNl5WUTscbSjpMc85TS7gtf4speiBt
 QF75yF6U7FNMclzdqlDnbZmCzkSAPqVcAgtuEaAPwZ6rx7EnBdEgTwcnXDWPOCaLMDyL
 bLJQ==
X-Gm-Message-State: AOAM531j88R7vPMQe22n+CpjXeBgRZVqUbnlZxdaYxKXlPV1cgWCGmw+
 /ggfC3Qis0OqWInM+nHrg+fASJacnrhUj0+qVhTjaVRdsSl4SadQ2U6bWe3ytOXGxNhkkJtth+T
 Qa13UWrfr3Z0PCwXlfvJ22OlLlnfC64a3VDait76cYw==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr1392925wma.100.1604008395966; 
 Thu, 29 Oct 2020 14:53:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOb9jejDagKN2otqeV1zFSG0/6+d0FSNPfIRhJooGnxcFENInAFKxKGTfRGns8rrnMa1b1mA==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr1392912wma.100.1604008395829; 
 Thu, 29 Oct 2020 14:53:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v67sm2022382wma.17.2020.10.29.14.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 14:53:14 -0700 (PDT)
Date: Thu, 29 Oct 2020 17:53:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: si-wei liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
Message-ID: <20201029175305-mutt-send-email-mst@kernel.org>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
 <5F863B83.6030204@oracle.com>
 <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
 <20201015091150-mutt-send-email-mst@kernel.org>
 <5F88AE4A.9030300@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5F88AE4A.9030300@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lingshan.zhu@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 boris.ostrovsky@oracle.com
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

T24gVGh1LCBPY3QgMTUsIDIwMjAgYXQgMDE6MTc6MTRQTSAtMDcwMCwgc2ktd2VpIGxpdSB3cm90
ZToKPiAKPiBPbiAxMC8xNS8yMDIwIDY6MTEgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
PiA+IE9uIFRodSwgT2N0IDE1LCAyMDIwIGF0IDAyOjE1OjMyUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+IE9uIDIwMjAvMTAvMTQg5LiK5Y2INzo0Miwgc2ktd2VpIGxpdSB3cm90ZToK
PiA+ID4gPiA+IAo+ID4gPiA+ID4gU28gd2hhdCBJIHN1Z2dlc3QgaXMgdG8gZml4IHRoZSBwaW5u
aW5nIGxlYWthZ2UgZmlyc3QgYW5kIGRvIHRoZQo+ID4gPiA+ID4gcG9zc2libGUgb3B0aW1pemF0
aW9uIG9uIHRvcCAod2hpY2ggaXMgc3RpbGwgcXVlc3Rpb25hYmxlIHRvIG1lKS4KPiA+ID4gPiBP
Sy4gVW5mb3J0dW5hdGVseSwgdGhpcyB3YXMgcGlja2VkIGFuZCBnb3QgbWVyZ2VkIGluIHVwc3Ry
ZWFtLiBTbyBJIHdpbGwKPiA+ID4gPiBwb3N0IGEgZm9sbG93IHVwIHBhdGNoIHNldCB0byAxKSBy
ZXZlcnQgdGhlIGNvbW1pdCB0byB0aGUgb3JpZ2luYWwKPiA+ID4gPiBfX2dldF9mcmVlX3BhZ2Uo
KSBpbXBsZW1lbnRhdGlvbiwgYW5kIDIpIGZpeCB0aGUgYWNjb3VudGluZyBhbmQgbGVha2FnZQo+
ID4gPiA+IG9uIHRvcC4gV2lsbCBpdCBiZSBmaW5lPwo+ID4gPiAKPiA+ID4gRmluZS4KPiA+ID4g
Cj4gPiA+IFRoYW5rcwo+ID4gRmluZSBieSBtZSB0b28uCj4gPiAKPiBUaGFua3MsIE1pY2hhZWwg
JiBKYXNvbi4gSSB3aWxsIHBvc3QgdGhlIGZpeCBzaG9ydGx5LiBTdGF5IHR1bmVkLgo+IAo+IC1T
aXdlaQoKZGlkIEkgbWlzcyB0aGUgcGF0Y2g/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
