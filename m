Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F225C388F7
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:06:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01145206C1
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7ClPaZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01145206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E7A98682C;
	Wed,  4 Nov 2020 01:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGbZwpOPEAJ1; Wed,  4 Nov 2020 01:06:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 054D7869BB;
	Wed,  4 Nov 2020 01:06:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE9C3C0889;
	Wed,  4 Nov 2020 01:06:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE2FC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E2CF869BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ppxMdeqG-5Y
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:06:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EBCBD8682C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:06:20 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A415KLI051725;
 Wed, 4 Nov 2020 01:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4g1Qyk3zIMuI2hc/GK8ov5ul9MZNNMy6Okf5ToOjO0U=;
 b=j7ClPaZUiUuynxb1v/Qez/vyEhY5ETBP+3Kda/LjrXhj/cg692n6tB6u/AaV517IgbT9
 c449eeN9IQF2kugdP1F8dmBi52sHru4Kg1aNxhdJJZOjtktLzGkZAd+HQVnt+AVaMaXb
 r46rkGFMwVls0PRULxy50M0K8bIkdp4SeVMzrZT+87PT618/Tk/FQd86JSXcRrK3cRvF
 Yiu0fi/mWlI8xZZftd3DnuR2E7c1HcPfkIMUo+6HoTY8Urbtx2p505WrKpcQjVHybMZc
 isjJoxT9rvcyf1VHtwnlXCoSDUkShoUK/0ZRWGvLg+sWWdGIqIaNoDWQRalQifGTcRJD FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 34hhw2ma5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 01:06:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A410omC131300;
 Wed, 4 Nov 2020 01:06:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 34jf499kv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 01:06:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A416GW7001902;
 Wed, 4 Nov 2020 01:06:16 GMT
Received: from [10.159.249.36] (/10.159.249.36)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Nov 2020 17:06:16 -0800
Message-ID: <5FA1FE87.4050909@oracle.com>
Date: Tue, 03 Nov 2020 17:06:15 -0800
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
 <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com>
In-Reply-To: <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040004
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

Ck9uIDExLzMvMjAyMCA1OjAwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMC8z
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
ICAgaWYgKG5jaHVua3MgJiYgbGFzdF9wZm4pIHsKPj4gKyAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgcGZuOwo+PiArCj4+ICsgICAgICAgICAgICAvKgo+PiArICAgICAgICAgICAgICogVW5waW4g
dGhlIG91dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB1bm1hcHBlZC4KPj4gKyAgICAgICAgICAg
ICAqIE1hcHBlZCBwYWdlcyBhcmUgYWNjb3VudGVkIGluIHZkcGFfbWFwKCksIHRodXMKPj4gKyAg
ICAgICAgICAgICAqIHdpbGwgYmUgaGFuZGxlZCBieSB2ZHBhX3VubWFwKCkuCj4+ICsgICAgICAg
ICAgICAgKi8KPj4gKyAgICAgICAgICAgIGZvciAocGZuID0gbWFwX3BmbjsgcGZuIDw9IGxhc3Rf
cGZuOyBwZm4rKykKPj4gKyAgICAgICAgICAgICAgICB1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3Bh
Z2UocGZuKSk7Cj4+ICsgICAgICAgIH0KPj4gICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwg
bXNnLT5pb3ZhLCBtc2ctPnNpemUpOwo+Cj4KPiBJIHdhbnQgdG8ga25vdyB3aGF0J3Mgd3Jvbmcg
d2l0aCBjdXJyZW50IGNvZGUuCj4KPiBXZSBjYWxsIHZob3N0X3ZkcGFfdW5tYXAoKSBvbiBlcnJv
ciB3aGljaCBjYWxscyAKPiB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKCkgdGhhdCB3aWxsIHVucGlu
IGFuZCByZWR1Y2UgdGhlIHBpbm5lZF92bS4KVGhpbmsgYWJvdXQgdGhlIGNhc2Ugd2hlcmUgdmhv
c3RfdmRwYV9tYXAoKSBmYWlscyBpbiB0aGUgbWlkZGxlIGFmdGVyIAptYWtpbmcgYSBmZXcgc3Vj
Y2Vzc2Z1bCBvbmVzLiBJbiB0aGUgY3VycmVudCBjb2RlLCB0aGUgCnZob3N0X3ZkcGFfaW90bGJf
dW5tYXAoKSB1bnBpbnMgd2hhdCBoYWQgYmVlbiBtYXBwZWQsIGJ1dCBkb2VzIG5vdCB1bnBpbiAK
dGhvc2UgdGhhdCBoYXZlIG5vdCB5ZXQgYmVlbiBtYXBwZWQuIFRoZXNlIG91dHN0YW5kaW5nIHBp
bm5lZCBwYWdlcyB3aWxsIApiZSBsZWFrZWQgYWZ0ZXIgbGVhdmluZyB0aGUgdmhvc3RfdmRwYV9t
YXAoKSBmdW5jdGlvbi4KCkFsc28sIHRoZSBzdWJ0cmFjdGlvbiBhY2NvdW50aW5nIGF0IHRoZSBl
bmQgb2YgdGhlIGZ1bmN0aW9uIGlzIGluY29ycmVjdCAKaW4gdGhhdCBjYXNlOiBAbnBhZ2VzIGlz
IGRlZHVjZWQgYnkgQHBpbm5lZCBpbiBlYWNoIGl0ZXJhdGlvbi4gVGhhdCdzIAp3aHkgSSBtb3Zl
ZCB0aGUgYWNjb3VudGluZyB0byB2aG9zdF92ZHBhX21hcCgpIHRvIGJlIHN5bW1ldHJpYyB3aXRo
IAp2aG9zdF92ZHBhX3VubWFwKCkuCgoKLVNpd2VpCj4KPiBUaGFua3MKPgo+Cj4+IC0gICAgICAg
IGF0b21pYzY0X3N1YihucGFnZXMsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+PiAgICAgICB9Cj4+
ICt1bmxvY2s6Cj4+ICAgICAgIG1tYXBfcmVhZF91bmxvY2soZGV2LT5tbSk7Cj4+ICtmcmVlOgo+
PiAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPj4gICAgICAgcmV0
dXJuIHJldDsKPj4gICB9Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
