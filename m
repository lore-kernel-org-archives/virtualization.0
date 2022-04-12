Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA663C433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 00:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3448860DC6;
	Tue, 12 Apr 2022 00:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmRNJiI7WBO1; Tue, 12 Apr 2022 00:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C318D60B3B;
	Tue, 12 Apr 2022 00:02:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9473DC0033;
	Tue, 12 Apr 2022 00:02:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA28CC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B329760DC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cT6FVTQ3omvj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:02:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 575AA60B3B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 00:02:28 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BNicXa024777; 
 Tue, 12 Apr 2022 00:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ymhm3gWLFUXXkn5483f/1Rx+YzD94Ie5+Dy9QnMA8pY=;
 b=nMj6Kj2t1b92u0VcCmR6oYCfajpyNsrxYFqMKOSUcbx0EbCBtvtMoNvVxmcjcDCImz5b
 Knyqm9f97FyI7AMfZgI4b4kcQt1lsS+NvtplK1x0TipnVcjSO/sDyaNQzqUnUYtMc3yp
 Losyt5avJAMTUssB1+JIYAoTUOCav761xOdnF1cAibWL56zJ0UZpDEnxVfqDAk6wceWA
 aoxJQDPOmXHqCGFoZvvnvWXU2ntwerzFXWvL9JOon7Hbxm7pQgsh43qIN2VvK6YHOmuO
 XOwzWhrOnAx8CD+j+BKpgG/g2OAyX4uM4xRzZ0Vm4jdGSSUbfJyoaB2OCiij5D7QTPlu dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3fcx9987ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 00:02:05 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23BNnExM003563;
 Tue, 12 Apr 2022 00:02:04 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3fcx9987p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 00:02:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23BNrv2L030620;
 Tue, 12 Apr 2022 00:02:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 3fb1dj3v9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Apr 2022 00:02:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 23C020kV24248614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Apr 2022 00:02:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8251A11C050;
 Tue, 12 Apr 2022 00:02:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C11AC11C04A;
 Tue, 12 Apr 2022 00:01:59 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.66.170])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 12 Apr 2022 00:01:59 +0000 (GMT)
Date: Tue, 12 Apr 2022 02:01:45 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220412020145.32e26e5a.pasic@linux.ibm.com>
In-Reply-To: <877d7vbspu.fsf@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1bvXk22wNw3YGkUdJsgQgRpdAVK_Flry
X-Proofpoint-ORIG-GUID: 0h2qVqskP8RMF8-85NvyW9SJF_9wzeKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_09,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110128
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gTW9uLCAxMSBBcHIgMjAyMiAxNjoyNzo0MSArMDIwMApDb3JuZWxpYSBIdWNrIDxjb2h1Y2tA
cmVkaGF0LmNvbT4gd3JvdGU6Cgo+IE9uIE1vbiwgQXByIDExIDIwMjIsIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+ID4gT24gU3VuLCBBcHIgMTAsIDIwMjIgYXQg
Mzo1MSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZTogIAo+ID4+
Cj4gPj4gT24gRnJpLCBBcHIgMDgsIDIwMjIgYXQgMDM6MDM6MDdQTSArMDIwMCwgSGFsaWwgUGFz
aWMgd3JvdGU6ICAKPiA+PiA+IE9uIFdlZCwgMDYgQXByIDIwMjIgMTU6MDQ6MzIgKzAyMDAKPiA+
PiA+IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiA+ICAKPiA+
PiA+ID4gT24gV2VkLCBBcHIgMDYgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRo
YXQuY29tPiB3cm90ZToKPiA+PiA+ID4gIAo+ID4+ID4gPiA+IE9uIFdlZCwgQXByIDA2LCAyMDIy
IGF0IDA0OjM1OjM3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6ICAKPiA+PiA+ID4gPj4gVGhp
cyBwYXRjaCBpbXBsZW1lbnRzIFBDSSB2ZXJzaW9uIG9mIHN5bmNocm9uaXplX3ZxcygpLgo+ID4+
ID4gPiA+Pgo+ID4+ID4gPiA+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+Cj4gPj4gPiA+ID4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
Cj4gPj4gPiA+ID4+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBhdWxtY2tAa2VybmVsLm9yZz4K
PiA+PiA+ID4gPj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+Cj4gPj4gPiA+ID4+
IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+ICAKPiA+PiA+
ID4gPgo+ID4+ID4gPiA+IFBsZWFzZSBhZGQgaW1wbGVtZW50YXRpb25zIGF0IGxlYXN0IGZvciBj
Y3cgYW5kIG1taW8uICAKPiA+PiA+ID4KPiA+PiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQgKGlmIGFu
eXRoaW5nKSBjYW4vc2hvdWxkIGJlIGRvbmUgZm9yIGNjdy4uLiAgCj4gPj4gPgo+ID4+ID4gSWYg
bm90aGluZyBuZWVkcyB0byBiZSBkb25lIEkgd291bGQgbGlrZSB0byBoYXZlIGF0IGxlYXN0IGEg
Y29tbWVudCBpbgo+ID4+ID4gdGhlIGNvZGUgdGhhdCBleHBsYWlucyB3aHkuIFNvIHRoYXQgc29t
ZWJvZHkgd2hvIHJlYWRzIHRoZSBjb2RlCj4gPj4gPiBkb2Vzbid0IHdvbmRlcjogd2h5IGlzIHZp
cnRpby1jY3cgbm90IGltcGxlbWVudGluZyB0aGF0IGNhbGxiYWNrLiAgCj4gPj4KPiA+PiBSaWdo
dC4KPiA+Pgo+ID4+IEkgYW0gY3VycmVudGx5IHRoaW5raW5nIGluc3RlYWQgb2YgbWFraW5nIHRo
aXMgb3B0aW9uYWwgaW4gdGhlCj4gPj4gY29yZSB3ZSBzaG91bGQgbWFrZSBpdCBtYW5kYXRvcnks
IGFuZCBoYXZlIHRyYW5zcG9ydHMgd2hpY2ggZG8gbm90Cj4gPj4gbmVlZCB0byBzeW5jIGhhdmUg
YW4gZW1wdHkgc3R1YiB3aXRoIGRvY3VtZW50YXRpb24gZXhwbGFpbmluZyB3aHkuICAKPiAKPiBZ
ZXMsIHRoYXQgbWFrZXMgc2Vuc2UgdG8gbWUuIElmIHdlIGNhbiBleHBsYWluIHdoeSB3ZSBkb24n
dCBuZWVkIHRvIGRvCj4gYW55dGhpbmcsIHdlIHNob3VsZCBrZWVwIHRoYXQgZXhwbGFuYXRpb24g
ZWFzaWx5IGFjY2Vzc2libGUuCj4gCj4gPj4KPiA+PiBBbHNvLCBkbyB3ZSB3YW50IHRvIGRvY3Vt
ZW50IHRoaXMgc3luYyBpcyBleHBsaWNpdGx5IGZvciBpcnEgZW5hYmxlL2Rpc2FibGU/Cj4gPj4g
c3luY2hyb25pemVfaXJxX2VuYWJsZV9kaXNhYmxlPyAgCj4gPgo+ID4gSSB3b3VsZCBub3Qgc2lu
Y2UgdGhlIHRyYW5zcG9ydCBpcyBub3QgZ3VhcmFudGVlZCB0byB1c2UgYW4gaW50ZXJydXB0Cj4g
PiBmb3IgY2FsbGJhY2tzLgo+ID4gIAo+ID4+Cj4gPj4gIAo+ID4+ID4gPiAgCj4gPj4gPiA+ID4g
IAo+ID4+ID4gPiA+PiAtLS0KPiA+PiA+ID4gPj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
Y29tbW9uLmMgfCAxNCArKysrKysrKysrKysrKwo+ID4+ID4gPiA+PiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uaCB8ICAyICsrCj4gPj4gPiA+ID4+ICBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDEgKwo+ID4+ID4gPiA+PiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm4uYyB8ICAyICsrCj4gPj4gPiA+ID4+ICA0IGZpbGVzIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKykKPiA+PiA+ID4gPj4KPiA+PiA+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jCj4gPj4gPiA+ID4+IGluZGV4IGQ3MjRmNjc2NjA4Yi4uYjc4YzhiYzkzYTk3IDEw
MDY0NAo+ID4+ID4gPiA+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5j
Cj4gPj4gPiA+ID4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+
PiA+ID4gPj4gQEAgLTM3LDYgKzM3LDIwIEBAIHZvaWQgdnBfc3luY2hyb25pemVfdmVjdG9ycyhz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+PiA+ID4gPj4gICAgICAgICAgICAgICAgICBz
eW5jaHJvbml6ZV9pcnEocGNpX2lycV92ZWN0b3IodnBfZGV2LT5wY2lfZGV2LCBpKSk7Cj4gPj4g
PiA+ID4+ICB9Cj4gPj4gPiA+ID4+Cj4gPj4gPiA+ID4+ICt2b2lkIHZwX3N5bmNocm9uaXplX3Zx
cyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+PiA+ID4gPj4gK3sKPiA+PiA+ID4gPj4g
KyAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2Uo
dmRldik7Cj4gPj4gPiA+ID4+ICsgICAgICAgIGludCBpOwo+ID4+ID4gPiA+PiArCj4gPj4gPiA+
ID4+ICsgICAgICAgIGlmICh2cF9kZXYtPmludHhfZW5hYmxlZCkgewo+ID4+ID4gPiA+PiArICAg
ICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycSh2cF9kZXYtPnBjaV9kZXYtPmlycSk7Cj4gPj4g
PiA+ID4+ICsgICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4+ID4gPiA+PiArICAgICAgICB9Cj4g
Pj4gPiA+ID4+ICsKPiA+PiA+ID4gPj4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8IHZwX2Rldi0+
bXNpeF92ZWN0b3JzOyArK2kpCj4gPj4gPiA+ID4+ICsgICAgICAgICAgICAgICAgc3luY2hyb25p
emVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaSkpOwo+ID4+ID4gPiA+PiAr
fQo+ID4+ID4gPiA+PiArICAKPiA+PiA+ID4KPiA+PiA+ID4gLi4uZ2l2ZW4gdGhhdCB0aGlzIHNl
ZW1zIHRvIHN5bmNocm9uaXplIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVycz8KPiA+PiA+ID4g
SGFsaWwsIGRvIHlvdSB0aGluayBjY3cgbmVlZHMgdG8gZG8gYW55dGhpbmc/IChBRkFJQ1MsIHdl
IG9ubHkgaGF2ZSBvbmUKPiA+PiA+ID4gJ2lycScgZm9yIGNoYW5uZWwgZGV2aWNlcyBhbnl3YXks
IGFuZCB0aGUgaGFuZGxlciBqdXN0IGNhbGxzIHRoZQo+ID4+ID4gPiByZWxldmFudCBjYWxsYmFj
a3MgZGlyZWN0bHkuKSAgCj4gPj4gPgo+ID4+ID4gU29ycnkgSSBkb24ndCB1bmRlcnN0YW5kIGVu
b3VnaCB5ZXQuIEEgbW9yZSB2ZXJib3NlIGRvY3VtZW50YXRpb24gb24KPiA+PiA+ICJ2aXJ0aW9f
c3luY2hyb25pemVfdnFzIC0gc3luY2hyb25pemUgd2l0aCB2aXJ0cXVldWUgY2FsbGJhY2tzIiB3
b3VsZAo+ID4+ID4gc3VyZWx5IGJlbmVmaXQgbWUuIEl0IG1heSBiZSBtb3JlIHRoYW4gZW5vdWdo
IGZvciBhIGJhY2stYmVsdCBidXQgaXQKPiA+PiA+IGFpbid0IGVub3VnaCBmb3IgbWUgdG8gdGVs
bCB3aGF0IGlzIHRoZSBjYWxsYmFjayBzdXBwb3NlZCB0byBhY2NvbXBsaXNoLiAgCj4gCj4gKzEg
Zm9yIG1vcmUgZXhwbGFuYXRpb25zLgo+IAo+ID4+ID4KPiA+PiA+IEkgd2lsbCBoYXZlIHRvIHN0
dWR5IHRoaXMgZGlzY3Vzc2lvbiBhbmQgdGhlIGNvZGUgbW9yZSB0aG9yb3VnaGx5Lgo+ID4+ID4g
VGVudGF0aXZlbHkgSSBzaWRlIHdpdGggSmFzb24gYW5kIE1pY2hhZWwgaW4gYSBzZW5zZSwgdGhh
dCBJIGRvbid0Cj4gPj4gPiBiZWxpZXZlIHZpcnRpby1jY3cgaXMgc2FmZSBhZ2FpbnN0IHJvdWdo
IGludGVycnVwdHMuICAKPiA+Cj4gPiBUaGF0J3MgbXkgZmVlbGluZyBhcyB3ZWxsLiAgCj4gCj4g
SSdkIHNheSBjY3cgaXMgc2FmZSBhZ2FpbnN0ICJub3RpZmljYXRpb24gaW50ZXJydXB0cyBiZWZv
cmUgaW5kaWNhdG9ycwo+IGhhdmUgYmVlbiByZWdpc3RlcmVkIi4KCkkgYmVsaWV2ZSBKYXNvbidz
IHNjb3BlIGlzIGJyb2FkZXIgdGhhbiB0aGF0LiBMZXQgbWUgdHJ5IHRvIGV4cGxhaW4uIEEKcXVv
dGUgZm9ybSB0aGUgc3RhbmRhcmQ6CiIiIgozLjEuMSBEcml2ZXIgUmVxdWlyZW1lbnRzOiBEZXZp
Y2UgSW5pdGlhbGl6YXRpb24KVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRv
IGluaXRpYWxpemUgYSBkZXZpY2U6IAogICAgMS4gUmVzZXQgdGhlIGRldmljZS4gCiAgICAyLiBT
ZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0
aGUgZGV2aWNlLiAKICAgIDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBP
UyBrbm93cyBob3cgdG8gZHJpdmUgdGhlIGRldmljZS4gCiAgICA0LiBSZWFkIGRldmljZSBmZWF0
dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29k
IGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZSBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhl
IGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKSB0aGUgZGV2aWNlLXNwZWNpZmlj
IGNvbmZpZ3VyYXRpb24gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRl
dmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0LiAKICAgIDUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3Rh
dHVzIGJpdC4gVGhlIGRyaXZlciBNVVNUIE5PVCBhY2NlcHQgbmV3IGZlYXR1cmUgYml0cyBhZnRl
ciB0aGlzIHN0ZXAuIAogICAgNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUg
RkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDogb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMg
bm90IHN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVz
YWJsZS4gCiAgICA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRp
c2NvdmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNl
dHVwLCByZWFkaW5nIGFuZCBwb3NzaWJseSB3cml0aW5nIHRoZSBkZXZpY2XigJlzIHZpcnRpbyBj
b25maWd1cmF0aW9uIHNwYWNlLCBhbmQgcG9wdWxhdGlvbiBvZiB2aXJ0cXVldWVzLiAKICAgIDgu
IFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQgdGhlIGRldmljZSBp
cyDigJxsaXZl4oCdLgoiIiIKClRoYXQgbWVhbnMgc3R1ZmYgbWF5IGhhcHBlbiBiZXR3ZWVuICJk
aXNjb3Zlcnkgb2YgdmlydHF1ZXVlcyIgYW5kICJEUklWRVJfT0siLiBTbyBpdAppcyBub3Qgc3Vm
ZmljaWVudCB0byBiZSAic2FmZSBhZ2FpbnN0IG5vdGlmaWNhdGlvbnMgYmVmb3JlIGluZGljYXRv
cnMKaGF2ZSBiZWVuIHJlZ2lzdGVyZWQiLCBidXQgd2Ugd2FudCB0byBiZSBhbHNvIHNhZmUgYmV0
d2VlbiAiaW5kaWNhdG9ycyBoYXZlCmJlZW4gcmVnaXN0ZXJlZCIgYW5kICJEUklWRVJfT0sgc3Rh
dHVzIGhhcyBiZWVuIHNldCIuIAoKQEphc29uOiBjYW4geW91IGNvbmZpcm0/CgpSZWdhcmRpbmcg
dGhlIHF1ZXN0aW9uICJhcmUgd2Ugc2FmZSBhZ2FpbnN0IG5vdGlmaWNhdGlvbnMgYmVmb3JlCmlu
ZGljYXRvcnMgaGF2ZSBiZWVuIHJlZ2lzdGVyZWQiIEkgdGhpbmsgd2UgcmVhbGx5IG5lZWQgdG8g
dGhpbmsgYWJvdXQKc29tZXRoaW5nIGxpa2UgU2VjdXJlIEV4ZWN1dGlvbi4gV2UgZG9uJ3QgaGF2
ZSwgYW5kIHdlIGFyZSB1bmxpa2VseQp0byBoYXZlIGluIGhhcmR3YXJlIHZpcnRpby1jY3cgaW1w
bGVtZW50YXRpb25zLCBhbmQgZm9yIGEgbWFsaWNpb3VzIGh5cGVydmlzb3IKdGhhdCBoYXMgZnVs
bCBhY2Nlc3MgdG8gdGhlIGd1ZXN0IG1lbW9yeSBoYXJkZW5pbmcgbWFrZXMgbm8gc2Vuc2UuCgpC
dXQgaWYgd2UgYXNzdW1lIHRoYXQgYW4gYXR0YWNrZXIgY2FuIGluamVjdCBhZGFwdGVyIGludGVy
cnVwdHMgZm9yIGFuIGFyYml0cmFyeQpJU0MsIGFuZCBjYW4gcG9rZSBhbnkgc2hhcmVkIG1lbW9y
eSAobm90aWZpZXIgYml0cyBhcmUgc2hhcmVkKS4uLiBUaGluZ3MgbWlnaHQKYmVjb21lIGNyaXRp
Y2FsIGFscmVhZHkgd2hlbiByZWdpc3Rlcl9hZGFwdGVyX2ludGVycnVwdCgpIGRvZXMgaXQncyBt
YWdpYy4KCgo+IEZvciB0aGUgcmV2ZXJzZSBjYXNlLCBtYXliZSB3ZSBzaG91bGQgYWx3YXlzCj4g
aW52YWxpZGF0ZSB0aGUgaW5kaWNhdG9ycyBpbiB0aGUgcmVzZXQgY2FzZT8gTW9yZSBpbmZvcm1h
dGlvbiByZWdhcmRpbmcKPiB0aGUgYXR0YWNrIHZlY3RvciB3b3VsZCBoZWxwIGhlcmUgOikKPiAK
PiBNeSBtYWluIGNvbmNlcm4gaXMgdGhhdCB3ZSB3b3VsZCBuZWVkIHRvIHN5bmNocm9uaXplIGFn
YWluc3QgYSBzaW5nbGUKPiBpbnRlcnJ1cHQgdGhhdCBjb3ZlcnMgYWxsIGtpbmRzIG9mIEkvTyBp
bnRlcnJ1cHRzLCBub3QganVzdCBhIHNpbmdsZQo+IGRldmljZS4uLgo+IAoKQ291bGQgd2Ugc3lu
Y2hyb25pemUgb24gc3RydWN0IGFpcnFfaW5mbydzIGxvY2sgbWVtYmVyPyBJZiB3ZSB3ZXJlCnRv
IGdyYWIgYWxsIG9mIHRoZXNlIHRoYXQgbWlnaHQgYmUgaW52b2x2ZWQuLi4KCkFGQUlVIGZvciB0
aGUgc3luY2hyb25pemUgaW1wbGVtZW50YXRpb24gd2UgbmVlZCBhIGxvY2sgb3IgYSBzZXQgb2Yg
bG9ja3MKdGhhdCBjb250YWluIGFsbCB0aGUgcG9zc2libGUgdnJpbmdfaW50ZXJydXB0KCkgY2Fs
bHMgd2l0aCB0aGUgcXVldXVlcwp0aGF0IGJlbG9uZyB0byB0aGUgZ2l2ZW4gZGV2aWNlIGFzIGEg
Y3JpdGljYWwgc2VjdGlvbi4gVGhhdCB3YXksIG9uZQpoYXMgdGhlIGFjcXVpcmUncyBhbmQgcmVs
ZWFzZSdzIGluIHBsYWNlIHNvIHRoYXQgdGhlIHZyaWduX2ludGVycnVwdCgpCmVpdGhlciBndWFy
YW50ZWVkIHRvIGZpbmlzaCBiZWZvcmUgdGhlIGNoYW5nZSBvZiBkcml2ZXJfcmVhZHkgaXMKZ3Vh
cmFudGVlZCB0byBiZSBjb21wbGV0ZSwgb3IgaXQgaXMgZ3VhcmFudGVlZCB0byBzZWUgdGhlIGNo
YW5nZS4KCkluIGFueSBjYXNlLCBJIGd1ZXNzIHdlIHNob3VsZCBmaXJzdCBnZXQgY2xlYXIgb24g
dGhlIGZpcnN0IHBhcnQuIEkuZS4Kd2hlbiBkbyB3ZSB3YW50IHRvIGFsbG93IGhvc3QtPmd1ZXN0
IG5vdGlmaWNhdGlvbnMuCgpSZWdhcmRzLApIYWxpbAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
