Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B0C2D0A3
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 23:56:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625C3206B6
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcineMco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625C3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE1D786A98;
	Mon,  9 Nov 2020 23:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ueQUPvs_uwmn; Mon,  9 Nov 2020 23:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B032184B80;
	Mon,  9 Nov 2020 23:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 926CCC0889;
	Mon,  9 Nov 2020 23:56:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33AD3C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 23:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1897E87026
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 23:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqtOfseiic4D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 23:56:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3296D86FB2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 23:56:27 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NsZBe071595;
 Mon, 9 Nov 2020 23:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=j+8SZ6jURM8CsRuUQ1SQdJjcxLcOCiihnxI0zbDA42g=;
 b=fcineMcoqkURJTWSkcCEIsVlyEpqMDCQHH7R9u8vuk1pRzie/BXLitFeRi2ricyZn1J6
 b+c+9+5i/BwODc8hCUhnazOQgKUrnQdqXG8wHZHdIGa1/O1YlYxlWUEvLz2GxB4pLRDW
 ydkGIiMHyJMrjX2Su228NcUm2minY7+60DGXpcRbeuwVNcr6QNJny+bbNn1X920zP02H
 f3zOMI8Q4hvWZ2pEeb9rnt45wX3EL/Q0nlYYuzaWXRbxSZfAT3QNyscNVxyWps07vkCj
 bPIW8it7QFqpaS+NJUgl7wz7Z3Hvx9ooYydKdVErfwVJbB095Atf8al46KU2+MTbs9Ox kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34nkhkrw2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 09 Nov 2020 23:56:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Nu5jU013145;
 Mon, 9 Nov 2020 23:56:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 34p5gw18qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Nov 2020 23:56:24 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9NuNhP032277;
 Mon, 9 Nov 2020 23:56:23 GMT
Received: from [10.159.155.223] (/10.159.155.223)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Nov 2020 15:56:22 -0800
Message-ID: <5FA9D725.3050906@oracle.com>
Date: Mon, 09 Nov 2020 15:56:21 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
 <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
 <5FA48342.4060404@oracle.com>
 <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
 <5FA9B823.9060609@oracle.com> <20201109173236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201109173236-mutt-send-email-mst@kernel.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090152
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

Ck9uIDExLzkvMjAyMCAyOjQyIFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gTW9u
LCBOb3YgMDksIDIwMjAgYXQgMDE6NDQ6MDNQTSAtMDgwMCwgc2ktd2VpIGxpdSB3cm90ZToKPj4g
T24gMTEvOC8yMDIwIDc6MjEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDIwLzExLzYg
5LiK5Y2INjo1Nywgc2ktd2VpIGxpdSB3cm90ZToKPj4+PiBPbiAxMS80LzIwMjAgNzoyNiBQTSwg
SmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gT24gMjAyMC8xMS81IOS4iuWNiDc6MzMsIFNpLVdlaSBM
aXUgd3JvdGU6Cj4+Pj4+PiBQaW5uZWQgcGFnZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50ZWQg
cGFydGljdWxhcmx5IHdoZW4KPj4+Pj4+IG1hcHBpbmcgZXJyb3Igb2NjdXJzIG9uIElPVExCIHVw
ZGF0ZS4gQ2xlYW4gdXAgZGFuZ2xpbmcKPj4+Pj4+IHBpbm5lZCBwYWdlcyBmb3IgdGhlIGVycm9y
IHBhdGguCj4+Pj4+Pgo+Pj4+Pj4gVGhlIG1lbW9yeSB1c2FnZSBmb3IgYm9va2tlZXBpbmcgcGlu
bmVkIHBhZ2VzIGlzIHJldmVydGVkCj4+Pj4+PiB0byB3aGF0IGl0IHdhcyBiZWZvcmU6IG9ubHkg
b25lIHNpbmdsZSBmcmVlIHBhZ2UgaXMgbmVlZGVkLgo+Pj4+Pj4gVGhpcyBoZWxwcyByZWR1Y2Ug
dGhlIGhvc3QgbWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4+Pj4+PiBhbW91bnQg
b2YgbWVtb3J5LCBvciBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIGhvc3QgaXMgcnVubmluZwo+Pj4+
Pj4gc2hvcnQgb2YgZnJlZSBtZW1vcnkuCj4+Pj4+Pgo+Pj4+Pj4gRml4ZXM6IDRjOGNmMzE4ODVm
NiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+
Pj4gQ2hhbmdlcyBpbiB2MjoKPj4+Pj4+IC0gRHJvcCB0aGUgcmV2ZXJzaW9uIHBhdGNoCj4+Pj4+
PiAtIEZpeCB1bmhhbmRsZWQgcGFnZSBsZWFrIHRvd2FyZHMgdGhlIGVuZCBvZiBwYWdlX2xpc3QK
Pj4+Pj4+Cj4+Pj4+PiAgICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDc5Cj4+Pj4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4+Pj4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Pj4+Pgo+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPj4+Pj4+IGluZGV4IGI2ZDkwMTYuLmUxMTI4NTQgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+
Pj4+IEBAIC01NjAsNiArNTYwLDggQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwKPj4+Pj4+ICAgICAgICAgIGlmIChyKQo+Pj4+Pj4gICAgICAgICAgICB2
aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUgLSAxKTsK
Pj4+Pj4+ICsgICAgZWxzZQo+Pj4+Pj4gKyAgICAgICAgYXRvbWljNjRfYWRkKHNpemUgPj4gUEFH
RV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+Pj4+PiAgICAgICAgICByZXR1cm4gcjsK
Pj4+Pj4+ICAgIH0KPj4+Pj4+IEBAIC01OTEsMTQgKzU5MywxNiBAQCBzdGF0aWMgaW50Cj4+Pj4+
PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+
Pj4+Pj4gICAgICAgIHVuc2lnbmVkIGxvbmcgbGlzdF9zaXplID0gUEFHRV9TSVpFIC8gc2l6ZW9m
KHN0cnVjdCBwYWdlICopOwo+Pj4+Pj4gICAgICAgIHVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBG
T0xMX0xPTkdURVJNOwo+Pj4+Pj4gICAgICAgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFz
ZSwgbWFwX3BmbiwgbGFzdF9wZm4gPSAwOwo+Pj4+Pj4gLSAgICB1bnNpZ25lZCBsb25nIGxvY2tl
ZCwgbG9ja19saW1pdCwgcGlubmVkLCBpOwo+Pj4+Pj4gKyAgICB1bnNpZ25lZCBsb25nIGxvY2tf
bGltaXQsIHN6MnBpbiwgbmNodW5rcywgaTsKPj4+Pj4+ICAgICAgICB1NjQgaW92YSA9IG1zZy0+
aW92YTsKPj4+Pj4+ICsgICAgbG9uZyBwaW5uZWQ7Cj4+Pj4+PiAgICAgICAgaW50IHJldCA9IDA7
Cj4+Pj4+PiAgICAgICAgICBpZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIsIG1zZy0+
aW92YSwKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgbXNnLT5pb3ZhICsgbXNnLT5zaXpl
IC0gMSkpCj4+Pj4+PiAgICAgICAgICAgIHJldHVybiAtRUVYSVNUOwo+Pj4+Pj4gICAgKyAgICAv
KiBMaW1pdCB0aGUgdXNlIG9mIG1lbW9yeSBmb3IgYm9va2tlZXBpbmcgKi8KPj4+Pj4+ICAgICAg
ICBwYWdlX2xpc3QgPSAoc3RydWN0IHBhZ2UgKiopIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVM
KTsKPj4+Pj4+ICAgICAgICBpZiAoIXBhZ2VfbGlzdCkKPj4+Pj4+ICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07Cj4+Pj4+PiBAQCAtNjA3LDUyICs2MTEsNzUgQEAgc3RhdGljIGludAo+Pj4+Pj4g
dmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+
Pj4+ICAgICAgICAgICAgZ3VwX2ZsYWdzIHw9IEZPTExfV1JJVEU7Cj4+Pj4+PiAgICAgICAgICBu
cGFnZXMgPSBQQUdFX0FMSUdOKG1zZy0+c2l6ZSArIChpb3ZhICYgflBBR0VfTUFTSykpCj4+Pj4+
Pj4+IFBBR0VfU0hJRlQ7Cj4+Pj4+PiAtICAgIGlmICghbnBhZ2VzKQo+Pj4+Pj4gLSAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4+Pj4+PiArICAgIGlmICghbnBhZ2VzKSB7Cj4+Pj4+PiArICAgICAg
ICByZXQgPSAtRUlOVkFMOwo+Pj4+Pj4gKyAgICAgICAgZ290byBmcmVlOwo+Pj4+Pj4gKyAgICB9
Cj4+Pj4+PiAgICAgICAgICBtbWFwX3JlYWRfbG9jayhkZXYtPm1tKTsKPj4+Pj4+ICAgIC0gICAg
bG9ja2VkID0gYXRvbWljNjRfYWRkX3JldHVybihucGFnZXMsICZkZXYtPm1tLT5waW5uZWRfdm0p
Owo+Pj4+Pj4gICAgICAgIGxvY2tfbGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spID4+IFBB
R0VfU0hJRlQ7Cj4+Pj4+PiAtCj4+Pj4+PiAtICAgIGlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7
Cj4+Pj4+PiArICAgIGlmIChucGFnZXMgKyBhdG9taWM2NF9yZWFkKCZkZXYtPm1tLT5waW5uZWRf
dm0pID4gbG9ja19saW1pdCkgewo+Pj4+Pj4gICAgICAgICAgICByZXQgPSAtRU5PTUVNOwo+Pj4+
Pj4gLSAgICAgICAgZ290byBvdXQ7Cj4+Pj4+PiArICAgICAgICBnb3RvIHVubG9jazsKPj4+Pj4+
ICAgICAgICB9Cj4+Pj4+PiAgICAgICAgICBjdXJfYmFzZSA9IG1zZy0+dWFkZHIgJiBQQUdFX01B
U0s7Cj4+Pj4+PiAgICAgICAgaW92YSAmPSBQQUdFX01BU0s7Cj4+Pj4+PiArICAgIG5jaHVua3Mg
PSAwOwo+Pj4+Pj4gICAgICAgICAgd2hpbGUgKG5wYWdlcykgewo+Pj4+Pj4gLSAgICAgICAgcGlu
bmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+Pj4+Pj4gLSAg
ICAgICAgcmV0ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVMTCk7Cj4+Pj4+PiAtICAg
ICAgICBpZiAocmV0ICE9IHBpbm5lZCkKPj4+Pj4+ICsgICAgICAgIHN6MnBpbiA9IG1pbl90KHVu
c2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+Pj4+ICsgICAgICAgIHBpbm5lZCA9
IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBzejJwaW4sCj4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVMTCk7Cj4+Pj4+PiArICAgICAgICBpZiAoc3oy
cGluICE9IHBpbm5lZCkgewo+Pj4+Pj4gKyAgICAgICAgICAgIGlmIChwaW5uZWQgPCAwKSB7Cj4+
Pj4+PiArICAgICAgICAgICAgICAgIHJldCA9IHBpbm5lZDsKPj4+Pj4+ICsgICAgICAgICAgICB9
IGVsc2Ugewo+Pj4+Pj4gKyAgICAgICAgICAgICAgICB1bnBpbl91c2VyX3BhZ2VzKHBhZ2VfbGlz
dCwgcGlubmVkKTsKPj4+Pj4+ICsgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPj4+Pj4+
ICsgICAgICAgICAgICB9Cj4+Pj4+PiAgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+Pj4+ICsg
ICAgICAgIH0KPj4+Pj4+ICsgICAgICAgIG5jaHVua3MrKzsKPj4+Pj4+ICAgICAgICAgICAgICBp
ZiAoIWxhc3RfcGZuKQo+Pj4+Pj4gICAgICAgICAgICAgICAgbWFwX3BmbiA9IHBhZ2VfdG9fcGZu
KHBhZ2VfbGlzdFswXSk7Cj4+Pj4+PiAgICAtICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcmV0OyBp
KyspIHsKPj4+Pj4+ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwaW5uZWQ7IGkrKykgewo+Pj4+
Pj4gICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyB0aGlzX3BmbiA9IHBhZ2VfdG9fcGZuKHBh
Z2VfbGlzdFtpXSk7Cj4+Pj4+PiAgICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4+Pj4+PiAgICAg
ICAgICAgICAgICAgIGlmIChsYXN0X3BmbiAmJiAodGhpc19wZm4gIT0gbGFzdF9wZm4gKyAxKSkg
ewo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIC8qIFBpbiBhIGNvbnRpZ3VvdXMgY2h1bmsgb2Yg
bWVtb3J5ICovCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgY3NpemUgPSAobGFzdF9wZm4gLSBt
YXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsKPj4+Pj4+IC0gICAgICAgICAgICAgICAgaWYgKHZo
b3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplLAo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPj4+Pj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICBtc2ctPnBlcm0pKQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICByZXQgPSB2aG9zdF92
ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1zZy0+cGVybSk7Cj4+Pj4+PiArICAgICAgICAgICAgICAgIGlmIChyZXQpIHsKPj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgIC8qCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
KiBVbnBpbiB0aGUgcGFnZXMgdGhhdCBhcmUgbGVmdCB1bm1hcHBlZAo+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICogZnJvbSB0aGlzIHBvaW50IG9uIGluIHRoZSBjdXJyZW50Cj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgKiBwYWdlX2xpc3QuIFRoZSByZW1haW5pbmcgb3V0c3RhbmRp
bmcKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAqIG9uZXMgd2hpY2ggbWF5IHN0cmlkZSBh
Y3Jvc3Mgc2V2ZXJhbAo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICogY2h1bmtzIHdpbGwg
YmUgY292ZXJlZCBpbiB0aGUgY29tbW9uCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgKiBl
cnJvciBwYXRoIHN1YnNlcXVlbnRseS4KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAqLwo+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlcygmcGFnZV9saXN0W2ld
LAo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlubmVkIC0gaSk7Cj4+Pj4+
Cj4+Pj4+IENhbiB3ZSBzaW1wbHkgZG8gbGFzdF9wZm4gPSB0aGlzX3BmbiBoZXJlPwo+Pj4+IE5v
cGUuIFRoZXkgYXJlIG5vdCBjb250aWd1b3VzIHNlZ21lbnRzIG9mIG1lbW9yeS4gTm90ZWQgdGhl
Cj4+Pj4gY29uZGl0aW9uYWwgKHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkgYmVpbmcgaGVsZCBo
ZXJlLgo+Pj4KPj4+IFJpZ2h0Lgo+Pj4KPj4+Cj4+Pj4+Cj4+Pj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gb3V0Owo+Pj4+Pj4gKyAgICAgICAgICAgICAgICB9Cj4+Pj4+PiArCj4+Pj4+
PiAgICAgICAgICAgICAgICAgICAgbWFwX3BmbiA9IHRoaXNfcGZuOwo+Pj4+Pj4gICAgICAgICAg
ICAgICAgICAgIGlvdmEgKz0gY3NpemU7Cj4+Pj4+PiArICAgICAgICAgICAgICAgIG5jaHVua3Mg
PSAwOwo+Pj4+Pj4gICAgICAgICAgICAgICAgfQo+Pj4+Pj4gICAgICAgICAgICAgICAgICBsYXN0
X3BmbiA9IHRoaXNfcGZuOwo+Pj4+Pj4gICAgICAgICAgICB9Cj4+Pj4+PiAgICAtICAgICAgICBj
dXJfYmFzZSArPSByZXQgPDwgUEFHRV9TSElGVDsKPj4+Pj4+IC0gICAgICAgIG5wYWdlcyAtPSBy
ZXQ7Cj4+Pj4+PiArICAgICAgICBjdXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPj4+
Pj4+ICsgICAgICAgIG5wYWdlcyAtPSBwaW5uZWQ7Cj4+Pj4+PiAgICAgICAgfQo+Pj4+Pj4gICAg
ICAgICAgLyogUGluIHRoZSByZXN0IGNodW5rICovCj4+Pj4+PiBAQCAtNjYwLDEwICs2ODcsMjYg
QEAgc3RhdGljIGludAo+Pj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgbWFwX3BmbiA8PCBQ
QUdFX1NISUZULCBtc2ctPnBlcm0pOwo+Pj4+Pj4gICAgb3V0Ogo+Pj4+Pj4gICAgICAgIGlmIChy
ZXQpIHsKPj4+Pj4+ICsgICAgICAgIGlmIChuY2h1bmtzICYmIGxhc3RfcGZuKSB7Cj4+Pj4+Cj4+
Pj4+IEFueSByZWFzb24gZm9yIGNoZWNraW5nIGxhc3RfcGZuIGhlcmU/Cj4+Pj4+Cj4+Pj4+IE5v
dGUgdGhhdCB3ZSBkaWQ6Cj4+Pj4+Cj4+Pj4+ICsgICAgICAgIG5jaHVua3MrKzsKPj4+Pj4KPj4+
Pj4gICAgICAgICAgIGlmICghbGFzdF9wZm4pCj4+Pj4+ICAgICAgICAgICAgICAgbWFwX3BmbiA9
IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4+Pj4gSXQncyBmb3IgZXhwbGljaXQgY29kaW5n
IHRvIG1ha2Ugc3VyZSB0aGlzIGNvbW1vbiBlcnJvciBwYXRoIGNhbiBiZQo+Pj4+IHJldXNlZCBu
byBtYXR0ZXIgaWYgbGFzdF9wZm4gaGFzIGEgc2FuZSB2YWx1ZSBhc3NpZ25lZCBvciBub3QuIEkg
Y2FuCj4+Pj4gY2hhbmdlIGl0IHRvIGFuIGltcGxpY2l0IFdBUk5fT04oKSBpZiBuZWVkIGJlLgo+
Pj4KPj4+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZC4gQSBxdWVzdGlvbiwgd2hlbiB3
aWxsIHdlIGdldCBuY2h1bmtzICE9Cj4+PiAwIGJ1dCBsYXN0X3BmbiA9PSAwPwo+PiBUaGUgY3Vy
cmVudCBjb2RlIGhhcyBpbXBsaWNpdCBhc3N1bXB0aW9uIHRoYXQgbmNodW5rcyAhPSAwIGluZmVy
cyBsYXN0X3Bmbgo+PiAhPSAwLiBIb3dldmVyLCB0aGlzIGFzc3VtcHRpb24gY291bGQgYnJlYWsg
c3ViamVjdCB0byBjb2RlIHN0cnVjdHVyZSBjaGFuZ2VzCj4+IGZvciBlZy4gZmFpbHVyZSBtYXkg
b2NjdXIgYWZ0ZXIgdGhlIGluY3JlbWVudCBvZiBuY2h1bmtzIGFuZCBiZWZvcmUgdGhlIGZvcgo+
PiBsb29wLiBJIGZlZWwgaXQnZCBiZSB0aGUgYmVzdCB0byBjYXB0dXJlIHRoaXMgYXNzdW1wdGlv
biB3aXRoIHNvbWV0aGluZwo+PiBleHBsaWNpdC4KPj4KPj4gLVNpd2VpCj4gaWYgaGVyZSBpc24n
dCByZWFsbHkgYW4gZXhwbGljaXQgd2F5IHRvIGRvY3VtZW50IGFzc3VtcHRpb25zLAo+IGl0J3Mg
YSB3YXkgdG8gYXZvaWQgYXNzdW1wdGlvbnMgOikKQWdyZWVkLiBJIHdhcyByZWZlcnJpbmcgdG8g
dGhlIHYzIHBhdGNoIHdoaWNoIGhhZCB0dXJuZWQgdGhlIGRlZmVuc2l2ZSAKY29kaW5nIHRvIGEg
V0FSTl9PTigpLgoKPiBBIHdheSB0byBkb2N1bWVudCBhc3N1bXB0aW9ucyBpcyBwcm9iYWJseSBC
VUdfT04uCklmIHlvdSdyZSBmaW5lIHdpdGggYmVsb3cgY2hlY2twYXRjaCB3YXJuaW5nIEkgY2Fu
IGRlZmluaXRlbHkgY29udmVydCBpdCAKdG8gYSBCVUdfT046CgpXQVJOSU5HOiBBdm9pZCBjcmFz
aGluZyB0aGUga2VybmVsIC0gdHJ5IHVzaW5nIFdBUk5fT04gJiByZWNvdmVyeSBjb2RlIApyYXRo
ZXIgdGhhbiBCVUcoKSBvciBCVUdfT04oKQoKTGV0IG1lIGtub3cgaWYgSSBuZWVkIHRvIHBvc3Qg
YSB2NCBmb3IgdGhpcyBuaXQuCgpUaGFua3MKLVNpd2VpCgoKCj4KPj4+IFRoYW5rcwo+Pj4KPj4+
Cj4+Pj4gVGhhbmtzLAo+Pj4+IC1TaXdlaQo+Pj4+Cj4+Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+Pgo+
Pj4+Pgo+Pj4+Pj4gKyAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcGZuOwo+Pj4+Pj4gKwo+Pj4+
Pj4gKyAgICAgICAgICAgIC8qCj4+Pj4+PiArICAgICAgICAgICAgICogVW5waW4gdGhlIG91dHN0
YW5kaW5nIHBhZ2VzIHdoaWNoIGFyZSB5ZXQgdG8gYmUKPj4+Pj4+ICsgICAgICAgICAgICAgKiBt
YXBwZWQgYnV0IGhhdmVuJ3QgZHVlIHRvIHZkcGFfbWFwKCkgb3IKPj4+Pj4+ICsgICAgICAgICAg
ICAgKiBwaW5fdXNlcl9wYWdlcygpIGZhaWx1cmUuCj4+Pj4+PiArICAgICAgICAgICAgICoKPj4+
Pj4+ICsgICAgICAgICAgICAgKiBNYXBwZWQgcGFnZXMgYXJlIGFjY291bnRlZCBpbiB2ZHBhX21h
cCgpLCBoZW5jZQo+Pj4+Pj4gKyAgICAgICAgICAgICAqIHRoZSBjb3JyZXNwb25kaW5nIHVucGlu
bmluZyB3aWxsIGJlIGhhbmRsZWQgYnkKPj4+Pj4+ICsgICAgICAgICAgICAgKiB2ZHBhX3VubWFw
KCkuCj4+Pj4+PiArICAgICAgICAgICAgICovCj4+Pj4+PiArICAgICAgICAgICAgZm9yIChwZm4g
PSBtYXBfcGZuOyBwZm4gPD0gbGFzdF9wZm47IHBmbisrKQo+Pj4+Pj4gKyAgICAgICAgICAgICAg
ICB1bnBpbl91c2VyX3BhZ2UocGZuX3RvX3BhZ2UocGZuKSk7Cj4+Pj4+PiArICAgICAgICB9Cj4+
Pj4+PiAgICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwgbXNnLT5pb3ZhLCBtc2ctPnNpemUp
Owo+Pj4+Pj4gLSAgICAgICAgYXRvbWljNjRfc3ViKG5wYWdlcywgJmRldi0+bW0tPnBpbm5lZF92
bSk7Cj4+Pj4+PiAgICAgICAgfQo+Pj4+Pj4gK3VubG9jazoKPj4+Pj4+ICAgICAgICBtbWFwX3Jl
YWRfdW5sb2NrKGRldi0+bW0pOwo+Pj4+Pj4gK2ZyZWU6Cj4+Pj4+PiAgICAgICAgZnJlZV9wYWdl
KCh1bnNpZ25lZCBsb25nKXBhZ2VfbGlzdCk7Cj4+Pj4+PiAgICAgICAgcmV0dXJuIHJldDsKPj4+
Pj4+ICAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
