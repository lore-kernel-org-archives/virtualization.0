Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B880C0015E
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 06:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1A928176E;
	Wed,  5 Jul 2023 06:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1A928176E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9GAZaYR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JO-nYUuYWXlC; Wed,  5 Jul 2023 06:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42CF98175C;
	Wed,  5 Jul 2023 06:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42CF98175C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F354FC0072;
	Wed,  5 Jul 2023 06:16:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA238C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 06:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36E8A8176E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 06:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36E8A8176E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gCgvmNEI4AgQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 06:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EF8681756
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EF8681756
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688537766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TBBB6lG9AFcGbGAzMsUXWxOnjBOVl3P6MUCcvBHbSmw=;
 b=f9GAZaYRg2hN3xc6SoKc1590mARchDSX1dB2ESJfIY2vPMt1TfBBq9Lstf13GFqgAqyGAa
 AC2xoeuZHzoIvnvQJI4dBZrlGqaP8jb8ftLhQzLJPan0k+AhbgYJKZzZkEHbugx92+eabn
 wheWcpJBh8arIJpfrlw4UptGkdqHmnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37--Y9y3Fu_N82LkRaoTpajkg-1; Wed, 05 Jul 2023 02:16:04 -0400
X-MC-Unique: -Y9y3Fu_N82LkRaoTpajkg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb40d0623bso1694705e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 23:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688537763; x=1691129763;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBBB6lG9AFcGbGAzMsUXWxOnjBOVl3P6MUCcvBHbSmw=;
 b=EPkp9zhsCAvvk5SzJneMDhXH35Wi5v+xhs/YOCPllCQ5NS4a0ZESTZwKLG67WALa90
 JHALFd+jViJSZZgrePdkGmbCiYpW6+mNHSbZlcUw0PAHDQB8YFXUXgDW6xsVOPNCB1K6
 fII1s/pCtsG7ivXsrEfF2FuyuFIyeNBZhlZiq0moCWHwuTHN1ns2RcvL8FsI8aREtrRC
 GPSn+urm5ZhZl4KvBFJrVGq7o4nEEutbvuRnYtcXE/y5UgrYe5Wz2iygLRjcs2+9R1Pb
 kompIxW3c7qlifaeQjX4mBU1Cu1hC2htfta4HS4fWUsf3sg4IvUtk1BFrWD4xJM+MhVk
 FkqA==
X-Gm-Message-State: ABy/qLYG6sX2zyTyAw602BliOC/TA66KhDUpioqjUTSHYzaPYDRcDXf1
 M+xfEAqi09SAWiNdo9F52pUCYnEDbM2HYoN4JEuXO3vSHdO3AD+5qHuiMOraDsnavM/LD7SIqUs
 tbXBtFz/oupN21cEdyDB1D91oCDQQ3FSv3AKi6ktKRw==
X-Received: by 2002:a05:600c:519a:b0:3fb:b18a:f32d with SMTP id
 fa26-20020a05600c519a00b003fbb18af32dmr1182554wmb.17.1688537763304; 
 Tue, 04 Jul 2023 23:16:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRjW7JSmJKn22ARTG8gQSc74SDVkixROnuT/Q+4llMdAdfakRodtDTA7BfzPqsBd3zTp3PHg==
X-Received: by 2002:a05:600c:519a:b0:3fb:b18a:f32d with SMTP id
 fa26-20020a05600c519a00b003fbb18af32dmr1182532wmb.17.1688537763037; 
 Tue, 04 Jul 2023 23:16:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:91bf:2a8a:e512:df36:67d3])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c251200b003fbcf032c55sm1123833wma.7.2023.07.04.23.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 23:16:02 -0700 (PDT)
Date: Wed, 5 Jul 2023 02:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230705021447-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
 <20230705012917-mutt-send-email-mst@kernel.org>
 <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDE6NDc6NDRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIEp1bCA1LCAyMDIzIGF0IDE6MzHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAw
MToxMTozN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1bCA0LCAy
MDIzIGF0IDY6MTbigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA1OjI2OjAyUE0gLTA3
MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIDcv
My8yMDIzIDg6NDYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gT24g
TW9uLCBKdWwgMDMsIDIwMjMgYXQgMDQ6MjU6MTRQTSArMDIwMCwgRXVnZW5pbyBQw6lyZXogd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gT2ZmZXIgdGhpcyBiYWNrZW5kIGZlYXR1cmUgYXMgbWx4NSBpcyBj
b21wYXRpYmxlIHdpdGggaXQuIEl0IGFsbG93cyBpdAo+ID4gPiA+ID4gPiA+IHRvIGRvIGxpdmUg
bWlncmF0aW9uIHdpdGggQ1ZRLCBkeW5hbWljYWxseSBzd2l0Y2hpbmcgYmV0d2VlbiBwYXNzdGhy
b3VnaAo+ID4gPiA+ID4gPiA+IGFuZCBzaGFkb3cgdmlydHF1ZXVlLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+Cj4gPiA+ID4gPiA+IFNhbWUgY29tbWVudC4KPiA+ID4gPiA+IHRvIHdoaWNoPwo+ID4g
PiA+ID4KPiA+ID4gPiA+IC1TaXdlaQo+ID4gPiA+Cj4gPiA+ID4gVkhPU1RfQkFDS0VORF9GX0VO
QUJMRV9BRlRFUl9EUklWRVJfT0sgaXMgdG9vIG5hcnJvdyBhIHVzZS1jYXNlIHRvIGNvbW1pdCB0
byBpdAo+ID4gPiA+IGFzIGEga2VybmVsL3VzZXJzcGFjZSBBQkk6IHdoYXQgaWYgb25lIHdhbnRz
IHRvIHN0YXJ0IHJpbmdzIGluIHNvbWUKPiA+ID4gPiBvdGhlciBzcGVjaWZpYyBvcmRlcj8KPiA+
ID4KPiA+ID4gSnVzdCBlbmFibGUgYSBxdWV1ZSBieSB3cml0aW5nIGUuZyAxIHRvIHF1ZXVlX2Vu
YWJsZSBpbiBhIHNwZWNpZmljIG9yZGVyPwo+ID4KPiA+Cj4gPiBCdXQgdGhlbiBhdCBkcml2ZXIg
b2sgdGltZSB3ZSBkb24ndCBrbm93IGhvdyBtYW55IHF1ZXVlcyBhcmUgdGhlcmUuCj4gCj4gVGhl
cmUgc2hvdWxkIGJlIGEgZGV2aWNlIHNwZWNpZmljIGludGVyZmFjZSBmb3IgdGhpcywgZm9yIGV4
YW1wbGUsCj4gbnVtX3F1ZXVlX3BhcmlzLiBTbyB0aGUgZGV2aWNlIGtub3dzIGF0IG1vc3QgaG93
IG1hbnkgcXVldWVzIHRoZXJlCj4gYXJlLiBPciBhbnl0aGluZyBJIG1pc3M/CgpUaGF0J3MgYSBk
ZXZpY2UgbGltaXRhdGlvbnMuIERvZXMgbm90IHRlbGwgdGhlIGRldmljZSBob3cgbXVjaCBpcyB1
c2VkLgoKPiA+Cj4gPiA+ID4gQXMgd2FzIGRpc2N1c3NlZCBvbiBsaXN0LCBhIGJldHRlciBwcm9t
aXNlIGlzIG5vdCB0byBhY2Nlc3MgcmluZwo+ID4gPiA+IHVudGlsIHRoZSAxc3Qga2ljay4gdmRw
YSBjYW4gdGhlbiBkbyBhIGtpY2sgd2hlbiBpdCB3YW50cwo+ID4gPiA+IHRoZSBkZXZpY2UgdG8g
c3RhcnQgYWNjZXNzaW5nIHJpbmdzLgo+ID4gPgo+ID4gPiBSZXRoaW5rIGFib3V0IHRoZSBBQ0NF
U1NfQUZURVJfS0lDSywgaXQgc291bmRzIGZ1bmN0aW9uYWwgZXF1aXZhbGVudAo+ID4gPiB0byBh
bGxvdyBxdWV1ZV9lbmFibGUgYWZ0ZXIgRFJJVkVSX09LLCBidXQgaXQgc2VlbXMgdG8gaGF2ZQo+
ID4gPiBkaXN0YW52YWdlczoKPiA+ID4KPiA+ID4gQSBidXN5IHBvbGxpbmcgc29mdHdhcmUgZGV2
aWNlIG1heSBkaXNhYmxlIG5vdGlmaWNhdGlvbnMgYW5kIG5ldmVyCj4gPiA+IHJlc3BvbmQgdG8g
cmVnaXN0ZXIgdG8gYW55IGtpY2sgbm90aWZpZXJzLiBBQ0NFU1NfQUZURVJfS0lDSyB3aWxsCj4g
PiA+IGludHJvZHVjZSBvdmVyaGVhZCB0byB0aG9zZSBpbXBsZW1lbnRhdGlvbnMuCj4gPiA+Cj4g
PiA+IFRoYW5rcwo+ID4KPiA+IEl0J3MganVzdCB0aGUgMXN0IGtpY2ssIHRoZW4geW91IGNhbiBk
aXNhYmxlLiBObz8KPiAKPiBZZXMsIGJ1dDoKPiAKPiAxKSBhZGRpbmcgaG9va3MgZm9yIHF1ZXVl
X2VuYWJsZQo+IDIpIGFkZGluZyBuZXcgY29kZXMgdG8gcmVnaXN0ZXIgZXZlbnQgbm90aWZpZXIg
YW5kIHRvZ2dsZSB0aGUgbm90aWZpZXIKPiAKPiAxKSBzZWVtcyBtdWNoIGVhc2llcj8gT3IgZm9y
IG1vc3QgZGV2aWNlcywgaXQgYWxyZWFkeSBiZWhhdmVzIGxpa2UgdGhpcy4KPiAKPiBUaGFua3MK
CldlbGwgbGlidmhvc3R1c2VyIGNoZWNrcyBlbmFibGVkIHF1ZXVlcyBhdCBEUklWRVJfT0ssIGRv
ZXMgaXQgbm90PwoKPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+
ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDcgKysrKysr
Kwo+ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4g
PiA+IGluZGV4IDkxMzhlZjJmYjJjOC4uNWYzMDlhMTZiOWRjIDEwMDY0NAo+ID4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+IEBAIC03
LDYgKzcsNyBAQAo+ID4gPiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25l
dC5oPgo+ID4gPiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2lkcy5oPgo+
ID4gPiA+ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmRwYS5oPgo+ID4gPiA+ID4gPiA+
ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aG9zdF90eXBlcy5oPgo+ID4gPiA+ID4gPiA+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPiA+ID4gPiA+ID4gPiAgICNpbmNsdWRlIDxs
aW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gPiA+ID4gPiA+ID4gICAjaW5jbHVkZSA8bGludXgvbWx4
NS9jcS5oPgo+ID4gPiA+ID4gPiA+IEBAIC0yNDk5LDYgKzI1MDAsMTEgQEAgc3RhdGljIHZvaWQg
dW5yZWdpc3Rlcl9saW5rX25vdGlmaWVyKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIGZsdXNoX3dvcmtxdWV1ZShuZGV2LT5tdmRldi53
cSk7Cj4gPiA+ID4gPiA+ID4gICB9Cj4gPiA+ID4gPiA+ID4gK3N0YXRpYyB1NjQgbWx4NV92ZHBh
X2dldF9iYWNrZW5kX2ZlYXR1cmVzKGNvbnN0IHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+
ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ICsgcmV0dXJuIEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spOwo+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+
ID4gKwo+ID4gPiA+ID4gPiA+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiA+ID4gPiA+ID4g
PiAgIHsKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+ID4gPiA+ID4gQEAgLTMxNDAsNiArMzE0Niw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIG1seDVfdmRwYV9vcHMgPSB7Cj4gPiA+
ID4gPiA+ID4gICAgICAgICAgIC5nZXRfdnFfYWxpZ24gPSBtbHg1X3ZkcGFfZ2V0X3ZxX2FsaWdu
LAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X3ZxX2dyb3VwID0gbWx4NV92ZHBhX2dldF92
cV9ncm91cCwKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgLmdldF9kZXZpY2VfZmVhdHVyZXMgPSBt
bHg1X3ZkcGFfZ2V0X2RldmljZV9mZWF0dXJlcywKPiA+ID4gPiA+ID4gPiArIC5nZXRfYmFja2Vu
ZF9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfYmFja2VuZF9mZWF0dXJlcywKPiA+ID4gPiA+ID4g
PiAgICAgICAgICAgLnNldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9m
ZWF0dXJlcywKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgLmdldF9kcml2ZXJfZmVhdHVyZXMgPSBt
bHg1X3ZkcGFfZ2V0X2RyaXZlcl9mZWF0dXJlcywKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgLnNl
dF9jb25maWdfY2IgPSBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiA+ID4gPiA+ID4gPiAtLQo+
ID4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
