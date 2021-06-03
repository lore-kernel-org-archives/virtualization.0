Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A256C47097
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 23:33:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE24613FA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 23:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE24613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6454740678;
	Thu,  3 Jun 2021 23:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6lrYN7HIJe0; Thu,  3 Jun 2021 23:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C5C84063F;
	Thu,  3 Jun 2021 23:33:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B277FC0022;
	Thu,  3 Jun 2021 23:33:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9A2C0001;
 Thu,  3 Jun 2021 23:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6663B608E8;
 Thu,  3 Jun 2021 23:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCswRev3Mzsf; Thu,  3 Jun 2021 23:33:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E26E608E1;
 Thu,  3 Jun 2021 23:33:04 +0000 (UTC)
IronPort-SDR: 8LU5fo2lB40PXFvVhxmcQNLg2iJVMgdJI78O165E3XukC9Lf+8mnn828yDScRVKjt507zaIF5S
 al2VdVKzuhYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202320922"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="202320922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 16:33:00 -0700
IronPort-SDR: qAh/G4h1oAVmxnpXqZzvzXCuEocjpQVTLKofsVYdH1zoxAHAjOZW/w7M8EFkVDo5EB13y1/Kmd
 5P5MI2NAPGSw==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="550880326"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237])
 ([10.209.7.237])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 16:32:59 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andy Lutomirski <luto@kernel.org>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
Date: Thu, 3 Jun 2021 16:32:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Josh Poimboeuf <jpoimboe@redhat.com>, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

Cj4gV2UgZG8gbm90IG5lZWQgYW4gaW5jcmVhc2luZyBwaWxlIG9mIGtsdWRnZXMKCkRvIHlvdSBt
ZWFuIGRpc2FibGluZyBmZWF0dXJlcyBpcyBhIGtsdWRnZT8KCklmIHllcyBJIGRpc2FncmVlIHdp
dGggdGhhdCBjaGFyYWN0ZXJpemF0aW9uLgoKCj4gdG8gbWFrZSBURFggYW5kIFNFViDigJxzZWN1
cmXigJ0uICBXZSBuZWVkIHRoZSBhY3R1YWwgbG9hZGVkIGRyaXZlciB0byBiZSBzZWN1cmUuICBU
aGUgdmlydGlvIGFyY2hpdGVjdHVyZSBpcyBmdWxsIG9mIGxlZ2FjeSBub25zZW5zZSwKPiBhbmQg
dGhlcmUgaXMgbm8gZ29vZCByZWFzb24gZm9yIFNFViBhbmQgVERYIHRvIGJlIGEgZ2lhbnQgc3Bl
Y2lhbCBjYXNlLgoKSSBkb24ndCBrbm93IHdoZXJlIHlvdSBzZWUgYSAiZ2lhbnQgc3BlY2lhbCBj
YXNlIi4gRXhjZXB0IGZvciB0aGUgCmxpbWl0ZWQgZmVhdHVyZSBuZWdvdGlhdGlvbiBhbGwgdGhl
IGNoYW5nZXMgYXJlIGNvbW1vbiwgYW5kIHRoZSAKZGlzYWJsaW5nIG9mIGZlYXR1cmVzICh3aGlj
aCBpcyBub3QgbmV3IEJUVywgYnV0IGFscmVhZHkgZG9uZSBlLmcuIHdpdGggCmZvcmNpbmcgRE1B
IEFQSSBpbiBzb21lIGNhc2VzKSBjYW4gYmUgb2YgY291cnNlIHVzZWQgYnkgYWxsIHRoZXNlIG90
aGVyIAp0ZWNobm9sb2dpZXMgdG9vLiBCdXQgaXQganVzdCBjYW5ub3QgYmUgZG9uZSBieSBkZWZh
dWx0IGZvciBldmVyeXRoaW5nIApiZWNhdXNlIGl0IHdvdWxkIGJyZWFrIGNvbXBhdGliaWxpdHku
IFNvIGV2ZXJ5IHRlY2hub2xvZ3kgd2l0aCBzdWNoIApyZXF1aXJlbWVudHMgaGFzIHRvIGV4cGxp
Y2l0bHkgb3B0LWluLgoKCj4KPiBBcyBJIHNhaWQgYmVmb3JlLCByZWFsIFBDSWUgKFRodW5kZXJi
b2x0L1VTQi1DIG9yIGFueXRoaW5nIGVsc2UpIGhhcyB0aGUgZXhhY3Qgc2FtZSBwcm9ibGVtLiAg
VGhlIGZhY3QgdGhhdCBURFggaGFzIGVuY3J5cHRlZCBtZW1vcnkgaXMsIGF0IGJlc3QsIGEgcG9v
ciBwcm94eSBmb3IgdGhlIGFjdHVhbCBjb25kaXRpb24uICBUaGUgYWN0dWFsIGNvbmRpdGlvbiBp
cyB0aGF0IHRoZSBob3N0IGRvZXMgbm90IHRydXN0IHRoZSBkZXZpY2UgdG8gaW1wbGVtZW50IHRo
ZSB2aXJ0aW8gcHJvdG9jb2wgY29ycmVjdGx5LgoKUmlnaHQgdGhleSBjYW4gZG8gc2ltaWxhciBs
aW1pdGF0aW9ucyBvZiBmZWF0dXJlIHNldHMuIEJ1dCBhZ2FpbiBpdCAKY2Fubm90IGJlIGRlZmF1
bHQuCgoKPgo+Pgo+PiBURFggYW5kIFNFViB1c2UgdGhlIGFyY2ggaG9vayB0byBlbmZvcmNlIERN
QSBBUEksIHNvIHRoYXQgcGFydCBpcyBhbHNvCj4+IHNvbHZlZC4KPj4KPiBDYW4geW91IHBvaW50
IG1lIHRvIHRoZSBjb2RlIHlvdeKAmXJlIHJlZmVycmluZyB0bz8KClNlZSA0LzggaW4gdGhpcyBw
YXRjaCBraXQuIEl0IHVzZXMgYW4gZXhpc3RpbmcgaG9vayB3aGljaCBpcyBhbHJlYWR5IAp1c2Vk
IGluIHRyZWUgYnkgczM5MC4KCgotQW5kaQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
