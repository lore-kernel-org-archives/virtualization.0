Return-Path: <SRS0=rWzq=EQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A10C388F7
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 22:41:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E3D2068D
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 22:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pMkkDUkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E3D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 55560854D8;
	Tue, 10 Nov 2020 22:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Y0uWeUDj5wF; Tue, 10 Nov 2020 22:41:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8330F86193;
	Tue, 10 Nov 2020 22:41:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD66C0889;
	Tue, 10 Nov 2020 22:41:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3F76C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 22:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A7A585F5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 22:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vu0cPaq14ZUn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 22:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66C4485F59
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 22:41:28 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAMO5p1181197;
 Tue, 10 Nov 2020 22:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FVCQcCo87X80CoZYT8TN01W7K5ekGpE6EM5jmtpOA7E=;
 b=pMkkDUkn8uZfq7l4l/+yCxAv2SkLqthgfiyKE0N1xYEAE1Hk3r8bGCjh3zPDCbVODVUb
 oSckiMo8nwdbXcsUwNDDeKVc0dYa59Ckl8I9bNSlu/v7Necakpvboe/BOzUNwdtmAcUq
 M47h66RL/FV9bdpEaRpZsoqUEFJDmhO3cvq898KlJz517iM9+M9wx3i+Y/WPP3YbMiLv
 Kt6CFiDnRW614Rnb2YZNh9Alq3hycnL++2cEtYfYuobAuVEk/hY65eBwZR+ImqCaJxVR
 HajpIjQ7YmlM2rHDmhmngDlr/Z3XvUiJoOwfFrOxr8Mi6BH82e27bMIgVUeG0KQ8aGce Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 34nh3axje2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Nov 2020 22:41:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAMPEL3125672;
 Tue, 10 Nov 2020 22:41:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 34p55p7nn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Nov 2020 22:41:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAMfOJh009538;
 Tue, 10 Nov 2020 22:41:24 GMT
Received: from [10.159.244.182] (/10.159.244.182)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Nov 2020 14:41:23 -0800
Message-ID: <5FAB1712.3010405@oracle.com>
Date: Tue, 10 Nov 2020 14:41:22 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, lingshan.zhu@intel.com
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
 <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
In-Reply-To: <9e4b0cda-8118-0ed0-7a27-5d284c49f936@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100151
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

Ck9uIDExLzkvMjAyMCA3OjI4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMS82
IOS4iuWNiDc6MjYsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFBpbm5lZCBwYWdlcyBhcmUgbm90IHBy
b3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+PiBtYXBwaW5nIGVycm9yIG9jY3Vy
cyBvbiBJT1RMQiB1cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4+IHBpbm5lZCBwYWdlcyBmb3Ig
dGhlIGVycm9yIHBhdGguCj4+Cj4+IFRoZSBtZW1vcnkgdXNhZ2UgZm9yIGJvb2trZWVwaW5nIHBp
bm5lZCBwYWdlcyBpcyByZXZlcnRlZAo+PiB0byB3aGF0IGl0IHdhcyBiZWZvcmU6IG9ubHkgb25l
IHNpbmdsZSBmcmVlIHBhZ2UgaXMgbmVlZGVkLgo+PiBUaGlzIGhlbHBzIHJlZHVjZSB0aGUgaG9z
dCBtZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPj4gYW1vdW50IG9mIG1lbW9yeSwg
b3IgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZSBob3N0IGlzIHJ1bm5pbmcKPj4gc2hvcnQgb2YgZnJl
ZSBtZW1vcnkuCj4+Cj4+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZE
UEEtYmFzZWQgYmFja2VuZCIpCj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+IENoYW5nZXMgaW4gdjM6Cj4+IC0gVHVybiBleHBsaWNp
dCBsYXN0X3BmbiBjaGVjayB0byBhIFdBUk5fT04oKSAoSmFzb24pCj4+Cj4+IENoYW5nZXMgaW4g
djI6Cj4+IC0gRHJvcCB0aGUgcmV2ZXJzaW9uIHBhdGNoCj4+IC0gRml4IHVuaGFuZGxlZCBwYWdl
IGxlYWsgdG93YXJkcyB0aGUgZW5kIG9mIHBhZ2VfbGlzdAo+Cj4KPiBBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPgo+IFRoYW5rcwo+CgpUaGFua3MgSmFzb24gZm9y
IHlvdXIgcmV2aWV3IQoKCi1TaXdlaQo+Cj4+Cj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA4
MCAKPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPj4gaW5kZXggYjZkOTAxNi4uNWIxM2RmZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92
aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gQEAgLTU2MCw2ICs1
NjAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+
PiAgICAgICAgIGlmIChyKQo+PiAgICAgICAgICAgdmhvc3RfaW90bGJfZGVsX3JhbmdlKGRldi0+
aW90bGIsIGlvdmEsIGlvdmEgKyBzaXplIC0gMSk7Cj4+ICsgICAgZWxzZQo+PiArICAgICAgICBh
dG9taWM2NF9hZGQoc2l6ZSA+PiBQQUdFX1NISUZULCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4g
ICAgICAgICByZXR1cm4gcjsKPj4gICB9Cj4+IEBAIC01OTEsMTQgKzU5MywxNiBAQCBzdGF0aWMg
aW50IAo+PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LAo+PiAgICAgICB1bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVv
ZihzdHJ1Y3QgcGFnZSAqKTsKPj4gICAgICAgdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExf
TE9OR1RFUk07Cj4+ICAgICAgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3Bm
biwgbGFzdF9wZm4gPSAwOwo+PiAtICAgIHVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0
LCBwaW5uZWQsIGk7Cj4+ICsgICAgdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5j
aHVua3MsIGk7Cj4+ICAgICAgIHU2NCBpb3ZhID0gbXNnLT5pb3ZhOwo+PiArICAgIGxvbmcgcGlu
bmVkOwo+PiAgICAgICBpbnQgcmV0ID0gMDsKPj4gICAgICAgICBpZiAodmhvc3RfaW90bGJfaXRy
ZWVfZmlyc3QoaW90bGIsIG1zZy0+aW92YSwKPj4gICAgICAgICAgICAgICAgICAgICAgIG1zZy0+
aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+PiAgICAgICAgICAgcmV0dXJuIC1FRVhJU1Q7Cj4+ICAg
KyAgICAvKiBMaW1pdCB0aGUgdXNlIG9mIG1lbW9yeSBmb3IgYm9va2tlZXBpbmcgKi8KPj4gICAg
ICAgcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5F
TCk7Cj4+ICAgICAgIGlmICghcGFnZV9saXN0KQo+PiAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
Cj4+IEBAIC02MDcsNTIgKzYxMSw3NSBAQCBzdGF0aWMgaW50IAo+PiB2aG9zdF92ZHBhX3Byb2Nl
c3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICAgICAgZ3VwX2Zs
YWdzIHw9IEZPTExfV1JJVEU7Cj4+ICAgICAgICAgbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNp
emUgKyAoaW92YSAmIH5QQUdFX01BU0spKSA+PiAKPj4gUEFHRV9TSElGVDsKPj4gLSAgICBpZiAo
IW5wYWdlcykKPj4gLSAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsgICAgaWYgKCFucGFnZXMp
IHsKPj4gKyAgICAgICAgcmV0ID0gLUVJTlZBTDsKPj4gKyAgICAgICAgZ290byBmcmVlOwo+PiAr
ICAgIH0KPj4gICAgICAgICBtbWFwX3JlYWRfbG9jayhkZXYtPm1tKTsKPj4gICAtICAgIGxvY2tl
ZCA9IGF0b21pYzY0X2FkZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4g
ICAgICAgbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsK
Pj4gLQo+PiAtICAgIGlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4+ICsgICAgaWYgKG5wYWdl
cyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0KSB7Cj4+
ICAgICAgICAgICByZXQgPSAtRU5PTUVNOwo+PiAtICAgICAgICBnb3RvIG91dDsKPj4gKyAgICAg
ICAgZ290byB1bmxvY2s7Cj4+ICAgICAgIH0KPj4gICAgICAgICBjdXJfYmFzZSA9IG1zZy0+dWFk
ZHIgJiBQQUdFX01BU0s7Cj4+ICAgICAgIGlvdmEgJj0gUEFHRV9NQVNLOwo+PiArICAgIG5jaHVu
a3MgPSAwOwo+PiAgICAgICAgIHdoaWxlIChucGFnZXMpIHsKPj4gLSAgICAgICAgcGlubmVkID0g
bWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+PiAtICAgICAgICByZXQg
PSBwaW5fdXNlcl9wYWdlcyhjdXJfYmFzZSwgcGlubmVkLAo+PiAtICAgICAgICAgICAgICAgICAg
ICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+PiAtICAgICAgICBpZiAocmV0ICE9IHBp
bm5lZCkKPj4gKyAgICAgICAgc3oycGluID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBs
aXN0X3NpemUpOwo+PiArICAgICAgICBwaW5uZWQgPSBwaW5fdXNlcl9wYWdlcyhjdXJfYmFzZSwg
c3oycGluLAo+PiArICAgICAgICAgICAgICAgICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVM
TCk7Cj4+ICsgICAgICAgIGlmIChzejJwaW4gIT0gcGlubmVkKSB7Cj4+ICsgICAgICAgICAgICBp
ZiAocGlubmVkIDwgMCkgewo+PiArICAgICAgICAgICAgICAgIHJldCA9IHBpbm5lZDsKPj4gKyAg
ICAgICAgICAgIH0gZWxzZSB7Cj4+ICsgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlcyhw
YWdlX2xpc3QsIHBpbm5lZCk7Cj4+ICsgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPj4g
KyAgICAgICAgICAgIH0KPj4gICAgICAgICAgICAgICBnb3RvIG91dDsKPj4gKyAgICAgICAgfQo+
PiArICAgICAgICBuY2h1bmtzKys7Cj4+ICAgICAgICAgICAgIGlmICghbGFzdF9wZm4pCj4+ICAg
ICAgICAgICAgICAgbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4+ICAgLSAg
ICAgICAgZm9yIChpID0gMDsgaSA8IHJldDsgaSsrKSB7Cj4+ICsgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBwaW5uZWQ7IGkrKykgewo+PiAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdGhpc19w
Zm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbaV0pOwo+PiAgICAgICAgICAgICAgIHU2NCBjc2l6
ZTsKPj4gICAgICAgICAgICAgICAgIGlmIChsYXN0X3BmbiAmJiAodGhpc19wZm4gIT0gbGFzdF9w
Zm4gKyAxKSkgewo+PiAgICAgICAgICAgICAgICAgICAvKiBQaW4gYSBjb250aWd1b3VzIGNodW5r
IG9mIG1lbW9yeSAqLwo+PiAgICAgICAgICAgICAgICAgICBjc2l6ZSA9IChsYXN0X3BmbiAtIG1h
cF9wZm4gKyAxKSA8PCBQQUdFX1NISUZUOwo+PiAtICAgICAgICAgICAgICAgIGlmICh2aG9zdF92
ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1h
cF9wZm4gPDwgUEFHRV9TSElGVCwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+
cGVybSkpCj4+ICsgICAgICAgICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwg
Y3NpemUsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9T
SElGVCwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNnLT5wZXJtKTsKPj4gKyAg
ICAgICAgICAgICAgICBpZiAocmV0KSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgIC8qCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAqIFVucGluIHRoZSBwYWdlcyB0aGF0IGFyZSBsZWZ0IHVubWFw
cGVkCj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGZyb20gdGhpcyBwb2ludCBvbiBpbiB0aGUg
Y3VycmVudAo+PiArICAgICAgICAgICAgICAgICAgICAgKiBwYWdlX2xpc3QuIFRoZSByZW1haW5p
bmcgb3V0c3RhbmRpbmcKPj4gKyAgICAgICAgICAgICAgICAgICAgICogb25lcyB3aGljaCBtYXkg
c3RyaWRlIGFjcm9zcyBzZXZlcmFsCj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGNodW5rcyB3
aWxsIGJlIGNvdmVyZWQgaW4gdGhlIGNvbW1vbgo+PiArICAgICAgICAgICAgICAgICAgICAgKiBl
cnJvciBwYXRoIHN1YnNlcXVlbnRseS4KPj4gKyAgICAgICAgICAgICAgICAgICAgICovCj4+ICsg
ICAgICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMoJnBhZ2VfbGlzdFtpXSwKPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlubmVkIC0gaSk7Cj4+ICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIG91dDsKPj4gKyAgICAgICAgICAgICAgICB9Cj4+ICsKPj4gICAgICAgICAg
ICAgICAgICAgbWFwX3BmbiA9IHRoaXNfcGZuOwo+PiAgICAgICAgICAgICAgICAgICBpb3ZhICs9
IGNzaXplOwo+PiArICAgICAgICAgICAgICAgIG5jaHVua3MgPSAwOwo+PiAgICAgICAgICAgICAg
IH0KPj4gICAgICAgICAgICAgICAgIGxhc3RfcGZuID0gdGhpc19wZm47Cj4+ICAgICAgICAgICB9
Cj4+ICAgLSAgICAgICAgY3VyX2Jhc2UgKz0gcmV0IDw8IFBBR0VfU0hJRlQ7Cj4+IC0gICAgICAg
IG5wYWdlcyAtPSByZXQ7Cj4+ICsgICAgICAgIGN1cl9iYXNlICs9IHBpbm5lZCA8PCBQQUdFX1NI
SUZUOwo+PiArICAgICAgICBucGFnZXMgLT0gcGlubmVkOwo+PiAgICAgICB9Cj4+ICAgICAgICAg
LyogUGluIHRoZSByZXN0IGNodW5rICovCj4+IEBAIC02NjAsMTAgKzY4NywyNyBAQCBzdGF0aWMg
aW50IAo+PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LAo+PiAgICAgICAgICAgICAgICAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ctPnBl
cm0pOwo+PiAgIG91dDoKPj4gICAgICAgaWYgKHJldCkgewo+PiArICAgICAgICBpZiAobmNodW5r
cykgewo+PiArICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBwZm47Cj4+ICsKPj4gKyAgICAgICAg
ICAgIC8qCj4+ICsgICAgICAgICAgICAgKiBVbnBpbiB0aGUgb3V0c3RhbmRpbmcgcGFnZXMgd2hp
Y2ggYXJlIHlldCB0byBiZQo+PiArICAgICAgICAgICAgICogbWFwcGVkIGJ1dCBoYXZlbid0IGR1
ZSB0byB2ZHBhX21hcCgpIG9yCj4+ICsgICAgICAgICAgICAgKiBwaW5fdXNlcl9wYWdlcygpIGZh
aWx1cmUuCj4+ICsgICAgICAgICAgICAgKgo+PiArICAgICAgICAgICAgICogTWFwcGVkIHBhZ2Vz
IGFyZSBhY2NvdW50ZWQgaW4gdmRwYV9tYXAoKSwgaGVuY2UKPj4gKyAgICAgICAgICAgICAqIHRo
ZSBjb3JyZXNwb25kaW5nIHVucGlubmluZyB3aWxsIGJlIGhhbmRsZWQgYnkKPj4gKyAgICAgICAg
ICAgICAqIHZkcGFfdW5tYXAoKS4KPj4gKyAgICAgICAgICAgICAqLwo+PiArICAgICAgICAgICAg
V0FSTl9PTighbGFzdF9wZm4pOwo+PiArICAgICAgICAgICAgZm9yIChwZm4gPSBtYXBfcGZuOyBw
Zm4gPD0gbGFzdF9wZm47IHBmbisrKQo+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFn
ZShwZm5fdG9fcGFnZShwZm4pKTsKPj4gKyAgICAgICAgfQo+PiAgICAgICAgICAgdmhvc3RfdmRw
YV91bm1hcCh2LCBtc2ctPmlvdmEsIG1zZy0+c2l6ZSk7Cj4+IC0gICAgICAgIGF0b21pYzY0X3N1
YihucGFnZXMsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+PiAgICAgICB9Cj4+ICt1bmxvY2s6Cj4+
ICAgICAgIG1tYXBfcmVhZF91bmxvY2soZGV2LT5tbSk7Cj4+ICtmcmVlOgo+PiAgICAgICBmcmVl
X3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPj4gICAgICAgcmV0dXJuIHJldDsKPj4g
ICB9Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
