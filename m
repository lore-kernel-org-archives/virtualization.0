Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8F9C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:28:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E613764FEA
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E613764FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFAAC83A5F;
	Tue, 16 Mar 2021 08:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vp5c934oQkIL; Tue, 16 Mar 2021 08:28:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D312E83A80;
	Tue, 16 Mar 2021 08:28:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7538C000C;
	Tue, 16 Mar 2021 08:28:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDCE9C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B89C283A80
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASgxso9_ozzR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:28:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74EDE83857
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615883316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aclyiJU0u5NdHfgjYb9hnlntTA8of1G4TDmlVUOlgpI=;
 b=DDEcuzt2dq0puIoC2lLdY5Chiinu2msgH5xLr0nvXnKSJHmqHL4XQp8x5UjMspXsCO16Gy
 IcdDAvxmmR01Gax9Q3I26nsf1/iEflAAIZn2o7Yvv40BQiMV05eJN4cZaOxk7dY1hlP+3J
 bETciMGKGdJjIEd80mkctlU8O57C8Rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-RIB7NMDlNuG3eZHGFM1kdQ-1; Tue, 16 Mar 2021 04:28:32 -0400
X-MC-Unique: RIB7NMDlNuG3eZHGFM1kdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D4D56BDC;
 Tue, 16 Mar 2021 08:28:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F8B810016DB;
 Tue, 16 Mar 2021 08:28:21 +0000 (UTC)
Subject: Re: [RFC v2 00/13] vDPA software assisted live migration
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210315194842.277740-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67a2525b-d0b2-dc7a-fa9d-f7c10ae22adf@redhat.com>
Date: Tue, 16 Mar 2021 16:28:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315194842.277740-1-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>
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

CuWcqCAyMDIxLzMvMTYg5LiK5Y2IMzo0OCwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFRoaXMg
c2VyaWVzIGVuYWJsZSBzaGFkb3cgdmlydHF1ZXVlIGZvciB2aG9zdC1uZXQgZGV2aWNlcy4gVGhp
cyBpcyBhCj4gbmV3IG1ldGhvZCBvZiB2aG9zdCBkZXZpY2VzIG1pZ3JhdGlvbjogSW5zdGVhZCBv
ZiByZWxheSBvbiB2aG9zdAo+IGRldmljZSdzIGRpcnR5IGxvZ2dpbmcgY2FwYWJpbGl0eSwgU1cg
YXNzaXN0ZWQgTE0gaW50ZXJjZXB0cyBkYXRhcGxhbmUsCj4gZm9yd2FyZGluZyB0aGUgZGVzY3Jp
cHRvcnMgYmV0d2VlbiBWTSBhbmQgZGV2aWNlLiBJcyBpbnRlbmRlZCBmb3IgdkRQQQo+IGRldmlj
ZXMgd2l0aCBubyBsb2dnaW5nLCBidXQgdGhpcyBhZGRyZXNzIHRoZSBiYXNpYyBwbGF0Zm9ybSB0
byBidWlsZAo+IHRoYXQgc3VwcG9ydCBvbi4KPgo+IEluIHRoaXMgbWlncmF0aW9uIG1vZGUsIHFl
bXUgb2ZmZXJzIGEgbmV3IHZyaW5nIHRvIHRoZSBkZXZpY2UgdG8KPiByZWFkIGFuZCB3cml0ZSBp
bnRvLCBhbmQgZGlzYWJsZSB2aG9zdCBub3RpZmllcnMsIHByb2Nlc3NpbmcgZ3Vlc3QgYW5kCj4g
dmhvc3Qgbm90aWZpY2F0aW9ucyBpbiBxZW11LiBPbiB1c2VkIGJ1ZmZlciByZWxheSwgcWVtdSB3
aWxsIG1hcmsgdGhlCj4gZGlydHkgbWVtb3J5IGFzIHdpdGggcGxhaW4gdmlydGlvLW5ldCBkZXZp
Y2VzLiBUaGlzIHdheSwgZGV2aWNlcyBkb2VzCj4gbm90IG5lZWQgdG8gaGF2ZSBkaXJ0eSBwYWdl
IGxvZ2dpbmcgY2FwYWJpbGl0eS4KPgo+IFRoaXMgc2VyaWVzIGlzIGEgUE9DIGRvaW5nIFNXIExN
IGZvciB2aG9zdC1uZXQgZGV2aWNlcywgd2hpY2ggYWxyZWFkeQo+IGhhdmUgZGlydHkgcGFnZSBs
b2dnaW5nIGNhcGFiaWxpdGllcy4gRm9yIHFlbXUgdG8gdXNlIHNoYWRvdyB2aXJ0cXVldWVzCj4g
dGhlc2Ugdmhvc3QtbmV0IGRldmljZXMgbmVlZCB0byBiZSBpbnN0YW50aWF0ZWQ6Cj4gKiBXaXRo
IElPTU1VIChpb21tdV9wbGF0Zm9ybT1vbixhdHM9b24pCj4gKiBXaXRob3V0IGV2ZW50X2lkeCAo
ZXZlbnRfaWR4PW9mZikKPgo+IEFuZCBzaGFkb3cgdmlydHF1ZXVlIG5lZWRzIHRvIGJlIGVuYWJs
ZWQgZm9yIHRoZW0gd2l0aCBRTVAgY29tbWFuZAo+IGxpa2U6Cj4KPiB7Cj4gICAgImV4ZWN1dGUi
OiAieC12aG9zdC1lbmFibGUtc2hhZG93LXZxIiwKPiAgICAiYXJndW1lbnRzIjogewo+ICAgICAg
Im5hbWUiOiAidmlydGlvLW5ldCIsCj4gICAgICAiZW5hYmxlIjogZmFsc2UKPiAgICB9Cj4gfQo+
Cj4gSnVzdCB0aGUgbm90aWZpY2F0aW9uIGZvcndhcmRpbmcgKHdpdGggbm8gZGVzY3JpcHRvciBy
ZWxheSkgY2FuIGJlCj4gYWNoaWV2ZWQgd2l0aCBwYXRjaGVzIDUgYW5kIDYsIGFuZCBzdGFydGlu
ZyBTVlEuIFByZXZpb3VzIGNvbW1pdHMKPiBhcmUgY2xlYW51cCBvbmVzIGFuZCBkZWNsYXJhdGlv
biBvZiBRTVAgY29tbWFuZC4KPgo+IENvbW1pdCAxMSBpbnRyb2R1Y2VzIHRoZSBidWZmZXIgZm9y
d2FyZGluZy4gUHJldmlvdXMgb25lIGFyZSBmb3IKPiBwcmVwYXJhdGlvbnMgYWdhaW4sIGFuZCBs
YXRlcnMgYXJlIGZvciBlbmFibGluZyBzb21lIG9idmlvdXMKPiBvcHRpbWl6YXRpb25zLgo+Cj4g
SXQgaXMgYmFzZWQgb24gdGhlIGlkZWFzIG9mIERQREsgU1cgYXNzaXN0ZWQgTE0sIGluIHRoZSBz
ZXJpZXMgb2YKPiBEUERLJ3MgaHR0cHM6Ly9wYXRjaHdvcmsuZHBkay5vcmcvY292ZXIvNDgzNzAv
IC4gSG93ZXZlciwgdGhlc2UgZG9lcwo+IG5vdCBtYXAgdGhlIHNoYWRvdyB2cSBpbiBndWVzdCdz
IFZBLCBidXQgaW4gcWVtdSdzLgo+Cj4gQ29tbWVudHMgYXJlIHdlbGNvbWUhIEVzcGVjaWFsbHkg
b246Cj4gKiBEaWZmZXJlbnQvaW1wcm92ZWQgd2F5IG9mIHN5bmNocm9uaXphdGlvbiwgcGFydGlj
dWxhcmx5IG9uIHRoZSByYWNlCj4gICAgb2YgbWFza2luZy4KPgo+IFRPRE86Cj4gKiBFdmVudCwg
aW5kaXJlY3QsIHBhY2tlZCwgYW5kIG90aGVycyBmZWF0dXJlcyBvZiB2aXJ0aW8gLSBXYWl0aW5n
IGZvcgo+ICAgIGNvbmZpcm1hdGlvbiBvZiB0aGUgYmlnIHBpY3R1cmUuCgoKU28gdHdvIHRoaW5n
cyBpbiBteSBtaW5kIGFmdGVyIHJldmlld2luZyB0aGUgc2VpcmVzOgoKMSkgd2hpY2ggbGF5ZXIg
c2hvdWxkIHdlIGltcGxlbWVudCB0aGUgc2hhZG93IHZpcnRxdWV1ZS4gRS5nIGlmIHlvdSB3YW50
IAp0byBkbyB0aGF0IGF0IHZpcnRpbyBsZXZlbCwgeW91IG5lZWQgdG8gZGVhbCB3aXRoIGEgbG90
IG9mIApzeW5jaHJvbml6YXRpb25zLiBJIHByZWZlciB0byBkbyBpdCBpbiB2aG9zdC12RFBBLgoy
KSBVc2luZyBWQSBhcyBJT1ZBIHdoaWNoIGNhbiBub3Qgd29yayBmb3Igdmhvc3QtdkRQQQoKCj4g
KiB2RFBBIGRldmljZXM6CgoKU28gSSB0aGluayB3ZSBjYW4gc3RhcnQgZnJvbSBhIHZob3N0LXZE
UEEgc3BlY2lmaWMgc2hhZG93IHZpcnRxdWV1ZSAKZmlyc3QsIHRoZW4gZXh0ZW5kaW5nIGl0IHRv
IGJlIGEgZ2VuZXJhbCBvbmUgd2hpY2ggbWlnaHQgYmUgbXVjaCBlYXNpZXIuCgoKPiBEZXZlbG9w
aW5nIHNvbHV0aW9ucyBmb3IgdHJhY2tpbmcgdGhlIGF2YWlsYWJsZSBJT1ZBCj4gICAgc3BhY2Ug
Zm9yIGFsbCBkZXZpY2VzLgoKCkZvciB2aG9zdC1uZXQsIHlvdSBjYW4gYXNzdW1lIHRoYXQgWzAs
IFVMTE9OR19NQVhdIGlzIHZhbGlkIHNvIHlvdSBjYW4gCnNpbXBseSB1c2UgVkEgYXMgSU9WQS4K
Cgo+IFNtYWxsIFBPQyBhdmFpbGFibGUsIHNraXBwaW5nIHRoZSBnZXQvc2V0Cj4gICAgc3RhdHVz
IChzaW5jZSB2RFBBIGRvZXMgbm90IHN1cHBvcnQgaXQpIGFuZCBqdXN0IGFsbG9jYXRpbmcgbW9y
ZSBhbmQKPiAgICBtb3JlIElPVkEgYWRkcmVzc2VzIGluIGEgaGFyZGNvZGVkIHJhbmdlIGF2YWls
YWJsZSBmb3IgdGhlIGRldmljZS4KCgpJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yayBidXQgeW91
IG5lZWQgbWFrZSBzdXJlIHRoYXQgcmFuZ2UgY2FuIGZpdCB0aGUgCnNpemUgb2YgdGhlIGFsbCBt
ZW1vcnkgcmVnaW9ucyBhbmQgbmVlZCB0byBkZWFsIHdpdGggbWVtb3J5IHJlZ2lvbiBhZGQgCmFu
ZCBkZWwuCgpJIGd1ZXNzIHlvdSBwcm9iYWJseSBuZWVkIGEgZnVsbCBmdW5jdGlvbmFsIHRyZWUg
YmFzZWQgSU9WQSBhbGxvY2F0b3IuCgpUaGFua3MKCgo+ICogVG8gc2VwcGFyYXRlIGJ1ZmZlcnMg
Zm9yd2FyZGluZyBpbiBpdHMgb3duIEFJTyBjb250ZXh0LCBzbyB3ZSBjYW4KPiAgICB0aHJvdyBt
b3JlIHRocmVhZHMgdG8gdGhhdCB0YXNrIGFuZCB3ZSBkb24ndCBuZWVkIHRvIHN0b3AgdGhlIG1h
aW4KPiAgICBldmVudCBsb29wLgo+ICogSU9NTVUgb3B0aW1pemF0aW9ucywgc28gYmFjdGhpbmcg
YW5kIGJpZ2dlciBjaHVua3Mgb2YgSU9WQSBjYW4gYmUKPiAgICBzZW50IHRvIGRldmljZS4KPiAq
IEF1dG9tYXRpYyBraWNrLWluIG9uIGxpdmUtbWlncmF0aW9uLgo+ICogUHJvcGVyIGRvY3VtZW50
YXRpb24uCj4KPiBUaGFua3MhCj4KPiBDaGFuZ2VzIGZyb20gdjEgUkZDOgo+ICAgICogVXNlIFFN
UCBpbnN0ZWFkIG9mIG1pZ3JhdGlvbiB0byBzdGFydCBTVlEgbW9kZS4KPiAgICAqIE9ubHkgYWNj
ZXB0aW5nIElPTU1VIGRldmljZXMsIGNsb3NlciBiZWhhdmlvciB3aXRoIHRhcmdldCBkZXZpY2Vz
Cj4gICAgICAodkRQQSkKPiAgICAqIEZpeCBpbnZhbGlkIG1hc2tpbmcvdW5tYXNraW5nIG9mIHZo
b3N0IGNhbGwgZmQuCj4gICAgKiBVc2Ugb2YgcHJvcGVyIG1ldGhvZHMgZm9yIHN5bmNocm9uaXph
dGlvbi4KPiAgICAqIE5vIG5lZWQgdG8gbW9kaWZ5IFZpcnRJTyBkZXZpY2UgY29kZSwgYWxsIG9m
IHRoZSBjaGFuZ2VzIGFyZQo+ICAgICAgY29udGFpbmVkIGluIHZob3N0IGNvZGUuCj4gICAgKiBE
ZWxldGUgc3VwZXJmbHVvdXMgY29kZS4KPiAgICAqIEFuIGludGVybWVkaWF0ZSBSRkMgd2FzIHNl
bnQgd2l0aCBvbmx5IHRoZSBub3RpZmljYXRpb25zIGZvcndhcmRpbmcKPiAgICAgIGNoYW5nZXMu
IEl0IGNhbiBiZSBzZWVuIGluCj4gICAgICBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyMTAx
MjkyMDU0MTUuODc2MjkwLTEtZXBlcmV6bWFAcmVkaGF0LmNvbS8KPiAgICAqIHYxIGF0Cj4gICAg
ICBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMC0xMS9t
c2cwNTM3Mi5odG1sCj4KPiBFdWdlbmlvIFDDqXJleiAoMTMpOgo+ICAgIHZpcnRpbzogQWRkIHZp
cnRpb19xdWV1ZV9pc19ob3N0X25vdGlmaWVyX2VuYWJsZWQKPiAgICB2aG9zdDogU2F2ZSBtYXNr
ZWRfbm90aWZpZXIgc3RhdGUKPiAgICB2aG9zdDogQWRkIFZob3N0U2hhZG93VmlydHF1ZXVlCj4g
ICAgdmhvc3Q6IEFkZCB4LXZob3N0LWVuYWJsZS1zaGFkb3ctdnEgcW1wCj4gICAgdmhvc3Q6IFJv
dXRlIGd1ZXN0LT5ob3N0IG5vdGlmaWNhdGlvbiB0aHJvdWdoIHNoYWRvdyB2aXJ0cXVldWUKPiAg
ICB2aG9zdDogUm91dGUgaG9zdC0+Z3Vlc3Qgbm90aWZpY2F0aW9uIHRocm91Z2ggc2hhZG93IHZp
cnRxdWV1ZQo+ICAgIHZob3N0OiBBdm9pZCByZS1zZXQgbWFza2VkIG5vdGlmaWVyIGluIHNoYWRv
dyB2cQo+ICAgIHZpcnRpbzogQWRkIHZob3N0X3NoYWRvd192cV9nZXRfdnJpbmdfYWRkcgo+ICAg
IHZpcnRpbzogQWRkIHZpcnRpb19xdWV1ZV9mdWxsCj4gICAgdmhvc3Q6IGFkZCB2aG9zdF9rZXJu
ZWxfc2V0X3ZyaW5nX2VuYWJsZQo+ICAgIHZob3N0OiBTaGFkb3cgdmlydHF1ZXVlIGJ1ZmZlcnMg
Zm9yd2FyZGluZwo+ICAgIHZob3N0OiBDaGVjayBmb3IgZGV2aWNlIFZSSU5HX1VTRURfRl9OT19O
T1RJRlkgYXQgc2hhZG93IHZpcnRxdWV1ZQo+ICAgICAga2ljawo+ICAgIHZob3N0OiBVc2UgVlJJ
TkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgYXQgZGV2aWNlIGNhbGwgb24gc2hhZG93Cj4gICAgICB2
aXJ0cXVldWUKPgo+ICAgcWFwaS9uZXQuanNvbiAgICAgICAgICAgICAgICAgICAgICB8ICAyMiAr
Kwo+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCB8ICAzNiArKwo+ICAgaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QuaCAgICAgICAgICB8ICAgNiArCj4gICBpbmNsdWRlL2h3L3Zp
cnRpby92aXJ0aW8uaCAgICAgICAgIHwgICAzICsKPiAgIGh3L3ZpcnRpby92aG9zdC1iYWNrZW5k
LmMgICAgICAgICAgfCAgMjkgKysKPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVl
LmMgfCA1NTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGh3L3ZpcnRpby92aG9z
dC5jICAgICAgICAgICAgICAgICAgfCAyODMgKysrKysrKysrKysrKysrCj4gICBody92aXJ0aW8v
dmlydGlvLmMgICAgICAgICAgICAgICAgIHwgIDIzICstCj4gICBody92aXJ0aW8vbWVzb24uYnVp
bGQgICAgICAgICAgICAgIHwgICAyICstCj4gICA5IGZpbGVzIGNoYW5nZWQsIDk1MiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody92aXJ0aW8v
dmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
