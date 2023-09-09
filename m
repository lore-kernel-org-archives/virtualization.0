Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED70AEEB582
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 08:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CA144061F;
	Sat,  9 Sep 2023 08:45:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CA144061F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=lBfk8+L3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWbXC0GOgoXX; Sat,  9 Sep 2023 08:45:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C2FE417CF;
	Sat,  9 Sep 2023 08:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C2FE417CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F06ABC0032;
	Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A48BAC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79B9F405FB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79B9F405FB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=lBfk8+L3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1C38eCQ7eOHU
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:58 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17B72405E7
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17B72405E7
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3898KudG016740; Sat, 9 Sep 2023 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=4191D9g0bYMjiSJ8agqKnC2wQqgm2p8BAJmekQ6CYVs=;
 b=lBfk8+L3Menf7qi+4pLxfHWraNYnpI/5DVA51kK/ev6aZZO+rTS1TsdDnnNdGv3mr7CG
 V4MCdT88ec86P2oK9Yv5ntQ9VLeWOi/AA5Btjy9zYT8hNRxNmBSml9IwCVu1TPui9jUZ
 bAd0ST9gttM2vFb539SNwsiaz+q/fTHHMYK+7z0PMiGF/QOSnWtC3ZAGhGaWrK7k2Ji4
 38eOgpIL87468XHSQ5DaP/1Ajmahs6diZzRcxBIXFZL+vw2whmu+8SmYrFEwyifihWJf
 Z46yRsgqrWi8julklMmDfrc+RmhInwaF/uVTBQs2dKv0fuVuzNiTpGxlcWo1goVRKWCh jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0n3ng1q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 08:44:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38954WNo002299; Sat, 9 Sep 2023 08:44:55 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f58qgc7-2; Sat, 09 Sep 2023 08:44:55 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com
Subject: [PATCH RFC v2 1/3] vdpa: introduce dedicated descriptor group for
 virtqueue
Date: Sat,  9 Sep 2023 01:42:37 -0700
Message-Id: <1694248959-13369-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090078
X-Proofpoint-GUID: zOKy5XvarCjChjQqUypEsOd9jVXbv5TD
X-Proofpoint-ORIG-GUID: zOKy5XvarCjChjQqUypEsOd9jVXbv5TD
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

SW4gc29tZSBjYXNlcywgdGhlIGFjY2VzcyB0byB0aGUgdmlydHF1ZXVlJ3MgZGVzY3JpcHRvciBh
cmVhLCBkZXZpY2UKYW5kIGRyaXZlciBhcmVhcyAocHJlY2x1ZGluZyBpbmRpcmVjdCBkZXNjcmlw
dG9yIHRhYmxlIGluIGd1ZXN0IG1lbW9yeSkKbWF5IGhhdmUgdG8gYmUgY29uZmluZWQgdG8gYSBk
aWZmZXJlbnQgYWRkcmVzcyBzcGFjZSB0aGFuIHdoZXJlIGl0cwpidWZmZXJzIHJlc2lkZS4gV2l0
aG91dCBsb3NzIG9mIHNpbXBsaWNpdHkgYW5kIGdlbmVyYWxpdHkgd2l0aCBhbHJlYWR5CmVzdGFi
bGlzaGVkIHRlcm1pbm9sb2d5LCBsZXQncyBmb2xkIHVwIHRoZXNlIDMgYXJlYXMgYW5kIGNhbGwg
dGhlbQphcyBhIHdob2xlIGFzIGRlc2NyaXB0b3IgdGFibGUgZ3JvdXAsIG9yIGRlc2NyaXB0b3Ig
Z3JvdXAgZm9yIHNob3J0LgpTcGVjaWZpY2FsbHksIGluIGNhc2Ugb2Ygc3BsaXQgdmlydHF1ZXVl
cywgZGVzY3JpcHRvciBncm91cCBjb25zaXN0cyBvZgpyZWdpb25zIGZvciBEZXNjcmlwdG9yIFRh
YmxlLCBBdmFpbGFibGUgUmluZyBhbmQgVXNlZCBSaW5nOyBmb3IgcGFja2VkCnZpcnRxdWV1ZXMg
bGF5b3V0LCBkZXNjcmlwdG9yIGdyb3VwIGNvbnRhaW5zIERlc2NyaXB0b3IgUmluZywgRHJpdmVy
CmFuZCBEZXZpY2UgRXZlbnQgU3VwcHJlc3Npb24gc3RydWN0dXJlcy4KClRoZSBncm91cCBJRCBm
b3IgYSBkZWRpY2F0ZWQgZGVzY3JpcHRvciBncm91cCBjYW4gYmUgb2J0YWluZWQgdGhyb3VnaCBh
Cm5ldyAuZ2V0X3ZxX2Rlc2NfZ3JvdXAoKSBvcC4gSWYgZHJpdmVyIGltcGxlbWVudHMgdGhpcyBv
cCwgaXQgbWVhbnMgdGhhdAp0aGUgZGVzY3JpcHRvciwgZGV2aWNlIGFuZCBkcml2ZXIgYXJlYXMg
b2YgdGhlIHZpcnRxdWV1ZSBtYXkgcmVzaWRlCmluIGEgZGVkaWNhdGVkIGdyb3VwIHRoYW4gd2hl
cmUgaXRzIGJ1ZmZlcnMgcmVzaWRlLCBhLmsuYSB0aGUgZGVmYXVsdAp2aXJ0cXVldWUgZ3JvdXAg
dGhyb3VnaCB0aGUgLmdldF92cV9ncm91cCgpIG9wLgoKSW4gcHJpbmNpcGxlLCB0aGUgZGVzY3Jp
cHRvciBncm91cCBtYXkgb3IgbWF5IG5vdCBoYXZlIHNhbWUgZ3JvdXAgSUQKYXMgdGhlIGRlZmF1
bHQgZ3JvdXAuIEV2ZW4gaWYgdGhlIGRlc2NyaXB0b3IgZ3JvdXAgaGFzIGEgZGlmZmVyZW50IElE
LAptZWFuaW5nIHRoZSB2cSdzIGRlc2NyaXB0b3IgZ3JvdXAgYXJlYXMgY2FuIG9wdGlvbmFsbHkg
bW92ZSB0byBhCnNlcGFyYXRlIGFkZHJlc3Mgc3BhY2UgdGhhbiB3aGVyZSBndWVzdCBtZW1vcnkg
cmVzaWRlcywgdGhlIGRlc2NyaXB0b3IKZ3JvdXAgbWF5IHN0aWxsIHN0YXJ0IGZyb20gYSBkZWZh
dWx0IGFkZHJlc3Mgc3BhY2UsIHNhbWUgYXMgd2hlcmUgaXRzCmJ1ZmZlcnMgcmVzaWRlLiBUbyBt
b3ZlIHRoZSBkZXNjcmlwdG9yIGdyb3VwIHRvIGEgZGlmZmVyZW50IGFkZHJlc3MKc3BhY2UsIC5z
ZXRfZ3JvdXBfYXNpZCgpIGhhcyB0byBiZSBjYWxsZWQgdG8gY2hhbmdlIHRoZSBBU0lEIGJpbmRp
bmcKZm9yIHRoZSBncm91cCwgd2hpY2ggaXMgbm8gZGlmZmVyZW50IHRoYW4gd2hhdCBuZWVkcyB0
byBiZSBkb25lIG9uIGFueQpvdGhlciB2aXJ0cXVldWUgZ3JvdXAuIE9uIHRoZSBvdGhlciBoYW5k
LCB0aGUgLnJlc2V0KCkgc2VtYW50aWNzIGFsc28KYXBwbGllcyBvbiBkZXNjcmlwdG9yIHRhYmxl
IGdyb3VwLCBtZWFuaW5nIHRoZSBkZXZpY2UgcmVzZXQgd2lsbCBjbGVhcgphbGwgQVNJRCBiaW5k
aW5ncyBhbmQgbW92ZSBhbGwgdmlydHF1ZXVlIGdyb3VwcyBpbmNsdWRpbmcgZGVzY3JpcHRvcgpn
cm91cCBiYWNrIHRvIHRoZSBkZWZhdWx0IGFkZHJlc3Mgc3BhY2UsIGkuZS4gaW4gQVNJRCAwLgoK
UUVNVSdzIHNoYWRvdyB2aXJ0cXVldWUgaXMgZ29pbmcgdG8gdXRpbGl6ZSBkZWRpY2F0ZWQgZGVz
Y3JpcHRvciBncm91cAp0byBzcGVlZCB1cCBtYXAgYW5kIHVubWFwIG9wZXJhdGlvbnMsIHlpZWxk
aW5nIHRyZW1lbmRvdXMgZG93bnRpbWUKcmVkdWN0aW9uIGJ5IGF2b2lkaW5nIHRoZSBmdWxsIGFu
ZCBzbG93IHJlbWFwIGN5Y2xlIGluIFNWUSBzd2l0Y2hpbmcuCgpTaWduZWQtb2ZmLWJ5OiBTaS1X
ZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCi0tLQpSRkMgdjEgLT4gdjI6CiAgLSBleHBhbmQgY29tbWl0
IGxvZyB0byBtZW50aW9uIGRvd250aW1lIHJlZHVjdGlvbiBpbiBzd2l0Y2hpbmcKICAtIGFkZCBj
bGFyaWZpY2F0aW9ucyBmb3Igd2hhdCAiZGVzY3JpcHRvciBncm91cCIgY292ZXJzIGFuZCB3aGF0
bm90Ci0tLQogaW5jbHVkZS9saW51eC92ZHBhLmggfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEu
aCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCmluZGV4IGRiMWIwZWEuLjE3YTRlZmEgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCisrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCkBAIC0y
MDQsNiArMjA0LDE2IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKICAqCQkJCUB2ZGV2OiB2ZHBh
IGRldmljZQogICoJCQkJQGlkeDogdmlydHF1ZXVlIGluZGV4CiAgKgkJCQlSZXR1cm5zIHUzMjog
Z3JvdXAgaWQgZm9yIHRoaXMgdmlydHF1ZXVlCisgKiBAZ2V0X3ZxX2Rlc2NfZ3JvdXA6CQlHZXQg
dGhlIGdyb3VwIGlkIGZvciB0aGUgZGVzY3JpcHRvciB0YWJsZSBvZgorICoJCQkJYSBzcGVjaWZp
YyB2aXJ0cXVldWUgKG9wdGlvbmFsKQorICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCisgKgkJCQlA
aWR4OiB2aXJ0cXVldWUgaW5kZXgKKyAqCQkJCVJldHVybnMgdTMyOiBncm91cCBpZCBmb3IgdGhl
IGRlc2NyaXB0b3IgdGFibGUKKyAqCQkJCXBvcnRpb24gb2YgdGhpcyB2aXJ0cXVldWUuIENvdWxk
IGJlIGRpZmZlcmVudAorICoJCQkJdGhhbiB0aGUgb25lIGZyb20gQGdldF92cV9ncm91cCwgaW4g
d2hpY2ggY2FzZQorICoJCQkJdGhlIGFjY2VzcyB0byB0aGUgZGVzY3JpcHRvciB0YWJsZSBjYW4g
YmUKKyAqCQkJCWNvbmZpbmVkIHRvIGEgc2VwYXJhdGUgYXNpZCwgaXNvbGF0aW5nIGZyb20KKyAq
CQkJCXRoZSB2aXJ0cXVldWUncyBidWZmZXIgYWRkcmVzcyBhY2Nlc3MuCiAgKiBAZ2V0X2Rldmlj
ZV9mZWF0dXJlczoJR2V0IHZpcnRpbyBmZWF0dXJlcyBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZQog
ICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCiAgKgkJCQlSZXR1cm5zIHRoZSB2aXJ0aW8gZmVhdHVy
ZXMgc3VwcG9ydCBieSB0aGUKQEAgLTM1Nyw2ICszNjcsNyBAQCBzdHJ1Y3QgdmRwYV9jb25maWdf
b3BzIHsKIAkvKiBEZXZpY2Ugb3BzICovCiAJdTMyICgqZ2V0X3ZxX2FsaWduKShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpOwogCXUzMiAoKmdldF92cV9ncm91cCkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1MTYgaWR4KTsKKwl1MzIgKCpnZXRfdnFfZGVzY19ncm91cCkoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKIAl1NjQgKCpnZXRfZGV2aWNlX2ZlYXR1cmVzKShzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwogCWludCAoKnNldF9kcml2ZXJfZmVhdHVyZXMpKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKTsKIAl1NjQgKCpnZXRfZHJpdmVyX2Zl
YXR1cmVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwotLSAKMS44LjMuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
