Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5363AC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 13:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7752828A9;
	Mon, 26 Sep 2022 13:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7752828A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvhVPKQN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YofEZLKgFCi; Mon, 26 Sep 2022 13:15:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4004682A0B;
	Mon, 26 Sep 2022 13:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4004682A0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 145C4C0033;
	Mon, 26 Sep 2022 13:15:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F921C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47E3D40BE9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47E3D40BE9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com
 header.a=rsa-sha256 header.s=pp1 header.b=hvhVPKQN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckY2evdVc78B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:15:44 +0000 (UTC)
X-Greylist: delayed 00:42:50 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80CA040BEE
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80CA040BEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:15:44 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QAgGR2040377;
 Mon, 26 Sep 2022 12:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LwYe0rqnIwkPr/6i34zbZrq42JrO4q9+e/lsvkT4moU=;
 b=hvhVPKQN1FEJWOPSo8YHe2vB4Edyjc8NAnzkgCunOr02abENXcy0nhFfhDVQC2a5OdGi
 2/BZwXgiPgvAY4OW3ZXAvRXU2y4bCmY8tuBP6aJ28k+e0jH8gc6r/ZNsNilj1g23BOML
 nPPpmnkixH2xpttfDEmxVOLNPxz9n99ECRK6NwNa1uNNITzi370mVDYtCGW15fncK8U+
 HuXu+w87roMtE0H6WNI1AJ/ORASSQQtTay4gYRqedHx6rwlQXv4bVfB5pD5ehgoSVwgI
 B4+1fqZTh6T3eqB6fyzmy9zprGc3M7e94yLW1KUVD+8A6rJ2AUiJdCik33fy2htsOsSD Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juaj9u48j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 12:32:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QBg1iF035764;
 Mon, 26 Sep 2022 12:32:30 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3juaj9u47k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 12:32:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QCLRAx028467;
 Mon, 26 Sep 2022 12:32:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma01fra.de.ibm.com with ESMTP id 3jssh8st30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Sep 2022 12:32:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 28QCWP4T50659810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Sep 2022 12:32:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD4C2A405B;
 Mon, 26 Sep 2022 12:32:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03EE4A4064;
 Mon, 26 Sep 2022 12:32:25 +0000 (GMT)
Received: from [9.171.20.172] (unknown [9.171.20.172])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 26 Sep 2022 12:32:24 +0000 (GMT)
Message-ID: <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
Date: Mon, 26 Sep 2022 14:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: peterz@infradead.org
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
In-Reply-To: <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _396JyvztbuSkpeimeTAG1CEme02xONc
X-Proofpoint-ORIG-GUID: pMmy3F52peTfAA4qOM_y04VF95GksKs4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260079
Cc: vincent.guittot@linaro.org, linux-pm@vger.kernel.org, bigeasy@linutronix.de,
 Amit Shah <amit@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@kernel.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 mgorman@suse.de, oleg@redhat.com, tj@kernel.org,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, will@kernel.org,
 dietmar.eggemann@arm.com, ebiederm@xmission.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpBbSAyNi4wOS4yMiB1bSAxMjo1NSBzY2hyaWViIENocmlzdGlhbiBCb3JudHJhZWdlcjoKPiAK
PiAKPiBBbSAyNi4wOS4yMiB1bSAxMDowNiBzY2hyaWViIENocmlzdGlhbiBCb3JudHJhZWdlcjoK
Pj4KPj4KPj4gQW0gMjMuMDkuMjIgdW0gMDk6NTMgc2NocmllYiBDaHJpc3RpYW4gQm9ybnRyYWVn
ZXI6Cj4+PiBBbSAyMy4wOS4yMiB1bSAwOToyMSBzY2hyaWViIENocmlzdGlhbiBCb3JudHJhZWdl
cjoKPj4+PiBQZXRlciwKPj4+Pgo+Pj4+IGFzIGEgaGVhZHMtdXAuIFRoaXMgY29tbWl0IChiaXNl
Y3RlZCBhbmQgdmVyaWZpZWQpIHRyaWdnZXJzIGEKPj4+PiByZWdyZXNzaW9uIGluIG91ciBLVk0g
b24gczM5MHggQ0kuIFRoZSBzeW1wdG9tIGlzIHRoYXQgYSBzcGVjaWZpYwo+Pj4+IHRlc3RjYXNl
IChzdGFydCBhIGd1ZXN0IHdpdGggbmV4dCBrZXJuZWwgYW5kIGEgcG9reSByYW1kaXNrLAo+Pj4+
IHRoZW4gc3NoIHZpYSB2c29jayBpbnRvIHRoZSBndWVzdCBhbmQgcnVuIHRoZSByZWJvb3QgY29t
bWFuZCkgbm93Cj4+Pj4gdGFrZXMgbXVjaCBsb25nZXIgKDMwMCBpbnN0ZWFkIG9mIDIwIHNlY29u
ZHMpLiBGcm9tIGEgZmlyc3QgbG9vawo+Pj4+IGl0IHNlZW1zIHRoYXQgdGhlIHNzaGQgdGFrZXMg
dmVyeSBsb25nIHRvIGVuZCBkdXJpbmcgc2h1dGRvd24KPj4+PiBidXQgSSBoYXZlIG5vdCBsb29r
ZWQgaW50byB0aGF0IHlldC4KPj4+PiBBbnkgcXVpY2sgaWRlYT8KPj4+Pgo+Pj4+IENocmlzdGlh
bgo+Pj4KPj4+IHRoZSBzc2hkIHNlZW1zIHRvIGhhbmcgaW4gdmlydGlvLXNlcmlhbCAobm90IHZz
b2NrKS4KPj4KPj4gRldJVywgc3NoZCBkb2VzIG5vdCBzZWVtIHRvIGhhbmcsIGluc3RlYWQgaXQg
c2VlbXMgdG8gYnVzeSBsb29wIGluCj4+IHdhaXRfcG9ydF93cml0YWJsZSBjYWxsaW5nIGludG8g
dGhlIHNjaGVkdWxlciBvdmVyIGFuZCBvdmVyIGFnYWluLgo+IAo+IC0jZGVmaW5lIFRBU0tfRlJF
RVpBQkxFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAwMjAwMAo+ICsjZGVm
aW5lIFRBU0tfRlJFRVpBQkxFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAw
MDAwMAo+IAo+ICJGaXhlcyIgdGhlIGlzc3VlLiBKdXN0IGhhdmUgdG8gZmluZCBvdXQgd2hpY2gg
b2YgdXNlcnMgaXMgcmVzcG9uc2libGUuCgpTbyBpdCBzZWVtcyB0aGF0IG15IGluaXRpYWwgdGVz
dCB3YXMgbm90IGdvb2QgZW5vdWdoLgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci92aXJ0aW9f
Y29uc29sZS5jIGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKaW5kZXggOWZhM2M3NmEy
NjdmLi5lOTNkZjRmNzM1ZmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29s
ZS5jCisrKyBiL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jCkBAIC03OTAsNyArNzkwLDcg
QEAgc3RhdGljIGludCB3YWl0X3BvcnRfd3JpdGFibGUoc3RydWN0IHBvcnQgKnBvcnQsIGJvb2wg
bm9uYmxvY2spCiAgICAgICAgICAgICAgICAgaWYgKG5vbmJsb2NrKQogICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FQUdBSU47CiAgCi0gICAgICAgICAgICAgICByZXQgPSB3YWl0X2V2
ZW50X2ZyZWV6YWJsZShwb3J0LT53YWl0cXVldWUsCisgICAgICAgICAgICAgICByZXQgPSB3YWl0
X2V2ZW50X2ludGVycnVwdGlibGUocG9ydC0+d2FpdHF1ZXVlLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICF3aWxsX3dyaXRlX2Jsb2NrKHBvcnQpKTsKICAgICAg
ICAgICAgICAgICBpZiAocmV0IDwgMCkKICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7CgpEb2VzIGZpeCB0aGUgcHJvYmxlbS4KTXkgaW5pdGlhbCB0ZXN0IHdhcyB0aGUgZm9sbG93
aW5nCgotLS0gYS9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYworKysgYi9kcml2ZXJzL2No
YXIvdmlydGlvX2NvbnNvbGUuYwpAQCAtNzkwLDEwICs3OTAsOCBAQCBzdGF0aWMgaW50IHdhaXRf
cG9ydF93cml0YWJsZShzdHJ1Y3QgcG9ydCAqcG9ydCwgYm9vbCBub25ibG9jaykKICAgICAgICAg
ICAgICAgICBpZiAobm9uYmxvY2spCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVB
R0FJTjsKICAKLSAgICAgICAgICAgICAgIHJldCA9IHdhaXRfZXZlbnRfZnJlZXphYmxlKHBvcnQt
PndhaXRxdWV1ZSwKKyAgICAgICAgICAgICAgIHdhaXRfZXZlbnQocG9ydC0+d2FpdHF1ZXVlLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICF3aWxsX3dyaXRlX2Js
b2NrKHBvcnQpKTsKLSAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQotICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0OwogICAgICAgICB9CiAgICAgICAgIC8qIFBvcnQgZ290IGhvdC11
bnBsdWdnZWQuICovCiAgICAgICAgIGlmICghcG9ydC0+Z3Vlc3RfY29ubmVjdGVkKQoKYW5kIG9i
dmlvdXNseSBpdCBkaWQgbm90IHByb3ZpZGUgYW4gZXhpdCBwYXRoLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
