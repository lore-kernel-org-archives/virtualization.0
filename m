Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E3C43334
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 18:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4019B41556;
	Fri, 24 Jun 2022 18:32:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4019B41556
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuUJmW_Un-xH; Fri, 24 Jun 2022 18:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1208641561;
	Fri, 24 Jun 2022 18:32:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1208641561
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 672BDC0080;
	Fri, 24 Jun 2022 18:32:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE28C002D;
 Fri, 24 Jun 2022 18:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F71F84956;
 Fri, 24 Jun 2022 18:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F71F84956
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ieq6n2JTHTNZ; Fri, 24 Jun 2022 18:32:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CD2A84950
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CD2A84950;
 Fri, 24 Jun 2022 18:32:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9BE31042;
 Fri, 24 Jun 2022 11:31:59 -0700 (PDT)
Received: from [10.57.84.111] (unknown [10.57.84.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862573F792;
 Fri, 24 Jun 2022 11:31:53 -0700 (PDT)
Message-ID: <c9dee5e3-4525-b9bf-3775-30995d59af9e@arm.com>
Date: Fri, 24 Jun 2022 19:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/5] vfio/iommu_type1: Remove the domain->ops comparison
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-4-nicolinc@nvidia.com>
 <BL1PR11MB52717050DBDE29A81637BBFA8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YqutYjgtFOTXCF0+@Asurada-Nvidia>
 <6e1280c5-4b22-ebb3-3912-6c72bc169982@arm.com>
 <20220624131611.GM4147@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220624131611.GM4147@nvidia.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "sven@svenpeter.dev" <sven@svenpeter.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "john.garry@huawei.com" <john.garry@huawei.com>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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

T24gMjAyMi0wNi0yNCAxNDoxNiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IE9uIFdlZCwgSnVu
IDIyLCAyMDIyIGF0IDA4OjU0OjQ1QU0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24g
MjAyMi0wNi0xNiAyMzoyMywgTmljb2xpbiBDaGVuIHdyb3RlOgo+Pj4gT24gVGh1LCBKdW4gMTYs
IDIwMjIgYXQgMDY6NDA6MTRBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+Pgo+Pj4+PiBU
aGUgZG9tYWluLT5vcHMgdmFsaWRhdGlvbiB3YXMgYWRkZWQsIGFzIGEgcHJlY2F1dGlvbiwgZm9y
IG1peGVkLWRyaXZlcgo+Pj4+PiBzeXN0ZW1zLiBIb3dldmVyLCBhdCB0aGlzIG1vbWVudCBvbmx5
IG9uZSBpb21tdSBkcml2ZXIgaXMgcG9zc2libGUuIFNvCj4+Pj4+IHJlbW92ZSBpdC4KPj4+Pgo+
Pj4+IEl0J3MgdHJ1ZSBvbiBhIHBoeXNpY2FsIHBsYXRmb3JtLiBCdXQgSSdtIG5vdCBzdXJlIHdo
ZXRoZXIgYSB2aXJ0dWFsIHBsYXRmb3JtCj4+Pj4gaXMgYWxsb3dlZCB0byBpbmNsdWRlIG11bHRp
cGxlIGUuZy4gb25lIHZpcnRpby1pb21tdSBhbG9uZ3NpZGUgYSB2aXJ0dWFsIFZULWQKPj4+PiBv
ciBhIHZpcnR1YWwgc21tdS4gSXQgbWlnaHQgYmUgY2xlYXJlciB0byBjbGFpbSB0aGF0IChhcyBS
b2JpbiBwb2ludGVkIG91dCkKPj4+PiB0aGVyZSBpcyBwbGVudHkgbW9yZSBzaWduaWZpY2FudCBw
cm9ibGVtcyB0aGFuIHRoaXMgdG8gc29sdmUgaW5zdGVhZCBvZiBzaW1wbHkKPj4+PiBzYXlpbmcg
dGhhdCBvbmx5IG9uZSBpb21tdSBkcml2ZXIgaXMgcG9zc2libGUgaWYgd2UgZG9uJ3QgaGF2ZSBl
eHBsaWNpdCBjb2RlCj4+Pj4gdG8gcmVqZWN0IHN1Y2ggY29uZmlndXJhdGlvbi4g8J+Yigo+Pj4K
Pj4+IFdpbGwgZWRpdCB0aGlzIHBhcnQuIFRoYW5rcyEKPj4KPj4gT2gsIHBoeXNpY2FsIHBsYXRm
b3JtcyB3aXRoIG1peGVkIElPTU1VcyBkZWZpbml0ZWx5IGV4aXN0IGFscmVhZHkuIFRoZSBtYWlu
Cj4+IHBvaW50IGlzIHRoYXQgd2hpbGUgYnVzX3NldF9pb21tdSBzdGlsbCBleGlzdHMsIHRoZSBj
b3JlIGNvZGUgZWZmZWN0aXZlbHkKPj4gKmRvZXMqIHByZXZlbnQgbXVsdGlwbGUgZHJpdmVycyBm
cm9tIHJlZ2lzdGVyaW5nIC0gZXZlbiBpbiBlbXVsYXRlZCBjYXNlcwo+PiBsaWtlIHRoZSBleGFt
cGxlIGFib3ZlLCB2aXJ0aW8taW9tbXUgYW5kIFZULWQgd291bGQgYm90aCB0cnkgdG8KPj4gYnVz
X3NldF9pb21tdSgmcGNpX2J1c190eXBlKSwgYW5kIG9uZSBvZiB0aGVtIHdpbGwgbG9zZS4gVGhl
IGFzcGVjdCB3aGljaAo+PiBtaWdodCB3YXJyYW50IGNsYXJpZmljYXRpb24gaXMgdGhhdCB0aGVy
ZSdzIG5vIGNvbWJpbmF0aW9uIG9mIHN1cHBvcnRlZAo+PiBkcml2ZXJzIHdoaWNoIGNsYWltIG5v
bi1vdmVybGFwcGluZyBidXNlcyAqYW5kKiBjb3VsZCBhcHBlYXIgaW4gdGhlIHNhbWUKPj4gc3lz
dGVtIC0gZXZlbiBpZiB5b3UgdHJpZWQgdG8gY29udHJpdmUgc29tZXRoaW5nIGJ5IGVtdWxhdGlu
Zywgc2F5LCBWVC1kCj4+IChQQ0kpIGFsb25nc2lkZSByb2NrY2hpcC1pb21tdSAocGxhdGZvcm0p
LCB5b3UgY291bGQgc3RpbGwgb25seSBkZXNjcmliZSBvbmUKPj4gb3IgdGhlIG90aGVyIGR1ZSB0
byBBQ1BJIHZzLiBEZXZpY2V0cmVlLgo+IAo+IFJpZ2h0LCBhbmQgdGhhdCBpcyBzdGlsbCBzb21l
dGhpbmcgd2UgbmVlZCB0byBwcm90ZWN0IGFnYWluc3Qgd2l0aAo+IHRoaXMgb3BzIGNoZWNrLiBW
RklPIGlzIG5vdCBjaGVja2luZyB0aGF0IHRoZSBidXMncyBhcmUgdGhlIHNhbWUKPiBiZWZvcmUg
YXR0ZW1wdGluZyB0byByZS11c2UgYSBkb21haW4uCj4gCj4gU28gaXQgaXMgYWN0dWFsbHkgZnVu
Y3Rpb25hbCBhbmQgZG9lcyBwcm90ZWN0IGFnYWluc3Qgc3lzdGVtcyB3aXRoCj4gbXVsdGlwbGUg
aW9tbXUgZHJpdmVycyBvbiBkaWZmZXJlbnQgYnVzc2VzLgoKQnV0IGFzIGFib3ZlLCB3aGljaCBz
eXN0ZW1zICphcmUqIHRob3NlPyBFdmVyeXRoaW5nIHRoYXQncyBvbiBteSByYWRhciAKd291bGQg
aGF2ZSBkcml2ZXJzIGFsbCBjb21wZXRpbmcgZm9yIHRoZSBwbGF0Zm9ybSBidXMgLSBJbnRlbCBh
bmQgczM5MCAKYXJlIHNvbWV3aGF0IHRoZSBvZGQgb25lcyBvdXQgaW4gdGhhdCByZXNwZWN0LCBi
dXQgYXJlIGFsc28gbm9uLWlzc3VlcyAKYXMgYWJvdmUuIEZXSVcgbXkgaW9tbXUvYnVzIGRldiBi
cmFuY2ggaGFzIGdvdCBhcyBmYXIgYXMgdGhlIGZpbmFsIGJ1cyAKb3BzIHJlbW92YWwgYW5kIGFs
bG93aW5nIG11bHRpcGxlIGRyaXZlciByZWdpc3RyYXRpb25zLCBhbmQgYmVmb3JlIGl0IAphbGxv
d3MgdGhhdCwgaXQgZG9lcyBub3cgaGF2ZSB0aGUgY29tbW9uIGF0dGFjaCBjaGVjayB0aGF0IEkg
c2tldGNoZWQgCm91dCBpbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBvZiB0aGlzLgoKSXQncyBw
cm9iYWJseSBhbHNvIG5vdGV3b3J0aHkgdGhhdCBkb21haW4tPm9wcyBpcyBubyBsb25nZXIgdGhl
IHNhbWUgCmRvbWFpbi0+b3BzIHRoYXQgdGhpcyBjb2RlIHdhcyB3cml0dGVuIHRvIGNoZWNrLCBh
bmQgbWF5IG5vdyBiZSAKZGlmZmVyZW50IGJldHdlZW4gZG9tYWlucyBmcm9tIHRoZSBzYW1lIGRy
aXZlci4KClRoYW5rcywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
