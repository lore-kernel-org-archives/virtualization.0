Return-Path: <SRS0=WAh4=EZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028EC63777
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 23:27:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ECF2145D
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 23:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mGJCAiog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ECF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F42886C63;
	Thu, 19 Nov 2020 23:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGxVPM1yBHvY; Thu, 19 Nov 2020 23:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 678B086C59;
	Thu, 19 Nov 2020 23:27:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 463B3C163C;
	Thu, 19 Nov 2020 23:27:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB3F0C0891
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 23:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B8DF685CE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 23:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6pb4MU7r8yQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 23:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C641E85B5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 23:26:57 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNKk9c041578;
 Thu, 19 Nov 2020 23:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cRZ4sWIQ4ARfaY4GL/Fi7waJEAavuIeLP3xVj8Jeq/U=;
 b=mGJCAiog9q3yVuAL1SKbToknStZJ9y72yRFFLxeswT3fAbCTSt9QlMRRGeph+RznNQ5H
 zt9KA9x8FrF2X9/qdG188byMFva3Zxbr97/yfXQGm1PDtOdFeVPYNhNMtw7V0/e19UKw
 pCxS6S5k/bHmUAFVL0rPU6Nv3JiCcqhjgkN5bd3cBQARj+I2BwAlTzVdRUYPhRii17kc
 tHbp3tcK1BiaLxyRygQIcFwmhcpHnbEl+lGK59Gk9kaiFINTFlDsrTlQlA4bAuN9+dIc
 9gVSv2JBiJ/FIN9tgbP5oHROyPpwkgkC4tDpXHU6uhS1t0SbLYRR6k+i3EdxEBhOmjrD ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 34t76m88qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Nov 2020 23:26:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNJaoc156300;
 Thu, 19 Nov 2020 23:26:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 34ts0uf37a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2020 23:26:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJNQqnf031042;
 Thu, 19 Nov 2020 23:26:53 GMT
Received: from [10.159.241.144] (/10.159.241.144)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 19 Nov 2020 15:26:52 -0800
Message-ID: <5FB6FF3A.6060005@oracle.com>
Date: Thu, 19 Nov 2020 15:26:50 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: mst@redhat.com
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
 <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
In-Reply-To: <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=3 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190160
Cc: lingshan.zhu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com
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

QSBnZW50bGUgcmVtaW5kZXIuIEFueSBjaGFuY2UgdGhpcyBwYXRjaCB3aWxsIGdldCBwaWNrZWQg
c29vbj8KClRoYW5rcywKLVNpd2VpCgpPbiAxMS85LzIwMjAgNzoyOCBQTSwgSmFzb24gV2FuZyB3
cm90ZToKPgo+IE9uIDIwMjAvMTEvNiDkuIrljYg3OjI2LCBTaS1XZWkgTGl1IHdyb3RlOgo+PiBQ
aW5uZWQgcGFnZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50ZWQgcGFydGljdWxhcmx5IHdoZW4K
Pj4gbWFwcGluZyBlcnJvciBvY2N1cnMgb24gSU9UTEIgdXBkYXRlLiBDbGVhbiB1cCBkYW5nbGlu
Zwo+PiBwaW5uZWQgcGFnZXMgZm9yIHRoZSBlcnJvciBwYXRoLgo+Pgo+PiBUaGUgbWVtb3J5IHVz
YWdlIGZvciBib29ra2VlcGluZyBwaW5uZWQgcGFnZXMgaXMgcmV2ZXJ0ZWQKPj4gdG8gd2hhdCBp
dCB3YXMgYmVmb3JlOiBvbmx5IG9uZSBzaW5nbGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPj4gVGhp
cyBoZWxwcyByZWR1Y2UgdGhlIGhvc3QgbWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdl
Cj4+IGFtb3VudCBvZiBtZW1vcnksIG9yIGluIHRoZSBzaXR1YXRpb24gd2hlcmUgaG9zdCBpcyBy
dW5uaW5nCj4+IHNob3J0IG9mIGZyZWUgbWVtb3J5Lgo+Pgo+PiBGaXhlczogNGM4Y2YzMTg4NWY2
ICgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2VkIGJhY2tlbmQiKQo+PiBTaWduZWQtb2ZmLWJ5
OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiBDaGFuZ2VzIGlu
IHYzOgo+PiAtIFR1cm4gZXhwbGljaXQgbGFzdF9wZm4gY2hlY2sgdG8gYSBXQVJOX09OKCkgKEph
c29uKQo+Pgo+PiBDaGFuZ2VzIGluIHYyOgo+PiAtIERyb3AgdGhlIHJldmVyc2lvbiBwYXRjaAo+
PiAtIEZpeCB1bmhhbmRsZWQgcGFnZSBsZWFrIHRvd2FyZHMgdGhlIGVuZCBvZiBwYWdlX2xpc3QK
Pgo+Cj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4KPiBUaGFu
a3MKPgo+Cj4+Cj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA4MCAKPj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCA2MiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gaW5kZXggYjZk
OTAxNi4uNWIxM2RmZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gQEAgLTU2MCw2ICs1NjAsOCBAQCBzdGF0aWMgaW50
IHZob3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICAgIGlmIChyKQo+
PiAgICAgICAgICAgdmhvc3RfaW90bGJfZGVsX3JhbmdlKGRldi0+aW90bGIsIGlvdmEsIGlvdmEg
KyBzaXplIC0gMSk7Cj4+ICsgICAgZWxzZQo+PiArICAgICAgICBhdG9taWM2NF9hZGQoc2l6ZSA+
PiBQQUdFX1NISUZULCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4gICAgICAgICByZXR1cm4gcjsK
Pj4gICB9Cj4+IEBAIC01OTEsMTQgKzU5MywxNiBAQCBzdGF0aWMgaW50IAo+PiB2aG9zdF92ZHBh
X3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICB1bnNp
Z25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsK
Pj4gICAgICAgdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9OR1RFUk07Cj4+ICAgICAg
IHVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3BmbiwgbGFzdF9wZm4gPSAwOwo+
PiAtICAgIHVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0LCBwaW5uZWQsIGk7Cj4+ICsg
ICAgdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3MsIGk7Cj4+ICAgICAg
IHU2NCBpb3ZhID0gbXNnLT5pb3ZhOwo+PiArICAgIGxvbmcgcGlubmVkOwo+PiAgICAgICBpbnQg
cmV0ID0gMDsKPj4gICAgICAgICBpZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIsIG1z
Zy0+aW92YSwKPj4gICAgICAgICAgICAgICAgICAgICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAt
IDEpKQo+PiAgICAgICAgICAgcmV0dXJuIC1FRVhJU1Q7Cj4+ICAgKyAgICAvKiBMaW1pdCB0aGUg
dXNlIG9mIG1lbW9yeSBmb3IgYm9va2tlZXBpbmcgKi8KPj4gICAgICAgcGFnZV9saXN0ID0gKHN0
cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7Cj4+ICAgICAgIGlmICgh
cGFnZV9saXN0KQo+PiAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4+IEBAIC02MDcsNTIgKzYx
MSw3NSBAQCBzdGF0aWMgaW50IAo+PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0
cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICAgICAgZ3VwX2ZsYWdzIHw9IEZPTExfV1JJVEU7
Cj4+ICAgICAgICAgbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAoaW92YSAmIH5QQUdF
X01BU0spKSA+PiAKPj4gUEFHRV9TSElGVDsKPj4gLSAgICBpZiAoIW5wYWdlcykKPj4gLSAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsgICAgaWYgKCFucGFnZXMpIHsKPj4gKyAgICAgICAgcmV0
ID0gLUVJTlZBTDsKPj4gKyAgICAgICAgZ290byBmcmVlOwo+PiArICAgIH0KPj4gICAgICAgICBt
bWFwX3JlYWRfbG9jayhkZXYtPm1tKTsKPj4gICAtICAgIGxvY2tlZCA9IGF0b21pYzY0X2FkZF9y
ZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4gICAgICAgbG9ja19saW1pdCA9
IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsKPj4gLQo+PiAtICAgIGlmIChs
b2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4+ICsgICAgaWYgKG5wYWdlcyArIGF0b21pYzY0X3JlYWQo
JmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0KSB7Cj4+ICAgICAgICAgICByZXQgPSAt
RU5PTUVNOwo+PiAtICAgICAgICBnb3RvIG91dDsKPj4gKyAgICAgICAgZ290byB1bmxvY2s7Cj4+
ICAgICAgIH0KPj4gICAgICAgICBjdXJfYmFzZSA9IG1zZy0+dWFkZHIgJiBQQUdFX01BU0s7Cj4+
ICAgICAgIGlvdmEgJj0gUEFHRV9NQVNLOwo+PiArICAgIG5jaHVua3MgPSAwOwo+PiAgICAgICAg
IHdoaWxlIChucGFnZXMpIHsKPj4gLSAgICAgICAgcGlubmVkID0gbWluX3QodW5zaWduZWQgbG9u
ZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+PiAtICAgICAgICByZXQgPSBwaW5fdXNlcl9wYWdlcyhj
dXJfYmFzZSwgcGlubmVkLAo+PiAtICAgICAgICAgICAgICAgICAgICAgZ3VwX2ZsYWdzLCBwYWdl
X2xpc3QsIE5VTEwpOwo+PiAtICAgICAgICBpZiAocmV0ICE9IHBpbm5lZCkKPj4gKyAgICAgICAg
c3oycGluID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+PiArICAg
ICAgICBwaW5uZWQgPSBwaW5fdXNlcl9wYWdlcyhjdXJfYmFzZSwgc3oycGluLAo+PiArICAgICAg
ICAgICAgICAgICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVMTCk7Cj4+ICsgICAgICAgIGlm
IChzejJwaW4gIT0gcGlubmVkKSB7Cj4+ICsgICAgICAgICAgICBpZiAocGlubmVkIDwgMCkgewo+
PiArICAgICAgICAgICAgICAgIHJldCA9IHBpbm5lZDsKPj4gKyAgICAgICAgICAgIH0gZWxzZSB7
Cj4+ICsgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlcyhwYWdlX2xpc3QsIHBpbm5lZCk7
Cj4+ICsgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPj4gKyAgICAgICAgICAgIH0KPj4g
ICAgICAgICAgICAgICBnb3RvIG91dDsKPj4gKyAgICAgICAgfQo+PiArICAgICAgICBuY2h1bmtz
Kys7Cj4+ICAgICAgICAgICAgIGlmICghbGFzdF9wZm4pCj4+ICAgICAgICAgICAgICAgbWFwX3Bm
biA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4+ICAgLSAgICAgICAgZm9yIChpID0gMDsg
aSA8IHJldDsgaSsrKSB7Cj4+ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwaW5uZWQ7IGkrKykg
ewo+PiAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBwYWdlX3RvX3Bmbihw
YWdlX2xpc3RbaV0pOwo+PiAgICAgICAgICAgICAgIHU2NCBjc2l6ZTsKPj4gICAgICAgICAgICAg
ICAgIGlmIChsYXN0X3BmbiAmJiAodGhpc19wZm4gIT0gbGFzdF9wZm4gKyAxKSkgewo+PiAgICAg
ICAgICAgICAgICAgICAvKiBQaW4gYSBjb250aWd1b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+PiAg
ICAgICAgICAgICAgICAgICBjc2l6ZSA9IChsYXN0X3BmbiAtIG1hcF9wZm4gKyAxKSA8PCBQQUdF
X1NISUZUOwo+PiAtICAgICAgICAgICAgICAgIGlmICh2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBj
c2l6ZSwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElG
VCwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSkpCj4+ICsgICAgICAg
ICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNnLT5wZXJtKTsKPj4gKyAgICAgICAgICAgICAgICBpZiAo
cmV0KSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgIC8qCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAqIFVucGluIHRoZSBwYWdlcyB0aGF0IGFyZSBsZWZ0IHVubWFwcGVkCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAqIGZyb20gdGhpcyBwb2ludCBvbiBpbiB0aGUgY3VycmVudAo+PiArICAgICAg
ICAgICAgICAgICAgICAgKiBwYWdlX2xpc3QuIFRoZSByZW1haW5pbmcgb3V0c3RhbmRpbmcKPj4g
KyAgICAgICAgICAgICAgICAgICAgICogb25lcyB3aGljaCBtYXkgc3RyaWRlIGFjcm9zcyBzZXZl
cmFsCj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGNodW5rcyB3aWxsIGJlIGNvdmVyZWQgaW4g
dGhlIGNvbW1vbgo+PiArICAgICAgICAgICAgICAgICAgICAgKiBlcnJvciBwYXRoIHN1YnNlcXVl
bnRseS4KPj4gKyAgICAgICAgICAgICAgICAgICAgICovCj4+ICsgICAgICAgICAgICAgICAgICAg
IHVucGluX3VzZXJfcGFnZXMoJnBhZ2VfbGlzdFtpXSwKPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGlubmVkIC0gaSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsK
Pj4gKyAgICAgICAgICAgICAgICB9Cj4+ICsKPj4gICAgICAgICAgICAgICAgICAgbWFwX3BmbiA9
IHRoaXNfcGZuOwo+PiAgICAgICAgICAgICAgICAgICBpb3ZhICs9IGNzaXplOwo+PiArICAgICAg
ICAgICAgICAgIG5jaHVua3MgPSAwOwo+PiAgICAgICAgICAgICAgIH0KPj4gICAgICAgICAgICAg
ICAgIGxhc3RfcGZuID0gdGhpc19wZm47Cj4+ICAgICAgICAgICB9Cj4+ICAgLSAgICAgICAgY3Vy
X2Jhc2UgKz0gcmV0IDw8IFBBR0VfU0hJRlQ7Cj4+IC0gICAgICAgIG5wYWdlcyAtPSByZXQ7Cj4+
ICsgICAgICAgIGN1cl9iYXNlICs9IHBpbm5lZCA8PCBQQUdFX1NISUZUOwo+PiArICAgICAgICBu
cGFnZXMgLT0gcGlubmVkOwo+PiAgICAgICB9Cj4+ICAgICAgICAgLyogUGluIHRoZSByZXN0IGNo
dW5rICovCj4+IEBAIC02NjAsMTAgKzY4NywyNyBAQCBzdGF0aWMgaW50IAo+PiB2aG9zdF92ZHBh
X3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICAgICAg
ICAgICAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ctPnBlcm0pOwo+PiAgIG91dDoKPj4g
ICAgICAgaWYgKHJldCkgewo+PiArICAgICAgICBpZiAobmNodW5rcykgewo+PiArICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyBwZm47Cj4+ICsKPj4gKyAgICAgICAgICAgIC8qCj4+ICsgICAgICAg
ICAgICAgKiBVbnBpbiB0aGUgb3V0c3RhbmRpbmcgcGFnZXMgd2hpY2ggYXJlIHlldCB0byBiZQo+
PiArICAgICAgICAgICAgICogbWFwcGVkIGJ1dCBoYXZlbid0IGR1ZSB0byB2ZHBhX21hcCgpIG9y
Cj4+ICsgICAgICAgICAgICAgKiBwaW5fdXNlcl9wYWdlcygpIGZhaWx1cmUuCj4+ICsgICAgICAg
ICAgICAgKgo+PiArICAgICAgICAgICAgICogTWFwcGVkIHBhZ2VzIGFyZSBhY2NvdW50ZWQgaW4g
dmRwYV9tYXAoKSwgaGVuY2UKPj4gKyAgICAgICAgICAgICAqIHRoZSBjb3JyZXNwb25kaW5nIHVu
cGlubmluZyB3aWxsIGJlIGhhbmRsZWQgYnkKPj4gKyAgICAgICAgICAgICAqIHZkcGFfdW5tYXAo
KS4KPj4gKyAgICAgICAgICAgICAqLwo+PiArICAgICAgICAgICAgV0FSTl9PTighbGFzdF9wZm4p
Owo+PiArICAgICAgICAgICAgZm9yIChwZm4gPSBtYXBfcGZuOyBwZm4gPD0gbGFzdF9wZm47IHBm
bisrKQo+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZShwZm5fdG9fcGFnZShwZm4p
KTsKPj4gKyAgICAgICAgfQo+PiAgICAgICAgICAgdmhvc3RfdmRwYV91bm1hcCh2LCBtc2ctPmlv
dmEsIG1zZy0+c2l6ZSk7Cj4+IC0gICAgICAgIGF0b21pYzY0X3N1YihucGFnZXMsICZkZXYtPm1t
LT5waW5uZWRfdm0pOwo+PiAgICAgICB9Cj4+ICt1bmxvY2s6Cj4+ICAgICAgIG1tYXBfcmVhZF91
bmxvY2soZGV2LT5tbSk7Cj4+ICtmcmVlOgo+PiAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxv
bmcpcGFnZV9saXN0KTsKPj4gICAgICAgcmV0dXJuIHJldDsKPj4gICB9Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
