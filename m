Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E0C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 01:51:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E57224B1
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 01:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E57224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABF4D85077;
	Wed, 20 Jan 2021 01:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G41isVJiEgUi; Wed, 20 Jan 2021 01:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36C9884FD2;
	Wed, 20 Jan 2021 01:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAFC9C088B;
	Wed, 20 Jan 2021 01:51:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 478BFC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 34FD9204F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ripV8Gj76ExM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:51:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 2668C20425
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:51:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UMHI5TK_1611107465; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UMHI5TK_1611107465) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 20 Jan 2021 09:51:06 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: Jason Wang <jasowang@redhat.com>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
 <46f2f81f-9906-e1f7-d8fd-6da2c61683ba@redhat.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <25d8430c-bf18-38ca-cf0c-c054507e1466@linux.alibaba.com>
Date: Wed, 20 Jan 2021 09:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <46f2f81f-9906-e1f7-d8fd-6da2c61683ba@redhat.com>
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

CgpPbiAxLzE5LzIxIDEyOjA2IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IAo+IE9uIDIwMjEvMS8x
OSDkuIrljYg5OjMzLCBKZWZmbGVYdSB3cm90ZToKPj4KPj4gT24gMS8xOC8yMSAxOjI1IFBNLCBK
YXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24gMjAyMS8xLzE4IOS4iuWNiDExOjU4LCBKb3NlcGggUWkg
d3JvdGU6Cj4+Pj4gbW9kdWxlIHBhcmFtZXRlciAndmlydGJsa19xdWV1ZV9kZXB0aCcgd2FzIGZp
cnN0bHkgaW50cm9kdWNlZCBmb3IKPj4+PiB0ZXN0aW5nL2JlbmNobWFya2luZyBwdXJwb3NlcyBk
ZXNjcmliZWQgaW4gY29tbWl0IGZjNDMyNGI0NTk3Ywo+Pj4+ICgidmlydGlvLWJsazogYmFzZSBx
dWV1ZS1kZXB0aCBvbiB2aXJ0cXVldWUgcmluZ3NpemUgb3IgbW9kdWxlIHBhcmFtIikuCj4+Pj4g
U2luY2Ugd2UgaGF2ZSBkaWZmZXJlbnQgdmlydGlvLWJsayBkZXZpY2VzIHdoaWNoIGhhdmUgZGlm
ZmVyZW50Cj4+Pj4gY2FwYWJpbGl0aWVzLCBpdCByZXF1aXJlcyB0aGF0IHdlIHN1cHBvcnQgcGVy
LWRldmljZSBxdWV1ZSBkZXB0aAo+Pj4+IGluc3RlYWQKPj4+PiBvZiBwZXItbW9kdWxlLiBTbyBk
ZWZhdWx0bHkgdXNlIHZxIGZyZWUgZWxlbWVudHMgaWYgbW9kdWxlIHBhcmFtZXRlcgo+Pj4+ICd2
aXJ0YmxrX3F1ZXVlX2RlcHRoJyBpcyBub3Qgc2V0Lgo+Pj4KPj4+IEkgd29uZGVyIGlmIGl0J3Mg
YmV0dGVyIHRvIHVzZSBzeXNmcyBpbnN0ZWFkIChvciB3aGV0aGVyIGl0IGhhcyBhbHJlYWR5Cj4+
PiBoYWQgc29tZXRoaW5nIGxpa2UgdGhpcyBpbiB0aGUgYmxvY2tlciBsYXllcikuCj4+Pgo+PiAi
L3N5cy9ibG9jay88ZGV2Pi9xdWV1ZS9ucl9yZXF1ZXN0cyIgaW5kZWVkIHdvcmtzLCBidXQgaXNu
J3QgYmV0dGVyIHRvCj4+IHNldCBxdWV1ZV9kZXB0aCBhY2NvcmRpbmcgdG8gdGhlIGhhcmR3YXJl
IGNhcGFiaWxpdHkgYXQgdGhlIHZlcnkgZmlyc3Q/Cj4+IEFGQUlLLCBudm1lIGp1c3Qgc2V0IHBl
ci1kZXZpY2UgcXVldWVfZGVwdGggYXQgaW5pdGlhbGl6aW5nIHBoYXNlLgo+IAo+IAo+IEkgYWdy
ZWUsIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGN1cnJlbnQgY29kZSBtYXkgbW9kaWZ5IG1vZHVs
ZSBwYXJhbWV0ZXIuCgpUaGUgbW9kdWxlIHBhcmFtZXRlciAndmlydGJsa19xdWV1ZV9kZXB0aCcg
aXMgYWN0dWFsbHkgcmVtYWluZWQgdW50YWludGVkLgoKQWN0dWFsbHkgaXQgaXMgdGhlIG9yaWdp
bmFsIGNvZGUgYmVmb3JlIHRoaXMgcGF0Y2ggdGhhdCBjaGFuZ2VzIHRoZQptb2R1bGUgcGFyYW1l
dGVyLiBXaGVuIHRoZSBtb2R1bGUgcGFyYW1ldGVyIGlzIG5vdCBzZXQgYnkgYm9vdCBjbWRsaW5l
CihpLmUuLCBkZWZhdWx0IHRvIDApLCBpdCB3aWxsIGJlIGluaXRpYWxpemVkIHRvIHRoZSBxdWV1
ZV9kZXB0aCBvZiB0aGUKdnJpbmcgb2YgdGhlIGZpcnN0IHByb2JlZCB2aXJ0aW8tYmxrIGRldmlj
ZSwgYW5kIHdpbGwgYmUgcmV2ZWFsZWQgdG8KdXNlciBzcGFjZSB0aHJvdWdoICcvc3lzL21vZHVs
ZS92aXJ0aW9fYmxrL3BhcmFtZXRlcnMvcXVldWVfZGVwdGgnLiBJJ20Kbm90IHN1cmUgaWYgdGhp
cyBiZWhhdmlvciBpcyByZWFzb25hYmxlIG9yIG5vdC4KClRoZSBvbmx5IHNpZGUgZWZmZWN0IG9m
IHRoaXMgcGF0Y2ggaXMgdGhhdCwgbm93Cicvc3lzL21vZHVsZS92aXJ0aW9fYmxrL3BhcmFtZXRl
cnMvcXVldWVfZGVwdGgnIHdpbGwgYmUga2VwdCBhcyAnMCcgd2hlbgp0aGUgbW9kdWxlIHBhcmFt
ZXRlciBpcyBub3Qgc2V0IG1hbnVhbGx5LgoKClRoYW5rcywKSmVmZmxlCgoKPj4KPj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogSm9zZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+Cj4+
Pj4gLS0tCj4+Pj4gwqDCoCBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDEyICsrKysrKyst
LS0tLQo+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBi
L2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4+Pj4gaW5kZXggMTQ1NjA2ZC4uZjgzYTQxNyAx
MDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+Pj4+ICsrKyBiL2Ry
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4+Pj4gQEAgLTcwNSw2ICs3MDUsNyBAQCBzdGF0aWMg
aW50IHZpcnRibGtfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UKPj4+PiAqdmRldikKPj4+PiDC
oMKgwqDCoMKgwqAgdTMyIHYsIGJsa19zaXplLCBtYXhfc2l6ZSwgc2dfZWxlbXMsIG9wdF9pb19z
aXplOwo+Pj4+IMKgwqDCoMKgwqDCoCB1MTYgbWluX2lvX3NpemU7Cj4+Pj4gwqDCoMKgwqDCoMKg
IHU4IHBoeXNpY2FsX2Jsb2NrX2V4cCwgYWxpZ25tZW50X29mZnNldDsKPj4+PiArwqDCoMKgIHVu
c2lnbmVkIGludCBxdWV1ZV9kZXB0aDsKPj4+PiDCoMKgIMKgwqDCoMKgwqAgaWYgKCF2ZGV2LT5j
b25maWctPmdldCkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJnZkZXYtPmRl
diwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRcbiIsCj4+Pj4gQEAgLTc1NSwx
NyArNzU2LDE4IEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlvX2Rldmlj
ZQo+Pj4+ICp2ZGV2KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfdnE7
Cj4+Pj4gwqDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgIC3CoMKgwqAgLyogRGVmYXVsdCBxdWV1ZSBz
aXppbmcgaXMgdG8gZmlsbCB0aGUgcmluZy4gKi8KPj4+PiAtwqDCoMKgIGlmICghdmlydGJsa19x
dWV1ZV9kZXB0aCkgewo+Pj4+IC3CoMKgwqDCoMKgwqDCoCB2aXJ0YmxrX3F1ZXVlX2RlcHRoID0g
dmJsay0+dnFzWzBdLnZxLT5udW1fZnJlZTsKPj4+PiArwqDCoMKgIGlmIChsaWtlbHkoIXZpcnRi
bGtfcXVldWVfZGVwdGgpKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlcHRoID0gdmJs
ay0+dnFzWzBdLnZxLT5udW1fZnJlZTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiAuLi4g
YnV0IHdpdGhvdXQgaW5kaXJlY3QgZGVzY3MsIHdlIHVzZSAyIGRlc2NzIHBlciByZXEgKi8KPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fUklOR19GX0lORElSRUNUX0RFU0MpKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZp
cnRibGtfcXVldWVfZGVwdGggLz0gMjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdWV1
ZV9kZXB0aCAvPSAyOwo+Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAg
cXVldWVfZGVwdGggPSB2aXJ0YmxrX3F1ZXVlX2RlcHRoOwo+Pj4+IMKgwqDCoMKgwqDCoCB9Cj4+
Pj4gwqDCoCDCoMKgwqDCoMKgIG1lbXNldCgmdmJsay0+dGFnX3NldCwgMCwgc2l6ZW9mKHZibGst
PnRhZ19zZXQpKTsKPj4+PiDCoMKgwqDCoMKgwqAgdmJsay0+dGFnX3NldC5vcHMgPSAmdmlydGlv
X21xX29wczsKPj4+PiAtwqDCoMKgIHZibGstPnRhZ19zZXQucXVldWVfZGVwdGggPSB2aXJ0Ymxr
X3F1ZXVlX2RlcHRoOwo+Pj4+ICvCoMKgwqAgdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1
ZXVlX2RlcHRoOwo+Pj4+IMKgwqDCoMKgwqDCoCB2YmxrLT50YWdfc2V0Lm51bWFfbm9kZSA9IE5V
TUFfTk9fTk9ERTsKPj4+PiDCoMKgwqDCoMKgwqAgdmJsay0+dGFnX3NldC5mbGFncyA9IEJMS19N
UV9GX1NIT1VMRF9NRVJHRTsKPj4+PiDCoMKgwqDCoMKgwqAgdmJsay0+dGFnX3NldC5jbWRfc2l6
ZSA9CgotLSAKVGhhbmtzLApKZWZmbGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
