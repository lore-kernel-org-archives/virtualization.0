Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4EC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 02:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C3C84197C;
	Thu, 28 Apr 2022 02:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HxkY-1KvDhQD; Thu, 28 Apr 2022 02:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 610D94197D;
	Thu, 28 Apr 2022 02:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D59CC0039;
	Thu, 28 Apr 2022 02:43:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B17E1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89D9A404B7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_myyRNWLckP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92FFD40159
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:43:48 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S0NxE0007306;
 Thu, 28 Apr 2022 02:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=I7+IAwtxTapFJYhZvZoTTtFaCWq9J4pTQ54VhBKsD98=;
 b=QKt0TXVH91lvQtZQ/uF69kApFnBTeX1jX78tbyzUMuk5Y9EXGTIxmll2If33yJBf6kV4
 zPYOzSHCR02SPUuIBePqGEYKGXyP2hjUWx8HswPXqFAoMnxWZn5Edu0S+rfvqY39cteP
 WKsSXY7J//znvVghINQ8bwylBlPbSVMV+mUVTmK28JvhNl0T4U7HYRN/HzKyufb9U5dg
 6Rt+RNiS8IaD/EY1sUw844+c8pp5gpQYBwGyAMkzfJk5k1czawTfPeJBMs2CU9oeS1o5
 /nX+CjA4i6ZRyeuNfGugD23fcY/wmexJl/TbQOqsD1smv3zlaT017pohQg6P6SzZ5i4i 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqgbk1y06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Apr 2022 02:43:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23S2fGmr000616;
 Thu, 28 Apr 2022 02:43:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqgbk1xyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Apr 2022 02:43:22 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S2dWei004030;
 Thu, 28 Apr 2022 02:43:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma01fra.de.ibm.com with ESMTP id 3fm938wb0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Apr 2022 02:43:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 23S2hIEF55771408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Apr 2022 02:43:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F863A404D;
 Thu, 28 Apr 2022 02:43:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C402EA4040;
 Thu, 28 Apr 2022 02:43:17 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.21.163])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Thu, 28 Apr 2022 02:43:17 +0000 (GMT)
Date: Thu, 28 Apr 2022 04:43:15 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428044315.3945e660.pasic@linux.ibm.com>
In-Reply-To: <87ilqu7u6w.fsf@redhat.com>
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nVGGsjJyI-Dp1hqx04GKo6n8n4njrryo
X-Proofpoint-GUID: -3sWKC2dVUz214jceQbUHmppgsr5vVfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280012
Cc: paulmck@kernel.org, lulu@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 peterz@infradead.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 eperezma@redhat.com, tglx@linutronix.de
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

T24gV2VkLCAyNyBBcHIgMjAyMiAxMToyNzowMyArMDIwMApDb3JuZWxpYSBIdWNrIDxjb2h1Y2tA
cmVkaGF0LmNvbT4gd3JvdGU6Cgo+IE9uIFR1ZSwgQXByIDI2IDIwMjIsICJNaWNoYWVsIFMuIFRz
aXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gPiBPbiBUdWUsIEFwciAyNiwgMjAy
MiBhdCAwNTo0NzoxN1BNICswMjAwLCBDb3JuZWxpYSBIdWNrIHdyb3RlOiAgCj4gPj4gT24gTW9u
LCBBcHIgMjUgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+PiAgIAo+ID4+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQw
MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOiAgCj4gPj4gPj4gT24gVHVlLCBBcHIgMjYsIDIw
MjIgYXQgMTE6NDI6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZTogIAo+ID4+ID4+ID4gCj4g
Pj4gPj4gPiDlnKggMjAyMi80LzI2IDExOjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOiAg
Cj4gPj4gPj4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDExOjM1OjQxUE0gLTA0MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+ID4+ID4+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAy
MDIyIGF0IDA0OjI5OjExQU0gKzAyMDAsIEhhbGlsIFBhc2ljIHdyb3RlOiAgCj4gPj4gPj4gPiA+
ID4gPiBPbiBNb24sIDI1IEFwciAyMDIyIDA5OjU5OjU1IC0wNDAwCj4gPj4gPj4gPiA+ID4gPiAi
TWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+ID4+ID4gPiA+
ID4gICAKPiA+PiA+PiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRB
TSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZTogIAo+ID4+ID4+ID4gPiA+ID4gPiA+IE9uIE1v
biwgQXByIDI1IDIwMjIsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6ICAKPiA+PiA+PiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjQ0
OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6ICAKPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4g
VGhpcyBwYXRjaCB0cmllcyB0byBpbXBsZW1lbnQgdGhlIHN5bmNocm9uaXplX2NicygpIGZvciBj
Y3cuIEZvciB0aGUKPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhh
dCBpcyBjYWxsZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPj4gPj4gPiA+ID4g
PiA+ID4gPiA+IHN5bmNocm9uaXphdGlvbiBpcyBzaW1wbHkgZG9uZSB2aWEgdGhlIGFpcnFfaW5m
bydzIGxvY2suIEZvciB0aGUKPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0
KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKSwgYSBwZXIKPiA+
PiA+PiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEgaXMgaW50cm9kdWNl
ZCBhbnMgdXNlZCBpbiB0aGUgc3luY2hyb25pemF0aW9uCj4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+
IG1ldGhvZC4KPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gCj4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+
IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiA+PiA+PiA+ID4gPiA+
ID4gPiA+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KPiA+PiA+
PiA+ID4gPiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1ja0BrZXJuZWwu
b3JnPgo+ID4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVs
Lm9yZz4KPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNpY0BsaW51
eC5pYm0uY29tPgo+ID4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29o
dWNrQHJlZGhhdC5jb20+Cj4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+ICAKPiA+PiA+PiA+ID4gPiA+ID4gPiA+IAo+
ID4+ID4+ID4gPiA+ID4gPiA+ID4gVGhpcyBpcyB0aGUgb25seSBvbmUgdGhhdCBpcyBnaXZpbmcg
bWUgcGF1c2UuIEhhbGlsLCBDb3JuZWxpYSwKPiA+PiA+PiA+ID4gPiA+ID4gPiA+IHNob3VsZCB3
ZSBiZSBjb25jZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGltcGFjdCBoZXJlPwo+ID4+ID4+
ID4gPiA+ID4gPiA+ID4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVzdGVkPyAgCj4gPj4gPj4gPiA+
ID4gPiA+ID4gV2UgY2FuIGhhdmUgYSBidW5jaCBvZiBkZXZpY2VzIHVzaW5nIHRoZSBzYW1lIGFp
cnEgc3RydWN0dXJlLCBhbmQgdGhlCj4gPj4gPj4gPiA+ID4gPiA+ID4gc3luYyBjYiBjcmVhdGVz
IGEgY2hva2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0ZXJpbmcvdW5yZWdpc3RlcmluZy4gIAo+ID4+
ID4+ID4gPiA+ID4gPiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBt
dWx0aXBsZSBDUFVzIGF0IHRoZSBtb21lbnQ/ICAKPiA+PiA+PiA+ID4gPiA+IEknbSBub3Qgc3Vy
ZSBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLgo+ID4+ID4+ID4gPiA+ID4gCj4gPj4gPj4gPiA+
ID4gPiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZlIG11bHRpcGxlIENQVXMgdGhhdCBhcmUgZXhlY3V0
aW5nIHNvbWUgcG9ydGlvbiBvZgo+ID4+ID4+ID4gPiA+ID4gdmlydGlvX2Njd19pbnRfaGFuZGxl
cigpLiBTbyBJIGd1ZXNzIHRoZSBhbnN3ZXIgaXMgeWVzLiBDb25uaWUgd2hhdCBkbyB5b3UgdGhp
bms/Cj4gPj4gPj4gPiA+ID4gPiAKPiA+PiA+PiA+ID4gPiA+IE9uIHRoZSBvdGhlciBoYW5kIHdl
IGNvdWxkIGFsc28gZW5kIHVwIHNlcmlhbGl6aW5nIHN5bmNocm9uaXplX2NicygpCj4gPj4gPj4g
PiA+ID4gPiBjYWxscyBmb3IgZGlmZmVyZW50IGRldmljZXMgaWYgdGhleSBoYXBwZW4gdG8gdXNl
IHRoZSBzYW1lIGFpcnFfaW5mby4gQnV0Cj4gPj4gPj4gPiA+ID4gPiB0aGlzIHByb2JhYmx5IHdh
cyBub3QgeW91ciBxdWVzdGlvbiAgCj4gPj4gPj4gPiA+ID4gCj4gPj4gPj4gPiA+ID4gSSBhbSBs
ZXNzIGNvbmNlcm5lZCBhYm91dCAgc3luY2hyb25pemVfY2JzIGJlaW5nIHNsb3cgYW5kIG1vcmUg
YWJvdXQKPiA+PiA+PiA+ID4gPiB0aGUgc2xvd2Rvd24gaW4gaW50ZXJydXB0IHByb2Nlc3Npbmcg
aXRzZWxmLgo+ID4+ID4+ID4gPiA+ICAgCj4gPj4gPj4gPiA+ID4gPiA+IHRoaXMgcGF0Y2ggc2Vy
aWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4gPj4gPj4gPiA+ID4gPiA+ICAgCj4gPj4gPj4g
PiA+ID4gPiBUaG9zZSBjb3VsZCB0aGVuIHBpbGUgdXAgb24gdGhlIG5ld2x5IGludHJvZHVjZWQg
c3BpbmxvY2suICAKPiA+PiAKPiA+PiBIb3cgYmFkIHdvdWxkIHRoYXQgYmUgaW4gcHJhY3RpY2U/
IElJVUMsIHdlIGhpdCBvbiB0aGUgc3BpbmxvY2sgd2hlbgo+ID4+IC0gZG9pbmcgc3luY2hyb25p
emVfY2JzIChzaG91bGQgYmUgcmFyZSkKPiA+PiAtIHByb2Nlc3NpbmcgcXVldWUgaW50ZXJydXB0
cyBmb3IgZGV2aWNlcyB1c2luZyBwZXItZGV2aWNlIGluZGljYXRvcnMKPiA+PiAgICh3aGljaCBp
cyB0aGUgbm9uLXByZWZlcnJlZCBwYXRoLCB3aGljaCBJIHdvdWxkIGJhc2ljYWxseSBvbmx5IGV4
cGVjdAo+ID4+ICAgd2hlbiBydW5uaW5nIG9uIGFuIGFuY2llbnQgb3Igbm9uLXN0YW5kYXJkIGh5
cGVydmlzb3IpICAKPiA+Cj4gPiB0aGlzIG9uZSBpcyBteSBjb25jZXJuLiBJIGFtIHdvcnJpZWQg
c2VyaWFsaXppbmcgZXZlcnl0aGluZyBvbiBhIHNpbmdsZSBsb2NrCj4gPiB3aWxsIGRyYXN0aWNh
bGx5IHJlZ3Jlc3MgcGVyZm9ybWFuY2UgaGVyZS4gIAo+IAo+IFllYWgsIHRoYXQgY2FzZSBjb3Vs
ZCBnZXQgbXVjaCB3b3JzZS4gT1RPSCwgaG93IGxpa2VseSBpcyBpdCB0aGF0IGFueQo+IHNldHVw
IHRoYXQgcnVucyBhIHJlY2VudCBrZXJuZWwgd2lsbCBhY3R1YWxseSBlbmQgdXAgd2l0aCBkZXZp
Y2VzIHVzaW5nCj4gcGVyLWRldmljZSBpbmRpY2F0b3JzPyBBbnl0aGluZyBydW5uaW5nIHVuZGVy
IGEgUUVNVSByZWxlYXNlZCBpbiB0aGUKPiBsYXN0IGNvdXBsZSBvZiB5ZWFycyBpcyB1bmxpa2Vs
eSB0byBub3QgdXNlIGFpcnFzLCBJIHRoaW5rLiBIYWxpbCwgZG8KPiB5b3UgdGhpbmsgdGhhdCB0
aGUgY2xhc3NpYyBpbmRpY2F0b3Igc2V0dXAgd291bGQgYmUgbW9yZSBjb21tb24gb24gYW55Cj4g
bm9uLVFFTVUgaHlwZXJ2aXNvcnM/Cj4gCgpJIHJlYWxseSBkb24ndCBrbm93LiBNeSBvcGluaW9u
IGlzIHRoYXQsIHR3byBzdGFnZXMgaW5kaWNhdG9ycyBhcmUga2luZApvZiByZWNvbW1lbmRlZCBm
b3IgYW55Ym9keSB3aG8gY2FyZXMgYWJvdXQgbm90aWZpY2F0aW9ucyBwZXJmb3JtYW5jZS4KCj4g
SU9XLCBob3cgbXVjaCBlZmZvcnQgaXMgaXQgd29ydGggc3BlbmRpbmcgb24gb3B0aW1pemluZyB0
aGlzIGNhc2U/IFdlCj4gY2VydGFpbmx5IHNob3VsZCBleHBsb3JlIGFueSBzaW1wbGUgc29sdXRp
b25zLCBidXQgSSBkb24ndCB0aGluayB3ZSBuZWVkCj4gdG8gdHdpc3Qgb3Vyc2VsdmVzIGludG8g
cHJldHplbHMgdG8gc29sdmUgaXQuCj4gCgpGcmFua2x5LCBJIHdvdWxkIGJlIGZpbmUgd2l0aCBh
biByd2xvY2sgYmFzZWQgc29sdXRpb24gYXMgcHJvcG9zZWQgYnkKSmFzb24uIE15IHJhdGlvbmFs
ZSBpczogd2UgcmVjb21tZW5kIHR3byBzdGFnZSBpbmRpY2F0b3JzLCBhbmQgdGhlIHR3bwpzdGFn
ZSBpbmRpY2F0b3JzIGFyZSBhbHJlYWR5IGVuY3VtYmVyZWQgYnkgYW4gcndsb2NrIG9uIHRoZSBp
bnRlcnJ1cHQKcGF0aC4gWWVzLCB0aGUgY29hbGVzY2VuY2Ugb2YgYWRhcHRlciBpbnRlcnJ1cHRz
IGlzIGFyY2hpdGVjdHVyYWxseQpkaWZmZXJlbnQsIGFuZCBzbyBpdCBpcyB3aXRoIEdJU0EgKHdp
dGhvdXQgR0lTQSwgSSdtIG5vdCBldmVuIHN1cmUpLCBzbwp0aGlzIHJ3bG9jayBlbmQgdXAgYmVp
bmcgd29yc2UgdGhhbiB0aGUgb25lIGZvciAyIHN0YWdlLiBCdXQgbXkgZmVlbGluZwppcywgdGhh
dCBpdCBzaG91bGQgYmUgZmluZS4gT24gdGhlIG90aGVyIGhhbmQsIEkgZG9uJ3QgZmVlbCBjb21m
b3J0YWJsZQp3aXRoIHBsYWluIHNwaW5sb2NrLCBhbmQgSSBhbSBjdXJpb3VzIGFib3V0IGEgbW9y
ZSBhZHZhbmNlZCBzb2x1dGlvbi4KQnV0IG15IGd1ZXNzIGlzIHRoYXQgcndsb2NrICsgc29tZSB0
ZXN0aW5nIGZvciB0aGUgbGVnYWN5IGluZGljYXRvciBjYXNlCmp1c3QgdG8gZG91YmxlIGNoZWNr
IGlmIHRoZXJlIGlzIGEgaGVhdnkgcmVncmVzc2lvbiBkZXNwaXRlIG9mIG91cgpleHBlY3RhdGlv
bnMgdG8gc2VlIG5vbmUgc2hvdWxkIGRvIHRoZSB0cmljay4KClJlZ2FyZHMsCkhhbGlsCgo+ID4K
PiA+ICAKPiA+PiAtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIGludGVycnVwdHMgKHNob3VsZCBiZSBy
YXJlKQo+ID4+IC0gZHVyaW5nIHNldHVwLCByZXNldCwgZXRjLiAoc2hvdWxkIG5vdCBiZSBhIGNv
bmNlcm4pICAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
