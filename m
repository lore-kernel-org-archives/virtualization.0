Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA97C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 110AE6129F;
	Fri, 10 Mar 2023 09:53:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 110AE6129F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzsN63Id
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pK20lbzDrvj5; Fri, 10 Mar 2023 09:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68B9B60B23;
	Fri, 10 Mar 2023 09:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68B9B60B23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47F61C0035;
	Fri, 10 Mar 2023 09:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63822C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F22F402D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F22F402D4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzsN63Id
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZ8bmA9SlmSZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70F5B4014E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70F5B4014E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678442033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJZ+haSRLZgV6ZdKradu2QUHXRi+jxvd6L7UDmrPOnQ=;
 b=IzsN63Ido+Oxpcho7d9aaLDVmztOh7l6rtuZrfkB1cJ0u9RIIY5ooiTcXytJFnav5nC8Ba
 Gj3Hs2hKfXgJ4PTYV4zsDZCls2lJ6kqpnZ3apIOj5QR9Rw1HLe3A+MUcrehKEA8KnbyHOq
 eU0CuiRw8GJv70/V+gGqMZWnVRck/f4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Vlqq1kzPNeaq7PFnAGhN8w-1; Fri, 10 Mar 2023 04:53:49 -0500
X-MC-Unique: Vlqq1kzPNeaq7PFnAGhN8w-1
Received: by mail-ed1-f71.google.com with SMTP id
 u10-20020a056402064a00b004c689813557so6938526edx.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678442028;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJZ+haSRLZgV6ZdKradu2QUHXRi+jxvd6L7UDmrPOnQ=;
 b=s/RLUscPZmbCW56ou+zlEh/fz8Rch50YmrnkBi2HHLjmYAF7NayInZs2N4r547wepC
 1+jLGrudj7QKOJaih+DrGeEQfml7pm/vXG2vGSL4ezPmV+qlkq8trcObiUn/v0wkEKXL
 NLNbc2jifhOctIHWeI5ff31NzKvH7gTnXSasuAQqgXaWZMbG7zNHE0A/PTlCfVwWkERO
 WG04xDpf3TJVrTm65phdNkqzIAzGlgLaoWXV422cXO1FdvVdwAiAr4lepRlpxMyJombr
 S/u/MTIhEcAF3V1hH8hLuQD/fidND8a4LIe1GjQ4TKW+lhYQNDA0u88KYr9U3onsxmr+
 TxPg==
X-Gm-Message-State: AO0yUKXv6KNn2Q4r+IvHBN01n9WkEmy5k+aisQXGNXTxRv1sRRnGi1CB
 8HliGNXlKfs4ugspYNxwpjxzL/iARrXjgIPqEeoIqX6Iftw9veTgchWp7n2jlYPKR6qRtRC0tTy
 QWMLbC9DySI39sghcbk/MWV2+IXBOOenUPXAH07xyUg==
X-Received: by 2002:a17:907:c24c:b0:8af:2b57:b80f with SMTP id
 tj12-20020a170907c24c00b008af2b57b80fmr26919608ejc.55.1678442028257; 
 Fri, 10 Mar 2023 01:53:48 -0800 (PST)
X-Google-Smtp-Source: AK7set84hVHKVbQM3/doo56JfwRs1MHyLT3B6JMxFy3rht/7SrZaJgsFx7Yr+6LNKTCvUqzlg4M8yA==
X-Received: by 2002:a17:907:c24c:b0:8af:2b57:b80f with SMTP id
 tj12-20020a170907c24c00b008af2b57b80fmr26919592ejc.55.1678442027988; 
 Fri, 10 Mar 2023 01:53:47 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 op7-20020a170906bce700b008e2dfc6382asm750509ejb.125.2023.03.10.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:53:47 -0800 (PST)
Date: Fri, 10 Mar 2023 04:53:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230310045100-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
 <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com>
 <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
 <20230310034101-mutt-send-email-mst@kernel.org>
 <CACGkMEsr3xSa=1WtU35CepWSJ8CK9g4nGXgmHS_9D09LHi7H8g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsr3xSa=1WtU35CepWSJ8CK9g4nGXgmHS_9D09LHi7H8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
 Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 netdev@vger.kernel.org, robin.murphy@arm.com, wangrong68@huawei.com
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

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgMDU6NDU6NDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIE1hciAxMCwgMjAyMyBhdCA0OjQx4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBGZWIgMjAsIDIwMjMgYXQg
MTA6Mzc6MThBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBGZWIgMTcs
IDIwMjMgYXQgODo0MyBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToK
PiA+ID4gPgo+ID4gPiA+IE9uIEZyaSwgRmViIDE3LCAyMDIzIGF0IDA1OjEyOjI5QU0gLTA1MDAs
IE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIFRodSwgRmViIDE2LCAyMDIz
IGF0IDA4OjE0OjUwUE0gLTA0MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiA+ID4gPiA+ID4g
T24gVHVlLCBGZWIgMDcsIDIwMjMgYXQgMDg6MDg6NDNQTSArMDgwMCwgTmFueW9uZyBTdW4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gRnJvbTogUm9uZyBXYW5nIDx3YW5ncm9uZzY4QGh1YXdlaS5jb20+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbmNlIGVuYWJsZSBpb21tdSBkb21haW4gZm9y
IG9uZSBkZXZpY2UsIHRoZSBNU0kKPiA+ID4gPiA+ID4gPiB0cmFuc2xhdGlvbiB0YWJsZXMgaGF2
ZSB0byBiZSB0aGVyZSBmb3Igc29mdHdhcmUtbWFuYWdlZCBNU0kuCj4gPiA+ID4gPiA+ID4gT3Ro
ZXJ3aXNlLCBwbGF0Zm9ybSB3aXRoIHNvZnR3YXJlLW1hbmFnZWQgTVNJIHdpdGhvdXQgYW4KPiA+
ID4gPiA+ID4gPiBpcnEgYnlwYXNzIGZ1bmN0aW9uLCBjYW4gbm90IGdldCBhIGNvcnJlY3QgbWVt
b3J5IHdyaXRlIGV2ZW50Cj4gPiA+ID4gPiA+ID4gZnJvbSBwY2llLCB3aWxsIG5vdCBnZXQgaXJx
cy4KPiA+ID4gPiA+ID4gPiBUaGUgc29sdXRpb24gaXMgdG8gb2J0YWluIHRoZSBNU0kgcGh5IGJh
c2UgYWRkcmVzcyBmcm9tCj4gPiA+ID4gPiA+ID4gaW9tbXUgcmVzZXJ2ZWQgcmVnaW9uLCBhbmQg
c2V0IGl0IHRvIGlvbW11IE1TSSBjb29raWUsCj4gPiA+ID4gPiA+ID4gdGhlbiB0cmFuc2xhdGlv
biB0YWJsZXMgd2lsbCBiZSBjcmVhdGVkIHdoaWxlIHJlcXVlc3QgaXJxLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBQcm9iYWJseSBub3Qgd2hhdCBhbnlvbmUgd2FudHMgdG8gaGVhciwgYnV0IEkg
d291bGQgcHJlZmVyIHdlIG5vdCBhZGQKPiA+ID4gPiA+ID4gbW9yZSB1c2VzIG9mIHRoaXMgc3R1
ZmYuIEl0IGxvb2tzIGxpa2Ugd2UgaGF2ZSB0byBnZXQgcmlkIG9mCj4gPiA+ID4gPiA+IGlvbW11
X2dldF9tc2lfY29va2llKCkgOlwKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSdkIGxpa2UgaXQg
aWYgdmRwYSBjb3VsZCBtb3ZlIHRvIGlvbW11ZmQgbm90IGtlZXAgY29weWluZyBzdHVmZiBmcm9t
Cj4gPiA+ID4gPiA+IGl0Li4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBYnNvbHV0ZWx5IGJ1dCB3aGVu
IGlzIHRoYXQgaGFwcGVuaW5nPwo+ID4gPiA+Cj4gPiA+ID4gRG9uJ3Qga25vdywgSSB0aGluayBp
dCBoYXMgdG8gY29tZSBmcm9tIHRoZSBWRFBBIG1haW50YWluZXJzLCBOaWNvbGluCj4gPiA+ID4g
bWFkZSBzb21lIGRyYWZ0cyBidXQgd2Fzbid0IGFibGUgdG8gZ2V0IGl0IGJleW9uZCB0aGF0Lgo+
ID4gPgo+ID4gPiBDaW5keSAoY2NlZCkgd2lsbCBjYXJyeSBvbiB0aGUgd29yay4KPiA+ID4KPiA+
ID4gVGhhbmtzCj4gPgo+ID4gSG1tIGRpZG4ndCBzZWUgYW55dGhpbmcgeWV0LiBOYW55b25nIFN1
biBtYXliZSB5b3UgY2FuIHRha2UgYSBsb29rPwo+IAo+IEp1c3QgdG8gY2xhcmlmeSwgQ2luZHkg
d2lsbCB3b3JrIG9uIHRoZSBpb21tdWZkIGNvbnZlcnNpb24gZm9yCj4gdmhvc3QtdkRQQSwgdGhl
IGNoYW5nZXMgYXJlIG5vbi10cml2aWFsIGFuZCBtYXkgdGFrZSB0aW1lLiBCZWZvcmUgd2UKPiBh
cmUgYWJsZSB0byBhY2hpZXZlIHRoYXQsICBJIHRoaW5rIHdlIHN0aWxsIG5lZWQgc29tZXRoaW5n
IGxpa2UgdGhpcwo+IHBhdGNoIHRvIG1ha2UgdkRQQSB3b3JrIG9uIHNvZnR3YXJlIG1hbmFnZWQg
TVNJIHBsYXRmb3Jtcy4KPiAKPiBNYXliZSBOYW55b25nIGNhbiBwb3N0IGEgbmV3IHZlcnNpb24g
dGhhdCBhZGRyZXNzZXMgdGhlIGNvbW1lbnQgc28gZmFyPwo+IAo+IFRoYW5rcwoKTWF5YmUgYnV0
IGFuIGFjayBmcm9tIGlvbW11IG1haW50YWluZXJzIHdpbGwgYmUgbmVlZGVkIGFueXdheS4gTGV0
J3Mgc2VlCnRoYXQgdmVyc2lvbiwgbWF5YmUgc3BsaXQgdGhlIGV4cG9ydCB0byBhIHBhdGNoIGJ5
IGl0c2VsZiB0byBtYWtlIHRoZQpuZWVkIGZvciB0aGF0IGFjayBjbGVhci4KCgo+ID4KPiA+ID4g
Pgo+ID4gPiA+IFBsZWFzZSBoYXZlIHBlb3BsZSB3aG8gbmVlZCBtb3JlIGlvbW11IHBsYXRmb3Jt
IGVuYWJsZW1lbnQgdG8gcGljayBpdAo+ID4gPiA+IHVwIGluc3RlYWQgb2YgbWVyZ2luZyBoYWNr
cyBsaWtlIHRoaXMuLgo+ID4gPiA+Cj4gPiA+ID4gV2UgYXJlIHZlcnkgY2xvc2UgdG8gaGF2aW5n
IG5lc3RlZCB0cmFuc2xhdGlvbiBvbiBBUk0gc28gYW55b25lIHdobyBpcwo+ID4gPiA+IHNlcmlv
dXMgYWJvdXQgVkRQQSBvbiBBUk0gaXMgZ29pbmcgdG8gbmVlZCBpb21tdWZkIGFueWhvdy4KPiA+
ID4gPgo+ID4gPiA+IEphc29uCj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
