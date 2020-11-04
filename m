Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B175C388F7
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:10:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268FA223C7
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MGl0F6Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268FA223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4490873F5;
	Wed,  4 Nov 2020 01:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N561tjrsSokM; Wed,  4 Nov 2020 01:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9773873ED;
	Wed,  4 Nov 2020 01:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B976CC0889;
	Wed,  4 Nov 2020 01:10:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70095C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 59368869F8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 74yd0tCQl6ho
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:10:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3F476869D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:10:50 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A419Vn2145963;
 Wed, 4 Nov 2020 01:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DtwzgX6oGsGfwgrfaqE3rZ3ObrVUFSjNerNak6tY0aI=;
 b=MGl0F6OwLFCfi67CW/WLXR39Sq26rMzAM+f64OExcZ9eU4JczOfzIdxA47W4biOhQuWs
 6oOcWejbGkKeXtAGe/PW5e6fAftBuTctsSgF19p/GaYBtoObE/77ETXgkuFOA610t1j3
 2T6QgzTnVViVvKDdDFAkqexGpYkhMQqOClDfyHzpsFxzofs4OMWy8909jo3f1NkgYo4h
 bPDBvxH3ieez7vA1nB2RauZGDC9cb0sGnmpSEGgq/fM/u1UJzEvZfTnRgIBTBC2CR4xA
 Us/dLDnCgXVHlqcVQcQJE3I+AnNZQAdQ2jnm5XPybVIlrlTHoYVc/PiJCoEVH5T3Dwwu yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 34hhvccb6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Nov 2020 01:10:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A410hYV175032;
 Wed, 4 Nov 2020 01:08:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34hw0edtj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Nov 2020 01:08:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A418iiH016358;
 Wed, 4 Nov 2020 01:08:44 GMT
Received: from [10.159.249.36] (/10.159.249.36)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Nov 2020 17:08:44 -0800
Message-ID: <5FA1FF1B.1000303@oracle.com>
Date: Tue, 03 Nov 2020 17:08:43 -0800
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
 <5FA1FE87.4050909@oracle.com>
In-Reply-To: <5FA1FE87.4050909@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040005
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

Ck9uIDExLzMvMjAyMCA1OjA2IFBNLCBzaS13ZWkgbGl1IHdyb3RlOgo+Cj4gT24gMTEvMy8yMDIw
IDU6MDAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvMTAvMzAg5LiL5Y2IMzo0
NSwgU2ktV2VpIExpdSB3cm90ZToKPj4+IFBpbm5lZCBwYWdlcyBhcmUgbm90IHByb3Blcmx5IGFj
Y291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+Pj4gbWFwcGluZyBlcnJvciBvY2N1cnMgb24gSU9U
TEIgdXBkYXRlLiBDbGVhbiB1cCBkYW5nbGluZwo+Pj4gcGlubmVkIHBhZ2VzIGZvciB0aGUgZXJy
b3IgcGF0aC4KPj4+Cj4+PiBUaGUgbWVtb3J5IHVzYWdlIGZvciBib29ra2VlcGluZyBwaW5uZWQg
cGFnZXMgaXMgcmV2ZXJ0ZWQKPj4+IHRvIHdoYXQgaXQgd2FzIGJlZm9yZTogb25seSBvbmUgc2lu
Z2xlIGZyZWUgcGFnZSBpcyBuZWVkZWQuCj4+PiBUaGlzIGhlbHBzIHJlZHVjZSB0aGUgaG9zdCBt
ZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPj4+IGFtb3VudCBvZiBtZW1vcnksIG9y
IGluIHRoZSBzaXR1YXRpb24gd2hlcmUgaG9zdCBpcyBydW5uaW5nCj4+PiBzaG9ydCBvZiBmcmVl
IG1lbW9yeS4KPj4+Cj4+PiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2
RFBBLWJhc2VkIGJhY2tlbmQiKQo+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2Vp
LmxpdUBvcmFjbGUuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNjQg
Cj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
Cj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+Pj4gaW5kZXggYjZkOTAxNi4uOGRhODU1OCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gQEAgLTU2
MCw2ICs1NjAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LAo+Pj4gICAgICAgICBpZiAocikKPj4+ICAgICAgICAgICB2aG9zdF9pb3RsYl9kZWxfcmFu
Z2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUgLSAxKTsKPj4+ICsgICAgZWxzZQo+Pj4g
KyAgICAgICAgYXRvbWljNjRfYWRkKHNpemUgPj4gUEFHRV9TSElGVCwgJmRldi0+bW0tPnBpbm5l
ZF92bSk7Cj4+PiAgICAgICAgIHJldHVybiByOwo+Pj4gICB9Cj4+PiBAQCAtNTkxLDE0ICs1OTMs
MTYgQEAgc3RhdGljIGludCAKPj4+IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsCj4+PiAgICAgICB1bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBB
R0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsKPj4+ICAgICAgIHVuc2lnbmVkIGludCBn
dXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+Pj4gICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMs
IGN1cl9iYXNlLCBtYXBfcGZuLCBsYXN0X3BmbiA9IDA7Cj4+PiAtICAgIHVuc2lnbmVkIGxvbmcg
bG9ja2VkLCBsb2NrX2xpbWl0LCBwaW5uZWQsIGk7Cj4+PiArICAgIHVuc2lnbmVkIGxvbmcgbG9j
a19saW1pdCwgc3oycGluLCBuY2h1bmtzLCBpOwo+Pj4gICAgICAgdTY0IGlvdmEgPSBtc2ctPmlv
dmE7Cj4+PiArICAgIGxvbmcgcGlubmVkOwo+Pj4gICAgICAgaW50IHJldCA9IDA7Cj4+PiAgICAg
ICAgIGlmICh2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3RsYiwgbXNnLT5pb3ZhLAo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+Pj4gICAgICAg
ICAgIHJldHVybiAtRUVYSVNUOwo+Pj4gICArICAgIC8qIExpbWl0IHRoZSB1c2Ugb2YgbWVtb3J5
IGZvciBib29ra2VlcGluZyAqLwo+Pj4gICAgICAgcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoq
KSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7Cj4+PiAgICAgICBpZiAoIXBhZ2VfbGlzdCkK
Pj4+ICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPj4+IEBAIC02MDcsNTIgKzYxMSw2NCBAQCBz
dGF0aWMgaW50IAo+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiwKPj4+ICAgICAgICAgICBndXBfZmxhZ3MgfD0gRk9MTF9XUklURTsKPj4+ICAg
ICAgICAgbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAoaW92YSAmIH5QQUdFX01BU0sp
KSA+PiAKPj4+IFBBR0VfU0hJRlQ7Cj4+PiAtICAgIGlmICghbnBhZ2VzKQo+Pj4gLSAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4+PiArICAgIGlmICghbnBhZ2VzKSB7Cj4+PiArICAgICAgICByZXQg
PSAtRUlOVkFMOwo+Pj4gKyAgICAgICAgZ290byBmcmVlOwo+Pj4gKyAgICB9Cj4+PiAgICAgICAg
IG1tYXBfcmVhZF9sb2NrKGRldi0+bW0pOwo+Pj4gICAtICAgIGxvY2tlZCA9IGF0b21pYzY0X2Fk
ZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4+ICAgICAgIGxvY2tfbGlt
aXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBBR0VfU0hJRlQ7Cj4+PiAtCj4+PiAtICAg
IGlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4+PiArICAgIGlmIChucGFnZXMgKyBhdG9taWM2
NF9yZWFkKCZkZXYtPm1tLT5waW5uZWRfdm0pID4gbG9ja19saW1pdCkgewo+Pj4gICAgICAgICAg
IHJldCA9IC1FTk9NRU07Cj4+PiAtICAgICAgICBnb3RvIG91dDsKPj4+ICsgICAgICAgIGdvdG8g
dW5sb2NrOwo+Pj4gICAgICAgfQo+Pj4gICAgICAgICBjdXJfYmFzZSA9IG1zZy0+dWFkZHIgJiBQ
QUdFX01BU0s7Cj4+PiAgICAgICBpb3ZhICY9IFBBR0VfTUFTSzsKPj4+ICsgICAgbmNodW5rcyA9
IDA7Cj4+PiAgICAgICAgIHdoaWxlIChucGFnZXMpIHsKPj4+IC0gICAgICAgIHBpbm5lZCA9IG1p
bl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+IC0gICAgICAgIHJldCA9
IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBwaW5uZWQsCj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwpOwo+Pj4gLSAgICAgICAgaWYgKHJldCAhPSBw
aW5uZWQpCj4+PiArICAgICAgICBzejJwaW4gPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMs
IGxpc3Rfc2l6ZSk7Cj4+PiArICAgICAgICBwaW5uZWQgPSBwaW5fdXNlcl9wYWdlcyhjdXJfYmFz
ZSwgc3oycGluLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3Qs
IE5VTEwpOwo+Pj4gKyAgICAgICAgaWYgKHN6MnBpbiAhPSBwaW5uZWQpIHsKPj4+ICsgICAgICAg
ICAgICBpZiAocGlubmVkIDwgMCkgewo+Pj4gKyAgICAgICAgICAgICAgICByZXQgPSBwaW5uZWQ7
Cj4+PiArICAgICAgICAgICAgfSBlbHNlIHsKPj4+ICsgICAgICAgICAgICAgICAgdW5waW5fdXNl
cl9wYWdlcyhwYWdlX2xpc3QsIHBpbm5lZCk7Cj4+PiArICAgICAgICAgICAgICAgIHJldCA9IC1F
Tk9NRU07Cj4+PiArICAgICAgICAgICAgfQo+Pj4gICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+
ICsgICAgICAgIH0KPj4+ICsgICAgICAgIG5jaHVua3MrKzsKPj4+ICAgICAgICAgICAgIGlmICgh
bGFzdF9wZm4pCj4+PiAgICAgICAgICAgICAgIG1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xp
c3RbMF0pOwo+Pj4gICAtICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcmV0OyBpKyspIHsKPj4+ICsg
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBwaW5uZWQ7IGkrKykgewo+Pj4gICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIHRoaXNfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0W2ldKTsKPj4+ICAg
ICAgICAgICAgICAgdTY0IGNzaXplOwo+Pj4gICAgICAgICAgICAgICAgIGlmIChsYXN0X3BmbiAm
JiAodGhpc19wZm4gIT0gbGFzdF9wZm4gKyAxKSkgewo+Pj4gICAgICAgICAgICAgICAgICAgLyog
UGluIGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8KPj4+ICAgICAgICAgICAgICAgICAg
IGNzaXplID0gKGxhc3RfcGZuIC0gbWFwX3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4+PiAtICAg
ICAgICAgICAgICAgIGlmICh2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNnLT5wZXJtKSkKPj4+ICsgICAgICAgICAgICAgICAgcmV0
ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtc2ctPnBlcm0pOwo+Pj4gKyAgICAgICAgICAgICAgICBpZiAocmV0KQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+Pj4gKwo+Pj4gICAgICAgICAgICAgICAg
ICAgbWFwX3BmbiA9IHRoaXNfcGZuOwo+Pj4gICAgICAgICAgICAgICAgICAgaW92YSArPSBjc2l6
ZTsKPj4+ICsgICAgICAgICAgICAgICAgbmNodW5rcyA9IDA7Cj4+PiAgICAgICAgICAgICAgIH0K
Pj4+ICAgICAgICAgICAgICAgICBsYXN0X3BmbiA9IHRoaXNfcGZuOwo+Pj4gICAgICAgICAgIH0K
Pj4+ICAgLSAgICAgICAgY3VyX2Jhc2UgKz0gcmV0IDw8IFBBR0VfU0hJRlQ7Cj4+PiAtICAgICAg
ICBucGFnZXMgLT0gcmV0Owo+Pj4gKyAgICAgICAgY3VyX2Jhc2UgKz0gcGlubmVkIDw8IFBBR0Vf
U0hJRlQ7Cj4+PiArICAgICAgICBucGFnZXMgLT0gcGlubmVkOwo+Pj4gICAgICAgfQo+Pj4gICAg
ICAgICAvKiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPj4+IEBAIC02NjAsMTAgKzY3NiwyMiBAQCBz
dGF0aWMgaW50IAo+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiwKPj4+ICAgICAgICAgICAgICAgICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
IG1zZy0+cGVybSk7Cj4+PiAgIG91dDoKPj4+ICAgICAgIGlmIChyZXQpIHsKPj4+ICsgICAgICAg
IGlmIChuY2h1bmtzICYmIGxhc3RfcGZuKSB7Cj4+PiArICAgICAgICAgICAgdW5zaWduZWQgbG9u
ZyBwZm47Cj4+PiArCj4+PiArICAgICAgICAgICAgLyoKPj4+ICsgICAgICAgICAgICAgKiBVbnBp
biB0aGUgb3V0c3RhbmRpbmcgcGFnZXMgd2hpY2ggYXJlIHVubWFwcGVkLgo+Pj4gKyAgICAgICAg
ICAgICAqIE1hcHBlZCBwYWdlcyBhcmUgYWNjb3VudGVkIGluIHZkcGFfbWFwKCksIHRodXMKPj4+
ICsgICAgICAgICAgICAgKiB3aWxsIGJlIGhhbmRsZWQgYnkgdmRwYV91bm1hcCgpLgo+Pj4gKyAg
ICAgICAgICAgICAqLwo+Pj4gKyAgICAgICAgICAgIGZvciAocGZuID0gbWFwX3BmbjsgcGZuIDw9
IGxhc3RfcGZuOyBwZm4rKykKPj4+ICsgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlKHBm
bl90b19wYWdlKHBmbikpOwo+Pj4gKyAgICAgICAgfQo+Pj4gICAgICAgICAgIHZob3N0X3ZkcGFf
dW5tYXAodiwgbXNnLT5pb3ZhLCBtc2ctPnNpemUpOwo+Pgo+Pgo+PiBJIHdhbnQgdG8ga25vdyB3
aGF0J3Mgd3Jvbmcgd2l0aCBjdXJyZW50IGNvZGUuCj4+Cj4+IFdlIGNhbGwgdmhvc3RfdmRwYV91
bm1hcCgpIG9uIGVycm9yIHdoaWNoIGNhbGxzIAo+PiB2aG9zdF92ZHBhX2lvdGxiX3VubWFwKCkg
dGhhdCB3aWxsIHVucGluIGFuZCByZWR1Y2UgdGhlIHBpbm5lZF92bS4KPiBUaGluayBhYm91dCB0
aGUgY2FzZSB3aGVyZSB2aG9zdF92ZHBhX21hcCgpIGZhaWxzIGluIHRoZSBtaWRkbGUgYWZ0ZXIg
Cj4gbWFraW5nIGEgZmV3IHN1Y2Nlc3NmdWwgb25lcy4gSW4gdGhlIGN1cnJlbnQgY29kZSwgdGhl
IAo+IHZob3N0X3ZkcGFfaW90bGJfdW5tYXAoKSB1bnBpbnMgd2hhdCBoYWQgYmVlbiBtYXBwZWQs
IGJ1dCBkb2VzIG5vdCAKPiB1bnBpbiB0aG9zZSB0aGF0IGhhdmUgbm90IHlldCBiZWVuIG1hcHBl
ZC4gVGhlc2Ugb3V0c3RhbmRpbmcgcGlubmVkIAo+IHBhZ2VzIHdpbGwgYmUgbGVha2VkIGFmdGVy
IGxlYXZpbmcgdGhlIHZob3N0X3ZkcGFfbWFwKCkgZnVuY3Rpb24uClR5cG86IC4uLiBsZWF2aW5n
IHRoZSB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKCkgZnVuY3Rpb24uCj4KPiBBbHNv
LCB0aGUgc3VidHJhY3Rpb24gYWNjb3VudGluZyBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlvbiBp
cyAKPiBpbmNvcnJlY3QgaW4gdGhhdCBjYXNlOiBAbnBhZ2VzIGlzIGRlZHVjZWQgYnkgQHBpbm5l
ZCBpbiBlYWNoIAo+IGl0ZXJhdGlvbi4gVGhhdCdzIHdoeSBJIG1vdmVkIHRoZSBhY2NvdW50aW5n
IHRvIHZob3N0X3ZkcGFfbWFwKCkgdG8gYmUgCj4gc3ltbWV0cmljIHdpdGggdmhvc3RfdmRwYV91
bm1hcCgpLgo+Cj4KPiAtU2l3ZWkKPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+PiAtICAgICAgICBhdG9t
aWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4+ICAgICAgIH0KPj4+ICt1
bmxvY2s6Cj4+PiAgICAgICBtbWFwX3JlYWRfdW5sb2NrKGRldi0+bW0pOwo+Pj4gK2ZyZWU6Cj4+
PiAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPj4+ICAgICAgIHJl
dHVybiByZXQ7Cj4+PiAgIH0KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
