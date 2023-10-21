Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D002C00A98
	for <virtualization@archiver.kernel.org>; Sat, 21 Oct 2023 09:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F3AD6FA38;
	Sat, 21 Oct 2023 09:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F3AD6FA38
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fzHvb7F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsX-o7Z4Qybv; Sat, 21 Oct 2023 09:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D48661288;
	Sat, 21 Oct 2023 09:28:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D48661288
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68B37C0039;
	Sat, 21 Oct 2023 09:28:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DDE1C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3F714F03C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3F714F03C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fzHvb7F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naUeXm0J5cJx
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2ACE4F0B6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Oct 2023 09:28:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2ACE4F0B6
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39L5Oo6K023901; Sat, 21 Oct 2023 09:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=XMke14vYG8UhRAuK8/FbiZ7AEIT4nF/4fIUeZ85zpTE=;
 b=fzHvb7F5SlWoKTdm48UF9vUnpOg2SDxFkTj/7mL1TiWElm5CaZIxELBDA6dXZzK0B31o
 gAlBlUyzThzC6oCzc1tlXqJ85EtinOOukGM+eCYPUmknLySWNJT6XznPgdf7Q2dNaudW
 l7ea2C0USn9pkZYg+nBDMytNgGZdioticg1uukqLOOcMVncWgaaJC4+zf3TOVkI66/Ht
 3psvPOEqfOy3cvod9wnyXelOpkP66E1mEKYcAO3MY7ZoKuDWDSfiLlxJN17GcheQGfsF
 AxxhFjNYrA5M1/hIAPLqHUyln5lljK0MsK/Kq5gml00izyE+BV5Gh3tg3y0g01MroHPA 1g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcrbv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 09:28:20 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39L6FU6E019120; Sat, 21 Oct 2023 09:28:20 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3tv532gf44-3; Sat, 21 Oct 2023 09:28:20 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v4 2/7] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Date: Sat, 21 Oct 2023 02:25:14 -0700
Message-Id: <1697880319-4937-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210086
X-Proofpoint-GUID: PZpPIxEzfvIjigMl35SlSAAYSgzW_BtQ
X-Proofpoint-ORIG-GUID: PZpPIxEzfvIjigMl35SlSAAYSgzW_BtQ
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

RGV2aWNlcyB3aXRoIG9uLWNoaXAgSU9NTVUgb3IgdmVuZG9yIHNwZWNpZmljIElPVExCIGltcGxl
bWVudGF0aW9uIG1heQpuZWVkIHRvIHJlc3RvcmUgaW90bGIgbWFwcGluZyB0byB0aGUgaW5pdGlh
bCBvciBkZWZhdWx0IHN0YXRlIHVzaW5nIHRoZQoucmVzZXRfbWFwIG9wLCBhcyBpdCdzIGRlc2ly
YWJsZSBmb3Igc29tZSBwYXJlbnQgZGV2aWNlcyB0byBub3Qgd29yawp3aXRoIERNQSBvcHMgYW5k
IG1haW50YWluIGEgc2ltcGxlIElPTU1VIG1vZGVsIHdpdGggLnJlc2V0X21hcC4gSW4KcGFydGlj
dWxhciwgZGV2aWNlIHJlc2V0IHNob3VsZCBub3QgY2F1c2UgbWFwcGluZyB0byBnbyBhd2F5IG9u
IHN1Y2gKSU9UTEIgbW9kZWwsIHNvIHBlcnNpc3RlbnQgbWFwcGluZyBpcyBpbXBsaWVkIGFjcm9z
cyByZXNldC4gQmVmb3JlIHRoZQp1c2Vyc3BhY2UgcHJvY2VzcyB1c2luZyB2aG9zdC12ZHBhIGlz
IGdvbmUsIGdpdmUgaXQgYSBjaGFuY2UgdG8gcmVzZXQKaW90bGIgYmFjayB0byB0aGUgaW5pdGlh
bCBzdGF0ZSBpbiB2aG9zdF92ZHBhX2NsZWFudXAoKS4KClNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVy
ZXptYUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTcgKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwppbmRleCA4NTE1MzVm
NTdiOTUuLmM2YmZlOWJkZGU0MiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKQEAgLTEzMSw2ICsxMzEsMTUgQEAgc3RhdGljIHN0cnVj
dCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMoc3RydWN0IHZob3N0X3Zk
cGEgKnYsCiAJcmV0dXJuIHZob3N0X3ZkcGFfYWxsb2NfYXModiwgYXNpZCk7CiB9CiAKK3N0YXRp
YyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNp
ZCkKK3sKKwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOworCWNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKKworCWlmIChvcHMtPnJlc2V0
X21hcCkKKwkJb3BzLT5yZXNldF9tYXAodmRwYSwgYXNpZCk7Cit9CisKIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQogewogCXN0
cnVjdCB2aG9zdF92ZHBhX2FzICphcyA9IGFzaWRfdG9fYXModiwgYXNpZCk7CkBAIC0xNDAsNiAr
MTQ5LDE0IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3Zk
cGEgKnYsIHUzMiBhc2lkKQogCiAJaGxpc3RfZGVsKCZhcy0+aGFzaF9saW5rKTsKIAl2aG9zdF92
ZHBhX2lvdGxiX3VubWFwKHYsICZhcy0+aW90bGIsIDBVTEwsIDBVTEwgLSAxLCBhc2lkKTsKKwkv
KgorCSAqIERldmljZXMgd2l0aCB2ZW5kb3Igc3BlY2lmaWMgSU9NTVUgbWF5IG5lZWQgdG8gcmVz
dG9yZQorCSAqIGlvdGxiIHRvIHRoZSBpbml0aWFsIG9yIGRlZmF1bHQgc3RhdGUsIHdoaWNoIGNh
bm5vdCBiZQorCSAqIGNsZWFuZWQgdXAgaW4gdGhlIGFsbCByYW5nZSB1bm1hcCBjYWxsIGFib3Zl
LiBHaXZlIHRoZW0KKwkgKiBhIGNoYW5jZSB0byBjbGVhbiB1cCBvciByZXNldCB0aGUgbWFwIHRv
IHRoZSBkZXNpcmVkCisJICogc3RhdGUuCisJICovCisJdmhvc3RfdmRwYV9yZXNldF9tYXAodiwg
YXNpZCk7CiAJa2ZyZWUoYXMpOwogCiAJcmV0dXJuIDA7Ci0tIAoyLjM5LjMKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
