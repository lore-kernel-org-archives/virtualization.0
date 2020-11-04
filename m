Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339BC388F7
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 23:41:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4032074B
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 23:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZhC9ginK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4032074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AFBFB856B7;
	Wed,  4 Nov 2020 23:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0LBAOb-vzd2K; Wed,  4 Nov 2020 23:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C94CE853FC;
	Wed,  4 Nov 2020 23:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4788C0889;
	Wed,  4 Nov 2020 23:41:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22C34C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1B112203F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rY7xh7qRPb8u
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:41:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id D61BF203A4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 23:41:02 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NdTRH027609;
 Wed, 4 Nov 2020 23:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TmvYSJAEXaLiuZqwCoKufrk44V28jWvQyY1Rql+I8fE=;
 b=ZhC9ginK2YTXj5nolrEEswjRXpbG1XEb5wCrqsk5kgqjbzF9Ks/DaKFKPyBkC7b4PYLt
 JQ5HY2cG8Ni4FG8p0ommD5cOsUKnSm2cTNpJZXwcrRx9HO1gJTsdavyAthUD2knIotIJ
 BCwR/W2T4IZb5ln+FfSon13HodHKeGmv/romcJPkHCDcDTEawCNaNSNIEvGYJw3yKq+e
 Zwp+KO2/IQkhl787m+DQ/tY5L9aUfsht9jrtLCSbFE24Jp5ec0G1aPK9eBKwgEjkbhZN
 Y2qtMxvTAxqrFDOCk/6estO7z0fkcsBiPJ9/eDYRFCjV6M2k+YBeOz4DvcFeqQw4hmBF Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34hhvchf0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 23:40:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NdwS6095672;
 Wed, 4 Nov 2020 23:40:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 34hvryn7nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 23:40:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4NevN5029823;
 Wed, 4 Nov 2020 23:40:57 GMT
Received: from [10.159.134.39] (/10.159.134.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Nov 2020 15:40:56 -0800
Message-ID: <5FA33C06.6010000@oracle.com>
Date: Wed, 04 Nov 2020 15:40:54 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, lingshan.zhu@intel.com
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
 <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
 <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com>
In-Reply-To: <77a2aefe-ccad-bd51-3721-1139d4e535d7@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=2 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040169
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDExLzMvMjAyMCA2OjQyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMC8z
MCDkuIvljYgzOjQ1LCBTaS1XZWkgTGl1IHdyb3RlOgo+PiBQaW5uZWQgcGFnZXMgYXJlIG5vdCBw
cm9wZXJseSBhY2NvdW50ZWQgcGFydGljdWxhcmx5IHdoZW4KPj4gbWFwcGluZyBlcnJvciBvY2N1
cnMgb24gSU9UTEIgdXBkYXRlLiBDbGVhbiB1cCBkYW5nbGluZwo+PiBwaW5uZWQgcGFnZXMgZm9y
IHRoZSBlcnJvciBwYXRoLgo+Pgo+PiBUaGUgbWVtb3J5IHVzYWdlIGZvciBib29ra2VlcGluZyBw
aW5uZWQgcGFnZXMgaXMgcmV2ZXJ0ZWQKPj4gdG8gd2hhdCBpdCB3YXMgYmVmb3JlOiBvbmx5IG9u
ZSBzaW5nbGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPj4gVGhpcyBoZWxwcyByZWR1Y2UgdGhlIGhv
c3QgbWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4+IGFtb3VudCBvZiBtZW1vcnks
IG9yIGluIHRoZSBzaXR1YXRpb24gd2hlcmUgaG9zdCBpcyBydW5uaW5nCj4+IHNob3J0IG9mIGZy
ZWUgbWVtb3J5Lgo+Pgo+PiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2
RFBBLWJhc2VkIGJhY2tlbmQiKQo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNjQgCj4+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4+IGluZGV4IGI2ZDkwMTYuLjhkYTg1NTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC01NjAsNiArNTYwLDgg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAg
ICAgICBpZiAocikKPj4gICAgICAgICAgIHZob3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxi
LCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEpOwo+PiArICAgIGVsc2UKPj4gKyAgICAgICAgYXRvbWlj
NjRfYWRkKHNpemUgPj4gUEFHRV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+ICAgICAg
ICAgcmV0dXJuIHI7Cj4+ICAgfQo+PiBAQCAtNTkxLDE0ICs1OTMsMTYgQEAgc3RhdGljIGludCAK
Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwK
Pj4gICAgICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3Ry
dWN0IHBhZ2UgKik7Cj4+ICAgICAgIHVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xMX0xPTkdU
RVJNOwo+PiAgICAgICB1bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxh
c3RfcGZuID0gMDsKPj4gLSAgICB1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlu
bmVkLCBpOwo+PiArICAgIHVuc2lnbmVkIGxvbmcgbG9ja19saW1pdCwgc3oycGluLCBuY2h1bmtz
LCBpOwo+PiAgICAgICB1NjQgaW92YSA9IG1zZy0+aW92YTsKPj4gKyAgICBsb25nIHBpbm5lZDsK
Pj4gICAgICAgaW50IHJldCA9IDA7Cj4+ICAgICAgICAgaWYgKHZob3N0X2lvdGxiX2l0cmVlX2Zp
cnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4+ICAgICAgICAgICAgICAgICAgICAgICBtc2ctPmlvdmEg
KyBtc2ctPnNpemUgLSAxKSkKPj4gICAgICAgICAgIHJldHVybiAtRUVYSVNUOwo+PiAgICsgICAg
LyogTGltaXQgdGhlIHVzZSBvZiBtZW1vcnkgZm9yIGJvb2trZWVwaW5nICovCj4+ICAgICAgIHBh
Z2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+
PiAgICAgICBpZiAoIXBhZ2VfbGlzdCkKPj4gICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+PiBA
QCAtNjA3LDUyICs2MTEsNjQgQEAgc3RhdGljIGludCAKPj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lv
dGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAgICAgICAgIGd1cF9mbGFncyB8
PSBGT0xMX1dSSVRFOwo+PiAgICAgICAgIG5wYWdlcyA9IFBBR0VfQUxJR04obXNnLT5zaXplICsg
KGlvdmEgJiB+UEFHRV9NQVNLKSkgPj4gCj4+IFBBR0VfU0hJRlQ7Cj4+IC0gICAgaWYgKCFucGFn
ZXMpCj4+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiArICAgIGlmICghbnBhZ2VzKSB7Cj4+
ICsgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4+ICsgICAgICAgIGdvdG8gZnJlZTsKPj4gKyAgICB9
Cj4+ICAgICAgICAgbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4+ICAgLSAgICBsb2NrZWQgPSBh
dG9taWM2NF9hZGRfcmV0dXJuKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+ICAgICAg
IGxvY2tfbGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7Cj4+IC0K
Pj4gLSAgICBpZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+PiArICAgIGlmIChucGFnZXMgKyBh
dG9taWM2NF9yZWFkKCZkZXYtPm1tLT5waW5uZWRfdm0pID4gbG9ja19saW1pdCkgewo+PiAgICAg
ICAgICAgcmV0ID0gLUVOT01FTTsKPj4gLSAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgIGdv
dG8gdW5sb2NrOwo+PiAgICAgICB9Cj4+ICAgICAgICAgY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYg
UEFHRV9NQVNLOwo+PiAgICAgICBpb3ZhICY9IFBBR0VfTUFTSzsKPj4gKyAgICBuY2h1bmtzID0g
MDsKPj4gICAgICAgICB3aGlsZSAobnBhZ2VzKSB7Cj4+IC0gICAgICAgIHBpbm5lZCA9IG1pbl90
KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4gLSAgICAgICAgcmV0ID0gcGlu
X3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4gLSAgICAgICAgICAgICAgICAgICAgIGd1
cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4gLSAgICAgICAgaWYgKHJldCAhPSBwaW5uZWQp
Cj4+ICsgICAgICAgIHN6MnBpbiA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9z
aXplKTsKPj4gKyAgICAgICAgcGlubmVkID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBp
biwKPj4gKyAgICAgICAgICAgICAgICAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+
PiArICAgICAgICBpZiAoc3oycGluICE9IHBpbm5lZCkgewo+PiArICAgICAgICAgICAgaWYgKHBp
bm5lZCA8IDApIHsKPj4gKyAgICAgICAgICAgICAgICByZXQgPSBwaW5uZWQ7Cj4+ICsgICAgICAg
ICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMocGFnZV9s
aXN0LCBwaW5uZWQpOwo+PiArICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07Cj4+ICsgICAg
ICAgICAgICB9Cj4+ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgIH0KPj4gKyAg
ICAgICAgbmNodW5rcysrOwo+PiAgICAgICAgICAgICBpZiAoIWxhc3RfcGZuKQo+PiAgICAgICAg
ICAgICAgIG1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+PiAgIC0gICAgICAg
IGZvciAoaSA9IDA7IGkgPCByZXQ7IGkrKykgewo+PiArICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
cGlubmVkOyBpKyspIHsKPj4gICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHRoaXNfcGZuID0g
cGFnZV90b19wZm4ocGFnZV9saXN0W2ldKTsKPj4gICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4+
ICAgICAgICAgICAgICAgICBpZiAobGFzdF9wZm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsg
MSkpIHsKPj4gICAgICAgICAgICAgICAgICAgLyogUGluIGEgY29udGlndW91cyBjaHVuayBvZiBt
ZW1vcnkgKi8KPj4gICAgICAgICAgICAgICAgICAgY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZu
ICsgMSkgPDwgUEFHRV9TSElGVDsKPj4gLSAgICAgICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9t
YXAodiwgaW92YSwgY3NpemUsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZu
IDw8IFBBR0VfU0hJRlQsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ctPnBlcm0p
KQo+PiArICAgICAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXpl
LAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSk7Cj4+ICsgICAgICAg
ICAgICAgICAgaWYgKHJldCkKPj4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+PiAr
Cj4+ICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPSB0aGlzX3BmbjsKPj4gICAgICAgICAgICAg
ICAgICAgaW92YSArPSBjc2l6ZTsKPj4gKyAgICAgICAgICAgICAgICBuY2h1bmtzID0gMDsKPj4g
ICAgICAgICAgICAgICB9Cj4+ICAgICAgICAgICAgICAgICBsYXN0X3BmbiA9IHRoaXNfcGZuOwo+
PiAgICAgICAgICAgfQo+PiAgIC0gICAgICAgIGN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZU
Owo+PiAtICAgICAgICBucGFnZXMgLT0gcmV0Owo+PiArICAgICAgICBjdXJfYmFzZSArPSBwaW5u
ZWQgPDwgUEFHRV9TSElGVDsKPj4gKyAgICAgICAgbnBhZ2VzIC09IHBpbm5lZDsKPj4gICAgICAg
fQo+PiAgICAgICAgIC8qIFBpbiB0aGUgcmVzdCBjaHVuayAqLwo+PiBAQCAtNjYwLDEwICs2NzYs
MjIgQEAgc3RhdGljIGludCAKPj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9T
SElGVCwgbXNnLT5wZXJtKTsKPj4gICBvdXQ6Cj4+ICAgICAgIGlmIChyZXQpIHsKPj4gKyAgICAg
ICAgaWYgKG5jaHVua3MgJiYgbGFzdF9wZm4pIHsKPgo+Cj4gQ2FuIHdlIGRlY3JlYXNlIG5wYWdl
cyB3aGVyZSB5b3UgZGlkICJuY2h1bmtzKysiIHRoZW4gd2UgY2FuIGNoZWNrIAo+IG5wYWdlcyBo
ZXJlIGluc3RlYWQ/CkhtbW0sIEkgYW0gbm90IHN1cmUgSSBnZXQgd2hhdCB5b3Ugd2FudC4uLiBA
bmNodW5rcyBnZXRzIHJlc2V0IHRvIDAgCndoZW5ldmVyIGEgY2VydGFpbiByYW5nZSBvZiBwaW5u
ZWQgcGFnZXMgaXMgc3VjY2Vzc2Z1bGx5IG1hcHBlZC4gVGhlIApjb25kaXRpb25hbCAod2hlbiBu
Y2h1bmtzIGlzIG5vbi16ZXJvKSBoZXJlIGluZGljYXRlcyBpZiB0aGVyZSdzIGFueSAKX291dHN0
YW5kaW5nXyBwaW5uZWQgcGFnZSB0aGF0IGhhcyB0byBjbGVhbiB1cCBpbiB0aGUgZXJyb3IgaGFu
ZGxpbmcgCnBhdGguIFdoaWxlIHRoZSBkZWNyZW1lbnQgb2YgQG5wYWdlcyBtYXkgbm90IG9jY3Vy
IHdoZW4gcmVzZXR0aW5nIHRoZSAKQG5jaHVua3MgY291bnRlciwgcmVuZGVyaW5nIGluY29ycmVj
dCBjbGVhbnVwIGluIHRoZSBlcnJvciBwYXRoLgoKQlRXIHdoaWxlIHJldmlld2luZyBpdCBJIGdv
dCBub3RpY2VkIG9mIGFuIGVycm9yIGluIG15IGNvZGUuIFRoZXJlIG1pZ2h0IApiZSBzdGlsbCBw
YWdlIHBpbm5pbmcgbGVhayBmcm9tIHdoZXJldmVyIHRoZSB2aG9zdF92ZHBhX21hcCgpIGVycm9y
IApvY2N1cnMgdG93YXJkcyB0aGUgZW5kIG9mIHBhZ2VfbGlzdC4gSSB3aWxsIHBvc3QgYSB2MiB0
byBmaXggdGhpcy4KClJlZ2FyZHMsCi1TaXdlaQoKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMK
KysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKQEAgLTY1Niw4ICs2NTYsMTkgQEAgc3RhdGljIGlu
dCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCAKdmhvc3RfdmRwYSAqdiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwg
aW92YSwgY3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNnLT5wZXJtKTsKLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAocmV0KQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChyZXQpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBVbnBpbiB0aGUgcGFnZXMg
dGhhdCBhcmUgbGVmdCAKdW5tYXBwZWQKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIGZyb20gdGhpcyBwb2ludCBvbiBpbiB0aGUgY3VycmVudAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICogcGFnZV9saXN0LiBUaGUgcmVtYWluaW5nIApv
dXRzdGFuZGluZworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogb25l
cyB3aGljaCBtYXkgc3RyaWRlIGFjcm9zcyAKc2V2ZXJhbAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogY2h1bmtzIHdpbGwgYmUgY292ZXJlZCBpbiB0aGUgCmNvbW1v
bgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogZXJyb3IgcGF0aCBz
dWJzZXF1ZW50bHkuCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8K
KyB1bnBpbl91c2VyX3BhZ2VzKCZwYWdlX2xpc3RbaV0sCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm5lZCAtIGkpOwogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0OworICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIH0KCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9w
Zm4gPSB0aGlzX3BmbjsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW92YSArPSBj
c2l6ZTsKCgoKPgo+IFRoYW5rcwo+Cj4KPj4gKyAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcGZu
Owo+PiArCj4+ICsgICAgICAgICAgICAvKgo+PiArICAgICAgICAgICAgICogVW5waW4gdGhlIG91
dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB1bm1hcHBlZC4KPj4gKyAgICAgICAgICAgICAqIE1h
cHBlZCBwYWdlcyBhcmUgYWNjb3VudGVkIGluIHZkcGFfbWFwKCksIHRodXMKPj4gKyAgICAgICAg
ICAgICAqIHdpbGwgYmUgaGFuZGxlZCBieSB2ZHBhX3VubWFwKCkuCj4+ICsgICAgICAgICAgICAg
Ki8KPj4gKyAgICAgICAgICAgIGZvciAocGZuID0gbWFwX3BmbjsgcGZuIDw9IGxhc3RfcGZuOyBw
Zm4rKykKPj4gKyAgICAgICAgICAgICAgICB1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3BhZ2UocGZu
KSk7Cj4+ICsgICAgICAgIH0KPj4gICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwgbXNnLT5p
b3ZhLCBtc2ctPnNpemUpOwo+PiAtICAgICAgICBhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5t
bS0+cGlubmVkX3ZtKTsKPj4gICAgICAgfQo+PiArdW5sb2NrOgo+PiAgICAgICBtbWFwX3JlYWRf
dW5sb2NrKGRldi0+bW0pOwo+PiArZnJlZToKPj4gICAgICAgZnJlZV9wYWdlKCh1bnNpZ25lZCBs
b25nKXBhZ2VfbGlzdCk7Cj4+ICAgICAgIHJldHVybiByZXQ7Cj4+ICAgfQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
