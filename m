Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B92C77B7E
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 14:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15AC06FF27;
	Thu, 20 Apr 2023 14:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15AC06FF27
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iMaZ0OMP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a15B3akler-z; Thu, 20 Apr 2023 14:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 498916FEF2;
	Thu, 20 Apr 2023 14:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 498916FEF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08238C0037;
	Thu, 20 Apr 2023 14:16:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74727C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DF5A81F91
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:16:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DF5A81F91
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iMaZ0OMP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zt3UaCAvZGKx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BB2B81F84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BB2B81F84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682000185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1T36f5lWuPwGQNCUsmK0J4sinKZGKVtA8ZHxEwHxbRo=;
 b=iMaZ0OMPfqUKBQop0yl5DiHpCvX+u+IKFH5NxAh65g1YSnlW1LhXMeNdP6BzxurNWYzqv/
 gNKnSsHv3dFM9g0D2/dUbk4LCXfG1r1cMIGrXqJ7SaBFOEzKcZdZvP6uxpN+CwiiH/5J5y
 KA5a/ehkMOT5lUpb6X01bzv1VLsVsGg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-E5By3_RbMseCuPUEaTJtvw-1; Thu, 20 Apr 2023 10:16:21 -0400
X-MC-Unique: E5By3_RbMseCuPUEaTJtvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDD1B384D03B;
 Thu, 20 Apr 2023 14:16:11 +0000 (UTC)
Received: from [10.39.208.29] (unknown [10.39.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F891121319;
 Thu, 20 Apr 2023 14:16:09 +0000 (UTC)
Message-ID: <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
Date: Thu, 20 Apr 2023 16:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
In-Reply-To: <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

CgpPbiA0LzIwLzIzIDA2OjM0LCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFdlZCwgQXByIDE5LCAy
MDIzIGF0IDk6NDPigK9QTSBNYXhpbWUgQ29xdWVsaW4KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhh
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
Lgo+IAo+IExvb2tpbmcgYXQgdGhlIGNvZGVzLCBpdCBvbmx5IHJldHVybnMgdGhlIHZhbHVlIHRo
YXQgaXMgc2V0IHZpYQo+IHNldF92cV9zdGF0ZSgpLiBJIHRoaW5rIGl0IGlzIGV4cGVjdGVkIHRv
IGJlIGNhbGxlZCBiZWZvcmUgdGhlCj4gZGF0YXBhdGggcnVucy4KPiAKPiBTbyB3aGVuIGJvdW5k
IHRvIHZpcnRpby12ZHBhLCBpdCBpcyBleHBlY3RlZCB0byByZXR1cm4gMC4gQnV0IHdlIG5lZWQK
PiB0byBmaXggdGhlIHBhY2tlZCB2aXJ0cXVldWUgY2FzZSwgSSB3b25kZXIgaWYgd2UgbmVlZCB0
byBjYWxsCj4gc2V0X3ZxX3N0YXRlKCkgZXhwbGljaXRseSBpbiB2aXJ0aW8tdmRwYSBiZWZvcmUg
c3RhcnRpbmcgdGhlIGRldmljZS4KPiAKPiBXaGVuIGJvdW5kIHRvIHZob3N0LXZkcGEsIFFlbXUg
d2lsbCBjYWxsIFZIT1NUX1NFVF9WUklOR19CQVNFIHdoaWNoCj4gd2lsbCBlbmQgdXAgYSBjYWxs
IHRvIHNldF92cV9zdGF0ZSgpLiBVbmZvcnR1bmF0ZWx5LCBpdCBkb2Vzbid0Cj4gc3VwcG9ydCBw
YWNrZWQgcmluZyB3aGljaCBuZWVkcyBzb21lIGV4dGVuc2lvbi4KPiAKPj4KPj4gICBiLiBNaXNz
aW5nIElPQ1RMczogaXQgd291bGQgYmUgaGFuZHkgdG8gaGF2ZSBuZXcgSU9DVExzIHRvCj4+ICAg
ICAgcXVlcnkgVmlydGlvIGRldmljZSBzdGF0dXMsCj4gCj4gV2hhdCdzIHRoZSB1c2UgY2FzZSBv
ZiB0aGlzIGlvY3RsPyBJdCBsb29rcyB0byBtZSB1c2Vyc3BhY2UgaXMKPiBub3RpZmllZCBvbiBl
YWNoIHN0YXR1cyBjaGFuZ2Ugbm93Ogo+IAo+IHN0YXRpYyBpbnQgdmR1c2VfZGV2X3NldF9zdGF0
dXMoc3RydWN0IHZkdXNlX2RldiAqZGV2LCB1OCBzdGF0dXMpCj4gewo+ICAgICAgICAgIHN0cnVj
dCB2ZHVzZV9kZXZfbXNnIG1zZyA9IHsgMCB9Owo+IAo+ICAgICAgICAgIG1zZy5yZXEudHlwZSA9
IFZEVVNFX1NFVF9TVEFUVVM7Cj4gICAgICAgICAgbXNnLnJlcS5zLnN0YXR1cyA9IHN0YXR1czsK
PiAKPiAgICAgICAgICByZXR1cm4gdmR1c2VfZGV2X21zZ19zeW5jKGRldiwgJm1zZyk7Cj4gfQoK
VGhlIGlkZWEgd2FzIHRvIGJlIGFibGUgdG8gcXVlcnkgdGhlIHN0YXR1cyBhdCByZWNvbm5lY3Qg
dGltZSwgYW5kCm5laXRoZXIgaGF2aW5nIHRvIGFzc3VtZSBpdHMgdmFsdWUgbm9yIGhhdmluZyB0
byBzdG9yZSBpdHMgdmFsdWUgaW4gYQpmaWxlICh0aGUgc3RhdHVzIGNvdWxkIGNoYW5nZSB3aGls
ZSB0aGUgVkRVU0UgYXBwbGljYXRpb24gaXMgc3RvcHBlZCwKYnV0IG1heWJlIGl0IHdvdWxkIHJl
Y2VpdmUgdGhlIG5vdGlmaWNhdGlvbiBhdCByZWNvbm5lY3QpLgoKSSB3aWxsIHByb3RvdHlwZSB1
c2luZyBhIHRtcGZzIGZpbGUgdG8gc2F2ZSBuZWVkZWQgaW5mb3JtYXRpb24sIGFuZCBzZWUKaWYg
aXQgd29ya3MuCgo+PiBhbmQgcmV0cmlldmUgdGhlIGNvbmZpZwo+PiAgICAgIHNwYWNlIHNldCBh
dCBWRFVTRV9DUkVBVEVfREVWIHRpbWUuCj4gCj4gSW4gb3JkZXIgdG8gYmUgc2FmZSwgVkRVU0Ug
YXZvaWRzIHdyaXRhYmxlIGNvbmZpZyBzcGFjZS4gT3RoZXJ3aXNlCj4gZHJpdmVycyBjb3VsZCBi
bG9jayBvbiBjb25maWcgd3JpdGluZyBmb3JldmVyLiBUaGF0J3Mgd2h5IHdlIGRvbid0IGRvCj4g
aXQgbm93LgoKVGhlIGlkZWEgd2FzIG5vdCB0byBtYWtlIHRoZSBjb25maWcgc3BhY2Ugd3JpdGFi
bGUsIGJ1dCBqdXN0IHRvIGJlIGFibGUKdG8gZmV0Y2ggd2hhdCB3YXMgZmlsbGVkIGF0IFZEVVNF
X0NSRUFURV9ERVYgdGltZS4KCldpdGggdGhlIHRtcGZzIGZpbGUsIHdlIGNhbiBhdm9pZCBkb2lu
ZyB0aGF0IGFuZCBqdXN0IHNhdmUgdGhlIGNvbmZpZwpzcGFjZSB0aGVyZS4KCj4gV2UgbmVlZCB0
byBoYXJkZW4gdGhlIGNvbmZpZyB3cml0ZSBiZWZvcmUgd2UgY2FuIHByb2NlZWQgdG8gdGhpcyBJ
IHRoaW5rLgo+IAo+Pgo+PiAyLiBWRFVTRSBhcHBsaWNhdGlvbiBhcyBub24tcm9vdDoKPj4gICAg
V2UgbmVlZCB0byBydW4gdGhlIFZEVVNFIGFwcGxpY2F0aW9uIGFzIG5vbi1yb290LiBUaGVyZQo+
PiAgICBpcyBzb21lIHJhY2UgYmV0d2VlbiB0aGUgdGltZSB0aGUgVURFViBydWxlIGlzIGFwcGxp
ZWQKPj4gICAgYW5kIHRoZSB0aW1lIHRoZSBkZXZpY2Ugc3RhcnRzIGJlaW5nIHVzZWQuIERpc2N1
c3NpbmcKPj4gICAgd2l0aCBKYXNvbiwgaGUgc3VnZ2VzdGVkIHdlIG1heSBoYXZlIGEgVkRVU0Ug
ZGFlbW9uIHJ1bgo+PiAgICBhcyByb290IHRoYXQgd291bGQgY3JlYXRlIHRoZSBWRFVTRSBkZXZp
Y2UsIG1hbmFnZXMgaXRzCj4+ICAgIHJpZ2h0cyBhbmQgdGhlbiBwYXNzIGl0cyBmaWxlIGRlc2Ny
aXB0b3IgdG8gdGhlIFZEVVNFCj4+ICAgIGFwcC4gSG93ZXZlciwgd2l0aCBjdXJyZW50IElPQ1RM
cywgaXQgbWVhbnMgdGhlIFZEVVNFCj4+ICAgIGRhZW1vbiB3b3VsZCBuZWVkIHRvIGtub3cgc2V2
ZXJhbCBpbmZvcm1hdGlvbiB0aGF0Cj4+ICAgIGJlbG9uZ3MgdG8gdGhlIFZEVVNFIGFwcCBpbXBs
ZW1lbnRpbmcgdGhlIGRldmljZSBzdWNoCj4+ICAgIGFzIHN1cHBvcnRlZCBWaXJ0aW8gZmVhdHVy
ZXMsIGNvbmZpZyBzcGFjZSwgZXRjLi4uCj4+ICAgIElmIHdlIGdvIHRoYXQgcm91dGUsIG1heWJl
IHdlIHNob3VsZCBoYXZlIGEgY29udHJvbAo+PiAgICBJT0NUTCB0byBjcmVhdGUgdGhlIGRldmlj
ZSB3aGljaCB3b3VsZCBqdXN0IHBhc3MgdGhlCj4+ICAgIGRldmljZSB0eXBlLiBUaGVuIGFub3Ro
ZXIgZGV2aWNlIElPQ1RMIHRvIHBlcmZvcm0gdGhlCj4+ICAgIGluaXRpYWxpemF0aW9uLiBXb3Vs
ZCB0aGF0IG1ha2Ugc2Vuc2U/Cj4gCj4gSSB0aGluayBzby4gV2UgY2FuIGhlYXIgZnJvbSBvdGhl
cnMuCj4gCj4+Cj4+IDMuIENvcmVkdW1wOgo+PiAgICBJbiBvcmRlciB0byBiZSBhYmxlIHRvIHBl
cmZvcm0gcG9zdC1tb3J0ZW0gYW5hbHlzaXMsIERQREsKPj4gICAgVmhvc3QgbGlicmFyeSBtYXJr
cyBwYWdlcyB1c2VkIGZvciB2cmluZ3MgYW5kIGRlc2NyaXB0b3JzCj4+ICAgIGJ1ZmZlcnMgYXMg
TUFEVl9ET0RVTVAgdXNpbmcgbWFkdmlzZSgpLiBIb3dldmVyIHdpdGgKPj4gICAgVkRVU0UgaXQg
ZmFpbHMgd2l0aCAtRUlOVkFMLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2UKPj4gICAgc2V0
IFZNX0RPTlRFWFBBTkQgZmxhZyB0byB0aGUgVk1BcyBhbmQgbWFkdmlzZSdzCj4+ICAgIE1BRFZf
RE9EVU1QIGZhaWxzIGlmIGl0IGlzIHByZXNlbnQuIEknbSBub3Qgc3VyZSB0bwo+PiAgICB1bmRl
cnN0YW5kIHdoeSBtYWR2aXNlIHdvdWxkIHByZXZlbnQgTUFEVl9ET0RVTVAgaWYKPj4gICAgVk1f
RE9OVEVYUEFORCBpcyBzZXQuIEFueSB0aG91Z2h0cz8KPiAKPiBBZGRpbmcgUGV0ZXIgd2hvIG1h
eSBrbm93IHRoZSBhbnN3ZXIuCgpUaGFua3MhCk1heGltZQoKPiBUaGFua3MKPiAKPj4KPj4gWzBd
OiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvbGlzdC8/c2VyaWVzPTI3
NTk0JnN0YXRlPSUyQSZhcmNoaXZlPWJvdGgKPj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL0NBQ0drTUV0Z3J4TjNQUHdzRG80b09zbnNTTEpmRW1CRVowV3ZqR1JyM3doVStRYXNV
Z0BtYWlsLmdtYWlsLmNvbS9ULwo+Pgo+PiBNYXhpbWUgQ29xdWVsaW4gKDIpOgo+PiAgICB2ZHVz
ZTogdmFsaWRhdGUgYmxvY2sgZmVhdHVyZXMgb25seSB3aXRoIGJsb2NrIGRldmljZXMKPj4gICAg
dmR1c2U6IGVuYWJsZSBWaXJ0aW8tbmV0IGRldmljZSB0eXBlCj4+Cj4+ICAgZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDExICsrKysrKystLS0tCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gLS0KPj4gMi4zOS4yCj4+
Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
