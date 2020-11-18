Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C5C5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 07:55:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C92080A
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 07:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM/+LOXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 72F91204EF;
	Wed, 18 Nov 2020 07:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z2cktsjGjZsg; Wed, 18 Nov 2020 07:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01A3D204BD;
	Wed, 18 Nov 2020 07:55:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB2DC0891;
	Wed, 18 Nov 2020 07:55:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6065DC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 07:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3993F204C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 07:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hIhz7zlk5C4Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 07:55:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4D00A204BD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605686103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwlkB059N2EU+7oiHQ3QutUUUHuAlq8BMtOzJYPkSzI=;
 b=WM/+LOXvLs9zlhv8kg8y9+hYhyCkCD5QYX3GIdSneGG2gSv+tXU7b3SRABFuvzay2yBX2B
 c60dIdoL9l/X/hRz9kROTKNxGXSdr4yvi9qzi8LIBVDzpz4/MjdqXnWfZLgxNVmGnFH1Zb
 Vg/2tzxq/8ZfTHI/ewZymnf8roGVeug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-HKjnb5yfMLCNsH46CJMMxw-1; Wed, 18 Nov 2020 02:55:00 -0500
X-MC-Unique: HKjnb5yfMLCNsH46CJMMxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A8421018720;
 Wed, 18 Nov 2020 07:54:59 +0000 (UTC)
Received: from [10.72.13.172] (ovpn-13-172.pek2.redhat.com [10.72.13.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 657C810013C4;
 Wed, 18 Nov 2020 07:54:50 +0000 (UTC)
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
To: Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <bba47572-bec9-794f-5a70-d7f016267022@redhat.com>
 <8318de9f-c585-39f8-d931-1ff5e0341d75@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e3f8f065-ca17-e4a0-06e5-990bbe8fe947@redhat.com>
Date: Wed, 18 Nov 2020 15:54:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8318de9f-c585-39f8-d931-1ff5e0341d75@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, mst@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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

Ck9uIDIwMjAvMTEvMTgg5LiL5Y2IMjo1NywgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBPbiAxMS8x
Ny8yMCAxMToxNyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAyMC8xMS8xOCDkuIrljYgx
Mjo0MCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+Pj4gT24gVGh1LCBOb3YgMTIsIDIwMjAgYXQg
MDU6MTg6NTlQTSAtMDYwMCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPj4+PiBUaGUgZm9sbG93aW5n
IGtlcm5lbCBwYXRjaGVzIHdlcmUgbWFkZSBvdmVyIE1pY2hhZWwncyB2aG9zdCBicmFuY2g6Cj4+
Pj4KPj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN0L3Zob3N0LmdpdC9sb2cvP2g9dmhvc3RfXzsh
IUdxaXZQVmE3QnJpbyFNekN2M3dkUmZ6NWRsdHVuYXpSV0dDZVVrTWc5MXBQRU9McElpdnNlYkxY
OXZoWURTaV9FMVYzNmU5SDBOb1J5c19oVSQKPj4+PiBhbmQgdGhlIHZob3N0LXNjc2kgYnVnIGZp
eCBwYXRjaHNldDoKPj4+Pgo+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1zY3NpLzIwMjAxMTEyMTcwMDA4LkdCMTU1NTY1M0BzdGVm
YW5oYS14MS5sb2NhbGRvbWFpbi9ULyp0X187SXchIUdxaXZQVmE3QnJpbyFNekN2M3dkUmZ6NWRs
dHVuYXpSV0dDZVVrTWc5MXBQRU9McElpdnNlYkxYOXZoWURTaV9FMVYzNmU5SDBObXVQRV9tOCQK
Pj4+PiBBbmQgdGhlIHFlbXUgcGF0Y2ggd2FzIG1hZGUgb3ZlciB0aGUgcWVtdSBtYXN0ZXIgYnJh
bmNoLgo+Pj4+Cj4+Pj4gdmhvc3Qtc2NzaSBjdXJyZW50bHkgc3VwcG9ydHMgbXVsdGlwbGUgcXVl
dWVzIHdpdGggdGhlIG51bV9xdWV1ZXMKPj4+PiBzZXR0aW5nLCBidXQgd2UgZW5kIHVwIHdpdGgg
YSBzZXR1cCB3aGVyZSB0aGUgZ3Vlc3QncyBzY3NpL2Jsb2NrCj4+Pj4gbGF5ZXIgY2FuIGRvIGEg
cXVldWUgcGVyIHZDUFUgYW5kIHRoZSBsYXllcnMgYmVsb3cgdmhvc3QgY2FuIGRvCj4+Pj4gYSBx
dWV1ZSBwZXIgQ1BVLiB2aG9zdC1zY3NpIHdpbGwgdGhlbiBkbyBhIG51bV9xdWV1ZSB2aXJ0cXVl
dWVzLAo+Pj4+IGJ1dCBhbGwgSU8gZ2V0cyBzZXQgb24gYW5kIGNvbXBsZXRlZCBvbiBhIHNpbmds
ZSB2aG9zdC1zY3NpIHRocmVhZC4KPj4+PiBBZnRlciAyIC0gNCB2cXMgdGhpcyBiZWNvbWVzIGEg
Ym90dGxlbmVjay4KPj4+Pgo+Pj4+IFRoaXMgcGF0Y2hzZXQgYWxsb3dzIHVzIHRvIGNyZWF0ZSBh
IHdvcmtlciB0aHJlYWQgcGVyIElPIHZxLCBzbyB3ZQo+Pj4+IGNhbiBiZXR0ZXIgdXRpbGl6ZSBt
dWx0aXBsZSBDUFVzIHdpdGggdGhlIG11bHRpcGxlIHF1ZXVlcy4gSXQKPj4+PiBpbXBsbWVudHMg
SmFzb24ncyBzdWdnZXN0aW9uIHRvIGNyZWF0ZSB0aGUgaW5pdGlhbCB3b3JrZXIgbGlrZQo+Pj4+
IG5vcm1hbCwgdGhlbiBjcmVhdGUgdGhlIGV4dHJhIHdvcmtlcnMgZm9yIElPIHZxcyB3aXRoIHRo
ZQo+Pj4+IFZIT1NUX1NFVF9WUklOR19FTkFCTEUgaW9jdGwgY29tbWFuZCBhZGRlZCBpbiB0aGlz
IHBhdGNoc2V0Lgo+Pj4gSG93IGRvZXMgdXNlcnNwYWNlIGZpbmQgb3V0IHRoZSB0aWRzIGFuZCBz
ZXQgdGhlaXIgQ1BVIGFmZmluaXR5Pwo+Pj4KPj4+IFdoYXQgaXMgdGhlIG1lYW5pbmcgb2YgdGhl
IG5ldyBWSE9TVF9TRVRfVlJJTkdfRU5BQkxFIGlvY3RsPyBJdCBkb2Vzbid0Cj4+PiByZWFsbHkg
ImVuYWJsZSIgb3IgImRpc2FibGUiIHRoZSB2cSwgcmVxdWVzdHMgYXJlIHByb2Nlc3NlZCByZWdh
cmRsZXNzLgo+Pgo+PiBBY3R1YWxseSBJIHRoaW5rIGl0IHNob3VsZCBkbyB0aGUgcmVhbCAiZW5h
YmxlL2Rpc2FibGUiIHRoYXQgdHJpZXMgdG8gZm9sbG93IHRoZSB2aXJ0aW8gc3BlYy4KPj4KPiBX
aGF0IGRvZXMgcmVhbCBtZWFuIGhlcmU/CgoKSSB0aGluayBpdCBtZWFucyB3aGVuIGEgdnEgaXMg
ZGlzYWJsZWQsIHZob3N0IHdvbid0IHByb2Nlc3MgYW55IHJlcXVlc3QgCmZyb20gdGhhdCB2aXJ0
cXVldWUuCgoKPiBGb3IgdGhlIHZkcGEgZW5hYmxlIGNhbGwgZm9yIGV4YW1wbGUsIHdvdWxkIGl0
IGJlIGxpa2UKPiBpZmN2Zl92ZHBhX3NldF92cV9yZWFkeSB3aGVyZSBpdCBzZXRzIHRoZSByZWFk
eSBiaXQgb3IgbW9yZSBsaWtlIG1seDVfdmRwYV9zZXRfdnFfcmVhZHkKPiB3aGVyZSBpdCBjYW4g
ZG8gc29tZSBtb3JlIHdvcmsgaW4gdGhlIGRpc2FibGUgY2FzZT8KCgpGb3IgdkRQQSwgaXQgd291
bGQgYmUgbW9yZSBjb21wbGljYXRlZC4KCkUuZyBmb3IgSUZDVkYsIGl0IGp1c3QgZGVsYXkgdGhl
IHNldHRpbmcgb2YgcXVldWVfZW5hYmxlIHdoZW4gaXQgZ2V0IApEUklWRVJfT0suIFRlY2huaWNh
bGx5IGl0IGNhbiBwYXNzdGhyb3VnaCB0aGUgcXVldWVfZW5hYmxlIHRvIHRoZSAKaGFyZHdhcmUg
YXMgd2hhdCBtbHg1ZSBkaWQuCgoKPgo+IEZvciBuZXQgYW5kIHNvbWV0aGluZyBsaWtlIGlmY3Zm
X3ZkcGFfc2V0X3ZxX3JlYWR5J3MgZGVzaWduIHdvdWxkIHdlIGhhdmUKPiB2aG9zdF9yaW5nX2lv
Y3RsKCkgc2V0IHNvbWUgdmhvc3RfdmlydHF1ZXVlIGVuYWJsZSBiaXQuIFdlIHRoZW4gaGF2ZSBz
b21lIGhlbHBlcgo+IHZob3N0X3ZxX2lzX2VuYWJsZWQoKSBhbmQgc29tZSBjb2RlIHRvIGRldGVj
dCBpZiB1c2Vyc3BhY2Ugc3VwcG9ydHMgdGhlIG5ldyBpb2N0bC4KCgpZZXMsIHZob3N0IHN1cHBv
cnQgYmFja2VuZCBjYXBhYmlsaXR5LiBXaGVuIHVzZXJzcGFjZSBuZWdvdGlhdGUgdGhlIG5ldyAK
Y2FwYWJpbGl0eSwgd2Ugc2hvdWxkIGRlcGVuZCBvbiBTRVRfVlJJTkdfRU5BQkxFLCBpZiBub3Qg
d2UgY2FuIGRvIAp2aG9zdF92cV9pc19lbmFibGUoKS4KCgo+IEFuZCB0aGVuIGluIHZob3N0X25l
dF9zZXRfYmFja2VuZCBkbyB3ZSBjYWxsIHZob3N0X3ZxX2lzX2VuYWJsZWQoKT8gV2hhdCBpcyBk
b25lCj4gZm9yIGRpc2FibGUgdGhlbj8KCgpJdCBuZWVkcyBtb3JlIHRob3VnaHQsIGJ1dCB0aGUg
cXVlc3Rpb24gaXMgbm90IHNwZWNpZmljIHRvIApTRVRfVlJJTkdfRU5BQkxFLiBDb25zaWRlciBn
dWVzdCBtYXkgemVybyByaW5nIGFkZHJlc3MgYXMgd2VsbC4KCkZvciBkaXNhYmxpbmcsIHdlIGNh
biBzaW1wbHkgZmx1c2ggdGhlIHdvcmsgYW5kIGRpc2FibGUgYWxsIHRoZSBwb2xscy4KCgo+IEl0
IGRvZXNuJ3Qgc2VlbSB0byBidXkgYSBsb3Qgb2YgbmV3IGZ1bmN0aW9uYWxpdHkuIElzIGl0IGp1
c3QKPiBzbyB3ZSBmb2xsb3cgdGhlIHNwZWM/CgoKTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCBz
aW5jZSBzcGVjIGRlZmluZXMgcXVldWVfZW5hYmxlLCB3ZSBzaG91bGQgCnN1cHBvcnQgaXQgaW4g
dmhvc3QuIEFuZCB3ZSBjYW4gcGlnZ3liYWNrIHRoZSBkZWxheWVkIHZxIGNyZWF0aW9uIHdpdGgg
CnRoaXMgZmVhdHVyZS4gT3RoZXJ3aXNlIHdlIHdpbGwgZHVwbGljYXRlIHRoZSBmdW5jdGlvbiBp
ZiB3ZSB3YW50IHRvIApzdXBwb3J0IHF1ZXVlX2VuYWJsZS4KCgo+Cj4gT3IgZG8geW91IHdhbnQg
aXQgd29yayBtb3JlIGxpa2UgbWx4NV92ZHBhX3NldF92cV9yZWFkeT8gRm9yIHRoaXMgaW4gdmhv
c3RfcmluZ19pb2N0bAo+IHdoZW4gd2UgZ2V0IHRoZSBuZXcgaW9jdGwgd2Ugd291bGQgY2FsbCBp
bnRvIHRoZSBkcml2ZXJzIGFuZCBoYXZlIGl0IHN0YXJ0IHF1ZXVlcwo+IGFuZCBzdG9wIHF1ZXVl
cz8gRm9yIGVuYWJsZSwgd2hhdCB3ZSB5b3UgZG8gZm9yIG5ldCBmb3IgdGhpcyBjYXNlPwoKCk5l
dCBpcyBzb21ldGhpbmcgZGlmZmVyZW50LCB3ZSBjYW4gc2ltcGx5IHVzZSBTRVRfQkFDS0VORCB0
byBkaXNhYmxlIGEgCnNwZWNpZmljIHZpcnRxdWV1ZSB3aXRob3V0IGludHJvZHVjaW5nIG5ldyBp
b2N0bHMuIE5vdGljZSB0aGF0LCBuZXQgbXEgCmlzIGtpbmQgb2YgZGlmZmVyZW50IHdpdGggc2Nz
aSB3aGljaCBoYXZlIGEgcGVyIHF1ZXVlIHBhaXIgdmhvc3QgZGV2aWNlLCAKYW5kIHRoZSBBUEkg
YWxsb3dzIHVzIHRvIHNldCBiYWNrZW5kIGZvciBhIHNwZWNpZmljIHZpcnRxdWV1ZS4KCgo+IEZv
ciBkaXNhYmxlLAo+IHdvdWxkIHlvdSBkbyBzb21ldGhpbmcgbGlrZSB2aG9zdF9uZXRfc3RvcF92
cSAod2UgZG9uJ3QgZnJlZSB1cCBhbnl0aGluZyBhbGxvY2F0ZWQKPiBpbiB2aG9zdF92cmluZ19p
b2N0bCBjYWxscywgYnV0IHdlIGNhbiBzdG9wIHdoYXQgd2Ugc2V0dXAgaW4gdGhlIG5ldCBkcml2
ZXIpPwoKCkl0J3MgdXAgdG8geW91LCBpZiB5b3UgdGhpbmsgeW91IHNob3VsZCBmcmVlIHRoZSBy
ZXNvdXJjZXMgeW91IGNhbiBkbyB0aGF0LgoKCj4gSXMgdGhpcyB1c2VmdWwgZm9yIHRoZSBjdXJy
ZW50IG5ldCBtcSBkZXNpZ24gb3IgaXMgdGhpcyBmb3Igc29tZXRoaW5nIGxpa2Ugd2hlcmUKPiB5
b3Ugd291bGQgZG8gb25lIHZob3N0IG5ldCBkZXZpY2Ugd2l0aCBtdWx0aXBsZSB2cXM/CgoKSSB0
aGluayBTRVRfVlJJTkdfRU5BQkxFIGlzIG1vcmUgdXNlZnVsIGZvciBTQ1NJIHNpbmNlIGl0IGhh
dmUgYSBtb2RlbCAKb2YgbXVsdGlwbGUgdnFzIHBlciB2aG9zdCBkZXZpY2UuCgoKPgo+IE15IGlz
c3VlL2NvbnZlcm4gaXMgdGhhdCBpbiBnZW5lcmFsIHRoZXNlIGNhbGxzIHNlZW1zIHVzZWZ1bCwg
YnV0IHdlIGRvbid0IHJlYWxseQo+IG5lZWQgdGhlbSBmb3Igc2NzaSBiZWNhdXNlIHZob3N0IHNj
c2kgaXMgYWxyZWFkeSBzdHVjayBjcmVhdGluZyB2cXMgbGlrZSBob3cgaXQgZG9lcwo+IGR1ZSB0
byBleGlzdGluZyB1c2Vycy4gSWYgd2UgZG8gdGhlIGlmY3ZmX3ZkcGFfc2V0X3ZxX3JlYWR5IHR5
cGUgb2YgZGVzaWduIHdoZXJlCj4gd2UganVzdCBzZXQgc29tZSBiaXQsIHRoZW4gdGhlIG5ldyBp
b2N0bCBkb2VzIG5vdCBnaXZlIHVzIGEgbG90LiBJdCdzIGp1c3QgYW4gZXh0cmEKPiBjaGVjayBh
bmQgZXh0cmEgY29kZS4KPgo+IEFuZCBmb3IgdGhlIG1seDVfdmRwYV9zZXRfdnFfcmVhZHkgdHlw
ZSBvZiBkZXNpZ24sIGl0IGRvZXNuJ3Qgc2VlbSBsaWtlIGl0J3MgZ29pbmcKPiB0byBoYXBwZW4g
YSBsb3Qgd2hlcmUgdGhlIGFkbWluIGlzIGdvaW5nIHRvIHdhbnQgdG8gcmVtb3ZlIHZxcyBmcm9t
IGEgcnVubmluZyBkZXZpY2UuCgoKSW4gdGhpcyBjYXNlLCBxZW11IG1heSBqdXN0IGRpc2FibGUg
dGhlIHF1ZXVlcyBvZiB2aG9zdC1zY3NpIHZpYSAKU0VUX1ZSSU5HX0VOQUJMRSBhbmQgdGhlbiB3
ZSBjYW4gZnJlZSByZXNvdXJjZXM/CgoKPiBBbmQgZm9yIGJvdGggYWRkaXRpb24vcmVtb3ZhbCBm
b3Igc2NzaSB3ZSB3b3VsZCBuZWVkIGNvZGUgaW4gdmlydGlvIHNjc2kgdG8gaGFuZGxlCj4gaG90
IHBsdWcgcmVtb3ZhbC9hZGRpdGlvbiBvZiBhIHF1ZXVlIGFuZCB0aGVuIHJlZG9pbmcgdGhlIG11
bHRpcXVldWUgbWFwcGluZ3Mgd2hpY2gKPiB3b3VsZCBiZSBkaWZmaWN1bHQgdG8gYWRkIHdpdGgg
bm8gb25lIHJlcXVlc3RpbmcgaXQuCgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
