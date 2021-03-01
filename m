Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB335C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 06:24:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B95464DF1
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 06:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B95464DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8C42842EC;
	Mon,  1 Mar 2021 06:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdmCmVoPaVOs; Mon,  1 Mar 2021 06:24:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71053842E9;
	Mon,  1 Mar 2021 06:24:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50A18C000A;
	Mon,  1 Mar 2021 06:24:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CDCC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 06:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E421D42D1B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 06:24:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjYeL6fm-wLH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 06:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA8C542D19
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614579875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8TAxYYg7937/MNm6gI3QQ1GQZAxezLvaR25kvT1TIE=;
 b=Ddss9Y4DOSz6WLfRptKMqouCYvWnKZqtFkpfU8zH/PFUl7LROYTS4qrL2mIuiEScbun34y
 LykAsPkQ0SIMS40QgLOrPRwzHWY3gP8Dk0e5Z96fWcamlW7HeoLzmToCr9ZsZP2f2entWZ
 hPVk7vqKH01HoGOpuDq5Yc9AJ2FBJc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-5Hv8IO15MTWghoDS3Y9DsA-1; Mon, 01 Mar 2021 01:24:29 -0500
X-MC-Unique: 5Hv8IO15MTWghoDS3Y9DsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FFE0107ACFC;
 Mon,  1 Mar 2021 06:24:27 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-230.pek2.redhat.com
 [10.72.13.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAEEC5D9DE;
 Mon,  1 Mar 2021 06:24:12 +0000 (UTC)
Subject: Re: [RFC v2 7/7] vhost: Route host->guest notification through shadow
 virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3df92e05-95c5-536e-150a-b5be8d6e149e@redhat.com>
Date: Mon, 1 Mar 2021 14:24:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-8-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
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

Ck9uIDIwMjEvMi85IDExOjM3IOS4i+WNiCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4gU2lnbmVk
LW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBo
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgIDIgKysKPiAgIGh3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCA0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiAgIGh3L3ZpcnRpby92aG9zdC5jICAgICAgICAgICAgICAgICAgfCAgNSArKy0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhv
c3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5kZXggYzQ1MDM1YzRiNy4uMjEwMTMzNDM0YyAxMDA2
NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+IEBAIC0xNyw2ICsxNyw4IEBACj4gICAK
PiAgIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93VmlydHF1ZXVlIFZob3N0U2hhZG93VmlydHF1
ZXVlOwo+ICAgCj4gK0V2ZW50Tm90aWZpZXIgKnZob3N0X3NoYWRvd192cV9nZXRfY2FsbF9ub3Rp
ZmllcihWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdnEpOwo+ICsKPiAgIGJvb2wgdmhvc3Rfc2hhZG93
X3ZxX3N0YXJ0X3JjdShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaWR4LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEpOwo+IGRpZmYgLS1naXQgYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0
cXVldWUuYwo+IGluZGV4IDAxZjI4MmQ0MzQuLjYxZDk4YWU2NTIgMTAwNjQ0Cj4gLS0tIGEvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1z
aGFkb3ctdmlydHF1ZXVlLmMKPiBAQCAtMjQsNiArMjQsOCBAQCB0eXBlZGVmIHN0cnVjdCBWaG9z
dFNoYWRvd1ZpcnRxdWV1ZSB7Cj4gICAKPiAgICAgICAvKiBCb3Jyb3dlZCB2aXJ0cXVldWUncyBn
dWVzdCB0byBob3N0IG5vdGlmaWVyLiAqLwo+ICAgICAgIEV2ZW50Tm90aWZpZXIgaG9zdF9ub3Rp
ZmllcjsKPiArICAgIC8qIEhvc3QgdG8gZ3Vlc3Qgbm90aWZpZXIgKi8KPiArICAgIEV2ZW50Tm90
aWZpZXIgKmd1ZXN0X25vdGlmaWVyOwo+ICAgCj4gICAgICAgLyogVmlydGlvIHF1ZXVlIHNoYWRv
d2luZyAqLwo+ICAgICAgIFZpcnRRdWV1ZSAqdnE7Cj4gQEAgLTQwLDYgKzQyLDI2IEBAIHN0YXRp
YyB2b2lkIHZob3N0X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50Tm90aWZpZXIgKm4pCj4gICAgICAg
fQo+ICAgfQo+ICAgCj4gKy8qIEZvcndhcmQgdmhvc3Qgbm90aWZpY2F0aW9ucyAqLwo+ICtzdGF0
aWMgdm9pZCB2aG9zdF9oYW5kbGVfY2FsbChFdmVudE5vdGlmaWVyICpuKQo+ICt7Cj4gKyAgICBW
aG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gY29udGFpbmVyX29mKG4sIFZob3N0U2hhZG93Vmly
dHF1ZXVlLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
YWxsX25vdGlmaWVyKTsKPiArCj4gKyAgICBpZiAoZXZlbnRfbm90aWZpZXJfdGVzdF9hbmRfY2xl
YXIobikpIHsKPiArICAgICAgICBldmVudF9ub3RpZmllcl9zZXQoc3ZxLT5ndWVzdF9ub3RpZmll
cik7Cj4gKyAgICB9Cj4gK30KCgpTbyBJIHdvbmRlciBob3cgdGhpcyBpcyBzeW5jaG9uaXplZCB3
aXRoIHZpcnRxdWV1ZSBtYXNrL3VubWFzay4gT3IgdGhlIAptYXNraW5nIGlzIHRvdGFsbHkgdHJh
bnNwYXJlbnQgdG8gc2hhZG93IHZpcnRxdWV1ZT8KClRoYW5rcwoKCj4gKwo+ICsvKgo+ICsgKiBH
ZXQgdGhlIHZob3N0IGNhbGwgbm90aWZpZXIgb2YgdGhlIHNoYWRvdyB2cQo+ICsgKiBAdnEgU2hh
ZG93IHZpcnRxdWV1ZQo+ICsgKi8KPiArRXZlbnROb3RpZmllciAqdmhvc3Rfc2hhZG93X3ZxX2dl
dF9jYWxsX25vdGlmaWVyKFZob3N0U2hhZG93VmlydHF1ZXVlICp2cSkKPiArewo+ICsgICAgcmV0
dXJuICZ2cS0+Y2FsbF9ub3RpZmllcjsKPiArfQo+ICsKPiAgIC8qCj4gICAgKiBTdGFydCBzaGFk
b3cgdmlydHF1ZXVlIG9wZXJhdGlvbi4KPiAgICAqIEBkZXYgdmhvc3QgZGV2aWNlCj4gQEAgLTU3
LDYgKzc5LDEwIEBAIGJvb2wgdmhvc3Rfc2hhZG93X3ZxX3N0YXJ0X3JjdShzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsCj4gICAgICAgICAgIC5pbmRleCA9IGlkeCwKPiAgICAgICAgICAgLmZkID0gZXZl
bnRfbm90aWZpZXJfZ2V0X2ZkKCZzdnEtPmtpY2tfbm90aWZpZXIpLAo+ICAgICAgIH07Cj4gKyAg
ICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfZmlsZSBjYWxsX2ZpbGUgPSB7Cj4gKyAgICAgICAgLmluZGV4
ID0gaWR4LAo+ICsgICAgICAgIC5mZCA9IGV2ZW50X25vdGlmaWVyX2dldF9mZCgmc3ZxLT5jYWxs
X25vdGlmaWVyKSwKPiArICAgIH07Cj4gICAgICAgaW50IHI7Cj4gICAKPiAgICAgICAvKiBDaGVj
ayB0aGF0IG5vdGlmaWNhdGlvbnMgYXJlIHN0aWxsIGdvaW5nIGRpcmVjdGx5IHRvIHZob3N0IGRl
diAqLwo+IEBAIC02Niw2ICs5Miw3IEBAIGJvb2wgdmhvc3Rfc2hhZG93X3ZxX3N0YXJ0X3JjdShz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVu
dF9ub3RpZmllcl9nZXRfZmQodnFfaG9zdF9ub3RpZmllcikpOwo+ICAgICAgIGV2ZW50X25vdGlm
aWVyX3NldF9oYW5kbGVyKCZzdnEtPmhvc3Rfbm90aWZpZXIsIHZob3N0X2hhbmRsZV9ndWVzdF9r
aWNrKTsKPiAgIAo+ICsgICAgc3ZxLT5ndWVzdF9ub3RpZmllciA9IHZpcnRpb19xdWV1ZV9nZXRf
Z3Vlc3Rfbm90aWZpZXIoc3ZxLT52cSk7Cj4gICAgICAgciA9IGRldi0+dmhvc3Rfb3BzLT52aG9z
dF9zZXRfdnJpbmdfa2ljayhkZXYsICZraWNrX2ZpbGUpOwo+ICAgICAgIGlmICh1bmxpa2VseShy
ICE9IDApKSB7Cj4gICAgICAgICAgIGVycm9yX3JlcG9ydCgiQ291bGRuJ3Qgc2V0IGtpY2sgZmQ6
ICVzIiwgc3RyZXJyb3IoZXJybm8pKTsKPiBAQCAtNzUsOCArMTAyLDE5IEBAIGJvb2wgdmhvc3Rf
c2hhZG93X3ZxX3N0YXJ0X3JjdShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAgICAgLyogQ2hl
Y2sgZm9yIHBlbmRpbmcgbm90aWZpY2F0aW9ucyBmcm9tIHRoZSBndWVzdCAqLwo+ICAgICAgIHZo
b3N0X2hhbmRsZV9ndWVzdF9raWNrKCZzdnEtPmhvc3Rfbm90aWZpZXIpOwo+ICAgCj4gKyAgICBy
ID0gZGV2LT52aG9zdF9vcHMtPnZob3N0X3NldF92cmluZ19jYWxsKGRldiwgJmNhbGxfZmlsZSk7
Cj4gKyAgICBpZiAociAhPSAwKSB7Cj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDb3VsZG4ndCBz
ZXQgY2FsbCBmZDogJXMiLCBzdHJlcnJvcihlcnJubykpOwo+ICsgICAgICAgIGdvdG8gZXJyX3Nl
dF92cmluZ19jYWxsOwo+ICsgICAgfQo+ICsKPiAgICAgICByZXR1cm4gdHJ1ZTsKPiAgIAo+ICtl
cnJfc2V0X3ZyaW5nX2NhbGw6Cj4gKyAgICBraWNrX2ZpbGUuZmQgPSBldmVudF9ub3RpZmllcl9n
ZXRfZmQodnFfaG9zdF9ub3RpZmllcik7Cj4gKyAgICByID0gZGV2LT52aG9zdF9vcHMtPnZob3N0
X3NldF92cmluZ19raWNrKGRldiwgJmtpY2tfZmlsZSk7Cj4gKyAgICBhc3NlcnQociA9PSAwKTsK
PiArCj4gICBlcnJfc2V0X3ZyaW5nX2tpY2s6Cj4gICAgICAgZXZlbnRfbm90aWZpZXJfc2V0X2hh
bmRsZXIoJnN2cS0+aG9zdF9ub3RpZmllciwgTlVMTCk7Cj4gICAKPiBAQCAtMTA4LDYgKzE0Niwx
NiBAQCB2b2lkIHZob3N0X3NoYWRvd192cV9zdG9wX3JjdShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gICAgICAgYXNzZXJ0KHIgPT0gMCk7Cj4gICAKPiAgICAgICBldmVudF9ub3RpZmllcl9zZXRf
aGFuZGxlcigmc3ZxLT5ob3N0X25vdGlmaWVyLCBOVUxMKTsKPiArCj4gKyAgICBpZiAoIWRldi0+
dnFzW2lkeF0ubm90aWZpZXJfaXNfbWFza2VkKSB7Cj4gKyAgICAgICAgRXZlbnROb3RpZmllciAq
ZSA9IHZob3N0X3NoYWRvd192cV9nZXRfY2FsbF9ub3RpZmllcihzdnEpOwo+ICsKPiArICAgICAg
ICAvKiBSZXN0b3JlIHZob3N0IGNhbGwgKi8KPiArICAgICAgICB2aG9zdF92aXJ0cXVldWVfbWFz
ayhkZXYsIGRldi0+dmRldiwgZGV2LT52cV9pbmRleCArIGlkeCwgZmFsc2UpOwo+ICsKPiArICAg
ICAgICAvKiBDaGVjayBmb3IgcGVuZGluZyBjYWxscyAqLwo+ICsgICAgICAgIHZob3N0X2hhbmRs
ZV9jYWxsKGUpOwo+ICsgICAgfQo+ICAgfQo+ICAgCj4gICAvKgo+IEBAIC0xMzYsNiArMTg0LDcg
QEAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3NoYWRvd192cV9uZXcoc3RydWN0IHZob3N0
X2RldiAqZGV2LCBpbnQgaWR4KQo+ICAgICAgICAgICBnb3RvIGVycl9pbml0X2NhbGxfbm90aWZp
ZXI7Cj4gICAgICAgfQo+ICAgCj4gKyAgICBldmVudF9ub3RpZmllcl9zZXRfaGFuZGxlcigmc3Zx
LT5jYWxsX25vdGlmaWVyLCB2aG9zdF9oYW5kbGVfY2FsbCk7Cj4gICAgICAgcmV0dXJuIGdfc3Rl
YWxfcG9pbnRlcigmc3ZxKTsKPiAgIAo+ICAgZXJyX2luaXRfY2FsbF9ub3RpZmllcjoKPiBkaWZm
IC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYwo+IGluZGV4IDlk
NDcyOGU1NDUuLjBkYzk1Njc5ZTkgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPiAr
KysgYi9ody92aXJ0aW8vdmhvc3QuYwo+IEBAIC05NzUsNyArOTc1LDYgQEAgc3RhdGljIGludCB2
aG9zdF9zd19saXZlX21pZ3JhdGlvbl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICAg
ICAgICAgIGZvciAoaWR4ID0gMDsgaWR4IDwgZGV2LT5udnFzOyArK2lkeCkgewo+ICAgICAgICAg
ICAgICAgYm9vbCBvayA9IHZob3N0X3NoYWRvd192cV9zdGFydF9yY3UoZGV2LCBpZHgsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnNoYWRv
d192cXNbaWR4XSk7Cj4gLQo+ICAgICAgICAgICAgICAgaWYgKCFvaykgewo+ICAgICAgICAgICAg
ICAgICAgIGludCBzdG9wX2lkeCA9IGlkeDsKPiAgIAo+IEBAIC0xNjA4LDYgKzE2MDcsMTAgQEAg
dm9pZCB2aG9zdF92aXJ0cXVldWVfbWFzayhzdHJ1Y3Qgdmhvc3RfZGV2ICpoZGV2LCBWaXJ0SU9E
ZXZpY2UgKnZkZXYsIGludCBuLAo+ICAgICAgIGlmIChtYXNrKSB7Cj4gICAgICAgICAgIGFzc2Vy
dCh2ZGV2LT51c2VfZ3Vlc3Rfbm90aWZpZXJfbWFzayk7Cj4gICAgICAgICAgIGZpbGUuZmQgPSBl
dmVudF9ub3RpZmllcl9nZXRfZmQoJmhkZXYtPnZxc1tpbmRleF0ubWFza2VkX25vdGlmaWVyKTsK
PiArICAgIH0gZWxzZSBpZiAoaGRldi0+c3dfbG1fZW5hYmxlZCkgewo+ICsgICAgICAgIFZob3N0
U2hhZG93VmlydHF1ZXVlICpzdnEgPSBoZGV2LT5zaGFkb3dfdnFzW25dOwo+ICsgICAgICAgIEV2
ZW50Tm90aWZpZXIgKmUgPSB2aG9zdF9zaGFkb3dfdnFfZ2V0X2NhbGxfbm90aWZpZXIoc3ZxKTsK
PiArICAgICAgICBmaWxlLmZkID0gZXZlbnRfbm90aWZpZXJfZ2V0X2ZkKGUpOwo+ICAgICAgIH0g
ZWxzZSB7Cj4gICAgICAgICAgIGZpbGUuZmQgPSBldmVudF9ub3RpZmllcl9nZXRfZmQodmlydGlv
X3F1ZXVlX2dldF9ndWVzdF9ub3RpZmllcih2dnEpKTsKPiAgICAgICB9CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
