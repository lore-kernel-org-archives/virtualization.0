Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 01:33:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26AC9230FA
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 01:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AC9230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BD12623067;
	Tue, 19 Jan 2021 01:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSAFBbXLBxtA; Tue, 19 Jan 2021 01:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9141222E20;
	Tue, 19 Jan 2021 01:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73A90C08A1;
	Tue, 19 Jan 2021 01:33:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFBFAC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A61B08464C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hho7bggHCQpC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA87784640
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:33:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UMC0JGl_1611020021; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UMC0JGl_1611020021) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Jan 2021 09:33:41 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: Jason Wang <jasowang@redhat.com>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
Date: Tue, 19 Jan 2021 09:33:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
Content-Language: en-US
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAxLzE4LzIxIDE6MjUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gCj4gT24gMjAyMS8xLzE4
IOS4iuWNiDExOjU4LCBKb3NlcGggUWkgd3JvdGU6Cj4+IG1vZHVsZSBwYXJhbWV0ZXIgJ3ZpcnRi
bGtfcXVldWVfZGVwdGgnIHdhcyBmaXJzdGx5IGludHJvZHVjZWQgZm9yCj4+IHRlc3RpbmcvYmVu
Y2htYXJraW5nIHB1cnBvc2VzIGRlc2NyaWJlZCBpbiBjb21taXQgZmM0MzI0YjQ1OTdjCj4+ICgi
dmlydGlvLWJsazogYmFzZSBxdWV1ZS1kZXB0aCBvbiB2aXJ0cXVldWUgcmluZ3NpemUgb3IgbW9k
dWxlIHBhcmFtIikuCj4+IFNpbmNlIHdlIGhhdmUgZGlmZmVyZW50IHZpcnRpby1ibGsgZGV2aWNl
cyB3aGljaCBoYXZlIGRpZmZlcmVudAo+PiBjYXBhYmlsaXRpZXMsIGl0IHJlcXVpcmVzIHRoYXQg
d2Ugc3VwcG9ydCBwZXItZGV2aWNlIHF1ZXVlIGRlcHRoIGluc3RlYWQKPj4gb2YgcGVyLW1vZHVs
ZS4gU28gZGVmYXVsdGx5IHVzZSB2cSBmcmVlIGVsZW1lbnRzIGlmIG1vZHVsZSBwYXJhbWV0ZXIK
Pj4gJ3ZpcnRibGtfcXVldWVfZGVwdGgnIGlzIG5vdCBzZXQuCj4gCj4gCj4gSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gdXNlIHN5c2ZzIGluc3RlYWQgKG9yIHdoZXRoZXIgaXQgaGFzIGFscmVh
ZHkKPiBoYWQgc29tZXRoaW5nIGxpa2UgdGhpcyBpbiB0aGUgYmxvY2tlciBsYXllcikuCj4gCgoi
L3N5cy9ibG9jay88ZGV2Pi9xdWV1ZS9ucl9yZXF1ZXN0cyIgaW5kZWVkIHdvcmtzLCBidXQgaXNu
J3QgYmV0dGVyIHRvCnNldCBxdWV1ZV9kZXB0aCBhY2NvcmRpbmcgdG8gdGhlIGhhcmR3YXJlIGNh
cGFiaWxpdHkgYXQgdGhlIHZlcnkgZmlyc3Q/CkFGQUlLLCBudm1lIGp1c3Qgc2V0IHBlci1kZXZp
Y2UgcXVldWVfZGVwdGggYXQgaW5pdGlhbGl6aW5nIHBoYXNlLgoKVGhhbmtzLApKZWZmbGUKCj4g
Cj4gCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJh
YmEuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgfCAxMiArKysr
KysrLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJp
dmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4gaW5kZXggMTQ1NjA2ZC4uZjgzYTQxNyAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4gKysrIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKPj4gQEAgLTcwNSw2ICs3MDUsNyBAQCBzdGF0aWMgaW50IHZpcnRibGtf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+IMKgwqDCoMKgwqAgdTMyIHYsIGJs
a19zaXplLCBtYXhfc2l6ZSwgc2dfZWxlbXMsIG9wdF9pb19zaXplOwo+PiDCoMKgwqDCoMKgIHUx
NiBtaW5faW9fc2l6ZTsKPj4gwqDCoMKgwqDCoCB1OCBwaHlzaWNhbF9ibG9ja19leHAsIGFsaWdu
bWVudF9vZmZzZXQ7Cj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IHF1ZXVlX2RlcHRoOwo+PiDCoCDC
oMKgwqDCoMKgIGlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRc
biIsCj4+IEBAIC03NTUsMTcgKzc1NiwxOCBAQCBzdGF0aWMgaW50IHZpcnRibGtfcHJvYmUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UKPj4gKnZkZXYpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dF9mcmVlX3ZxOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCAvKiBEZWZhdWx0IHF1ZXVl
IHNpemluZyBpcyB0byBmaWxsIHRoZSByaW5nLiAqLwo+PiAtwqDCoMKgIGlmICghdmlydGJsa19x
dWV1ZV9kZXB0aCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdmlydGJsa19xdWV1ZV9kZXB0aCA9IHZi
bGstPnZxc1swXS52cS0+bnVtX2ZyZWU7Cj4+ICvCoMKgwqAgaWYgKGxpa2VseSghdmlydGJsa19x
dWV1ZV9kZXB0aCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlcHRoID0gdmJsay0+dnFz
WzBdLnZxLT5udW1fZnJlZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIC4uLiBidXQgd2l0aG91
dCBpbmRpcmVjdCBkZXNjcywgd2UgdXNlIDIgZGVzY3MgcGVyIHJlcSAqLwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJ
UkVDVF9ERVNDKSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydGJsa19xdWV1ZV9kZXB0
aCAvPSAyOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdWV1ZV9kZXB0aCAvPSAyOwo+PiAr
wqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBxdWV1ZV9kZXB0aCA9IHZpcnRibGtf
cXVldWVfZGVwdGg7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIG1lbXNldCgmdmJs
ay0+dGFnX3NldCwgMCwgc2l6ZW9mKHZibGstPnRhZ19zZXQpKTsKPj4gwqDCoMKgwqDCoCB2Ymxr
LT50YWdfc2V0Lm9wcyA9ICZ2aXJ0aW9fbXFfb3BzOwo+PiAtwqDCoMKgIHZibGstPnRhZ19zZXQu
cXVldWVfZGVwdGggPSB2aXJ0YmxrX3F1ZXVlX2RlcHRoOwo+PiArwqDCoMKgIHZibGstPnRhZ19z
ZXQucXVldWVfZGVwdGggPSBxdWV1ZV9kZXB0aDsKPj4gwqDCoMKgwqDCoCB2YmxrLT50YWdfc2V0
Lm51bWFfbm9kZSA9IE5VTUFfTk9fTk9ERTsKPj4gwqDCoMKgwqDCoCB2YmxrLT50YWdfc2V0LmZs
YWdzID0gQkxLX01RX0ZfU0hPVUxEX01FUkdFOwo+PiDCoMKgwqDCoMKgIHZibGstPnRhZ19zZXQu
Y21kX3NpemUgPQoKLS0gClRoYW5rcywKSmVmZmxlCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
