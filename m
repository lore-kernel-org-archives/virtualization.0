Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C2C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:53:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286D1206DA
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 02:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfjNVp4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286D1206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3621868E7;
	Tue, 11 Aug 2020 02:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4+DSTlIYaPwI; Tue, 11 Aug 2020 02:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0AD6E86759;
	Tue, 11 Aug 2020 02:53:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF3C7C013C;
	Tue, 11 Aug 2020 02:53:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9C86C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D22E487B8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQgRaj82H90n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B1C9D87B84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597114403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Uybr7bUWG76B7NZzZpYoruROjuEoNEFed1mvtj7ELc=;
 b=MfjNVp4BSYXJnsFU6rzCfS1H9UpkMgjNV47rx5MYXoDx15CJONuwzJzRv12+raj0YaeMY+
 Obss7rPPUrZbW/WI+OajzjnN0G+H72cAEIIpLiVt6gByqPaMocu2C3aug8ZgyNrMGwWYSb
 JZS5ZGj3vuBryduKy4ll9SGzHOufIN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-YzemLnq8NfGmYei6ueFNDw-1; Mon, 10 Aug 2020 22:53:21 -0400
X-MC-Unique: YzemLnq8NfGmYei6ueFNDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5979E1005504;
 Tue, 11 Aug 2020 02:53:19 +0000 (UTC)
Received: from [10.72.13.186] (ovpn-13-186.pek2.redhat.com [10.72.13.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4AD61983;
 Tue, 11 Aug 2020 02:53:11 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <eli@mellanox.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
 <20200810080410-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
Date: Tue, 11 Aug 2020 10:53:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810080410-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOC8xMCDkuIvljYg4OjA1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBBdWcgMDYsIDIwMjAgYXQgMDM6NDM6NTRQTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+
PiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAwODoyOToyMkFNIC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+PiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAwMzowMzo1NVBNICswMzAw
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gT24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDg6NTE6NTZB
TSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+PiBPbiBXZWQsIEp1biAxNywg
MjAyMCBhdCAxMToyOTo0NEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4gVGhpcyBw
YXRjaCBpbnRyb2R1Y2UgYSBjb25maWcgb3AgdG8gZ2V0IHZhbGlkIGlvdmEgcmFuZ2UgZnJvbSB0
aGUgdkRQQQo+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAgaW5jbHVkZS9s
aW51eC92ZHBhLmggfCAxNCArKysrKysrKysrKysrKwo+Pj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+PiBpbmRleCAyMzlkYjc5NDM1N2Mu
LmI3NjMzZWQyNTAwYyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+
Pj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4gQEAgLTQxLDYgKzQxLDE2IEBA
IHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4+Pj4+PiAgIAl1bnNpZ25lZCBpbnQgaW5kZXg7Cj4+Pj4+
PiAgIH07Cj4+Pj4+PiAgIAo+Pj4+Pj4gKy8qKgo+Pj4+Pj4gKyAqIHZEUEEgSU9WQSByYW5nZSAt
IHRoZSBJT1ZBIHJhbmdlIHN1cHBvcnQgYnkgdGhlIGRldmljZQo+Pj4+Pj4gKyAqIEBzdGFydDog
c3RhcnQgb2YgdGhlIElPVkEgcmFuZ2UKPj4+Pj4+ICsgKiBAZW5kOiBlbmQgb2YgdGhlIElPVkEg
cmFuZ2UKPj4+Pj4+ICsgKi8KPj4+Pj4+ICtzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHsKPj4+Pj4+
ICsJdTY0IHN0YXJ0Owo+Pj4+Pj4gKwl1NjQgZW5kOwo+Pj4+Pj4gK307Cj4+Pj4+PiArCj4+Pj4+
Cj4+Pj4+IFRoaXMgaXMgYW1iaWd1b3VzLiBJcyBlbmQgaW4gdGhlIHJhbmdlIG9yIGp1c3QgYmVo
aW5kIGl0Pwo+Pj4+PiBIb3cgYWJvdXQgZmlyc3QvbGFzdD8KPj4+PiBJdCBpcyBjdXN0b21hcnkg
aW4gdGhlIGtlcm5lbCB0byB1c2Ugc3RhcnQtZW5kIHdoZXJlIGVuZCBjb3JyZXNwb25kcyB0bwo+
Pj4+IHRoZSBieXRlIGZvbGxvd2luZyB0aGUgbGFzdCBpbiB0aGUgcmFuZ2UuIFNlZSBzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QKPj4+PiB2bV9zdGFydCBhbmQgdm1fZW5kIGZpZWxkcwo+Pj4gRXhhY3Rs
eSBteSBwb2ludDoKPj4+Cj4+PiBpbmNsdWRlL2xpbnV4L21tX3R5cGVzLmg6ICAgICAgIHVuc2ln
bmVkIGxvbmcgdm1fZW5kOyAgICAgICAgICAgLyogVGhlIGZpcnN0IGJ5dGUgYWZ0ZXIgb3VyIGVu
ZCBhZGRyZXNzCj4+Pgo+Pj4gaW4gdGhpcyBjYXNlIEphc29uIHdhbnRzIGl0IHRvIGJlIHRoZSBs
YXN0IGJ5dGUsIG5vdCBvbmUgYmVoaW5kLgo+Pj4KPj4+Cj4+IE1heWJlIHN0YXJ0LCBzaXplPyBO
b3QgYW1iaWd1b3VzLCBhbmQgeW91IGRvbid0IG5lZWQgdG8gZG8gYW5ub3lpbmcKPj4gY2FsY3Vs
YXRpb25zIGxpa2Ugc2l6ZSA9IGxhc3QgLSBzdGFydCArIDEKPiBTaXplIGhhcyBhIGJ1bmNoIG9m
IGlzc3VlczogY2FuIG92ZXJsYXAsIGNhbiBub3QgY292ZXIgdGhlIGVudGlyZSA2NCBiaXQKPiBy
YW5nZS4gVGhlIHJlcXVpc2l0ZSBjaGVja3MgYXJlIGFyZ3VhYmx5IGVhc2llciB0byBnZXQgd3Jv
bmcgdGhhbgo+IGdldHRpbmcgdGhlIHNpemUgaWYgeW91IG5lZWQgaXQuCgoKWWVzLCBzbyBkbyB5
b3Ugc3RpbGwgcHJlZmVyIGZpcnN0L2xhc3Qgb3IganVzdCBiZWdpbi9lbmQgd2hpY2ggaXMgCmNv
bnNpc3RlbnQgd2l0aCBpb21tdV9kb21haW5fZ2VvbWV0cnk/CgpUaGFua3MKCgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
