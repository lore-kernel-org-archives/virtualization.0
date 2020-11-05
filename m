Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B3C388F7
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 22:40:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3671E20782
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 22:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n6wmRoKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3671E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A73B5867F6;
	Thu,  5 Nov 2020 22:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGynftVlouvY; Thu,  5 Nov 2020 22:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8275867F5;
	Thu,  5 Nov 2020 22:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA637C0893;
	Thu,  5 Nov 2020 22:40:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE45C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B96E85A84
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XlbB4bjQ3zD4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4127A84E8C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:40:18 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MdLr1108716;
 Thu, 5 Nov 2020 22:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cqWZm+4EoPfwmoGeHu0IrhFosnm7ha7NSRN73JiWl2k=;
 b=n6wmRoKKjgGFXtuSrwdivoS9w1PoZBn90gpoukxDDVMex7MrUZ1O9wU1X7SbIzbiDZmH
 LQvfFiFywZC9EaLK938xwvZ0Muhprp2RbGUVUi1MSb65/ZLE5+059FoO9ibOpGzW5izz
 FSq9nFArtTRgfflPhdVLm0bSSQupy4QgTZwBSAFF1WKIYGAPrRTMDm93bT6BflqxhZAZ
 trm2jeW3X/SmSibzkeNi6iYTwopRT80gvWhUJJk6bxCAM1OrjlwPZ/CFfZ2RSAiG7AE/
 QZ8M6+A8/VVFTiRrGppJWES3G4Dxgxbc/QT3YWgxbHtDGvWX0mUZk4Y6qFGgmRjJud2C Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 34hhw2xg1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Nov 2020 22:40:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MUauw072666;
 Thu, 5 Nov 2020 22:40:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 34hw0ne26m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Nov 2020 22:40:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5MeDT7014778;
 Thu, 5 Nov 2020 22:40:14 GMT
Received: from [192.168.0.28] (/73.189.186.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Nov 2020 14:40:13 -0800
Message-ID: <5FA47F4C.2030504@oracle.com>
Date: Thu, 05 Nov 2020 14:40:12 -0800
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
 <5FA33C06.6010000@oracle.com>
 <38317b10-0f1f-1521-ec10-a462be83b5a6@redhat.com>
In-Reply-To: <38317b10-0f1f-1521-ec10-a462be83b5a6@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050146
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

Ck9uIDExLzQvMjAyMCA3OjEyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMS81
IOS4iuWNiDc6NDAsIHNpLXdlaSBsaXUgd3JvdGU6Cj4+Cj4+IE9uIDExLzMvMjAyMCA2OjQyIFBN
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjAvMTAvMzAg5LiL5Y2IMzo0NSwgU2kt
V2VpIExpdSB3cm90ZToKPj4+PiBQaW5uZWQgcGFnZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50
ZWQgcGFydGljdWxhcmx5IHdoZW4KPj4+PiBtYXBwaW5nIGVycm9yIG9jY3VycyBvbiBJT1RMQiB1
cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4+Pj4gcGlubmVkIHBhZ2VzIGZvciB0aGUgZXJyb3Ig
cGF0aC4KPj4+Pgo+Pj4+IFRoZSBtZW1vcnkgdXNhZ2UgZm9yIGJvb2trZWVwaW5nIHBpbm5lZCBw
YWdlcyBpcyByZXZlcnRlZAo+Pj4+IHRvIHdoYXQgaXQgd2FzIGJlZm9yZTogb25seSBvbmUgc2lu
Z2xlIGZyZWUgcGFnZSBpcyBuZWVkZWQuCj4+Pj4gVGhpcyBoZWxwcyByZWR1Y2UgdGhlIGhvc3Qg
bWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4+Pj4gYW1vdW50IG9mIG1lbW9yeSwg
b3IgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZSBob3N0IGlzIHJ1bm5pbmcKPj4+PiBzaG9ydCBvZiBm
cmVlIG1lbW9yeS4KPj4+Pgo+Pj4+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9k
dWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgZHJpdmVycy92aG9zdC92ZHBh
LmMgfCA2NCAKPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tCj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTggZGVs
ZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+IGluZGV4IGI2ZDkwMTYuLjhkYTg1NTggMTAwNjQ0Cj4+
Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+Pj4+IEBAIC01NjAsNiArNTYwLDggQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX21hcChz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+PiAgICAgICAgIGlmIChyKQo+Pj4+ICAgICAgICAgICB2
aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUgLSAxKTsK
Pj4+PiArICAgIGVsc2UKPj4+PiArICAgICAgICBhdG9taWM2NF9hZGQoc2l6ZSA+PiBQQUdFX1NI
SUZULCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4+PiAgICAgICAgIHJldHVybiByOwo+Pj4+ICAg
fQo+Pj4+IEBAIC01OTEsMTQgKzU5MywxNiBAQCBzdGF0aWMgaW50IAo+Pj4+IHZob3N0X3ZkcGFf
cHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4gICAgICAgdW5z
aWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7
Cj4+Pj4gICAgICAgdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9OR1RFUk07Cj4+Pj4g
ICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBfcGZuLCBsYXN0X3BmbiA9
IDA7Cj4+Pj4gLSAgICB1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlubmVkLCBp
Owo+Pj4+ICsgICAgdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3MsIGk7
Cj4+Pj4gICAgICAgdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4+Pj4gKyAgICBsb25nIHBpbm5lZDsK
Pj4+PiAgICAgICBpbnQgcmV0ID0gMDsKPj4+PiAgICAgICAgIGlmICh2aG9zdF9pb3RsYl9pdHJl
ZV9maXJzdChpb3RsYiwgbXNnLT5pb3ZhLAo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBtc2ct
PmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPj4+PiAgICAgICAgICAgcmV0dXJuIC1FRVhJU1Q7Cj4+
Pj4gICArICAgIC8qIExpbWl0IHRoZSB1c2Ugb2YgbWVtb3J5IGZvciBib29ra2VlcGluZyAqLwo+
Pj4+ICAgICAgIHBhZ2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9wYWdlKEdG
UF9LRVJORUwpOwo+Pj4+ICAgICAgIGlmICghcGFnZV9saXN0KQo+Pj4+ICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsKPj4+PiBAQCAtNjA3LDUyICs2MTEsNjQgQEAgc3RhdGljIGludCAKPj4+PiB2
aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+
ICAgICAgICAgICBndXBfZmxhZ3MgfD0gRk9MTF9XUklURTsKPj4+PiAgICAgICAgIG5wYWdlcyA9
IFBBR0VfQUxJR04obXNnLT5zaXplICsgKGlvdmEgJiB+UEFHRV9NQVNLKSkgPj4gCj4+Pj4gUEFH
RV9TSElGVDsKPj4+PiAtICAgIGlmICghbnBhZ2VzKQo+Pj4+IC0gICAgICAgIHJldHVybiAtRUlO
VkFMOwo+Pj4+ICsgICAgaWYgKCFucGFnZXMpIHsKPj4+PiArICAgICAgICByZXQgPSAtRUlOVkFM
Owo+Pj4+ICsgICAgICAgIGdvdG8gZnJlZTsKPj4+PiArICAgIH0KPj4+PiAgICAgICAgIG1tYXBf
cmVhZF9sb2NrKGRldi0+bW0pOwo+Pj4+ICAgLSAgICBsb2NrZWQgPSBhdG9taWM2NF9hZGRfcmV0
dXJuKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4gICAgICAgbG9ja19saW1pdCA9
IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsKPj4+PiAtCj4+Pj4gLSAgICBp
ZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+Pj4+ICsgICAgaWYgKG5wYWdlcyArIGF0b21pYzY0
X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0KSB7Cj4+Pj4gICAgICAgICAg
IHJldCA9IC1FTk9NRU07Cj4+Pj4gLSAgICAgICAgZ290byBvdXQ7Cj4+Pj4gKyAgICAgICAgZ290
byB1bmxvY2s7Cj4+Pj4gICAgICAgfQo+Pj4+ICAgICAgICAgY3VyX2Jhc2UgPSBtc2ctPnVhZGRy
ICYgUEFHRV9NQVNLOwo+Pj4+ICAgICAgIGlvdmEgJj0gUEFHRV9NQVNLOwo+Pj4+ICsgICAgbmNo
dW5rcyA9IDA7Cj4+Pj4gICAgICAgICB3aGlsZSAobnBhZ2VzKSB7Cj4+Pj4gLSAgICAgICAgcGlu
bmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+Pj4+IC0gICAg
ICAgIHJldCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBwaW5uZWQsCj4+Pj4gLSAgICAgICAg
ICAgICAgICAgICAgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4+PiAtICAgICAgICBp
ZiAocmV0ICE9IHBpbm5lZCkKPj4+PiArICAgICAgICBzejJwaW4gPSBtaW5fdCh1bnNpZ25lZCBs
b25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4+Pj4gKyAgICAgICAgcGlubmVkID0gcGluX3VzZXJf
cGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPj4+PiArICAgICAgICAgICAgICAgICAgICBndXBfZmxh
Z3MsIHBhZ2VfbGlzdCwgTlVMTCk7Cj4+Pj4gKyAgICAgICAgaWYgKHN6MnBpbiAhPSBwaW5uZWQp
IHsKPj4+PiArICAgICAgICAgICAgaWYgKHBpbm5lZCA8IDApIHsKPj4+PiArICAgICAgICAgICAg
ICAgIHJldCA9IHBpbm5lZDsKPj4+PiArICAgICAgICAgICAgfSBlbHNlIHsKPj4+PiArICAgICAg
ICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMocGFnZV9saXN0LCBwaW5uZWQpOwo+Pj4+ICsgICAg
ICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPj4+PiArICAgICAgICAgICAgfQo+Pj4+ICAgICAg
ICAgICAgICAgZ290byBvdXQ7Cj4+Pj4gKyAgICAgICAgfQo+Pj4+ICsgICAgICAgIG5jaHVua3Mr
KzsKPj4+PiAgICAgICAgICAgICBpZiAoIWxhc3RfcGZuKQo+Pj4+ICAgICAgICAgICAgICAgbWFw
X3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4+Pj4gICAtICAgICAgICBmb3IgKGkg
PSAwOyBpIDwgcmV0OyBpKyspIHsKPj4+PiArICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGlubmVk
OyBpKyspIHsKPj4+PiAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBwYWdl
X3RvX3BmbihwYWdlX2xpc3RbaV0pOwo+Pj4+ICAgICAgICAgICAgICAgdTY0IGNzaXplOwo+Pj4+
ICAgICAgICAgICAgICAgICBpZiAobGFzdF9wZm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsg
MSkpIHsKPj4+PiAgICAgICAgICAgICAgICAgICAvKiBQaW4gYSBjb250aWd1b3VzIGNodW5rIG9m
IG1lbW9yeSAqLwo+Pj4+ICAgICAgICAgICAgICAgICAgIGNzaXplID0gKGxhc3RfcGZuIC0gbWFw
X3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4+Pj4gLSAgICAgICAgICAgICAgICBpZiAodmhvc3Rf
dmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
bXNnLT5wZXJtKSkKPj4+PiArICAgICAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfbWFwKHYs
IGlvdmEsIGNzaXplLAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4g
PDwgUEFHRV9TSElGVCwKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ctPnBl
cm0pOwo+Pj4+ICsgICAgICAgICAgICAgICAgaWYgKHJldCkKPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7Cj4+Pj4gKwo+Pj4+ICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPSB0
aGlzX3BmbjsKPj4+PiAgICAgICAgICAgICAgICAgICBpb3ZhICs9IGNzaXplOwo+Pj4+ICsgICAg
ICAgICAgICAgICAgbmNodW5rcyA9IDA7Cj4+Pj4gICAgICAgICAgICAgICB9Cj4+Pj4gICAgICAg
ICAgICAgICAgIGxhc3RfcGZuID0gdGhpc19wZm47Cj4+Pj4gICAgICAgICAgIH0KPj4+PiAgIC0g
ICAgICAgIGN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+Pj4+IC0gICAgICAgIG5wYWdl
cyAtPSByZXQ7Cj4+Pj4gKyAgICAgICAgY3VyX2Jhc2UgKz0gcGlubmVkIDw8IFBBR0VfU0hJRlQ7
Cj4+Pj4gKyAgICAgICAgbnBhZ2VzIC09IHBpbm5lZDsKPj4+PiAgICAgICB9Cj4+Pj4gICAgICAg
ICAvKiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPj4+PiBAQCAtNjYwLDEwICs2NzYsMjIgQEAgc3Rh
dGljIGludCAKPj4+PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9z
dF92ZHBhICp2LAo+Pj4+ICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
IG1zZy0+cGVybSk7Cj4+Pj4gICBvdXQ6Cj4+Pj4gICAgICAgaWYgKHJldCkgewo+Pj4+ICsgICAg
ICAgIGlmIChuY2h1bmtzICYmIGxhc3RfcGZuKSB7Cj4+Pgo+Pj4KPj4+IENhbiB3ZSBkZWNyZWFz
ZSBucGFnZXMgd2hlcmUgeW91IGRpZCAibmNodW5rcysrIiB0aGVuIHdlIGNhbiBjaGVjayAKPj4+
IG5wYWdlcyBoZXJlIGluc3RlYWQ/Cj4+IEhtbW0sIEkgYW0gbm90IHN1cmUgSSBnZXQgd2hhdCB5
b3Ugd2FudC4uLiBAbmNodW5rcyBnZXRzIHJlc2V0IHRvIDAgCj4+IHdoZW5ldmVyIGEgY2VydGFp
biByYW5nZSBvZiBwaW5uZWQgcGFnZXMgaXMgc3VjY2Vzc2Z1bGx5IG1hcHBlZC4gVGhlIAo+PiBj
b25kaXRpb25hbCAod2hlbiBuY2h1bmtzIGlzIG5vbi16ZXJvKSBoZXJlIGluZGljYXRlcyBpZiB0
aGVyZSdzIGFueSAKPj4gX291dHN0YW5kaW5nXyBwaW5uZWQgcGFnZSB0aGF0IGhhcyB0byBjbGVh
biB1cCBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgCj4+IHBhdGguIFdoaWxlIHRoZSBkZWNyZW1lbnQg
b2YgQG5wYWdlcyBtYXkgbm90IG9jY3VyIHdoZW4gcmVzZXR0aW5nIHRoZSAKPj4gQG5jaHVua3Mg
Y291bnRlciwgcmVuZGVyaW5nIGluY29ycmVjdCBjbGVhbnVwIGluIHRoZSBlcnJvciBwYXRoLgo+
Cj4KPiBZZXMsIEkgbWVhbnQgZSBjYW4gZGVjcmVhc2UgbnBhZ2VzIHdoZXJlIHlvdSBkaWQgIm5j
aHVua3MrKyIuIEFueWhvdywgCj4gaXQncyBqdXN0IGEgb3B0aW1pemF0aW9uIHRvIGF2b2lkIGEg
bG9jYWwgdmFyaWFibGUgd2hpY2ggaXMgbm90IGEgbXVzdC4KClRvIG1lIHRoYXQgb3Bwb3J0dW5p
dHkgZG9lc24ndCBleGlzdC4gQG5jaHVua3MgYW5kIEBucGFnZXMgdHJhY2sgCmRpZmZlcmVudCBr
aW5kIG9mIHRoaW5ncy4gQG5wYWdlcyBpcyBub3QgaW50ZXJjaGFuZ2VhYmxlIHRvIHJlcHJlc2Vu
dCAKYWxsIHBvc3NpYmxlIGVycm9yIGNhc2VzLgoKLVNpd2VpCgo+Cj4KPj4KPj4gQlRXIHdoaWxl
IHJldmlld2luZyBpdCBJIGdvdCBub3RpY2VkIG9mIGFuIGVycm9yIGluIG15IGNvZGUuIFRoZXJl
IAo+PiBtaWdodCBiZSBzdGlsbCBwYWdlIHBpbm5pbmcgbGVhayBmcm9tIHdoZXJldmVyIHRoZSB2
aG9zdF92ZHBhX21hcCgpIAo+PiBlcnJvciBvY2N1cnMgdG93YXJkcyB0aGUgZW5kIG9mIHBhZ2Vf
bGlzdC4gSSB3aWxsIHBvc3QgYSB2MiB0byBmaXggdGhpcy4KPj4KPgo+IFN1cmUsIHdpbGwgcmV2
aWV3Lgo+Cj4gVGhhbmtzCj4KPgo+PiBSZWdhcmRzLAo+PiAtU2l3ZWkKPj4KPj4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gQEAgLTY1
Niw4ICs2NTYsMTkgQEAgc3RhdGljIGludCAKPj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3Vw
ZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSB2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IAo+PiBQ
QUdFX1NISUZULAo+PiBtc2ctPnBlcm0pOwo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChyZXQpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkg
ewo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyoKPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFVucGluIHRoZSBwYWdlcyB0aGF0
IGFyZSAKPj4gbGVmdCB1bm1hcHBlZAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICogZnJvbSB0aGlzIHBvaW50IG9uIGluIHRoZSAKPj4gY3VycmVudAo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogcGFnZV9saXN0LiBUaGUgcmVt
YWluaW5nIAo+PiBvdXRzdGFuZGluZwo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICogb25lcyB3aGljaCBtYXkgc3RyaWRlIAo+PiBhY3Jvc3Mgc2V2ZXJhbAo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogY2h1bmtzIHdpbGwgYmUg
Y292ZXJlZCBpbiAKPj4gdGhlIGNvbW1vbgo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICogZXJyb3IgcGF0aCBzdWJzZXF1ZW50bHkuCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KPj4gKyB1bnBpbl91c2VyX3BhZ2VzKCZwYWdl
X2xpc3RbaV0sCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBpbm5lZCAtIGkpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fQo+Pgo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPSB0aGlzX3Bm
bjsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3ZhICs9IGNzaXplOwo+Pgo+
Pgo+Pgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4gKyAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgcGZuOwo+Pj4+ICsKPj4+PiArICAgICAgICAgICAgLyoKPj4+PiArICAgICAgICAgICAgICog
VW5waW4gdGhlIG91dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB1bm1hcHBlZC4KPj4+PiArICAg
ICAgICAgICAgICogTWFwcGVkIHBhZ2VzIGFyZSBhY2NvdW50ZWQgaW4gdmRwYV9tYXAoKSwgdGh1
cwo+Pj4+ICsgICAgICAgICAgICAgKiB3aWxsIGJlIGhhbmRsZWQgYnkgdmRwYV91bm1hcCgpLgo+
Pj4+ICsgICAgICAgICAgICAgKi8KPj4+PiArICAgICAgICAgICAgZm9yIChwZm4gPSBtYXBfcGZu
OyBwZm4gPD0gbGFzdF9wZm47IHBmbisrKQo+Pj4+ICsgICAgICAgICAgICAgICAgdW5waW5fdXNl
cl9wYWdlKHBmbl90b19wYWdlKHBmbikpOwo+Pj4+ICsgICAgICAgIH0KPj4+PiAgICAgICAgICAg
dmhvc3RfdmRwYV91bm1hcCh2LCBtc2ctPmlvdmEsIG1zZy0+c2l6ZSk7Cj4+Pj4gLSAgICAgICAg
YXRvbWljNjRfc3ViKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4gICAgICAgfQo+
Pj4+ICt1bmxvY2s6Cj4+Pj4gICAgICAgbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPj4+PiAr
ZnJlZToKPj4+PiAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPj4+
PiAgICAgICByZXR1cm4gcmV0Owo+Pj4+ICAgfQo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
