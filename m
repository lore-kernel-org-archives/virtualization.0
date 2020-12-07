Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5DEC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:54:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6202A22C7E
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202A22C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC631875A6;
	Mon,  7 Dec 2020 03:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOats4-xRIra; Mon,  7 Dec 2020 03:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F3E88753D;
	Mon,  7 Dec 2020 03:54:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AB8DC0FA7;
	Mon,  7 Dec 2020 03:54:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 817A4C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6968785F4E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwoCg7ixz5FL
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7414E85F33
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607313264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2mgpR5hlh3Amjrpkze++o1dwsDrV0P0MuQh4sXa0kQ=;
 b=HN10S+3EDpJ1eAeSl8iXb+O3TO7bVmHYawVh0yqfRHJ0jWFWdfFGers+mLg5tE34m8tT7H
 L+I+iUmHe26mSYllehZ3TFuF6Okz56rPDw4DGbC72eXGsroCamW1MpwTCN5vOVGIofo2Tg
 3rma31HdMmkpxtOTncJyWE8CrosLdE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-smFEc9h9OFOYI4RTQfovkg-1; Sun, 06 Dec 2020 22:54:21 -0500
X-MC-Unique: smFEc9h9OFOYI4RTQfovkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1423B107ACE4;
 Mon,  7 Dec 2020 03:54:20 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06B0B10016DB;
 Mon,  7 Dec 2020 03:54:13 +0000 (UTC)
Subject: Re: [PATCH net-next] tun: fix ubuf refcount incorrectly on error path
To: wangyunjian <wangyunjian@huawei.com>, "mst@redhat.com" <mst@redhat.com>
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <094f1828-9a73-033e-b1ca-43b73588d22b@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB4E07B@dggemm513-mbx.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e972e42b-4344-31dc-eb4c-d963adb08a5c@redhat.com>
Date: Mon, 7 Dec 2020 11:54:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB4E07B@dggemm513-mbx.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>, xudingke <xudingke@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjAvMTIvNCDkuIvljYg2OjIyLCB3YW5neXVuamlhbiB3cm90ZToKPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogSmFzb24gV2FuZyBbbWFpbHRvOmphc293YW5nQHJl
ZGhhdC5jb21dCj4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNCwgMjAyMCAyOjExIFBNCj4+IFRv
OiB3YW5neXVuamlhbiA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT47IG1zdEByZWRoYXQuY29tCj4+
IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgTGlsaWp1bgo+PiAoSmVycnkpIDxqZXJyeS5saWxpanVuQGh1YXdlaS5j
b20+OyB4dWRpbmdrZSA8eHVkaW5na2VAaHVhd2VpLmNvbT4KPj4gU3ViamVjdDogUmU6IFtQQVRD
SCBuZXQtbmV4dF0gdHVuOiBmaXggdWJ1ZiByZWZjb3VudCBpbmNvcnJlY3RseSBvbiBlcnJvciBw
YXRoCj4+Cj4+Cj4+IE9uIDIwMjAvMTIvMyDkuIvljYg0OjAwLCB3YW5neXVuamlhbiB3cm90ZToK
Pj4+IEZyb206IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPj4+Cj4+PiBB
ZnRlciBzZXR0aW5nIGNhbGxiYWNrIGZvciB1YnVmX2luZm8gb2Ygc2tiLCB0aGUgY2FsbGJhY2sK
Pj4+ICh2aG9zdF9uZXRfemVyb2NvcHlfY2FsbGJhY2spIHdpbGwgYmUgY2FsbGVkIHRvIGRlY3Jl
YXNlIHRoZSByZWZjb3VudAo+Pj4gd2hlbiBmcmVlaW5nIHNrYi4gQnV0IHdoZW4gYW4gZXhjZXB0
aW9uIG9jY3VycyBhZnRlcndhcmRzLCB0aGUgZXJyb3IKPj4+IGhhbmRsaW5nIGluIHZob3N0IGhh
bmRsZV90eCgpIHdpbGwgdHJ5IHRvIGRlY3JlYXNlIHRoZSBzYW1lIHJlZmNvdW50Cj4+PiBhZ2Fp
bi4gVGhpcyBpcyB3cm9uZyBhbmQgZml4IHRoaXMgYnkgY2xlYXJpbmcgdWJ1Zl9pbmZvIHdoZW4g
bWVldGluZwo+Pj4gZXJyb3JzLgo+Pj4KPj4+IEZpeGVzOiA0NDc3MTM4ZmEwYWUgKCJ0dW46IHBy
b3Blcmx5IHRlc3QgZm9yIElGRl9VUCIpCj4+PiBGaXhlczogOTBlMzNkNDU5NDA3ICgidHVuOiBl
bmFibGUgbmFwaV9ncm9fZnJhZ3MoKSBmb3IgVFVOL1RBUAo+Pj4gZHJpdmVyIikKPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBZdW5qaWFuIFdhbmcgPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+Cj4+PiAt
LS0KPj4+ICAgIGRyaXZlcnMvbmV0L3R1bi5jIHwgMTEgKysrKysrKysrKysKPj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3R1bi5jIGIvZHJpdmVycy9uZXQvdHVuLmMgaW5kZXgKPj4+IDJkYzE5ODhhODk3My4uMzYx
NGJiMWI2ZDM1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMKPj4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3R1bi5jCj4+PiBAQCAtMTg2MSw2ICsxODYxLDEyIEBAIHN0YXRpYyBzc2l6ZV90
IHR1bl9nZXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdAo+PiAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUg
KnRmaWxlLAo+Pj4gICAgCWlmICh1bmxpa2VseSghKHR1bi0+ZGV2LT5mbGFncyAmIElGRl9VUCkp
KSB7Cj4+PiAgICAJCWVyciA9IC1FSU87Cj4+PiAgICAJCXJjdV9yZWFkX3VubG9jaygpOwo+Pj4g
KwkJaWYgKHplcm9jb3B5KSB7Cj4+PiArCQkJc2tiX3NoaW5mbyhza2IpLT5kZXN0cnVjdG9yX2Fy
ZyA9IE5VTEw7Cj4+PiArCQkJc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyAmPSB+U0tCVFhfREVW
X1pFUk9DT1BZOwo+Pj4gKwkJCXNrYl9zaGluZm8oc2tiKS0+dHhfZmxhZ3MgJj0gflNLQlRYX1NI
QVJFRF9GUkFHOwo+Pj4gKwkJfQo+Pj4gKwo+Pj4gICAgCQlnb3RvIGRyb3A7Cj4+PiAgICAJfQo+
Pj4KPj4+IEBAIC0xODc0LDYgKzE4ODAsMTEgQEAgc3RhdGljIHNzaXplX3QgdHVuX2dldF91c2Vy
KHN0cnVjdCB0dW5fc3RydWN0Cj4+PiAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLAo+Pj4K
Pj4+ICAgIAkJaWYgKHVubGlrZWx5KGhlYWRsZW4gPiBza2JfaGVhZGxlbihza2IpKSkgewo+Pj4g
ICAgCQkJYXRvbWljX2xvbmdfaW5jKCZ0dW4tPmRldi0+cnhfZHJvcHBlZCk7Cj4+PiArCQkJaWYg
KHplcm9jb3B5KSB7Cj4+PiArCQkJCXNrYl9zaGluZm8oc2tiKS0+ZGVzdHJ1Y3Rvcl9hcmcgPSBO
VUxMOwo+Pj4gKwkJCQlza2Jfc2hpbmZvKHNrYiktPnR4X2ZsYWdzICY9IH5TS0JUWF9ERVZfWkVS
T0NPUFk7Cj4+PiArCQkJCXNrYl9zaGluZm8oc2tiKS0+dHhfZmxhZ3MgJj0gflNLQlRYX1NIQVJF
RF9GUkFHOwo+Pj4gKwkJCX0KPj4+ICAgIAkJCW5hcGlfZnJlZV9mcmFncygmdGZpbGUtPm5hcGkp
Owo+Pj4gICAgCQkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4+PiAgICAJCQltdXRleF91bmxvY2soJnRm
aWxlLT5uYXBpX211dGV4KTsKPj4KPj4gSXQgbG9va3MgdG8gbWUgdGhlbiB3ZSBtaXNzIHRoZSBm
YWlsdXJlIGZlZWRiYWNrLgo+Pgo+PiBUaGUgaXNzdWVzIGNvbWVzIGZyb20gdGhlIGluY29uc2lz
dGVudCBlcnJvciBoYW5kbGluZyBpbiB0dW4uCj4+Cj4+IEkgd29uZGVyIHdoZXRoZXIgd2UgY2Fu
IHNpbXBseSBkbyB1YXJnLT5jYWxsYmFjayh1YXJnLCBmYWxzZSkgaWYgbmVjZXNzYXJ5IG9uCj4+
IGV2ZXJ5IGZhaWx0dXJlIHBhdGggb24gdHVuX2dldF91c2VyKCkuCj4gSG93IGFib3V0IHRoaXM/
Cj4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3R1bi5jIHwgMjkgKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1
bi5jCj4gaW5kZXggMmRjMTk4OGE4OTczLi4zNmE4ZDhlYWNkN2IgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9uZXQvdHVuLmMKPiArKysgYi9kcml2ZXJzL25ldC90dW4uYwo+IEBAIC0xNjM3LDYgKzE2
MzcsMTkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICp0dW5fYnVpbGRfc2tiKHN0cnVjdCB0dW5f
c3RydWN0ICp0dW4sCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiArLyogY29weSB1YnVm
X2luZm8gZm9yIGNhbGxiYWNrIHdoZW4gc2tiIGhhcyBubyBlcnJvciAqLwo+ICtpbmxpbmUgc3Rh
dGljIHR1bl9jb3B5X3VidWZfaW5mbyhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBib29sIHplcm9jb3B5
LCB2b2lkICptc2dfY29udHJvbCkKPiArewo+ICsJaWYgKHplcm9jb3B5KSB7Cj4gKwkJc2tiX3No
aW5mbyhza2IpLT5kZXN0cnVjdG9yX2FyZyA9IG1zZ19jb250cm9sOwo+ICsJCXNrYl9zaGluZm8o
c2tiKS0+dHhfZmxhZ3MgfD0gU0tCVFhfREVWX1pFUk9DT1BZOwo+ICsJCXNrYl9zaGluZm8oc2ti
KS0+dHhfZmxhZ3MgfD0gU0tCVFhfU0hBUkVEX0ZSQUc7Cj4gKwl9IGVsc2UgaWYgKG1zZ19jb250
cm9sKSB7Cj4gKwkJc3RydWN0IHVidWZfaW5mbyAqdWFyZyA9IG1zZ19jb250cm9sOwo+ICsJCXVh
cmctPmNhbGxiYWNrKHVhcmcsIGZhbHNlKTsKPiArCX0KPiArfQo+ICsKPiAgIC8qIEdldCBwYWNr
ZXQgZnJvbSB1c2VyIHNwYWNlIGJ1ZmZlciAqLwo+ICAgc3RhdGljIHNzaXplX3QgdHVuX2dldF91
c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sIHN0cnVjdCB0dW5fZmlsZSAqdGZpbGUsCj4gICAJ
CQkgICAgdm9pZCAqbXNnX2NvbnRyb2wsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSwKPiBAQCAtMTgx
MiwxNiArMTgyNSw2IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9nZXRfdXNlcihzdHJ1Y3QgdHVuX3N0
cnVjdCAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLAo+ICAgCQlicmVhazsKPiAgIAl9Cj4g
ICAKPiAtCS8qIGNvcHkgc2tiX3VidWZfaW5mbyBmb3IgY2FsbGJhY2sgd2hlbiBza2IgaGFzIG5v
IGVycm9yICovCj4gLQlpZiAoemVyb2NvcHkpIHsKPiAtCQlza2Jfc2hpbmZvKHNrYiktPmRlc3Ry
dWN0b3JfYXJnID0gbXNnX2NvbnRyb2w7Cj4gLQkJc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyB8
PSBTS0JUWF9ERVZfWkVST0NPUFk7Cj4gLQkJc2tiX3NoaW5mbyhza2IpLT50eF9mbGFncyB8PSBT
S0JUWF9TSEFSRURfRlJBRzsKPiAtCX0gZWxzZSBpZiAobXNnX2NvbnRyb2wpIHsKPiAtCQlzdHJ1
Y3QgdWJ1Zl9pbmZvICp1YXJnID0gbXNnX2NvbnRyb2w7Cj4gLQkJdWFyZy0+Y2FsbGJhY2sodWFy
ZywgZmFsc2UpOwo+IC0JfQo+IC0KPiAgIAlza2JfcmVzZXRfbmV0d29ya19oZWFkZXIoc2tiKTsK
PiAgIAlza2JfcHJvYmVfdHJhbnNwb3J0X2hlYWRlcihza2IpOwo+ICAgCXNrYl9yZWNvcmRfcnhf
cXVldWUoc2tiLCB0ZmlsZS0+cXVldWVfaW5kZXgpOwo+IEBAIC0xODMwLDYgKzE4MzMsNyBAQCBz
dGF0aWMgc3NpemVfdCB0dW5fZ2V0X3VzZXIoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgc3RydWN0
IHR1bl9maWxlICp0ZmlsZSwKPiAgIAkJc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPiAgIAkJ
aW50IHJldDsKPiAgIAo+ICsJCXR1bl9jb3B5X3VidWZfaW5mbyhza2IsIHplcm9jb3B5LCBtc2df
Y29udHJvbCk7CgoKSWYgeW91IHRoaW5rIGRpc2FibGluZyB6ZXJvY29weSBmb3IgWERQICh3aGlj
aCBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlKS4gCkl0J3MgYmV0dGVyIHRvIGRvIHRoaXMgaW4gYW5v
dGhlciBwYXRjaC4KCgo+ICAgCQlsb2NhbF9iaF9kaXNhYmxlKCk7Cj4gICAJCXJjdV9yZWFkX2xv
Y2soKTsKPiAgIAkJeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UodHVuLT54ZHBfcHJvZyk7Cj4g
QEAgLTE4ODAsNyArMTg4NCw3IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9nZXRfdXNlcihzdHJ1Y3Qg
dHVuX3N0cnVjdCAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLAo+ICAgCQkJV0FSTl9PTigx
KTsKPiAgIAkJCXJldHVybiAtRU5PTUVNOwo+ICAgCQl9Cj4gLQo+ICsJCXR1bl9jb3B5X3VidWZf
aW5mbyhza2IsIHplcm9jb3B5LCBtc2dfY29udHJvbCk7CgoKQW5kIGZvciBOQVBJIGZyYWdzLgoK
Cj4gICAJCWxvY2FsX2JoX2Rpc2FibGUoKTsKPiAgIAkJbmFwaV9ncm9fZnJhZ3MoJnRmaWxlLT5u
YXBpKTsKPiAgIAkJbG9jYWxfYmhfZW5hYmxlKCk7Cj4gQEAgLTE4ODksNiArMTg5Myw3IEBAIHN0
YXRpYyBzc2l6ZV90IHR1bl9nZXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLCBzdHJ1Y3Qg
dHVuX2ZpbGUgKnRmaWxlLAo+ICAgCQlzdHJ1Y3Qgc2tfYnVmZl9oZWFkICpxdWV1ZSA9ICZ0Zmls
ZS0+c2suc2tfd3JpdGVfcXVldWU7Cj4gICAJCWludCBxdWV1ZV9sZW47Cj4gICAKPiArCQl0dW5f
Y29weV91YnVmX2luZm8oc2tiLCB6ZXJvY29weSwgbXNnX2NvbnRyb2wpOwo+ICAgCQlzcGluX2xv
Y2tfYmgoJnF1ZXVlLT5sb2NrKTsKPiAgIAkJX19za2JfcXVldWVfdGFpbChxdWV1ZSwgc2tiKTsK
PiAgIAkJcXVldWVfbGVuID0gc2tiX3F1ZXVlX2xlbihxdWV1ZSk7Cj4gQEAgLTE4OTksOCArMTkw
NCwxMCBAQCBzdGF0aWMgc3NpemVfdCB0dW5fZ2V0X3VzZXIoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1
biwgc3RydWN0IHR1bl9maWxlICp0ZmlsZSwKPiAgIAo+ICAgCQlsb2NhbF9iaF9lbmFibGUoKTsK
PiAgIAl9IGVsc2UgaWYgKCFJU19FTkFCTEVEKENPTkZJR180S1NUQUNLUykpIHsKPiArCQl0dW5f
Y29weV91YnVmX2luZm8oc2tiLCB6ZXJvY29weSwgbXNnX2NvbnRyb2wpOwo+ICAgCQl0dW5fcnhf
YmF0Y2hlZCh0dW4sIHRmaWxlLCBza2IsIG1vcmUpOwo+ICAgCX0gZWxzZSB7Cj4gKwkJdHVuX2Nv
cHlfdWJ1Zl9pbmZvKHNrYiwgemVyb2NvcHksIG1zZ19jb250cm9sKTsKPiAgIAkJbmV0aWZfcnhf
bmkoc2tiKTsKPiAgIAl9Cj4gICAJcmN1X3JlYWRfdW5sb2NrKCk7CgoKU28gaXQgbG9va3MgdG8g
bWUgeW91IHdhbnQgdG8gZGlzYWJsZSB6ZXJvY29weSBpbiBhbGwgb2YgdGhlIHBvc3NpYmxlIApk
YXRhcGF0aD8KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
