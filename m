Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A4C433DB
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:12:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE6D2256F
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE6D2256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D9B785A58;
	Thu, 24 Dec 2020 02:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VU_9Fu10dfXU; Thu, 24 Dec 2020 02:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5329385624;
	Thu, 24 Dec 2020 02:12:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33CC5C1787;
	Thu, 24 Dec 2020 02:12:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D57C0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EA7DA8632E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pC3Rx47bv9-b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:12:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9C812862B7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608775919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swnlJja9vV9IaQUf+Cmbgo9v/rpw1W8NO8amK8k/76w=;
 b=OoUngNy+XMzo+U9wGATfFjmKjlPA4LDx124qGaR3jDmjVRG6VbXIsRe0z/b7QQSPkok8uX
 jmkPLgVA0ET679OA0gRk9PvWyhI7hG1/zTLfH7dOrNkVtgoQnF+bQP9z5I0gAh2z6gtSzM
 xE+zsecSw5NgZpDlpko7karOiRIYf5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-kM5oObpROuyJDzDHe6-P1A-1; Wed, 23 Dec 2020 21:11:55 -0500
X-MC-Unique: kM5oObpROuyJDzDHe6-P1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C510107ACE6;
 Thu, 24 Dec 2020 02:11:54 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C11B5D9C6;
 Thu, 24 Dec 2020 02:11:42 +0000 (UTC)
Subject: Re: [PATCH v2] vhost/vsock: add IOTLB API support
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201223143638.123417-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28e8b1cf-513a-5bc6-096d-432dfa6620cb@redhat.com>
Date: Thu, 24 Dec 2020 10:11:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201223143638.123417-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjAvMTIvMjMg5LiL5Y2IMTA6MzYsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBU
aGlzIHBhdGNoIGVuYWJsZXMgdGhlIElPVExCIEFQSSBzdXBwb3J0IGZvciB2aG9zdC12c29jayBk
ZXZpY2VzLAo+IGFsbG93aW5nIHRoZSB1c2Vyc3BhY2UgdG8gZW11bGF0ZSBhbiBJT01NVSBmb3Ig
dGhlIGd1ZXN0Lgo+Cj4gVGhlc2UgY2hhbmdlcyB3ZXJlIG1hZGUgZm9sbG93aW5nIHZob3N0LW5l
dCwgaW4gZGV0YWlscyB0aGlzIHBhdGNoOgo+IC0gZXhwb3NlcyBWSVJUSU9fRl9BQ0NFU1NfUExB
VEZPUk0gZmVhdHVyZSBhbmQgaW5pdHMgdGhlIGlvdGxiCj4gICAgZGV2aWNlIGlmIHRoZSBmZWF0
dXJlIGlzIGFja2VkCj4gLSBpbXBsZW1lbnRzIFZIT1NUX0dFVF9CQUNLRU5EX0ZFQVRVUkVTIGFu
ZAo+ICAgIFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTIGlvY3Rscwo+IC0gY2FsbHMgdnFfbWV0
YV9wcmVmZXRjaCgpIGJlZm9yZSB2cSBwcm9jZXNzaW5nIHRvIHByZWZldGNoIHZxCj4gICAgbWV0
YWRhdGEgYWRkcmVzcyBpbiBJT1RMQgo+IC0gcHJvdmlkZXMgLnJlYWRfaXRlciwgLndyaXRlX2l0
ZXIsIGFuZCAucG9sbCBjYWxsYmFja3MgZm9yIHRoZQo+ICAgIGNoYXJkZXY7IHRoZXkgYXJlIHVz
ZWQgYnkgdGhlIHVzZXJzcGFjZSB0byBleGNoYW5nZSBJT1RMQiBtZXNzYWdlcwo+Cj4gVGhpcyBw
YXRjaCB3YXMgdGVzdGVkIHNwZWNpZnlpbmcgImludGVsX2lvbW11PXN0cmljdCIgaW4gdGhlIGd1
ZXN0Cj4ga2VybmVsIGNvbW1hbmQgbGluZS4gSSB1c2VkIFFFTVUgd2l0aCBhIHBhdGNoIGFwcGxp
ZWQgWzFdIHRvIGZpeCBhCj4gc2ltcGxlIGlzc3VlICh0aGF0IHBhdGNoIHdhcyBtZXJnZWQgaW4g
UUVNVSB2NS4yLjApOgo+ICAgICAgJCBxZW11IC1NIHEzNSxhY2NlbD1rdm0sa2VybmVsLWlycWNo
aXA9c3BsaXQgXAo+ICAgICAgICAgICAgIC1kcml2ZSBmaWxlPWZlZG9yYS5xY293Mixmb3JtYXQ9
cWNvdzIsaWY9dmlydGlvIFwKPiAgICAgICAgICAgICAtZGV2aWNlIGludGVsLWlvbW11LGludHJl
bWFwPW9uLGRldmljZS1pb3RsYj1vbiBcCj4gICAgICAgICAgICAgLWRldmljZSB2aG9zdC12c29j
ay1wY2ksZ3Vlc3QtY2lkPTMsaW9tbXVfcGxhdGZvcm09b24sYXRzPW9uCj4KPiBbMV0gaHR0cHM6
Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjAtMTAvbXNnMDkwNzcu
aHRtbAo+Cj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0K
Pgo+IFRoZSBwYXRjaCBpcyB0aGUgc2FtZSBvZiB2MSwgYnV0IEkgcmUtdGVzdGVkIGl0IHdpdGg6
Cj4gLSBRRU1VIHY1LjIuMC01NTEtZ2EwNWY4ZWNkODgKPiAtIExpbnV4IDUuOS4xNSAoaG9zdCkK
PiAtIExpbnV4IDUuOS4xNSBhbmQgNS4xMC4wIChndWVzdCkKPiBOb3csIGVuYWJsaW5nICdhdHMn
IGl0IHdvcmtzIHdlbGwsIHRoZXJlIGFyZSBqdXN0IGEgZmV3IHNpbXBsZSBjaGFuZ2VzLgo+Cj4g
djE6IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2tlcm5lbC9tc2czNzE2MDIyLmh0bWwK
PiB2MjoKPiAtIHVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UgYWJvdXQgUUVNVSB2ZXJzaW9uIGFuZCBz
dHJpbmcgdXNlZCB0byB0ZXN0Cj4gLSByZWJhc2VkIG9uIG1zdC92aG9zdCBicmFuY2gKPgo+IFRo
YW5rcywKPiBTdGVmYW5vCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfCA2OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNjUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3Zzb2NrLmMgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPiBpbmRleCBhNDgzY2Vj
MzFkNWMuLjVlNzhmYjcxOTYwMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMK
PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPiBAQCAtMzAsNyArMzAsMTIgQEAKPiAgICNk
ZWZpbmUgVkhPU1RfVlNPQ0tfUEtUX1dFSUdIVCAyNTYKPiAgIAo+ICAgZW51bSB7Cj4gLQlWSE9T
VF9WU09DS19GRUFUVVJFUyA9IFZIT1NUX0ZFQVRVUkVTLAo+ICsJVkhPU1RfVlNPQ0tfRkVBVFVS
RVMgPSBWSE9TVF9GRUFUVVJFUyB8Cj4gKwkJCSAgICAgICAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NF
U1NfUExBVEZPUk0pCj4gK307Cj4gKwo+ICtlbnVtIHsKPiArCVZIT1NUX1ZTT0NLX0JBQ0tFTkRf
RkVBVFVSRVMgPSAoMVVMTCA8PCBWSE9TVF9CQUNLRU5EX0ZfSU9UTEJfTVNHX1YyKQo+ICAgfTsK
PiAgIAo+ICAgLyogVXNlZCB0byB0cmFjayBhbGwgdGhlIHZob3N0X3Zzb2NrIGluc3RhbmNlcyBv
biB0aGUgc3lzdGVtLiAqLwo+IEBAIC05NCw2ICs5OSw5IEBAIHZob3N0X3RyYW5zcG9ydF9kb19z
ZW5kX3BrdChzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2NrLAo+ICAgCWlmICghdmhvc3RfdnFfZ2V0
X2JhY2tlbmQodnEpKQo+ICAgCQlnb3RvIG91dDsKPiAgIAo+ICsJaWYgKCF2cV9tZXRhX3ByZWZl
dGNoKHZxKSkKPiArCQlnb3RvIG91dDsKPiArCj4gICAJLyogQXZvaWQgZnVydGhlciB2bWV4aXRz
LCB3ZSdyZSBhbHJlYWR5IHByb2Nlc3NpbmcgdGhlIHZpcnRxdWV1ZSAqLwo+ICAgCXZob3N0X2Rp
c2FibGVfbm90aWZ5KCZ2c29jay0+ZGV2LCB2cSk7Cj4gICAKPiBAQCAtNDQ5LDYgKzQ1Nyw5IEBA
IHN0YXRpYyB2b2lkIHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKHN0cnVjdCB2aG9zdF93b3Jr
ICp3b3JrKQo+ICAgCWlmICghdmhvc3RfdnFfZ2V0X2JhY2tlbmQodnEpKQo+ICAgCQlnb3RvIG91
dDsKPiAgIAo+ICsJaWYgKCF2cV9tZXRhX3ByZWZldGNoKHZxKSkKPiArCQlnb3RvIG91dDsKPiAr
Cj4gICAJdmhvc3RfZGlzYWJsZV9ub3RpZnkoJnZzb2NrLT5kZXYsIHZxKTsKPiAgIAlkbyB7Cj4g
ICAJCXUzMiBsZW47Cj4gQEAgLTc2Niw4ICs3NzcsMTIgQEAgc3RhdGljIGludCB2aG9zdF92c29j
a19zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X3Zzb2NrICp2c29jaywgdTY0IGZlYXR1cmVzKQo+
ICAgCW11dGV4X2xvY2soJnZzb2NrLT5kZXYubXV0ZXgpOwo+ICAgCWlmICgoZmVhdHVyZXMgJiAo
MSA8PCBWSE9TVF9GX0xPR19BTEwpKSAmJgo+ICAgCSAgICAhdmhvc3RfbG9nX2FjY2Vzc19vaygm
dnNvY2stPmRldikpIHsKPiAtCQltdXRleF91bmxvY2soJnZzb2NrLT5kZXYubXV0ZXgpOwo+IC0J
CXJldHVybiAtRUZBVUxUOwo+ICsJCWdvdG8gZXJyOwo+ICsJfQo+ICsKPiArCWlmICgoZmVhdHVy
ZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkgewo+ICsJCWlmICh2aG9z
dF9pbml0X2RldmljZV9pb3RsYigmdnNvY2stPmRldiwgdHJ1ZSkpCj4gKwkJCWdvdG8gZXJyOwo+
ICAgCX0KPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHZzb2NrLT52cXMpOyBp
KyspIHsKPiBAQCAtNzc4LDYgKzc5MywxMCBAQCBzdGF0aWMgaW50IHZob3N0X3Zzb2NrX3NldF9m
ZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2NrLCB1NjQgZmVhdHVyZXMpCj4gICAJfQo+
ICAgCW11dGV4X3VubG9jaygmdnNvY2stPmRldi5tdXRleCk7Cj4gICAJcmV0dXJuIDA7Cj4gKwo+
ICtlcnI6Cj4gKwltdXRleF91bmxvY2soJnZzb2NrLT5kZXYubXV0ZXgpOwo+ICsJcmV0dXJuIC1F
RkFVTFQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBsb25nIHZob3N0X3Zzb2NrX2Rldl9pb2N0bChz
dHJ1Y3QgZmlsZSAqZiwgdW5zaWduZWQgaW50IGlvY3RsLAo+IEBAIC04MTEsNiArODMwLDE4IEBA
IHN0YXRpYyBsb25nIHZob3N0X3Zzb2NrX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZiwgdW5zaWdu
ZWQgaW50IGlvY3RsLAo+ICAgCQlpZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1cmVzLCBhcmdwLCBz
aXplb2YoZmVhdHVyZXMpKSkKPiAgIAkJCXJldHVybiAtRUZBVUxUOwo+ICAgCQlyZXR1cm4gdmhv
c3RfdnNvY2tfc2V0X2ZlYXR1cmVzKHZzb2NrLCBmZWF0dXJlcyk7Cj4gKwljYXNlIFZIT1NUX0dF
VF9CQUNLRU5EX0ZFQVRVUkVTOgo+ICsJCWZlYXR1cmVzID0gVkhPU1RfVlNPQ0tfQkFDS0VORF9G
RUFUVVJFUzsKPiArCQlpZiAoY29weV90b191c2VyKGFyZ3AsICZmZWF0dXJlcywgc2l6ZW9mKGZl
YXR1cmVzKSkpCj4gKwkJCXJldHVybiAtRUZBVUxUOwo+ICsJCXJldHVybiAwOwo+ICsJY2FzZSBW
SE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUzoKPiArCQlpZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1
cmVzLCBhcmdwLCBzaXplb2YoZmVhdHVyZXMpKSkKPiArCQkJcmV0dXJuIC1FRkFVTFQ7Cj4gKwkJ
aWYgKGZlYXR1cmVzICYgflZIT1NUX1ZTT0NLX0JBQ0tFTkRfRkVBVFVSRVMpCj4gKwkJCXJldHVy
biAtRU9QTk9UU1VQUDsKPiArCQl2aG9zdF9zZXRfYmFja2VuZF9mZWF0dXJlcygmdnNvY2stPmRl
diwgZmVhdHVyZXMpOwo+ICsJCXJldHVybiAwOwo+ICAgCWRlZmF1bHQ6Cj4gICAJCW11dGV4X2xv
Y2soJnZzb2NrLT5kZXYubXV0ZXgpOwo+ICAgCQlyID0gdmhvc3RfZGV2X2lvY3RsKCZ2c29jay0+
ZGV2LCBpb2N0bCwgYXJncCk7Cj4gQEAgLTgyMyw2ICs4NTQsMzQgQEAgc3RhdGljIGxvbmcgdmhv
c3RfdnNvY2tfZGV2X2lvY3RsKHN0cnVjdCBmaWxlICpmLCB1bnNpZ25lZCBpbnQgaW9jdGwsCj4g
ICAJfQo+ICAgfQo+ICAgCj4gK3N0YXRpYyBzc2l6ZV90IHZob3N0X3Zzb2NrX2Nocl9yZWFkX2l0
ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRvKQo+ICt7Cj4gKwlzdHJ1
Y3QgZmlsZSAqZmlsZSA9IGlvY2ItPmtpX2ZpbHA7Cj4gKwlzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZz
b2NrID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+ICsJc3RydWN0IHZob3N0X2RldiAqZGV2ID0gJnZz
b2NrLT5kZXY7Cj4gKwlpbnQgbm9ibG9jayA9IGZpbGUtPmZfZmxhZ3MgJiBPX05PTkJMT0NLOwo+
ICsKPiArCXJldHVybiB2aG9zdF9jaHJfcmVhZF9pdGVyKGRldiwgdG8sIG5vYmxvY2spOwo+ICt9
Cj4gKwo+ICtzdGF0aWMgc3NpemVfdCB2aG9zdF92c29ja19jaHJfd3JpdGVfaXRlcihzdHJ1Y3Qg
a2lvY2IgKmlvY2IsCj4gKwkJCQkJc3RydWN0IGlvdl9pdGVyICpmcm9tKQo+ICt7Cj4gKwlzdHJ1
Y3QgZmlsZSAqZmlsZSA9IGlvY2ItPmtpX2ZpbHA7Cj4gKwlzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZz
b2NrID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwo+ICsJc3RydWN0IHZob3N0X2RldiAqZGV2ID0gJnZz
b2NrLT5kZXY7Cj4gKwo+ICsJcmV0dXJuIHZob3N0X2Nocl93cml0ZV9pdGVyKGRldiwgZnJvbSk7
Cj4gK30KPiArCj4gK3N0YXRpYyBfX3BvbGxfdCB2aG9zdF92c29ja19jaHJfcG9sbChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgcG9sbF90YWJsZSAqd2FpdCkKPiArewo+ICsJc3RydWN0IHZob3N0X3Zzb2Nr
ICp2c29jayA9IGZpbGUtPnByaXZhdGVfZGF0YTsKPiArCXN0cnVjdCB2aG9zdF9kZXYgKmRldiA9
ICZ2c29jay0+ZGV2Owo+ICsKPiArCXJldHVybiB2aG9zdF9jaHJfcG9sbChmaWxlLCBkZXYsIHdh
aXQpOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgdmhv
c3RfdnNvY2tfZm9wcyA9IHsKPiAgIAkub3duZXIgICAgICAgICAgPSBUSElTX01PRFVMRSwKPiAg
IAkub3BlbiAgICAgICAgICAgPSB2aG9zdF92c29ja19kZXZfb3BlbiwKPiBAQCAtODMwLDYgKzg4
OSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHZob3N0X3Zzb2NrX2Zv
cHMgPSB7Cj4gICAJLmxsc2VlawkJPSBub29wX2xsc2VlaywKPiAgIAkudW5sb2NrZWRfaW9jdGwg
PSB2aG9zdF92c29ja19kZXZfaW9jdGwsCj4gICAJLmNvbXBhdF9pb2N0bCAgID0gY29tcGF0X3B0
cl9pb2N0bCwKPiArCS5yZWFkX2l0ZXIgICAgICA9IHZob3N0X3Zzb2NrX2Nocl9yZWFkX2l0ZXIs
Cj4gKwkud3JpdGVfaXRlciAgICAgPSB2aG9zdF92c29ja19jaHJfd3JpdGVfaXRlciwKPiArCS5w
b2xsICAgICAgICAgICA9IHZob3N0X3Zzb2NrX2Nocl9wb2xsLAo+ICAgfTsKPiAgIAo+ICAgc3Rh
dGljIHN0cnVjdCBtaXNjZGV2aWNlIHZob3N0X3Zzb2NrX21pc2MgPSB7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
