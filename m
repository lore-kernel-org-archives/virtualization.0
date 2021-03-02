Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC2C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:11:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62798600EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62798600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1362D4EF6E;
	Tue,  2 Mar 2021 04:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rqf7j1sC5X87; Tue,  2 Mar 2021 04:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CC2F4EF39;
	Tue,  2 Mar 2021 04:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 579FEC000B;
	Tue,  2 Mar 2021 04:10:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A638C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C9D583D2B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrnImxit0u4e
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:10:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4884283D1F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614658254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnixtgQumn/YdDNdwsgtPpTAOMhcHJJG+MHuTRbSqDE=;
 b=b56pR2MAxbNjXiaBsiFmJd8rqL/8mjPN7uYMRCy8Al2Xnb6zIetos8OgkbvGKJSKu2x786
 d+eeF30vi3CEl07FTf7WCfWuC74p5VDr3h4Sic7EnFe8r5Jq0NvtI41t/vt1WTaYu4EwN3
 ix8F1EERaMxNNM8PgScJ72bZTp6yYvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-RpD-tQ_JNi6chN-_szPXXA-1; Mon, 01 Mar 2021 23:10:50 -0500
X-MC-Unique: RpD-tQ_JNi6chN-_szPXXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C9C80196E;
 Tue,  2 Mar 2021 04:10:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-215.pek2.redhat.com
 [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DFBD5C661;
 Tue,  2 Mar 2021 04:10:44 +0000 (UTC)
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated random
 MAC address
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
 <20210301110937-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4634d597-eaf0-a3d4-b31f-2825cf38f538@redhat.com>
Date: Tue, 2 Mar 2021 12:10:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301110937-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMy8yIDEyOjEyIOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IE1vbiwgTWFyIDAxLCAyMDIxIGF0IDAzOjE5OjUxUE0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToK
Pj4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDg6MDk6NDhBTSAtMDUwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+Pj4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDk6MDg6MjhBTSArMDIw
MCwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDA1OjExOjIz
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+IE9uIDIwMjEvMi8yNCAyOjE4IOS4i+WN
iCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+Pj4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gVXNlIGEgcmFuZG9tbHkgZ2VuZXJhdGVkIE1BQyBhZGRyZXNz
IHRvIGJlIGFwcGxpZWQgaW4gY2FzZSBpdCBpcyBub3QKPj4+Pj4+IGNvbmZpZ3VyZWQgYnkgbWFu
YWdlbWVudCB0b29sLgo+Pj4+Pj4KPj4+Pj4+IFRoZSB2YWx1ZSBxdWVyaWVkIHRocm91Z2ggbWx4
NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKSBpcyBub3QKPj4+Pj4+IHJlbGVsYXZudCB0
byB2ZHBhIHNpbmNlIGl0IGlzIHRoZSBtYWMgdGhhdCBzaG91bGQgYmUgdXNlZCBieSB0aGUgcmVn
dWxhcgo+Pj4+Pj4gTklDIGRyaXZlci4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQg
PHBhcmF2QG52aWRpYS5jb20+Cj4+Pj4+Cj4+Pj4+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgICBkcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA1ICstLS0tCj4+Pj4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4gaW5kZXggYjY3YmJhNTgxZGZkLi5lY2UyMTgzZTdi
MjAgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4gQEAg
LTIwMDUsMTAgKzIwMDUsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2
ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUpCj4+Pj4+PiAgICAJaWYgKGVy
cikKPj4+Pj4+ICAgIAkJZ290byBlcnJfbXR1Owo+Pj4+Pj4gLQllcnIgPSBtbHg1X3F1ZXJ5X25p
Y192cG9ydF9tYWNfYWRkcmVzcyhtZGV2LCAwLCAwLCBjb25maWctPm1hYyk7Cj4+Pj4+PiAtCWlm
IChlcnIpCj4+Pj4+PiAtCQlnb3RvIGVycl9tdHU7Cj4+Pj4+PiAtCj4+Pj4+PiArCWV0aF9yYW5k
b21fYWRkcihjb25maWctPm1hYyk7Cj4+Pj4gSSB0aGluayB0aGlzIHBhdGNoIGlzIG1pc3Npbmcg
c2V0dGluZyBWSVJUSU9fTkVUX0ZfTVRVLiBJIHdpbGwgcG9zdCB2Mgo+Pj4+IHdpdGggdGhlIG90
aGVyIGZpeGVzIGluIHRoaXMgc2VyaWVzLgo+Pj4gSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB3
aHkgdGhpcyBpcyBhIGdvb2QgaWRlYS4KPj4+Cj4+PiBJZiB1c2Vyc3BhY2Ugd2FudHMgYSByYW5k
b20gbWFjIGl0IGNhbiBzZXQgaXQsIHdpdGggdGhpcwo+Pj4gcGF0Y2ggaXQgaXMgaW1wb3NzaWJs
ZSB0byBrbm93IHdoZXRoZXIgdGhlIG1hYyBpcwo+Pj4gYSBoYXJkd2FyZSBvbmUgKHdoaWNoIHdp
bGwgYmUgcGVyc2lzdGVudCBlLmcuIGFjcm9zcyByZWJvb3RzKQo+Pj4gb3IgYSByYW5kb20gb25l
Lgo+Pj4KPj4gWW91IGNhbiBzdGlsbCBnZXQgYSBwZXJzaXN0ZW50IE1BQyBzZXQgYnkgdGhlIHZk
cGEgdG9vbC4gZS5nCj4+Cj4+IHZkcGEgZGV2IGNvbmZpZyBzZXQgdmRwYTAgbWFjIDAwOjExOjIy
OjMzOjQ0OjU1Cj4+Cj4+IElmIHlvdSBkb24ndCB1c2UgdmRwYSB0b29sLCB0aGUgZGV2aWNlIGFz
c2lnbnMgYSByYW5kb20gTUFDLiBUaGlzIE1BQyBpcwo+PiB1c2VkIHRvIGZpbHRlciBpbWNvbWlu
ZyB1bmljYXN0IHRyYWZmaWMgKGRvbmUgaW4gYSBzdWJzZXF1ZW50IHBhdGNoKS4KPiBXZWxsIHBy
ZXZpb3VzbHkgZGV2aWNlIGxlYXJuZWQgdGhlIE1BQyBmcm9tIG91dGdvaW5nIHRyYWZmaWMKPiBh
bmQgdXNlZCB0aGF0IGZvciB0aGUgZmlsdGVyLgo+IElzIGNoYW5naW5nIHRoYXQgdG8gYSByYW5k
b20gdmFsdWUgcmVhbGx5IGFsbCB0aGF0IHVzZWZ1bCBhcwo+IGEgZGVmYXVsdD8gIFdoeSBub3Qg
ZG8gdGhlIHJhbmRvbWl6YXRpb24gaW4gdXNlcnNwYWNlPwoKCkkgdGhpbmsgdGhlIHBvaW50IGlz
IHRoYXQsIGlmIHVzZXJzcGFjZSBkb2Vucyd0IHNwZWNpZnkgYSBtYWMsIGl0IGNhbiAKc3RpbGwg
d29yay4KClRoYW5rcwoKCj4KPgo+Pj4gRS5nLiB0aGVyZSBpcyBhIHBhdGNoIGNvbmZpZ3VyaW5n
IGEgdXNlcnNwYWNlIHN1cHBsaWVkCj4+PiBtYWMgaWYgdGhlIGhhcmR3YXJlIG1hYyBpcyB6ZXJv
Lgo+Pj4KPj4+IFRoaXMgcGF0Y2ggd2lsbCBicmVhayBpdC4KPj4+Cj4+Pj4+PiAgICAJbXZkZXYt
PnZkZXYuZG1hX2RldiA9IG1kZXYtPmRldmljZTsKPj4+Pj4+ICAgIAllcnIgPSBtbHg1X3ZkcGFf
YWxsb2NfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4+Pj4+PiAgICAJaWYgKGVycikKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
