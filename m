Return-Path: <SRS0=bMq5=D5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649DC55179
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 03:22:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0769208B6
	for <virtualization@archiver.kernel.org>; Thu, 22 Oct 2020 03:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbQJeNhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0769208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 357F7874E9;
	Thu, 22 Oct 2020 03:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSBQE6bDY8Ml; Thu, 22 Oct 2020 03:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47F6E87493;
	Thu, 22 Oct 2020 03:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39731C08A1;
	Thu, 22 Oct 2020 03:22:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ACF7C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 03:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 791FC874C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 03:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-mqrijZc-L9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 03:22:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 710BA87493
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 03:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603336970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcNyG5kZlVTOvNSi+KB5ie4eDdxWcxoVSBpvVyq9VHY=;
 b=ZbQJeNhDW3BKu+9dfJLkjmT2JRCsRtb9X8LhZG40Wy7qvmt4d5E9uscSgq1SNwcrV+/REw
 +DnNG+t/zZAocIVLbSOoobsdazsKEHtjeOlcxp/qSAkhZwu63gZAW5kmUUAw0CHuAWlKLS
 heOnUtKI+SizXdhKwkufo4jBQ7njLMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-nLIADEqzMoSH34_WQJdXzg-1; Wed, 21 Oct 2020 23:22:45 -0400
X-MC-Unique: nLIADEqzMoSH34_WQJdXzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9AEC5F9C2;
 Thu, 22 Oct 2020 03:22:43 +0000 (UTC)
Received: from [10.72.13.119] (ovpn-13-119.pek2.redhat.com [10.72.13.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4CC5D9DD;
 Thu, 22 Oct 2020 03:22:32 +0000 (UTC)
Subject: Re: [PATCH v4] Revert "virtio-net: ethtool configurable RXCSUM"
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20201021142944.13615-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <807f793c-70ff-072c-c8d8-a4ca06eba2c6@redhat.com>
Date: Thu, 22 Oct 2020 11:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021142944.13615-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Willem de Bruijn <willemb@google.com>, kernel test robot <lkp@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
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

Ck9uIDIwMjAvMTAvMjEg5LiL5Y2IMTA6MzAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBU
aGlzIHJldmVydHMgY29tbWl0IDM2MThhZDJhN2MwZTc4ZTQyNTgzODYzOTRkNWQ1ZjkyYTNkYmNj
ZjguCj4KPiBXaGVuIGNvbnRyb2wgdnEgaXMgbm90IG5lZ290aWF0ZWQsIHRoYXQgY29tbWl0IGNh
dXNlcyBhIGNyYXNoOgo+Cj4gWyAgIDcyLjIyOTE3MV0ga2VybmVsIEJVRyBhdCBkcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmM6MTY2NyEKPiBbICAgNzIuMjMwMjY2XSBpbnZhbGlkIG9wY29kZTogMDAw
MCBbIzFdIFBSRUVNUFQgU01QCj4gWyAgIDcyLjIzMTE3Ml0gQ1BVOiAwIFBJRDogMSBDb21tOiBz
d2FwcGVyLzAgTm90IHRhaW50ZWQgNS45LjAtcmM4LTAyOTM0LWczNjE4YWQyYTdjMGU3ICMxCj4g
WyAgIDcyLjIzMTE3Ml0gRUlQOiB2aXJ0bmV0X3NlbmRfY29tbWFuZCsweDEyMC8weDE0MAo+IFsg
ICA3Mi4yMzExNzJdIENvZGU6IDAwIDBmIDk0IGMwIDhiIDdkIGYwIDY1IDMzIDNkIDE0IDAwIDAw
IDAwIDc1IDFjIDhkIDY1IGY0IDViIDVlIDVmIDVkIGMzIDY2IDkwIGJlIDAxIDAwIDAwIDAwIGU5
IDZlIGZmIGZmIGZmIDhkIGI2IDAwCj4gKzAwIDAwIDAwIDwwZj4gMGIgZTggZDkgYmIgODIgMDAg
ZWIgMTcgOGQgYjQgMjYgMDAgMDAgMDAgMDAgOGQgYjQgMjYgMDAgMDAgMDAKPiBbICAgNzIuMjMx
MTcyXSBFQVg6IDAwMDAwMDBkIEVCWDogZjcyODk1YzAgRUNYOiAwMDAwMDAxNyBFRFg6IDAwMDAw
MDExCj4gWyAgIDcyLjIzMTE3Ml0gRVNJOiBmNzE5NzgwMCBFREk6IGVkNjliZDAwIEVCUDogZWQ2
OWJjZjQgRVNQOiBlZDY5YmM5OAo+IFsgICA3Mi4yMzExNzJdIERTOiAwMDdiIEVTOiAwMDdiIEZT
OiAwMGQ4IEdTOiAwMGUwIFNTOiAwMDY4IEVGTEFHUzogMDAwMTAyNDYKPiBbICAgNzIuMjMxMTcy
XSBDUjA6IDgwMDUwMDMzIENSMjogMDAwMDAwMDAgQ1IzOiAwMmM4NDAwMCBDUjQ6IDAwMDQwNmYw
Cj4gWyAgIDcyLjIzMTE3Ml0gQ2FsbCBUcmFjZToKPiBbICAgNzIuMjMxMTcyXSAgPyBfX3ZpcnRf
YWRkcl92YWxpZCsweDQ1LzB4NjAKPiBbICAgNzIuMjMxMTcyXSAgPyBfX19jYWNoZV9mcmVlKzB4
NTFmLzB4NzYwCj4gWyAgIDcyLjIzMTE3Ml0gID8ga29iamVjdF91ZXZlbnRfZW52KzB4ZjQvMHg1
NjAKPiBbICAgNzIuMjMxMTcyXSAgdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMrMHg0ZC8weDgw
Cj4gWyAgIDcyLjIzMTE3Ml0gIHZpcnRuZXRfc2V0X2ZlYXR1cmVzKzB4ODUvMHgxMjAKPiBbICAg
NzIuMjMxMTcyXSAgPyB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2FkcysweDgwLzB4ODAKPiBbICAg
NzIuMjMxMTcyXSAgX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4MjdhLzB4OGUwCj4gWyAgIDcy
LjIzMTE3Ml0gID8ga29iamVjdF91ZXZlbnQrMHhhLzB4MjAKPiBbICAgNzIuMjMxMTcyXSAgPyBu
ZXRkZXZfcmVnaXN0ZXJfa29iamVjdCsweDEyYy8weDE2MAo+IFsgICA3Mi4yMzExNzJdICByZWdp
c3Rlcl9uZXRkZXZpY2UrMHg0ZmUvMHg3NDAKPiBbICAgNzIuMjMxMTcyXSAgcmVnaXN0ZXJfbmV0
ZGV2KzB4MWMvMHg0MAo+IFsgICA3Mi4yMzExNzJdICB2aXJ0bmV0X3Byb2JlKzB4NzI4LzB4YjYw
Cj4gWyAgIDcyLjIzMTE3Ml0gID8gX3Jhd19zcGluX3VubG9jaysweDFkLzB4NDAKPiBbICAgNzIu
MjMxMTcyXSAgPyB2aXJ0aW9fdmRwYV9nZXRfc3RhdHVzKzB4MWMvMHgyMAo+IFsgICA3Mi4yMzEx
NzJdICB2aXJ0aW9fZGV2X3Byb2JlKzB4MWM2LzB4MjcxCj4gWyAgIDcyLjIzMTE3Ml0gIHJlYWxs
eV9wcm9iZSsweDE5NS8weDJlMAo+IFsgICA3Mi4yMzExNzJdICBkcml2ZXJfcHJvYmVfZGV2aWNl
KzB4MjYvMHg2MAo+IFsgICA3Mi4yMzExNzJdICBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDQ5LzB4
NjAKPiBbICAgNzIuMjMxMTcyXSAgX19kcml2ZXJfYXR0YWNoKzB4NDYvMHhjMAo+IFsgICA3Mi4y
MzExNzJdICA/IGRldmljZV9kcml2ZXJfYXR0YWNoKzB4NjAvMHg2MAo+IFsgICA3Mi4yMzExNzJd
ICBidXNfYWRkX2RyaXZlcisweDE5Ny8weDFjMAo+IFsgICA3Mi4yMzExNzJdICBkcml2ZXJfcmVn
aXN0ZXIrMHg2Ni8weGMwCj4gWyAgIDcyLjIzMTE3Ml0gIHJlZ2lzdGVyX3ZpcnRpb19kcml2ZXIr
MHgxYi8weDQwCj4gWyAgIDcyLjIzMTE3Ml0gIHZpcnRpb19uZXRfZHJpdmVyX2luaXQrMHg2MS8w
eDg2Cj4gWyAgIDcyLjIzMTE3Ml0gID8gdmV0aF9pbml0KzB4MTQvMHgxNAo+IFsgICA3Mi4yMzEx
NzJdICBkb19vbmVfaW5pdGNhbGwrMHg3Ni8weDJlNAo+IFsgICA3Mi4yMzExNzJdICA/IHJkaW5p
dF9zZXR1cCsweDJhLzB4MmEKPiBbICAgNzIuMjMxMTcyXSAgZG9faW5pdGNhbGxzKzB4YjIvMHhk
NQo+IFsgICA3Mi4yMzExNzJdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDE0Zi8weDE3OQo+IFsg
ICA3Mi4yMzExNzJdICA/IHJlc3RfaW5pdCsweDEwMC8weDEwMAo+IFsgICA3Mi4yMzExNzJdICBr
ZXJuZWxfaW5pdCsweGQvMHhlMAo+IFsgICA3Mi4yMzExNzJdICByZXRfZnJvbV9mb3JrKzB4MWMv
MHgzMAo+IFsgICA3Mi4yMzExNzJdIE1vZHVsZXMgbGlua2VkIGluOgo+IFsgICA3Mi4yNjk1NjNd
IC0tLVsgZW5kIHRyYWNlIGE2ZWJjNGFmZWEwZTZjYjEgXS0tLQo+Cj4gVGhlIHJlYXNvbiBpcyB0
aGF0IHZpcnRuZXRfc2V0X2ZlYXR1cmVzIG5vdyBjYWxscyB2aXJ0bmV0X3NldF9ndWVzdF9vZmZs
b2Fkcwo+IHVuY29uZGl0aW9uYWxseSwgaXQgdXNlZCB0byBvbmx5IGNhbGwgaXQgd2hlbiB0aGVy
ZSBpcyBzb21ldGhpbmcKPiB0byBjb25maWd1cmUuCj4KPiBJZiBkZXZpY2UgZG9lcyBub3QgaGF2
ZSBhIGNvbnRyb2wgdnEsIGV2ZXJ5dGhpbmcgYnJlYWtzLgo+Cj4gUmV2ZXJ0IHRoZSBvcmlnaW5h
bCBjb21taXQgZm9yIG5vdy4KPgo+IENjOiBUb25naGFvIFpoYW5nIDx4aWFuZ3hpYS5tLnl1ZUBn
bWFpbC5jb20+Cj4gQ2M6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPiBG
aXhlczogMzYxOGFkMmE3YzBlNyAoInZpcnRpby1uZXQ6IGV0aHRvb2wgY29uZmlndXJhYmxlIFJY
Q1NVTSIpCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gLS0t
CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPgo+Cj4gU2Ft
ZSBwYXRjaCBhcyBhbGwgb2YgdjEtdjMsIGp1c3QgdHdlYWtpbmcgdGhlIGNvbW1pdCBsb2cuCj4K
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUwICsrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAz
NyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBkMmQyYzRhNTNjZjIuLjIxYjcxMTQ4
YzUzMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNjgsOCArNjgsNiBAQCBzdGF0aWMgY29uc3QgdW5z
aWduZWQgbG9uZyBndWVzdF9vZmZsb2Fkc1tdID0gewo+ICAgCQkJCSgxVUxMIDw8IFZJUlRJT19O
RVRfRl9HVUVTVF9FQ04pICB8IFwKPiAgIAkJCQkoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfR1VFU1Rf
VUZPKSkKPiAgIAo+IC0jZGVmaW5lIEdVRVNUX09GRkxPQURfQ1NVTV9NQVNLICgxVUxMIDw8IFZJ
UlRJT19ORVRfRl9HVUVTVF9DU1VNKQo+IC0KPiAgIHN0cnVjdCB2aXJ0bmV0X3N0YXRfZGVzYyB7
Cj4gICAJY2hhciBkZXNjW0VUSF9HU1RSSU5HX0xFTl07Cj4gICAJc2l6ZV90IG9mZnNldDsKPiBA
QCAtMjUyNCw0OCArMjUyMiwyOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfZ2V0X3BoeXNfcG9ydF9u
YW1lKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGNoYXIgKmJ1ZiwKPiAgIAlyZXR1cm4gMDsKPiAg
IH0KPiAgIAo+IC1zdGF0aWMgbmV0ZGV2X2ZlYXR1cmVzX3QgdmlydG5ldF9maXhfZmVhdHVyZXMo
c3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwKPiAtCQkJCQkgICAgICBuZXRkZXZfZmVhdHVyZXNf
dCBmZWF0dXJlcykKPiAtewo+IC0JLyogSWYgUnggY2hlY2tzdW0gaXMgZGlzYWJsZWQsIExSTyBz
aG91bGQgYWxzbyBiZSBkaXNhYmxlZC4gKi8KPiAtCWlmICghKGZlYXR1cmVzICYgTkVUSUZfRl9S
WENTVU0pKQo+IC0JCWZlYXR1cmVzICY9IH5ORVRJRl9GX0xSTzsKPiAtCj4gLQlyZXR1cm4gZmVh
dHVyZXM7Cj4gLX0KPiAtCj4gICBzdGF0aWMgaW50IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCj4gICAJCQkJbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMpCj4g
ICB7Cj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+IC0J
dTY0IG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzOwo+ICsJdTY0IG9mZmxvYWRzOwo+ICAg
CWludCBlcnI7Cj4gICAKPiAtCS8qIERvbid0IGFsbG93IGNvbmZpZ3VyYXRpb24gd2hpbGUgWERQ
IGlzIGFjdGl2ZS4gKi8KPiAtCWlmICh2aS0+eGRwX3F1ZXVlX3BhaXJzKQo+IC0JCXJldHVybiAt
RUJVU1k7Cj4gLQo+ICAgCWlmICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0Zf
TFJPKSB7Cj4gKwkJaWYgKHZpLT54ZHBfcXVldWVfcGFpcnMpCj4gKwkJCXJldHVybiAtRUJVU1k7
Cj4gKwo+ICAgCQlpZiAoZmVhdHVyZXMgJiBORVRJRl9GX0xSTykKPiAtCQkJb2ZmbG9hZHMgfD0g
R1VFU1RfT0ZGTE9BRF9MUk9fTUFTSyAmCj4gLQkJCQkgICAgdmktPmd1ZXN0X29mZmxvYWRzX2Nh
cGFibGU7Cj4gKwkJCW9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGU7Cj4gICAJ
CWVsc2UKPiAtCQkJb2ZmbG9hZHMgJj0gfkdVRVNUX09GRkxPQURfTFJPX01BU0s7Cj4gKwkJCW9m
ZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgo+ICsJCQkJICAgfkdVRVNUX09G
RkxPQURfTFJPX01BU0s7Cj4gKwo+ICsJCWVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRz
KHZpLCBvZmZsb2Fkcyk7Cj4gKwkJaWYgKGVycikKPiArCQkJcmV0dXJuIGVycjsKPiArCQl2aS0+
Z3Vlc3Rfb2ZmbG9hZHMgPSBvZmZsb2FkczsKPiAgIAl9Cj4gICAKPiAtCWlmICgoZGV2LT5mZWF0
dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0ZfUlhDU1VNKSB7Cj4gLQkJaWYgKGZlYXR1cmVzICYg
TkVUSUZfRl9SWENTVU0pCj4gLQkJCW9mZmxvYWRzIHw9IEdVRVNUX09GRkxPQURfQ1NVTV9NQVNL
ICYKPiAtCQkJCSAgICB2aS0+Z3Vlc3Rfb2ZmbG9hZHNfY2FwYWJsZTsKPiAtCQllbHNlCj4gLQkJ
CW9mZmxvYWRzICY9IH5HVUVTVF9PRkZMT0FEX0NTVU1fTUFTSzsKPiAtCX0KPiAtCj4gLQllcnIg
PSB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2Fkcyh2aSwgb2ZmbG9hZHMpOwo+IC0JaWYgKGVycikK
PiAtCQlyZXR1cm4gZXJyOwo+IC0KPiAtCXZpLT5ndWVzdF9vZmZsb2FkcyA9IG9mZmxvYWRzOwo+
ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gQEAgLTI1ODQsNyArMjU2Myw2IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgdmlydG5ldF9uZXRkZXYgPSB7Cj4gICAJLm5kb19m
ZWF0dXJlc19jaGVjawk9IHBhc3N0aHJ1X2ZlYXR1cmVzX2NoZWNrLAo+ICAgCS5uZG9fZ2V0X3Bo
eXNfcG9ydF9uYW1lCT0gdmlydG5ldF9nZXRfcGh5c19wb3J0X25hbWUsCj4gICAJLm5kb19zZXRf
ZmVhdHVyZXMJPSB2aXJ0bmV0X3NldF9mZWF0dXJlcywKPiAtCS5uZG9fZml4X2ZlYXR1cmVzCT0g
dmlydG5ldF9maXhfZmVhdHVyZXMsCj4gICB9Owo+ICAgCj4gICBzdGF0aWMgdm9pZCB2aXJ0bmV0
X2NvbmZpZ19jaGFuZ2VkX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+IEBAIC0zMDM1
LDEwICszMDEzLDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ICAgCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9G
X0dVRVNUX1RTTzQpIHx8Cj4gICAJICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9f
TkVUX0ZfR1VFU1RfVFNPNikpCj4gICAJCWRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9MUk87Cj4g
LQlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09G
RkxPQURTKSkgewo+IC0JCWRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9SWENTVU07Cj4gKwlp
ZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxP
QURTKSkKPiAgIAkJZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKPiAtCX0KPiAgIAo+
ICAgCWRldi0+dmxhbl9mZWF0dXJlcyA9IGRldi0+ZmVhdHVyZXM7Cj4gICAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
