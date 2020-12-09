Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7838C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:27:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C21023B79
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21023B79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B47A786E34;
	Wed,  9 Dec 2020 09:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6PjpBz5S82ON; Wed,  9 Dec 2020 09:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4FD5F86E2D;
	Wed,  9 Dec 2020 09:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED33C0893;
	Wed,  9 Dec 2020 09:27:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A672FC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8C0D686D27
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HHM281CUZ3Wm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:27:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 92D0E86C43
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607506038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkbNrnwLg4MCQBfK6YxYOGZihNEG5026HVI+jw2DPYc=;
 b=JX4MHBuEbQh/7Y98SqMTipZ2X9rCcZJOsTgKOduTzk+FvGFrsZ7/OozxWMQCyW/Iq6eUMW
 UrQwv/0hxH7kfIAnuhMwq8YYinvE2rLINGRWmItUev+G1WYln+htqAbYRk88kHwwgcN5lJ
 JhzKqWDVQtNMG4A7NdRYvLWlzax80Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-_4IPs0VPO1es2zo-zKkK4w-1; Wed, 09 Dec 2020 04:27:13 -0500
X-MC-Unique: _4IPs0VPO1es2zo-zKkK4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50B981005504;
 Wed,  9 Dec 2020 09:27:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F71D18E59;
 Wed,  9 Dec 2020 09:27:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 852DF4BB7B;
 Wed,  9 Dec 2020 09:27:09 +0000 (UTC)
Date: Wed, 9 Dec 2020 04:26:50 -0500 (EST)
From: Jason Wang <jasowang@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <1410217602.34486578.1607506010536.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201208093715.GX203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201208093715.GX203660@stefanha-x1.localdomain>
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.18]
Thread-Topic: vDPA software assisted live migration
Thread-Index: UAk5pFR+aaXpJfnw1iW4417H+q8oRQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDA3
OjUwOjM4UE0gKzAxMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gVGhpcyBzZXJpZXMgZW5h
YmxlIHZEUEEgc29mdHdhcmUgYXNzaXN0ZWQgbGl2ZSBtaWdyYXRpb24gZm9yIHZob3N0LW5ldAo+
ID4gZGV2aWNlcy4gVGhpcyBpcyBhIG5ldyBtZXRob2Qgb2Ygdmhvc3QgZGV2aWNlcyBtaWdyYXRp
b246IEluc3RlYWQgb2YKPiA+IHJlbGF5IG9uIHZEUEEgZGV2aWNlJ3MgZGlydHkgbG9nZ2luZyBj
YXBhYmlsaXR5LCBTVyBhc3Npc3RlZCBMTQo+ID4gaW50ZXJjZXB0cyBkYXRhcGxhbmUsIGZvcndh
cmRpbmcgdGhlIGRlc2NyaXB0b3JzIGJldHdlZW4gVk0gYW5kIGRldmljZS4KPiAKPiBQcm9zOgo+
ICsgdmhvc3QvdkRQQSBkZXZpY2VzIGRvbid0IG5lZWQgdG8gaW1wbGVtZW50IGRpcnR5IG1lbW9y
eSBsb2dnaW5nCj4gKyBPYnNvbGV0ZXMgaW9jdGwoVkhPU1RfU0VUX0xPR19CQVNFKSBhbmQgZnJp
ZW5kcwo+IAo+IENvbnM6Cj4gLSBOb3QgZ2VuZXJpYywgcmVsaWVzIG9uIHZob3N0LW5ldC1zcGVj
aWZpYyBpb2N0bHMKPiAtIERvZXNuJ3Qgc3VwcG9ydCBWSVJUSU8gU2hhcmVkIE1lbW9yeSBSZWdp
b25zCj4gICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2Jsb2IvbWFz
dGVyL3NoYXJlZC1tZW0udGV4CgpJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgbXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IGl0J3MgdGhlCnJlc3BvbnNpYmxpdHkgb2YgZGV2aWNlIHRvIG1pZ3JhdGUg
dGhpcyBwYXJ0PwoKPiAtIFBlcmZvcm1hbmNlIChzZWUgYmVsb3cpCj4gCj4gSSB0aGluayBwZXJm
b3JtYW5jZSB3aWxsIGJlIHNpZ25pZmljYW50bHkgbG93ZXIgd2hlbiB0aGUgc2hhZG93IHZxIGlz
Cj4gZW5hYmxlZC4gSW1hZ2luZSBhIHZEUEEgZGV2aWNlIHdpdGggaGFyZHdhcmUgdnEgZG9vcmJl
bGwgcmVnaXN0ZXJzCj4gbWFwcGVkIGludG8gdGhlIGd1ZXN0IHNvIHRoZSBndWVzdCBkcml2ZXIg
Y2FuIGRpcmVjdGx5IGtpY2sgdGhlIGRldmljZS4KPiBXaGVuIHRoZSBzaGFkb3cgdnEgaXMgZW5h
YmxlZCBhIHZtZXhpdCBpcyBuZWVkZWQgdG8gd3JpdGUgdG8gdGhlIHNoYWRvdwo+IHZxIGlvZXZl
bnRmZCwgdGhlbiB0aGUgaG9zdCBrZXJuZWwgc2NoZWR1bGVyIHN3aXRjaGVzIHRvIGEgUUVNVSB0
aHJlYWQKPiB0byByZWFkIHRoZSBpb2V2ZW50ZmQsIHRoZSBkZXNjcmlwdG9ycyBhcmUgdHJhbnNs
YXRlZCwgUUVNVSB3cml0ZXMgdG8KPiB0aGUgdmhvc3QgaGRldiBraWNrIGZkLCB0aGUgaG9zdCBr
ZXJuZWwgc2NoZWR1bGVyIHN3aXRjaGVzIHRvIHRoZSB2aG9zdAo+IHdvcmtlciB0aHJlYWQsIHZo
b3N0L3ZEUEEgbm90aWZpZXMgdGhlIHZpcnRxdWV1ZSwgYW5kIGZpbmFsbHkgdGhlCj4gdkRQQSBk
cml2ZXIgd3JpdGVzIHRvIHRoZSBoYXJkd2FyZSB2cSBkb29yYmVsbCByZWdpc3Rlci4gVGhhdCBp
cyBhIGxvdAo+IG9mIG92ZXJoZWFkIGNvbXBhcmVkIHRvIHdyaXRpbmcgdG8gYW4gZXhpdGxlc3Mg
TU1JTyByZWdpc3RlciEKCkkgdGhpbmsgaXQncyBhIGJhbGFuY2UuIEUuZyB3ZSBjYW4gcG9sbCB0
aGUgdmlydHF1ZXVlIHRvIGhhdmUgYW4KZXhpdGxlc3MgZG9vcmJlbGwuCgo+IAo+IElmIHRoZSBz
aGFkb3cgdnEgd2FzIGltcGxlbWVudGVkIGluIGRyaXZlcnMvdmhvc3QvIGFuZCBRRU1VIHVzZWQg
dGhlCj4gZXhpc3RpbmcgaW9jdGwoVkhPU1RfU0VUX0xPR19CQVNFKSBhcHByb2FjaCwgdGhlbiB0
aGUgb3ZlcmhlYWQgd291bGQgYmUKPiByZWR1Y2VkIHRvIGp1c3Qgb25lIHNldCBvZiBpb2V2ZW50
ZmQvaXJxZmQuIEluIG90aGVyIHdvcmRzLCB0aGUgUUVNVQo+IGRpcnR5IG1lbW9yeSBsb2dnaW5n
IGhhcHBlbnMgYXN5bmNocm9ub3VzbHkgYW5kIGlzbid0IGluIHRoZSBkYXRhcGxhbmUuCj4gCj4g
SW4gYWRkaXRpb24sIGhhcmR3YXJlIHRoYXQgc3VwcG9ydHMgZGlydHkgbWVtb3J5IGxvZ2dpbmcg
YXMgd2VsbCBhcwo+IHNvZnR3YXJlIHZEUEEgZGV2aWNlcyBjb3VsZCBjb21wbGV0ZWx5IGVsaW1p
bmF0ZSB0aGUgc2hhZG93IHZxIGZvciBldmVuCj4gYmV0dGVyIHBlcmZvcm1hbmNlLgoKWWVzLiBU
aGF0J3Mgb3VyIHBsYW4uIEJ1dCB0aGUgaW50ZXJmYWNlIG1pZ2h0IHJlcXVpcmUgbW9yZSB0aG91
Z2h0LgoKRS5nIGlzIHRoZSBiaXRtYXAgYSBnb29kIGFwcHJvYWNoPyBUbyBtZSByZXBvcnRpbmcg
ZGlydHkgcGFnZXMgdmlhCnZpcnF1ZXVlIGlzIGJldHRlciBzaW5jZSBpdCBnZXQgbGVzcyBmb290
cHJpbnQgYW5kIGlzIHNlbGYgdGhyb3R0bGVkLgoKQW5kIHdlIG5lZWQgYW4gYWRkcmVzcyBzcGFj
ZSBvdGhlciB0aGFuIHRoZSBvbmUgdXNlZCBieSBndWVzdCBmb3IKZWl0aGVyIGJpdG1hcCBmb3Ig
dmlydHF1ZXVlLgoKPiAKPiBCdXQgcGVyZm9ybWFuY2UgaXMgYSBxdWVzdGlvbiBvZiAiaXMgaXQg
Z29vZCBlbm91Z2g/Ii4gTWF5YmUgdGhpcwo+IGFwcHJvYWNoIGlzIG9rYXkgYW5kIHVzZXJzIGRv
bid0IGV4cGVjdCBnb29kIHBlcmZvcm1hbmNlIHdoaWxlIGRpcnR5Cj4gbWVtb3J5IGxvZ2dpbmcg
aXMgZW5hYmxlZC4KClllcywgYW5kIGFjdHVhbGx5IHN1Y2ggc2xvdyBkb3duIG1heSBoZWxwIGZv
ciB0aGUgY29udmVyZ2Ugb2YgdGhlCm1pZ3JhdGlvbi4KCk5vdGUgdGhhdCB0aGUgd2hvbGUgaWRl
YSBpcyB0cnkgdG8gaGF2ZSBhIGdlbmVyaWMgc29sdXRpb24gZm9yIGFsbAp0eXBlcyBvZiBkZXZp
Y2VzLiBJdCdzIGdvb2QgdG8gY29uc2lkZXIgdGhlIHBlcmZvcm1hbmNlIGJ1dCBmb3IgdGhlCmZp
cnN0IHN0YWdlLCBpdCBzaG91bGQgYmUgc3VmZmljaWVudCB0byBtYWtlIGl0IHdvcmsgYW5kIGNv
bnNpZGVyIHRvCm9wdGltaXplIG9uIHRvcC4KCj4gSSBqdXN0IHdhbnRlZCB0byBzaGFyZSB0aGUg
aWRlYSBvZiBtb3ZpbmcgdGhlCj4gc2hhZG93IHZxIGludG8gdGhlIGtlcm5lbCBpbiBjYXNlIHlv
dSBsaWtlIHRoYXQgYXBwcm9hY2ggYmV0dGVyLgoKTXkgdW5kZXJzdGFuZGluZyBpcyB0byBrZWVw
IGtlcm5lbCBhcyBzaW1wbGUgYXMgcG9zc2libGUgYW5kIGxlYXZlIHRoZQpwb2xpY2VzIHRvIHVz
ZXJzcGFjZSBhcyBtdWNoIGFzIHBvc3NpYmxlLiBFLmcgaXQgcmVxdWlyZXMgdXMgdG8KZGlzYWJs
ZSBkb29yYmVsbCBtYXBwaW5nIGFuZCBpcnEgb2ZmbG9hZGluZywgYWxsIG9mIHdoaWNoIHdlcmUg
dW5kZXIKdGhlIGNvbnRyb2wgb2YgdXNlcnNwYWNlLgoKVGhhbmtzCgo+IAo+IFN0ZWZhbgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
