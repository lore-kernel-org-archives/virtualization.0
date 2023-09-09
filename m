Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C912EEB564
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 08:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5FB781E46;
	Sat,  9 Sep 2023 08:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5FB781E46
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VcC5jyF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpq_yuFjAteC; Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CB0681E4E;
	Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CB0681E4E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF51C0032;
	Sat,  9 Sep 2023 08:45:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8681BC0039
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B0D841721
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B0D841721
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VcC5jyF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbFBQ8W3z3ml
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BA79405FB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BA79405FB
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3898dgvn012077; Sat, 9 Sep 2023 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=jSMOrKu+GOgnx+zBObx/pCpKIJPIbb3KfLHim2zMvSo=;
 b=VcC5jyF2wv/ZL1+O2KHq/62pdYjCcYFOy/TNfWVLQ6LdhtzNCBWIvupevf3fRGt8/39q
 L+7XG5OC3csr9RgAqOIInZCzOQDqSWKkIsDbzU+2xJcIRgEbkJ+40v+U/vCBiUgb8ohy
 oUugzMgV+SqbFW+BxWvWvyK39pi4QaqXrAJ7gCmv2rce1OPA05/2XEV5CSLsc5n6rdQT
 JKksptJSZIiqHkzeqe0fkSt9s5BzQ1xAgZjF65HpB5JlFCqVhJvRK2XQ/IiArMykhuYJ
 S+Ob5YCDYIMZzdwJF63laYA9pYnW1V09N3ZDE0wmBEJuwb86HzWywPpTTPU6SPgppGdo SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0ncug134-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 08:44:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38954WNq002299; Sat, 9 Sep 2023 08:44:56 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f58qgc7-4; Sat, 09 Sep 2023 08:44:56 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com
Subject: [PATCH RFC v2 3/3] vhost-vdpa: uAPI to get dedicated descriptor group
 id
Date: Sat,  9 Sep 2023 01:42:39 -0700
Message-Id: <1694248959-13369-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=788 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090078
X-Proofpoint-GUID: 12jFS1X8sQFjd3IShF1eXXzfATm-PQ9f
X-Proofpoint-ORIG-GUID: 12jFS1X8sQFjd3IShF1eXXzfATm-PQ9f
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

V2l0aCBfRl9ERVNDX0FTSUQgYmFja2VuZCBmZWF0dXJlLCB0aGUgZGV2aWNlIGNhbiBub3cgc3Vw
cG9ydCB0aGUKVkhPU1RfVkRQQV9HRVRfVlJJTkdfREVTQ19HUk9VUCBpb2N0bCwgYW5kIGl0IG1h
eSBleHBvc2UgdGhlIGRlc2NyaXB0b3IKdGFibGUgKGluY2x1ZGluZyBhdmFpbCBhbmQgdXNlZCBy
aW5nKSBpbiBhIGRpZmZlcmVudCBncm91cCB0aGFuIHRoZQpidWZmZXJzIGl0IGNvbnRhaW5zLiBU
aGlzIG5ldyB1QVBJIHdpbGwgZmV0Y2ggdGhlIGdyb3VwIElEIG9mIHRoZQpkZXNjcmlwdG9yIHRh
YmxlLgoKU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgpB
Y2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVy
cy92aG9zdC92ZHBhLmMgICAgICAgfCAxMCArKysrKysrKysrCiBpbmNsdWRlL3VhcGkvbGludXgv
dmhvc3QuaCB8ICA4ICsrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5j
CmluZGV4IGYyZTVkY2UuLmVhYmFjMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
CisrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCkBAIC02MDIsNiArNjAyLDE2IEBAIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHVuc2lnbmVk
IGludCBjbWQsCiAJCWVsc2UgaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmcywgc2l6ZW9mKHMpKSkK
IAkJCXJldHVybiAtRUZBVUxUOwogCQlyZXR1cm4gMDsKKwljYXNlIFZIT1NUX1ZEUEFfR0VUX1ZS
SU5HX0RFU0NfR1JPVVA6CisJCWlmICghdmhvc3RfdmRwYV9oYXNfZGVzY19ncm91cCh2KSkKKwkJ
CXJldHVybiAtRU9QTk9UU1VQUDsKKwkJcy5pbmRleCA9IGlkeDsKKwkJcy5udW0gPSBvcHMtPmdl
dF92cV9kZXNjX2dyb3VwKHZkcGEsIGlkeCk7CisJCWlmIChzLm51bSA+PSB2ZHBhLT5uZ3JvdXBz
KQorCQkJcmV0dXJuIC1FSU87CisJCWVsc2UgaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmcywgc2l6
ZW9mKHMpKSkKKwkJCXJldHVybiAtRUZBVUxUOworCQlyZXR1cm4gMDsKIAljYXNlIFZIT1NUX1ZE
UEFfU0VUX0dST1VQX0FTSUQ6CiAJCWlmIChjb3B5X2Zyb21fdXNlcigmcywgYXJncCwgc2l6ZW9m
KHMpKSkKIAkJCXJldHVybiAtRUZBVUxUOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4
L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAppbmRleCBmNWM0OGI2Li42NDk1
NjBjIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAorKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmhvc3QuaApAQCAtMjE5LDQgKzIxOSwxMiBAQAogICovCiAjZGVmaW5lIFZI
T1NUX1ZEUEFfUkVTVU1FCQlfSU8oVkhPU1RfVklSVElPLCAweDdFKQogCisvKiBHZXQgdGhlIGdy
b3VwIGZvciB0aGUgZGVzY3JpcHRvciB0YWJsZSBpbmNsdWRpbmcgZHJpdmVyICYgZGV2aWNlIGFy
ZWFzCisgKiBvZiBhIHZpcnRxdWV1ZTogcmVhZCBpbmRleCwgd3JpdGUgZ3JvdXAgaW4gbnVtLgor
ICogVGhlIHZpcnRxdWV1ZSBpbmRleCBpcyBzdG9yZWQgaW4gdGhlIGluZGV4IGZpZWxkIG9mIHZo
b3N0X3ZyaW5nX3N0YXRlLgorICogVGhlIGdyb3VwIElEIG9mIHRoZSBkZXNjcmlwdG9yIHRhYmxl
IGZvciB0aGlzIHNwZWNpZmljIHZpcnRxdWV1ZQorICogaXMgcmV0dXJuZWQgdmlhIG51bSBmaWVs
ZCBvZiB2aG9zdF92cmluZ19zdGF0ZS4KKyAqLworI2RlZmluZSBWSE9TVF9WRFBBX0dFVF9WUklO
R19ERVNDX0dST1VQCV9JT1dSKFZIT1NUX1ZJUlRJTywgMHg3RiwJXAorCQkJCQkgICAgICBzdHJ1
Y3Qgdmhvc3RfdnJpbmdfc3RhdGUpCiAjZW5kaWYKLS0gCjEuOC4zLjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
