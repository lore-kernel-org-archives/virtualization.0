Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A24CDB484
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 01:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24A1D419D9;
	Thu, 19 Oct 2023 01:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24A1D419D9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VlV9zGyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yCNS_Bfu7GZI; Thu, 19 Oct 2023 01:13:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9603D419D8;
	Thu, 19 Oct 2023 01:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9603D419D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25BA9C008C;
	Thu, 19 Oct 2023 01:13:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14CFAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7A4883495
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7A4883495
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VlV9zGyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtwJMY5gErms
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04FCE8318C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04FCE8318C
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IIp6h9018131; Thu, 19 Oct 2023 01:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=EDhfB7JA2J6D7sXgXuclzb2hlADtZpOfMMez4ap+xqE=;
 b=VlV9zGyJHTWGOwwYaSB8DBwctBW7zyZeKYccK6N6hsLSNERZWDUskXEEhzakeiuI17St
 TVvMbzJT9WBlnmybPa1USj0Ytq0przeiMF5bVRkU3Xjbvn4uoeNEnwB3APaB9K0GSmvo
 mhPQUi/UZQSLKG6MXU5lTnOHqmJTCbrZv3EZqL0LYFm+K/gYkRSOPtr9oSuCpY+GKNPW
 FaKlzsy+MbojNwuINugPEkqKyuSimI/MM2AXvcljE2gUPBnNnTp927nrO96XNsHiHTOG
 sERNLAh7I5y4LcRL52IdOiSvsRmSRfkozgXnXaRIpk4zmkW+2kras/phTECPr1FiVAfj ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu95mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 01:12:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39J0UpS0015251; Thu, 19 Oct 2023 01:12:58 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3trg1h8w2d-2; Thu, 19 Oct 2023 01:12:58 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v3 1/5] vdpa: introduce .reset_map operation callback
Date: Wed, 18 Oct 2023 18:10:14 -0700
Message-Id: <1697677818-11371-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
References: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=993 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190007
X-Proofpoint-GUID: Yq2AfOlhAYoIBciWxMaPxlaCO_aTQkPR
X-Proofpoint-ORIG-GUID: Yq2AfOlhAYoIBciWxMaPxlaCO_aTQkPR
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
