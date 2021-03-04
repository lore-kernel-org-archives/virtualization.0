Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B595BC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:24:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3551064EEC
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3551064EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5C9F6F608;
	Thu,  4 Mar 2021 08:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DYeW1kn7oL-Q; Thu,  4 Mar 2021 08:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 505A76F5B9;
	Thu,  4 Mar 2021 08:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A8ADC000A;
	Thu,  4 Mar 2021 08:24:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4D22C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A4896F608
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6W-Y221s2Se5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:24:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 622E36F5B9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614846274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IclWwaawMHCNvxX8I+oUb0tVcPL3WS0YV84m0Vq1gk=;
 b=BCTSpy8JoHlecnkoXZl5i6K+PYLiprzsiqog6Gc3OXh1KwxGNtvKg3vafuAsyw+EBowyG1
 6y7r6StAl5cxZnhhSC9gXSIzr8fClcNnJtqTioQCtpdMaH7VnWv1IEVdaQfcz+PubkKil/
 3eOt+SEcNXWdi1iYlw2DwwOmYtXx1us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-bdUaXeI-Oi2FndwzEeR6Cw-1; Thu, 04 Mar 2021 03:24:31 -0500
X-MC-Unique: bdUaXeI-Oi2FndwzEeR6Cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24ABC107AFDF;
 Thu,  4 Mar 2021 08:24:30 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-64.pek2.redhat.com
 [10.72.12.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 093815D9C6;
 Thu,  4 Mar 2021 08:24:17 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: Cornelia Huck <cohuck@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
 <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
 <20210303092905.677eb66c.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b5b3f9b-41d7-795c-c677-c45f1d5a774e@redhat.com>
Date: Thu, 4 Mar 2021 16:24:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303092905.677eb66c.cohuck@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

Ck9uIDIwMjEvMy8zIDQ6Mjkg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdyb3RlOgo+IE9uIFdlZCwg
MyBNYXIgMjAyMSAxMjowMTowMSArMDgwMAo+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4+IE9uIDIwMjEvMy8yIDg6MDgg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdy
b3RlOgo+Pj4gT24gTW9uLCAxIE1hciAyMDIxIDExOjUxOjA4ICswODAwCj4+PiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+ICAgCj4+Pj4gT24gMjAyMS8zLzEgNToy
NSDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4gT24gRnJpLCBGZWIgMjYs
IDIwMjEgYXQgMDQ6MTk6MTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9uIDIw
MjEvMi8yNiAyOjUzIOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+IENv
bmZ1c2VkLiBXaGF0IGlzIHdyb25nIHdpdGggdGhlIGFib3ZlPyBJdCBuZXZlciByZWFkcyB0aGUK
Pj4+Pj4+PiBmaWVsZCB1bmxlc3MgdGhlIGZlYXR1cmUgaGFzIGJlZW4gb2ZmZXJlZCBieSBkZXZp
Y2UuCj4+Pj4+PiBTbyB0aGUgc3BlYyBzYWlkOgo+Pj4+Pj4KPj4+Pj4+ICIKPj4+Pj4+Cj4+Pj4+
PiBUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG1heF92aXJ0cXVldWVfcGFp
cnMgb25seSBleGlzdHMgaWYKPj4+Pj4+IFZJUlRJT19ORVRfRl9NUSBpcyBzZXQuCj4+Pj4+Pgo+
Pj4+Pj4gIgo+Pj4+Pj4KPj4+Pj4+IElmIEkgcmVhZCB0aGlzIGNvcnJlY3RseSwgdGhlcmUgd2ls
bCBiZSBubyBtYXhfdmlydHF1ZXVlX3BhaXJzIGZpZWxkIGlmIHRoZQo+Pj4+Pj4gVklSVElPX05F
VF9GX01RIGlzIG5vdCBvZmZlcmVkIGJ5IGRldmljZT8gSWYgeWVzIHRoZSBvZmZzZXRvZigpIHZp
b2xhdGVzCj4+Pj4+PiB3aGF0IHNwZWMgc2FpZC4KPj4+Pj4+Cj4+Pj4+PiBUaGFua3MKPj4+Pj4g
SSB0aGluayB0aGF0J3MgYSBtaXN1bmRlcnN0YW5kaW5nLiBUaGlzIHRleHQgd2FzIG5ldmVyIGlu
dGVuZGVkIHRvCj4+Pj4+IGltcGx5IHRoYXQgZmllbGQgb2Zmc2V0cyBjaGFuZ2UgYmVhc2VkIG9u
IGZlYXR1cmUgYml0cy4KPj4+Pj4gV2UgaGFkIHRoaXMgcGFpbiB3aXRoIGxlZ2FjeSBhbmQgd2Ug
bmV2ZXIgd2FudGVkIHRvIGdvIGJhY2sgdGhlcmUuCj4+Pj4+Cj4+Pj4+IFRoaXMgbWVyZWx5IGlt
cGxpZXMgdGhhdCB3aXRob3V0IFZJUlRJT19ORVRfRl9NUSB0aGUgZmllbGQKPj4+Pj4gc2hvdWxk
IG5vdCBiZSBhY2Nlc3NlZC4gRXhpc3RzIGluIHRoZSBzZW5zZSAiaXMgYWNjZXNzaWJsZSB0byBk
cml2ZXIiLgo+Pj4+Pgo+Pj4+PiBMZXQncyBqdXN0IGNsYXJpZnkgdGhhdCBpbiB0aGUgc3BlYywg
am9iIGRvbmUuCj4+Pj4gT2ssIGFncmVlLiBUaGF0IHdpbGwgbWFrZSB0aGluZ3MgbW9yZSBlYWlz
ZXIuCj4+PiBZZXMsIHRoYXQgbWFrZXMgbXVjaCBtb3JlIHNlbnNlLgo+Pj4KPj4+IFdoYXQgYWJv
dXQgYWRkaW5nIHRoZSBmb2xsb3dpbmcgdG8gdGhlICJCYXNpYyBGYWNpbGl0aWVzIG9mIGEgVmly
dGlvCj4+PiBEZXZpY2UvRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UiIHNlY3Rpb24gb2YgdGhl
IHNwZWM6Cj4+Pgo+Pj4gIklmIGFuIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gZmllbGQgZG9lcyBu
b3QgZXhpc3QsIHRoZSBjb3JyZXNwb25kaW5nCj4+PiBzcGFjZSBpcyBzdGlsbCBwcmVzZW50LCBi
dXQgcmVzZXJ2ZWQuIgo+Pgo+PiBUaGlzIGJlY2FtZSBpbnRlcmVzdGluZyBhZnRlciByZS1yZWFk
aW5nIHNvbWUgb2YgdGhlIHFlbXUgY29kZXMuCj4+Cj4+IEUuZyBpbiB2aXJ0aW8tbmV0LmMgd2Ug
aGFkOgo+Pgo+PiAqc3RhdGljIFZpcnRJT0ZlYXR1cmUgZmVhdHVyZV9zaXplc1tdID0gewo+PiAg
IMKgwqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTUFDLAo+PiAgIMKgwqDCoMKg
IC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIG1hYyl9LAo+PiAgIMKgwqDC
oCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfU1RBVFVTLAo+PiAgIMKgwqDCoMKgIC5l
bmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIHN0YXR1cyl9LAo+PiAgIMKgwqDC
oCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTVEsCj4+ICAgwqDCoMKgwqAgLmVuZCA9
IGVuZG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbWF4X3ZpcnRxdWV1ZV9wYWlycyl9LAo+
PiAgIMKgwqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTVRVLAo+PiAgIMKgwqDC
oMKgIC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIG10dSl9LAo+PiAgIMKg
wqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfU1BFRURfRFVQTEVYLAo+PiAgIMKg
wqDCoMKgIC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIGR1cGxleCl9LAo+
PiAgIMKgwqDCoCB7LmZsYWdzID0gKDFVTEwgPDwgVklSVElPX05FVF9GX1JTUykgfCAoMVVMTCA8
PAo+PiBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQpLAo+PiAgIMKgwqDCoMKgIC5lbmQgPSBlbmRv
ZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIHN1cHBvcnRlZF9oYXNoX3R5cGVzKX0sCj4+ICAg
wqDCoMKgIHt9Cj4+IH07Kgo+Pgo+PiAqSXQgaGFzIGEgaW1wbGljdCBkZXBlbmRlbmN5IGNoYWlu
LiBFLmcgTVRVIGRvZXNuJ3QgcHJlc25ldCBpZgo+PiBEVVBMRVgvUlNTIGlzIG5vdCBvZmZlcmVk
IC4uLgo+PiAqCj4gQnV0IEkgdGhpbmsgaXQgY292ZXJzIGV2ZXJ5dGhpbmcgdXAgdG8gdGhlIHJl
bGV2YW50IGZpZWxkLCBubz8gU28gTVRVCj4gaXMgaW5jbHVkZWQgaWYgd2UgaGF2ZSB0aGUgZmVh
dHVyZSBiaXQsIGV2ZW4gaWYgd2UgZG9uJ3QgaGF2ZQo+IERVUExFWC9SU1MuCj4KPiBHaXZlbiB0
aGF0IGEgY29uZmlnIHNwYWNlIG1heSBiZSBzaG9ydGVyIChidXQgbXVzdCBub3QgY29sbGFwc2UK
PiBub24tZXhpc3RpbmcgZmllbGRzKSwgbWF5YmUgYSBiZXR0ZXIgd29yZGluZyB3b3VsZCBiZToK
Pgo+ICJJZiBhbiBvcHRpb25hbCBjb25maWd1cmF0aW9uIGZpZWxkIGRvZXMgbm90IGV4aXN0LCB0
aGUgY29ycmVzcG9uZGluZwo+IHNwYWNlIHdpbGwgc3RpbGwgYmUgcHJlc2VudCBpZiBpdCBpcyBu
b3QgYXQgdGhlIGVuZCBvZiB0aGUKPiBjb25maWd1cmF0aW9uIHNwYWNlIChpLmUuLCBmdXJ0aGVy
IGNvbmZpZ3VyYXRpb24gZmllbGRzIGV4aXN0LikKCgpUaGlzIHNob3VsZCB3b3JrIGJ1dCBJIHRo
aW5rIHdlIG5lZWQgdG8gZGVmaW5lIHRoZSBlbmQgb2YgY29uZmlndXJhdGlvbiAKc3BhY2UgZmly
c3Q/CgoKPiBUaGlzCj4gaW1wbGllcyB0aGF0IGEgZ2l2ZW4gZmllbGQsIGlmIGl0IGV4aXN0cywg
aXMgYWx3YXlzIGF0IHRoZSBzYW1lIG9mZnNldAo+IGZyb20gdGhlIGJlZ2lubmluZyBvZiB0aGUg
Y29uZmlndXJhdGlvbiBzcGFjZS4iCj4KPgo+Pj4gKERvIHdlIG5lZWQgdG8gc3BlY2lmeSB3aGF0
IGEgZGV2aWNlIG5lZWRzIHRvIGRvIGlmIHRoZSBkcml2ZXIgdHJpZXMgdG8KPj4+IGFjY2VzcyBh
IG5vbi1leGlzdGluZyBmaWVsZD8gV2UgY2Fubm90IHJlYWxseSBtYWtlIGFzc3VtcHRpb25zIGFi
b3V0Cj4+PiBjb25maWcgc3BhY2UgYWNjZXNzZXM7IHZpcnRpby1jY3cgY2FuIGp1c3QgY29weSBh
IGNodW5rIG9mIGNvbmZpZyBzcGFjZQo+Pj4gdGhhdCBjb250YWlucyBub24tZXhpc3RpbmcgZmll
bGRzLi4uCj4+Cj4+IFJpZ2h0LCBpdCBsb29rcyB0byBtZSBjY3cgZG9lc24ndCBkZXBlbmRzIG9u
IGNvbmZpZyBsZW4gd2hpY2ggaXMga2luZCBvZgo+PiBpbnRlcmVzdGluZy4gSSB0aGluayB0aGUg
YW5zd2VyIGRlcGVuZHMgb24gdGhlIGltcGxlbWVudGF0aW9uIG9mIGJvdGgKPj4gdHJhbnNwb3J0
IGFuZCBkZXZpY2U6Cj4gKHZpcnRpby1jY3cgaXMgYSBiaXQgb2RkLCBiZWNhdXNlIGNoYW5uZWwg
SS9PIGRvZXMgbm90IGhhdmUgdGhlIGNvbmNlcHQKPiBvZiBhIGNvbmZpZyBzcGFjZSBhbmQgSSBu
ZWVkZWQgdG8gY29tZSB1cCB3aXRoIHNvbWV0aGluZykKCgpPay4KCgo+Cj4+IExldCdzIHRha2Ug
dmlydGlvLW5ldC1wY2kgYXMgYW4gZXhhbXBsZSwgaXQgZmlsbHMgc3RhdHVzIHVuY29uZGl0aW9u
YWxseQo+PiBpbiB2aXJ0aW9fbmV0X3NldF9jb25maWcoKSBldmVuIGlmIFZJUlRJT19ORVRfRl9T
VEFUVVMgaXMgbm90Cj4+IG5lZ290aWF0ZWQuIFNvIHdpdGggdGhlIGFib3ZlIGZlYXR1cmVfc2l6
ZXM6Cj4+Cj4+IDEpIGlmIG9uZSBvZiB0aGUgTVEsIE1UVSwgRFVQTEVYIG9yIFJTUyBpcyBpbXBs
ZW1lbnRlZCwgZHJpdmVyIGNhbiBzdGlsbAo+PiByZWFkIHN0YXR1cyBpbiB0aGlzIGNhc2UKPj4g
MikgaWYgbm9uZSBvZiB0aGUgYWJvdmUgZm91ciBpcyBuZWdvdGllZCwgZHJpdmVyIGNhbiBvbmx5
IHJlYWQgYSAweEZGCj4+ICh2aXJ0aW9fY29uZmlnX3JlYWRiKCkpCj4+Cj4+Cj4+PiBJIGd1ZXNz
IHRoZSBkZXZpY2UgY291bGQgaWdub3JlCj4+PiB3cml0ZXMgYW5kIHJldHVybiB6ZXJvZXMgb24g
cmVhZD8pCj4+Cj4+IFNvIGNvbnNpZGVyIHRoZSBhYm92ZSwgaXQgbWlnaHQgYmUgdG9vIGxhdGUg
dG8gZml4L2NsYXJpZnkgdGhhdCBpbiB0aGUKPj4gc3BlYyBvbiB0aGUgZXhwZWN0ZWQgYmVoYXZp
b3VyIG9mIHJlYWRpbmcvd3JpdGluZyBub24tZXhpc3QgZmllbGRzLgo+IFdlIGNvdWxkIHN0aWxs
IGFkdmlzZSBiZWhhdmlvdXIgdmlhIFNIT1VMRCwgdGhvdWdoIEknbSBub3Qgc3VyZSBpdCBhZGRz
Cj4gbXVjaCBhdCB0aGlzIHBvaW50IGluIHRpbWUuCj4KPiBJdCByZWFsbHkgZmVlbHMgYSBiaXQg
b2RkIHRoYXQgYSBkcml2ZXIgY2FuIHN0aWxsIHJlYWQgYW5kIHdyaXRlIGZpZWxkcwo+IGZvciBm
ZWF0dXJlcyB0aGF0IGl0IGRpZCBub3QgbmVnb3RpYXRlLCBidXQgSSBmZWFyIHdlJ3JlIHN0dWNr
IHdpdGggaXQuCgoKWWVzLCBzaW5jZSB0aGUgZGV2aWNlIChhdCBsZWFzdCB2aXJ0aW8tcGNpKSBp
bXBsbWVudCB0aGluZyBsaWtlIHRoaXMuCgpUaGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4g
SSd2ZSBvcGVuZWQgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1
ZXMvOTggZm9yIHRoZQo+Pj4gc3BlYyBpc3N1ZXMuCj4+PiAgIAo+Cj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4g
VG8gdW5zdWJzY3JpYmUsIGUtbWFpbDogdmlydGlvLWRldi11bnN1YnNjcmliZUBsaXN0cy5vYXNp
cy1vcGVuLm9yZwo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6IHZpcnRpby1kZXYt
aGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
