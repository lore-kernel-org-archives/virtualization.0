Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7633FC4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 09:13:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39DF22C7D
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 09:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39DF22C7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42F2B8708D;
	Thu, 10 Dec 2020 09:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id anvz2qTaZcH0; Thu, 10 Dec 2020 09:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 944C287071;
	Thu, 10 Dec 2020 09:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78554C0FA7;
	Thu, 10 Dec 2020 09:12:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E5BC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 42DE08707A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WAuoGCnqGxly
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3BD6087071
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607591575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwZyk42Z1jA26ZNB0Ygx5Hz5zCov15S0EUsriUF2TEA=;
 b=dAFWocrr7d2G2l1vsMLpf36J2XOkeByL4GRm7V66ziWPbo2kgojnuXD2TxUPVQuz2h5XUm
 iRljeEurbREorD5Ff7Q8fjjH3icQjXJ07cRTuPHPvULlyYeNYGrK96XymNVlrqnCa73clq
 1rgVDWYvy5N4pTwt91/klCX3RHIFri4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-vGcsDXMlMQaNRaTayzAUXA-1; Thu, 10 Dec 2020 04:12:51 -0500
X-MC-Unique: vGcsDXMlMQaNRaTayzAUXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FA9B107ACE6;
 Thu, 10 Dec 2020 09:12:48 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2DD19746;
 Thu, 10 Dec 2020 09:12:30 +0000 (UTC)
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201208093715.GX203660@stefanha-x1.localdomain>
 <1410217602.34486578.1607506010536.JavaMail.zimbra@redhat.com>
 <20201209155729.GB396498@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <750d098a-20e1-983b-9085-5197776cde35@redhat.com>
Date: Thu, 10 Dec 2020 17:12:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209155729.GB396498@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Jim Harford <jim.harford@broadcom.com>,
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

Ck9uIDIwMjAvMTIvOSDkuIvljYgxMTo1NywgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+IE9uIFdl
ZCwgRGVjIDA5LCAyMDIwIGF0IDA0OjI2OjUwQU0gLTA1MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPj4+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0
IDA3OjUwOjM4UE0gKzAxMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+Pj4+IFRoaXMgc2VyaWVz
IGVuYWJsZSB2RFBBIHNvZnR3YXJlIGFzc2lzdGVkIGxpdmUgbWlncmF0aW9uIGZvciB2aG9zdC1u
ZXQKPj4+PiBkZXZpY2VzLiBUaGlzIGlzIGEgbmV3IG1ldGhvZCBvZiB2aG9zdCBkZXZpY2VzIG1p
Z3JhdGlvbjogSW5zdGVhZCBvZgo+Pj4+IHJlbGF5IG9uIHZEUEEgZGV2aWNlJ3MgZGlydHkgbG9n
Z2luZyBjYXBhYmlsaXR5LCBTVyBhc3Npc3RlZCBMTQo+Pj4+IGludGVyY2VwdHMgZGF0YXBsYW5l
LCBmb3J3YXJkaW5nIHRoZSBkZXNjcmlwdG9ycyBiZXR3ZWVuIFZNIGFuZCBkZXZpY2UuCj4+PiBQ
cm9zOgo+Pj4gKyB2aG9zdC92RFBBIGRldmljZXMgZG9uJ3QgbmVlZCB0byBpbXBsZW1lbnQgZGly
dHkgbWVtb3J5IGxvZ2dpbmcKPj4+ICsgT2Jzb2xldGVzIGlvY3RsKFZIT1NUX1NFVF9MT0dfQkFT
RSkgYW5kIGZyaWVuZHMKPj4+Cj4+PiBDb25zOgo+Pj4gLSBOb3QgZ2VuZXJpYywgcmVsaWVzIG9u
IHZob3N0LW5ldC1zcGVjaWZpYyBpb2N0bHMKPj4+IC0gRG9lc24ndCBzdXBwb3J0IFZJUlRJTyBT
aGFyZWQgTWVtb3J5IFJlZ2lvbnMKPj4+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3Mv
dmlydGlvLXNwZWMvYmxvYi9tYXN0ZXIvc2hhcmVkLW1lbS50ZXgKPj4gSSBtYXkgbWlzcyBzb21l
dGhpbmcgYnV0IG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpdCdzIHRoZQo+PiByZXNwb25zaWJs
aXR5IG9mIGRldmljZSB0byBtaWdyYXRlIHRoaXMgcGFydD8KPiBHb29kIHBvaW50LiBZb3UncmUg
cmlnaHQuCj4KPj4+IC0gUGVyZm9ybWFuY2UgKHNlZSBiZWxvdykKPj4+Cj4+PiBJIHRoaW5rIHBl
cmZvcm1hbmNlIHdpbGwgYmUgc2lnbmlmaWNhbnRseSBsb3dlciB3aGVuIHRoZSBzaGFkb3cgdnEg
aXMKPj4+IGVuYWJsZWQuIEltYWdpbmUgYSB2RFBBIGRldmljZSB3aXRoIGhhcmR3YXJlIHZxIGRv
b3JiZWxsIHJlZ2lzdGVycwo+Pj4gbWFwcGVkIGludG8gdGhlIGd1ZXN0IHNvIHRoZSBndWVzdCBk
cml2ZXIgY2FuIGRpcmVjdGx5IGtpY2sgdGhlIGRldmljZS4KPj4+IFdoZW4gdGhlIHNoYWRvdyB2
cSBpcyBlbmFibGVkIGEgdm1leGl0IGlzIG5lZWRlZCB0byB3cml0ZSB0byB0aGUgc2hhZG93Cj4+
PiB2cSBpb2V2ZW50ZmQsIHRoZW4gdGhlIGhvc3Qga2VybmVsIHNjaGVkdWxlciBzd2l0Y2hlcyB0
byBhIFFFTVUgdGhyZWFkCj4+PiB0byByZWFkIHRoZSBpb2V2ZW50ZmQsIHRoZSBkZXNjcmlwdG9y
cyBhcmUgdHJhbnNsYXRlZCwgUUVNVSB3cml0ZXMgdG8KPj4+IHRoZSB2aG9zdCBoZGV2IGtpY2sg
ZmQsIHRoZSBob3N0IGtlcm5lbCBzY2hlZHVsZXIgc3dpdGNoZXMgdG8gdGhlIHZob3N0Cj4+PiB3
b3JrZXIgdGhyZWFkLCB2aG9zdC92RFBBIG5vdGlmaWVzIHRoZSB2aXJ0cXVldWUsIGFuZCBmaW5h
bGx5IHRoZQo+Pj4gdkRQQSBkcml2ZXIgd3JpdGVzIHRvIHRoZSBoYXJkd2FyZSB2cSBkb29yYmVs
bCByZWdpc3Rlci4gVGhhdCBpcyBhIGxvdAo+Pj4gb2Ygb3ZlcmhlYWQgY29tcGFyZWQgdG8gd3Jp
dGluZyB0byBhbiBleGl0bGVzcyBNTUlPIHJlZ2lzdGVyIQo+PiBJIHRoaW5rIGl0J3MgYSBiYWxh
bmNlLiBFLmcgd2UgY2FuIHBvbGwgdGhlIHZpcnRxdWV1ZSB0byBoYXZlIGFuCj4+IGV4aXRsZXNz
IGRvb3JiZWxsLgo+Pgo+Pj4gSWYgdGhlIHNoYWRvdyB2cSB3YXMgaW1wbGVtZW50ZWQgaW4gZHJp
dmVycy92aG9zdC8gYW5kIFFFTVUgdXNlZCB0aGUKPj4+IGV4aXN0aW5nIGlvY3RsKFZIT1NUX1NF
VF9MT0dfQkFTRSkgYXBwcm9hY2gsIHRoZW4gdGhlIG92ZXJoZWFkIHdvdWxkIGJlCj4+PiByZWR1
Y2VkIHRvIGp1c3Qgb25lIHNldCBvZiBpb2V2ZW50ZmQvaXJxZmQuIEluIG90aGVyIHdvcmRzLCB0
aGUgUUVNVQo+Pj4gZGlydHkgbWVtb3J5IGxvZ2dpbmcgaGFwcGVucyBhc3luY2hyb25vdXNseSBh
bmQgaXNuJ3QgaW4gdGhlIGRhdGFwbGFuZS4KPj4+Cj4+PiBJbiBhZGRpdGlvbiwgaGFyZHdhcmUg
dGhhdCBzdXBwb3J0cyBkaXJ0eSBtZW1vcnkgbG9nZ2luZyBhcyB3ZWxsIGFzCj4+PiBzb2Z0d2Fy
ZSB2RFBBIGRldmljZXMgY291bGQgY29tcGxldGVseSBlbGltaW5hdGUgdGhlIHNoYWRvdyB2cSBm
b3IgZXZlbgo+Pj4gYmV0dGVyIHBlcmZvcm1hbmNlLgo+PiBZZXMuIFRoYXQncyBvdXIgcGxhbi4g
QnV0IHRoZSBpbnRlcmZhY2UgbWlnaHQgcmVxdWlyZSBtb3JlIHRob3VnaHQuCj4+Cj4+IEUuZyBp
cyB0aGUgYml0bWFwIGEgZ29vZCBhcHByb2FjaD8gVG8gbWUgcmVwb3J0aW5nIGRpcnR5IHBhZ2Vz
IHZpYQo+PiB2aXJxdWV1ZSBpcyBiZXR0ZXIgc2luY2UgaXQgZ2V0IGxlc3MgZm9vdHByaW50IGFu
ZCBpcyBzZWxmIHRocm90dGxlZC4KPj4KPj4gQW5kIHdlIG5lZWQgYW4gYWRkcmVzcyBzcGFjZSBv
dGhlciB0aGFuIHRoZSBvbmUgdXNlZCBieSBndWVzdCBmb3IKPj4gZWl0aGVyIGJpdG1hcCBmb3Ig
dmlydHF1ZXVlLgo+Pgo+Pj4gQnV0IHBlcmZvcm1hbmNlIGlzIGEgcXVlc3Rpb24gb2YgImlzIGl0
IGdvb2QgZW5vdWdoPyIuIE1heWJlIHRoaXMKPj4+IGFwcHJvYWNoIGlzIG9rYXkgYW5kIHVzZXJz
IGRvbid0IGV4cGVjdCBnb29kIHBlcmZvcm1hbmNlIHdoaWxlIGRpcnR5Cj4+PiBtZW1vcnkgbG9n
Z2luZyBpcyBlbmFibGVkLgo+PiBZZXMsIGFuZCBhY3R1YWxseSBzdWNoIHNsb3cgZG93biBtYXkg
aGVscCBmb3IgdGhlIGNvbnZlcmdlIG9mIHRoZQo+PiBtaWdyYXRpb24uCj4+Cj4+IE5vdGUgdGhh
dCB0aGUgd2hvbGUgaWRlYSBpcyB0cnkgdG8gaGF2ZSBhIGdlbmVyaWMgc29sdXRpb24gZm9yIGFs
bAo+PiB0eXBlcyBvZiBkZXZpY2VzLiBJdCdzIGdvb2QgdG8gY29uc2lkZXIgdGhlIHBlcmZvcm1h
bmNlIGJ1dCBmb3IgdGhlCj4+IGZpcnN0IHN0YWdlLCBpdCBzaG91bGQgYmUgc3VmZmljaWVudCB0
byBtYWtlIGl0IHdvcmsgYW5kIGNvbnNpZGVyIHRvCj4+IG9wdGltaXplIG9uIHRvcC4KPiBNb3Zp
bmcgdGhlIHNoYWRvdyB2cSB0byB0aGUga2VybmVsIGxhdGVyIHdvdWxkIGJlIHF1aXRlIGEgYmln
IGNoYW5nZQo+IHJlcXVpcmluZyByZXdyaXRpbmcgbXVjaCBvZiB0aGUgY29kZS4gVGhhdCdzIHdo
eSBJIG1lbnRpb25lZCB0aGlzIG5vdwo+IGJlZm9yZSBhIGxvdCBvZiBlZmZvcnQgaXMgaW52ZXN0
ZWQgaW4gYSBRRU1VIGltcGxlbWVudGF0aW9uLgoKClJpZ2h0LgoKCj4KPj4+IEkganVzdCB3YW50
ZWQgdG8gc2hhcmUgdGhlIGlkZWEgb2YgbW92aW5nIHRoZQo+Pj4gc2hhZG93IHZxIGludG8gdGhl
IGtlcm5lbCBpbiBjYXNlIHlvdSBsaWtlIHRoYXQgYXBwcm9hY2ggYmV0dGVyLgo+PiBNeSB1bmRl
cnN0YW5kaW5nIGlzIHRvIGtlZXAga2VybmVsIGFzIHNpbXBsZSBhcyBwb3NzaWJsZSBhbmQgbGVh
dmUgdGhlCj4+IHBvbGljZXMgdG8gdXNlcnNwYWNlIGFzIG11Y2ggYXMgcG9zc2libGUuIEUuZyBp
dCByZXF1aXJlcyB1cyB0bwo+PiBkaXNhYmxlIGRvb3JiZWxsIG1hcHBpbmcgYW5kIGlycSBvZmZs
b2FkaW5nLCBhbGwgb2Ygd2hpY2ggd2VyZSB1bmRlcgo+PiB0aGUgY29udHJvbCBvZiB1c2Vyc3Bh
Y2UuCj4gSWYgdGhlIHBlcmZvcm1hbmNlIGlzIGFjY2VwdGFibGUgd2l0aCB0aGUgUUVNVSBhcHBy
b2FjaCB0aGVuIEkgdGhpbmsKPiB0aGF0J3MgdGhlIGJlc3QgcGxhY2UgdG8gaW1wbGVtZW50IGl0
LiBJdCBsb29rcyBoaWdoLW92ZXJoZWFkIHRob3VnaCBzbwo+IG1heWJlIG9uZSBvZiB0aGUgZmly
c3QgdGhpbmdzIHRvIGRvIGlzIHRvIHJ1biBiZW5jaG1hcmtzIHRvIGNvbGxlY3QgZGF0YQo+IG9u
IGhvdyBpdCBwZXJmb3Jtcz8KCgpZZXMsIEkgYWdyZWUuCgpUaGFua3MKCgo+Cj4gU3RlZmFuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
