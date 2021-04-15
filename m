Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582EC43461
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 05:52:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9DF61418
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 05:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9DF61418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 811EB8469A;
	Thu, 15 Apr 2021 05:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sT7-bhfJmFpK; Thu, 15 Apr 2021 05:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1889384327;
	Thu, 15 Apr 2021 05:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0290C000C;
	Thu, 15 Apr 2021 05:52:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19FABC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E75166075D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vS2bPm5sBpat
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:52:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDE1B60680
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:52:32 +0000 (UTC)
IronPort-SDR: FOrbdcTQtV5XZIPI2tEO7FvuW5ktsVpZU8n/iHj0rRE/IKI6YhMghkbW11yW+PIY2KHtSSfgiZ
 FS6K60peQzsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="182292637"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="182292637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 22:52:31 -0700
IronPort-SDR: le0ePrD8dHFzeHU/i6bw3s4nn51etvnkSpndLPjm4rQvetke09KhH4n/uymUhDXJzUEwfISQ/r
 EzsDssBx+nBw==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418621890"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 22:52:28 -0700
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
 <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
Date: Thu, 15 Apr 2021 13:52:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
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

CgpPbiA0LzE1LzIwMjEgMTE6MzAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiDlnKggMjAyMS80
LzE0IOS4i+WNiDU6MTgsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+IFRoaXMgY29tbWl0IGRlZHVj
ZXMgVklSVElPIGRldmljZSBJRCBhcyBkZXZpY2UgdHlwZSB3aGVuIHByb2JlLAo+PiB0aGVuIGlm
Y3ZmX3ZkcGFfZ2V0X2RldmljZV9pZCgpIGNhbiBzaW1wbHkgcmV0dXJuIHRoZSBJRC4KPj4gaWZj
dmZfdmRwYV9nZXRfZmVhdHVyZXMoKSBhbmQgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUoKQo+
PiBjYW4gd29yayBwcm9wZXJseSBiYXNlZCBvbiB0aGUgZGV2aWNlIElELgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+IC0tLQo+PiDC
oCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHzCoCAxICsKPj4gwqAgZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDIyICsrKysrKysrKystLS0tLS0tLS0tLS0KPj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggCj4+IGIvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+PiBpbmRleCBiMmVlYjE2YjljMmMuLjFjMDRjZDI1
NmZhNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+IEBAIC04NCw2ICs4NCw3IEBA
IHN0cnVjdCBpZmN2Zl9odyB7Cj4+IMKgwqDCoMKgwqAgdTMyIG5vdGlmeV9vZmZfbXVsdGlwbGll
cjsKPj4gwqDCoMKgwqDCoCB1NjQgcmVxX2ZlYXR1cmVzOwo+PiDCoMKgwqDCoMKgIHU2NCBod19m
ZWF0dXJlczsKPj4gK8KgwqDCoCB1MzIgZGV2X3R5cGU7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHZp
cnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjb21tb25fY2ZnOwo+PiDCoMKgwqDCoMKgIHZv
aWQgX19pb21lbSAqbmV0X2NmZzsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdnJpbmdfaW5mbyB2cmlu
Z1tJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAyXTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
Ywo+PiBpbmRleCA0NGQ3NTg2MDE5ZGEuLjk5YjBhNmI0YzIyNyAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4+IEBAIC0zMjMsMTkgKzMyMyw5IEBAIHN0YXRpYyB1MzIgaWZjdmZfdmRw
YV9nZXRfZ2VuZXJhdGlvbihzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4gwqAg
wqAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF9kZXZpY2VfaWQoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhX2RldikKPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFw
dGVyID0gdmRwYV90b19hZGFwdGVyKHZkcGFfZGV2KTsKPj4gLcKgwqDCoCBzdHJ1Y3QgcGNpX2Rl
diAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4+IC3CoMKgwqAgdTMyIHJldCA9IC1FTk9ERVY7Cj4+
IC0KPj4gLcKgwqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYtPmRldmljZSA+
IDB4MTA3ZikKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IC0KPj4gLcKgwqDCoCBp
ZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0ID3CoCBwZGV2
LT5zdWJzeXN0ZW1fZGV2aWNlOwo+PiAtwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgIHJl
dCA9wqAgcGRldi0+ZGV2aWNlIC0gMHgxMDQwOwo+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAq
dmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4gwqAgLcKgwqDCoCByZXR1cm4gcmV0Owo+PiAr
wqDCoMKgIHJldHVybiB2Zi0+ZGV2X3R5cGU7Cj4+IMKgIH0KPj4gwqAgwqAgc3RhdGljIHUzMiBp
ZmN2Zl92ZHBhX2dldF92ZW5kb3JfaWQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4g
QEAgLTQ2Niw2ICs0NTYsMTQgQEAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwgCj4+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPj4gwqDCoMKgwqDC
oCBwY2lfc2V0X2RydmRhdGEocGRldiwgYWRhcHRlcik7Cj4+IMKgIMKgwqDCoMKgwqAgdmYgPSAm
YWRhcHRlci0+dmY7Cj4+ICvCoMKgwqAgaWYgKHBkZXYtPmRldmljZSA8IDB4MTAwMCB8fCBwZGV2
LT5kZXZpY2UgPiAweDEwN2YpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7
Cj4+ICsKPj4gK8KgwqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+PiArwqDCoMKgwqDC
oMKgwqAgdmYtPmRldl90eXBlID3CoCBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+PiArwqDCoMKg
IGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgIHZmLT5kZXZfdHlwZSA9wqAgcGRldi0+ZGV2aWNlIC0g
MHgxMDQwOwo+Cj4KPiBTbyBhIHF1ZXN0aW9uIGhlcmUsIGlzIHRoZSBkZXZpY2UgYSB0cmFuc3Rp
b25hbCBkZXZpY2Ugb3IgbW9kZXJuIG9uZT8KPgo+IElmIGl0J3MgYSB0cmFuc2l0b25hbCBvbmUs
IGNhbiBpdCBzd3RpY2ggZW5kaWFuZXNzIGF1dG9tYXRpY2FsbHkgb3Igbm90Pwo+Cj4gVGhhbmtz
CkhpIEphc29uLAoKVGhpcyBkcml2ZXIgc2hvdWxkIGRyaXZlIGJvdGggbW9kZXJuIGFuZCB0cmFu
c2l0aW9uYWwgZGV2aWNlcyBhcyB3ZSAKZGlzY3Vzc2VkIGJlZm9yZS4KSWYgaXQncyBhIHRyYW5z
aXRpb25hbCBvbmUsIGl0IHdpbGwgYWN0IGFzIGEgbW9kZXJuIGRldmljZSBieSBkZWZhdWx0LCAK
bGVnYWN5IG1vZGUgaXMgYSBmYWlsLW92ZXIgcGF0aC4KRm9yIHZEUEEsIGl0IGhhcyB0byBzdXBw
b3J0IFZJUlRJT18xIGFuZCBBQ0NFU1NfUExBVEZPUk0sIHNvIGl0IG11c3QgaW4gCm1vZGVybiBt
b2RlLgpJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gd29ycnkgYWJvdXQgZW5kaWFuZXNzIGZvciBs
ZWdhY3kgbW9kZS4KClRoYW5rcwpaaHUgTGluZ3NoYW4KPgo+Cj4+ICsKPj4gwqDCoMKgwqDCoCB2
Zi0+YmFzZSA9IHBjaW1faW9tYXBfdGFibGUocGRldik7Cj4+IMKgIMKgwqDCoMKgwqAgYWRhcHRl
ci0+cGRldiA9IHBkZXY7Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
