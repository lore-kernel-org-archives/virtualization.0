Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B6C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:00:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC6564DD8
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC6564DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7BBD86FAA;
	Mon,  1 Feb 2021 06:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ou7ZKIoEL-Ln; Mon,  1 Feb 2021 06:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA5E986F93;
	Mon,  1 Feb 2021 06:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90921C0FA7;
	Mon,  1 Feb 2021 06:00:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFE5C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0DEFF86F97
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sij+ZRqCdKJZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E57B086F67
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612159249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdybqpikUstylFnotQy48gGt+VsHUqQDR1hNUpuuxFI=;
 b=cso1UdoPDaebNbLQ/LWWCuUfHEGGzLPeoiaLGrYF5F0Di5u3GSEXBzIsPHcQXEE5emTX0u
 89Pj98AaTwLekwZc051B/67YFjb7jIbpQ79mQWjif+56UkZZISLnGprvmu6JLkytA/QyWS
 kdoSKUrkFfb7VUOJ5zN9wPzMZmPhfic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-fAEQBVTOOKuxJMlZzKKzzQ-1; Mon, 01 Feb 2021 01:00:46 -0500
X-MC-Unique: fAEQBVTOOKuxJMlZzKKzzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED10D800D62;
 Mon,  1 Feb 2021 06:00:44 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A339A1001281;
 Mon,  1 Feb 2021 06:00:37 +0000 (UTC)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-3-elic@nvidia.com>
 <54239b51-918c-3475-dc88-4da1a4548da8@redhat.com>
 <20210131185536.GA164217@mtl-vdi-166.wap.labs.mlnx>
 <0c99f35c-7644-7201-cd11-7d486389a182@redhat.com>
 <20210201055247.GA184807@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c013407d-7a6a-adaa-efd1-24a8a48dc6fa@redhat.com>
Date: Mon, 1 Feb 2021 14:00:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201055247.GA184807@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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

Ck9uIDIwMjEvMi8xIOS4i+WNiDE6NTIsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBNb24sIEZlYiAw
MSwgMjAyMSBhdCAxMTozNjoyM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzIvMSDkuIrljYgyOjU1LCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBGcmksIEphbiAyOSwgMjAy
MSBhdCAxMTo0OTo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMS8y
OCDkuIvljYg5OjQxLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+IFdoZW4gYSBjaGFuZ2Ugb2YgbWVt
b3J5IG1hcCBvY2N1cnMsIHRoZSBoYXJkd2FyZSByZXNvdXJjZXMgYXJlIGRlc3Ryb3llZAo+Pj4+
PiBhbmQgdGhlbiByZS1jcmVhdGVkIGFnYWluIHdpdGggdGhlIG5ldyBtZW1vcnkgbWFwLiBJbiBz
dWNoIGNhc2UsIHdlIG5lZWQKPj4+Pj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxl
IGFuZCB1c2VkIGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4+Pj4+IHJlc3RvcmUgdGhl
IHVzZWQgaW5kZXggd2hpY2ggaXMgYWRkZWQgaGVyZS4KPj4+Pj4KPj4+Pj4gRml4ZXMgMWE4NmIz
NzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRl
dmljZXMiKQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4K
Pj4+PiBBIHF1ZXN0aW9uLiBEb2VzIHRoaXMgbWVhbiBhZnRlciBhIHZxIGlzIHN1c3BlbmRlZCwg
dGhlIGh3IHVzZWQgaW5kZXggaXMgbm90Cj4+Pj4gZXF1YWwgdG8gdnEgdXNlZCBpbmRleD8KPj4+
IFN1cmVseSB0aGVyZSBpcyBqdXN0IG9uZSAiVXNlZCBpbmRleCIgZm9yIGEgVlEuIFdoYXQgSSB3
YXMgdHJ5aW5nIHRvIHNheQo+Pj4gaXMgdGhhdCBhZnRlciB0aGUgVlEgaXMgc3VzcGVuZGVkLCBJ
IHJlYWQgdGhlIHVzZWQgaW5kZXggYnkgcXVlcnlpbmcgdGhlCj4+PiBoYXJkd2FyZS4gVGhlIHJl
YWQgcmVzdWx0IGlzIHRoZSB1c2VkIGluZGV4IHRoYXQgdGhlIGhhcmR3YXJlIHdyb3RlIHRvCj4+
PiBtZW1vcnkuCj4+Cj4+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCBoZXJlLiBTbyBp
dCBsb29rcyB0byBtZSB3ZSBoYWQgdHdvIGluZGV4LiBUaGUKPj4gZmlyc3QgaXMgdGhlIHVzZWQg
aW5kZXggd2hpY2ggaXMgc3RvcmVkIGluIHRoZSBtZW1vcnkvdmlydHF1ZXVlLCB0aGUgc2Vjb25k
Cj4+IGlzIHRoZSBvbmUgdGhhdCBpcyBzdG9yZWQgYnkgdGhlIGRldmljZS4KPj4KPiBJdCBpcyB0
aGUgc3RydWN0dXJlcyBkZWZpbmVkIGluIHRoZSB2aXJ0aW8gc3BlYyBpbiAyLjYuNiBmb3IgdGhl
Cj4gYXZhaWxhYmxlIHJpbmcgYW5kIDIuNi44IGZvciB0aGUgdXNlZCByaW5nLiBBcyB5b3Uga25v
dyB0aGVzZSB0aGUKPiBhdmFpbGFibGUgcmluZyBpcyB3cml0dGVuIHRvIGJ5IHRoZSBkcml2ZXIg
YW5kIHJlYWQgYnkgdGhlIGRldmljZS4gVGhlCj4gb3Bwb3NpdGUgaGFwcGVucyBmb3IgdGhlIHVz
ZWQgaW5kZXguCgoKUmlnaHQsIHNvIGZvciB1c2VkIGluZGV4IGl0IHdhcyB3cm90ZSBieSBkZXZp
Y2UuIEFuZCB0aGUgZGV2aWNlIHNob3VsZCAKaGF2ZSBhbiBpbnRlcm5hbCB1c2VkIGluZGV4IHZh
bHVlIHRoYXQgaXMgdXNlZCB0byB3cml0ZSB0byB0aGUgdXNlZCAKcmluZy4gQW5kIHRoZSBjb2Rl
IGlzIHVzZWQgdG8gc3luYyB0aGUgZGV2aWNlIGludGVybmFsIHVzZWQgaW5kZXggaWYgSSAKdW5k
ZXJzdGFuZCB0aGlzIGNvcnJlY3RseS4KCgo+IFRoZSByZWFzb24gSSBuZWVkIHRvIHJlc3RvcmUg
dGhlIGxhc3Qga25vd24gaW5kaWNlcyBpcyBmb3IgdGhlIG5ldwo+IGhhcmR3YXJlIG9iamVjdHMg
dG8gc3luYyBvbiB0aGUgbGFzdCBzdGF0ZSBhbmQgdGFrZSBvdmVyIGZyb20gdGhlcmUuCgoKUmln
aHQsIGFmdGVyIHRoZSB2cSBzdXNwZW5kaW5nLCB0aGUgcXVlc3Rpb25zIGFyZToKCjEpIGlzIGhh
cmR3YXJlIGludGVybmFsIHVzZWQgaW5kZXggbWlnaHQgbm90IGJlIHRoZSBzYW1lIHdpdGggdGhl
IHVzZWQgCmluZGV4IGluIHRoZSB2aXJ0cXVldWU/CgpvcgoKMikgY2FuIHdlIHNpbXBseSBzeW5j
IHRoZSB2aXJ0cXVldWUncyB1c2VkIGluZGV4IHRvIHRoZSBoYXJkd2FyZSdzIHVzZWQgCmluZGV4
PwoKVGhhbmtzCgoKPgo+Pj4gICAgQWZ0ZXIgdGhlIEkgY3JlYXRlIHRoZSBuZXcgaGFyZHdhcmUg
b2JqZWN0LCBJIG5lZWQgdG8gdGVsbCBpdAo+Pj4gd2hhdCBpcyB0aGUgdXNlZCBpbmRleCAoYW5k
IHRoZSBhdmFpbGFibGUgaW5kZXgpIGFzIGEgd2F5IHRvIHN5bmMgaXQKPj4+IHdpdGggdGhlIGV4
aXN0aW5nIFZRLgo+Pgo+PiBGb3IgYXZhaWwgaW5kZXggSSB1bmRlcnN0YW5kIHRoYXQgdGhlIGhh
cmR3YXJlIGluZGV4IGlzIG5vdCBzeW5jZWQgd2l0aCB0aGUKPj4gYXZhaWwgaW5kZXggc3RvcmVk
IGluIHRoZSBtZW1vcnkvdmlydHF1ZXVlLiBUaGUgcXVlc3Rpb24gaXMgdXNlZCBpbmRleCwgaWYK
Pj4gdGhlIGhhcmR3YXJlIG9uZSBpcyBub3Qgc3luY2VkIHdpdGggdGhlIG9uZSBpbiB0aGUgdmly
dHF1ZXVlLiBJdCBtZWFucyBhZnRlcgo+PiB2cSBpcyBzdXNwZW5kZWQswqAgc29tZSByZXF1ZXN0
cyBpcyBub3QgY29tcGxldGVkIGJ5IHRoZSBoYXJkd2FyZSAoZS5nIHRoZQo+PiBidWZmZXIgd2Vy
ZSBub3QgcHV0IHRvIHVzZWQgcmluZykuCj4+Cj4+IFRoaXMgbWF5IGhhdmUgaW1wbGljYXRpb25z
IHRvIGxpdmUgbWlncmF0aW9uLCBpdCBtZWFucyB0aG9zZSB1bmFjY29tcGxpc2hlZAo+PiByZXF1
ZXN0cyBuZWVkcyB0byBiZSBtaWdyYXRlZCB0byB0aGUgZGVzdGluYXRpb24gYW5kIHJlc3VibWl0
dGVkIHRvIHRoZQo+PiBkZXZpY2UuIFRoaXMgbG9va3Mgbm90IGVhc3kuCj4+Cj4+IFRoYW5rcwo+
Pgo+Pgo+Pj4gVGhpcyBzeW5jIGlzIGVzcGVjaWFsbHkgaW1wb3J0YW50IHdoZW4gYSBjaGFuZ2Ug
b2YgbWFwIG9jY3VycyB3aGlsZSB0aGUKPj4+IFZRIHdhcyBhbHJlYWR5IHVzZWQgKGhlbmNlIHRo
ZSBpbmRpY2VzIGFyZSBsaWtlbHkgdG8gYmUgbm9uIHplcm8pLiBUaGlzCj4+PiBjYW4gYmUgdHJp
Z2dlcmVkIGJ5IGhvdCBhZGRpbmcgbWVtb3J5IGFmdGVyIHRoZSBWUXMgaGF2ZSBiZWVuIHVzZWQu
Cj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gLS0tCj4+Pj4+ICAgICBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA3ICsrKysrKysKPj4+Pj4gICAgIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+Pj4+PiBpbmRleCA1NDlkZWQwNzRmZjMuLjNmYzg1ODhjZWNhZSAxMDA2NDQKPj4+Pj4gLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+PiBAQCAtODcsNiArODcsNyBAQCBzdHJ1Y3Qg
bWx4NV92cV9yZXN0b3JlX2luZm8gewo+Pj4+PiAgICAgCXU2NCBkZXZpY2VfYWRkcjsKPj4+Pj4g
ICAgIAl1NjQgZHJpdmVyX2FkZHI7Cj4+Pj4+ICAgICAJdTE2IGF2YWlsX2luZGV4Owo+Pj4+PiAr
CXUxNiB1c2VkX2luZGV4Owo+Pj4+PiAgICAgCWJvb2wgcmVhZHk7Cj4+Pj4+ICAgICAJc3RydWN0
IHZkcGFfY2FsbGJhY2sgY2I7Cj4+Pj4+ICAgICAJYm9vbCByZXN0b3JlOwo+Pj4+PiBAQCAtMTIx
LDYgKzEyMiw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlIHsKPj4+Pj4gICAgIAl1MzIg
dmlydHFfaWQ7Cj4+Pj4+ICAgICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4+Pj4+ICAg
ICAJdTE2IGF2YWlsX2lkeDsKPj4+Pj4gKwl1MTYgdXNlZF9pZHg7Cj4+Pj4+ICAgICAJaW50IGZ3
X3N0YXRlOwo+Pj4+PiAgICAgCS8qIGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0ICovCj4+Pj4+IEBA
IC04MDQsNiArODA2LDcgQEAgc3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1
X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPj4+Pj4gICAgIAlvYmpf
Y29udGV4dCA9IE1MWDVfQUREUl9PRihjcmVhdGVfdmlydGlvX25ldF9xX2luLCBpbiwgb2JqX2Nv
bnRleHQpOwo+Pj4+PiAgICAgCU1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250
ZXh0LCBod19hdmFpbGFibGVfaW5kZXgsIG12cS0+YXZhaWxfaWR4KTsKPj4+Pj4gKwlNTFg1X1NF
VCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfdXNlZF9pbmRleCwgbXZxLT51
c2VkX2lkeCk7Cj4+Pj4+ICAgICAJTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2Nv
bnRleHQsIHF1ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPj4+Pj4gICAgIAkJIGdldF9mZWF0
dXJlc18xMl8zKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+PiAgICAgCXZxX2N0
eCA9IE1MWDVfQUREUl9PRih2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgdmlydGlv
X3FfY29udGV4dCk7Cj4+Pj4+IEBAIC0xMDIyLDYgKzEwMjUsNyBAQCBzdGF0aWMgaW50IGNvbm5l
Y3RfcXBzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRx
dWV1ZSAqbQo+Pj4+PiAgICAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+Pj4+ICAgICAJdTgg
c3RhdGU7Cj4+Pj4+ICAgICAJdTE2IGF2YWlsYWJsZV9pbmRleDsKPj4+Pj4gKwl1MTYgdXNlZF9p
bmRleDsKPj4+Pj4gICAgIH07Cj4+Pj4+ICAgICBzdGF0aWMgaW50IHF1ZXJ5X3ZpcnRxdWV1ZShz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm12
cSwKPj4+Pj4gQEAgLTEwNTIsNiArMTA1Niw3IEBAIHN0YXRpYyBpbnQgcXVlcnlfdmlydHF1ZXVl
KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1Cj4+
Pj4+ICAgICAJbWVtc2V0KGF0dHIsIDAsIHNpemVvZigqYXR0cikpOwo+Pj4+PiAgICAgCWF0dHIt
PnN0YXRlID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsIHN0YXRl
KTsKPj4+Pj4gICAgIAlhdHRyLT5hdmFpbGFibGVfaW5kZXggPSBNTFg1X0dFVCh2aXJ0aW9fbmV0
X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfYXZhaWxhYmxlX2luZGV4KTsKPj4+Pj4gKwlhdHRy
LT51c2VkX2luZGV4ID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQs
IGh3X3VzZWRfaW5kZXgpOwo+Pj4+PiAgICAgCWtmcmVlKG91dCk7Cj4+Pj4+ICAgICAJcmV0dXJu
IDA7Cj4+Pj4+IEBAIC0xNjAyLDYgKzE2MDcsNyBAQCBzdGF0aWMgaW50IHNhdmVfY2hhbm5lbF9p
bmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+
Pj4+PiAgICAgCQlyZXR1cm4gZXJyOwo+Pj4+PiAgICAgCXJpLT5hdmFpbF9pbmRleCA9IGF0dHIu
YXZhaWxhYmxlX2luZGV4Owo+Pj4+PiArCXJpLT51c2VkX2luZGV4ID0gYXR0ci51c2VkX2luZGV4
Owo+Pj4+PiAgICAgCXJpLT5yZWFkeSA9IG12cS0+cmVhZHk7Cj4+Pj4+ICAgICAJcmktPm51bV9l
bnQgPSBtdnEtPm51bV9lbnQ7Cj4+Pj4+ICAgICAJcmktPmRlc2NfYWRkciA9IG12cS0+ZGVzY19h
ZGRyOwo+Pj4+PiBAQCAtMTY0Niw2ICsxNjUyLDcgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9jaGFu
bmVsc19pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+PiAgICAgCQkJY29udGlu
dWU7Cj4+Pj4+ICAgICAJCW12cS0+YXZhaWxfaWR4ID0gcmktPmF2YWlsX2luZGV4Owo+Pj4+PiAr
CQltdnEtPnVzZWRfaWR4ID0gcmktPnVzZWRfaW5kZXg7Cj4+Pj4+ICAgICAJCW12cS0+cmVhZHkg
PSByaS0+cmVhZHk7Cj4+Pj4+ICAgICAJCW12cS0+bnVtX2VudCA9IHJpLT5udW1fZW50Owo+Pj4+
PiAgICAgCQltdnEtPmRlc2NfYWRkciA9IHJpLT5kZXNjX2FkZHI7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
