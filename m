Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442ADCDB483
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 00:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8588E81F67;
	Tue, 17 Oct 2023 00:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8588E81F67
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=glPMvXzH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67KADfTYCkzK; Tue, 17 Oct 2023 00:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6BFB81AAB;
	Tue, 17 Oct 2023 00:42:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6BFB81AAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68654C0088;
	Tue, 17 Oct 2023 00:42:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E5FEC0DDB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 957C2605EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 957C2605EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=glPMvXzH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Is3kFz1H9TGS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:44 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B10D6600CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 00:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B10D6600CA
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKO8bX014418; Tue, 17 Oct 2023 00:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=KrpapIJ3BkNAXiuqRX7bRQLsn2/RQH2+BsvlPVXHXNA=;
 b=glPMvXzHavU3wJJTbXGlGb60s2ADRLv3I12Yb/1hQXGoSjh88YfThCFrU0jPLObxTdTb
 ZR9KV2ISQvZkCxJXcIy5NxXGbT2WGQZnX3a4ZlG7/WbLd6CqVJAYE3YsuEmTUq5zpSpN
 jCdDZpiTkM3S4/ry17/uCTR6xBTjkaR/IId/4NYNalFV9W8qAgplwjS7+BehB55vHFM2
 QeZ2l7rJdAcvLMjRUxb+ssuDQcH7lCm39mUYluBVbO6WjoX8MuJlx5qn3XDRGZEdEbxH
 LAP6H8E7v07CtmMNZ+Y/y22q0hWdckxF00RiTqEs9Ogft57DkDMX+3VV4EFIgvt3L8xq Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bkxsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 00:42:40 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GNB27K027141; Tue, 17 Oct 2023 00:42:39 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3trg535bja-4; Tue, 17 Oct 2023 00:42:39 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com, sgarzare@redhat.com
Subject: [PATCH v2 3/4] vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
Date: Mon, 16 Oct 2023 17:39:56 -0700
Message-Id: <1697503197-15935-4-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: Evj-k7e-lxAQDDNY1nc-XlkIMSEyxO8b
X-Proofpoint-ORIG-GUID: Evj-k7e-lxAQDDNY1nc-XlkIMSEyxO8b
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

VXNlcnNwYWNlIG5lZWRzIHRoaXMgZmVhdHVyZSBmbGFnIHRvIGRpc3Rpbmd1aXNoIGlmIHZob3N0
LXZkcGEKaW90bGIgaW4gdGhlIGtlcm5lbCBjYW4gYmUgdHJ1c3RlZCB0byBwZXJzaXN0IElPVExC
IG1hcHBpbmcKYWNyb3NzIHZEUEEgcmVzZXQuIFdpdGhvdXQgaXQsIHVzZXJzcGFjZSBoYXMgbm8g
d2F5IHRvIHRlbGwgYXBhcnQKaWYgaXQncyBydW5uaW5nIG9uIGFuIG9sZGVyIGtlcm5lbCwgd2hp
Y2ggY291bGQgc2lsZW50bHkgZHJvcAphbGwgaW90bGIgbWFwcGluZyBhY3Jvc3MgdkRQQSByZXNl
dCwgZXNwZWNpYWxseSB3aXRoIGJyb2tlbgpwYXJlbnQgZHJpdmVyIGltcGxlbWVudGF0aW9uIGZv
ciB0aGUgLnJlc2V0IGRyaXZlciBvcC4gVGhlIGJyb2tlbgpkcml2ZXIgbWF5IGluY29ycmVjdGx5
IGRyb3AgYWxsIG1hcHBpbmdzIG9mIGl0cyBvd24gYXMgcGFydCBvZgoucmVzZXQsIHdoaWNoIGlu
YWR2ZXJ0ZW50bHkgZW5kcyB1cCB3aXRoIGNvcnJ1cHRlZCBtYXBwaW5nIHN0YXRlCmJldHdlZW4g
dmhvc3QtdmRwYSB1c2Vyc3BhY2UgYW5kIHRoZSBrZXJuZWwuIEFzIGEgd29ya2Fyb3VuZCwgdG8K
bWFrZSB0aGUgbWFwcGluZyBiZWhhdmlvdXIgcHJlZGljdGFibGUgYWNyb3NzIHJlc2V0LCB1c2Vy
c3BhY2UKaGFzIHRvIHByby1hY3RpdmVseSByZW1vdmUgYWxsIG1hcHBpbmdzIGJlZm9yZSB2RFBB
IHJlc2V0LCBhbmQKdGhlbiByZXN0b3JlIGFsbCB0aGUgbWFwcGluZ3MgYWZ0ZXJ3YXJkcy4gVGhp
cyB3b3JrYXJvdW5kIGlzIGRvbmUKdW5jb25kaXRpb25hbGx5IG9uIHRvcCBvZiBhbGwgcGFyZW50
IGRyaXZlcnMgdG9kYXksIGR1ZSB0byB0aGUKcGFyZW50IGRyaXZlciBpbXBsZW1lbnRhdGlvbiBp
c3N1ZSBhbmQgbm8gbWVhbnMgdG8gZGlmZmVyZW50aWF0ZS4KVGhpcyB3b3JrYXJvdW5kIGhhZCBi
ZWVuIHV0aWxpemVkIGluIFFFTVUgc2luY2UgZGF5IG9uZSB3aGVuIHRoZQpjb3JyZXNwb25kaW5n
IHZob3N0LXZkcGEgdXNlcnNwYWNlIGJhY2tlbmQgY2FtZSB0byB0aGUgd29ybGQuCgpUaGVyZSBh
cmUgMyBjYXNlcyB0aGF0IGJhY2tlbmQgbWF5IGNsYWltIHRoaXMgZmVhdHVyZSBiaXQgb24gZm9y
OgoKLSBwYXJlbnQgZGV2aWNlIHRoYXQgaGFzIHRvIHdvcmsgd2l0aCBwbGF0Zm9ybSBJT01NVQot
IHBhcmVudCBkZXZpY2Ugd2l0aCBvbi1jaGlwIElPTU1VIHRoYXQgaGFzIHRoZSBleHBlY3RlZAog
IC5yZXNldF9tYXAgc3VwcG9ydCBpbiBkcml2ZXIKLSBwYXJlbnQgZGV2aWNlIHdpdGggdmVuZG9y
IHNwZWNpZmljIElPTU1VIGltcGxlbWVudGF0aW9uIHdpdGgKICBwZXJzaXN0ZW50IElPVExCIG1h
cHBpbmcgYWxyZWFkeSB0aGF0IGhhcyB0byBzcGVjaWZpY2FsbHkKICBkZWNsYXJlIHRoaXMgYmFj
a2VuZCBmZWF0dXJlCgpUaGUgcmVhc29uIHdoeSAucmVzZXRfbWFwIGlzIGJlaW5nIG9uZSBvZiB0
aGUgcHJlLWNvbmRpdGlvbiBmb3IKcGVyc2lzdGVudCBpb3RsYiBpcyBiZWNhdXNlIHdpdGhvdXQg
aXQsIHZob3N0LXZkcGEgY2FuJ3Qgc3dpdGNoCmJhY2sgaW90bGIgdG8gdGhlIGluaXRpYWwgc3Rh
dGUgbGF0ZXIgb24sIGVzcGVjaWFsbHkgZm9yIHRoZQpvbi1jaGlwIElPTU1VIGNhc2Ugd2hpY2gg
c3RhcnRzIHdpdGggaWRlbnRpdHkgbWFwcGluZyBhdCBkZXZpY2UKY3JlYXRpb24uIHZpcnRpby12
ZHBhIHJlcXVpcmVzIG9uLWNoaXAgSU9NTVUgdG8gcGVyZm9ybSAxOjEKcGFzc3Rocm91Z2ggdHJh
bnNsYXRpb24gZnJvbSBQQSB0byBJT1ZBIGFzLWlzIHRvIGJlZ2luIHdpdGgsIGFuZAoucmVzZXRf
bWFwIGlzIHRoZSBvbmx5IG1lYW5zIHRvIHR1cm4gYmFjayBpb3RsYiB0byB0aGUgaWRlbnRpdHkK
bWFwcGluZyBtb2RlIGFmdGVyIHZob3N0LXZkcGEgaXMgZ29uZS4KClRoZSBkaWZmZXJlbmNlIGlu
IGJlaGF2aW9yIGRpZCBub3QgbWF0dGVyIGFzIFFFTVUgdW5tYXBzIGFsbCB0aGUKbWVtb3J5IHVu
cmVnaXN0ZXJpbmcgdGhlIG1lbW9yeSBsaXN0ZW5lciBhdCB2aG9zdF92ZHBhX2Rldl9zdGFydCgK
c3RhcnRlZCA9IGZhbHNlKSwgYnV0IHRoZSBiYWNrZW5kIGFja25vd2xlZGdpbmcgdGhpcyBmZWF0
dXJlIGZsYWcKYWxsb3dzIFFFTVUgdG8gbWFrZSBzdXJlIGl0IGlzIHNhZmUgdG8gc2tpcCB0aGlz
IHVubWFwICYgbWFwIGluIHRoZQpjYXNlIG9mIHZob3N0IHN0b3AgJiBzdGFydCBjeWNsZS4KCklu
IHRoYXQgc2Vuc2UsIHRoaXMgZmVhdHVyZSBmbGFnIGlzIGFjdHVhbGx5IGEgc2lnbmFsIGZvciB1
c2Vyc3BhY2UKdG8ga25vdyB0aGF0IHRoZSBkcml2ZXIgYnVnIGhhcyBiZWVuIHNvbHZlZC4gTm90
IG9mZmVyaW5nIGl0CmluZGljYXRlcyB0aGF0IHVzZXJzcGFjZSBjYW5ub3QgdHJ1c3QgdGhlIGtl
cm5lbCB3aWxsIHJldGFpbiB0aGUKbWFwcy4KClNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNp
LXdlaS5saXVAb3JhY2xlLmNvbT4KQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTUgKysr
KysrKysrKysrKysrCiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8ICAyICsrCiAy
IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCmluZGV4IGEzZjgxNjBjOTgwNy4uOTIw
Mjk4NmE3ZDgxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYworKysgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwpAQCAtNDM4LDYgKzQzOCwxNSBAQCBzdGF0aWMgdTY0IHZob3N0X3ZkcGFf
Z2V0X2JhY2tlbmRfZmVhdHVyZXMoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYpCiAJCXJldHVy
biBvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKHZkcGEpOwogfQogCitzdGF0aWMgYm9vbCB2aG9z
dF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKK3sK
KwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOworCWNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKKworCXJldHVybiAoIW9wcy0+c2V0X21h
cCAmJiAhb3BzLT5kbWFfbWFwKSB8fCBvcHMtPnJlc2V0X21hcCB8fAorCSAgICAgICB2aG9zdF92
ZHBhX2dldF9iYWNrZW5kX2ZlYXR1cmVzKHYpICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfSU9U
TEJfUEVSU0lTVCk7Cit9CisKIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJlcCkKIHsKIAlzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwpAQCAtNzI1LDYgKzczNCw3IEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAogCQkJcmV0dXJu
IC1FRkFVTFQ7CiAJCWlmIChmZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVT
IHwKIAkJCQkgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKSB8CisJCQkJIEJJVF9V
TEwoVkhPU1RfQkFDS0VORF9GX0lPVExCX1BFUlNJU1QpIHwKIAkJCQkgQklUX1VMTChWSE9TVF9C
QUNLRU5EX0ZfU1VTUEVORCkgfAogCQkJCSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUp
IHwKIAkJCQkgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSykp
KQpAQCAtNzQxLDYgKzc1MSw5IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9j
dGwoc3RydWN0IGZpbGUgKmZpbGVwLAogCQlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9C
QUNLRU5EX0ZfREVTQ19BU0lEKSkgJiYKIAkJICAgICAhdmhvc3RfdmRwYV9oYXNfZGVzY19ncm91
cCh2KSkKIAkJCXJldHVybiAtRU9QTk9UU1VQUDsKKwkJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwo
VkhPU1RfQkFDS0VORF9GX0lPVExCX1BFUlNJU1QpKSAmJgorCQkgICAgICF2aG9zdF92ZHBhX2hh
c19wZXJzaXN0ZW50X21hcCh2KSkKKwkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAkJdmhvc3Rfc2V0
X2JhY2tlbmRfZmVhdHVyZXMoJnYtPnZkZXYsIGZlYXR1cmVzKTsKIAkJcmV0dXJuIDA7CiAJfQpA
QCAtNzk2LDYgKzgwOSw4IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwo
c3RydWN0IGZpbGUgKmZpbGVwLAogCQkJZmVhdHVyZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5E
X0ZfUkVTVU1FKTsKIAkJaWYgKHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAodikpCiAJCQlmZWF0
dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpOworCQlpZiAodmhvc3Rf
dmRwYV9oYXNfcGVyc2lzdGVudF9tYXAodikpCisJCQlmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NU
X0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKTsKIAkJZmVhdHVyZXMgfD0gdmhvc3RfdmRwYV9nZXRf
YmFja2VuZF9mZWF0dXJlcyh2KTsKIAkJaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1
cmVzLCBzaXplb2YoZmVhdHVyZXMpKSkKIAkJCXIgPSAtRUZBVUxUOwpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3Rf
dHlwZXMuaAppbmRleCAxOGFkNmFlN2FiNWMuLmQ3NjU2OTA4ZjczMCAxMDA2NDQKLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zo
b3N0X3R5cGVzLmgKQEAgLTE5MCw1ICsxOTAsNyBAQCBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3Jh
bmdlIHsKICAqIGJ1ZmZlcnMgbWF5IHJlc2lkZS4gUmVxdWlyZXMgVkhPU1RfQkFDS0VORF9GX0lP
VExCX0FTSUQuCiAgKi8KICNkZWZpbmUgVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCAgICAweDcK
Ky8qIElPVExCIGRvbid0IGZsdXNoIG1lbW9yeSBtYXBwaW5nIGFjcm9zcyBkZXZpY2UgcmVzZXQg
Ki8KKyNkZWZpbmUgVkhPU1RfQkFDS0VORF9GX0lPVExCX1BFUlNJU1QgIDB4OAogCiAjZW5kaWYK
LS0gCjIuMzkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
