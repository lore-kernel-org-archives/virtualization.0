Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702BC56201
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 03:07:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9AF21534
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 03:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMyM6fut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9AF21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D69B87128;
	Thu, 26 Nov 2020 03:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6UDw99AMgUUO; Thu, 26 Nov 2020 03:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7772F870B3;
	Thu, 26 Nov 2020 03:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45A8AC0891;
	Thu, 26 Nov 2020 03:07:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB886C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 03:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 920A9870BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 03:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1Yd2r7uMr4B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 03:07:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0D2A1870B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 03:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606360055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yXE0MDOyVD7WAE8aijm9XJiMRGRHSOjfmxlipWrPcs=;
 b=MMyM6futOer8PZU1EPuHpSHLdLoqULq4+03J3dtz/yEpRYG7UdSKCxROvenspMr2Zl4Tnm
 xcrJhkPYu6YJFnWlFk9cmM/tMVEPVpKAXzsulPzH7LWLhyynF8mfsK/DnPeNwtErc89SJF
 P9pJc0z9EZ3V5gXZCg8RPCpgW86fsLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-GQ81NE11OqyvxM1ZNrQQ8w-1; Wed, 25 Nov 2020 22:07:32 -0500
X-MC-Unique: GQ81NE11OqyvxM1ZNrQQ8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4781005E46;
 Thu, 26 Nov 2020 03:07:29 +0000 (UTC)
Received: from [10.72.13.213] (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B62E10023AF;
 Thu, 26 Nov 2020 03:07:04 +0000 (UTC)
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <5a4d0b7a-fb62-9e78-9e85-9262dca57f1c@redhat.com>
 <CAJaqyWf+6yoMHJuLv=QGLMP4egmdm722=V2kKJ_aiQAfCCQOFw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9edb2df1-dec0-8aad-4fdd-93c3b3be9ff6@redhat.com>
Date: Thu, 26 Nov 2020 11:07:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf+6yoMHJuLv=QGLMP4egmdm722=V2kKJ_aiQAfCCQOFw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Alex Barba <alex.barba@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Jim Harford <jim.harford@broadcom.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stephen Finucane <stephenfin@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTEvMjUg5LiL5Y2IODowMywgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4g
T24gV2VkLCBOb3YgMjUsIDIwMjAgYXQgODowOSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4gT24gMjAyMC8xMS8yMSDkuIrljYgyOjUwLCBFdWdlbmlvIFDD
qXJleiB3cm90ZToKPj4+IFRoaXMgc2VyaWVzIGVuYWJsZSB2RFBBIHNvZnR3YXJlIGFzc2lzdGVk
IGxpdmUgbWlncmF0aW9uIGZvciB2aG9zdC1uZXQKPj4+IGRldmljZXMuIFRoaXMgaXMgYSBuZXcg
bWV0aG9kIG9mIHZob3N0IGRldmljZXMgbWlncmF0aW9uOiBJbnN0ZWFkIG9mCj4+PiByZWxheSBv
biB2RFBBIGRldmljZSdzIGRpcnR5IGxvZ2dpbmcgY2FwYWJpbGl0eSwgU1cgYXNzaXN0ZWQgTE0K
Pj4+IGludGVyY2VwdHMgZGF0YXBsYW5lLCBmb3J3YXJkaW5nIHRoZSBkZXNjcmlwdG9ycyBiZXR3
ZWVuIFZNIGFuZCBkZXZpY2UuCj4+Pgo+Pj4gSW4gdGhpcyBtaWdyYXRpb24gbW9kZSwgcWVtdSBv
ZmZlcnMgYSBuZXcgdnJpbmcgdG8gdGhlIGRldmljZSB0bwo+Pj4gcmVhZCBhbmQgd3JpdGUgaW50
bywgYW5kIGRpc2FibGUgdmhvc3Qgbm90aWZpZXJzLCBwcm9jZXNzaW5nIGd1ZXN0IGFuZAo+Pj4g
dmhvc3Qgbm90aWZpY2F0aW9ucyBpbiBxZW11LiBPbiB1c2VkIGJ1ZmZlciByZWxheSwgcWVtdSB3
aWxsIG1hcmsgdGhlCj4+PiBkaXJ0eSBtZW1vcnkgYXMgd2l0aCBwbGFpbiB2aXJ0aW8tbmV0IGRl
dmljZXMuIFRoaXMgd2F5LCBkZXZpY2VzIGRvZXMKPj4+IG5vdCBuZWVkIHRvIGhhdmUgZGlydHkg
cGFnZSBsb2dnaW5nIGNhcGFiaWxpdHkuCj4+Pgo+Pj4gVGhpcyBzZXJpZXMgaXMgYSBQT0MgZG9p
bmcgU1cgTE0gZm9yIHZob3N0LW5ldCBkZXZpY2VzLCB3aGljaCBhbHJlYWR5Cj4+PiBoYXZlIGRp
cnR5IHBhZ2UgbG9nZ2luZyBjYXBhYmlsaXRpZXMuIE5vbmUgb2YgdGhlIGNoYW5nZXMgaGF2ZSBh
Y3R1YWwKPj4+IGVmZmVjdCB3aXRoIGN1cnJlbnQgZGV2aWNlcyB1bnRpbCBsYXN0IHR3byBwYXRj
aGVzICgyNiBhbmQgMjcpIGFyZQo+Pj4gYXBwbGllZCwgYnV0IHRoZXkgY2FuIGJlIHJlYmFzZWQg
b24gdG9wIG9mIGFueSBvdGhlci4gVGhlc2UgY2hlY2tzIHRoZQo+Pj4gZGV2aWNlIHRvIG1lZXQg
YWxsIHJlcXVpcmVtZW50cywgYW5kIGRpc2FibGUgdmhvc3QtbmV0IGRldmljZXMgbG9nZ2luZwo+
Pj4gc28gbWlncmF0aW9uIGdvZXMgdGhyb3VnaCBTVyBMTS4gVGhpcyBsYXN0IHBhdGNoIGlzIG5v
dCBtZWFudCB0byBiZQo+Pj4gYXBwbGllZCBpbiB0aGUgZmluYWwgcmV2aXNpb24sIGl0IGlzIGlu
IHRoZSBzZXJpZXMganVzdCBmb3IgdGVzdGluZwo+Pj4gcHVycG9zZXMuCj4+Pgo+Pj4gRm9yIHVz
ZSBTVyBhc3Npc3RlZCBMTSB0aGVzZSB2aG9zdC1uZXQgZGV2aWNlcyBuZWVkIHRvIGJlIGluc3Rh
bnRpYXRlZDoKPj4+ICogV2l0aCBJT01NVSAoaW9tbXVfcGxhdGZvcm09b24sYXRzPW9uKQo+Pj4g
KiBXaXRob3V0IGV2ZW50X2lkeCAoZXZlbnRfaWR4PW9mZikKPj4KPj4gU28gYSBxdWVzdGlvbiBp
cyBhdCB3aGF0IGxldmVsIGRvIHdlIHdhbnQgdG8gaW1wbGVtZW50IHFlbXUgYXNzaXN0ZWQKPj4g
bGl2ZSBtaWdyYXRpb24uIFRvIG1lIGl0IGNvdWxkIGJlIGRvbmUgYXQgdHdvIGxldmVsczoKPj4K
Pj4gMSkgZ2VuZXJpYyB2aG9zdCBsZXZlbCB3aGljaCBtYWtlcyBpdCB3b3JrIGZvciBib3RoIHZo
b3N0LW5ldC92aG9zdC11c2VyCj4+IGFuZCB2aG9zdC12RFBBCj4+IDIpIGEgc3BlY2lmaWMgdHlw
ZSBvZiB2aG9zdAo+Pgo+PiBUbyBtZSwgaGF2aW5nIGEgZ2VuZXJpYyBvbmUgbG9va3MgYmV0dGVy
IGJ1dCBpdCB3b3VsZCBiZSBtdWNoIG1vcmUKPj4gY29tcGxpY2F0ZWQuIFNvIHdoYXQgSSByZWFk
IGZyb20gdGhpcyBzZXJpZXMgaXMgaXQgd2FzIGEgdmhvc3Qga2VybmVsCj4+IHNwZWNpZmljIHNv
ZnR3YXJlIGFzc2lzdGVkIGxpdmUgbWlncmF0aW9uIHdoaWNoIGlzIGEgZ29vZCBzdGFydC4KPj4g
QWN0dWFsbHkgaXQgbWF5IGV2ZW4gaGF2ZSByZWFsIHVzZSBjYXNlLCBlLmcgaXQgY2FuIHNhdmUg
ZGlydHkgYml0bWFwcwo+PiBmb3IgZ3Vlc3Qgd2l0aCBsYXJnZSBtZW1vcnkuIEJ1dCB3ZSBuZWVk
IHRvIGFkZHJlc3MgdGhlIGFib3ZlCj4+IGxpbWl0YXRpb25zIGZpcnN0Lgo+Pgo+PiBTbyBJIHdv
dWxkIGxpa2UgdG8ga25vdyB3aGF0J3MgdGhlIHJlYXNvbiBmb3IgbWFuZGF0aW5nIGlvbW11IHBs
YXRmb3JtCj4+IGFuZCBhdHM/IEFuZCBJIHRoaW5rIHdlIG5lZWQgdG8gZml4IGNhc2Ugb2YgZXZl
bnQgaWR4IHN1cHBvcnQuCj4+Cj4gVGhlcmUgaXMgbm8gc3BlY2lmaWMgcmVhc29uIGZvciBtYW5k
YXRpbmcgaW9tbXUgJiBhdHMsIGl0IHdhcyBqdXN0Cj4gc3RhcnRlZCB0aGF0IHdheS4KPgo+IEkg
d2lsbCBleHRlbmQgdGhlIHBhdGNoIHRvIHN1cHBvcnQgdGhvc2UgY2FzZXMgdG9vLgo+Cj4+PiBK
dXN0IHRoZSBub3RpZmljYXRpb24gZm9yd2FyZGluZyAod2l0aCBubyBkZXNjcmlwdG9yIHJlbGF5
KSBjYW4gYmUKPj4+IGFjaGlldmVkIHdpdGggcGF0Y2hlcyA3IGFuZCA5LCBhbmQgc3RhcnRpbmcg
bWlncmF0aW9uLiBQYXJ0aWFsIGFwcGxpZXMKPj4+IGJldHdlZW4gMTMgYW5kIDI0IHdpbGwgbm90
IHdvcmsgd2hpbGUgbWlncmF0aW5nIG9uIHNvdXJjZSwgYW5kIHBhdGNoCj4+PiAyNSBpcyBuZWVk
ZWQgZm9yIHRoZSBkZXN0aW5hdGlvbiB0byByZXN1bWUgbmV0d29yayBhY3Rpdml0eS4KPj4+Cj4+
PiBJdCBpcyBiYXNlZCBvbiB0aGUgaWRlYXMgb2YgRFBESyBTVyBhc3Npc3RlZCBMTSwgaW4gdGhl
IHNlcmllcyBvZgo+Pgo+PiBBY3R1YWxseSB3ZSdyZSBiZXR0ZXIgdGhhbiB0aGF0IHNpbmNlIHRo
ZXJlJ3Mgbm8gbmVlZCB0aGUgdHJpY2sgbGlrZQo+PiBoYXJkY29kZWQgSU9WQSBmb3IgbWVkaWF0
ZWQoc2hhZG93KSB2aXJ0cXVldWUuCj4+Cj4+Cj4+PiBEUERLJ3MgaHR0cHM6Ly9wYXRjaHdvcmsu
ZHBkay5vcmcvY292ZXIvNDgzNzAvIC4KPj4KPj4gSSBub3RpY2UgdGhhdCB5b3UgZG8gR1BBLT5W
QSB0cmFuc2xhdGlvbnMgYW5kIHRyeSB0byBlc3RhYmxpc2ggYSBWQS0+VkEKPj4gKHVzZSBWQSBh
cyBJT1ZBKSBtYXBwaW5nIHZpYSBkZXZpY2UgSU9UTEIuIFRoaXMgc2hvcnRjdXQgc2hvdWxkIHdv
cmsgZm9yCj4+IHZob3N0LWtlcm5lbC91c2VyIGJ1dCBub3Qgdmhvc3QtdkRQQS4gVGhlIHJlYXNv
biBpcyB0aGF0IHRoZXJlJ3Mgbm8KPj4gZ3VhcmFudGVlIHRoYXQgdGhlIHdob2xlIDY0Yml0IGFk
ZHJlc3MgcmFuZ2UgY291bGQgYmUgdXNlZCBhcyBJT1ZBLiBPbmUKPj4gZXhhbXBsZSBpcyB0aGF0
IGZvciBoYXJkd2FyZSBJT01NVSBsaWtlIGludGVsLCBpdCB1c3VhbGx5IGhhcyA0NyBvciA1Mgo+
PiBiaXRzIG9mIGFkZHJlc3Mgd2lkdGguCj4+Cj4+IFNvIHdlIHByb2JhYmx5IG5lZWQgYW4gSU9W
QSBhbGxvY2F0b3IgdGhhdCBjYW4gbWFrZSBzdXJlIHRoZSBJT1ZBIGlzIG5vdAo+PiBvdmVybGFw
cGVkIGFuZCBmaXQgZm9yIFsxXS4gV2UgY2FuIHByb2JhYmx5IGJ1aWxkIHRoZSBJT1ZBIGZvciBn
dWVzdCBWQQo+PiB2aWEgbWVtb3J5IGxpc3RlbmVycy4gVGhlbiB3ZSBoYXZlCj4+Cj4+IDEpIElP
VkEgZm9yIEdQQQo+PiAyKSBJT1ZBIGZvciBzaGFkb3cgVlEKPj4KPj4gQW5kIGFkdmVydGlzZSBJ
T1ZBIHRvIFZBIG1hcHBpbmcgdG8gdmhvc3QuCj4+Cj4+IFsxXQo+PiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD0xYjQ4ZGMwM2U1NzVhODcyNDA0ZjMzYjA0Y2QyMzc5NTNjNWQ3NDk4Cj4+Cj4gR290IGl0
LCB3aWxsIGNvbnRyb2wgaXQgdG9vLgo+Cj4gTWF5YmUgZm9yIHZob3N0LW5ldCB3ZSBjb3VsZCBk
aXJlY3RseSBzZW5kIGlvdGxiIG1pc3MgZm9yIFswLH4wVUxMXS4KCgpJdCB3b3JrcyBidXQgaXQg
bWVhbnMgdmhvc3QtbmV0IG5lZWRzIHNvbWUgc3BlY2lhbCBjYXJlLiBUbyBtZSBhIGdlbmVyaWMg
CklPVkEgYWxsb2NhdG9yIGxvb2tzIGJldHRlci4KCgo+Cj4+PiBDb21tZW50cyBhcmUgd2VsY29t
ZS4KPj4+Cj4+PiBUaGFua3MhCj4+Pgo+Pj4gRXVnZW5pbyBQw6lyZXogKDI3KToKPj4+ICAgICB2
aG9zdDogQWRkIHZob3N0X2Rldl9jYW5fbG9nCj4+PiAgICAgdmhvc3Q6IEFkZCBkZXZpY2UgY2Fs
bGJhY2sgaW4gdmhvc3RfbWlncmF0aW9uX2xvZwo+Pj4gICAgIHZob3N0OiBNb3ZlIGxvZyByZXNp
emUvcHV0IHRvIHZob3N0X2Rldl9zZXRfbG9nCj4+PiAgICAgdmhvc3Q6IGFkZCB2aG9zdF9rZXJu
ZWxfc2V0X3ZyaW5nX2VuYWJsZQo+Pj4gICAgIHZob3N0OiBBZGQgaGRldi0+ZGV2LnN3X2xtX3Zx
X2hhbmRsZXIKPj4+ICAgICB2aXJ0aW86IEFkZCB2aXJ0aW9fcXVldWVfZ2V0X3VzZWRfbm90aWZ5
X3NwbGl0Cj4+PiAgICAgdmhvc3Q6IFJvdXRlIGd1ZXN0LT5ob3N0IG5vdGlmaWNhdGlvbiB0aHJv
dWdoIHFlbXUKPj4+ICAgICB2aG9zdDogQWRkIGEgZmxhZyBmb3Igc29mdHdhcmUgYXNzaXN0ZWQg
TGl2ZSBNaWdyYXRpb24KPj4+ICAgICB2aG9zdDogUm91dGUgaG9zdC0+Z3Vlc3Qgbm90aWZpY2F0
aW9uIHRocm91Z2ggcWVtdQo+Pj4gICAgIHZob3N0OiBBbGxvY2F0ZSBzaGFkb3cgdnJpbmcKPj4+
ICAgICB2aXJ0aW86IGNvbnN0LWlmeSBhbGwgdmlydGlvX3Rzd2FwKiBmdW5jdGlvbnMKPj4+ICAg
ICB2aXJ0aW86IEFkZCB2aXJ0aW9fcXVldWVfZnVsbAo+Pj4gICAgIHZob3N0OiBTZW5kIGJ1ZmZl
cnMgdG8gZGV2aWNlCj4+PiAgICAgdmlydGlvOiBSZW1vdmUgdmlydGlvX3F1ZXVlX2dldF91c2Vk
X25vdGlmeV9zcGxpdAo+Pj4gICAgIHZob3N0OiBEbyBub3QgaW52YWxpZGF0ZSBzaWduYWxsZWQg
dXNlZAo+Pj4gICAgIHZpcnRpbzogRXhwb3NlIHZpcnRxdWV1ZV9hbGxvY19lbGVtZW50Cj4+PiAg
ICAgdmhvc3Q6IGFkZCB2aG9zdF92cmluZ19zZXRfbm90aWZpY2F0aW9uX3JjdQo+Pj4gICAgIHZo
b3N0OiBhZGQgdmhvc3RfdnJpbmdfcG9sbF9yY3UKPj4+ICAgICB2aG9zdDogYWRkIHZob3N0X3Zy
aW5nX2dldF9idWZfcmN1Cj4+PiAgICAgdmhvc3Q6IFJldHVybiB1c2VkIGJ1ZmZlcnMKPj4+ICAg
ICB2aG9zdDogQWRkIHZob3N0X3ZpcnRxdWV1ZV9tZW1vcnlfdW5tYXAKPj4+ICAgICB2aG9zdDog
QWRkIHZob3N0X3ZpcnRxdWV1ZV9tZW1vcnlfbWFwCj4+PiAgICAgdmhvc3Q6IHVubWFwIHFlbXUn
cyBzaGFkb3cgdmlydHF1ZXVlcyBvbiBzdyBsaXZlIG1pZ3JhdGlvbgo+Pj4gICAgIHZob3N0OiBp
b21tdSBjaGFuZ2VzCj4+PiAgICAgdmhvc3Q6IERvIG5vdCBjb21taXQgdmhvc3QgdXNlZCBpZHgg
b24gdmhvc3RfdmlydHF1ZXVlX3N0b3AKPj4+ICAgICB2aG9zdDogQWRkIHZob3N0X2hkZXZfY2Fu
X3N3X2xtCj4+PiAgICAgdmhvc3Q6IGZvcmJpZCB2aG9zdCBkZXZpY2VzIGxvZ2dpbmcKPj4+Cj4+
PiAgICBody92aXJ0aW8vdmhvc3Qtc3ctbG0tcmluZy5oICAgICAgfCAgMzkgKysrCj4+PiAgICBp
bmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oICAgICAgICAgfCAgIDUgKwo+Pj4gICAgaW5jbHVkZS9o
dy92aXJ0aW8vdmlydGlvLWFjY2Vzcy5oIHwgICA4ICstCj4+PiAgICBpbmNsdWRlL2h3L3ZpcnRp
by92aXJ0aW8uaCAgICAgICAgfCAgIDQgKwo+Pj4gICAgaHcvbmV0L3ZpcnRpby1uZXQuYyAgICAg
ICAgICAgICAgIHwgIDM5ICsrLQo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuYyAgICAg
ICAgIHwgIDI5ICsrCj4+PiAgICBody92aXJ0aW8vdmhvc3Qtc3ctbG0tcmluZy5jICAgICAgfCAy
NjggKysrKysrKysrKysrKysrKysrKwo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LmMgICAgICAgICAg
ICAgICAgIHwgNDMxICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+Pj4gICAgaHcvdmly
dGlvL3ZpcnRpby5jICAgICAgICAgICAgICAgIHwgIDE4ICstCj4+PiAgICBody92aXJ0aW8vbWVz
b24uYnVpbGQgICAgICAgICAgICAgfCAgIDIgKy0KPj4+ICAgIDEwIGZpbGVzIGNoYW5nZWQsIDc1
OCBpbnNlcnRpb25zKCspLCA4NSBkZWxldGlvbnMoLSkKPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody92aXJ0aW8vdmhvc3Qtc3ctbG0tcmluZy5oCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvdmlydGlvL3Zob3N0LXN3LWxtLXJpbmcuYwo+Pgo+PiBTbyB0aGlzIGxvb2tzIGxpa2UgYSBw
cmV0dHkgaHVnZSBwYXRjaHNldCB3aGljaCBJJ20gdHJ5aW5nIHRvIHRoaW5rIG9mCj4+IHdheXMg
dG8gc3BsaXQuIEFuIGlkZWEgaXMgdG8gZG8gdGhpcyBpcyB0d28gc3RlcHMKPj4KPj4gMSkgaW1w
bGVtZW50IGEgc2hhZG93IHZpcnRxdWV1ZSBtb2RlIGZvciB2aG9zdCBmaXJzdCAody9vIGxpdmUK
Pj4gbWlncmF0aW9uKS4gVGhlbiB3ZSBjYW4gdGVzdCBkZXNjcmlwdG9ycyByZWxheSwgSU9WQSBh
bGxvY2F0aW5nLCBldGMuCj4gSG93IHdvdWxkIHRoYXQgbW9kZSBiZSBhY3RpdmF0ZWQgaWYgaXQg
aXMgbm90IHRpZWQgdG8gbGl2ZSBtaWdyYXRpb24/Cj4gTmV3IGJhY2tlbmQvY29tbWFuZCBsaW5l
IHN3aXRjaD8KCgpFaXRoZXIgYSBuZXcgY2xpIG9wdGlvbiBvciBldmVuIGEgcW1wIGNvbW1hbmQg
Y2FuIHdvcmsuCgoKPgo+IE1heWJlIGl0IGlzIGJldHRlciB0byBhbHNvIHN0YXJ0IHdpdGggbm8g
aW9tbXUgJiBhdHMgc3VwcG9ydCBhbmQgYWRkIGl0IG9uIHRvcC4KCgpZZXMuCgoKPgo+PiAyKSBh
ZGQgbGl2ZSBtaWdyYXRpb24gc3VwcG9ydCBvbiB0b3AKPj4KPj4gQW5kIGl0IGxvb2tzIHRvIG1l
IGl0J3MgYmV0dGVyIHRvIHNwbGl0IHRoZSBzaGFkb3cgdmlydHF1ZXVlICh2aXJ0aW8KPj4gZHJp
dmVyIHBhcnQpIGludG8gYW4gaW5kZXBlbmRlbnQgZmlsZS4gQW5kIHVzZSBnZW5lcmljIG5hbWUg
KHcvbwo+PiAic2hhZG93IikgaW4gb3JkZXIgdG8gYmUgcmV1c2VkIGJ5IG90aGVyIHVzZSBjYXNl
cyBhcyB3ZWxsLgo+Pgo+IEkgdGhpbmsgdGhlIHNhbWUuCj4KPiBUaGFua3MhCj4KPj4gVGhvdWdo
dHM/Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
