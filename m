Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442EC43461
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:24:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BCE6117A
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BCE6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 728B341851;
	Fri, 16 Apr 2021 02:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dT0qlA2YXF-d; Fri, 16 Apr 2021 02:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB04641853;
	Fri, 16 Apr 2021 02:24:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B021C000C;
	Fri, 16 Apr 2021 02:24:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9710C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A132483A88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GazRY_buuqZP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6AE283A49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618539858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7yqDQHPgrQYkb8M62q+x5doApMJRAx5WaKLZfS6Tcg=;
 b=iuFknwjIEu7q/rnTBdCsJj1cO8q+boty6JN1BGGFKzNyA4HGAHJBbup9RckzlyXtU44MWL
 wK1aPNTUiYNDKlzsLydlJVh1+7sz2ZtUtbbszbYT3R39wqS25QnGDic3MSSJHhjlftKXIf
 hOZ/X+D0sRs81mZJa85LgWvpscf2btg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-HANyjIGRNDuhtujU26iTeg-1; Thu, 15 Apr 2021 22:24:15 -0400
X-MC-Unique: HANyjIGRNDuhtujU26iTeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A914CC623;
 Fri, 16 Apr 2021 02:24:13 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-140.pek2.redhat.com
 [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4520353CC3;
 Fri, 16 Apr 2021 02:24:00 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
 <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
 <CACycT3uNR+nZY5gY0UhPkeOyi7Za6XkX4b=hasuDcgqdc7fqfg@mail.gmail.com>
 <YHfo8pc7dIO9lNc3@stefanha-x1.localdomain>
 <80b31814-9e41-3153-7efb-c0c2fab44feb@redhat.com>
 <YHhP4i+yXgA2KkVJ@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <31aa139a-dd4e-ba8a-c671-a2a1c69c1ffc@redhat.com>
Date: Fri, 16 Apr 2021 10:23:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHhP4i+yXgA2KkVJ@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Yongji Xie <xieyongji@bytedance.com>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzQvMTUg5LiL5Y2IMTA6MzgsIFN0ZWZhbiBIYWpub2N6aSDlhpnpgZM6Cj4gT24g
VGh1LCBBcHIgMTUsIDIwMjEgYXQgMDQ6MzY6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4g5ZyoIDIwMjEvNC8xNSDkuIvljYgzOjE5LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+Pj4g
T24gVGh1LCBBcHIgMTUsIDIwMjEgYXQgMDE6Mzg6MzdQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPj4+PiBPbiBXZWQsIEFwciAxNCwgMjAyMSBhdCAxMDoxNSBQTSBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+PiBPbiBXZWQsIE1hciAzMSwgMjAyMSBh
dCAwNDowNToxOVBNICswODAwLCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4+Pj4gVkRVU0UgKHZEUEEg
RGV2aWNlIGluIFVzZXJzcGFjZSkgaXMgYSBmcmFtZXdvcmsgdG8gc3VwcG9ydAo+Pj4+Pj4gaW1w
bGVtZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZEUEEgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIFRo
aXMKPj4+Pj4+IGRvY3VtZW50IGlzIGludGVuZGVkIHRvIGNsYXJpZnkgdGhlIFZEVVNFIGRlc2ln
biBhbmQgdXNhZ2UuCj4+Pj4+Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAgIERvY3VtZW50YXRpb24v
dXNlcnNwYWNlLWFwaS9pbmRleC5yc3QgfCAgIDEgKwo+Pj4+Pj4gICAgRG9jdW1lbnRhdGlvbi91
c2Vyc3BhY2UtYXBpL3ZkdXNlLnJzdCB8IDIxMiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4+Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25zKCspCj4+Pj4+
PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL3ZkdXNl
LnJzdAo+Pj4+PiBKdXN0IGxvb2tpbmcgb3ZlciB0aGUgZG9jdW1lbnRhdGlvbiBicmllZmx5IChJ
IGhhdmVuJ3Qgc3R1ZGllZCB0aGUgY29kZQo+Pj4+PiB5ZXQpLi4uCj4+Pj4+Cj4+Pj4gVGhhbmsg
eW91IQo+Pj4+Cj4+Pj4+PiArSG93IFZEVVNFIHdvcmtzCj4+Pj4+PiArLS0tLS0tLS0tLS0tCj4+
Pj4+PiArRWFjaCB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UgaXMgY3JlYXRlZCBieSB0aGUgVkRVU0Vf
Q1JFQVRFX0RFViBpb2N0bCBvbgo+Pj4+Pj4gK3RoZSBjaGFyYWN0ZXIgZGV2aWNlICgvZGV2L3Zk
dXNlL2NvbnRyb2wpLiBUaGVuIGEgZGV2aWNlIGZpbGUgd2l0aCB0aGUKPj4+Pj4+ICtzcGVjaWZp
ZWQgbmFtZSAoL2Rldi92ZHVzZS8kTkFNRSkgd2lsbCBhcHBlYXIsIHdoaWNoIGNhbiBiZSB1c2Vk
IHRvCj4+Pj4+PiAraW1wbGVtZW50IHRoZSB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UncyBjb250cm9s
IHBhdGggYW5kIGRhdGEgcGF0aC4KPj4+Pj4gVGhlc2Ugc3RlcHMgYXJlIHRha2VuIGFmdGVyIHNl
bmRpbmcgdGhlIFZEUEFfQ01EX0RFVl9ORVcgbmV0bGluawo+Pj4+PiBtZXNzYWdlPyAoUGxlYXNl
IGNvbnNpZGVyIHJlb3JkZXJpbmcgdGhlIGRvY3VtZW50YXRpb24gdG8gbWFrZSBpdCBjbGVhcgo+
Pj4+PiB3aGF0IHRoZSBzZXF1ZW5jZSBvZiBzdGVwcyBhcmUuKQo+Pj4+Pgo+Pj4+IE5vLCBWRFVT
RSBkZXZpY2VzIHNob3VsZCBiZSBjcmVhdGVkIGJlZm9yZSBzZW5kaW5nIHRoZQo+Pj4+IFZEUEFf
Q01EX0RFVl9ORVcgbmV0bGluayBtZXNzYWdlcyB3aGljaCBtaWdodCBwcm9kdWNlIEkvT3MgdG8g
VkRVU0UuCj4+PiBJIHNlZS4gUGxlYXNlIGluY2x1ZGUgYW4gb3ZlcnZpZXcgb2YgdGhlIHN0ZXBz
IGJlZm9yZSBnb2luZyBpbnRvIGRldGFpbC4KPj4+IFNvbWV0aGluZyBsaWtlOgo+Pj4KPj4+ICAg
ICBWRFVTRSBkZXZpY2VzIGFyZSBzdGFydGVkIGFzIGZvbGxvd3M6Cj4+Pgo+Pj4gICAgIDEuIENy
ZWF0ZSBhIG5ldyBWRFVTRSBpbnN0YW5jZSB3aXRoIGlvY3RsKFZEVVNFX0NSRUFURV9ERVYpIG9u
Cj4+PiAgICAgICAgL2Rldi92ZHVzZS9jb250cm9sLgo+Pj4KPj4+ICAgICAyLiBCZWdpbiBwcm9j
ZXNzaW5nIFZEVVNFIG1lc3NhZ2VzIGZyb20gL2Rldi92ZHVzZS8kTkFNRS4gVGhlIGZpcnN0Cj4+
PiAgICAgICAgbWVzc2FnZXMgd2lsbCBhcnJpdmUgd2hpbGUgYXR0YWNoaW5nIHRoZSBWRFVTRSBp
bnN0YW5jZSB0byB2RFBBLgo+Pj4KPj4+ICAgICAzLiBTZW5kIHRoZSBWRFBBX0NNRF9ERVZfTkVX
IG5ldGxpbmsgbWVzc2FnZSB0byBhdHRhY2ggdGhlIFZEVVNFCj4+PiAgICAgICAgaW5zdGFuY2Ug
dG8gdkRQQS4KPj4+Cj4+PiAgICAgVkRVU0UgZGV2aWNlcyBhcmUgc3RvcHBlZCBhcyBmb2xsb3dz
Ogo+Pj4KPj4+ICAgICAuLi4KPj4+Cj4+Pj4+PiArICAgICBzdGF0aWMgaW50IG5ldGxpbmtfYWRk
X3ZkdXNlKGNvbnN0IGNoYXIgKm5hbWUsIGludCBkZXZpY2VfaWQpCj4+Pj4+PiArICAgICB7Cj4+
Pj4+PiArICAgICAgICAgICAgIHN0cnVjdCBubF9zb2NrICpubHNvY2s7Cj4+Pj4+PiArICAgICAg
ICAgICAgIHN0cnVjdCBubF9tc2cgKm1zZzsKPj4+Pj4+ICsgICAgICAgICAgICAgaW50IGZhbWlk
Owo+Pj4+Pj4gKwo+Pj4+Pj4gKyAgICAgICAgICAgICBubHNvY2sgPSBubF9zb2NrZXRfYWxsb2Mo
KTsKPj4+Pj4+ICsgICAgICAgICAgICAgaWYgKCFubHNvY2spCj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgICAgICAgIGlm
IChnZW5sX2Nvbm5lY3Qobmxzb2NrKSkKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGZyZWVfc29jazsKPj4+Pj4+ICsKPj4+Pj4+ICsgICAgICAgICAgICAgZmFtaWQgPSBnZW5sX2N0
cmxfcmVzb2x2ZShubHNvY2ssIFZEUEFfR0VOTF9OQU1FKTsKPj4+Pj4+ICsgICAgICAgICAgICAg
aWYgKGZhbWlkIDwgMCkKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGNsb3NlX3Nv
Y2s7Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgICAgICAgIG1zZyA9IG5sbXNnX2FsbG9jKCk7Cj4+
Pj4+PiArICAgICAgICAgICAgIGlmICghbXNnKQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IGdvdG8gY2xvc2Vfc29jazsKPj4+Pj4+ICsKPj4+Pj4+ICsgICAgICAgICAgICAgaWYgKCFnZW5s
bXNnX3B1dChtc2csIE5MX0FVVE9fUE9SVCwgTkxfQVVUT19TRVEsIGZhbWlkLCAwLCAwLAo+Pj4+
Pj4gKyAgICAgICAgICAgICAgICAgVkRQQV9DTURfREVWX05FVywgMCkpCj4+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgZ290byBubGFfcHV0X2ZhaWx1cmU7Cj4+Pj4+PiArCj4+Pj4+PiArICAg
ICAgICAgICAgIE5MQV9QVVRfU1RSSU5HKG1zZywgVkRQQV9BVFRSX0RFVl9OQU1FLCBuYW1lKTsK
Pj4+Pj4+ICsgICAgICAgICAgICAgTkxBX1BVVF9TVFJJTkcobXNnLCBWRFBBX0FUVFJfTUdNVERF
Vl9ERVZfTkFNRSwgInZkdXNlIik7Cj4+Pj4+PiArICAgICAgICAgICAgIE5MQV9QVVRfVTMyKG1z
ZywgVkRQQV9BVFRSX0RFVl9JRCwgZGV2aWNlX2lkKTsKPj4+Pj4gV2hhdCBhcmUgdGhlIHBlcm1p
c3Npb24vY2FwYWJpbGl0eSByZXF1aXJlbWVudHMgZm9yIFZEVVNFPwo+Pj4+Pgo+Pj4+IE5vdyBJ
IHRoaW5rIHdlIG5lZWQgcHJpdmlsZWdlZCBwZXJtaXNzaW9uIChyb290IHVzZXIpLiBCZWNhdXNl
Cj4+Pj4gdXNlcnNwYWNlIGRhZW1vbiBpcyBhYmxlIHRvIGFjY2VzcyBhdmFpbCB2cmluZywgdXNl
ZCB2cmluZywgZGVzY3JpcHRvcgo+Pj4+IHRhYmxlIGluIGtlcm5lbCBkcml2ZXIgZGlyZWN0bHku
Cj4+PiBQbGVhc2Ugc3RhdGUgdGhpcyBleHBsaWNpdGx5IGF0IHRoZSBzdGFydCBvZiB0aGUgZG9j
dW1lbnQuIEV4aXN0aW5nCj4+PiBpbnRlcmZhY2VzIGxpa2UgRlVTRSBhcmUgZGVzaWduZWQgdG8g
YXZvaWQgdHJ1c3RpbmcgdXNlcnNwYWNlLgo+Pgo+PiBUaGVyZSdyZSBzb21lIHN1YnRsZSBkaWZm
ZXJlbmNlIGhlcmUuIFZEVVNFIHByZXNlbnQgYSBkZXZpY2UgdG8ga2VybmVsIHdoaWNoCj4+IG1l
YW5zIElPTU1VIGlzIHByb2JhYmx5IHRoZSBvbmx5IHRoaW5nIHRvIHByZXZlbnQgYSBtYWxpY291
cyBkZXZpY2UuCj4+Cj4+Cj4+PiBUaGVyZWZvcmUKPj4+IHBlb3BsZSBtaWdodCB0aGluayB0aGUg
c2FtZSBpcyB0aGUgY2FzZSBoZXJlLiBJdCdzIGNyaXRpY2FsIHRoYXQgcGVvcGxlCj4+PiBhcmUg
YXdhcmUgb2YgdGhpcyBiZWZvcmUgZGVwbG95aW5nIFZEVVNFIHdpdGggdmlydGlvLXZkcGEuCj4+
Pgo+Pj4gV2Ugc2hvdWxkIHByb2JhYmx5IHBhdXNlIGhlcmUgYW5kIHRoaW5rIGFib3V0IHdoZXRo
ZXIgaXQncyBwb3NzaWJsZSB0bwo+Pj4gYXZvaWQgdHJ1c3RpbmcgdXNlcnNwYWNlLiBFdmVuIGlm
IGl0IHRha2VzIHNvbWUgZWZmb3J0IGFuZCBjb3N0cyBzb21lCj4+PiBwZXJmb3JtYW5jZSBpdCB3
b3VsZCBwcm9iYWJseSBiZSB3b3J0aHdoaWxlLgo+Pgo+PiBTaW5jZSB0aGUgYm91bmNlIGJ1ZmZl
ciBpcyB1c2VkIHRoZSBvbmx5IGF0dGFjayBzdXJmYWNlIGlzIHRoZSBjb2hlcmVudAo+PiBhcmVh
LCBpZiB3ZSB3YW50IHRvIGVuZm9yY2Ugc3Ryb25nZXIgaXNvbGF0aW9uIHdlIG5lZWQgdG8gdXNl
IHNoYWRvdwo+PiB2aXJ0cXVldWUgKHdoaWNoIGlzIHByb3Bvc2VkIGluIGVhcmxpZXIgdmVyc2lv
biBieSBtZSkgaW4gdGhpcyBjYXNlLiBCdXQgSSdtCj4+IG5vdCBzdXJlIGl0J3Mgd29ydGggdG8g
ZG8gdGhhdC4KPiBUaGUgc2VjdXJpdHkgc2l0dWF0aW9uIG5lZWRzIHRvIGJlIGNsZWFyIGJlZm9y
ZSBtZXJnaW5nIHRoaXMgZmVhdHVyZS4KCgorMQoKCj4KPiBJIHRoaW5rIHRoZSBJT01NVSBhbmQg
dnJpbmcgY2FuIGJlIG1hZGUgc2VjdXJlLiBXaGF0IGlzIG1vcmUgY29uY2VybmluZwo+IGlzIHRo
ZSBrZXJuZWwgY29kZSB0aGF0IHJ1bnMgb24gdG9wOiBWSVJUSU8gZGV2aWNlIGRyaXZlcnMsIG5l
dHdvcmsKPiBzdGFjaywgZmlsZSBzeXN0ZW1zLCBldGMuIFRoZXkgdHJ1c3QgZGV2aWNlcyB0byBh
biBleHRlbnQuCj4KPiBTaW5jZSB2aXJ0aW8tdmRwYSBpcyBhIGJpZyByZWFzb24gZm9yIGRvaW5n
IFZEVVNFIGluIHRoZSBmaXJzdCBwbGFjZSBJCj4gZG9uJ3QgdGhpbmsgaXQgbWFrZXMgc2Vuc2Ug
dG8gZGlzYWJsZSB2aXJ0aW8tdmRwYSB3aXRoIFZEVVNFLiBBIHNvbHV0aW9uCj4gaXMgbmVlZGVk
LgoKClllcywgc28gdGhlIGNhc2Ugb2YgVkRVU0UgaXMgc29tZXRoaW5nIHNpbWlsYXIgdG8gdGhl
IGNhc2Ugb2YgZS5nIFNFVi4KCkJvdGggY2FzZXMgd29uJ3QgdHJ1c3QgZGV2aWNlIGFuZCB1c2Ug
c29tZSBraW5kIG9mIHNvZnR3YXJlIElPVExCLgoKVGhhdCBtZWFucyB3ZSBuZWVkIHRvIHByb3Rl
Y3QgYXQgYm90aCBJT1RMQiBhbmQgdmlydGlvIGRyaXZlcnMuCgpMZXQgbWUgcG9zdCBwYXRjaGVz
IGZvciB2aXJ0aW8gZmlyc3QuCgoKPgo+IEknbSBnb2luZyB0byBiZSBvZmZsaW5lIGZvciBhIHdl
ZWsgYW5kIGRvbid0IHdhbnQgdG8gYmUgYSBib3R0bGVuZWNrLgo+IEknbGwgY2F0Y2ggdXAgd2hl
biBJJ20gYmFjay4KCgpUaGFua3MgYSBsb3QgZm9yIGNvbW1lbnRzIGFuZCBJIHRoaW5rIHdlIGhh
ZCBzdWZmaWNlbnQgdGltZSB0byBtYWtlIApWRFVTRSBzYWZlIGJlZm9yZSBtZXJnaW5nLgoKCj4K
PiBTdGVmYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
