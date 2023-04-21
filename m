Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E95C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 14:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD336FF70;
	Fri, 21 Apr 2023 14:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AD336FF70
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDyTg0cm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3aJIPieQ9Mtd; Fri, 21 Apr 2023 14:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C036F6FF6C;
	Fri, 21 Apr 2023 14:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C036F6FF6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BABFC0036;
	Fri, 21 Apr 2023 14:28:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6617C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 14:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CA80810CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 14:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CA80810CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDyTg0cm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LY07JDqM0DSg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 14:28:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 156FB80EBC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 156FB80EBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682087309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gh2FKDIw04E1Y2danPvwRc3umx0NY4oLoGalTyKkosA=;
 b=bDyTg0cm2eUs/tUKqL+haN1CEqvXh5XnPqYJRAZ9kFSpOp7TTRyMS8X2VwItDHoQOBhcEN
 zBddQzP+qHjwo/aee2hqJwfNm5/YhGkLIZQE/zwTJaJahZwLkrthRHObBJG1UJc4Wvgomp
 f8WQ/3QJl27ZxmV5jywqfKAoArgBu9s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-gToPFlIiNMmobDwMQ3Dsdw-1; Fri, 21 Apr 2023 10:28:26 -0400
X-MC-Unique: gToPFlIiNMmobDwMQ3Dsdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF57838123CC;
 Fri, 21 Apr 2023 14:28:25 +0000 (UTC)
Received: from [10.39.208.29] (unknown [10.39.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C80E2C08492;
 Fri, 21 Apr 2023 14:28:23 +0000 (UTC)
Message-ID: <88a24206-b576-efc6-1bce-7f5075024c63@redhat.com>
Date: Fri, 21 Apr 2023 16:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
 <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
 <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
In-Reply-To: <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, david.marchand@redhat.com
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

CgpPbiA0LzIxLzIzIDA3OjUxLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFRodSwgQXByIDIwLCAy
MDIzIGF0IDEwOjE24oCvUE0gTWF4aW1lIENvcXVlbGluCj4gPG1heGltZS5jb3F1ZWxpbkByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4KPj4KPj4gT24gNC8yMC8yMyAwNjozNCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+IE9uIFdlZCwgQXByIDE5LCAyMDIzIGF0IDk6NDPigK9QTSBNYXhpbWUgQ29xdWVs
aW4KPj4+IDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBUaGlz
IHNtYWxsIHNlcmllcyBlbmFibGVzIHZpcnRpby1uZXQgZGV2aWNlIHR5cGUgaW4gVkRVU0UuCj4+
Pj4gV2l0aCBpdCwgYmFzaWMgb3BlcmF0aW9uIGhhdmUgYmVlbiB0ZXN0ZWQsIGJvdGggd2l0aAo+
Pj4+IHZpcnRpby12ZHBhIGFuZCB2aG9zdC12ZHBhIHVzaW5nIERQREsgVmhvc3QgbGlicmFyeSBz
ZXJpZXMKPj4+PiBhZGRpbmcgVkRVU0Ugc3VwcG9ydCBbMF0gdXNpbmcgc3BsaXQgcmluZ3MgbGF5
b3V0Lgo+Pj4+Cj4+Pj4gQ29udHJvbCBxdWV1ZSBzdXBwb3J0IChhbmQgc28gbXVsdGlxdWV1ZSkg
aGFzIGFsc28gYmVlbgo+Pj4+IHRlc3RlZCwgYnV0IHJlcXVpcmUgYSBLZXJuZWwgc2VyaWVzIGZy
b20gSmFzb24gV2FuZwo+Pj4+IHJlbGF4aW5nIGNvbnRyb2wgcXVldWUgcG9sbGluZyBbMV0gdG8g
ZnVuY3Rpb24gcmVsaWFibHkuCj4+Pj4KPj4+PiBPdGhlciB0aGFuIHRoYXQsIHdlIGhhdmUgaWRl
bnRpZmllZCBhIGZldyBnYXBzOgo+Pj4+Cj4+Pj4gMS4gUmVjb25uZWN0aW9uOgo+Pj4+ICAgIGEu
IFZEVVNFX1ZRX0dFVF9JTkZPIGlvY3RsKCkgcmV0dXJucyBhbHdheXMgMCBmb3IgYXZhaWwKPj4+
PiAgICAgICBpbmRleCwgZXZlbiBhZnRlciB0aGUgdmlydHF1ZXVlIGhhcyBhbHJlYWR5IGJlZW4K
Pj4+PiAgICAgICBwcm9jZXNzZWQuIElzIHRoYXQgZXhwZWN0ZWQ/IEkgaGF2ZSB0cmllZCBpbnN0
ZWFkIHRvCj4+Pj4gICAgICAgZ2V0IHRoZSBkcml2ZXIncyBhdmFpbCBpbmRleCBkaXJlY3RseSBm
cm9tIHRoZSBhdmFpbAo+Pj4+ICAgICAgIHJpbmcsIGJ1dCBpdCBkb2VzIG5vdCBzZWVtIHJlbGlh
YmxlIGFzIEkgc29tZXRpbWVzIGdldAo+Pj4+ICAgICAgICJpZCAldSBpcyBub3QgYSBoZWFkIVxu
IiB3YXJuaW5ncy4gQWxzbyBzdWNoIHNvbHV0aW9uCj4+Pj4gICAgICAgd291bGQgbm90IGJlIHBv
c3NpYmxlIHdpdGggcGFja2VkIHJpbmcsIGFzIHdlIG5lZWQgdG8KPj4+PiAgICAgICBrbm93IHRo
ZSB3cmFwIGNvdW50ZXJzIHZhbHVlcy4KPj4+Cj4+PiBMb29raW5nIGF0IHRoZSBjb2RlcywgaXQg
b25seSByZXR1cm5zIHRoZSB2YWx1ZSB0aGF0IGlzIHNldCB2aWEKPj4+IHNldF92cV9zdGF0ZSgp
LiBJIHRoaW5rIGl0IGlzIGV4cGVjdGVkIHRvIGJlIGNhbGxlZCBiZWZvcmUgdGhlCj4+PiBkYXRh
cGF0aCBydW5zLgo+Pj4KPj4+IFNvIHdoZW4gYm91bmQgdG8gdmlydGlvLXZkcGEsIGl0IGlzIGV4
cGVjdGVkIHRvIHJldHVybiAwLiBCdXQgd2UgbmVlZAo+Pj4gdG8gZml4IHRoZSBwYWNrZWQgdmly
dHF1ZXVlIGNhc2UsIEkgd29uZGVyIGlmIHdlIG5lZWQgdG8gY2FsbAo+Pj4gc2V0X3ZxX3N0YXRl
KCkgZXhwbGljaXRseSBpbiB2aXJ0aW8tdmRwYSBiZWZvcmUgc3RhcnRpbmcgdGhlIGRldmljZS4K
Pj4+Cj4+PiBXaGVuIGJvdW5kIHRvIHZob3N0LXZkcGEsIFFlbXUgd2lsbCBjYWxsIFZIT1NUX1NF
VF9WUklOR19CQVNFIHdoaWNoCj4+PiB3aWxsIGVuZCB1cCBhIGNhbGwgdG8gc2V0X3ZxX3N0YXRl
KCkuIFVuZm9ydHVuYXRlbHksIGl0IGRvZXNuJ3QKPj4+IHN1cHBvcnQgcGFja2VkIHJpbmcgd2hp
Y2ggbmVlZHMgc29tZSBleHRlbnNpb24uCj4+Pgo+Pj4+Cj4+Pj4gICAgYi4gTWlzc2luZyBJT0NU
THM6IGl0IHdvdWxkIGJlIGhhbmR5IHRvIGhhdmUgbmV3IElPQ1RMcyB0bwo+Pj4+ICAgICAgIHF1
ZXJ5IFZpcnRpbyBkZXZpY2Ugc3RhdHVzLAo+Pj4KPj4+IFdoYXQncyB0aGUgdXNlIGNhc2Ugb2Yg
dGhpcyBpb2N0bD8gSXQgbG9va3MgdG8gbWUgdXNlcnNwYWNlIGlzCj4+PiBub3RpZmllZCBvbiBl
YWNoIHN0YXR1cyBjaGFuZ2Ugbm93Ogo+Pj4KPj4+IHN0YXRpYyBpbnQgdmR1c2VfZGV2X3NldF9z
dGF0dXMoc3RydWN0IHZkdXNlX2RldiAqZGV2LCB1OCBzdGF0dXMpCj4+PiB7Cj4+PiAgICAgICAg
ICAgc3RydWN0IHZkdXNlX2Rldl9tc2cgbXNnID0geyAwIH07Cj4+Pgo+Pj4gICAgICAgICAgIG1z
Zy5yZXEudHlwZSA9IFZEVVNFX1NFVF9TVEFUVVM7Cj4+PiAgICAgICAgICAgbXNnLnJlcS5zLnN0
YXR1cyA9IHN0YXR1czsKPj4+Cj4+PiAgICAgICAgICAgcmV0dXJuIHZkdXNlX2Rldl9tc2dfc3lu
YyhkZXYsICZtc2cpOwo+Pj4gfQo+Pgo+PiBUaGUgaWRlYSB3YXMgdG8gYmUgYWJsZSB0byBxdWVy
eSB0aGUgc3RhdHVzIGF0IHJlY29ubmVjdCB0aW1lLCBhbmQKPj4gbmVpdGhlciBoYXZpbmcgdG8g
YXNzdW1lIGl0cyB2YWx1ZSBub3IgaGF2aW5nIHRvIHN0b3JlIGl0cyB2YWx1ZSBpbiBhCj4+IGZp
bGUgKHRoZSBzdGF0dXMgY291bGQgY2hhbmdlIHdoaWxlIHRoZSBWRFVTRSBhcHBsaWNhdGlvbiBp
cyBzdG9wcGVkLAo+PiBidXQgbWF5YmUgaXQgd291bGQgcmVjZWl2ZSB0aGUgbm90aWZpY2F0aW9u
IGF0IHJlY29ubmVjdCkuCj4gCj4gSSBzZWUuCj4gCj4+Cj4+IEkgd2lsbCBwcm90b3R5cGUgdXNp
bmcgYSB0bXBmcyBmaWxlIHRvIHNhdmUgbmVlZGVkIGluZm9ybWF0aW9uLCBhbmQgc2VlCj4+IGlm
IGl0IHdvcmtzLgo+IAo+IEl0IG1pZ2h0IHdvcmsgYnV0IHRoZW4gdGhlIEFQSSBpcyBub3Qgc2Vs
ZiBjb250YWluZWQuIE1heWJlIGl0J3MKPiBiZXR0ZXIgdG8gaGF2ZSBhIGRlZGljYXRlZCBpb2N0
bC4KPiAKPj4KPj4+PiBhbmQgcmV0cmlldmUgdGhlIGNvbmZpZwo+Pj4+ICAgICAgIHNwYWNlIHNl
dCBhdCBWRFVTRV9DUkVBVEVfREVWIHRpbWUuCj4+Pgo+Pj4gSW4gb3JkZXIgdG8gYmUgc2FmZSwg
VkRVU0UgYXZvaWRzIHdyaXRhYmxlIGNvbmZpZyBzcGFjZS4gT3RoZXJ3aXNlCj4+PiBkcml2ZXJz
IGNvdWxkIGJsb2NrIG9uIGNvbmZpZyB3cml0aW5nIGZvcmV2ZXIuIFRoYXQncyB3aHkgd2UgZG9u
J3QgZG8KPj4+IGl0IG5vdy4KPj4KPj4gVGhlIGlkZWEgd2FzIG5vdCB0byBtYWtlIHRoZSBjb25m
aWcgc3BhY2Ugd3JpdGFibGUsIGJ1dCBqdXN0IHRvIGJlIGFibGUKPj4gdG8gZmV0Y2ggd2hhdCB3
YXMgZmlsbGVkIGF0IFZEVVNFX0NSRUFURV9ERVYgdGltZS4KPj4KPj4gV2l0aCB0aGUgdG1wZnMg
ZmlsZSwgd2UgY2FuIGF2b2lkIGRvaW5nIHRoYXQgYW5kIGp1c3Qgc2F2ZSB0aGUgY29uZmlnCj4+
IHNwYWNlIHRoZXJlLgo+IAo+IFNhbWUgYXMgdGhlIGNhc2UgZm9yIHN0YXR1cy4KCkkgaGF2ZSBj
b29rZWQgYSBEUERLIHBhdGNoIHRvIHN1cHBvcnQgcmVjb25uZWN0IHdpdGggYSB0bXBmcyBmaWxl
IGFzCnN1Z2dlc3RlZCBieSBZb25namk6CgpodHRwczovL2dpdGxhYi5jb20vbWNvcXVlbGluL2Rw
ZGstbmV4dC12aXJ0aW8vLS9jb21taXQvNTM5MTNmMmIxMTU1YjAyYzQ0ZDVkM2QyOThhYWZkMzU3
ZTdhOGM0OAoKVGhhdCdzIHN0aWxsIHJvdWdoIGFyb3VuZCB0aGUgZWRnZXMsIGJ1dCBpdCBzZWVt
cyB0byB3b3JrIHJlbGlhYmx5CmZvciB0aGUgdGVzdGluZyBJIGhhdmUgZG9uZSBzbyBmYXIuIFdl
J2xsIGNlcnRhaW5seSB3YW50IHRvIHVzZSB0aGUKdG1wZnMgbWVtb3J5IHRvIGRpcmVjdGx5IHN0
b3JlIGF2YWlsYWJsZSBpbmRleGVzIGFuZCB3cmFwIGNvdW50ZXJzIHRvCmF2b2lkIGludHJvZHVj
aW5nIG92ZXJoZWFkIGluIHRoZSBkYXRhcGF0aC4gVGhlIHRyaWNreSBwYXJ0IHdpbGwgYmUgdG8K
bWFuYWdlIE5VTUEgYWZmaW5pdHkuCgpSZWdhcmRzLApNYXhpbWUKCj4gCj4gVGhhbmtzCj4gCj4+
Cj4+PiBXZSBuZWVkIHRvIGhhcmRlbiB0aGUgY29uZmlnIHdyaXRlIGJlZm9yZSB3ZSBjYW4gcHJv
Y2VlZCB0byB0aGlzIEkgdGhpbmsuCj4+Pgo+Pj4+Cj4+Pj4gMi4gVkRVU0UgYXBwbGljYXRpb24g
YXMgbm9uLXJvb3Q6Cj4+Pj4gICAgIFdlIG5lZWQgdG8gcnVuIHRoZSBWRFVTRSBhcHBsaWNhdGlv
biBhcyBub24tcm9vdC4gVGhlcmUKPj4+PiAgICAgaXMgc29tZSByYWNlIGJldHdlZW4gdGhlIHRp
bWUgdGhlIFVERVYgcnVsZSBpcyBhcHBsaWVkCj4+Pj4gICAgIGFuZCB0aGUgdGltZSB0aGUgZGV2
aWNlIHN0YXJ0cyBiZWluZyB1c2VkLiBEaXNjdXNzaW5nCj4+Pj4gICAgIHdpdGggSmFzb24sIGhl
IHN1Z2dlc3RlZCB3ZSBtYXkgaGF2ZSBhIFZEVVNFIGRhZW1vbiBydW4KPj4+PiAgICAgYXMgcm9v
dCB0aGF0IHdvdWxkIGNyZWF0ZSB0aGUgVkRVU0UgZGV2aWNlLCBtYW5hZ2VzIGl0cwo+Pj4+ICAg
ICByaWdodHMgYW5kIHRoZW4gcGFzcyBpdHMgZmlsZSBkZXNjcmlwdG9yIHRvIHRoZSBWRFVTRQo+
Pj4+ICAgICBhcHAuIEhvd2V2ZXIsIHdpdGggY3VycmVudCBJT0NUTHMsIGl0IG1lYW5zIHRoZSBW
RFVTRQo+Pj4+ICAgICBkYWVtb24gd291bGQgbmVlZCB0byBrbm93IHNldmVyYWwgaW5mb3JtYXRp
b24gdGhhdAo+Pj4+ICAgICBiZWxvbmdzIHRvIHRoZSBWRFVTRSBhcHAgaW1wbGVtZW50aW5nIHRo
ZSBkZXZpY2Ugc3VjaAo+Pj4+ICAgICBhcyBzdXBwb3J0ZWQgVmlydGlvIGZlYXR1cmVzLCBjb25m
aWcgc3BhY2UsIGV0Yy4uLgo+Pj4+ICAgICBJZiB3ZSBnbyB0aGF0IHJvdXRlLCBtYXliZSB3ZSBz
aG91bGQgaGF2ZSBhIGNvbnRyb2wKPj4+PiAgICAgSU9DVEwgdG8gY3JlYXRlIHRoZSBkZXZpY2Ug
d2hpY2ggd291bGQganVzdCBwYXNzIHRoZQo+Pj4+ICAgICBkZXZpY2UgdHlwZS4gVGhlbiBhbm90
aGVyIGRldmljZSBJT0NUTCB0byBwZXJmb3JtIHRoZQo+Pj4+ICAgICBpbml0aWFsaXphdGlvbi4g
V291bGQgdGhhdCBtYWtlIHNlbnNlPwo+Pj4KPj4+IEkgdGhpbmsgc28uIFdlIGNhbiBoZWFyIGZy
b20gb3RoZXJzLgo+Pj4KPj4+Pgo+Pj4+IDMuIENvcmVkdW1wOgo+Pj4+ICAgICBJbiBvcmRlciB0
byBiZSBhYmxlIHRvIHBlcmZvcm0gcG9zdC1tb3J0ZW0gYW5hbHlzaXMsIERQREsKPj4+PiAgICAg
Vmhvc3QgbGlicmFyeSBtYXJrcyBwYWdlcyB1c2VkIGZvciB2cmluZ3MgYW5kIGRlc2NyaXB0b3Jz
Cj4+Pj4gICAgIGJ1ZmZlcnMgYXMgTUFEVl9ET0RVTVAgdXNpbmcgbWFkdmlzZSgpLiBIb3dldmVy
IHdpdGgKPj4+PiAgICAgVkRVU0UgaXQgZmFpbHMgd2l0aCAtRUlOVkFMLiBNeSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgd2UKPj4+PiAgICAgc2V0IFZNX0RPTlRFWFBBTkQgZmxhZyB0byB0aGUgVk1B
cyBhbmQgbWFkdmlzZSdzCj4+Pj4gICAgIE1BRFZfRE9EVU1QIGZhaWxzIGlmIGl0IGlzIHByZXNl
bnQuIEknbSBub3Qgc3VyZSB0bwo+Pj4+ICAgICB1bmRlcnN0YW5kIHdoeSBtYWR2aXNlIHdvdWxk
IHByZXZlbnQgTUFEVl9ET0RVTVAgaWYKPj4+PiAgICAgVk1fRE9OVEVYUEFORCBpcyBzZXQuIEFu
eSB0aG91Z2h0cz8KPj4+Cj4+PiBBZGRpbmcgUGV0ZXIgd2hvIG1heSBrbm93IHRoZSBhbnN3ZXIu
Cj4+Cj4+IFRoYW5rcyEKPj4gTWF4aW1lCj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pj4KPj4+PiBbMF06
IGh0dHBzOi8vcGF0Y2h3b3JrLmRwZGsub3JnL3Byb2plY3QvZHBkay9saXN0Lz9zZXJpZXM9Mjc1
OTQmc3RhdGU9JTJBJmFyY2hpdmU9Ym90aAo+Pj4+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9DQUNHa01FdGdyeE4zUFB3c0RvNG9Pc25zU0xKZkVtQkVaMFd2akdScjN3aFUrUWFz
VWdAbWFpbC5nbWFpbC5jb20vVC8KPj4+Pgo+Pj4+IE1heGltZSBDb3F1ZWxpbiAoMik6Cj4+Pj4g
ICAgIHZkdXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sgZGV2aWNl
cwo+Pj4+ICAgICB2ZHVzZTogZW5hYmxlIFZpcnRpby1uZXQgZGV2aWNlIHR5cGUKPj4+Pgo+Pj4+
ICAgIGRyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCAxMSArKysrKysrLS0tLQo+
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+
Pj4KPj4+PiAtLQo+Pj4+IDIuMzkuMgo+Pj4+Cj4+Pgo+Pgo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
