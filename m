Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A092DC4742C
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 02:16:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D9E2071A
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 02:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SyDg1iOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D9E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 223D92046E;
	Wed,  4 Nov 2020 02:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJMK8INPynRJ; Wed,  4 Nov 2020 02:16:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0041A20410;
	Wed,  4 Nov 2020 02:16:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB804C0889;
	Wed,  4 Nov 2020 02:16:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C88A7C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B461F20410
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSHgrIuhtTmi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:16:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by silver.osuosl.org (Postfix) with ESMTPS id 8EB2F20378
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 02:16:17 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A42GFRp007942;
 Wed, 4 Nov 2020 02:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=erw7u5MM+etiNHAQKzo2tCxLDNXM9ykEwYhYCNlVB/4=;
 b=SyDg1iOIFWEHEfRfgRYAm2TQ1DsgCDtyloqPH1zPOfSeDls2XsyYz005VBv3qQl6Obvj
 yXyJManYbMbCbjCSctmCso6cNRofdQLzMD5FvodrTVEtaUChbqECc8PldtSkvTyW9sXl
 lffdKdlirOwPO/V6SPyaQX6HeDd8MHNhO6dZDjnZLofLJGOHQrprAuDQCEgS8tix7Ua+
 MJWeKjImQ2bkWP9g3NYNq1hrg2Rr2n8BmeKQ9LFE9sTOI3uU46nfcaXwsbmwehR8pA1+
 ORJBqzgJDRriuQz5pzG5WDuEjfNQvUp/0uL8Jl/7S4AcHg622lSxrC4EaRn7rHKYA2cw LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 34hhb24etr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 02:16:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A42Ah8l148155;
 Wed, 4 Nov 2020 02:14:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34hw0efjxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 02:14:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A42EAtu013024;
 Wed, 4 Nov 2020 02:14:11 GMT
Received: from [10.159.249.36] (/10.159.249.36)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Nov 2020 18:14:09 -0800
Message-ID: <5FA20E70.9010606@oracle.com>
Date: Tue, 03 Nov 2020 18:14:08 -0800
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
 <5FA1FE87.4050909@oracle.com> <5FA1FF1B.1000303@oracle.com>
 <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
In-Reply-To: <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=2
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040014
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

Ck9uIDExLzMvMjAyMCA1OjU4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMS80
IOS4iuWNiDk6MDgsIHNpLXdlaSBsaXUgd3JvdGU6Cj4+Cj4+IE9uIDExLzMvMjAyMCA1OjA2IFBN
LCBzaS13ZWkgbGl1IHdyb3RlOgo+Pj4KPj4+IE9uIDExLzMvMjAyMCA1OjAwIEFNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMC8xMC8zMCDkuIvljYgzOjQ1LCBTaS1XZWkgTGl1
IHdyb3RlOgo+Pj4+PiBQaW5uZWQgcGFnZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50ZWQgcGFy
dGljdWxhcmx5IHdoZW4KPj4+Pj4gbWFwcGluZyBlcnJvciBvY2N1cnMgb24gSU9UTEIgdXBkYXRl
LiBDbGVhbiB1cCBkYW5nbGluZwo+Pj4+PiBwaW5uZWQgcGFnZXMgZm9yIHRoZSBlcnJvciBwYXRo
Lgo+Pj4+Pgo+Pj4+PiBUaGUgbWVtb3J5IHVzYWdlIGZvciBib29ra2VlcGluZyBwaW5uZWQgcGFn
ZXMgaXMgcmV2ZXJ0ZWQKPj4+Pj4gdG8gd2hhdCBpdCB3YXMgYmVmb3JlOiBvbmx5IG9uZSBzaW5n
bGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPj4+Pj4gVGhpcyBoZWxwcyByZWR1Y2UgdGhlIGhvc3Qg
bWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4+Pj4+IGFtb3VudCBvZiBtZW1vcnks
IG9yIGluIHRoZSBzaXR1YXRpb24gd2hlcmUgaG9zdCBpcyBydW5uaW5nCj4+Pj4+IHNob3J0IG9m
IGZyZWUgbWVtb3J5Lgo+Pj4+Pgo+Pj4+PiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGlu
dHJvZHVjZSB2RFBBLWJhc2VkIGJhY2tlbmQiKQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgIGRyaXZlcnMvdmhv
c3QvdmRwYS5jIHwgNjQgCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0KPj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygr
KSwgMTggZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4+IGluZGV4IGI2ZDkwMTYuLjhkYTg1
NTggMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4+ICsrKyBiL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4+IEBAIC01NjAsNiArNTYwLDggQEAgc3RhdGljIGludCB2
aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4gICAgICAgICBpZiAocikK
Pj4+Pj4gICAgICAgICAgIHZob3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3ZhLCBp
b3ZhICsgc2l6ZSAtIDEpOwo+Pj4+PiArICAgIGVsc2UKPj4+Pj4gKyAgICAgICAgYXRvbWljNjRf
YWRkKHNpemUgPj4gUEFHRV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4+ICAgICAg
ICAgcmV0dXJuIHI7Cj4+Pj4+ICAgfQo+Pj4+PiBAQCAtNTkxLDE0ICs1OTMsMTYgQEAgc3RhdGlj
IGludCAKPj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPj4+Pj4gICAgICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUg
LyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4+Pj4+ICAgICAgIHVuc2lnbmVkIGludCBndXBfZmxh
Z3MgPSBGT0xMX0xPTkdURVJNOwo+Pj4+PiAgICAgICB1bnNpZ25lZCBsb25nIG5wYWdlcywgY3Vy
X2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPj4+Pj4gLSAgICB1bnNpZ25lZCBsb25nIGxv
Y2tlZCwgbG9ja19saW1pdCwgcGlubmVkLCBpOwo+Pj4+PiArICAgIHVuc2lnbmVkIGxvbmcgbG9j
a19saW1pdCwgc3oycGluLCBuY2h1bmtzLCBpOwo+Pj4+PiAgICAgICB1NjQgaW92YSA9IG1zZy0+
aW92YTsKPj4+Pj4gKyAgICBsb25nIHBpbm5lZDsKPj4+Pj4gICAgICAgaW50IHJldCA9IDA7Cj4+
Pj4+ICAgICAgICAgaWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEs
Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkK
Pj4+Pj4gICAgICAgICAgIHJldHVybiAtRUVYSVNUOwo+Pj4+PiAgICsgICAgLyogTGltaXQgdGhl
IHVzZSBvZiBtZW1vcnkgZm9yIGJvb2trZWVwaW5nICovCj4+Pj4+ICAgICAgIHBhZ2VfbGlzdCA9
IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+Pj4+PiAgICAg
ICBpZiAoIXBhZ2VfbGlzdCkKPj4+Pj4gICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+Pj4+PiBA
QCAtNjA3LDUyICs2MTEsNjQgQEAgc3RhdGljIGludCAKPj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNz
X2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4gICAgICAgICAgIGd1cF9m
bGFncyB8PSBGT0xMX1dSSVRFOwo+Pj4+PiAgICAgICAgIG5wYWdlcyA9IFBBR0VfQUxJR04obXNn
LT5zaXplICsgKGlvdmEgJiB+UEFHRV9NQVNLKSkgPj4gCj4+Pj4+IFBBR0VfU0hJRlQ7Cj4+Pj4+
IC0gICAgaWYgKCFucGFnZXMpCj4+Pj4+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiAr
ICAgIGlmICghbnBhZ2VzKSB7Cj4+Pj4+ICsgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4+Pj4+ICsg
ICAgICAgIGdvdG8gZnJlZTsKPj4+Pj4gKyAgICB9Cj4+Pj4+ICAgICAgICAgbW1hcF9yZWFkX2xv
Y2soZGV2LT5tbSk7Cj4+Pj4+ICAgLSAgICBsb2NrZWQgPSBhdG9taWM2NF9hZGRfcmV0dXJuKG5w
YWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4+ICAgICAgIGxvY2tfbGltaXQgPSBybGlt
aXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7Cj4+Pj4+IC0KPj4+Pj4gLSAgICBpZiAo
bG9ja2VkID4gbG9ja19saW1pdCkgewo+Pj4+PiArICAgIGlmIChucGFnZXMgKyBhdG9taWM2NF9y
ZWFkKCZkZXYtPm1tLT5waW5uZWRfdm0pID4gbG9ja19saW1pdCkgewo+Pj4+PiAgICAgICAgICAg
cmV0ID0gLUVOT01FTTsKPj4+Pj4gLSAgICAgICAgZ290byBvdXQ7Cj4+Pj4+ICsgICAgICAgIGdv
dG8gdW5sb2NrOwo+Pj4+PiAgICAgICB9Cj4+Pj4+ICAgICAgICAgY3VyX2Jhc2UgPSBtc2ctPnVh
ZGRyICYgUEFHRV9NQVNLOwo+Pj4+PiAgICAgICBpb3ZhICY9IFBBR0VfTUFTSzsKPj4+Pj4gKyAg
ICBuY2h1bmtzID0gMDsKPj4+Pj4gICAgICAgICB3aGlsZSAobnBhZ2VzKSB7Cj4+Pj4+IC0gICAg
ICAgIHBpbm5lZCA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+
Pj4gLSAgICAgICAgcmV0ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4+Pj4g
LSAgICAgICAgICAgICAgICAgICAgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4+Pj4g
LSAgICAgICAgaWYgKHJldCAhPSBwaW5uZWQpCj4+Pj4+ICsgICAgICAgIHN6MnBpbiA9IG1pbl90
KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+Pj4gKyAgICAgICAgcGlubmVk
ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+Pj4+PiArICAgICAgICBpZiAoc3oy
cGluICE9IHBpbm5lZCkgewo+Pj4+PiArICAgICAgICAgICAgaWYgKHBpbm5lZCA8IDApIHsKPj4+
Pj4gKyAgICAgICAgICAgICAgICByZXQgPSBwaW5uZWQ7Cj4+Pj4+ICsgICAgICAgICAgICB9IGVs
c2Ugewo+Pj4+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMocGFnZV9saXN0LCBw
aW5uZWQpOwo+Pj4+PiArICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07Cj4+Pj4+ICsgICAg
ICAgICAgICB9Cj4+Pj4+ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4+ICsgICAgICAgIH0K
Pj4+Pj4gKyAgICAgICAgbmNodW5rcysrOwo+Pj4+PiAgICAgICAgICAgICBpZiAoIWxhc3RfcGZu
KQo+Pj4+PiAgICAgICAgICAgICAgIG1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0p
Owo+Pj4+PiAgIC0gICAgICAgIGZvciAoaSA9IDA7IGkgPCByZXQ7IGkrKykgewo+Pj4+PiArICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgcGlubmVkOyBpKyspIHsKPj4+Pj4gICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIHRoaXNfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0W2ldKTsKPj4+Pj4g
ICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4+Pj4+ICAgICAgICAgICAgICAgICBpZiAobGFzdF9w
Zm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsKPj4+Pj4gICAgICAgICAgICAgICAg
ICAgLyogUGluIGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8KPj4+Pj4gICAgICAgICAg
ICAgICAgICAgY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsK
Pj4+Pj4gLSAgICAgICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUs
Cj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
Cj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ctPnBlcm0pKQo+Pj4+PiArICAg
ICAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplLAo+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSk7Cj4+Pj4+ICsgICAgICAg
ICAgICAgICAgaWYgKHJldCkKPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+
Pj4+PiArCj4+Pj4+ICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPSB0aGlzX3BmbjsKPj4+Pj4g
ICAgICAgICAgICAgICAgICAgaW92YSArPSBjc2l6ZTsKPj4+Pj4gKyAgICAgICAgICAgICAgICBu
Y2h1bmtzID0gMDsKPj4+Pj4gICAgICAgICAgICAgICB9Cj4+Pj4+ICAgICAgICAgICAgICAgICBs
YXN0X3BmbiA9IHRoaXNfcGZuOwo+Pj4+PiAgICAgICAgICAgfQo+Pj4+PiAgIC0gICAgICAgIGN1
cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+Pj4+PiAtICAgICAgICBucGFnZXMgLT0gcmV0
Owo+Pj4+PiArICAgICAgICBjdXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPj4+Pj4g
KyAgICAgICAgbnBhZ2VzIC09IHBpbm5lZDsKPj4+Pj4gICAgICAgfQo+Pj4+PiAgICAgICAgIC8q
IFBpbiB0aGUgcmVzdCBjaHVuayAqLwo+Pj4+PiBAQCAtNjYwLDEwICs2NzYsMjIgQEAgc3RhdGlj
IGludCAKPj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPj4+Pj4gICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwg
bXNnLT5wZXJtKTsKPj4+Pj4gICBvdXQ6Cj4+Pj4+ICAgICAgIGlmIChyZXQpIHsKPj4+Pj4gKyAg
ICAgICAgaWYgKG5jaHVua3MgJiYgbGFzdF9wZm4pIHsKPj4+Pj4gKyAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgcGZuOwo+Pj4+PiArCj4+Pj4+ICsgICAgICAgICAgICAvKgo+Pj4+PiArICAgICAg
ICAgICAgICogVW5waW4gdGhlIG91dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB1bm1hcHBlZC4K
Pj4+Pj4gKyAgICAgICAgICAgICAqIE1hcHBlZCBwYWdlcyBhcmUgYWNjb3VudGVkIGluIHZkcGFf
bWFwKCksIHRodXMKPj4+Pj4gKyAgICAgICAgICAgICAqIHdpbGwgYmUgaGFuZGxlZCBieSB2ZHBh
X3VubWFwKCkuCj4+Pj4+ICsgICAgICAgICAgICAgKi8KPj4+Pj4gKyAgICAgICAgICAgIGZvciAo
cGZuID0gbWFwX3BmbjsgcGZuIDw9IGxhc3RfcGZuOyBwZm4rKykKPj4+Pj4gKyAgICAgICAgICAg
ICAgICB1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3BhZ2UocGZuKSk7Cj4+Pj4+ICsgICAgICAgIH0K
Pj4+Pj4gICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwgbXNnLT5pb3ZhLCBtc2ctPnNpemUp
Owo+Pj4+Cj4+Pj4KPj4+PiBJIHdhbnQgdG8ga25vdyB3aGF0J3Mgd3Jvbmcgd2l0aCBjdXJyZW50
IGNvZGUuCj4+Pj4KPj4+PiBXZSBjYWxsIHZob3N0X3ZkcGFfdW5tYXAoKSBvbiBlcnJvciB3aGlj
aCBjYWxscyAKPj4+PiB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKCkgdGhhdCB3aWxsIHVucGluIGFu
ZCByZWR1Y2UgdGhlIHBpbm5lZF92bS4KPj4+IFRoaW5rIGFib3V0IHRoZSBjYXNlIHdoZXJlIHZo
b3N0X3ZkcGFfbWFwKCkgZmFpbHMgaW4gdGhlIG1pZGRsZSAKPj4+IGFmdGVyIG1ha2luZyBhIGZl
dyBzdWNjZXNzZnVsIG9uZXMuIEluIHRoZSBjdXJyZW50IGNvZGUsIHRoZSAKPj4+IHZob3N0X3Zk
cGFfaW90bGJfdW5tYXAoKSB1bnBpbnMgd2hhdCBoYWQgYmVlbiBtYXBwZWQsIGJ1dCBkb2VzIG5v
dCAKPj4+IHVucGluIHRob3NlIHRoYXQgaGF2ZSBub3QgeWV0IGJlZW4gbWFwcGVkLiBUaGVzZSBv
dXRzdGFuZGluZyBwaW5uZWQgCj4+PiBwYWdlcyB3aWxsIGJlIGxlYWtlZCBhZnRlciBsZWF2aW5n
IHRoZSB2aG9zdF92ZHBhX21hcCgpIGZ1bmN0aW9uLgo+PiBUeXBvOiAuLi4gbGVhdmluZyB0aGUg
dmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZSgpIGZ1bmN0aW9uLgo+Pj4KPj4+IEFsc28s
IHRoZSBzdWJ0cmFjdGlvbiBhY2NvdW50aW5nIGF0IHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uIGlz
IAo+Pj4gaW5jb3JyZWN0IGluIHRoYXQgY2FzZTogQG5wYWdlcyBpcyBkZWR1Y2VkIGJ5IEBwaW5u
ZWQgaW4gZWFjaCAKPj4+IGl0ZXJhdGlvbi4gVGhhdCdzIHdoeSBJIG1vdmVkIHRoZSBhY2NvdW50
aW5nIHRvIHZob3N0X3ZkcGFfbWFwKCkgdG8gCj4+PiBiZSBzeW1tZXRyaWMgd2l0aCB2aG9zdF92
ZHBhX3VubWFwKCkuCj4+Pgo+Cj4gSSBzZWUsIHRoZW4gSSB3b25kZXIgaWYgaXQgd291bGQgaGF2
ZSBtb3JlIGVhc3kgdG8gcmVhZCBjb2RlIGlmIHdlIGRvIAo+ICh1bilwaW5uaW5nL2FjY291dGlu
ZyBvbmx5IGluIHZob3N0X3ZkcGFfbWFwKCkvdmhvc3RfdmRwYV91bm1hcCgpPwoKWWVzLiBUaGF0
J3Mgd2hhdCBJJ3ZlIGRvbmUgaW4gbXkgbmV3IGNvZGUuIFRob3VnaCwgdGhlIGNhbGxlciBzdGls
bCBoYXMgCnRvIHVucGluIHRoZSBvdXRzdGFuZGluZyBwYWdlcyB0aGF0IGFyZW4ndCBhY2NvdW50
ZWQgZm9yIGluIAp2aG9zdF92ZHBhX21hcCgpLgoKLVNpd2VpCgoKPgo+IFRoYW5rcwo+Cj4KPj4+
Cj4+PiAtU2l3ZWkKPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gLSAgICAgICAgYXRv
bWljNjRfc3ViKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4+ICAgICAgIH0KPj4+
Pj4gK3VubG9jazoKPj4+Pj4gICAgICAgbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPj4+Pj4g
K2ZyZWU6Cj4+Pj4+ICAgICAgIGZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3QpOwo+
Pj4+PiAgICAgICByZXR1cm4gcmV0Owo+Pj4+PiAgIH0KPj4+Pgo+Pj4KPj4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
