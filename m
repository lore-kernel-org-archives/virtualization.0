Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C98EEB57C
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 08:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFB9560F5F;
	Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFB9560F5F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=UCCq0mje
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwjelfjuM0lT; Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5432F60742;
	Sat,  9 Sep 2023 08:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5432F60742
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 190E9C0039;
	Sat,  9 Sep 2023 08:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D961C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4218460F2D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4218460F2D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZZPqZSOhuEND
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DFCA60E5B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DFCA60E5B
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3898di6Y012084; Sat, 9 Sep 2023 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=Lj3POdozX8xuBZVUZyIfc35gFhDm0ApXMK2pZhJhbWw=;
 b=UCCq0mjeSdK8KRIHOBeTzUe2gW5ZrN0VVR3U2QQu3ocLKZVUheW0093raLWhPB3e8vHt
 lbONjwUHVgZQWcqbNpVYtviJeRWq0VAYgMAxaWZRA1m/kgYgnWllRTCHQCRcLQYMi/NW
 UZ/0NwQzQA7IhN0WEMzjSWD7eY+h+a83GfAMEvmM1HuqgTAZ7z6jQPObzUvKy7CvFHzw
 +iokUJ/Om9iTe8aDQXemR5y/ef+AnC/tIqLm0GcxmIs39IMRLIONFB0eaxhmnRhYxCbi
 QCAPwr+xOVgDkHgctrtzGcq4ASjGTFYcAPubW6QGHjz4pi7bE6vuLnfbWoS9JYUl8RLH mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0ncug131-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 08:44:56 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38954WNp002299; Sat, 9 Sep 2023 08:44:56 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f58qgc7-3; Sat, 09 Sep 2023 08:44:56 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com
Subject: [PATCH RFC v2 2/3] vhost-vdpa: introduce descriptor group backend
 feature
Date: Sat,  9 Sep 2023 01:42:38 -0700
Message-Id: <1694248959-13369-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=951 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090078
X-Proofpoint-GUID: wDc7BbqdJIxMD7pDNSEqiXIZAk2OVZEE
X-Proofpoint-ORIG-GUID: wDc7BbqdJIxMD7pDNSEqiXIZAk2OVZEE
Cc: virtualization@lists.linux-foundation.org
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

VXNlcnNwYWNlIGtub3dzIGlmIHRoZSBkZXZpY2UgaGFzIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdy
b3VwIG9yIG5vdApieSBjaGVja2luZyB0aGlzIGZlYXR1cmUgYml0LgoKSXQncyBvbmx5IGV4cG9z
ZWQgaWYgdGhlIHZkcGEgZHJpdmVyIGJhY2tlbmQgaW1wbGVtZW50cyB0aGUKLmdldF92cV9kZXNj
X2dyb3VwKCkgb3BlcmF0aW9uIGNhbGxiYWNrLiBVc2Vyc3BhY2UgdHJ5aW5nIHRvIG5lZ290aWF0
ZQp0aGlzIGZlYXR1cmUgd2hlbiBpdCBvciB0aGUgZGVwZW5kZW50IF9GX0lPVExCX0FTSUQgZmVh
dHVyZSBoYXNuJ3QKYmVlbiBleHBvc2VkIHdpbGwgcmVzdWx0IGluIGFuIGVycm9yLgoKU2lnbmVk
LW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgpBY2tlZC1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CgotLS0KUkZDIHYxIC0+IHYyOgogIC0g
YWRkIGNsYXJpZmljYXRpb25zIGZvciB3aGF0IGFyZWFzIEZfREVTQ19BU0lEIHNob3VsZCBjb3Zl
cgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTcgKysrKysrKysrKysr
KysrKysKIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oIHwgIDUgKysrKysKIDIgZmls
ZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKaW5kZXggYjQzZTg2OC4uZjJlNWRjZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
QEAgLTM4OSw2ICszODksMTQgQEAgc3RhdGljIGJvb2wgdmhvc3RfdmRwYV9jYW5fcmVzdW1lKGNv
bnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2KQogCXJldHVybiBvcHMtPnJlc3VtZTsKIH0KIAorc3Rh
dGljIGJvb2wgdmhvc3RfdmRwYV9oYXNfZGVzY19ncm91cChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdikKK3sKKwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOworCWNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKKworCXJldHVybiBvcHMt
PmdldF92cV9kZXNjX2dyb3VwOworfQorCiBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9mZWF0
dXJlcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVyZXApCiB7CiAJc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKQEAgLTY3OSw2ICs2ODcsNyBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKIAkJ
aWYgKGNvcHlfZnJvbV91c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0dXJlcykp
KQogCQkJcmV0dXJuIC1FRkFVTFQ7CiAJCWlmIChmZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNL
RU5EX0ZFQVRVUkVTIHwKKwkJCQkgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKSB8
CiAJCQkJIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKIAkJCQkgQklUX1VMTChW
SE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkpCiAJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CkBAIC02ODgs
NiArNjk3LDEyIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0
IGZpbGUgKmZpbGVwLAogCQlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0Zf
UkVTVU1FKSkgJiYKIAkJICAgICAhdmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQogCQkJcmV0dXJu
IC1FT1BOT1RTVVBQOworCQlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0Zf
REVTQ19BU0lEKSkgJiYKKwkJICAgICEoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRf
Rl9JT1RMQl9BU0lEKSkpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwkJaWYgKChmZWF0dXJlcyAmIEJJ
VF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCkpICYmCisJCSAgICAgIXZob3N0X3ZkcGFf
aGFzX2Rlc2NfZ3JvdXAodikpCisJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CiAJCXZob3N0X3NldF9i
YWNrZW5kX2ZlYXR1cmVzKCZ2LT52ZGV2LCBmZWF0dXJlcyk7CiAJCXJldHVybiAwOwogCX0KQEAg
LTc0MSw2ICs3NTYsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0
cnVjdCBmaWxlICpmaWxlcCwKIAkJCWZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X1NVU1BFTkQpOwogCQlpZiAodmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQogCQkJZmVhdHVyZXMg
fD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKTsKKwkJaWYgKHZob3N0X3ZkcGFfaGFz
X2Rlc2NfZ3JvdXAodikpCisJCQlmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9E
RVNDX0FTSUQpOwogCQlpZiAoY29weV90b191c2VyKGZlYXR1cmVwLCAmZmVhdHVyZXMsIHNpemVv
ZihmZWF0dXJlcykpKQogCQkJciA9IC1FRkFVTFQ7CiAJCWJyZWFrOwpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3Rf
dHlwZXMuaAppbmRleCBkM2FhZDEyYS4uNmFjYzYwNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0X3R5cGVzLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVz
LmgKQEAgLTE4MSw1ICsxODEsMTAgQEAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSB7CiAj
ZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EICAweDQKIC8qIERldmljZSBjYW4gYmUgcmVz
dW1lZCAqLwogI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FICAweDUKKy8qIERldmljZSBt
YXkgZXhwb3NlIHRoZSB2aXJ0cXVldWUncyBkZXNjcmlwdG9yIGFyZWEsIGRyaXZlciBhcmVhIGFu
ZAorICogZGV2aWNlIGFyZWEgdG8gYSBkaWZmZXJlbnQgZ3JvdXAgZm9yIEFTSUQgYmluZGluZyB0
aGFuIHdoZXJlIGl0cworICogYnVmZmVycyBtYXkgcmVzaWRlLiBSZXF1aXJlcyBWSE9TVF9CQUNL
RU5EX0ZfSU9UTEJfQVNJRC4KKyAqLworI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lE
ICAgIDB4NgogCiAjZW5kaWYKLS0gCjEuOC4zLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
