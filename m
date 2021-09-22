Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B90C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 13:59:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2865B611C9
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2865B611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A2AE40581;
	Wed, 22 Sep 2021 13:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WpBxAlV03wW; Wed, 22 Sep 2021 13:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F36140480;
	Wed, 22 Sep 2021 13:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB0FC000F;
	Wed, 22 Sep 2021 13:59:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD9CBC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90D0C4056A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDxXvAEQ7-tm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 992A140480
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:59:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB94611C9;
 Wed, 22 Sep 2021 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632319179;
 bh=36IWk6It8GnKx4IJa/NIBW4AEPYji1iLwvfilDyjCXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pekUNLVhn+YYL/CO9fT43ZTrfotwbsqxmeiiHiPuOBIeanmiMbOApgFDPqoNg+gAi
 FNfFzj4CVqKEkpWuEoityr4Fee26sPBLpdCW39J/fCQEof/s14b+FPdM/QbKO0vPyo
 mdSeGCVBCTeMvzIkPSLrKd0d4dAJTVt0TG1x2DifZ3HpedfaMgO3YSeDZYjyc41pqE
 +ynfgXqeKMTFJyJPIXU3ubLtBvCUSwAbLWtUjZWVRAmReoXHHKPsgq2use649Fq3Mu
 YcRyiBs2S/5gpSCSaQtZHwJwQ93fUbCD5ariOReFV469g6gw2K8SBJBO5JFRJDR8wU
 XbbWiNMzFfhpQ==
Date: Wed, 22 Sep 2021 16:59:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: =?utf-8?B?6a2P5L+K5ZCJ?= <weijunji@bytedance.com>
Subject: Re: Re: [RFC 0/5] VirtIO RDMA
Message-ID: <YUs2x9tUEgdC5lpr@unreal>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com>
 <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
 <YUsqQY5zY00bj4ul@unreal>
 <CAGH6tLV=9ceaUH_zdevtTyL5ft4ZxxX8d0axops4DmbFdFYFjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH6tLV=9ceaUH_zdevtTyL5ft4ZxxX8d0axops4DmbFdFYFjQ@mail.gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Gunthorpe <jgg@nvidia.com>,
 mst <mst@redhat.com>, RDMA mailing list <linux-rdma@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, yuval.shaia.ml@gmail.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Doug Ledford <dledford@redhat.com>,
 =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>
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

T24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDk6Mzc6MzdQTSArMDgwMCwg6a2P5L+K5ZCJIHdyb3Rl
Ogo+IE9uIFdlZCwgU2VwIDIyLCAyMDIxIGF0IDk6MDYgUE0gTGVvbiBSb21hbm92c2t5IDxsZW9u
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgU2VwIDIyLCAyMDIxIGF0IDA4OjA4
OjQ0UE0gKzA4MDAsIEp1bmppIFdlaSB3cm90ZToKPiA+ID4gPiBPbiBTZXAgMTUsIDIwMjEsIGF0
IDk6NDMgUE0sIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOgo+ID4KPiA+
IDwuLi4+Cj4gPgo+ID4gPiA+PiA0LiBUaGUgRlJNUiBhcGkgbmVlZCB0byBzZXQga2V5IG9mIE1S
IHRocm91Z2ggSUJfV1JfUkVHX01SLgo+ID4gPiA+PiAgIEJ1dCBpdCBpcyBpbXBvc3NpYmxlIHRv
IGNoYW5nZSBhIGtleSBvZiBtciB1c2luZyB1dmVyYnMuCj4gPiA+ID4KPiA+ID4gPiBGUk1SIGlz
IG1vcmUgbGlrZSBtZW1vcnkgd2luZG93cyBpbiB1c2VyIHNwYWNlLCB5b3UgY2FuJ3Qgc3VwcG9y
dCBpdAo+ID4gPiA+IHVzaW5nIGp1c3QgcmVndWxhciBNUnMuCj4gPiA+Cj4gPiA+IEl0IGlzIGhh
cmQgdG8gc3VwcG9ydCB0aGlzIHVzaW5nIHV2ZXJicywgYnV0IGl0IGlzIGVhc3kgdG8gc3VwcG9y
dAo+ID4gPiB3aXRoIHVSRE1BIHRoYXQgd2UgY2FuIGdldCBmdWxsIGNvbnRyb2wgb2YgbXJzLgo+
ID4KPiA+IFdoYXQgaXMgdVJETUE/Cj4gCj4gdVJETUEgaXMgYSBzb2Z0d2FyZSBpbXBsZW1lbnRh
dGlvbiBvZiB0aGUgUm9DRXYyIHByb3RvY29sIGxpa2UgcnhlLgo+IFdlIHdpbGwgaW1wbGVtZW50
IGl0IGluIFFFTVUgd2l0aCBWRklPIG9yIERQREsuCgpvaywgdGhhbmtzCgo+IAo+IFRoYW5rcy4K
PiBKdW5qaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
