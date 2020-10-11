Return-Path: <SRS0=TNKP=DS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6989C43457
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 06:47:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78321207FB
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 06:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuSV1U+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78321207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8EAE873EB;
	Sun, 11 Oct 2020 06:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATylXEtIIf34; Sun, 11 Oct 2020 06:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0820987165;
	Sun, 11 Oct 2020 06:47:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6F9EC0052;
	Sun, 11 Oct 2020 06:46:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 870AAC0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7520087808
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvML5eTJVDgd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF946877F5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602398816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9DBg94y3dH4K7OJQw3QhobflJnhMnjEF2bmY+pjq5A=;
 b=PuSV1U+QRPjOYk/wwIpwbWsQRNGDGiX1possCZJQGqC3spywQHbB0dtn3PwALbFXQ4gxga
 /HCf/CUvxg3OgCbkLfqjxIOS30/HP60oWAElvpQ24lM2soeT12P7Iquxec5pWBhyDXEjjT
 LvYeA3R4euQb5PDVC5110uqXEBaJwaw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-JDIfF527MRCQAhbigDcHbA-1; Sun, 11 Oct 2020 02:46:54 -0400
X-MC-Unique: JDIfF527MRCQAhbigDcHbA-1
Received: by mail-wr1-f72.google.com with SMTP id x16so7047090wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 23:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=e9DBg94y3dH4K7OJQw3QhobflJnhMnjEF2bmY+pjq5A=;
 b=PiK5X/3kGx133RUDfNIFJDtuEDz/x1th3Xgju2e2gdEoBiglvFSYngKhjodYbssrhO
 UlApqs/nNrG9JAQO7x/0yY0mVMl5mh+mldOZtdXHIuue/vUf/XDJAtN6QTe3kCQ2MTt/
 os6u8tm6F3tfJEf/yhXaU2xxwgp+ubky11hwYWPD9OY1aJQh90rqS4iDcpn3YE6fmPWl
 ISeg/ikIngGyxe9IdqsXJ0cWHD9OS+X2bkUSpXDsiz1SCg7UINJXVv872KcD0hU74UuD
 INOyZHgIIdZ+jDwz6mGlh/w+Byf9MKURajvXLGqVpF3R5tlc+fK8N1rL+OMlftkQJMfd
 UCpw==
X-Gm-Message-State: AOAM531tLcvy1hbdC3rppFW+F9LFaLDKk+Uzj5UCMMALowo0/VqsUdP4
 4Dsr7WrX02LsVN6nlckFtSnF7NalHLfE36AUt5Zr1qaVPxnFuEBADphJzzs+Svof0TnoDFhcLjK
 hvsfUrAwNLvfTh/DPCRl3GXmcjN4WPK1HrdvkZNQ99Q==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr5421304wme.130.1602398813150; 
 Sat, 10 Oct 2020 23:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM5mr9XODNM/0FDfdYSqdgaQBm+SlNnogDVtVm9qnwQtawYEdi+JIuDir297EELqzQhHaTMQ==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr5421290wme.130.1602398812957; 
 Sat, 10 Oct 2020 23:46:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-76-41.red.bezeqint.net. [79.179.76.41])
 by smtp.gmail.com with ESMTPSA id
 j5sm14175503wrx.88.2020.10.10.23.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 23:46:52 -0700 (PDT)
Date: Sun, 11 Oct 2020 02:46:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/3] vhost: Use vhost_get_used_size() in
 vhost_vring_set_addr()
Message-ID: <20201011024636-mutt-send-email-mst@kernel.org>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171932300.284610.11846106312938909461.stgit@bahia.lan>
 <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5fc896c6-e60d-db0b-f7b0-5b6806d70b8e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 virtualization@lists.linux-foundation.org, Laurent Vivier <laurent@vivier.eu>
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

T24gU2F0LCBPY3QgMTAsIDIwMjAgYXQgMTA6MzI6MTNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEwLzMg5LiL5Y2INjowMiwgR3JlZyBLdXJ6IHdyb3RlOgo+ID4gVGhl
IG9wZW4tY29kZWQgY29tcHV0YXRpb24gb2YgdGhlIHVzZWQgc2l6ZSBkb2Vzbid0IHRha2UgdGhl
IGV2ZW50Cj4gPiBpbnRvIGFjY291bnQgd2hlbiB0aGUgVklSVElPX1JJTkdfRl9FVkVOVF9JRFgg
ZmVhdHVyZSBpcyBwcmVzZW50Lgo+ID4gRml4IHRoYXQgYnkgdXNpbmcgdmhvc3RfZ2V0X3VzZWRf
c2l6ZSgpLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGthb2Qub3Jn
Pgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8ICAgIDMgKy0tCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
ID4gaW5kZXggYzNiNDk5NzVkYzI4Li45ZDJjMjI1ZmI1MTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gQEAg
LTE1MTksOCArMTUxOSw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZyaW5nX3NldF9hZGRyKHN0cnVj
dCB2aG9zdF9kZXYgKmQsCj4gPiAgIAkJLyogQWxzbyB2YWxpZGF0ZSBsb2cgYWNjZXNzIGZvciB1
c2VkIHJpbmcgaWYgZW5hYmxlZC4gKi8KPiA+ICAgCQlpZiAoKGEuZmxhZ3MgJiAoMHgxIDw8IFZI
T1NUX1ZSSU5HX0ZfTE9HKSkgJiYKPiA+ICAgCQkJIWxvZ19hY2Nlc3Nfb2sodnEtPmxvZ19iYXNl
LCBhLmxvZ19ndWVzdF9hZGRyLAo+ID4gLQkJCQlzaXplb2YgKnZxLT51c2VkICsKPiA+IC0JCQkJ
dnEtPm51bSAqIHNpemVvZiAqdnEtPnVzZWQtPnJpbmcpKQo+ID4gKwkJCQkgICAgICAgdmhvc3Rf
Z2V0X3VzZWRfc2l6ZSh2cSwgdnEtPm51bSkpKQo+ID4gICAJCQlyZXR1cm4gLUVJTlZBTDsKPiA+
ICAgCX0KPiA+IAo+ID4gCj4gCj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgpMaW51cyBhbHJlYWR5IG1lcmdlZCB0aGlzLCBJIGNhbid0IGFkZCB5b3VyIGFjaywg
c29ycnkhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
