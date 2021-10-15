Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5410C433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 04:42:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9679D61073
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 04:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9679D61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6059B83B29;
	Fri, 15 Oct 2021 04:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RikUc23byWfI; Fri, 15 Oct 2021 04:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D965683AFA;
	Fri, 15 Oct 2021 04:42:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE23CC0011;
	Fri, 15 Oct 2021 04:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84CFEC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72F2B40148
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CyvClj_dJJTP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:42:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FEE14013C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 04:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634272956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ev6Z0qzvimi353HfswrUXLN6SxjrSKewjNzr2xVV6DA=;
 b=KcaZbuv1/VPQ+Cl50m1HHw5xHtuSFzYDkL2YZBQlkzSw6LgLk8G88LYxHT3NnE2h8ENQ1q
 4HD3JyisDNjm075NbQ9vtYoygzidHmkIrMP1/Q4JdatmZf6+FrP9G0FA1dFXWbh5/MQD/B
 wlRAwTrK8h9tbKtaDAczbtvTtv+/iGQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-CutoxP16P3uf2i5GrdBouw-1; Fri, 15 Oct 2021 00:42:34 -0400
X-MC-Unique: CutoxP16P3uf2i5GrdBouw-1
Received: by mail-pg1-f197.google.com with SMTP id
 n9-20020a63f809000000b0026930ed1b24so4417425pgh.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 21:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ev6Z0qzvimi353HfswrUXLN6SxjrSKewjNzr2xVV6DA=;
 b=y+pR7BhCnxlMQ0pQwoVDsQGnfRis3GVSAsEIid1dM0es3snjvJU82Y34jTOa3iUavt
 4Jshei927Qaxv0KIG6nKDDP+lDL4wMACY13dyMacI934nIYgyhc1tKDrCjgrM9+kIoWf
 Hax3ojEhUHL4gUlaGlqBVLOM7owvQfmyinWMjnczwJPMqdQi//H+jyjzw7Ro6rfH63WW
 eVjeD+96nJyee77dP9qA09xX61n9YKtlM2Boa9wCT2ZgKynwwlnHf5ZxKhgBoXCdpmNQ
 FnfTSOI7d7ut9Qjs29BI6HZq7Pwrav3PoUytczWkztedx0AoNfBEGbA//bYw/x7OMtWx
 RLlg==
X-Gm-Message-State: AOAM530C5GcleoFZDvJcoyRxYcfrWb6Jay78VnXaMBZ0EpZvlh6xynon
 acBfUj1e2qWD5QdVPBInYzUKjKxxHVnqB6QjrG4qewHwr1jHuBomvyi4wj4KU+ZGzOKVU+zzpjG
 vYAfRSPt+mOOl5AOVTl3OkZR8/m9ATq/mWdy0hD2qCA==
X-Received: by 2002:a05:6a00:1906:b0:44c:b35d:71a8 with SMTP id
 y6-20020a056a00190600b0044cb35d71a8mr9198175pfi.51.1634272953500; 
 Thu, 14 Oct 2021 21:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRWx7Ag3grRRVbolD2IXIQe3qcDijMltS+Q82Xf3UA9zjb+piV5VfjvVtOGrX3EeO3Gorjbg==
X-Received: by 2002:a05:6a00:1906:b0:44c:b35d:71a8 with SMTP id
 y6-20020a056a00190600b0044cb35d71a8mr9198140pfi.51.1634272953172; 
 Thu, 14 Oct 2021 21:42:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s52sm3762347pfw.4.2021.10.14.21.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Oct 2021 21:42:32 -0700 (PDT)
Subject: Re: [RFC PATCH v4 11/20] vhost: Route host->guest notification
 through shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-12-eperezma@redhat.com>
 <ab9a7771-5f9b-6413-3e38-bd3dc7373256@redhat.com>
 <CAJaqyWfm734HrwTJK71hUQNYVkyDaR8OiqtGro_AX9i_pXfmBQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78843cbf-0096-816b-da74-5406fdcc3783@redhat.com>
Date: Fri, 15 Oct 2021 12:42:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfm734HrwTJK71hUQNYVkyDaR8OiqtGro_AX9i_pXfmBQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzE1IOS4iuWNiDEyOjM5LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6
Cj4gT24gV2VkLCBPY3QgMTMsIDIwMjEgYXQgNTo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvMTAvMSDkuIvljYgzOjA1LCBFdWdlbmlv
IFDDqXJleiDlhpnpgZM6Cj4+PiBUaGlzIHdpbGwgbWFrZSBxZW11IGF3YXJlIG9mIHRoZSBkZXZp
Y2UgdXNlZCBidWZmZXJzLCBhbGxvd2luZyBpdCB0bwo+Pj4gd3JpdGUgdGhlIGd1ZXN0IG1lbW9y
eSB3aXRoIGl0cyBjb250ZW50cyBpZiBuZWVkZWQuCj4+Pgo+Pj4gU2luY2UgdGhlIHVzZSBvZiB2
aG9zdF92aXJ0cXVldWVfc3RhcnQgY2FuIHVubWFza3MgYW5kIGRpc2NhcmQgY2FsbAo+Pj4gZXZl
bnRzLCB2aG9zdF92aXJ0cXVldWVfc3RhcnQgc2hvdWxkIGJlIG1vZGlmaWVkIGluIG9uZSBvZiB0
aGVzZSB3YXlzOgo+Pj4gKiBTcGxpdCBpbiB0d286IE9uZSBvZiB0aGVtIHVzZXMgYWxsIGxvZ2lj
IHRvIHN0YXJ0IGEgcXVldWUgd2l0aCBubwo+Pj4gICAgIHNpZGUgZWZmZWN0cyBmb3IgdGhlIGd1
ZXN0LCBhbmQgYW5vdGhlciBvbmUgdGhhIGFjdHVhbGx5IGFzc3VtZXMgdGhhdAo+Pj4gICAgIHRo
ZSBndWVzdCBoYXMganVzdCBzdGFydGVkIHRoZSBkZXZpY2UuIFZkcGEgc2hvdWxkIHVzZSBqdXN0
IHRoZQo+Pj4gICAgIGZvcm1lci4KPj4+ICogQWN0dWFsbHkgc3RvcmUgYW5kIGNoZWNrIGlmIHRo
ZSBndWVzdCBub3RpZmllciBpcyBtYXNrZWQsIGFuZCBkbyBpdAo+Pj4gICAgIGNvbmRpdGlvbmFs
bHkuCj4+PiAqIExlZnQgYXMgaXQgaXMsIGFuZCBkdXBsaWNhdGUgYWxsIHRoZSBsb2dpYyBpbiB2
aG9zdC12ZHBhLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXpt
YUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiAgICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRx
dWV1ZS5jIHwgMTkgKysrKysrKysrKysrKysrCj4+PiAgICBody92aXJ0aW8vdmhvc3QtdmRwYS5j
ICAgICAgICAgICAgIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+PiAgICAy
IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRp
by92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPj4+IGluZGV4IDIxZGM5OWFiNWQuLjNmZTEyOWNm
NjMgMTAwNjQ0Cj4+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4+
PiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4+PiBAQCAtNTMsNiAr
NTMsMjIgQEAgc3RhdGljIHZvaWQgdmhvc3RfaGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmll
ciAqbikKPj4+ICAgICAgICBldmVudF9ub3RpZmllcl9zZXQoJnN2cS0+a2lja19ub3RpZmllcik7
Cj4+PiAgICB9Cj4+Pgo+Pj4gKy8qIEZvcndhcmQgdmhvc3Qgbm90aWZpY2F0aW9ucyAqLwo+Pj4g
K3N0YXRpYyB2b2lkIHZob3N0X3N2cV9oYW5kbGVfY2FsbF9ub190ZXN0KEV2ZW50Tm90aWZpZXIg
Km4pCj4+PiArewo+Pj4gKyAgICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gY29udGFpbmVy
X29mKG4sIFZob3N0U2hhZG93VmlydHF1ZXVlLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNhbGxfbm90aWZpZXIpOwo+Pj4gKwo+Pj4gKyAgICBldmVu
dF9ub3RpZmllcl9zZXQoJnN2cS0+Z3Vlc3RfY2FsbF9ub3RpZmllcik7Cj4+PiArfQo+Pj4gKwo+
Pj4gK3N0YXRpYyB2b2lkIHZob3N0X3N2cV9oYW5kbGVfY2FsbChFdmVudE5vdGlmaWVyICpuKQo+
Pj4gK3sKPj4+ICsgICAgaWYgKGxpa2VseShldmVudF9ub3RpZmllcl90ZXN0X2FuZF9jbGVhcihu
KSkpIHsKPj4+ICsgICAgICAgIHZob3N0X3N2cV9oYW5kbGVfY2FsbF9ub190ZXN0KG4pOwo+Pj4g
KyAgICB9Cj4+PiArfQo+Pj4gKwo+Pj4gICAgLyoKPj4+ICAgICAqIE9idGFpbiB0aGUgU1ZRIGNh
bGwgbm90aWZpZXIsIHdoZXJlIHZob3N0IGRldmljZSBub3RpZmllcyBTVlEgdGhhdCB0aGVyZQo+
Pj4gICAgICogZXhpc3RzIHBlbmRpbmcgdXNlZCBidWZmZXJzLgo+Pj4gQEAgLTE4MCw2ICsxOTYs
OCBAQCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyhzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXYsIGludCBpZHgpCj4+PiAgICAgICAgfQo+Pj4KPj4+ICAgICAgICBzdnEtPnZxID0gdmly
dGlvX2dldF9xdWV1ZShkZXYtPnZkZXYsIHZxX2lkeCk7Cj4+PiArICAgIGV2ZW50X25vdGlmaWVy
X3NldF9oYW5kbGVyKCZzdnEtPmNhbGxfbm90aWZpZXIsCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZob3N0X3N2cV9oYW5kbGVfY2FsbCk7Cj4+PiAgICAgICAgcmV0dXJuIGdf
c3RlYWxfcG9pbnRlcigmc3ZxKTsKPj4+Cj4+PiAgICBlcnJfaW5pdF9jYWxsX25vdGlmaWVyOgo+
Pj4gQEAgLTE5NSw2ICsyMTMsNyBAQCBlcnJfaW5pdF9raWNrX25vdGlmaWVyOgo+Pj4gICAgdm9p
ZCB2aG9zdF9zdnFfZnJlZShWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdnEpCj4+PiAgICB7Cj4+PiAg
ICAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmdnEtPmtpY2tfbm90aWZpZXIpOwo+Pj4gKyAg
ICBldmVudF9ub3RpZmllcl9zZXRfaGFuZGxlcigmdnEtPmNhbGxfbm90aWZpZXIsIE5VTEwpOwo+
Pj4gICAgICAgIGV2ZW50X25vdGlmaWVyX2NsZWFudXAoJnZxLT5jYWxsX25vdGlmaWVyKTsKPj4+
ICAgICAgICBnX2ZyZWUodnEpOwo+Pj4gICAgfQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+PiBpbmRleCBiYzM0ZGUyNDM5
Li42YzVmNGM5OGI4IDEwMDY0NAo+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4g
KysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4gQEAgLTcxMiwxMyArNzEyLDQwIEBAIHN0
YXRpYyBib29sIHZob3N0X3ZkcGFfc3ZxX3N0YXJ0X3ZxKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwg
dW5zaWduZWQgaWR4KQo+Pj4gICAgewo+Pj4gICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0g
ZGV2LT5vcGFxdWU7Cj4+PiAgICAgICAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSA9IGdfcHRy
X2FycmF5X2luZGV4KHYtPnNoYWRvd192cXMsIGlkeCk7Cj4+PiAtICAgIHJldHVybiB2aG9zdF9z
dnFfc3RhcnQoZGV2LCBpZHgsIHN2cSk7Cj4+PiArICAgIEV2ZW50Tm90aWZpZXIgKnZob3N0X2Nh
bGxfbm90aWZpZXIgPSB2aG9zdF9zdnFfZ2V0X3N2cV9jYWxsX25vdGlmaWVyKHN2cSk7Cj4+PiAr
ICAgIHN0cnVjdCB2aG9zdF92cmluZ19maWxlIHZob3N0X2NhbGxfZmlsZSA9IHsKPj4+ICsgICAg
ICAgIC5pbmRleCA9IGlkeCArIGRldi0+dnFfaW5kZXgsCj4+PiArICAgICAgICAuZmQgPSBldmVu
dF9ub3RpZmllcl9nZXRfZmQodmhvc3RfY2FsbF9ub3RpZmllciksCj4+PiArICAgIH07Cj4+PiAr
ICAgIGludCByOwo+Pj4gKyAgICBib29sIGI7Cj4+PiArCj4+PiArICAgIC8qIFNldCBzaGFkb3cg
dnEgLT4gZ3Vlc3Qgbm90aWZpZXIgKi8KPj4+ICsgICAgYXNzZXJ0KHYtPmNhbGxfZmRbaWR4XSk7
Cj4+Cj4+IFdlIG5lZWQgYW92aWQgdGhlIGFzc2VyKCkgaGVyZS4gT24gd2hpY2ggY2FzZSB3ZSBj
YW4gaGl0IHRoaXM/Cj4+Cj4gSSB3b3VsZCBzYXkgdGhhdCB0aGVyZSBpcyBubyB3YXkgd2UgY2Fu
IGFjdHVhbGx5IGhpdCBpdCwgc28gbGV0J3MgcmVtb3ZlIGl0Lgo+Cj4+PiArICAgIHZob3N0X3N2
cV9zZXRfZ3Vlc3RfY2FsbF9ub3RpZmllcihzdnEsIHYtPmNhbGxfZmRbaWR4XSk7Cj4+PiArCj4+
PiArICAgIGIgPSB2aG9zdF9zdnFfc3RhcnQoZGV2LCBpZHgsIHN2cSk7Cj4+PiArICAgIGlmICh1
bmxpa2VseSghYikpIHsKPj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsKPj4+ICsgICAgfQo+Pj4g
Kwo+Pj4gKyAgICAvKiBTZXQgZGV2aWNlIC0+IFNWUSBub3RpZmllciAqLwo+Pj4gKyAgICByID0g
dmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoZGV2LCAmdmhvc3RfY2FsbF9maWxlKTsKPj4+
ICsgICAgaWYgKHVubGlrZWx5KHIpKSB7Cj4+PiArICAgICAgICBlcnJvcl9yZXBvcnQoInZob3N0
X3ZkcGFfc2V0X3ZyaW5nX2NhbGwgZm9yIHNoYWRvdyB2cSBmYWlsZWQiKTsKPj4+ICsgICAgICAg
IHJldHVybiBmYWxzZTsKPj4+ICsgICAgfQo+Pgo+PiBTaW1pbGFyIHRvIGtpY2ssIGRvIHdlIG5l
ZWQgdG8gc2V0X3ZyaW5nX2NhbGwoKSBiZWZvcmUgdmhvc3Rfc3ZxX3N0YXJ0KCk/Cj4+Cj4gSXQg
c2hvdWxkIG5vdCBtYXR0ZXIgYXQgdGhpcyBtb21lbnQgYmVjYXVzZSB0aGUgZGV2aWNlIHNob3Vs
ZCBub3QgYmUKPiBzdGFydGVkIGF0IHRoaXMgcG9pbnQgYW5kIGRldmljZSBjYWxscyBzaG91bGQg
bm90IHJ1bgo+IHZob3N0X3N2cV9oYW5kbGVfY2FsbCB1bnRpbCBCUUwgaXMgcmVsZWFzZWQuCgoK
WWVzLCB3ZSBzdG9wIHZpcnRxdWV1ZSBiZWZvcmUuCgoKPgo+IFRoZSAibG9naWMiIG9mIGRvaW5n
IGl0IGFmdGVyIGlzIHRvIG1ha2UgY2xlYXIgdGhhdCBzdnEgbXVzdCBiZSBmdWxseQo+IGluaXRp
YWxpemVkIGJlZm9yZSBwcm9jZXNzaW5nIGRldmljZSBjYWxscywgZXZlbiBpbiB0aGUgY2FzZSB0
aGF0IHdlCj4gZXh0cmFjdCBTVlEgaW4gaXRzIG93biBpb3RocmVhZCBvciBzaW1pbGFyLiBCdXQg
dGhpcyBjb3VsZCBiZSBkb25lCj4gYmVmb3JlIHZob3N0X3N2cV9zdGFydCBmb3Igc3VyZS4KPgo+
Pj4gKwo+Pj4gKyAgICAvKiBDaGVjayBmb3IgcGVuZGluZyBjYWxscyAqLwo+Pj4gKyAgICBldmVu
dF9ub3RpZmllcl9zZXQodmhvc3RfY2FsbF9ub3RpZmllcik7Cj4+Cj4+IEludGVyZXN0aW5nLCBj
YW4gdGhpcyByZXN1bHQgc3B1cmlvdXMgaW50ZXJydXB0Pwo+Pgo+IFRoaXMgYWN0dWFsbHkgInF1
ZXVlcyIgYSB2aG9zdF9zdnFfaGFuZGxlX2NhbGwgYWZ0ZXIgdGhlIEJRTCByZWxlYXNlLAo+IHdo
ZXJlIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIGZ1bGx5IHJlc2V0LiBJbiB0aGF0IHJlZ2FyZCwgaWYg
dGhlcmUgYXJlCj4gbm8gdXNlZCBkZXNjcmlwdG9ycyB0aGVyZSB3aWxsIG5vdCBiZSBhbiBpcnEg
cmFpc2VkIHRvIHRoZSBndWVzdC4gRG9lcwo+IHRoYXQgYW5zd2VyIHRoZSBxdWVzdGlvbj8gT3Ig
aGF2ZSBJIG1pc3NlZCBzb21ldGhpbmc/CgoKWWVzLCBwbGVhc2UgZXhwbGFpbiB0aGlzIGluIHRo
ZSBjb21tZW50LgoKCj4KPj4+ICsgICAgcmV0dXJuIHRydWU7Cj4+PiAgICB9Cj4+Pgo+Pj4gICAg
c3RhdGljIHVuc2lnbmVkIHZob3N0X3ZkcGFfZW5hYmxlX3N2cShzdHJ1Y3Qgdmhvc3RfdmRwYSAq
diwgYm9vbCBlbmFibGUpCj4+PiAgICB7Cj4+PiAgICAgICAgc3RydWN0IHZob3N0X2RldiAqaGRl
diA9IHYtPmRldjsKPj4+ICAgICAgICB1bnNpZ25lZCBuOwo+Pj4gKyAgICBpbnQgcjsKPj4+Cj4+
PiAgICAgICAgaWYgKGVuYWJsZSA9PSB2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPj4+ICAgICAg
ICAgICAgcmV0dXJuIGhkZXYtPm52cXM7Cj4+PiBAQCAtNzUyLDkgKzc3OSwxOCBAQCBzdGF0aWMg
dW5zaWduZWQgdmhvc3RfdmRwYV9lbmFibGVfc3ZxKHN0cnVjdCB2aG9zdF92ZHBhICp2LCBib29s
IGVuYWJsZSkKPj4+ICAgICAgICBpZiAoIWVuYWJsZSkgewo+Pj4gICAgICAgICAgICAvKiBEaXNh
YmxlIGFsbCBxdWV1ZXMgb3IgY2xlYW4gdXAgZmFpbGVkIHN0YXJ0ICovCj4+PiAgICAgICAgICAg
IGZvciAobiA9IDA7IG4gPCB2LT5zaGFkb3dfdnFzLT5sZW47ICsrbikgewo+Pj4gKyAgICAgICAg
ICAgIHN0cnVjdCB2aG9zdF92cmluZ19maWxlIGZpbGUgPSB7Cj4+PiArICAgICAgICAgICAgICAg
IC5pbmRleCA9IHZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4KGhkZXYsIG4pLAo+Pj4gKyAgICAgICAg
ICAgICAgICAuZmQgPSB2LT5jYWxsX2ZkW25dLAo+Pj4gKyAgICAgICAgICAgIH07Cj4+PiArCj4+
PiArICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwoaGRldiwgJmZpbGUp
Owo+Pj4gKyAgICAgICAgICAgIGFzc2VydChyID09IDApOwo+Pj4gKwo+Pj4gICAgICAgICAgICAg
ICAgdW5zaWduZWQgdnFfaWR4ID0gdmhvc3RfdmRwYV9nZXRfdnFfaW5kZXgoaGRldiwgbik7Cj4+
PiAgICAgICAgICAgICAgICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19wdHJfYXJyYXlf
aW5kZXgodi0+c2hhZG93X3Zxcywgbik7Cj4+PiAgICAgICAgICAgICAgICB2aG9zdF9zdnFfc3Rv
cChoZGV2LCBuLCBzdnEpOwo+Pj4gKyAgICAgICAgICAgIC8qIFRPRE86IFRoaXMgY2FuIHVubWFz
ayBvciBvdmVycmlkZSBjYWxsIGZkISAqLwo+Pgo+PiBJIGRvbid0IGdldCB0aGlzIGNvbW1lbnQu
IERvZXMgdGhpcyBtZWFuIHRoZSBjdXJyZW50IGNvZGUgY2FuJ3Qgd29yawo+PiB3aXRoIG1hc2tf
bm90aWZpZXJzPyBJZiB5ZXMsIHRoaXMgaXMgc29tZXRoaW5nIHdlIG5lZWQgdG8gZml4Lgo+Pgo+
IFllcywgYnV0IGl0IHdpbGwgYmUgYWRkcmVzc2VkIGluIHRoZSBuZXh0IHNlcmllcy4gSSBzaG91
bGQgaGF2ZQo+IGV4cGxhaW5lZCBpdCBiZXR0ZSBoZXJlLCBzb3JyeSA6KS4KCgpPay4KClRoYW5r
cwoKCj4KPiBUaGFua3MhCj4KPj4gVGhhbmtzCj4+Cj4+Cj4+PiAgICAgICAgICAgICAgICB2aG9z
dF92aXJ0cXVldWVfc3RhcnQoaGRldiwgaGRldi0+dmRldiwgJmhkZXYtPnZxc1tuXSwgdnFfaWR4
KTsKPj4+ICAgICAgICAgICAgfQo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
