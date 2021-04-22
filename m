Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC6C433ED
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:59:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A316145C
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A316145C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42B6B82B8C;
	Thu, 22 Apr 2021 08:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-L52FOnwpo4; Thu, 22 Apr 2021 08:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDF1E82ADD;
	Thu, 22 Apr 2021 08:59:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F220C000F;
	Thu, 22 Apr 2021 08:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 061DCC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D414A405C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Igod6devoZTV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD804405BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619081961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfOVe3Y2pHcez7ttpJdj+ZOGuypmISBrFuEMjlM7SWw=;
 b=PeIjTMVn/Nn6OLtaRzw81XpiFEQy5dNVRQ5qFqHcuhCUiRrut9MpehFiuh28qHsFeLhsRJ
 zY5IZxLL3peBFjd09rn1vlRgYeKu7Lwtp72yy54/xNPwkg/GCNZPtpBC4YbJxvnI/1SAgs
 MIvdEaiKumNRttcMVC0GJ5zXyDs2v3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-wOlUl2CiOTmPIkIts6VkwQ-1; Thu, 22 Apr 2021 04:59:19 -0400
X-MC-Unique: wOlUl2CiOTmPIkIts6VkwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CAD1926DA0;
 Thu, 22 Apr 2021 08:59:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-137.pek2.redhat.com
 [10.72.13.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3804360938;
 Thu, 22 Apr 2021 08:59:12 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
 <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
Date: Thu, 22 Apr 2021 16:59:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzQvMjIg5LiL5Y2INDozOSwgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBUaHUsIEFw
ciAyMiwgMjAyMSBhdCAwNDoyMTo0NVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS80LzIyIOS4i+WNiDQ6MDcsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+PiBPbiBUaHUsIEFwciAy
MiwgMjAyMSBhdCAwOTowMzo1OEFNICswMzAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gT24gVGh1
LCBBcHIgMjIsIDIwMjEgYXQgMTA6Mzc6MzhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
Pj4g5ZyoIDIwMjEvNC8yMSDkuIvljYg2OjQxLCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+Pj4gSW1w
bGVtZW50IG1seDVfZ2V0X3ZxX25vdGlmaWNhdGlvbigpIHRvIHJldHVybiB0aGUgZG9vcmJlbGwg
YWRkcmVzcy4KPj4+Pj4+IFNpemUgaXMgc2V0IHRvIG9uZSBzeXN0ZW0gcGFnZSBhcyByZXF1aXJl
ZC4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gICAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBh
LmggfCAxICsKPj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHwg
MSArCj4+Pj4+PiAgICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8IDYgKysr
KysrCj4+Pj4+PiAgICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPj4+Pj4+Cj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+IGluZGV4IGI2Y2M1M2JhOTgw
Yy4uNDlkZTYyY2RhNTk4IDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaAo+Pj4+Pj4gQEAgLTQxLDYgKzQxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNvdXJjZXMg
ewo+Pj4+Pj4gICAgIAl1MzIgcGRuOwo+Pj4+Pj4gICAgIAlzdHJ1Y3QgbWx4NV91YXJzX3BhZ2Ug
KnVhcjsKPj4+Pj4+ICAgICAJdm9pZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4+Pj4+PiArCXU2NCBw
aHlzX2tpY2tfYWRkcjsKPj4+Pj4+ICAgICAJdTE2IHVpZDsKPj4+Pj4+ICAgICAJdTMyIG51bGxf
bWtleTsKPj4+Pj4+ICAgICAJYm9vbCB2YWxpZDsKPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNv
dXJjZXMuYwo+Pj4+Pj4gaW5kZXggNjUyMWNiZDBmNWMyLi42NjVmOGZjMTcxMGYgMTAwNjQ0Cj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+Pj4+PiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+Pj4+PiBAQCAtMjQ3LDYgKzI0
Nyw3IEBAIGludCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldikKPj4+Pj4+ICAgICAJCWdvdG8gZXJyX2tleTsKPj4+Pj4+ICAgICAJa2lja19hZGRy
ID0gbWRldi0+YmFyX2FkZHIgKyBvZmZzZXQ7Cj4+Pj4+PiArCXJlcy0+cGh5c19raWNrX2FkZHIg
PSBraWNrX2FkZHI7Cj4+Pj4+PiAgICAgCXJlcy0+a2lja19hZGRyID0gaW9yZW1hcChraWNrX2Fk
ZHIsIFBBR0VfU0laRSk7Cj4+Pj4+PiAgICAgCWlmICghcmVzLT5raWNrX2FkZHIpIHsKPj4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+IGluZGV4IDEwYzVmZWYzYzAyMC4uNjgw
NzUxMDc0ZDJhIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+
Pj4+IEBAIC0xODY1LDggKzE4NjUsMTQgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2ZyZWUoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4+Pj4gICAgIHN0YXRpYyBzdHJ1Y3QgdmRwYV9ub3Rp
ZmljYXRpb25fYXJlYSBtbHg1X2dldF92cV9ub3RpZmljYXRpb24oc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1MTYgaWR4KQo+Pj4+Pj4gICAgIHsKPj4+Pj4+ICsJc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+Pj4+PiAgICAgCXN0cnVjdCB2ZHBhX25vdGlm
aWNhdGlvbl9hcmVhIHJldCA9IHt9Owo+Pj4+Pj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRl
djsKPj4+Pj4+ICsKPj4+Pj4+ICsJbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPj4+
Pj4+ICsJcmV0LmFkZHIgPSAocGh5c19hZGRyX3QpbmRldi0+bXZkZXYucmVzLnBoeXNfa2lja19h
ZGRyOwo+Pj4+Pj4gKwlyZXQuc2l6ZSA9IFBBR0VfU0laRTsKPj4+Pj4gTm90ZSB0aGF0IHRoZSBw
YWdlIHdpbGwgYmUgbWFwcGVkIGluIHRvIGd1ZXN0LCBzbyBpdCdzIG9ubHkgc2FmZSBpZiB0aGUK
Pj4+Pj4gZG9vcmJlZWwgZXhjbHVzaXZlbHkgb3duIHRoZSBwYWdlLiBUaGlzIG1lYW5zIGlmIHRo
ZXJlJ3JlIG90aGVyIHJlZ2lzdGVycyBpbgo+Pj4+PiB0aGUgcGFnZSwgd2UgY2FuIG5vdCBsZXQg
dGhlIGRvb3JiZWxsIGJ5cGFzcyB0byB3b3JrLgo+Pj4+Pgo+Pj4+PiBTbyB0aGlzIGlzIHN1c3Bp
Y2lvdXMgYXQgbGVhc3QgaW4gdGhlIGNhc2Ugb2Ygc3ViZnVuY3Rpb24gd2hlcmUgd2UgY2FsY3Vs
YXRlCj4+Pj4+IHRoZSBiYXIgbGVuZ3RoIGluIG1seDVfc2ZfZGV2X3RhYmxlX2NyZWF0ZSgpIGFz
Ogo+Pj4+Pgo+Pj4+PiB0YWJsZS0+c2ZfYmFyX2xlbmd0aCA9IDEgPDwgKE1MWDVfQ0FQX0dFTihk
ZXYsIGxvZ19taW5fc2Zfc2l6ZSkgKyAxMik7Cj4+Pj4+Cj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRo
aXMgY2FuIG9ubHkgd29yayBmb3IgdGhlIGFyY2ggd2l0aCBQQUdFX1NJWkUgPSA0MDk2LAo+Pj4+
PiBvdGhlcndpc2Ugd2UgY2FuIG1hcCBtb3JlIGludG8gdGhlIHVzZXJzcGFjZShndWVzdCkuCj4+
Pj4+Cj4+Pj4gQ29ycmVjdCwgc28gSSBndWVzcyBJIHNob3VsZCByZXR1cm4gaGVyZSA0MDk2Lgo+
Pgo+PiBJJ20gbm90IHF1aXRlIHN1cmUgYnV0IHNpbmNlIHRoZSBjYWxjdWxhdGlvbiBvZiB0aGUg
c2ZfYmFyX2xlbmd0aCBpcyBkb2VuCj4+IHZpYSBhIHNoaWZ0IG9mIDEyLCBpdCBtaWdodCBiZSBj
b3JyZWN0Lgo+Pgo+PiBBbmQgcGxlYXNlIGRvdWJsZSBjaGVjayBpZiB0aGUgZG9vcmJlbGwgb3du
IHRoZSBwYWdlIGV4Y2x1c2l2ZWx5Lgo+IEkgYW0gY2hlY2tpbmcgaWYgaXQgaXMgc2FmZSB0byBt
YXAgdGhlIGFueSBwYXJ0IG9mIHRoZSBTRidzIEJBUiB0bwo+IHVzZXJzcGFjZSB3aXRob3V0IGhh
cm1pbmcgb3RoZXIgZnVuY3Rpb25zLiBJZiB0aGlzIGlzIHRydWUsIEkgd2lsbCBjaGVjawo+IGlm
IEkgY2FuIHJldHVybiBQQUdFX1NJWkUgd2l0aG91dCBjb21wcm9taXNpbmcgc2VjdXJpdHkuCgoK
SXQncyB1c2FsbHkgbm90IHNhZmUgYW5kIGEgbGF5ZXIgdmlvbGF0aW9uIGlmIG90aGVyIHJlZ2lz
dGVycyBhcmUgcGxhY2VkIAphdCB0aGUgc2FtZSBwYWdlLgoKCj4gICBJIHRoaW5rIHdlIG1heQo+
IG5lZWQgdG8gZXh0ZW5kIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIHRvIGNvbnRhaW4g
YW5vdGhlciBmaWVsZAo+IG9mZnNldCB3aGljaCBpbmRpY2F0ZXMgdGhlIG9mZnNldCBmcm9tIGFk
ZHIgd2hlcmUgdGhlIGFjdHVhbCBkb29yYmVsbAo+IHJlc2lkZXMuCgoKVGhlIG1vdml0aWF0b24g
b2YgdGhlIGN1cnJlbnQgZGVzaWduIGlzIHRvIGJlIGZpdCBzZWFtbGVzcyBpbnRvIGhvdyBRZW11
IAptb2RlbCBkb29yYmVsbCBsYXlvdXRzIGN1cnJlbnRseToKCjEpIHBhZ2UtcGVyLXZxLCBlYWNo
IHZxIGhhcyBpdHMgb3duIHBhZ2UgYWxpZ25lZCBkb29yYmVsbAoyKSAyIGJ5dGVzIGRvb3JiZWxs
LCBlYWNoIHZxIGhhcyBpdHMgb3duIDIgYnl0ZSBhbGlnZW5kIGRvb3JiZWxsCgpPbmx5IDEpIGlz
IHN1cHBvcnQgaW4gdmhvc3QtdkRQQSAoYW5kIHZob3N0LXVzZXIpIHNpbmNlIGl0J3MgcmF0aGVy
IApzaW1wbGUgYW5kIHNlY3VyZSAocGFnZSBhbGlnbmVkKSB0byBiZSBtb2RlbGxlZCBhbmQgaW1w
bGVtZW50ZWQgdmlhIG1tYXAoKS4KCkV4cG9ydGluZyBhIGNvbXBsZXggbGF5b3V0IGlzIHBvc3Ni
aWxlIGJ1dCByZXF1aXJlcyBjYXJlZnVsIGRlc2lnbi4KCkFjdHVhbGx5LCB3ZSBoYWQgYW50b2hl
ciBvcHRpb24KCjMpIHNoYXJlZCBkb29yYmVsbDogYWxsIHZpcnRxdWV1ZSBzaGFyZXMgYSBzaW5n
bGUgcGFnZSBhbGlnbmVkIGRvb3JiZWxsCgpUaGlzIGlzIG5vdCB5ZXQgc3VwcG9ydGVkIGJ5IFFl
bXUuCgpUaGFua3MKCgo+Pgo+Pj4+IEkgYWxzbyB0aGluayB0aGF0IHRoZSBjaGVjayBpbiB2aG9z
dF92ZHBhX21tYXAoKSBzaG91bGQgdmVyaWZ5IHRoYXQgdGhlCj4+Pj4gcmV0dXJuZWQgc2l6ZSBp
cyBub3Qgc21hbGxlciB0aGFuIFBBR0VfU0laRSBiZWNhdXNlIHRoZSByZXR1cm5lZCBhZGRyZXNz
Cj4+PiBBY3R1YWxseSBJIHRoaW5rIGl0J3Mgb2sgc2luY2UgeW91IHZlcmlmeSB0aGUgc2l6ZSBl
cXVhbHMgdm1hLT52bV9lbmQgLQo+Pj4gdm1hLT52bV9zdGFydCB3aGljaCBtdXN0IGJlIGF0IGxl
YXN0IFBBR0VfU0laRS4KPj4KPj4gWWVzLgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+PiBtaWdodCBq
dXN0IGJlIGFsaWduZWQgdG8gUEFHRV9TSVpFLiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGVub2do
dCBidXQKPj4+PiBtYXliZSBhbHNvIHVzZSB0aGUgc2FtZSBsb2dpYyBpbiB2aG9zdF92ZHBhX2Zh
dWx0KCkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
