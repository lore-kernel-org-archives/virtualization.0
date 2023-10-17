Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE551CDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 00:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60D7760648;
	Tue, 17 Oct 2023 00:42:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60D7760648
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fyR8kgNa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em-0WUnjWYOM; Tue, 17 Oct 2023 00:42:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA628600CA;
	Tue, 17 Oct 2023 00:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA628600CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B178DC0039;
	Tue, 17 Oct 2023 00:42:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F21B7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA81560EDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA81560EDD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02yAflMKoyxk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A56E60B2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A56E60B2A
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKO29L011029; Tue, 17 Oct 2023 00:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=EDhfB7JA2J6D7sXgXuclzb2hlADtZpOfMMez4ap+xqE=;
 b=fyR8kgNauCTuMLIiF65GWmNQj7Or2UTtdmYu0wEumqu2er1M6ifjo35zBYk2rVBOKBvE
 RpwiVpjJlcmaQ4/WSvx25pIi6r9HG6R0qzOhMdxIxzwRsE0Jy/2fw+X1e6fQgsim0ejy
 salnmQJibZHWzKIIUrayIDC3zma/Rz3+21w4Df2yYab5A2APaWMhZh4rii70C7uvI9Mr
 ecZ+dINbmDgKbR7VZasYXHiK6+7GW0E9Ht/B/gjxZJ79owr60/TpuPu0s4CToo08AG7L
 Epg0eIj2QZS9VIlJYZ/AFzmex9q3COcDw+Ib8CK2vPk/Ix8cZxhSmWIO5S6Tdx/Rw97i Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjync01q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 00:42:38 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GNB27I027141; Tue, 17 Oct 2023 00:42:37 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3trg535bja-2; Tue, 17 Oct 2023 00:42:37 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com, sgarzare@redhat.com
Subject: [PATCH v2 1/4] vdpa: introduce .reset_map operation callback
Date: Mon, 16 Oct 2023 17:39:54 -0700
Message-Id: <1697503197-15935-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
References: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=992 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-GUID: 6v4slETenWCoQQ5DyNOOwRHPhACqeQXc
X-Proofpoint-ORIG-GUID: 6v4slETenWCoQQ5DyNOOwRHPhACqeQXc
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

RGV2aWNlIHNwZWNpZmljIElPTU1VIHBhcmVudCBkcml2ZXIgd2hvIHdpc2hlcyB0byBzZWUgbWFw
cGluZyB0byBiZQpkZWNvdXBsZWQgZnJvbSB2aXJ0aW8gb3IgdmRwYSBkZXZpY2UgbGlmZSBjeWNs
ZSAoZGV2aWNlIHJlc2V0KSBjYW4gdXNlCml0IHRvIHJlc3RvcmUgbWVtb3J5IG1hcHBpbmcgaW4g
dGhlIGRldmljZSBJT01NVSB0byB0aGUgaW5pdGlhbCBvcgpkZWZhdWx0IHN0YXRlLiBUaGUgcmVz
ZXQgb2YgbWFwcGluZyBpcyBkb25lIHBlciBhZGRyZXNzIHNwYWNlIGJhc2lzLgoKVGhlIHJlYXNv
biB3aHkgYSBzZXBhcmF0ZSAucmVzZXRfbWFwIG9wIGlzIGludHJvZHVjZWQgaXMgYmVjYXVzZSB0
aGlzCmFsbG93cyBhIHNpbXBsZSBvbi1jaGlwIElPTU1VIG1vZGVsIHdpdGhvdXQgZXhwb3Npbmcg
dG9vIG11Y2ggZGV2aWNlCmltcGxlbWVudGF0aW9uIGRldGFpbHMgdG8gdGhlIHVwcGVyIHZkcGEg
bGF5ZXIuIFRoZSAuZG1hX21hcC91bm1hcCBvcgouc2V0X21hcCBkcml2ZXIgQVBJIGlzIG1lYW50
IHRvIGJlIHVzZWQgdG8gbWFuaXB1bGF0ZSB0aGUgSU9UTEIgbWFwcGluZ3MsCmFuZCBoYXMgYmVl
biBhYnN0cmFjdGVkIGluIGEgd2F5IHNpbWlsYXIgdG8gaG93IGEgcmVhbCBJT01NVSBkZXZpY2Ug
bWFwcwpvciB1bm1hcHMgcGFnZXMgZm9yIGNlcnRhaW4gbWVtb3J5IHJhbmdlcy4gSG93ZXZlciwg
YXBhcnQgZnJvbSB0aGlzIHRoZXJlCmFsc28gZXhpc3RzIG90aGVyIG1hcHBpbmcgbmVlZHMsIGlu
IHdoaWNoIGNhc2UgMToxIHBhc3N0aHJvdWdoIG1hcHBpbmcKaGFzIHRvIGJlIHVzZWQgYnkgb3Ro
ZXIgdXNlcnMgKHJlYWQgdmlydGlvLXZkcGEpLiBUbyBlYXNlIHBhcmVudC92ZW5kb3IKZHJpdmVy
IGltcGxlbWVudGF0aW9uIGFuZCB0byBhdm9pZCBhYnVzaW5nIERNQSBvcHMgaW4gYW4gdW5leHBh
Y3RlZCB3YXksCnRoZXNlIG9uLWNoaXAgSU9NTVUgZGV2aWNlcyBjYW4gc3RhcnQgd2l0aCAxOjEg
cGFzc3Rocm91Z2ggbWFwcGluZyBtb2RlCmluaXRpYWxseSBhdCB0aGUgaGUgdGltZSBvZiBjcmVh
dGlvbi4gVGhlbiB0aGUgLnJlc2V0X21hcCBvcCBjYW4gYmUgdXNlZAp0byBzd2l0Y2ggaW90bGIg
YmFjayB0byB0aGlzIGluaXRpYWwgc3RhdGUgd2l0aG91dCBoYXZpbmcgdG8gZXhwb3NlIGEKY29t
cGxleCB0d28tZGltZW5zaW9uYWwgSU9NTVUgZGV2aWNlIG1vZGVsLgoKVGhlIC5yZXNldF9tYXAg
aXMgbm90IGEgTVVTVCBmb3IgZXZlcnkgcGFyZW50IHRoYXQgaW1wbGVtZW50cyB0aGUKLmRtYV9t
YXAgb3IgLnNldF9tYXAgQVBJLCBiZWNhdXNlIHRoZXJlIGNvdWxkIGJlIHNvZnR3YXJlIHZEUEEg
ZGV2aWNlcwood2hpY2ggaGFzIHVzZV92YT10cnVlKSB0aGF0IGRvbid0IGhhdmUgdG8gcGluIGtl
cm5lbCBtZW1vcnkgc28gdGhleQpkb24ndCBjYXJlIG11Y2ggYWJvdXQgaGlnaCBtYXBwaW5nIGNv
c3QgZHVyaW5nIGRldmljZSByZXNldC4gQW5kIHRob3NlCnNvZnR3YXJlIGRldmljZXMgbWF5IGhh
dmUgYWxzbyBpbXBsZW1lbnRlZCB0aGVpciBvd24gRE1BIG9wcywgc28gZG9uJ3QKaGF2ZSB0byB1
c2UgLnJlc2V0X21hcCB0byBhY2hpZXZlIGEgc2ltcGxlIElPTU1VIGRldmljZSBtb2RlbCBmb3Ig
MToxCnBhc3N0aHJvdWdoIG1hcHBpbmcsIGVpdGhlci4KClNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVy
ZXptYUByZWRoYXQuY29tPgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KLS0tCiBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmgg
Yi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAppbmRleCBkMzc2MzA5Yjk5Y2YuLjI2YWU2YWUxZWFjMyAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKKysrIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKQEAgLTMyNyw2ICszMjcsMTUgQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewogICoJCQkJQGlv
dmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQKICAqCQkJCUBzaXplOiBzaXplIG9mIHRoZSBhcmVhCiAg
KgkJCQlSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCisgKiBAcmVz
ZXRfbWFwOgkJCVJlc2V0IGRldmljZSBtZW1vcnkgbWFwcGluZyB0byB0aGUgZGVmYXVsdAorICoJ
CQkJc3RhdGUgKG9wdGlvbmFsKQorICoJCQkJTmVlZGVkIGZvciBkZXZpY2VzIHRoYXQgYXJlIHVz
aW5nIGRldmljZQorICoJCQkJc3BlY2lmaWMgRE1BIHRyYW5zbGF0aW9uIGFuZCBwcmVmZXIgbWFw
cGluZworICoJCQkJdG8gYmUgZGVjb3VwbGVkIGZyb20gdGhlIHZpcnRpbyBsaWZlIGN5Y2xlLAor
ICoJCQkJaS5lLiBkZXZpY2UgLnJlc2V0IG9wIGRvZXMgbm90IHJlc2V0IG1hcHBpbmcKKyAqCQkJ
CUB2ZGV2OiB2ZHBhIGRldmljZQorICoJCQkJQGFzaWQ6IGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmll
cgorICoJCQkJUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQogICog
QGdldF92cV9kbWFfZGV2OgkJR2V0IHRoZSBkbWEgZGV2aWNlIGZvciBhIHNwZWNpZmljCiAgKgkJ
CQl2aXJ0cXVldWUgKG9wdGlvbmFsKQogICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCkBAIC00MDUs
NiArNDE0LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7CiAJCSAgICAgICB1NjQgaW92YSwg
dTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9wYXF1ZSk7CiAJaW50ICgqZG1hX3Vu
bWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBhc2lkLAogCQkJIHU2
NCBpb3ZhLCB1NjQgc2l6ZSk7CisJaW50ICgqcmVzZXRfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKIAlpbnQgKCpzZXRfZ3JvdXBfYXNpZCkoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgZ3JvdXAsCiAJCQkgICAgICB1bnNpZ25l
ZCBpbnQgYXNpZCk7CiAJc3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rldikoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKLS0gCjIuMzkuMwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
