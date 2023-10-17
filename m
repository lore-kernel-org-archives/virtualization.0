Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD91FCDB485
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 00:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55E1781919;
	Tue, 17 Oct 2023 00:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55E1781919
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=tbhvgKGs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lv_CRpiZjld1; Tue, 17 Oct 2023 00:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C01C281AAB;
	Tue, 17 Oct 2023 00:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C01C281AAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99F91C0039;
	Tue, 17 Oct 2023 00:42:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E0A6C0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5025E605EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5025E605EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=tbhvgKGs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMgyIjJhA0pw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:45 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71C25605AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71C25605AF
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKO4BI011132; Tue, 17 Oct 2023 00:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=WEr4JGhEt6neFXoJwZaO0Xs8r8Ued1/sBS5Auy1yR+s=;
 b=tbhvgKGsUaqzEyNd9PBKXWXchCJVKq2RvEbxJvZRgB2VhRbhVDiaW+rmfJzcPoTqnYyk
 4fz9RZ22UFZnnY7vIZDJNAdFOaMX7CLNky/wNnrbiqxe65Nlood4CuvmmzCQLS/vxrVX
 qLotEBJwDW4BArKR6p8ZQdr8fWseSXRYOd8bp3rwNzZZSswJUMKraze1ErLs31q+4e/3
 /b9IBT2RpvIj5lvIGcCUTxPN9SGHU9YFRACv69hkL4/zp4dFJ8SaysoAhWUWeDSrrN7i
 4dOfe8y6xbJ21zGeU8Sxtkc508O6XmBxgzheEHShTiIMrL68tPAiRhkl7ZMvpUstsQ9A Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjync01u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 00:42:41 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GNB27L027141; Tue, 17 Oct 2023 00:42:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3trg535bja-5; Tue, 17 Oct 2023 00:42:40 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com, sgarzare@redhat.com
Subject: [PATCH v2 4/4] vdpa/mlx5: implement .reset_map driver op
Date: Mon, 16 Oct 2023 17:39:57 -0700
Message-Id: <1697503197-15935-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
References: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-GUID: -pbDF6oNQ7-PqtuDB7Ak_yjYkgTYxiAW
X-Proofpoint-ORIG-GUID: -pbDF6oNQ7-PqtuDB7Ak_yjYkgTYxiAW
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

U2luY2UgY29tbWl0IDZmNTMxMmY4MDE4MyAoInZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIHJ1
bm5pbmcgd2l0aAp2aXJ0aW9fdmRwYSIpLCBtbHg1X3ZkcGEgc3RhcnRzIHdpdGggcHJlYWxsb2Nh
dGUgMToxIERNQSBNUiBhdCBkZXZpY2UKY3JlYXRpb24gdGltZS4gVGhpcyAxOjEgRE1BIE1SIHdp
bGwgYmUgaW1wbGljaXRseSBkZXN0cm95ZWQgd2hpbGUKdGhlIGZpcnN0IC5zZXRfbWFwIGNhbGwg
aXMgaW52b2tlZCwgaW4gd2hpY2ggY2FzZSBjYWxsZXJzIGxpa2UKdmhvc3QtdmRwYSB3aWxsIHN0
YXJ0IHRvIHNldCB1cCBjdXN0b20gbWFwcGluZ3MuIFdoZW4gdGhlIC5yZXNldApjYWxsYmFjayBp
cyBpbnZva2VkLCB0aGUgY3VzdG9tIG1hcHBpbmdzIHdpbGwgYmUgY2xlYXJlZCBhbmQgdGhlIDE6
MQpETUEgTVIgd2lsbCBiZSByZS1jcmVhdGVkLgoKSW4gb3JkZXIgdG8gcmVkdWNlIGV4Y2Vzc2l2
ZSBtZW1vcnkgbWFwcGluZyBjb3N0IGluIGxpdmUgbWlncmF0aW9uLAppdCBpcyBkZXNpcmFibGUg
dG8gZGVjb3VwbGUgdGhlIHZob3N0LXZkcGEgSU9UTEIgYWJzdHJhY3Rpb24gZnJvbQp0aGUgdmly
dGlvIGRldmljZSBsaWZlIGN5Y2xlLCBpLmUuIG1hcHBpbmdzIGNhbiBiZSBrZXB0IGFyb3VuZCBp
bnRhY3QKYWNyb3NzIHZpcnRpbyBkZXZpY2UgcmVzZXQuIExldmVyYWdlIHRoZSAucmVzZXRfbWFw
IGNhbGxiYWNrLCB3aGljaAppcyBtZWFudCB0byBkZXN0cm95IHRoZSByZWd1bGFyIE1SIG9uIHRo
ZSBnaXZlbiBBU0lEIGFuZCByZWNyZWF0ZSB0aGUKaW5pdGlhbCBETUEgbWFwcGluZy4gVGhhdCB3
YXksIHRoZSBkZXZpY2UgLnJlc2V0IG9wIGNhbiBydW4gZnJlZSBmcm9tCmhhdmluZyB0byBtYWlu
dGFpbiBhbmQgY2xlYW4gdXAgbWVtb3J5IG1hcHBpbmdzIGJ5IGl0c2VsZi4KClRoZSBjdnEgbWFw
cGluZyBhbHNvIG5lZWRzIHRvIGJlIGNsZWFyZWQgaWYgaXMgaW4gdGhlIGdpdmVuIEFTSUQuCgpD
by1kZXZlbG9wZWQtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KU2lnbmVkLW9m
Zi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgpBY2tlZC1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaCB8ICAxICsKIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAg
fCAxNyArKysrKysrKysrKysrKysrKwogZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
ICB8IDE4ICsrKysrKysrKysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4IGRi
OTg4Y2VkNWE1ZC4uODQ1NDdkOTk4YmNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYS5oCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgK
QEAgLTEyNyw2ICsxMjcsNyBAQCBpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCQkJCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJ
CQkJdW5zaWduZWQgaW50IGFzaWQpOwogaW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldik7CitpbnQgbWx4NV92ZHBhX3Jlc2V0X21yKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpOwogCiAjZGVmaW5lIG1seDVf
dmRwYV93YXJuKF9fZGV2LCBmb3JtYXQsIC4uLikgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAJZGV2X3dhcm4oKF9fZGV2KS0+bWRldi0+
ZGV2aWNlLCAiJXM6JWQ6KHBpZCAlZCkgd2FybmluZzogIiBmb3JtYXQsIF9fZnVuY19fLCBfX0xJ
TkVfXywgICAgIFwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCA2NjUzMGUyOGYzMjcuLjIxOTdjNDZlNTYz
YSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYwpAQCAtNjQ1LDMgKzY0NSwyMCBAQCBpbnQgbWx4NV92ZHBhX2Ny
ZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogCiAJcmV0dXJuIG1seDVf
dmRwYV91cGRhdGVfY3ZxX2lvdGxiKG12ZGV2LCBOVUxMLCAwKTsKIH0KKworaW50IG1seDVfdmRw
YV9yZXNldF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lk
KQoreworCWlmIChhc2lkID49IE1MWDVfVkRQQV9OVU1fQVMpCisJCXJldHVybiAtRUlOVkFMOwor
CisJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG12ZGV2LT5tclthc2lkXSk7CisKKwlpZiAo
YXNpZCA9PSAwICYmIE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwgdW1lbV91aWRfMCkpIHsKKwkJ
aWYgKG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKG12ZGV2KSkKKwkJCW1seDVfdmRwYV93YXJuKG12
ZGV2LCAiY3JlYXRlIERNQSBNUiBmYWlsZWRcbiIpOworCX0gZWxzZSB7CisJCW1seDVfdmRwYV91
cGRhdGVfY3ZxX2lvdGxiKG12ZGV2LCBOVUxMLCBhc2lkKTsKKwl9CisKKwlyZXR1cm4gMDsKK30K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwppbmRleCA2YWJlMDIzMTBmMmIuLjkyOGU3MWJjNTU3
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCisrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwpAQCAtMjgzOCw3ICsyODM4LDYgQEAgc3Rh
dGljIGludCBtbHg1X3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQogCXVucmVn
aXN0ZXJfbGlua19ub3RpZmllcihuZGV2KTsKIAl0ZWFyZG93bl9kcml2ZXIobmRldik7CiAJY2xl
YXJfdnFzX3JlYWR5KG5kZXYpOwotCW1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNlcygmbmRl
di0+bXZkZXYpOwogCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7CiAJbmRldi0+bXZkZXYuc3VzcGVu
ZGVkID0gZmFsc2U7CiAJbmRldi0+Y3VyX251bV92cXMgPSAwOwpAQCAtMjg0OSwxMCArMjg0OCw2
IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikK
IAlpbml0X2dyb3VwX3RvX2FzaWRfbWFwKG12ZGV2KTsKIAkrK212ZGV2LT5nZW5lcmF0aW9uOwog
Ci0JaWYgKE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwgdW1lbV91aWRfMCkpIHsKLQkJaWYgKG1s
eDVfdmRwYV9jcmVhdGVfZG1hX21yKG12ZGV2KSkKLQkJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAi
Y3JlYXRlIE1SIGZhaWxlZFxuIik7Ci0JfQogCXVwX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsKIAog
CXJldHVybiAwOwpAQCAtMjkzMiw2ICsyOTI3LDE4IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3Nl
dF9tYXAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCwKIAlyZXR1
cm4gZXJyOwogfQogCitzdGF0aWMgaW50IG1seDVfdmRwYV9yZXNldF9tYXAoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKK3sKKwlzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9
IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKKwlpbnQgZXJyOworCisJZG93bl93cml0ZSgmbmRl
di0+cmVzbG9jayk7CisJZXJyID0gbWx4NV92ZHBhX3Jlc2V0X21yKG12ZGV2LCBhc2lkKTsKKwl1
cF93cml0ZSgmbmRldi0+cmVzbG9jayk7CisJcmV0dXJuIGVycjsKK30KKwogc3RhdGljIHN0cnVj
dCBkZXZpY2UgKm1seDVfZ2V0X3ZxX2RtYV9kZXYoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
MTYgaWR4KQogewogCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYp
OwpAQCAtMzE5OSw2ICszMjA2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgbWx4NV92ZHBhX29wcyA9IHsKIAkuc2V0X2NvbmZpZyA9IG1seDVfdmRwYV9zZXRfY29uZmln
LAogCS5nZXRfZ2VuZXJhdGlvbiA9IG1seDVfdmRwYV9nZXRfZ2VuZXJhdGlvbiwKIAkuc2V0X21h
cCA9IG1seDVfdmRwYV9zZXRfbWFwLAorCS5yZXNldF9tYXAgPSBtbHg1X3ZkcGFfcmVzZXRfbWFw
LAogCS5zZXRfZ3JvdXBfYXNpZCA9IG1seDVfc2V0X2dyb3VwX2FzaWQsCiAJLmdldF92cV9kbWFf
ZGV2ID0gbWx4NV9nZXRfdnFfZG1hX2RldiwKIAkuZnJlZSA9IG1seDVfdmRwYV9mcmVlLAotLSAK
Mi4zOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
