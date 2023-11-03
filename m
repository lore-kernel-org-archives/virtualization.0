Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4963C41535
	for <virtualization@archiver.kernel.org>; Fri,  3 Nov 2023 12:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 507B74F3EE;
	Fri,  3 Nov 2023 12:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 507B74F3EE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=X0diECcl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BD5VhTnrgfM1; Fri,  3 Nov 2023 12:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C219A4F19A;
	Fri,  3 Nov 2023 12:26:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C219A4F19A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACB0C0071;
	Fri,  3 Nov 2023 12:26:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B18C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FA5A432DE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FA5A432DE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=X0diECcl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayYbuJKGGaSU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:26:39 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B390943200
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Nov 2023 12:26:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B390943200
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2NOgrf010612; Fri, 3 Nov 2023 12:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=zgHrw6VGeyWMel+aZHOfhG+ULGqf048GVY0ovi8BZ68=;
 b=X0diECclx6eH3KP9Gq39pZ9xuHFiYx69oCscDi9jxdtWPxA+EjKA99MgkizkLJGziItB
 550XC+1GWeoiwK3PqMNdXwSAiGxetQXGZN3roNisALsB+/49ct03qbKDNWmpZs7JzV4W
 R1fq+ylmE+vvhoY+DSFWZcV3AiLhcq+HchpYHpH81l/xOtrjctOXo7USwuZ6cybDov5+
 vETsO3j+yeX/l/iSZy2U5RKdfZYbyoL+LrDRvSqqNy096Omf8I9t5PEpm0ECX8EsEoJO
 iYWviV5NkhOmQKhEeTfXr98uKIV2vPR5sFYozuXv6gqKbOmwguYicT4UkzChIpmZiNO1 tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuuks6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 12:26:34 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3AlWk9001040; Fri, 3 Nov 2023 12:26:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrab69e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 12:26:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3CQXvT039969;
 Fri, 3 Nov 2023 12:26:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3u0rrab66c-1; Fri, 03 Nov 2023 12:26:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
Date: Fri,  3 Nov 2023 05:26:27 -0700
Message-Id: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030104
X-Proofpoint-GUID: oBBaOlEfpjy3wDarKlIvSnjZvFlr3MBP
X-Proofpoint-ORIG-GUID: oBBaOlEfpjy3wDarKlIvSnjZvFlr3MBP
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Eli Cohen <elic@nvidia.com>
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

bWx4NV92ZHBhIGRvZXMgbm90IHByZXNlcnZlIHVzZXJsYW5kJ3MgdmlldyBvZiB2cmluZyBiYXNl
IGZvciB0aGUgY29udHJvbApxdWV1ZSBpbiB0aGUgZm9sbG93aW5nIHNlcXVlbmNlOgoKaW9jdGwg
VkhPU1RfU0VUX1ZSSU5HX0JBU0UKaW9jdGwgVkhPU1RfVkRQQV9TRVRfU1RBVFVTIFZJUlRJT19D
T05GSUdfU19EUklWRVJfT0sKICBtbHg1X3ZkcGFfc2V0X3N0YXR1cygpCiAgICBzZXR1cF9jdnFf
dnJpbmcoKQogICAgICB2cmluZ2hfaW5pdF9pb3RsYigpCiAgICAgICAgdnJpbmdoX2luaXRfa2Vy
bigpCiAgICAgICAgICB2cmgtPmxhc3RfYXZhaWxfaWR4ID0gMDsKaW9jdGwgVkhPU1RfR0VUX1ZS
SU5HX0JBU0UKClRvIGZpeCwgcmVzdG9yZSB0aGUgdmFsdWUgb2YgY3ZxLT52cmluZy5sYXN0X2F2
YWlsX2lkeCBhZnRlciBjYWxsaW5nCnZyaW5naF9pbml0X2lvdGxiLgoKRml4ZXM6IDUyNjI5MTJl
ZjNjZiAoInZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIGNvbnRyb2wgVlEgYW5kIE1BQyBzZXR0
aW5nIikKClNpZ25lZC1vZmYtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNs
ZS5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4
IDk0NjQ4OGI4OTg5Zi4uY2E5NzJhZjNjODlhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
CkBAIC0yNzk1LDEzICsyNzk1LDE4IEBAIHN0YXRpYyBpbnQgc2V0dXBfY3ZxX3ZyaW5nKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIAlzdHJ1Y3QgbWx4NV9jb250cm9sX3ZxICpjdnEgPSAm
bXZkZXYtPmN2cTsKIAlpbnQgZXJyID0gMDsKIAotCWlmIChtdmRldi0+YWN0dWFsX2ZlYXR1cmVz
ICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WUSkpCisJaWYgKG12ZGV2LT5hY3R1YWxfZmVh
dHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkgeworCQl1MTYgaWR4ID0gY3Zx
LT52cmluZy5sYXN0X2F2YWlsX2lkeDsKKwogCQllcnIgPSB2cmluZ2hfaW5pdF9pb3RsYigmY3Zx
LT52cmluZywgbXZkZXYtPmFjdHVhbF9mZWF0dXJlcywKIAkJCQkJTUxYNV9DVlFfTUFYX0VOVCwg
ZmFsc2UsCiAJCQkJCShzdHJ1Y3QgdnJpbmdfZGVzYyAqKSh1aW50cHRyX3QpY3ZxLT5kZXNjX2Fk
ZHIsCiAJCQkJCShzdHJ1Y3QgdnJpbmdfYXZhaWwgKikodWludHB0cl90KWN2cS0+ZHJpdmVyX2Fk
ZHIsCiAJCQkJCShzdHJ1Y3QgdnJpbmdfdXNlZCAqKSh1aW50cHRyX3QpY3ZxLT5kZXZpY2VfYWRk
cik7CiAKKwkJaWYgKCFlcnIpCisJCQljdnEtPnZyaW5nLmxhc3RfYXZhaWxfaWR4ID0gY3ZxLT52
cmluZy5sYXN0X3VzZWRfaWR4ID0gaWR4OworCX0KIAlyZXR1cm4gZXJyOwogfQogCi0tIAoyLjM5
LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
