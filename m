Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537EC2D0A3
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 21:44:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4AE2067C
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rbReRao2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4AE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C24832043A;
	Mon,  9 Nov 2020 21:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24jGKFZHh+tr; Mon,  9 Nov 2020 21:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3176A203D8;
	Mon,  9 Nov 2020 21:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21C2BC0889;
	Mon,  9 Nov 2020 21:44:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7E15C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 21:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A58F284718
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 21:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wix6GUKQwenS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 21:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 90D1984580
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 21:44:09 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9LE3M4082569;
 Mon, 9 Nov 2020 21:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tPDgdWZW3dSiwXq3cg+sLtJu53oZDSjaEc4UXPy6kJU=;
 b=rbReRao2dUuPFKRrTBNhcf50bW7/fvOBtnYLzYIXWnvG6DJWhyn+5XY1p5dJq+an9/Jl
 spppJKO8pcpDE6xxkrqdA1BnLlrmY10oRgbAmR4lusNjGpA8uKXgYwvSgPsEsPnirXdf
 GFXvVQcGFogkNeVBZ8BnWQwfloLa9Y7P4kKsEWA8k+yOs/v9Skv6fSPdUtOIE0GdGXlB
 a2vcupqwMlruWQjrIyuW5US2cwB0TcIj1u9exh0EOW9xA1PdmnaE/xTXRJzXo5qsrKRa
 GkNn+OIeLA7ReX4Nd+iMziOIxcPpGYAdb/u4kJzY9lslYoCKi1F2HesCC94UJlVy5uMe gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 34nh3arnxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 09 Nov 2020 21:44:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9LFPgV183328;
 Mon, 9 Nov 2020 21:44:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 34p55mhex1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Nov 2020 21:44:07 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9Li6mO004405;
 Mon, 9 Nov 2020 21:44:06 GMT
Received: from [192.168.0.28] (/73.189.186.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Nov 2020 13:44:06 -0800
Message-ID: <5FA9B823.9060609@oracle.com>
Date: Mon, 09 Nov 2020 13:44:03 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, lingshan.zhu@intel.com
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
 <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
 <5FA48342.4060404@oracle.com>
 <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
In-Reply-To: <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090139
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

Ck9uIDExLzgvMjAyMCA3OjIxIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMS82
IOS4iuWNiDY6NTcsIHNpLXdlaSBsaXUgd3JvdGU6Cj4+Cj4+IE9uIDExLzQvMjAyMCA3OjI2IFBN
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjAvMTEvNSDkuIrljYg3OjMzLCBTaS1X
ZWkgTGl1IHdyb3RlOgo+Pj4+IFBpbm5lZCBwYWdlcyBhcmUgbm90IHByb3Blcmx5IGFjY291bnRl
ZCBwYXJ0aWN1bGFybHkgd2hlbgo+Pj4+IG1hcHBpbmcgZXJyb3Igb2NjdXJzIG9uIElPVExCIHVw
ZGF0ZS4gQ2xlYW4gdXAgZGFuZ2xpbmcKPj4+PiBwaW5uZWQgcGFnZXMgZm9yIHRoZSBlcnJvciBw
YXRoLgo+Pj4+Cj4+Pj4gVGhlIG1lbW9yeSB1c2FnZSBmb3IgYm9va2tlZXBpbmcgcGlubmVkIHBh
Z2VzIGlzIHJldmVydGVkCj4+Pj4gdG8gd2hhdCBpdCB3YXMgYmVmb3JlOiBvbmx5IG9uZSBzaW5n
bGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPj4+PiBUaGlzIGhlbHBzIHJlZHVjZSB0aGUgaG9zdCBt
ZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPj4+PiBhbW91bnQgb2YgbWVtb3J5LCBv
ciBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIGhvc3QgaXMgcnVubmluZwo+Pj4+IHNob3J0IG9mIGZy
ZWUgbWVtb3J5Lgo+Pj4+Cj4+Pj4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1
Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxz
aS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4gLS0tCj4+Pj4gQ2hhbmdlcyBpbiB2MjoKPj4+PiAt
IERyb3AgdGhlIHJldmVyc2lvbiBwYXRjaAo+Pj4+IC0gRml4IHVuaGFuZGxlZCBwYWdlIGxlYWsg
dG93YXJkcyB0aGUgZW5kIG9mIHBhZ2VfbGlzdAo+Pj4+Cj4+Pj4gICBkcml2ZXJzL3Zob3N0L3Zk
cGEuYyB8IDc5IAo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAxOCBk
ZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4gaW5kZXggYjZkOTAxNi4uZTExMjg1NCAxMDA2NDQK
Pj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+Pj4gQEAgLTU2MCw2ICs1NjAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbWFw
KHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+ICAgICAgICAgaWYgKHIpCj4+Pj4gICAgICAgICAg
IHZob3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEp
Owo+Pj4+ICsgICAgZWxzZQo+Pj4+ICsgICAgICAgIGF0b21pYzY0X2FkZChzaXplID4+IFBBR0Vf
U0hJRlQsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+Pj4+ICAgICAgICAgcmV0dXJuIHI7Cj4+Pj4g
ICB9Cj4+Pj4gQEAgLTU5MSwxNCArNTkzLDE2IEBAIHN0YXRpYyBpbnQgCj4+Pj4gdmhvc3RfdmRw
YV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+PiAgICAgICB1
bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAq
KTsKPj4+PiAgICAgICB1bnNpZ25lZCBpbnQgZ3VwX2ZsYWdzID0gRk9MTF9MT05HVEVSTTsKPj4+
PiAgICAgICB1bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZu
ID0gMDsKPj4+PiAtICAgIHVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0LCBwaW5uZWQs
IGk7Cj4+Pj4gKyAgICB1bnNpZ25lZCBsb25nIGxvY2tfbGltaXQsIHN6MnBpbiwgbmNodW5rcywg
aTsKPj4+PiAgICAgICB1NjQgaW92YSA9IG1zZy0+aW92YTsKPj4+PiArICAgIGxvbmcgcGlubmVk
Owo+Pj4+ICAgICAgIGludCByZXQgPSAwOwo+Pj4+ICAgICAgICAgaWYgKHZob3N0X2lvdGxiX2l0
cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIG1z
Zy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+Pj4+ICAgICAgICAgICByZXR1cm4gLUVFWElTVDsK
Pj4+PiAgICsgICAgLyogTGltaXQgdGhlIHVzZSBvZiBtZW1vcnkgZm9yIGJvb2trZWVwaW5nICov
Cj4+Pj4gICAgICAgcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2Uo
R0ZQX0tFUk5FTCk7Cj4+Pj4gICAgICAgaWYgKCFwYWdlX2xpc3QpCj4+Pj4gICAgICAgICAgIHJl
dHVybiAtRU5PTUVNOwo+Pj4+IEBAIC02MDcsNTIgKzYxMSw3NSBAQCBzdGF0aWMgaW50IAo+Pj4+
IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+
Pj4gICAgICAgICAgIGd1cF9mbGFncyB8PSBGT0xMX1dSSVRFOwo+Pj4+ICAgICAgICAgbnBhZ2Vz
ID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAoaW92YSAmIH5QQUdFX01BU0spKSA+PiAKPj4+PiBQ
QUdFX1NISUZUOwo+Pj4+IC0gICAgaWYgKCFucGFnZXMpCj4+Pj4gLSAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4+Pj4gKyAgICBpZiAoIW5wYWdlcykgewo+Pj4+ICsgICAgICAgIHJldCA9IC1FSU5W
QUw7Cj4+Pj4gKyAgICAgICAgZ290byBmcmVlOwo+Pj4+ICsgICAgfQo+Pj4+ICAgICAgICAgbW1h
cF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4+Pj4gICAtICAgIGxvY2tlZCA9IGF0b21pYzY0X2FkZF9y
ZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4+PiAgICAgICBsb2NrX2xpbWl0
ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+Pj4+IC0KPj4+PiAtICAg
IGlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4+Pj4gKyAgICBpZiAobnBhZ2VzICsgYXRvbWlj
NjRfcmVhZCgmZGV2LT5tbS0+cGlubmVkX3ZtKSA+IGxvY2tfbGltaXQpIHsKPj4+PiAgICAgICAg
ICAgcmV0ID0gLUVOT01FTTsKPj4+PiAtICAgICAgICBnb3RvIG91dDsKPj4+PiArICAgICAgICBn
b3RvIHVubG9jazsKPj4+PiAgICAgICB9Cj4+Pj4gICAgICAgICBjdXJfYmFzZSA9IG1zZy0+dWFk
ZHIgJiBQQUdFX01BU0s7Cj4+Pj4gICAgICAgaW92YSAmPSBQQUdFX01BU0s7Cj4+Pj4gKyAgICBu
Y2h1bmtzID0gMDsKPj4+PiAgICAgICAgIHdoaWxlIChucGFnZXMpIHsKPj4+PiAtICAgICAgICBw
aW5uZWQgPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4+Pj4gLSAg
ICAgICAgcmV0ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+Pj4+IC0gICAgICAg
IGlmIChyZXQgIT0gcGlubmVkKQo+Pj4+ICsgICAgICAgIHN6MnBpbiA9IG1pbl90KHVuc2lnbmVk
IGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+PiArICAgICAgICBwaW5uZWQgPSBwaW5fdXNl
cl9wYWdlcyhjdXJfYmFzZSwgc3oycGluLAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIGd1cF9m
bGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4+PiArICAgICAgICBpZiAoc3oycGluICE9IHBpbm5l
ZCkgewo+Pj4+ICsgICAgICAgICAgICBpZiAocGlubmVkIDwgMCkgewo+Pj4+ICsgICAgICAgICAg
ICAgICAgcmV0ID0gcGlubmVkOwo+Pj4+ICsgICAgICAgICAgICB9IGVsc2Ugewo+Pj4+ICsgICAg
ICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlcyhwYWdlX2xpc3QsIHBpbm5lZCk7Cj4+Pj4gKyAg
ICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOwo+Pj4+ICsgICAgICAgICAgICB9Cj4+Pj4gICAg
ICAgICAgICAgICBnb3RvIG91dDsKPj4+PiArICAgICAgICB9Cj4+Pj4gKyAgICAgICAgbmNodW5r
cysrOwo+Pj4+ICAgICAgICAgICAgIGlmICghbGFzdF9wZm4pCj4+Pj4gICAgICAgICAgICAgICBt
YXBfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0WzBdKTsKPj4+PiAgIC0gICAgICAgIGZvciAo
aSA9IDA7IGkgPCByZXQ7IGkrKykgewo+Pj4+ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwaW5u
ZWQ7IGkrKykgewo+Pj4+ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB0aGlzX3BmbiA9IHBh
Z2VfdG9fcGZuKHBhZ2VfbGlzdFtpXSk7Cj4+Pj4gICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4+
Pj4gICAgICAgICAgICAgICAgIGlmIChsYXN0X3BmbiAmJiAodGhpc19wZm4gIT0gbGFzdF9wZm4g
KyAxKSkgewo+Pj4+ICAgICAgICAgICAgICAgICAgIC8qIFBpbiBhIGNvbnRpZ3VvdXMgY2h1bmsg
b2YgbWVtb3J5ICovCj4+Pj4gICAgICAgICAgICAgICAgICAgY3NpemUgPSAobGFzdF9wZm4gLSBt
YXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsKPj4+PiAtICAgICAgICAgICAgICAgIGlmICh2aG9z
dF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULAo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICBtc2ctPnBlcm0pKQo+Pj4+ICsgICAgICAgICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9tYXAo
diwgaW92YSwgY3NpemUsCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFwX3Bm
biA8PCBQQUdFX1NISUZULAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+
cGVybSk7Cj4+Pj4gKyAgICAgICAgICAgICAgICBpZiAocmV0KSB7Cj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgLyoKPj4+PiArICAgICAgICAgICAgICAgICAgICAgKiBVbnBpbiB0aGUgcGFnZXMg
dGhhdCBhcmUgbGVmdCB1bm1hcHBlZAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGZyb20g
dGhpcyBwb2ludCBvbiBpbiB0aGUgY3VycmVudAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAq
IHBhZ2VfbGlzdC4gVGhlIHJlbWFpbmluZyBvdXRzdGFuZGluZwo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAqIG9uZXMgd2hpY2ggbWF5IHN0cmlkZSBhY3Jvc3Mgc2V2ZXJhbAo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAqIGNodW5rcyB3aWxsIGJlIGNvdmVyZWQgaW4gdGhlIGNvbW1vbgo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGVycm9yIHBhdGggc3Vic2VxdWVudGx5Lgo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAqLwo+Pj4+ICsgICAgICAgICAgICAgICAgICAgIHVucGlu
X3VzZXJfcGFnZXMoJnBhZ2VfbGlzdFtpXSwKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwaW5uZWQgLSBpKTsKPj4+Cj4+Pgo+Pj4gQ2FuIHdlIHNpbXBseSBkbyBsYXN0X3BmbiA9
IHRoaXNfcGZuIGhlcmU/Cj4+IE5vcGUuIFRoZXkgYXJlIG5vdCBjb250aWd1b3VzIHNlZ21lbnRz
IG9mIG1lbW9yeS4gTm90ZWQgdGhlIAo+PiBjb25kaXRpb25hbCAodGhpc19wZm4gIT0gbGFzdF9w
Zm4gKyAxKSBiZWluZyBoZWxkIGhlcmUuCj4KPgo+IFJpZ2h0Lgo+Cj4KPj4KPj4+Cj4+Pgo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+PiArICAgICAgICAgICAgICAgIH0K
Pj4+PiArCj4+Pj4gICAgICAgICAgICAgICAgICAgbWFwX3BmbiA9IHRoaXNfcGZuOwo+Pj4+ICAg
ICAgICAgICAgICAgICAgIGlvdmEgKz0gY3NpemU7Cj4+Pj4gKyAgICAgICAgICAgICAgICBuY2h1
bmtzID0gMDsKPj4+PiAgICAgICAgICAgICAgIH0KPj4+PiAgICAgICAgICAgICAgICAgbGFzdF9w
Zm4gPSB0aGlzX3BmbjsKPj4+PiAgICAgICAgICAgfQo+Pj4+ICAgLSAgICAgICAgY3VyX2Jhc2Ug
Kz0gcmV0IDw8IFBBR0VfU0hJRlQ7Cj4+Pj4gLSAgICAgICAgbnBhZ2VzIC09IHJldDsKPj4+PiAr
ICAgICAgICBjdXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPj4+PiArICAgICAgICBu
cGFnZXMgLT0gcGlubmVkOwo+Pj4+ICAgICAgIH0KPj4+PiAgICAgICAgIC8qIFBpbiB0aGUgcmVz
dCBjaHVuayAqLwo+Pj4+IEBAIC02NjAsMTAgKzY4NywyNiBAQCBzdGF0aWMgaW50IAo+Pj4+IHZo
b3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4g
ICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwgbXNnLT5wZXJtKTsKPj4+
PiAgIG91dDoKPj4+PiAgICAgICBpZiAocmV0KSB7Cj4+Pj4gKyAgICAgICAgaWYgKG5jaHVua3Mg
JiYgbGFzdF9wZm4pIHsKPj4+Cj4+Pgo+Pj4gQW55IHJlYXNvbiBmb3IgY2hlY2tpbmcgbGFzdF9w
Zm4gaGVyZT8KPj4+Cj4+PiBOb3RlIHRoYXQgd2UgZGlkOgo+Pj4KPj4+ICsgICAgICAgIG5jaHVu
a3MrKzsKPj4+Cj4+PiAgICAgICAgICBpZiAoIWxhc3RfcGZuKQo+Pj4gICAgICAgICAgICAgIG1h
cF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+PiBJdCdzIGZvciBleHBsaWNpdCBj
b2RpbmcgdG8gbWFrZSBzdXJlIHRoaXMgY29tbW9uIGVycm9yIHBhdGggY2FuIGJlIAo+PiByZXVz
ZWQgbm8gbWF0dGVyIGlmIGxhc3RfcGZuIGhhcyBhIHNhbmUgdmFsdWUgYXNzaWduZWQgb3Igbm90
LiBJIGNhbiAKPj4gY2hhbmdlIGl0IHRvIGFuIGltcGxpY2l0IFdBUk5fT04oKSBpZiBuZWVkIGJl
Lgo+Cj4KPiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQuIEEgcXVlc3Rpb24sIHdoZW4g
d2lsbCB3ZSBnZXQgbmNodW5rcyAKPiAhPSAwIGJ1dCBsYXN0X3BmbiA9PSAwPwpUaGUgY3VycmVu
dCBjb2RlIGhhcyBpbXBsaWNpdCBhc3N1bXB0aW9uIHRoYXQgbmNodW5rcyAhPSAwIGluZmVycyAK
bGFzdF9wZm4gIT0gMC4gSG93ZXZlciwgdGhpcyBhc3N1bXB0aW9uIGNvdWxkIGJyZWFrIHN1Ympl
Y3QgdG8gY29kZSAKc3RydWN0dXJlIGNoYW5nZXMgZm9yIGVnLiBmYWlsdXJlIG1heSBvY2N1ciBh
ZnRlciB0aGUgaW5jcmVtZW50IG9mIApuY2h1bmtzIGFuZCBiZWZvcmUgdGhlIGZvciBsb29wLiBJ
IGZlZWwgaXQnZCBiZSB0aGUgYmVzdCB0byBjYXB0dXJlIHRoaXMgCmFzc3VtcHRpb24gd2l0aCBz
b21ldGhpbmcgZXhwbGljaXQuCgotU2l3ZWkKCj4KPiBUaGFua3MKPgo+Cj4+IFRoYW5rcywKPj4g
LVNpd2VpCj4+Cj4+Pgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4gKyAgICAgICAgICAgIHVu
c2lnbmVkIGxvbmcgcGZuOwo+Pj4+ICsKPj4+PiArICAgICAgICAgICAgLyoKPj4+PiArICAgICAg
ICAgICAgICogVW5waW4gdGhlIG91dHN0YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB5ZXQgdG8gYmUK
Pj4+PiArICAgICAgICAgICAgICogbWFwcGVkIGJ1dCBoYXZlbid0IGR1ZSB0byB2ZHBhX21hcCgp
IG9yCj4+Pj4gKyAgICAgICAgICAgICAqIHBpbl91c2VyX3BhZ2VzKCkgZmFpbHVyZS4KPj4+PiAr
ICAgICAgICAgICAgICoKPj4+PiArICAgICAgICAgICAgICogTWFwcGVkIHBhZ2VzIGFyZSBhY2Nv
dW50ZWQgaW4gdmRwYV9tYXAoKSwgaGVuY2UKPj4+PiArICAgICAgICAgICAgICogdGhlIGNvcnJl
c3BvbmRpbmcgdW5waW5uaW5nIHdpbGwgYmUgaGFuZGxlZCBieQo+Pj4+ICsgICAgICAgICAgICAg
KiB2ZHBhX3VubWFwKCkuCj4+Pj4gKyAgICAgICAgICAgICAqLwo+Pj4+ICsgICAgICAgICAgICBm
b3IgKHBmbiA9IG1hcF9wZm47IHBmbiA8PSBsYXN0X3BmbjsgcGZuKyspCj4+Pj4gKyAgICAgICAg
ICAgICAgICB1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3BhZ2UocGZuKSk7Cj4+Pj4gKyAgICAgICAg
fQo+Pj4+ICAgICAgICAgICB2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwgbXNnLT5zaXpl
KTsKPj4+PiAtICAgICAgICBhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3Zt
KTsKPj4+PiAgICAgICB9Cj4+Pj4gK3VubG9jazoKPj4+PiAgICAgICBtbWFwX3JlYWRfdW5sb2Nr
KGRldi0+bW0pOwo+Pj4+ICtmcmVlOgo+Pj4+ICAgICAgIGZyZWVfcGFnZSgodW5zaWduZWQgbG9u
ZylwYWdlX2xpc3QpOwo+Pj4+ICAgICAgIHJldHVybiByZXQ7Cj4+Pj4gICB9Cj4+Pgo+Pgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
