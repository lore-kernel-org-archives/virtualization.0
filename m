Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A5C55178
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 22:57:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03AE20782
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 22:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zHS6zEAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03AE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6D8585F61;
	Thu,  5 Nov 2020 22:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rs20VdEWDSVC; Thu,  5 Nov 2020 22:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C87FD85D37;
	Thu,  5 Nov 2020 22:57:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5230C0893;
	Thu,  5 Nov 2020 22:57:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F166FC0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DAAC687260
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18IpjzBCHhzE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 110DD87220
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 22:57:11 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5Mt2oB139132;
 Thu, 5 Nov 2020 22:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qalVJtnMtA/H2B26JocLzfDr4AGkJ+v8RwgbvaxATvE=;
 b=zHS6zEAn4WEGkyUgW52oK4Dc9gOI9aUjY8s/ohukFkJ0jn7xp+Et4uKQAj//WIRAKden
 o2/k1fAW2ErgrgvVSJvmS5WXhTV6U+1baFGRS6if5XnbLZ2lIWnNtnWjF6Q31LNMyor/
 Tgd35zPdEGq1rGItjzm88Lnr3PyzDzRX7vtk6e66F/VspeXBm8LNbsbdpKFGOFq7e0CI
 31KSoAEvLBQGskEMDiTwd2Q2zi83qcebINLY54ERkt767327rEl5ImiJCON37icS6GuQ
 NZGOitAN08HgtPcb+3WCSnD+zMpwoRHTijrCycvL3ikRCZkMaNfcRHD1xZ8iOSx8IhGH mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 34hhw2xj1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Nov 2020 22:57:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MuY14139713;
 Thu, 5 Nov 2020 22:57:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 34hw0nekj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Nov 2020 22:57:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5Mv8gB003944;
 Thu, 5 Nov 2020 22:57:08 GMT
Received: from [192.168.0.28] (/73.189.186.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Nov 2020 14:57:07 -0800
Message-ID: <5FA48342.4060404@oracle.com>
Date: Thu, 05 Nov 2020 14:57:06 -0800
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
In-Reply-To: <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050148
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

Ck9uIDExLzQvMjAyMCA3OjI2IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMS81
IOS4iuWNiDc6MzMsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFBpbm5lZCBwYWdlcyBhcmUgbm90IHBy
b3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+PiBtYXBwaW5nIGVycm9yIG9jY3Vy
cyBvbiBJT1RMQiB1cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4+IHBpbm5lZCBwYWdlcyBmb3Ig
dGhlIGVycm9yIHBhdGguCj4+Cj4+IFRoZSBtZW1vcnkgdXNhZ2UgZm9yIGJvb2trZWVwaW5nIHBp
bm5lZCBwYWdlcyBpcyByZXZlcnRlZAo+PiB0byB3aGF0IGl0IHdhcyBiZWZvcmU6IG9ubHkgb25l
IHNpbmdsZSBmcmVlIHBhZ2UgaXMgbmVlZGVkLgo+PiBUaGlzIGhlbHBzIHJlZHVjZSB0aGUgaG9z
dCBtZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPj4gYW1vdW50IG9mIG1lbW9yeSwg
b3IgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZSBob3N0IGlzIHJ1bm5pbmcKPj4gc2hvcnQgb2YgZnJl
ZSBtZW1vcnkuCj4+Cj4+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZE
UEEtYmFzZWQgYmFja2VuZCIpCj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+IENoYW5nZXMgaW4gdjI6Cj4+IC0gRHJvcCB0aGUgcmV2
ZXJzaW9uIHBhdGNoCj4+IC0gRml4IHVuaGFuZGxlZCBwYWdlIGxlYWsgdG93YXJkcyB0aGUgZW5k
IG9mIHBhZ2VfbGlzdAo+Pgo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNzkgCj4+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IGlu
ZGV4IGI2ZDkwMTYuLmUxMTI4NTQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC01NjAsNiArNTYwLDggQEAgc3Rh
dGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAgICAgICBp
ZiAocikKPj4gICAgICAgICAgIHZob3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3Zh
LCBpb3ZhICsgc2l6ZSAtIDEpOwo+PiArICAgIGVsc2UKPj4gKyAgICAgICAgYXRvbWljNjRfYWRk
KHNpemUgPj4gUEFHRV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+ICAgICAgICAgcmV0
dXJuIHI7Cj4+ICAgfQo+PiBAQCAtNTkxLDE0ICs1OTMsMTYgQEAgc3RhdGljIGludCAKPj4gdmhv
c3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAg
ICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBh
Z2UgKik7Cj4+ICAgICAgIHVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+
PiAgICAgICB1bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZu
ID0gMDsKPj4gLSAgICB1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlubmVkLCBp
Owo+PiArICAgIHVuc2lnbmVkIGxvbmcgbG9ja19saW1pdCwgc3oycGluLCBuY2h1bmtzLCBpOwo+
PiAgICAgICB1NjQgaW92YSA9IG1zZy0+aW92YTsKPj4gKyAgICBsb25nIHBpbm5lZDsKPj4gICAg
ICAgaW50IHJldCA9IDA7Cj4+ICAgICAgICAgaWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlv
dGxiLCBtc2ctPmlvdmEsCj4+ICAgICAgICAgICAgICAgICAgICAgICBtc2ctPmlvdmEgKyBtc2ct
PnNpemUgLSAxKSkKPj4gICAgICAgICAgIHJldHVybiAtRUVYSVNUOwo+PiAgICsgICAgLyogTGlt
aXQgdGhlIHVzZSBvZiBtZW1vcnkgZm9yIGJvb2trZWVwaW5nICovCj4+ICAgICAgIHBhZ2VfbGlz
dCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+PiAgICAg
ICBpZiAoIXBhZ2VfbGlzdCkKPj4gICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+PiBAQCAtNjA3
LDUyICs2MTEsNzUgQEAgc3RhdGljIGludCAKPj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3Vw
ZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAgICAgICAgIGd1cF9mbGFncyB8PSBGT0xM
X1dSSVRFOwo+PiAgICAgICAgIG5wYWdlcyA9IFBBR0VfQUxJR04obXNnLT5zaXplICsgKGlvdmEg
JiB+UEFHRV9NQVNLKSkgPj4gCj4+IFBBR0VfU0hJRlQ7Cj4+IC0gICAgaWYgKCFucGFnZXMpCj4+
IC0gICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiArICAgIGlmICghbnBhZ2VzKSB7Cj4+ICsgICAg
ICAgIHJldCA9IC1FSU5WQUw7Cj4+ICsgICAgICAgIGdvdG8gZnJlZTsKPj4gKyAgICB9Cj4+ICAg
ICAgICAgbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4+ICAgLSAgICBsb2NrZWQgPSBhdG9taWM2
NF9hZGRfcmV0dXJuKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+ICAgICAgIGxvY2tf
bGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7Cj4+IC0KPj4gLSAg
ICBpZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+PiArICAgIGlmIChucGFnZXMgKyBhdG9taWM2
NF9yZWFkKCZkZXYtPm1tLT5waW5uZWRfdm0pID4gbG9ja19saW1pdCkgewo+PiAgICAgICAgICAg
cmV0ID0gLUVOT01FTTsKPj4gLSAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgIGdvdG8gdW5s
b2NrOwo+PiAgICAgICB9Cj4+ICAgICAgICAgY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYgUEFHRV9N
QVNLOwo+PiAgICAgICBpb3ZhICY9IFBBR0VfTUFTSzsKPj4gKyAgICBuY2h1bmtzID0gMDsKPj4g
ICAgICAgICB3aGlsZSAobnBhZ2VzKSB7Cj4+IC0gICAgICAgIHBpbm5lZCA9IG1pbl90KHVuc2ln
bmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4gLSAgICAgICAgcmV0ID0gcGluX3VzZXJf
cGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4gLSAgICAgICAgICAgICAgICAgICAgIGd1cF9mbGFn
cywgcGFnZV9saXN0LCBOVUxMKTsKPj4gLSAgICAgICAgaWYgKHJldCAhPSBwaW5uZWQpCj4+ICsg
ICAgICAgIHN6MnBpbiA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsK
Pj4gKyAgICAgICAgcGlubmVkID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPj4g
KyAgICAgICAgICAgICAgICAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+PiArICAg
ICAgICBpZiAoc3oycGluICE9IHBpbm5lZCkgewo+PiArICAgICAgICAgICAgaWYgKHBpbm5lZCA8
IDApIHsKPj4gKyAgICAgICAgICAgICAgICByZXQgPSBwaW5uZWQ7Cj4+ICsgICAgICAgICAgICB9
IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMocGFnZV9saXN0LCBw
aW5uZWQpOwo+PiArICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07Cj4+ICsgICAgICAgICAg
ICB9Cj4+ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgIH0KPj4gKyAgICAgICAg
bmNodW5rcysrOwo+PiAgICAgICAgICAgICBpZiAoIWxhc3RfcGZuKQo+PiAgICAgICAgICAgICAg
IG1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+PiAgIC0gICAgICAgIGZvciAo
aSA9IDA7IGkgPCByZXQ7IGkrKykgewo+PiArICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGlubmVk
OyBpKyspIHsKPj4gICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHRoaXNfcGZuID0gcGFnZV90
b19wZm4ocGFnZV9saXN0W2ldKTsKPj4gICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4+ICAgICAg
ICAgICAgICAgICBpZiAobGFzdF9wZm4gJiYgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsK
Pj4gICAgICAgICAgICAgICAgICAgLyogUGluIGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkg
Ki8KPj4gICAgICAgICAgICAgICAgICAgY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkg
PDwgUEFHRV9TSElGVDsKPj4gLSAgICAgICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9tYXAodiwg
aW92YSwgY3NpemUsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBB
R0VfU0hJRlQsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ctPnBlcm0pKQo+PiAr
ICAgICAgICAgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplLAo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSk7Cj4+ICsgICAgICAgICAgICAg
ICAgaWYgKHJldCkgewo+PiArICAgICAgICAgICAgICAgICAgICAvKgo+PiArICAgICAgICAgICAg
ICAgICAgICAgKiBVbnBpbiB0aGUgcGFnZXMgdGhhdCBhcmUgbGVmdCB1bm1hcHBlZAo+PiArICAg
ICAgICAgICAgICAgICAgICAgKiBmcm9tIHRoaXMgcG9pbnQgb24gaW4gdGhlIGN1cnJlbnQKPj4g
KyAgICAgICAgICAgICAgICAgICAgICogcGFnZV9saXN0LiBUaGUgcmVtYWluaW5nIG91dHN0YW5k
aW5nCj4+ICsgICAgICAgICAgICAgICAgICAgICAqIG9uZXMgd2hpY2ggbWF5IHN0cmlkZSBhY3Jv
c3Mgc2V2ZXJhbAo+PiArICAgICAgICAgICAgICAgICAgICAgKiBjaHVua3Mgd2lsbCBiZSBjb3Zl
cmVkIGluIHRoZSBjb21tb24KPj4gKyAgICAgICAgICAgICAgICAgICAgICogZXJyb3IgcGF0aCBz
dWJzZXF1ZW50bHkuCj4+ICsgICAgICAgICAgICAgICAgICAgICAqLwo+PiArICAgICAgICAgICAg
ICAgICAgICB1bnBpbl91c2VyX3BhZ2VzKCZwYWdlX2xpc3RbaV0sCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBpbm5lZCAtIGkpOwo+Cj4KPiBDYW4gd2Ugc2ltcGx5IGRvIGxhc3Rf
cGZuID0gdGhpc19wZm4gaGVyZT8KTm9wZS4gVGhleSBhcmUgbm90IGNvbnRpZ3VvdXMgc2VnbWVu
dHMgb2YgbWVtb3J5LiBOb3RlZCB0aGUgY29uZGl0aW9uYWwgCih0aGlzX3BmbiAhPSBsYXN0X3Bm
biArIDEpIGJlaW5nIGhlbGQgaGVyZS4KCj4KPgo+PiAgICAgICAgICAgICAgICAgICAgICAgZ290
byBvdXQ7Cj4+ICsgICAgICAgICAgICAgICAgfQo+PiArCj4+ICAgICAgICAgICAgICAgICAgIG1h
cF9wZm4gPSB0aGlzX3BmbjsKPj4gICAgICAgICAgICAgICAgICAgaW92YSArPSBjc2l6ZTsKPj4g
KyAgICAgICAgICAgICAgICBuY2h1bmtzID0gMDsKPj4gICAgICAgICAgICAgICB9Cj4+ICAgICAg
ICAgICAgICAgICBsYXN0X3BmbiA9IHRoaXNfcGZuOwo+PiAgICAgICAgICAgfQo+PiAgIC0gICAg
ICAgIGN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+PiAtICAgICAgICBucGFnZXMgLT0g
cmV0Owo+PiArICAgICAgICBjdXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPj4gKyAg
ICAgICAgbnBhZ2VzIC09IHBpbm5lZDsKPj4gICAgICAgfQo+PiAgICAgICAgIC8qIFBpbiB0aGUg
cmVzdCBjaHVuayAqLwo+PiBAQCAtNjYwLDEwICs2ODcsMjYgQEAgc3RhdGljIGludCAKPj4gdmhv
c3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gICAg
ICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwgbXNnLT5wZXJtKTsKPj4gICBv
dXQ6Cj4+ICAgICAgIGlmIChyZXQpIHsKPj4gKyAgICAgICAgaWYgKG5jaHVua3MgJiYgbGFzdF9w
Zm4pIHsKPgo+Cj4gQW55IHJlYXNvbiBmb3IgY2hlY2tpbmcgbGFzdF9wZm4gaGVyZT8KPgo+IE5v
dGUgdGhhdCB3ZSBkaWQ6Cj4KPiArICAgICAgICBuY2h1bmtzKys7Cj4KPiAgICAgICAgICBpZiAo
IWxhc3RfcGZuKQo+ICAgICAgICAgICAgICBtYXBfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0
WzBdKTsKSXQncyBmb3IgZXhwbGljaXQgY29kaW5nIHRvIG1ha2Ugc3VyZSB0aGlzIGNvbW1vbiBl
cnJvciBwYXRoIGNhbiBiZSAKcmV1c2VkIG5vIG1hdHRlciBpZiBsYXN0X3BmbiBoYXMgYSBzYW5l
IHZhbHVlIGFzc2lnbmVkIG9yIG5vdC4gSSBjYW4gCmNoYW5nZSBpdCB0byBhbiBpbXBsaWNpdCBX
QVJOX09OKCkgaWYgbmVlZCBiZS4KClRoYW5rcywKLVNpd2VpCgo+Cj4KPiBUaGFua3MKPgo+Cj4+
ICsgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHBmbjsKPj4gKwo+PiArICAgICAgICAgICAgLyoK
Pj4gKyAgICAgICAgICAgICAqIFVucGluIHRoZSBvdXRzdGFuZGluZyBwYWdlcyB3aGljaCBhcmUg
eWV0IHRvIGJlCj4+ICsgICAgICAgICAgICAgKiBtYXBwZWQgYnV0IGhhdmVuJ3QgZHVlIHRvIHZk
cGFfbWFwKCkgb3IKPj4gKyAgICAgICAgICAgICAqIHBpbl91c2VyX3BhZ2VzKCkgZmFpbHVyZS4K
Pj4gKyAgICAgICAgICAgICAqCj4+ICsgICAgICAgICAgICAgKiBNYXBwZWQgcGFnZXMgYXJlIGFj
Y291bnRlZCBpbiB2ZHBhX21hcCgpLCBoZW5jZQo+PiArICAgICAgICAgICAgICogdGhlIGNvcnJl
c3BvbmRpbmcgdW5waW5uaW5nIHdpbGwgYmUgaGFuZGxlZCBieQo+PiArICAgICAgICAgICAgICog
dmRwYV91bm1hcCgpLgo+PiArICAgICAgICAgICAgICovCj4+ICsgICAgICAgICAgICBmb3IgKHBm
biA9IG1hcF9wZm47IHBmbiA8PSBsYXN0X3BmbjsgcGZuKyspCj4+ICsgICAgICAgICAgICAgICAg
dW5waW5fdXNlcl9wYWdlKHBmbl90b19wYWdlKHBmbikpOwo+PiArICAgICAgICB9Cj4+ICAgICAg
ICAgICB2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwgbXNnLT5zaXplKTsKPj4gLSAgICAg
ICAgYXRvbWljNjRfc3ViKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+ICAgICAgIH0K
Pj4gK3VubG9jazoKPj4gICAgICAgbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPj4gK2ZyZWU6
Cj4+ICAgICAgIGZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3QpOwo+PiAgICAgICBy
ZXR1cm4gcmV0Owo+PiAgIH0KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
