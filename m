Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D425C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:28:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362B861245
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362B861245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFB9E40F57;
	Wed,  7 Apr 2021 07:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mEnYKqhV9R0j; Wed,  7 Apr 2021 07:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 402D640250;
	Wed,  7 Apr 2021 07:28:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACB8C000C;
	Wed,  7 Apr 2021 07:28:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 802C5C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 614B040F59
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8o6sPZ07c4L
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C57640250
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617780521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swKYyFWZ2NQI8c+tMKAJbbNycuDshpSwBHM+3qxUY58=;
 b=cDRIgrRkY8nPKsu7LLPSqIUd4cxWz9/7fQG3k76Wq766Ly9+hfjSeC1VJtMpwqCNH08GpG
 ICGjt6L1xJd/EsQaGL07gelo2BYZmGsiULyPys6rVBHGNt67KZevl+GsM+8cwDFJAF1ry9
 iI80ceAD93XZTH/u2jioxf8Jecv3WiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-GGspCooHMf6rgmxfqJ9UPw-1; Wed, 07 Apr 2021 03:28:39 -0400
X-MC-Unique: GGspCooHMf6rgmxfqJ9UPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0BE1005D4F;
 Wed,  7 Apr 2021 07:28:38 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 964956A044;
 Wed,  7 Apr 2021 07:28:33 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 00/14] vdpa: Enable user to set mac address, 
 mtu
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <438c74dc-6cdf-0278-8dcd-27a75f07dbc3@redhat.com>
Date: Wed, 7 Apr 2021 15:28:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBDdXJyZW50bHkgdXNl
ciBjYW5ub3Qgc2V0IHRoZSBtYWMgYWRkcmVzcyBhbmQgbXR1IG9mIHRoZSB2ZHBhIGRldmljZS4K
PiBUaGlzIHBhdGNoc2V0IGVuYWJsZXMgdXNlcnMgdG8gc2V0IHRoZSBtYWMgYWRkcmVzcyBhbmQg
bXR1IG9mIHRoZSB2ZHBhCj4gZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVkLgo+IElm
IGEgdmVuZG9yIGRyaXZlciBzdXBwb3J0cyBzdWNoIGNvbmZpZ3VyYXRpb24gdXNlciBjYW4gc2V0
IGl0IG90aGVyd2lzZQo+IHVzZXIgZ2V0cyB1bnN1cHBvcnRlZCBlcnJvci4KPgo+IHZkcGEgbWFj
IGFkZHJlc3MgYW5kIG10dSBhcmUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gbGF5b3V0IGZpZWxkcy4K
PiBUbyBrZWVwIGludGVyZmFjZSBnZW5lcmljIGVub3VnaCBmb3IgbXVsdGlwbGUgdHlwZXMgb2Yg
dmRwYSBkZXZpY2VzLCBtYWMKPiBhZGRyZXNzIGFuZCBtdHUgc2V0dGluZyBpcyBpbXBsZW1lbnRl
ZCBhcyBjb25maWd1cmF0aW9uIGxheW91dCBjb25maWcKPiBrbm9icy4KPiBUaGlzIGVuYWJsZXMg
dG8gdXNlIHNpbWlsYXIgY29uZmlnIGxheW91dCBmb3Igb3RoZXIgdmlydGlvIGRldmljZXMuCj4K
PiBBbiBleGFtcGxlIG9mIHF1ZXJ5ICYgc2V0IG9mIGNvbmZpZyBsYXlvdXQgZmllbGRzIGZvciB2
ZHBhX3NpbV9uZXQKPiBkcml2ZXI6Cj4KPiBDb25maWd1cmF0aW9uIGxheW91dCBmaWVsZHMgYXJl
IHNldCBhZnRlciBkZXZpY2UgaXMgY3JlYXRlZC4KPiBUaGlzIGVuYWJsZXMgdXNlciB0byBjaGFu
Z2Ugc3VjaCBmaWVsZHMgYXQgbGF0ZXIgcG9pbnQgd2l0aG91dCBkZXN0cm95aW5nIGFuZAo+IHJl
Y3JlYXRpbmcgdGhlIGRldmljZSBmb3IgbmV3IGNvbmZpZy4KPgo+ICQgdmRwYSBtZ210ZGV2IHNo
b3cKPiB2ZHBhc2ltX25ldDoKPiAgICBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPgo+IEFkZCB0aGUg
ZGV2aWNlOgo+ICQgdmRwYSBkZXYgYWRkIG5hbWUgYmFyIG1nbXRkZXYgdmRwYXNpbV9uZXQKPgo+
IENvbmZpZ3VyZSBtYWMgYWRkcmVzcyBhbmQgbXR1Ogo+ICQgdmRwYSBkZXYgY29uZmlnIHNldCBi
YXIgbWFjIDAwOjExOjIyOjMzOjQ0OjU1IG10dSA5MDAwCj4KPiBJbiBhYm92ZSBjb21tYW5kIG9u
bHkgbWFjIGFkZHJlc3Mgb3Igb25seSBtdHUgY2FuIGFsc28gYmUgc2V0Lgo+Cj4gVmlldyB0aGUg
Y29uZmlnIGFmdGVyIHNldHRpbmc6Cj4gJCB2ZHBhIGRldiBjb25maWcgc2hvdwo+IGJhcjogbWFj
IDAwOjExOjIyOjMzOjQ0OjU1IGxpbmsgdXAgbGlua19hbm5vdW5jZSBmYWxzZSBtdHUgOTAwMCBz
cGVlZCAwIGR1cGxleCAwCj4KPiBQYXRjaCBzdW1tYXJ5Ogo+IFBhdGNoLTEgZml4IGtkb2Mgc3R5
bGUgY29tbWVudHMKPiBQYXRjaC0yIGZpeCBrZG9jIHN0eWxlIGNvbW1lbnRzCj4gUGF0Y2gtMyBp
bnRyb2R1Y2VkIGFuZCB1c2UgaGVscGVycyBmb3IgZ2V0L3NldCBjb25maWcgYW5kIGZlYXR1cmVz
Cj4gUGF0Y2gtNCBpbXBsZW1lbnQgcXVlcnkgZGV2aWNlIGNvbmZpZyBsYXlvdXQKPiBQYXRjaC01
IGVuYW5ibGUgdXNlciB0byBzZXQgbWFjIGFuZCBtdHUgaW4gY29uZmlnIHNwYWNlCj4gUGF0Y2gt
NiB2ZHBhX3NpbV9uZXQgaW1wbGVtZW50cyBnZXQgYW5kIHNldCBvZiBjb25maWcgbGF5b3V0Cj4g
UGF0Y2gtNyBtbHg1IHZkcGEgZHJpdmVyIHVzZSByaWdodCBkbWEgZGV2aWNlIGZvciBQQ0kgUEYs
VkYsU0YKPiBQYXRjaC04IG1seDUgdmRwYSBkcml2ZXIgdXNlcyByaWdodCBCQVIgb2Zmc2V0IGZv
ciBTRgo+IFBhdGNoLTkgbWx4NSB2ZHBhIGRyaXZlciBtaWdyYXRlcyB0byB1c2VyIGNyZWF0ZWQg
dmRwYSBkZXZpY2UKPiBQYXRjaC0xMCBtbHg1IHZkcGEgZHJpdmVyIHN1cHBvcnRzIHVzZXIgcHJv
dmlkZWQgbWFjIGNvbmZpZwo+IFBhdGNoLTExIG1seDUgdmRwYSBkcml2ZXIgdXNlcyB1c2VyIHBy
b3ZpZGVkIG1hYyBkdXJpbmcgcnggZmxvdyBzdGVlcmluZwo+IFBhdGNoLTEyIG1seDUgdmRwYSBk
cml2ZXIgZXhjbHVkZXMgaGVhZGVyIGxlbmd0aCBhbmQgZmNzCj4gUGF0Y2gtMTMgbWx4NSB2ZHBh
IGRyaXZlciBmaXhlcyBpbmRleCByZXN0b3JhdGlvbiBkdXJpbmcgc3VzcGVuZCByZXN1bWUKPiBQ
YXRjaC0xNCBtbHg1IHZkcGEgZHJpdmVyIGZpeGVzIGJpdCB1c2FnZQoKCkhpIFBhcmF2OgoKSSB0
aGluayBzb21lIG9mIHRoZSBjb2RlcyBzaG91bGQgYmUgc2VudCBpbmRlcGVuZGVudGx5OiBwYXRj
aCA3LTgsIApwYXRjaDEzLTE0IGFyZSBuZWVkZWQgZm9yIC1zdGFibGUuCgpUaGFua3MKCgo+Cj4g
Y2hhbmdlbG9nOgo+IHYxLT52MjoKPiAgIC0gbmV3IHBhdGNoZXMgdG8gZml4IGtkb2MgY29tbWVu
dCB0byBhZGQgbmV3IGtkb2Mgc2VjdGlvbgo+ICAgLSBuZXcgcGF0Y2ggdG8gaGF2ZSBzeW5jaHJv
bml6ZWQgYWNjZXNzIHRvIGZlYXR1cmVzIGFuZCBjb25maWcgc3BhY2UKPiAgIC0gcmVhZCB3aG9s
ZSBuZXQgY29uZmlnIGxheW91dCBpbnN0ZWFkIG9mIGluZGl2aWR1YWwgZmllbGRzCj4gICAtIGFk
ZGVkIGVycm9yIGV4dGFjayBmb3IgdW5tYW5hZ2VkIHZkcGEgZGV2aWNlCj4gICAtIGZpeGVkIHNl
dmVyYWwgZW5kaWFubmVzcyBpc3N1ZXMKPiAgIC0gaW50cm9kdWNlZCB2ZHBhIGRldmljZSBvcHMg
Zm9yIGdldCBjb25maWcgd2hpY2ggaXMgc3luY2hyb25pemVkCj4gICAgIHdpdGggb3RoZXIgZ2V0
L3NldCBmZWF0dXJlcyBvcHMgYW5kIGNvbmZpZyBvcHMKPiAgIC0gZml4ZWQgbXR1IHJhbmdlIGNo
ZWNraW5nIGZvciBtYXgKPiAgIC0gdXNpbmcgTkxBX1BPTElDWV9FVEhfQUREUgo+ICAgLSBzZXQg
Y29uZmlnIG1vdmVkIHRvIGRldmljZSBvcHMgaW5zdGVhZCBvZiBtZ210ZGV2IG9wcwo+ICAgLSBt
ZXJnZWQgYnVpbGQgYW5kIHNldCB0byBzaW5nbGUgcm91dGluZQo+ICAgLSBlbnN1cmluZyB0aGF0
IHVzZXIgaGFzIE5FVF9BRE1JTiBjYXBhYmlsaXR5IGZvciBjb25maWd1cmluZyBuZXR3b3JrCj4g
ICAgIGF0dHJpYnV0ZXMKPiAgIC0gdXNpbmcgdXBkYXRlZCBpbnRlcmZhY2UgYW5kIGNhbGxiYWNr
cyBmb3IgZ2V0L3NldCBjb25maWcKPiAgIC0gZm9sbG93aW5nIG5ldyBhcGkgZm9yIGNvbmZpZyBn
ZXQvc2V0IGZvciBtZ210IHRvb2wgaW4gbWx4NSB2ZHBhCj4gICAgIGRyaXZlcgo+ICAgLSBmaXhl
cyBmb3IgYWNjZXNzaW5nIHJpZ2h0IFNGIGRtYSBkZXZpY2UgYW5kIGJhciBhZGRyZXNzCj4gICAt
IGZpeCBmb3IgbXR1IGNhbGN1bGF0aW9uCj4gICAtIGZpeCBmb3IgYml0IGFjY2VzcyBpbiBmZWF0
dXJlcwo+ICAgLSBmaXggZm9yIGluZGV4IHJlc3RvcmUgd2l0aCBzdXNwZW5kL3Jlc3VtZSBvcGVy
YXRpb24KPgo+IEVsaSBDb2hlbiAoNyk6Cj4gICAgdmRwYS9tbHg1OiBVc2UgdGhlIGNvcnJlY3Qg
ZG1hIGRldmljZSB3aGVuIHJlZ2lzdGVyaW5nIG1lbW9yeQo+ICAgIHZkcGEvbWx4NTogUmV0cmll
dmUgQkFSIGFkZHJlc3Mgc3VpdGFibGUgYW55IGZ1bmN0aW9uCj4gICAgdmRwYS9tbHg1OiBFbmFi
bGUgdXNlciB0byBhZGQvZGVsZXRlIHZkcGEgZGV2aWNlCj4gICAgdmRwYS9tbHg1OiBTdXBwb3J0
IGNvbmZpZ3VyYXRpb24gb2YgTUFDCj4gICAgdmRwYS9tbHg1OiBGb3J3YXJkIG9ubHkgcGFja2V0
cyB3aXRoIGFsbG93ZWQgTUFDIGFkZHJlc3MKPiAgICB2ZHBhL21seDU6IEZpeCBzdXNwZW5kL3Jl
c3VtZSBpbmRleCByZXN0b3JhdGlvbgo+ICAgIHZkcGEvbWx4NTogRml4IHdyb25nIHVzZSBvZiBi
aXQgbnVtYmVycwo+Cj4gUGFyYXYgUGFuZGl0ICg2KToKPiAgICB2ZHBhOiBGb2xsb3cga2RvYyBj
b21tZW50IHN0eWxlCj4gICAgdmRwYTogRm9sbG93IGtkb2MgY29tbWVudCBzdHlsZQo+ICAgIHZk
cGE6IEludHJvZHVjZSBhbmQgdXNlIHZkcGEgZGV2aWNlIGdldCxzZXQgY29uZmlnLCBmZWF0dXJl
cyBoZWxwZXJzCj4gICAgdmRwYTogSW50cm9kdWNlIHF1ZXJ5IG9mIGRldmljZSBjb25maWcgbGF5
b3V0Cj4gICAgdmRwYTogRW5hYmxlIHVzZXIgdG8gc2V0IG1hYyBhbmQgbXR1IG9mIHZkcGEgZGV2
aWNlCj4gICAgdmRwYV9zaW1fbmV0OiBFbmFibGUgdXNlciB0byBzZXQgbWFjIGFkZHJlc3MgYW5k
IG10dQo+Cj4gU2ktV2VpIExpdSAoMSk6Cj4gICAgdmRwYS9tbHg1OiBzaG91bGQgZXhjbHVkZSBo
ZWFkZXIgbGVuZ3RoIGFuZCBmY3MgZnJvbSBtdHUKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaCAgIHwgICA0ICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAg
ICAgICAgICB8ICAgOSArLQo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYyAg
IHwgICAzICstCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgICAgfCAyNjQg
KysrKysrKysrKysrKystLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jICAgICAgICAgICAgICAg
ICAgfCAzODMgKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICBkcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYyAgICAgfCAgMjYgKysKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5oICAgICB8ICAgNCArCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
bmV0LmMgfCAgMzkgKy0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICAgICAg
fCAgIDYgKy0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICAgICB8IDEyMyAr
KysrKystLS0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC92ZHBhLmggICAgICAgICAgICB8ICAxMiAr
Cj4gICAxMSBmaWxlcyBjaGFuZ2VkLCA3NTIgaW5zZXJ0aW9ucygrKSwgMTIxIGRlbGV0aW9ucygt
KQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
