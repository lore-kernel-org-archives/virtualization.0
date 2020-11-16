Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12AC4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:08:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B7D20853
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJdCOgP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B7D20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 661488680E;
	Mon, 16 Nov 2020 11:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qB44BV8NiOB; Mon, 16 Nov 2020 11:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8FBD486786;
	Mon, 16 Nov 2020 11:08:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82E45C0800;
	Mon, 16 Nov 2020 11:08:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4A0C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4C64E85C86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWs7Vinfvv-k
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 761BA8560C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605524892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXX/wZqiroUfD/O74sRJcUfHvErWOcCKorfJ8YBwuSM=;
 b=LJdCOgP99pen6+gmpoWHEhukfH0B8mTP1n5iQ1BWtPZvRODHGh74HLDZFvKRLWaUxjv/+N
 snxTHXKICaJ2EOYa0Ia27yUqU3KQ4TIOuphNgsh63NlmYUVu7R8oMeKkDQV1NHa/HX6t/j
 Fq6bhCfA8coe+i0IjCqYCy2D7tkMaQA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-_6ICpEK8OzCBJMhpm_8hSw-1; Mon, 16 Nov 2020 06:08:09 -0500
X-MC-Unique: _6ICpEK8OzCBJMhpm_8hSw-1
Received: by mail-wm1-f69.google.com with SMTP id 14so10039285wmg.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZXX/wZqiroUfD/O74sRJcUfHvErWOcCKorfJ8YBwuSM=;
 b=G0GLvHdOm5uRkzMZcQtmAl1//Dg3Tyk5YdgIJvPKTtrJzVYTErJxRvFEOUzcZFXjIJ
 xGEhSxS5n45aLrZ9IHakeDOwkqFt9E29BOq2zXkFMLghZhW0kGBwq43bZygvxPlvhmem
 lzGsmUlvfcOSi0BkNt5r2vYwrmwhyzE7wqDgpvFCeDVG5wlPE6V1UDFqv/3QkFKCv5Iv
 GPODLvxGzExdMsZepLs6yWJf4PxsiVLDleTl8JB5igsG0xNyrbGrOeRbOmaqBgSky1MJ
 De2XKyxWcZw1zFBF/n93kHB/9v55zb3fKO84F2dvw2NM2tPSgnL4VzwY8HCdQ4j5S+M5
 9OSQ==
X-Gm-Message-State: AOAM530ru90T7Z/XpWFDxlPx4nSGNbFP0neWPwpmDGpoJzRcMQK5S/G0
 QAJhIDyhfK+9X30r73q80dhD26/DYKqnuo7MTMWLO9C/k97+NSRuPNr27vDs0TmZwmivw8+FdBI
 AIiOwJt1kMJ+Nv/z62EoMNW37ovZFkgUA/i6y3llXjA==
X-Received: by 2002:adf:f602:: with SMTP id t2mr7940580wrp.40.1605524888368;
 Mon, 16 Nov 2020 03:08:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxz0hQkQCVM7hHaRIfa6NDF4VzNeIvWdO00UDUV/f+MZSCAifF0VGRZOYOApyIH9wUNSun9jA==
X-Received: by 2002:adf:f602:: with SMTP id t2mr7940555wrp.40.1605524888154;
 Mon, 16 Nov 2020 03:08:08 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id p10sm22850438wre.2.2020.11.16.03.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 03:08:07 -0800 (PST)
Date: Mon, 16 Nov 2020 12:08:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201116110805.efspwzkuw2sdnaca@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMDE6MjU6MzFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIHdyb3RlIG9ubHkgdGhlIHN0YXR1cyBvZiBl
YWNoIHJlcXVlc3QuCj4+VGhpcyBwYXRjaCBpbXBsZW1lbnRzIGEgbW9yZSBhY2N1cmF0ZSBibG9j
ayBkZXZpY2Ugc2ltdWxhdG9yLAo+PnByb3ZpZGluZyBhIHJhbWRpc2stbGlrZSBiZWhhdmlvci4K
Pj4KPj5BbHNvIGhhbmRsZSBWSVJUSU9fQkxLX1RfR0VUX0lEIHJlcXVlc3QsIGFsd2F5cyBhbnN3
ZXJpbmcgdGhlCj4+InZkcGFfYmxrX3NpbSIgc3RyaW5nLgo+Cj4KPkxldCdzIHVzZSBhIHNlcGFy
YXRlIHBhdGNoIGZvciB0aGlzLgo+CgpPa2F5LCBJJ2xsIGRvLgoKPgo+Pgo+PlNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0KPj4gIGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDE1MSArKysrKysrKysrKysrKysr
KysrKysrKy0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygrKSwgMTggZGVs
ZXRpb25zKC0pCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+PmluZGV4IDhl
NDFiM2FiOThkNS4uNjhlNzQzODMzMjJmIDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9ibGsuYwo+PisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9ibGsuYwo+PkBAIC03LDYgKzcsNyBAQAo+PiAgICovCj4+ICAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+Cj4+KyNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4KPj4gICNpbmNsdWRlIDx1YXBpL2xp
bnV4L3ZpcnRpb19ibGsuaD4KPj4gICNpbmNsdWRlICJ2ZHBhX3NpbS5oIgo+PkBAIC0yNCwxMCAr
MjUsMTM3IEBACj4+ICBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fYmxrX2RldjsKPj4r
c3RhdGljIGludCB2ZHBhc2ltX2Jsa19oYW5kbGVfcmVxKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2lt
LAo+PisJCQkJICBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxKQo+Pit7Cj4+KwlzaXplX3Qg
d3JvdGUgPSAwLCB0b19yZWFkID0gMCwgdG9fd3JpdGUgPSAwOwo+PisJc3RydWN0IHZpcnRpb19i
bGtfb3V0aGRyIGhkcjsKPj4rCXVpbnQ4X3Qgc3RhdHVzOwo+PisJdWludDMyX3QgdHlwZTsKPj4r
CXNzaXplX3QgYnl0ZXM7Cj4+Kwlsb2ZmX3Qgb2Zmc2V0Owo+PisJaW50IGksIHJldDsKPj4rCj4+
Kwl2cmluZ2hfa2lvdl9jbGVhbnVwKCZ2cS0+cmlvdik7Cj4+Kwl2cmluZ2hfa2lvdl9jbGVhbnVw
KCZ2cS0+d2lvdik7Cj4KPgo+SXQgbG9va3MgdG8gbWUgd2Ugc2hvdWxkIGRvIHRob3NlIGFmdGVy
IHZyaW5naF9nZXRfZGVzY19pb3RsYigpPyBTZWUgCj5jb21tZW50IGFib3ZlIHZyaW5naF9nZXRk
ZXNjX2tlcm4oKS4KCkRvIHlvdSBtZWFuIGFmdGVyIHRoZSBsYXN0IHZyaW5naF9pb3ZfcHVzaF9p
b3RsYigpPwoKQmVjYXVzZSB2cmluZ2hfa2lvdl9jbGVhbnVwKCkgd2lsbCBmcmVlIHRoZSBhbGxv
Y2F0ZWQgaW92W10uCgo+Cj4KPj4rCj4+KwlyZXQgPSB2cmluZ2hfZ2V0ZGVzY19pb3RsYigmdnEt
PnZyaW5nLCAmdnEtPnJpb3YsICZ2cS0+d2lvdiwKPj4rCQkJCSAgICZ2cS0+aGVhZCwgR0ZQX0FU
T01JQyk7Cj4+KwlpZiAocmV0ICE9IDEpCj4+KwkJcmV0dXJuIHJldDsKPj4rCj4+Kwlmb3IgKGkg
PSAwOyBpIDwgdnEtPndpb3YudXNlZDsgaSsrKQo+PisJCXRvX3dyaXRlICs9IHZxLT53aW92Lmlv
dltpXS5pb3ZfbGVuOwo+Cj4KPkl0J3MgYmV0dGVyIHRvIGludHJvZHVjZSBhIGhlbHBlciBmb3Ig
dGhpcyAob3IgY29uc2lkZXIgdG8gdXNlIGlvdiAKPml0ZXJhdG9yKS4KCk9rYXksIEknbGwgdHJ5
IHRvIGZpbmQgdGhlIGJlc3Qgc29sdXRpb24uCgo+Cj4KPj4rCXRvX3dyaXRlIC09IDE7IC8qIGxh
c3QgYnl0ZSBpcyB0aGUgc3RhdHVzICovCj4+Kwo+PisJZm9yIChpID0gMDsgaSA8IHZxLT5yaW92
LnVzZWQ7IGkrKykKPj4rCQl0b19yZWFkICs9IHZxLT5yaW92LmlvdltpXS5pb3ZfbGVuOwo+PisK
Pj4rCWJ5dGVzID0gdnJpbmdoX2lvdl9wdWxsX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+cmlvdiwg
Jmhkciwgc2l6ZW9mKGhkcikpOwo+PisJaWYgKGJ5dGVzICE9IHNpemVvZihoZHIpKQo+PisJCXJl
dHVybiAwOwo+PisKPj4rCXRvX3JlYWQgLT0gYnl0ZXM7Cj4+Kwo+PisJdHlwZSA9IGxlMzJfdG9f
Y3B1KGhkci50eXBlKTsKPj4rCW9mZnNldCA9IGxlNjRfdG9fY3B1KGhkci5zZWN0b3IpIDw8IFNF
Q1RPUl9TSElGVDsKPj4rCXN0YXR1cyA9IFZJUlRJT19CTEtfU19PSzsKPj4rCj4+Kwlzd2l0Y2gg
KHR5cGUpIHsKPj4rCWNhc2UgVklSVElPX0JMS19UX0lOOgo+PisJCWlmIChvZmZzZXQgKyB0b193
cml0ZSA+IFZEUEFTSU1fQkxLX0NBUEFDSVRZIDw8IAo+PlNFQ1RPUl9TSElGVCkgewo+PisJCQlk
ZXZfZXJyKCZ2ZHBhc2ltLT52ZHBhLmRldiwKPj4rCQkJCSJyZWFkaW5nIG92ZXIgdGhlIGNhcGFj
aXR5IC0gb2Zmc2V0OiAKPj4weCVsbHggbGVuOiAweCVseFxuIiwKPj4rCQkJCW9mZnNldCwgdG9f
d3JpdGUpOwo+PisJCQlzdGF0dXMgPSBWSVJUSU9fQkxLX1NfSU9FUlI7Cj4+KwkJCWJyZWFrOwo+
PisJCX0KPj4rCj4+KwkJYnl0ZXMgPSB2cmluZ2hfaW92X3B1c2hfaW90bGIoJnZxLT52cmluZywg
JnZxLT53aW92LAo+PisJCQkJCSAgICAgIHZkcGFzaW0tPmJ1ZmZlciArIG9mZnNldCwKPj4rCQkJ
CQkgICAgICB0b193cml0ZSk7Cj4+KwkJaWYgKGJ5dGVzIDwgMCkgewo+PisJCQlkZXZfZXJyKCZ2
ZHBhc2ltLT52ZHBhLmRldiwKPj4rCQkJCSJ2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjog
JWxkIG9mZnNldDogMHglbGx4IGxlbjogMHglbHhcbiIsCj4+KwkJCQlieXRlcywgb2Zmc2V0LCB0
b193cml0ZSk7Cj4+KwkJCXN0YXR1cyA9IFZJUlRJT19CTEtfU19JT0VSUjsKPj4rCQkJYnJlYWs7
Cj4+KwkJfQo+PisKPj4rCQl3cm90ZSArPSBieXRlczsKPj4rCQlicmVhazsKPj4rCj4+KwljYXNl
IFZJUlRJT19CTEtfVF9PVVQ6Cj4+KwkJaWYgKG9mZnNldCArIHRvX3JlYWQgPiBWRFBBU0lNX0JM
S19DQVBBQ0lUWSA8PCBTRUNUT1JfU0hJRlQpIHsKPj4rCQkJZGV2X2VycigmdmRwYXNpbS0+dmRw
YS5kZXYsCj4+KwkJCQkid3JpdGluZyBvdmVyIHRoZSBjYXBhY2l0eSAtIG9mZnNldDogMHglbGx4
IGxlbjogMHglbHhcbiIsCj4+KwkJCQlvZmZzZXQsIHRvX3JlYWQpOwo+PisJCQlzdGF0dXMgPSBW
SVJUSU9fQkxLX1NfSU9FUlI7Cj4+KwkJCWJyZWFrOwo+PisJCX0KPj4rCj4+KwkJYnl0ZXMgPSB2
cmluZ2hfaW92X3B1bGxfaW90bGIoJnZxLT52cmluZywgJnZxLT5yaW92LAo+PisJCQkJCSAgICAg
IHZkcGFzaW0tPmJ1ZmZlciArIG9mZnNldCwKPj4rCQkJCQkgICAgICB0b19yZWFkKTsKPj4rCQlp
ZiAoYnl0ZXMgPCAwKSB7Cj4+KwkJCWRldl9lcnIoJnZkcGFzaW0tPnZkcGEuZGV2LAo+PisJCQkJ
InZyaW5naF9pb3ZfcHVsbF9pb3RsYigpIGVycm9yOiAlbGQgb2Zmc2V0OiAweCVsbHggbGVuOiAw
eCVseFxuIiwKPj4rCQkJCWJ5dGVzLCBvZmZzZXQsIHRvX3JlYWQpOwo+PisJCQlzdGF0dXMgPSBW
SVJUSU9fQkxLX1NfSU9FUlI7Cj4+KwkJCWJyZWFrOwo+PisJCX0KPj4rCQlicmVhazsKPj4rCj4+
KwljYXNlIFZJUlRJT19CTEtfVF9HRVRfSUQ6IHsKPj4rCQljaGFyIGlkW1ZJUlRJT19CTEtfSURf
QllURVNdID0gInZkcGFfYmxrX3NpbSI7Cj4KPgo+TGV0J3MgdXNlIGEgZ2xvYmFsIHN0YXRpYyBv
bmU/CgpJJ2xsIGRvLgoKPgo+Cj4+Kwo+PisJCWJ5dGVzID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxi
KCZ2cS0+dnJpbmcsCj4+KwkJCQkJICAgICAgJnZxLT53aW92LCBpZCwKPj4rCQkJCQkgICAgICBW
SVJUSU9fQkxLX0lEX0JZVEVTKTsKPj4rCQlpZiAoYnl0ZXMgPCAwKSB7Cj4+KwkJCWRldl9lcnIo
JnZkcGFzaW0tPnZkcGEuZGV2LAo+PisJCQkJInZyaW5naF9pb3ZfcHVzaF9pb3RsYigpIGVycm9y
OiAlbGRcbiIsIGJ5dGVzKTsKPj4rCQkJc3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJSOwo+PisJ
CQlicmVhazsKPj4rCQl9Cj4+Kwo+PisJCXdyb3RlICs9IGJ5dGVzOwo+PisJCWJyZWFrOwo+PisJ
fQo+PisKPj4rCWRlZmF1bHQ6Cj4+KwkJZGV2X3dhcm4oJnZkcGFzaW0tPnZkcGEuZGV2LAo+PisJ
CQkgIlVuc3VwcG9ydGVkIHJlcXVlc3QgdHlwZSAlZFxuIiwgdHlwZSk7Cj4+KwkJc3RhdHVzID0g
VklSVElPX0JMS19TX0lPRVJSOwo+PisJCWJyZWFrOwo+PisJfQo+PisKPj4rCS8qIGlmIFZJUlRJ
T19CTEtfVF9JTiBvciBWSVJUSU9fQkxLX1RfR0VUX0lEIGZhaWwsIHdlIG5lZWQgdG8gc2tpcAo+
PisJICogdGhlIHJlbWFpbmluZyBieXRlcyB0byBwdXQgdGhlIHN0YXR1cyBpbiB0aGUgbGFzdCBi
eXRlCj4+KwkgKi8KPj4rCWlmICh0b193cml0ZSAtIHdyb3RlID4gMCkgewo+PisJCXZyaW5naF9p
b3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPndpb3YsIE5VTEwsCj4+KwkJCQkgICAgICB0
b193cml0ZSAtIHdyb3RlKTsKPj4rCX0KPj4rCj4+KwkvKiBsYXN0IGJ5dGUgaXMgdGhlIHN0YXR1
cyAqLwo+PisJYnl0ZXMgPSB2cmluZ2hfaW92X3B1c2hfaW90bGIoJnZxLT52cmluZywgJnZxLT53
aW92LCAmc3RhdHVzLCAxKTsKPj4rCWlmIChieXRlcyAhPSAxKQo+PisJCXJldHVybiAwOwo+PisK
Pj4rCXdyb3RlICs9IGJ5dGVzOwo+PisKPj4rCS8qIE1ha2Ugc3VyZSBkYXRhIGlzIHdyb3RlIGJl
Zm9yZSBhZHZhbmNpbmcgaW5kZXggKi8KPj4rCXNtcF93bWIoKTsKPj4rCj4+Kwl2cmluZ2hfY29t
cGxldGVfaW90bGIoJnZxLT52cmluZywgdnEtPmhlYWQsIHdyb3RlKTsKPj4rCj4+KwlyZXR1cm4g
cmV0Owo+Pit9Cj4+Kwo+PiAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCj4+ICB7Cj4+ICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSBjb250
YWluZXJfb2Yod29yaywgc3RydWN0IHZkcGFzaW0sIHdvcmspOwo+Pi0JdTggc3RhdHVzID0gVklS
VElPX0JMS19TX09LOwo+PiAgCWludCBpOwo+PiAgCXNwaW5fbG9jaygmdmRwYXNpbS0+bG9jayk7
Cj4+QEAgLTQxLDIxICsxNjksNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2Jsa193b3JrKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKPj4gIAkJaWYgKCF2cS0+cmVhZHkpCj4+ICAJCQljb250aW51
ZTsKPj4tCQl3aGlsZSAodnJpbmdoX2dldGRlc2NfaW90bGIoJnZxLT52cmluZywgJnZxLT5yaW92
LCAmdnEtPndpb3YsCj4+LQkJCQkJICAgICZ2cS0+aGVhZCwgR0ZQX0FUT01JQykgPiAwKSB7Cj4+
LQo+Pi0JCQlpbnQgd3JpdGU7Cj4+LQo+Pi0JCQl2cS0+d2lvdi5pID0gdnEtPndpb3YudXNlZCAt
IDE7Cj4+LQkJCXdyaXRlID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+
d2lvdiwgJnN0YXR1cywgMSk7Cj4+LQkJCWlmICh3cml0ZSA8PSAwKQo+Pi0JCQkJYnJlYWs7Cj4+
LQo+Pi0JCQkvKiBNYWtlIHN1cmUgZGF0YSBpcyB3cm90ZSBiZWZvcmUgYWR2YW5jaW5nIAo+Pmlu
ZGV4ICovCj4+LQkJCXNtcF93bWIoKTsKPj4tCj4+LQkJCXZyaW5naF9jb21wbGV0ZV9pb3RsYigm
dnEtPnZyaW5nLCB2cS0+aGVhZCwgd3JpdGUpOwo+Pi0KPj4rCQl3aGlsZSAodmRwYXNpbV9ibGtf
aGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSkgPiAwKSB7Cj4+ICAJCQkvKiBNYWtlIHN1cmUgdXNlZCBp
cyB2aXNpYmxlIGJlZm9yZSByYXNpbmcgdGhlIGludGVycnVwdC4gKi8KPj4gIAkJCXNtcF93bWIo
KTsKPj5AQCAtNjcsNiArMTgxLDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+ICAJCQkJdnEtPmNiKHZxLT5wcml2YXRlKTsKPj4gIAkJ
CWxvY2FsX2JoX2VuYWJsZSgpOwo+PiAgCQl9Cj4+Kwo+Cj4KPlVubmVjZXNzYXJ5IGNoYW5nZS4K
ClJlbW92ZWQuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
