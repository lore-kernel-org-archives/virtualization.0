Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A2C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:51:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A56A64DBA
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A56A64DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C351642D19;
	Mon,  1 Mar 2021 07:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id diGpQbOPgRHv; Mon,  1 Mar 2021 07:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 492B2414EF;
	Mon,  1 Mar 2021 07:51:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A02EC000B;
	Mon,  1 Mar 2021 07:51:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E675C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1692E4F2A2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWJ5jXDS0OVV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87FE04F2A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614585074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRD01fD7jZO6lfYYtJCH4lu7HgZOAsRRQIl7A9rTpME=;
 b=HUFb3L6yy7OumQwFPRbK3FRnX+ZHj+yQwHp2OS2tEI8HUcg0gCrn9ygj6GZCO1vTUZG1tw
 IinqVmg58NeUtqbM7H7HMB3TwVymSPSHO8hUpUMTR2pIltsxenAWAE67RlzAKXbk2ekjgI
 8gAmow7o9/03VKYg6zJuEHmn020k844=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-V9Fr30i8Op2BT8z4bhJkSQ-1; Mon, 01 Mar 2021 02:51:10 -0500
X-MC-Unique: V9Fr30i8Op2BT8z4bhJkSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756961014BFA;
 Mon,  1 Mar 2021 07:51:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com
 [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 175916EF40;
 Mon,  1 Mar 2021 07:50:59 +0000 (UTC)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
 <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bbed2011-b0f7-82ba-0e85-0ee455595e5e@redhat.com>
Date: Mon, 1 Mar 2021 15:50:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Sean Mooney <smooney@redhat.com>, "mst@redhat.com" <mst@redhat.com>
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

Ck9uIDIwMjEvMy8xIDM6Mjkg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4KPj4gRnJvbTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogTW9uZGF5LCBNYXJjaCAx
LCAyMDIxIDk6MjkgQU0KPj4KPj4gT24gMjAyMS8yLzI2IDQ6NTAg5LiL5Y2ILCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4+Pj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+
PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDI2LCAyMDIxIDE6NTYgUE0KPj4+Pgo+Pj4+Cj4+Pj4g
T24gMjAyMS8yLzI2IDE6MzIg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+PiBGcm9t
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4gU2VudDogV2VkbmVzZGF5
LCBGZWJydWFyeSAyNCwgMjAyMSAyOjE4IFBNCj4+Pj4+Pgo+Pj4+Pj4gT24gMjAyMS8yLzI0IDI6
MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsJaWYgKG5s
YV9wdXRfdTE2KG1zZywKPj4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsCj4+Pj4+Pj4g
KwkJCWNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9wYWlycykpCj4+Pj4+Pj4gKwkJcmV0dXJuIC1FTVNH
U0laRTsKPj4+Pj4+IFdlIHByb2JhYmx5IG5lZWQgdG8gY2hlY2sgVklSVElPX05FVF9GX1JTUyBo
ZXJlLgo+Pj4+PiBZZXMuIFdpbGwgdXNlIGl0IGluIHYyLgo+Pj4+Pgo+Pj4+Pj4+ICsJaWYgKG5s
YV9wdXRfdTgobXNnLAo+PiBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLAo+
Pj4+Pj4+ICsJCSAgICAgICBjb25maWctPnJzc19tYXhfa2V5X3NpemUpKQo+Pj4+Pj4+ICsJCXJl
dHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsJcnNzX2ZpZWxkID0gbGUxNl90b19j
cHUoY29uZmlnLT5yc3NfbWF4X2tleV9zaXplKTsKPj4+Pj4+PiArCWlmIChubGFfcHV0X3UxNiht
c2csCj4+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfTUFYX0lUX0xFTiwKPj4+Pj4+IHJzc19m
aWVsZCkpCj4+Pj4+Pj4gKwkJcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKwlo
YXNoX3R5cGVzID0gbGUzMl90b19jcHUoY29uZmlnLT5zdXBwb3J0ZWRfaGFzaF90eXBlcyk7Cj4+
Pj4+Pj4gKwlpZiAobmxhX3B1dF91MzIobXNnLAo+PiBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNT
X0hBU0hfVFlQRVMsCj4+Pj4+Pj4gKwkJCWNvbmZpZy0+c3VwcG9ydGVkX2hhc2hfdHlwZXMpKQo+
Pj4+Pj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4gKwlyZXR1cm4gMDsKPj4+Pj4+PiAr
fQo+Pj4+Pj4+ICsKPj4+Pj4+PiArc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+Pj4+Pj4+ICtzdHJ1Y3Qgc2tfYnVmZiAqbXNnKSB7
Cj4+Pj4+Pj4gKwlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307Cj4+Pj4+Pj4g
Kwo+Pj4+Pj4+ICsJdmRldi0+Y29uZmlnLT5nZXRfY29uZmlnKHZkZXYsIDAsICZjb25maWcsIHNp
emVvZihjb25maWcpKTsKPj4+Pj4+IERvIHdlIG5lZWQgdG8gc3luYyB3aXRoIG90aGVyIHBvc3Np
YmxlIGdldF9jb25maWcgY2FsbHMgaGVyZT8KPj4+Pj4gVG8gcmVhZGVycyBvZiBnZXRfY29uZmln
KCkgaXMgb2suIE5vIG5lZWQgdG8gc3luYy4KPj4+Pj4gSG93ZXZlciwgSSB0aGluayBzZXRfY29u
ZmlnKCkgYW5kIGdldF9jb25maWcoKSBzaG91bGQgc3luYyBvdGhlcndpc2UKPj4+PiBnZXRfY29u
ZmlnIGNhbiBnZXQgcGFydGlhbCB2YWx1ZS4KPj4+Pj4gV2lsbCBwcm9iYWJseSBoYXZlIHRvIGFk
ZCB2ZHBhX2RldmljZS0+Y29uZmlnX2FjY2Vzc19sb2NrKCkuCj4+Pj4gUHJvYmFibHkuIEFuZCB0
aGUgc2V0X2NvbmZpZygpIHNob3VsZCBiZSBzeW5jaHJvbml6ZWQgd2l0aCB0aGUKPj4+PiByZXF1
cmVzdCB0aGF0IGNvbWVzIGZyb20gdkRQQSBidXMuCj4+PiBZZXMsIGEgcncgc2VtYXBob3JlIGlz
IGdvb2QgZW5vdWdoLgo+Pj4gRGV2aWNlIGNvbmZpZyBmaWVsZHMgY2FuIGJlIGNoYW5nZSBmcm9t
IHRoZSBkZXZpY2Ugc2lkZSBhbnl3YXksIHN1Y2ggYXMKPj4gbGluayBzdGF0dXMgYW55d2F5Lgo+
Pj4gU3luYyB1c2luZyBsb2NrIHNob3VsZG7igJl0IGJlIHByb2JsZW0uCj4+Pgo+Pj4+IFRoaXMg
bWFrZXMgbWUgdGhpbmsgd2hldGhlciB3ZSBzaG91bGQgZ28gYmFjayB0byB0d28gcGhhc2VzIG1l
dGhvZCwKPj4+PiBjcmVhdGUgYW5kIGVuYWJsZS4KPj4+Pgo+Pj4+IFRoZSB2RFBBIGRldmljZSBp
cyBvbmx5IHJlZ2lzdHJlZCBhZnRlciBlbmFibGluZywgdGhlbiB0aGVyZSdzIG5vCj4+Pj4gbmVl
ZCB0byBzeW5jIHdpdGggdkRQQSBidXMsIGFuZCBtZ210IGlzIG5vdCBhbGxvd2VkIHRvIGNoYW5n
ZSBjb25maWcKPj4gYWZ0ZXIgZW5hbGJpbmc/Cj4+PiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIGJl
IGFibGUgdG8gZGlzYWJsZSBpdCBhcyB3ZWxsLiBEaXNhYmxlIHNob3VsZCB0YWtlIHRoZQo+PiBk
ZXZpY2Ugb2YgdGhlIGJ1cy4KPj4+IEkgZmluZCBpdCB3ZWlyZCB0byBoYXZlIHRoaXMgbW9kZWwg
dG8gbGluZ2VyIGFyb3VuZCB0aGUgZGV2aWNlIHdpdGhvdXQKPj4gYW5jaG9yaW5nIG9uIHRoZSBi
dXMuCj4+PiBGb3IgZXhhbXBsZSBkZXZpY2UgaXMgbm90IHlldCBlbmFibGVkLCBzbyBpdCBpcyBu
b3QgYW5jaG9yZWQgb24gdGhlIGJ1cywgYnV0Cj4+IGl0cyBuYW1lIGlzIHN0aWxsIGhhdmUgdG8g
cmVtYWluIHVuaXF1ZS4KPj4KPj4KPj4gQ2FuIHdlIGRvIHNvbWUgc3luY2hvcm5pemF0aW9uIGJl
dHdlZW4gdmRwYSBkZXZpY2UgYWxsb2NhdGlvbiBhbmQgdmRwYQo+PiBkZXZpY2UgcmVnaXN0aWVy
IHRvIHNvbHZlIHRoZSBuYW1pbmcgaXNzdWU/Cj4gbWdtdCB0b29sIHF1ZXJ5aW5nIHRoZSBkZXZp
Y2UgY29uZmlnIHNwYWNlIGFmdGVyIHZkcGEgZGV2aWNlIGlzIGluIHVzZSBpcyByZWFsLgo+IFNv
IEkgZG9uJ3Qgc2VlIHNvbHZpbmcgaXQgYW55IGRpZmZlcmVudGx5Lgo+Cj4gTm93IHVwcGVyIGxh
eWVycyBvZiB2ZHBhIHRvIG5vdCBhY2Nlc3MgdGhlIGRldmljZSBvbiB0aGUgcGxhY2VkIG9uIHRo
ZSB2ZHBhIGJ1cywgY2FuIGJlIHRha2VuIGNhcmUgYnkgZXhpc3RpbmcgZHJpdmVyIGNvZGUgdXNp
bmcKPiBlY2hvIDAgPiAvc3lzL2J1cy92ZHBhL2RyaXZlcnNfYXV0b3Byb2JlCj4KPiBCeSBkZWZh
dWx0IHZkcGEgZGV2aWNlIHBsYWNlZCBvbiB0aGUgYnVzIHdvbnQgYmluZCB0byBhbnkgZHJpdmVy
IChuZXQvdmhvc3QgZXRjKS4KPiAxLiBEZWNpc2lvbiB0byBiaW5kIHRvIHdoaWNoIGRyaXZlciBp
cyBkb25lIGFmdGVyIGNvbmZpZyBvZiB0aGUgdmRwYSBkZXZpY2UgaXMgZG9uZS4KPiAyLiBvcmNo
ZXN0cmF0aW9uIHN3IGRvZXMgY3JlYXRlIGFuZCBjb25maWcgYmVmb3JlIGl0IGJpbmRzIHRvIHRo
ZSByaWdodCBkcml2ZXIKPiAzLiB3aGljaCBkcml2ZXIgdG8gYmluZCB0byBkZWNpZGVkIGJhc2Vk
IG9uIHRoZSB1c2UgY2FzZSBvZiB0aGF0IGluZGl2aWR1YWwgdmRwYSBkZXZpY2UKPiBGb3IgZXhh
bXBsZSwKPiAoYSkgdmRwYTAgYmluZHMgdG8gbmV0IGRyaXZlciB0byBoYXZlIE5ldGRldiBmb3Ig
Y29udGFpbmVyCj4gKGIpIHZkcGExIGJpbmRzIHRvIHZob3N0IGRyaXZlciB0byBtYXAgdmRwYSBk
ZXZpY2UgdG8gVk0KCgpJIHRoaW5rIGl0IHNob3VsZCB3b3JrLgoKQWRkaW5nIEFkcmlhbiwgTWF4
aW1lIGFuZCBTZWFuIGZvciBtb3JlIGNvbW1lbnRzLgoKCj4gICAKPj4+IERvIHdlIGhhdmUgdG8g
YW5jaG9yIHZkcGEgZGV2aWNlIG9uIHRoZSBidXM/IENhbiB2ZHBhIGJlIGEgY2xhc3M/Cj4+Cj4+
IEkgdGhpbmsgbm90LCBpdCdzIGEgYnVzIHRoYXQgaXMgZXhwZWN0ZWQgdG8gYmUgYm91bmQgdG8g
ZGlmZmVyZW50IGRyaXZlcgo+PiBpbnN0ZWFkIG9mIGEgc3Vic3lzdGVtLgo+IFllYWgsIEkgcmVh
bGl6ZWQgaXQgbGF0ZWx5IGFmdGVyIHdyaXRpbmcgdGhlIHByZXZpb3VzIGVtYWlsLgo+IExldHMg
c2VlIGlmIGFib3ZlIHNjaGVtZSB3b3JrcyBvciBub3QgdG8gdXNlIGV4aXN0aW5nIGRyaXZlcnNf
YXV0b3Byb2JlIGZpbGUuCgoKWWVzLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
