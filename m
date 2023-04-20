Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED1DC77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 14:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADE6581D72;
	Thu, 20 Apr 2023 14:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADE6581D72
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBwou1Kn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jplowez1BLBj; Thu, 20 Apr 2023 14:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B8DB81E3B;
	Thu, 20 Apr 2023 14:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B8DB81E3B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2EBFC0037;
	Thu, 20 Apr 2023 14:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB6EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2440F40902
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2440F40902
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBwou1Kn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jh9F5JAd267f
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B50BF408BA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B50BF408BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682000614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfo2baQUlkaoUrH6uVBEN/YQb1jbKuxQyDXUby2j6jw=;
 b=WBwou1KnMVruyGMA3rktOxtTgPf2nxqOFT2Exors12GTpotB4EH7aZydyNqXCaZlOMX/vR
 hRSNhu5FVBhUtLBNNNSIai/x9JQixk6Rtw02vYCF8aJi5oJBsIU2bScyxcPBllkpn/QozK
 /L++DfcgQ2RpyKViW3cRAgXDvZT01YQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-iDJJoEQ3Mfyqn8NlwvFLNQ-1; Thu, 20 Apr 2023 10:23:31 -0400
X-MC-Unique: iDJJoEQ3Mfyqn8NlwvFLNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE77E3C106A4;
 Thu, 20 Apr 2023 14:23:30 +0000 (UTC)
Received: from [10.39.208.29] (unknown [10.39.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFDA140C2064;
 Thu, 20 Apr 2023 14:23:28 +0000 (UTC)
Message-ID: <b97af8ee-5b5d-fbd9-443d-ee18f97ee03b@redhat.com>
Date: Thu, 20 Apr 2023 16:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yongji Xie <xieyongji@bytedance.com>
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACycT3tbQSFdADGiP-ijSj2ZjRctMsPmJQhEBygguzYOjA4Y9Q@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
In-Reply-To: <CACycT3tbQSFdADGiP-ijSj2ZjRctMsPmJQhEBygguzYOjA4Y9Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 David Marchand <david.marchand@redhat.com>
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

CgpPbiA0LzIwLzIzIDEwOjEzLCBZb25namkgWGllIHdyb3RlOgo+IE9uIFdlZCwgQXByIDE5LCAy
MDIzIGF0IDk6NDTigK9QTSBNYXhpbWUgQ29xdWVsaW4KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pgo+PiBUaGlzIHNtYWxsIHNlcmllcyBlbmFibGVzIHZpcnRpby1uZXQg
ZGV2aWNlIHR5cGUgaW4gVkRVU0UuCj4+IFdpdGggaXQsIGJhc2ljIG9wZXJhdGlvbiBoYXZlIGJl
ZW4gdGVzdGVkLCBib3RoIHdpdGgKPj4gdmlydGlvLXZkcGEgYW5kIHZob3N0LXZkcGEgdXNpbmcg
RFBESyBWaG9zdCBsaWJyYXJ5IHNlcmllcwo+PiBhZGRpbmcgVkRVU0Ugc3VwcG9ydCBbMF0gdXNp
bmcgc3BsaXQgcmluZ3MgbGF5b3V0Lgo+Pgo+PiBDb250cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBz
byBtdWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4+IHRlc3RlZCwgYnV0IHJlcXVpcmUgYSBLZXJu
ZWwgc2VyaWVzIGZyb20gSmFzb24gV2FuZwo+PiByZWxheGluZyBjb250cm9sIHF1ZXVlIHBvbGxp
bmcgWzFdIHRvIGZ1bmN0aW9uIHJlbGlhYmx5Lgo+Pgo+PiBPdGhlciB0aGFuIHRoYXQsIHdlIGhh
dmUgaWRlbnRpZmllZCBhIGZldyBnYXBzOgo+Pgo+PiAxLiBSZWNvbm5lY3Rpb246Cj4+ICAgYS4g
VkRVU0VfVlFfR0VUX0lORk8gaW9jdGwoKSByZXR1cm5zIGFsd2F5cyAwIGZvciBhdmFpbAo+PiAg
ICAgIGluZGV4LCBldmVuIGFmdGVyIHRoZSB2aXJ0cXVldWUgaGFzIGFscmVhZHkgYmVlbgo+PiAg
ICAgIHByb2Nlc3NlZC4gSXMgdGhhdCBleHBlY3RlZD8gSSBoYXZlIHRyaWVkIGluc3RlYWQgdG8K
Pj4gICAgICBnZXQgdGhlIGRyaXZlcidzIGF2YWlsIGluZGV4IGRpcmVjdGx5IGZyb20gdGhlIGF2
YWlsCj4+ICAgICAgcmluZywgYnV0IGl0IGRvZXMgbm90IHNlZW0gcmVsaWFibGUgYXMgSSBzb21l
dGltZXMgZ2V0Cj4+ICAgICAgImlkICV1IGlzIG5vdCBhIGhlYWQhXG4iIHdhcm5pbmdzLiBBbHNv
IHN1Y2ggc29sdXRpb24KPj4gICAgICB3b3VsZCBub3QgYmUgcG9zc2libGUgd2l0aCBwYWNrZWQg
cmluZywgYXMgd2UgbmVlZCB0bwo+PiAgICAgIGtub3cgdGhlIHdyYXAgY291bnRlcnMgdmFsdWVz
Lgo+Pgo+IAo+IEknbSBub3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoZSByZWNvbm5lY3Rpb24gaW4g
dGhlIHZob3N0LXVzZXItbmV0Cj4gY2FzZS4gQ2FuIHdlIHVzZSBhIHRtcGZzIGZpbGUgdG8gdHJh
Y2sgaW5mbGlnaHQgSS9PIGxpa2UgdGhpcyBbMV0KCldlIGRvbid0IGhhdmUgaW5mbGlnaHQgSU9z
IHdpdGggRFBESyBWaHNvdCBsaWJyYXJ5IGZvciBuZXQgZGV2aWNlcy4KQnV0IHllcywgYSBzb2x1
dGlvbiBpcyB0byBoYXZlIGEgdG1wZnMgZmlsZSB0byBzYXZlIG5lZWRlZCBkYXRhLgoKQWR2YW50
YWdlIG9mIHRoaXMgc29sdXRpb24gaXMgaXQgbWFrZXMgaXQgcG9zc2libGUgdG8gcmVjb25uZWN0
IHdpdGgKcGFja2VkIHJpbmcgaW4gY2FzZSBvZiBhcHBsaWNhdGlvbiBjcmFzaCwgYXMgdGhlIHdy
YXAgY291bnRlciB2YWx1ZXMKd291bGQgbm90IGJlIGxvc3QuCgo+IFsxXSBodHRwczovL3FlbXUt
cHJvamVjdC5naXRsYWIuaW8vcWVtdS9pbnRlcm9wL3Zob3N0LXVzZXIuaHRtbCNpbmZsaWdodC1p
LW8tdHJhY2tpbmcKPiAKPj4gICBiLiBNaXNzaW5nIElPQ1RMczogaXQgd291bGQgYmUgaGFuZHkg
dG8gaGF2ZSBuZXcgSU9DVExzIHRvCj4+ICAgICAgcXVlcnkgVmlydGlvIGRldmljZSBzdGF0dXMs
IGFuZCByZXRyaWV2ZSB0aGUgY29uZmlnCj4+ICAgICAgc3BhY2Ugc2V0IGF0IFZEVVNFX0NSRUFU
RV9ERVYgdGltZS4KPj4KPiAKPiBWRFVTRV9HRVRfU1RBVFVTIGlvY3RsIG1pZ2h0IGJlIG5lZWRl
ZC4gT3IgY2FuIHdlIHVzZSBhIHRtcGZzIGZpbGUgdG8KPiBzYXZlL3Jlc3RvcmUgdGhhdCBpbmZv
Lgo+IAo+PiAyLiBWRFVTRSBhcHBsaWNhdGlvbiBhcyBub24tcm9vdDoKPj4gICAgV2UgbmVlZCB0
byBydW4gdGhlIFZEVVNFIGFwcGxpY2F0aW9uIGFzIG5vbi1yb290LiBUaGVyZQo+PiAgICBpcyBz
b21lIHJhY2UgYmV0d2VlbiB0aGUgdGltZSB0aGUgVURFViBydWxlIGlzIGFwcGxpZWQKPj4gICAg
YW5kIHRoZSB0aW1lIHRoZSBkZXZpY2Ugc3RhcnRzIGJlaW5nIHVzZWQuIERpc2N1c3NpbmcKPj4g
ICAgd2l0aCBKYXNvbiwgaGUgc3VnZ2VzdGVkIHdlIG1heSBoYXZlIGEgVkRVU0UgZGFlbW9uIHJ1
bgo+PiAgICBhcyByb290IHRoYXQgd291bGQgY3JlYXRlIHRoZSBWRFVTRSBkZXZpY2UsIG1hbmFn
ZXMgaXRzCj4+ICAgIHJpZ2h0cyBhbmQgdGhlbiBwYXNzIGl0cyBmaWxlIGRlc2NyaXB0b3IgdG8g
dGhlIFZEVVNFCj4+ICAgIGFwcC4gSG93ZXZlciwgd2l0aCBjdXJyZW50IElPQ1RMcywgaXQgbWVh
bnMgdGhlIFZEVVNFCj4+ICAgIGRhZW1vbiB3b3VsZCBuZWVkIHRvIGtub3cgc2V2ZXJhbCBpbmZv
cm1hdGlvbiB0aGF0Cj4+ICAgIGJlbG9uZ3MgdG8gdGhlIFZEVVNFIGFwcCBpbXBsZW1lbnRpbmcg
dGhlIGRldmljZSBzdWNoCj4+ICAgIGFzIHN1cHBvcnRlZCBWaXJ0aW8gZmVhdHVyZXMsIGNvbmZp
ZyBzcGFjZSwgZXRjLi4uCj4+ICAgIElmIHdlIGdvIHRoYXQgcm91dGUsIG1heWJlIHdlIHNob3Vs
ZCBoYXZlIGEgY29udHJvbAo+PiAgICBJT0NUTCB0byBjcmVhdGUgdGhlIGRldmljZSB3aGljaCB3
b3VsZCBqdXN0IHBhc3MgdGhlCj4+ICAgIGRldmljZSB0eXBlLiBUaGVuIGFub3RoZXIgZGV2aWNl
IElPQ1RMIHRvIHBlcmZvcm0gdGhlCj4+ICAgIGluaXRpYWxpemF0aW9uLiBXb3VsZCB0aGF0IG1h
a2Ugc2Vuc2U/Cj4+Cj4gCj4gSSB0aGluayB3ZSBjYW4gcmV1c2UgdGhlIFZEVVNFX0NSRUFURV9E
RVYgaW9jdGwgKGp1c3QgdXNlIG5hbWUsCj4gZGV2aWNlX2lkIGFuZCB2ZW5kb3JfaWQpIGZvciBj
b250cm9sIGRldmljZSBoZXJlLCBhbmQgYWRkIGEgbmV3IGlvY3RsCj4gVkRVU0VfREVWX1NFVFVQ
IHRvIGRvIGRldmljZSBpbml0aWFsaXphdGlvbi4KCk9LLgpJZiB3ZSBkbyB0aGF0LCBjb3VsZCB3
ZSBhbHNvIHByb3ZpZGUgdGhlIHBvc3NpYmlsaXR5IHRvIHBhc3MgYW4gVVVJRCBhdCAKVkRVU0Vf
REVWX1NFVFVQIHRpbWU/CgpJdCBjb3VsZCBiZSB1c2VmdWwgaWYgd2Ugc2F2ZSBpbmZvcm1hdGlv
biBpbiBhIHRtcGZzIGZpbGUsIGluIG9yZGVyIHRvCmJlIGFibGUgYXQgcmVjb25uZWN0IHRpbWUg
dG8gZW5zdXJlIHRoZSB0bXBmcyBmaWxlIFVVSUQgbWF0Y2hlcyB3aXRoIHRoZQpWRFVTRSBkZXZp
Y2UgVVVJRCwgYW5kIHNvIGF2b2lkIHJlc3RvcmluZyBhIGxlZnRvdmVyIHRtcGZzIGZpbGUgb2Yg
YQpwcmV2aW91c2x5IGRldHJveWVkIHRoZW4gcmUtY3JlYXRlZCBWRFVTRSBkZXZpY2UuIFdvdWxk
IHRoYXQgbWFrZSBzZW5zZT8KClJlZ2FyZHMsCk1heGltZQoKPiBUaGFua3MsCj4gWW9uZ2ppCj4g
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
