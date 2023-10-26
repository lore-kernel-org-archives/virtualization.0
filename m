Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D0EC25B6F
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0891830B8;
	Thu, 26 Oct 2023 07:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0891830B8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=APLFxUnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gINnoJz15197; Thu, 26 Oct 2023 07:17:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 01B60830DE;
	Thu, 26 Oct 2023 07:17:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01B60830DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0787CC0DD2;
	Thu, 26 Oct 2023 07:17:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45DB6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20A5E41FA2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20A5E41FA2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=APLFxUnm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6lOqrSZatup
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5963741F9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5963741F9F
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q4AI4s026233; Thu, 26 Oct 2023 07:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=9k2d/53CGD70zPcIiDbCkVndsu3gKKkDw/PStLhE0u4=;
 b=APLFxUnmOrelaS9ysC8XnbAioRzcNiv1psfx5r9Lyr5u9hVIErjHc6Ik9Ha6YqsComEG
 tiCm+TpoxV6KxsZlBN8PjsFY0eTCFRNJ7Q+xw4d+ocS3jyjiZZ0haRxF/s3ZaPgpGSkP
 hh3NJfXj7Jd4QRrvYJymwzWW121PrPGGwbHkgx3oSV+3BGfDl0m6UNwYW6oPU3ZNmo6L
 yJifVSzYwh5fndavK6Sf8CaV+RjPBjF+j9bd35rfoDURNHcz2/ggGfKe0YUrYX+dK1oY
 2iUJJalyvP+A03DXaF+0pb7DKy1LtzdkvS3wn6UNAMro0GmlMXA8eppLQc/4Qeqh6n72 MA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76uaaqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:17:29 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39Q6tbAI015200; Thu, 26 Oct 2023 07:17:29 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3tv537t53r-4; Thu, 26 Oct 2023 07:17:28 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v5 3/7] vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
Date: Thu, 26 Oct 2023 00:14:36 -0700
Message-Id: <1698304480-18463-4-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: XAkapsrx_IZ8HuZxS0pHMfK541Vslfz2
X-Proofpoint-ORIG-GUID: XAkapsrx_IZ8HuZxS0pHMfK541Vslfz2
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
LXZkcGEgaW90bGIgaW4KdGhlIGtlcm5lbCBjYW4gYmUgdHJ1c3RlZCB0byBwZXJzaXN0IElPVExC
IG1hcHBpbmcgYWNyb3NzIHZEUEEgcmVzZXQuCldpdGhvdXQgaXQsIHVzZXJzcGFjZSBoYXMgbm8g
d2F5IHRvIHRlbGwgYXBhcnQgaWYgaXQncyBydW5uaW5nIG9uIGFuCm9sZGVyIGtlcm5lbCwgd2hp
Y2ggY291bGQgc2lsZW50bHkgZHJvcCBhbGwgaW90bGIgbWFwcGluZyBhY3Jvc3MgdkRQQQpyZXNl
dCwgZXNwZWNpYWxseSB3aXRoIGJyb2tlbiBwYXJlbnQgZHJpdmVyIGltcGxlbWVudGF0aW9uIGZv
ciB0aGUKLnJlc2V0IGRyaXZlciBvcC4gVGhlIGJyb2tlbiBkcml2ZXIgbWF5IGluY29ycmVjdGx5
IGRyb3AgYWxsIG1hcHBpbmdzIG9mCml0cyBvd24gYXMgcGFydCBvZiAucmVzZXQsIHdoaWNoIGlu
YWR2ZXJ0ZW50bHkgZW5kcyB1cCB3aXRoIGNvcnJ1cHRlZAptYXBwaW5nIHN0YXRlIGJldHdlZW4g
dmhvc3QtdmRwYSB1c2Vyc3BhY2UgYW5kIHRoZSBrZXJuZWwuIEFzIGEKd29ya2Fyb3VuZCwgdG8g
bWFrZSB0aGUgbWFwcGluZyBiZWhhdmlvdXIgcHJlZGljdGFibGUgYWNyb3NzIHJlc2V0LAp1c2Vy
c3BhY2UgaGFzIHRvIHByby1hY3RpdmVseSByZW1vdmUgYWxsIG1hcHBpbmdzIGJlZm9yZSB2RFBB
IHJlc2V0LCBhbmQKdGhlbiByZXN0b3JlIGFsbCB0aGUgbWFwcGluZ3MgYWZ0ZXJ3YXJkcy4gVGhp
cyB3b3JrYXJvdW5kIGlzIGRvbmUKdW5jb25kaXRpb25hbGx5IG9uIHRvcCBvZiBhbGwgcGFyZW50
IGRyaXZlcnMgdG9kYXksIGR1ZSB0byB0aGUgcGFyZW50CmRyaXZlciBpbXBsZW1lbnRhdGlvbiBp
c3N1ZSBhbmQgbm8gbWVhbnMgdG8gZGlmZmVyZW50aWF0ZS4gIFRoaXMKd29ya2Fyb3VuZCBoYWQg
YmVlbiB1dGlsaXplZCBpbiBRRU1VIHNpbmNlIGRheSBvbmUgd2hlbiB0aGUKY29ycmVzcG9uZGlu
ZyB2aG9zdC12ZHBhIHVzZXJzcGFjZSBiYWNrZW5kIGNhbWUgdG8gdGhlIHdvcmxkLgoKVGhlcmUg
YXJlIDMgY2FzZXMgdGhhdCBiYWNrZW5kIG1heSBjbGFpbSB0aGlzIGZlYXR1cmUgYml0IG9uIGZv
cjoKCi0gcGFyZW50IGRldmljZSB0aGF0IGhhcyB0byB3b3JrIHdpdGggcGxhdGZvcm0gSU9NTVUK
LSBwYXJlbnQgZGV2aWNlIHdpdGggb24tY2hpcCBJT01NVSB0aGF0IGhhcyB0aGUgZXhwZWN0ZWQK
ICAucmVzZXRfbWFwIHN1cHBvcnQgaW4gZHJpdmVyCi0gcGFyZW50IGRldmljZSB3aXRoIHZlbmRv
ciBzcGVjaWZpYyBJT01NVSBpbXBsZW1lbnRhdGlvbiB3aXRoCiAgcGVyc2lzdGVudCBJT1RMQiBt
YXBwaW5nIGFscmVhZHkgdGhhdCBoYXMgdG8gc3BlY2lmaWNhbGx5CiAgZGVjbGFyZSB0aGlzIGJh
Y2tlbmQgZmVhdHVyZQoKVGhlIHJlYXNvbiB3aHkgLnJlc2V0X21hcCBpcyBiZWluZyBvbmUgb2Yg
dGhlIHByZS1jb25kaXRpb24gZm9yCnBlcnNpc3RlbnQgaW90bGIgaXMgYmVjYXVzZSB3aXRob3V0
IGl0LCB2aG9zdC12ZHBhIGNhbid0IHN3aXRjaCBiYWNrCmlvdGxiIHRvIHRoZSBpbml0aWFsIHN0
YXRlIGxhdGVyIG9uLCBlc3BlY2lhbGx5IGZvciB0aGUgb24tY2hpcCBJT01NVQpjYXNlIHdoaWNo
IHN0YXJ0cyB3aXRoIGlkZW50aXR5IG1hcHBpbmcgYXQgZGV2aWNlIGNyZWF0aW9uLiB2aXJ0aW8t
dmRwYQpyZXF1aXJlcyBvbi1jaGlwIElPTU1VIHRvIHBlcmZvcm0gMToxIHBhc3N0aHJvdWdoIHRy
YW5zbGF0aW9uIGZyb20gUEEgdG8KSU9WQSBhcy1pcyB0byBiZWdpbiB3aXRoLCBhbmQgLnJlc2V0
X21hcCBpcyB0aGUgb25seSBtZWFucyB0byB0dXJuIGJhY2sKaW90bGIgdG8gdGhlIGlkZW50aXR5
IG1hcHBpbmcgbW9kZSBhZnRlciB2aG9zdC12ZHBhIGlzIGdvbmUuCgpUaGUgZGlmZmVyZW5jZSBp
biBiZWhhdmlvciBkaWQgbm90IG1hdHRlciBhcyBRRU1VIHVubWFwcyBhbGwgdGhlIG1lbW9yeQp1
bnJlZ2lzdGVyaW5nIHRoZSBtZW1vcnkgbGlzdGVuZXIgYXQgdmhvc3RfdmRwYV9kZXZfc3RhcnQo
IHN0YXJ0ZWQgPQpmYWxzZSksIGJ1dCB0aGUgYmFja2VuZCBhY2tub3dsZWRnaW5nIHRoaXMgZmVh
dHVyZSBmbGFnIGFsbG93cyBRRU1VIHRvCm1ha2Ugc3VyZSBpdCBpcyBzYWZlIHRvIHNraXAgdGhp
cyB1bm1hcCAmIG1hcCBpbiB0aGUgY2FzZSBvZiB2aG9zdCBzdG9wCiYgc3RhcnQgY3ljbGUuCgpJ
biB0aGF0IHNlbnNlLCB0aGlzIGZlYXR1cmUgZmxhZyBpcyBhY3R1YWxseSBhIHNpZ25hbCBmb3Ig
dXNlcnNwYWNlIHRvCmtub3cgdGhhdCB0aGUgZHJpdmVyIGJ1ZyBoYXMgYmVlbiBzb2x2ZWQuIE5v
dCBvZmZlcmluZyBpdCBpbmRpY2F0ZXMgdGhhdAp1c2Vyc3BhY2UgY2Fubm90IHRydXN0IHRoZSBr
ZXJuZWwgd2lsbCByZXRhaW4gdGhlIG1hcHMuCgpTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxz
aS13ZWkubGl1QG9yYWNsZS5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE1ICsr
KysrKysrKysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggfCAgMiArKwog
MiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwppbmRleCBjNmJmZTliZGRlNDIuLmFj
YzdjNzRiYTdkNiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKQEAgLTQzOSw2ICs0MzksMTUgQEAgc3RhdGljIHU2NCB2aG9zdF92ZHBh
X2dldF9iYWNrZW5kX2ZlYXR1cmVzKGNvbnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2KQogCQlyZXR1
cm4gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2ZHBhKTsKIH0KIAorc3RhdGljIGJvb2wgdmhv
c3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYpCit7
CisJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKKwljb25zdCBzdHJ1Y3QgdmRw
YV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7CisKKwlyZXR1cm4gKCFvcHMtPnNldF9t
YXAgJiYgIW9wcy0+ZG1hX21hcCkgfHwgb3BzLT5yZXNldF9tYXAgfHwKKwkgICAgICAgdmhvc3Rf
dmRwYV9nZXRfYmFja2VuZF9mZWF0dXJlcyh2KSAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0lP
VExCX1BFUlNJU1QpOworfQorCiBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVyZXApCiB7CiAJc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKQEAgLTcyNiw2ICs3MzUsNyBAQCBzdGF0aWMgbG9u
ZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKIAkJCXJldHVy
biAtRUZBVUxUOwogCQlpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJF
UyB8CiAJCQkJIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCkgfAorCQkJCSBCSVRf
VUxMKFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSB8CiAJCQkJIEJJVF9VTEwoVkhPU1Rf
QkFDS0VORF9GX1NVU1BFTkQpIHwKIAkJCQkgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1F
KSB8CiAJCQkJIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sp
KSkKQEAgLTc0Miw2ICs3NTIsOSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKIAkJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1Rf
QkFDS0VORF9GX0RFU0NfQVNJRCkpICYmCiAJCSAgICAgIXZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3Jv
dXAodikpCiAJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CisJCWlmICgoZmVhdHVyZXMgJiBCSVRfVUxM
KFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSkgJiYKKwkJICAgICAhdmhvc3RfdmRwYV9o
YXNfcGVyc2lzdGVudF9tYXAodikpCisJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CiAJCXZob3N0X3Nl
dF9iYWNrZW5kX2ZlYXR1cmVzKCZ2LT52ZGV2LCBmZWF0dXJlcyk7CiAJCXJldHVybiAwOwogCX0K
QEAgLTc5Nyw2ICs4MTAsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlcCwKIAkJCWZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX1JFU1VNRSk7CiAJCWlmICh2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3VwKHYpKQogCQkJZmVh
dHVyZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKTsKKwkJaWYgKHZob3N0
X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKHYpKQorCQkJZmVhdHVyZXMgfD0gQklUX1VMTChWSE9T
VF9CQUNLRU5EX0ZfSU9UTEJfUEVSU0lTVCk7CiAJCWZlYXR1cmVzIHw9IHZob3N0X3ZkcGFfZ2V0
X2JhY2tlbmRfZmVhdHVyZXModik7CiAJCWlmIChjb3B5X3RvX3VzZXIoZmVhdHVyZXAsICZmZWF0
dXJlcywgc2l6ZW9mKGZlYXR1cmVzKSkpCiAJCQlyID0gLUVGQVVMVDsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0
X3R5cGVzLmgKaW5kZXggMThhZDZhZTdhYjVjLi5kNzY1NjkwOGY3MzAgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92
aG9zdF90eXBlcy5oCkBAIC0xOTAsNSArMTkwLDcgQEAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9y
YW5nZSB7CiAgKiBidWZmZXJzIG1heSByZXNpZGUuIFJlcXVpcmVzIFZIT1NUX0JBQ0tFTkRfRl9J
T1RMQl9BU0lELgogICovCiAjZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQgICAgMHg3
CisvKiBJT1RMQiBkb24ndCBmbHVzaCBtZW1vcnkgbWFwcGluZyBhY3Jvc3MgZGV2aWNlIHJlc2V0
ICovCisjZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUICAweDgKIAogI2VuZGlm
Ci0tIAoyLjM5LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
