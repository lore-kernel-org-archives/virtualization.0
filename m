Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E597BC25B6F
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E8A461125;
	Thu, 26 Oct 2023 07:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E8A461125
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Rs3lqwAo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ce8aAm4q7Am9; Thu, 26 Oct 2023 07:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE74561126;
	Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE74561126
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81012C0071;
	Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6BC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81E4F83096
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81E4F83096
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Rs3lqwAo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oMPSY0evHjjP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:28 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA57C8308D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA57C8308D
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q3FQZP004619; Thu, 26 Oct 2023 07:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=9BXLcHlC+mpIFJm+VhDktZctOK6MnG2fZvm6HmvyjLg=;
 b=Rs3lqwAo8Be3B4aEEFM9rMNfoKIV486hCTweqP6nrCkz4e8FgmE/a7lr26SNqfDobjY/
 W8YOmplnAw/v4QXV+57QrxcVaWv6+mYyUx+8oB404zKvoTCh3NIdG10QhaR2pQjHTJIy
 Hof4uaWs1gT19s/TZ7PfRyUo2co+HNr7LKxgW8Iam+PVGlcDbwau5BYSc6uCON64BPF8
 SUZfUF3JddMeGbzDt0QYBsoaz5GJZnKwwyJrumsthWZYyfV890sq2DKFXpxNqTzRpS6S
 jQeVcc00ZGvS1jEqwzLVsfQcbKvNmGWtOiw3f2Ke0bnR1iXUN0xds/CgDc+O0d7+wW8U cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e3a9uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:17:27 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39Q6tbAF015200; Thu, 26 Oct 2023 07:17:26 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3tv537t53r-2; Thu, 26 Oct 2023 07:17:26 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v5 1/7] vdpa: introduce .reset_map operation callback
Date: Thu, 26 Oct 2023 00:14:34 -0700
Message-Id: <1698304480-18463-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-GUID: iH73BH5elrVY7zO4KmEbsp8tRo1wmiLL
X-Proofpoint-ORIG-GUID: iH73BH5elrVY7zO4KmEbsp8tRo1wmiLL
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

U29tZSBkZXZpY2Ugc3BlY2lmaWMgSU9NTVUgcGFyZW50IGRyaXZlcnMgaGF2ZSBsb25nIHN0YW5k
aW5nIGJvZ3VzCmJlaGF2aW9yIHRoYXQgbWlzdGFrZW5seSBjbGVhbiB1cCB0aGUgbWFwcyBkdXJp
bmcgLnJlc2V0LiBCeSBkZWZpbml0aW9uLAp0aGlzIGlzIHZpb2xhdGlvbiB0byB0aGUgb24tY2hp
cCBJT01NVSBvcHMgKGkuZS4gLnNldF9tYXAsIG9yIC5kbWFfbWFwICYKLmRtYV91bm1hcCkgaW4g
dGhvc2Ugb2ZmZW5kaW5nIGRyaXZlcnMsIGFzIHRoZSByZW1vdmFsIG9mIGludGVybmFsIG1hcHMK
aXMgY29tcGxldGVseSBhZ25vc3RpYyB0byB0aGUgdXBwZXIgbGF5ZXIsIGNhdXNpbmcgaW5jb25z
aXN0ZW50IHZpZXcKYmV0d2VlbiB0aGUgdXNlcnNwYWNlIGFuZCB0aGUga2VybmVsLiBTb21lIHVz
ZXJzcGFjZSBhcHAgbGlrZSBRRU1VIGdldHMKYXJvdW5kIG9mIHRoaXMgYnJva2VubmVzcyBieSBw
cm9hY3RpdmVseSByZW1vdmluZyBhbmQgYWRkaW5nIGJhY2sgYWxsCnRoZSBtYXBzIGFyb3VuZCB2
ZHBhIGRldmljZSByZXNldCwgYnV0IHN1Y2ggd29ya2Fyb3VuZCBhY3R1YWxseSBwZW5hbGl6ZQpv
dGhlciB3ZWxsLWJlaGF2ZWQgZHJpdmVyIHNldHVwLCB3aGVyZSB2ZHBhIHJlc2V0IGFsd2F5cyBj
b21lcyB3aXRoIHRoZQphc3NvY2lhdGVkIG1hcHBpbmcgY29zdCwgZXNwZWNpYWxseSBmb3Iga2Vy
bmVsIHZEUEEgZGV2aWNlcwoodXNlX3ZhPWZhbHNlKSB0aGF0IGhhdmUgaGlnaCBjb3N0IG9uIHBp
bm5pbmcuIEl0J3MgaW1wZXJhdGl2ZSB0bwpyZWN0aWZ5IHRoaXMgYmVoYXZpb3IgYW5kIHJlbW92
ZSB0aGUgcHJvYmxlbWF0aWMgY29kZSBmcm9tIGFsbCB0aG9zZQpub24tY29tcGxpYW50IHBhcmVu
dCBkcml2ZXJzLgoKVGhlIHJlYXNvbiB3aHkgYSBzZXBhcmF0ZSAucmVzZXRfbWFwIG9wIGlzIGlu
dHJvZHVjZWQgaXMgYmVjYXVzZSB0aGlzCmFsbG93cyBhIHNpbXBsZSBvbi1jaGlwIElPTU1VIG1v
ZGVsIHdpdGhvdXQgZXhwb3NpbmcgdG9vIG11Y2ggZGV2aWNlCmltcGxlbWVudGF0aW9uIGRldGFp
bCB0byB0aGUgdXBwZXIgdmRwYSBsYXllci4gVGhlIC5kbWFfbWFwL3VubWFwIG9yCi5zZXRfbWFw
IGRyaXZlciBBUEkgaXMgbWVhbnQgdG8gYmUgdXNlZCB0byBtYW5pcHVsYXRlIHRoZSBJT1RMQgpt
YXBwaW5ncywgYW5kIGhhcyBiZWVuIGFic3RyYWN0ZWQgaW4gYSB3YXkgc2ltaWxhciB0byBob3cg
YSByZWFsIElPTU1VCmRldmljZSBtYXBzIG9yIHVubWFwcyBwYWdlcyBmb3IgY2VydGFpbiBtZW1v
cnkgcmFuZ2VzLiBIb3dldmVyLCBhcGFydApmcm9tIHRoaXMgdGhlcmUgYWxzbyBleGlzdHMgb3Ro
ZXIgbWFwcGluZyBuZWVkcywgaW4gd2hpY2ggY2FzZSAxOjEKcGFzc3Rocm91Z2ggbWFwcGluZyBo
YXMgdG8gYmUgdXNlZCBieSBvdGhlciB1c2VycyAocmVhZCB2aXJ0aW8tdmRwYSkuIFRvCmVhc2Ug
cGFyZW50L3ZlbmRvciBkcml2ZXIgaW1wbGVtZW50YXRpb24gYW5kIHRvIGF2b2lkIGFidXNpbmcg
RE1BIG9wcyBpbgphbiB1bmV4cGFjdGVkIHdheSwgdGhlc2Ugb24tY2hpcCBJT01NVSBkZXZpY2Vz
IGNhbiBzdGFydCB3aXRoIDE6MQpwYXNzdGhyb3VnaCBtYXBwaW5nIG1vZGUgaW5pdGlhbGx5IGF0
IHRoZSB0aW1lIG9mIGNyZWF0aW9uLiBUaGVuIHRoZQoucmVzZXRfbWFwIG9wIGNhbiBiZSB1c2Vk
IHRvIHN3aXRjaCBpb3RsYiBiYWNrIHRvIHRoaXMgaW5pdGlhbCBzdGF0ZQp3aXRob3V0IGhhdmlu
ZyB0byBleHBvc2UgYSBjb21wbGV4IHR3by1kaW1lbnNpb25hbCBJT01NVSBkZXZpY2UgbW9kZWwu
CgpUaGUgLnJlc2V0X21hcCBpcyBub3QgYSBNVVNUIGZvciBldmVyeSBwYXJlbnQgdGhhdCBpbXBs
ZW1lbnRzIHRoZQouZG1hX21hcCBvciAuc2V0X21hcCBBUEksIGJlY2F1c2UgZGV2aWNlIG1heSB3
b3JrIHdpdGggRE1BIG9wcyBkaXJlY3RseQpieSBpbXBsZW1lbnQgdGhlaXIgb3duIHRvIG1hbmlw
dWxhdGUgc3lzdGVtIG1lbW9yeSBtYXBwaW5ncywgc28gZG9uJ3QKaGF2ZSB0byB1c2UgLnJlc2V0
X21hcCB0byBhY2hpZXZlIGEgc2ltcGxlIElPTU1VIGRldmljZSBtb2RlbCBmb3IgMToxCnBhc3N0
aHJvdWdoIG1hcHBpbmcuCgpTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9y
YWNsZS5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4K
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9s
aW51eC92ZHBhLmggfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92
ZHBhLmgKaW5kZXggZDM3NjMwOWI5OWNmLi4yNmFlNmFlMWVhYzMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvdmRwYS5oCisrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCkBAIC0zMjcsNiArMzI3
LDE1IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKICAqCQkJCUBpb3ZhOiBpb3ZhIHRvIGJlIHVu
bWFwcGVkCiAgKgkJCQlAc2l6ZTogc2l6ZSBvZiB0aGUgYXJlYQogICoJCQkJUmV0dXJucyBpbnRl
Z2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQorICogQHJlc2V0X21hcDoJCQlSZXNldCBk
ZXZpY2UgbWVtb3J5IG1hcHBpbmcgdG8gdGhlIGRlZmF1bHQKKyAqCQkJCXN0YXRlIChvcHRpb25h
bCkKKyAqCQkJCU5lZWRlZCBmb3IgZGV2aWNlcyB0aGF0IGFyZSB1c2luZyBkZXZpY2UKKyAqCQkJ
CXNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiBhbmQgcHJlZmVyIG1hcHBpbmcKKyAqCQkJCXRvIGJl
IGRlY291cGxlZCBmcm9tIHRoZSB2aXJ0aW8gbGlmZSBjeWNsZSwKKyAqCQkJCWkuZS4gZGV2aWNl
IC5yZXNldCBvcCBkb2VzIG5vdCByZXNldCBtYXBwaW5nCisgKgkJCQlAdmRldjogdmRwYSBkZXZp
Y2UKKyAqCQkJCUBhc2lkOiBhZGRyZXNzIHNwYWNlIGlkZW50aWZpZXIKKyAqCQkJCVJldHVybnMg
aW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkKICAqIEBnZXRfdnFfZG1hX2RldjoJ
CUdldCB0aGUgZG1hIGRldmljZSBmb3IgYSBzcGVjaWZpYwogICoJCQkJdmlydHF1ZXVlIChvcHRp
b25hbCkKICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQpAQCAtNDA1LDYgKzQxNCw3IEBAIHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgewogCQkgICAgICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgcGEs
IHUzMiBwZXJtLCB2b2lkICpvcGFxdWUpOwogCWludCAoKmRtYV91bm1hcCkoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCwKIAkJCSB1NjQgaW92YSwgdTY0IHNpemUp
OworCWludCAoKnJlc2V0X21hcCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBp
bnQgYXNpZCk7CiAJaW50ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50IGdyb3VwLAogCQkJICAgICAgdW5zaWduZWQgaW50IGFzaWQpOwogCXN0
cnVjdCBkZXZpY2UgKigqZ2V0X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dTE2IGlkeCk7Ci0tIAoyLjM5LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
