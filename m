Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822DACDB47E
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 01:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7F9783639;
	Thu, 19 Oct 2023 01:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7F9783639
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=z0MyfC57
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fuOecEdKeJ6v; Thu, 19 Oct 2023 01:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E9C083490;
	Thu, 19 Oct 2023 01:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E9C083490
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6290EC0039;
	Thu, 19 Oct 2023 01:13:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DAA0C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D691483490
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D691483490
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFKS24IHtjDp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:00 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73EA983168
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73EA983168
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IImtCv006120; Thu, 19 Oct 2023 01:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=IDcJMsPyKM2GyU6ZB9/xv6m5PTlDgNod8sH4SwkNOK4=;
 b=z0MyfC57BJET8EO662IqosLoeOfIsbcyafH9SeSUdXPB/2uQ0EN8gkVx5CjtQOEOBaUd
 BYwMV555SIEovOWW9lTiPMw+7DgYI1WreSdSuKDmDZ+GitDr8iYRvU59ezJ2VdTE7BaT
 x+C0vQKLx6Z0snijcpMPmi0p5uYW67p56WL6bCk3/QvfZ5PGnApJTKy3p5iP/O8YnJjo
 nJaFqWTE1+0st3CzEe+uPH4TJpLA7CjsrsW6+d3DswHTWe7AT9g4R3/xW3CBy+uRe8nj
 F/N12RN0emJAdUJbrIwROm+inIB73u6en5IDHeTf69nBjfb1aFAA3bNIS2e+Qfj1GbIP vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynh3n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 01:12:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39J0UpS1015251; Thu, 19 Oct 2023 01:12:58 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3trg1h8w2d-3; Thu, 19 Oct 2023 01:12:58 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v3 2/5] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Date: Wed, 18 Oct 2023 18:10:15 -0700
Message-Id: <1697677818-11371-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
References: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190007
X-Proofpoint-GUID: RjbT_jVlQfwqzkpHOXDLP1l8Fkz6q7r8
X-Proofpoint-ORIG-GUID: RjbT_jVlQfwqzkpHOXDLP1l8Fkz6q7r8
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
bWVudGF0aW9uCm1heSBuZWVkIHRvIHJlc3RvcmUgaW90bGIgbWFwcGluZyB0byB0aGUgaW5pdGlh
bCBvciBkZWZhdWx0IHN0YXRlCnVzaW5nIHRoZSAucmVzZXRfbWFwIG9wLCBhcyBpdCdzIGRlc2ly
YWJsZSBmb3Igc29tZSBwYXJlbnQgZGV2aWNlcwp0byBzb2xlbHkgbWFuaXB1bGF0ZSBtYXBwaW5n
cyBieSBpdHMgb3duLCBpbmRlcGVuZGVudCBvZiB2aXJ0aW8gZGV2aWNlCnN0YXRlLiBGb3IgaW5z
dGFuY2UsIGRldmljZSByZXNldCBkb2VzIG5vdCBjYXVzZSBtYXBwaW5nIGdvIGF3YXkgb24Kc3Vj
aCBJT1RMQiBtb2RlbCBpbiBuZWVkIG9mIHBlcnNpc3RlbnQgbWFwcGluZy4gQmVmb3JlIHZob3N0
LXZkcGEKaXMgZ29pbmcgYXdheSwgZ2l2ZSB0aGVtIGEgY2hhbmNlIHRvIHJlc2V0IGlvdGxiIGJh
Y2sgdG8gdGhlIGluaXRpYWwKc3RhdGUgaW4gdmhvc3RfdmRwYV9jbGVhbnVwKCkuCgpTaWduZWQt
b2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+CkFja2VkLWJ5OiBFdWdl
bmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3Zob3N0L3ZkcGEu
YyB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
YwppbmRleCA4NTE1MzVmNTdiOTUuLmEzZjgxNjBjOTgwNyAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKQEAgLTEzMSw2ICsxMzEsMTUg
QEAgc3RhdGljIHN0cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCiAJcmV0dXJuIHZob3N0X3ZkcGFfYWxsb2NfYXModiwgYXNp
ZCk7CiB9CiAKK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0cnVjdCB2aG9zdF92
ZHBhICp2LCB1MzIgYXNpZCkKK3sKKwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBh
OworCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKKwor
CWlmIChvcHMtPnJlc2V0X21hcCkKKwkJb3BzLT5yZXNldF9tYXAodmRwYSwgYXNpZCk7Cit9CisK
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUz
MiBhc2lkKQogewogCXN0cnVjdCB2aG9zdF92ZHBhX2FzICphcyA9IGFzaWRfdG9fYXModiwgYXNp
ZCk7CkBAIC0xNDAsNiArMTQ5LDEzIEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZW1vdmVfYXMo
c3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQogCiAJaGxpc3RfZGVsKCZhcy0+aGFzaF9s
aW5rKTsKIAl2aG9zdF92ZHBhX2lvdGxiX3VubWFwKHYsICZhcy0+aW90bGIsIDBVTEwsIDBVTEwg
LSAxLCBhc2lkKTsKKwkvKgorCSAqIERldmljZXMgd2l0aCB2ZW5kb3Igc3BlY2lmaWMgSU9NTVUg
bWF5IG5lZWQgdG8gcmVzdG9yZQorCSAqIGlvdGxiIHRvIHRoZSBpbml0aWFsIG9yIGRlZmF1bHQg
c3RhdGUgd2hpY2ggaXMgbm90IGRvbmUKKwkgKiB0aHJvdWdoIGRldmljZSByZXNldCwgYXMgdGhl
IElPVExCIG1hcHBpbmcgbWFuaXB1bGF0aW9uCisJICogY291bGQgYmUgZGVjb3VwbGVkIGZyb20g
dGhlIHZpcnRpbyBkZXZpY2UgbGlmZSBjeWNsZS4KKwkgKi8KKwl2aG9zdF92ZHBhX3Jlc2V0X21h
cCh2LCBhc2lkKTsKIAlrZnJlZShhcyk7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMzkuMwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
