Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45266C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:23:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8CE611F1
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8CE611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A22684667;
	Thu, 15 Apr 2021 07:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QweqYm_UMuXj; Thu, 15 Apr 2021 07:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9130B845EA;
	Thu, 15 Apr 2021 07:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DFB4C000B;
	Thu, 15 Apr 2021 07:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD97C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F37F400C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poVCLTcrGRid
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D89040FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:47 +0000 (UTC)
IronPort-SDR: NbzMaYiWT6jC+KN0E6P3i9IBDXS0H0zS5EzWsma/dqptM0duCuTkRY53Q4qOJxgxNoPsDFkI6F
 EbYKtW3UnFJA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174909032"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="174909032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 00:23:46 -0700
IronPort-SDR: kfxF4FwPksoR+4MIAykhuN88Y7X4M9VqYkWzYl6gUP6laeWOL0/X6Ub9CNTU7b3oTZawHAtKwE
 nwx4MZjzznzA==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418647970"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 00:23:40 -0700
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
 <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
 <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
 <c90a923f-7c8d-9a32-ce14-2370f85f1ba4@redhat.com>
 <10700088-3358-739b-5770-612ab761598c@linux.intel.com>
 <d6b27f59-ff17-1d63-0065-fd03ee36cd2d@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <af2bb5e6-e690-1aa6-4be3-75a18750aeb4@linux.intel.com>
Date: Thu, 15 Apr 2021 15:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d6b27f59-ff17-1d63-0065-fd03ee36cd2d@redhat.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiA0LzE1LzIwMjEgMzoxNyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIxLzQv
MTUg5LiL5Y2IMjo0MSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Pj4KPj4+Pj4gSSB0aGluayB3
ZSd2ZSBkaXNjdXNzZWQgdGhpcyBzb21ldGltZSBpbiB0aGUgcGFzdCBidXQgd2hhdCdzIHRoZSAK
Pj4+Pj4gcmVhc29uIGZvciBzdWNoIHdoaXRlbGlzdCBjb25zaWRlciB0aGVyZSdzIGFscmVhZHkg
YSAKPj4+Pj4gZ2V0X2ZlYXR1cmVzKCkgaW1wbGVtZW50aW9uPwo+Pj4+Pgo+Pj4+PiBFLmcgQW55
IHJlYXNvbiB0byBibG9jayBWSVJUSU9fQkxLX0ZfV1JJVEVfWkVST1Mgb3IgCj4+Pj4+IFZJUlRJ
T19GX1JJTkdfUEFDS0VEPwo+Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+PiBUaGUgcmVhc29uIGlzIHNv
bWUgZmVhdHVyZSBiaXRzIGFyZSBzdXBwb3J0ZWQgaW4gdGhlIGRldmljZSBidXQgbm90IAo+Pj4+
IHN1cHBvcnRlZCBieSB0aGUgZHJpdmVyLCBlLmcsIGZvciB2aXJ0aW8tbmV0LCBtcSAmIGNxIAo+
Pj4+IGltcGxlbWVudGF0aW9uIGlzIG5vdCByZWFkeSBpbiB0aGUgZHJpdmVyLgo+Pj4KPj4+Cj4+
PiBJIHVuZGVyc3RhbmQgdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCBidXQgSSB3b25kZXIgd2h5IHdl
IG5lZWQgdGhpcyAKPj4+IGZvciBibG9jayB3aGVyZSB3ZSBkb24ndCB2cSBjdnEuCj4+Pgo+Pj4g
VGhhbmtzCj4+IFRoaXMgaXMgc3RpbGwgYSBzdWJzZXQgb2YgdGhlIGZlYXR1cmUgYml0cyByZWFk
IGZyb20gaGFyZHdhcmUsIEkgCj4+IGxlYXZlIGl0IGhlcmUgdG8gY29kZSBjb25zaXN0ZW50bHks
IGFuZCBpbmRpY2F0ZSB3aGF0IHdlIHN1cHBvcnQgCj4+IGNsZWFybHkuCj4+IEFyZSB5b3Ugc3Vn
Z2VzdGluZyByZW1vdmUgdGhpcyBmZWF0dXJlIGJpdHMgbGlzdCBhbmQganVzdCB1c2Ugd2hhdCB3
ZSAKPj4gcmVhZCBmcm9tIGhhcmR3YXJlPwo+Pgo+PiBUaGFuc2sgCj4KPgo+IFllcywgcGxlYXNl
IGRvIHRoYXQuCj4KPiBUaGUgd2hpbHRlbGlzdCBkb2Vzbid0IGhlbHAgaW4gdGhpcyBjYXNlIEkg
dGhpbmsuCk9LLCB3aWxsIHJlbW92ZSB0aGlzIGluIFYyCgpUaGFua3MKPgo+IFRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
