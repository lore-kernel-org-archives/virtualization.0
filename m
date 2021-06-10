Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0869C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 04:30:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A296135C
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 04:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A296135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17756606DE;
	Thu, 10 Jun 2021 04:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tH-c_drEp34Z; Thu, 10 Jun 2021 04:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 834D46062B;
	Thu, 10 Jun 2021 04:30:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56923C000D;
	Thu, 10 Jun 2021 04:30:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC20FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE31040382
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06Z8IAmYXPm5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 325B9401CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623299410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8hUoJLo6PQHGOlEFPvoDydMJLFbad+V5wSYq0CsKZ8=;
 b=cVZPV9reNtXMDGp94RlY8dOCCGNH3e4aed9GIaKdPaMMJeoVzlCCFlBKMSncMlhkd1sR8P
 LNDXJ3POkK7R4gEfkGTD8awXcazOCojW/eLa59ouRgvuYLMAjQj5DnTR4DCpmbSxJ2qzMf
 38cRr2y2FOfNsCl55SOXHRfi1TYwj9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-BcsRN7E9Nsijs2OHvpwA3g-1; Thu, 10 Jun 2021 00:30:09 -0400
X-MC-Unique: BcsRN7E9Nsijs2OHvpwA3g-1
Received: by mail-wr1-f71.google.com with SMTP id
 n4-20020a5d42040000b0290119fef97609so257824wrq.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 21:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b8hUoJLo6PQHGOlEFPvoDydMJLFbad+V5wSYq0CsKZ8=;
 b=YHkD8IC3kvV63dhfbQdhTmwhyN5g2LsC/q+Osbyw6CXQyAo6FdhzutFGU4SdRsxR9z
 DcT4p3eiKfQxIWW6EItJlvq8xTB2cRagMsL6s9Z9YCff3X2TVdQ9/uSCGT8cEdl4DfPL
 dqaR7rldFA6h2ViTt9BZ0TbL+YuWpGXPuiyg3Airx2dLlbSKiiydmjcdzKH1hWgF2LaQ
 5JygTneZI+f9qyMZJzDyOTEDzlnAT+rhrK0sutKq7nv/Be9BA4Y1EF+5hbqOaqWMFmEj
 GFTBN5c1hiE4R7xjE/rvPISt4I72h3dROzMDWapK3UX8dvIvWekqEdnmIznz3CAe1HsT
 hy/w==
X-Gm-Message-State: AOAM53297Ldy19hOUopt3yi8sYSUSivJj8pkXAoH627ikcFyVsh17EfW
 th5tKy0niNzbXPXuif8YkY+XU+ZB7hNSD7I/uVZXD+z6GrAPTORsBxpOscWsOWAfYJaNBW9unT5
 IdEc6N8VyuEyEi2uHZ/bVUMTnu0UFL5W56DOZ3cHy8w==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr3042718wmh.24.1623299408456; 
 Wed, 09 Jun 2021 21:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGZH4TpiaMAKjkHc3ZiHIvFq1IH4L3/zQRGERZrQ2fUH/IKhXzt+seUn+txiu636DqoI2IWA==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr3042699wmh.24.1623299408247; 
 Wed, 09 Jun 2021 21:30:08 -0700 (PDT)
Received: from redhat.com ([77.124.100.105])
 by smtp.gmail.com with ESMTPSA id a4sm1589320wme.45.2021.06.09.21.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 21:30:07 -0700 (PDT)
Date: Thu, 10 Jun 2021 00:30:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Security hole in vhost-vdpa?
Message-ID: <20210610002358-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
 <20210606173637-mutt-send-email-mst@kernel.org>
 <82e91727-79f4-b6f1-37f1-9fb5bdf67b8d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <82e91727-79f4-b6f1-37f1-9fb5bdf67b8d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Gautam Dawar <gdawar@xilinx.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMTA6MTA6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82Lzcg5LiK5Y2INTozOCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFN1biwgSnVuIDA2LCAyMDIxIGF0IDAyOjM5OjQ4UE0gKzAwMDAsIEdhdXRhbSBE
YXdhciB3cm90ZToKPiA+ID4gSGkgQWxsLAo+ID4gPiAKPiA+ID4gCj4gPiA+IFRoaXMgaXMgaW4g
Y29udGludWF0aW9uIHRvIG15IGZpbmRpbmdzIG5vdGVkIGluIEJ1ZyAyMTMxNzkgYW5kIGRpc2N1
c3Npb25zIHdlCj4gPiA+IGhhdmUgaGFkIGluIHRoZSBsYXN0IGNvdXBsZSBvZiB3ZWVrcyBvdmVy
IGVtYWlscy4KPiA+ID4gCj4gPiA+IAo+ID4gPiBUb2RheSwgSSBwdWJsaXNoZWQgdGhlIGZpcnN0
IHBhdGNoIGZvciB0aGlzIGlzc3VlIHdoaWNoIGFkZHMgdGltZW91dCBiYXNlZCB3YWl0Cj4gPiA+
IGZvciBjb21wbGV0aW9uIGV2ZW50IGFuZCBhbHNvIGxvZ3MgYSB3YXJuaW5nIG1lc3NhZ2UgdG8g
YWxlcnQgdGhlIHVzZXIvCj4gPiA+IGFkbWluaXN0cmF0b3Igb2YgdGhlIHByb2JsZW0uCj4gPiBD
YW4ndCBjbG9zZSBqdXN0IGZpbmlzaCB3aXRob3V0IHdhaXRpbmcgZm9yIHVzZXJzcGFjZT8KPiAK
PiAKPiBJdCB3b3JrcyBhcyBsb25nIGFzIHdlIGRvbid0IHVzZSBtbWFwKCkuIFdoZW4gd2UgbWFw
IGtpY2tzLCBpdCBsb29rcyB0byBtZQo+IHRoZXJlJ3Mgbm8gd2F5IHRvICJyZXZva2UiIHRoZSBt
YXBwaW5nIGZyb20gdXNlcnNwYWNlPwo+IAo+IFRoYW5rcwoKQ2FuJ3Qgd2UgdHJhY2sgdGhlc2Ug
bWFwcGluZ3MgYW5kIG1hcCBzb21lIG90aGVyIHBhZ2UgdGhlcmU/Ckxpa2VseSBubyBtb3JlIHRo
YW4gb25lIGlzIG5lZWRlZCAuLi4KCgoKPiAKPiA+IFRoZW4gbm90aWZ5IHVzZXJzcGFjZSBhYm91
dCBhbnkgYnVmZmVycyB0aGF0IGRpZCBub3QgY29tcGxldGUgLi4uCj4gPiAKPiA+IAo+ID4gPiBB
cyBhIG5leHQgc3RlcCwgdGhlIGlkZWEgaXMgdG8gaW1wbGVtZW50IGEgbWVjaGFuaXNtIHRvIGFs
bG93IHZob3N0LXZkcGEgbW9kdWxlCj4gPiA+IG5vdGlmeSB1c2Vyc3BhY2UgYXBwIChRRU1VKSB0
byBjbG9zZSB0aGUgZmQgY29ycmVzcG9uZGluZyB0byB0aGUgdmhvc3QtdmRwYQo+ID4gPiBjaGFy
YWN0ZXIgZGV2aWNlIHdoZW4gaXQgaXMgd2FpdGluZyBmb3IgdGhlIGNvbXBsZXRpb24gZXZlbnQg
aW4KPiA+ID4gdmhvc3RfdmRwYV9yZW1vdmUoKS4gSmFzb24gY29uZmlybWVkIHRoaXMgYnkgc2F5
aW5nIHRoYXQgd2UgbmVlZCBhIG5ldyBldmVudGZkLwo+ID4gPiBpb2N0bCB0byByZWNlaXZlIGhv
dCByZW1vdmUgcmVxdWVzdCBmcm9tIGtlcm5lbC4KPiA+ID4gCj4gPiA+IAo+ID4gPiBBbHRob3Vn
aCwgd2UgY2FuIHByb2NlZWQgdG8gaW1wbGVtZW50IGNoYW5nZXMgZm9yIHRoZSBwYXJ0IGRlc2Ny
aWJlZCBhYm92ZSBidXQKPiA+ID4gSSBmZWVsIHRoYXQgdGhhdCB0aGUgcHJvYmxlbSBpcyBtdWNo
IGRlZXBlciB0aGFuIHRoYXQuIFRoaXMgbWVjaGFuaXNtIHdpbGwganVzdAo+ID4gPiByZXF1ZXN0
IHRoZSB1c2Vyc3BhY2UgdG8gY2xvc2UgdGhlIGZkIGFuZCBsZXQgdmhvc3QtdmRwYSBwcm9jZWVk
IHdpdGggdGhlCj4gPiA+IGNsZWFuLXVwLiBIb3dldmVyLCBJTUhPIHRoaW5ncyBzaG91bGQgYmUg
dW5kZXIgbW9yZSBjb250cm9sIG9mIGtlcm5lbCBzcGFjZQo+ID4gPiB0aGFuIHRoZSB1c2VyIHNw
YWNlLgo+ID4gPiAKPiA+ID4gCj4gPiA+IFRoZSBwcm9ibGVtIEkgYW0gdHJ5aW5nIHRvIGhpZ2hs
aWdodCBpcyB0aGF0IGEgbWFsaWNpb3VzIHVzZXItc3BhY2UgYXBwbGljYXRpb24KPiA+ID4gY2Fu
IHJlbmRlciBhbnkgbW9kdWxlIHJlZ2lzdGVyaW5nIGEgdkRQQSBkZXZpY2UgdG8gaGFuZyBpbiB0
aGVpcgo+ID4gPiBkZS1pbml0aWFsaXphdGlvbiBzZXF1ZW5jZS4gVGhpcyB3aWxsIHR5cGljYWxs
eSBzdXJmYWNlIHdoZW4KPiA+ID4gdmRwYV9kZXZpY2VfdW5yZWdpc3RlcigpIGlzIGNhbGxlZCBm
cm9tIHRoZSBmdW5jdGlvbiByZXNwb25zaWJsZSBmb3IgbW9kdWxlCj4gPiA+IHVubG9hZCBsZWFk
aW5nIHJtbW9kIGNvbW1hbmRzIHRvIG5vdCByZXR1cm4sIGZvcmV2ZXIuCj4gPiA+IAo+ID4gPiAK
PiA+ID4gVG8gcHJvdmUgbXkgcG9pbnQsIEkgY3JlYXRlZCBhIHNpbXBsZSBDIHByb2dyYW0gKHRl
c3RfdmRwYS5jKSB0aGF0IG9wZW5zIHRoZQo+ID4gPiB2aG9zdC12ZHBhIGNoYXJhY3RlciBkZXZp
Y2UgYW5kIG5ldmVyIGV4aXRzLiBUaGUgbG9ncyAodGVzdF9sb2dzLnR4dCkgc2hvdyB0aGF0Cj4g
PiA+IGFmdGVyIHJlZ2lzdGVyaW5nIHRoZSB2RFBBIGRldmljZSBmcm9tIHNmYyBkcml2ZXIsIHZo
b3N0LXZkcGEgbW9kdWxlIGNyZWF0ZXMKPiA+ID4gdGhlIGNoYXIgZGV2aWNlIC9kZXYvdmhvc3Qt
dmRwYS0wICBmb3IgaXQuIEFzIHRoaXMgaXMgYXZhaWxhYmxlIHRvIGFsbCBhcHBzIGluCj4gPiA+
IHRoZSB1c2Vyc3BhY2UsIHRoZSBtYWxpY2lvdXMgYXBwICguL2Jsb2NrX3ZkcGFfdW5sb2FkKSBv
cGVucyB0aGlzIGRldmljZSBhbmQKPiA+ID4gZ29lcyB0byBpbmZpbml0ZSBzbGVlcC4gQXQgdGhp
cyB0aW1lLCB3aGVuIG1vZHVsZSB1bmxvYWQgKHJtbW9kIHNmYykgaXMgY2FsbGVkLAo+ID4gPiBp
dCBoYW5ncyBhbmQgdGhlIGZvbGxvd2luZyBwcmludCBpbmZvcm1zIHRoZSB1c2VyL2FkbWluIG9m
IHRoaXMgc3RhdGUgd2l0aAo+ID4gPiBmb2xsb3dpbmcgbWVzc2FnZToKPiA+ID4gCj4gPiA+IFsg
ODE4MC4wNTM2NDddICB2aG9zdC12ZHBhLTA6IHZob3N0X3ZkcGFfcmVtb3ZlIHdhaXRpbmcgZm9y
IC9kZXYvdmhvc3QtdmRwYS0wCj4gPiA+IHRvIGJlIGNsb3NlZAo+ID4gPiAKPiA+ID4gCj4gPiA+
IEZpbmFsbHksIHdoZW4gYmxvY2tfdmRwYV91bmxvYWQgaXMga2lsbGVkLCB2aG9zdF92ZHBhX3Jl
bW92ZSgpIHVuYmxvY2tzIGFuZCBzZmMKPiA+ID4gbW9kdWxlIGlzIHVubG9hZGVkLgo+ID4gPiAK
PiA+ID4gCj4gPiA+IFdpdGggc3VjaCBhcHBsaWNhdGlvbiBydW5uaW5nIGluIHVzZXJzcGFjZSwg
YSBrZXJuZWwgbW9kdWxlICh0aGF0IHJlZ2lzdGVyZWQKPiA+ID4gY29ycmVzcG9uZGluZyB2RFBB
IGRldmljZSkgd2lsbCBoYW5nIGR1cmluZyB1bmxvYWQgc2VxdWVuY2UuIFN1Y2ggY29udHJvbCBv
Zgo+ID4gPiB0aGUgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIG9uIHRoZSBzeXN0ZW0gcmVzb3VyY2Vz
IHNob3VsZCBjZXJ0YWlubHkgYmUKPiA+ID4gcHJldmVudGVkLgo+ID4gPiAKPiA+ID4gVG8gbWUs
IHRoaXMgc2VlbXMgdG8gYmUgYSBzZXJpb3VzIGlzc3VlIGFuZCByZXF1aXJlcyBtb2RpZmljYXRp
b25zIGluIHRoZSB3YXkKPiA+ID4gaXQgaXMgY3VycmVudGx5IGhhbmRsZWQgaW4gdmhvc3QtdmRw
YSAoYW5kIG90aGVyIG1vZHVsZXMgKFZGSU8/KSB3aXRoIHNpbWlsYXIKPiA+ID4gaW1wbGVtZW50
YXRpb24pLgo+ID4gPiAKPiA+ID4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCj4gPiA+IAo+
ID4gPiAKPiA+ID4gUmVnYXJkcywKPiA+ID4gCj4gPiA+IEdhdXRhbSBEYXdhcgo+ID4gPiAKPiA+
ID4gI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4gPiA+ICNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ID4g
I2luY2x1ZGUgPHN0ZGxpYi5oPgo+ID4gPiAjaW5jbHVkZSA8c3RkaW8uaD4KPiA+ID4gI2luY2x1
ZGUgPGZjbnRsLmg+Cj4gPiA+ICNpbmNsdWRlIDxlcnJuby5oPgo+ID4gPiAKPiA+ID4gaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ID4gPiB7Cj4gPiA+ICAgICB1bnNpZ25lZCBpbnQg
aW5kZXg7Cj4gPiA+ICAgICBjaGFyIGRldl9wYXRoWzMwXTsKPiA+ID4gICAgIGludCBmZDsKPiA+
ID4gCj4gPiA+ICAgICBpZiAoYXJnYyAhPSAyKSB7Cj4gPiA+IAkgICBwcmludGYoIlVzYWdlOiAl
cyA8dmhvc3QtdmRwYSBkZXZpY2UgaW5kZXg+XG4iLCBhcmd2WzBdKTsKPiA+ID4gCSAgIHJldHVy
biAtMTsKPiA+ID4gICAgIH0KPiA+ID4gCj4gPiA+ICAgICBpbmRleCA9IHN0cnRvdWwoYXJndlsx
XSwgTlVMTCwgMTApOwo+ID4gPiAKPiA+ID4gICAgIHNucHJpbnRmKGRldl9wYXRoLCBzaXplb2Yo
ZGV2X3BhdGgpLCAiL2Rldi92aG9zdC12ZHBhLSV1IiwgaW5kZXgpOwo+ID4gPiAgICAgZmQgPSBv
cGVuKGRldl9wYXRoLCBPX1JEV1IpOwo+ID4gPiAgICAgaWYoZmQgPCAwKQo+ID4gPiAgICAgewo+
ID4gPiAgICAgICAgIHByaW50ZigiRmFpbGVkIHRvIG9wZW4gJXMsIGVycm5vOiAlZCFcbiIsIGRl
dl9wYXRoLCBlcnJubyk7Cj4gPiA+ICAgICAgICAgcmV0dXJuIDE7Cj4gPiA+ICAgICB9Cj4gPiA+
IAo+ID4gPiAgICAgcHJpbnRmKCJCbG9ja2luZyB1bmxvYWQgb2YgZHJpdmVyIHRoYXQgcmVnaXN0
ZXJlZCB2RFBBIGRldmljZSIKPiA+ID4gCSAgIiBjb3JyZXNwb25kaW5nIHRvIGNkZXYgJXMgY3Jl
YXRlZCBieSB2aG9zdC12ZHBhXG4iLCBkZXZfcGF0aCk7Cj4gPiA+ICAgICB3aGlsZSAoMSkKPiA+
ID4gCSAgIHNsZWVwKDEpOwo+ID4gPiAKPiA+ID4gICAgIGNsb3NlKGZkKTsKPiA+ID4gICAgIHJl
dHVybiAwOwo+ID4gPiB9Cj4gPiA+IFtyb290QG5kcjczMHAgfl0jIH4vY3JlYXRlX3ZkcGFfZGV2
aWNlLnNoCj4gPiA+IAo+ID4gPiBbcm9vdEBuZHI3MzBwIH5dIyBsbCAvZGV2L3Zob3N0LXZkcGEt
MAo+ID4gPiBjcnctLS0tLS0tIDEgcm9vdCByb290IDI0MCwgMCBKdW4gIDYgMTk6NTkgL2Rldi92
aG9zdC12ZHBhLTAKPiA+ID4gCj4gPiA+IFtyb290QG5kcjczMHAgfl0jIC4vYmxvY2tfdmRwYV91
bmxvYWQgMCAmCj4gPiA+IFsxXSAxMDkzMAo+ID4gPiBCbG9ja2luZyB1bmxvYWQgb2YgZHJpdmVy
IHRoYXQgcmVnaXN0ZXJlZCB2RFBBIGRldmljZSBjb3JyZXNwb25kaW5nIHRvIGNkZXYgL2Rldi92
aG9zdC12ZHBhLTAgY3JlYXRlZCBieSB2aG9zdC12ZHBhCj4gPiA+IAo+ID4gPiBbcm9vdEBuZHI3
MzBwIH5dIyBybW1vZCBzZmMKPiA+ID4gWyA4MTc5LjAxMDUyMF0gc2ZjX2VmMTAwIDAwMDA6MDY6
MDAuNDogZWYxMDBfdmRwYV9kZWxldGU6IENhbGxpbmcgdmRwYSB1bnJlZ2lzdGVyIGRldmljZQo+
ID4gPiBbIDgxODAuMDUzNjQ3XSAgdmhvc3QtdmRwYS0wOiB2aG9zdF92ZHBhX3JlbW92ZSB3YWl0
aW5nIGZvciAvZGV2L3Zob3N0LXZkcGEtMCB0byBiZSBjbG9zZWQKPiA+ID4gCj4gPiA+IFtyb290
QG5kcjczMHAgfl0jIGtpbGwgLTkgMTA5MzAKPiA+ID4gWyA4MjE4LjM5Mjg5N10gc2ZjX2VmMTAw
IDAwMDA6MDY6MDAuMDogc2h1dGRvd24gc3VjY2Vzc2Z1bAo+ID4gPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
