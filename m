Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573CEC7EE2F
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 09:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD45640568;
	Wed,  7 Jun 2023 09:43:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD45640568
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bR/vJcuL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ikE8PGCdwx3; Wed,  7 Jun 2023 09:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46DBC400D0;
	Wed,  7 Jun 2023 09:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46DBC400D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB46C0037;
	Wed,  7 Jun 2023 09:43:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 592CEC0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 09:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DE88415E2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 09:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DE88415E2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bR/vJcuL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iIG1aDRlD-t
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 09:43:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1EF44155B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1EF44155B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686131025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QZ1hF21NiKTJobI8K1XAh5a08hU1n8m1daENZFoRs8=;
 b=bR/vJcuLMZzRVC2PM3Dg/P/C7dZwtzQeEWtWqD88SbGvH3SW2yQvm7uihrqJ3JIazlceeF
 0AHNa7eHZyW1d7Sfxd3eWgWWrIMUNdWahX504meaKehxYqtwWdTMWXIXk3a0o9caflYN/G
 tsWs+qocLrOTgnGHHRrGdpchxlExkeg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-031c2N8bP3mvPmcdp19cgw-1; Wed, 07 Jun 2023 05:43:44 -0400
X-MC-Unique: 031c2N8bP3mvPmcdp19cgw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30af6a5b6b0so3126957f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 02:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686131023; x=1688723023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QZ1hF21NiKTJobI8K1XAh5a08hU1n8m1daENZFoRs8=;
 b=lxA11CPT7b1wwyhOPxt0gqAR40UNNj4QbMvThViXA2qpAZflidjogWpGSu3NQy7zDY
 stiZLbse3wymUpTThDEjJdZ5RnUn66YJ4zrf3PNnMOU1/GHFlx8QxmQanmt1g4jYVeHY
 1nAtg7rxagoPHuA8BJPxthW7s+gbU1lD4bVotQMq1GRLW4WEGQ93mFT3apHj0PkA/W9R
 sAmQUTO/nGhqZyAddFip1VZURkuZevW7EZqp41Y/R+ui+cXjEbwC/TXycXRYuW3OO4CQ
 3fQWxxQ6Qfb4xju3oKl/e0f5I/4WySOVjdGoICKflW4wvkZXjaz9VtQ0o8w5LfMSX2AM
 t3lg==
X-Gm-Message-State: AC+VfDxaT5nCjlitqV79F/GiZSIUvGHYvrJy81Se0NCpUjP5icsUlI3M
 oVb9cxn0dU/0/k2S+ib+XkLrRNAZUJ10DjudOcODXuoK8QIT2AVvmEfPSVnCrXPI2A4jo4R3fXM
 jZgz4AzMn0owq+DCSudGDzRt64DAFCFo2gQotWgSNHw==
X-Received: by 2002:adf:f752:0:b0:309:3b8d:16a8 with SMTP id
 z18-20020adff752000000b003093b8d16a8mr3811520wrp.50.1686131023290; 
 Wed, 07 Jun 2023 02:43:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5r8F++2zoGvW9X0FQgUyGuci7Faw6wUX9bX8XWZ5GmLoFQBI7RaLBvwAY8GuRxbZAJ6VSSdQ==
X-Received: by 2002:adf:f752:0:b0:309:3b8d:16a8 with SMTP id
 z18-20020adff752000000b003093b8d16a8mr3811501wrp.50.1686131022945; 
 Wed, 07 Jun 2023 02:43:42 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 o1-20020a5d6841000000b003079c402762sm14993624wrw.19.2023.06.07.02.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 02:43:42 -0700 (PDT)
Date: Wed, 7 Jun 2023 05:43:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230607054246-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gV2VkLCBKdW4gMDcsIDIwMjMgYXQgMTA6Mzk6MTVBTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+IE9uIFR1ZSwgSnVuIDYsIDIwMjMgYXQgMjo1OOKAr1BNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgSnVuIDA2LCAy
MDIzIGF0IDA5OjI5OjIyQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIE1vbiwg
SnVuIDUsIDIwMjMgYXQgMTA6NTjigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQg
MDk6NTQ6NTdBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID5PbiBN
b24sIEp1biAwNSwgMjAyMyBhdCAwMzozMDozNVBNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4gPiA+ID4gPj4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDk6MDA6MjVBTSAtMDQw
MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4+ID4gT24gTW9uLCBKdW4gMDUs
IDIwMjMgYXQgMDI6NTQ6MjBQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4g
PiA+ID4+ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwODo0MTo1NEFNIC0wNDAwLCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPj4gPiA+ID4gT24gTW9uLCBKdW4gMDUsIDIw
MjMgYXQgMDE6MDY6NDRQTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+
ID4+ID4gPiA+ID4gdmhvc3QtdmRwYSBJT0NUTHMgKGVnLiBWSE9TVF9HRVRfVlJJTkdfQkFTRSwg
VkhPU1RfU0VUX1ZSSU5HX0JBU0UpCj4gPiA+ID4gPj4gPiA+ID4gPiBkb24ndCBzdXBwb3J0IHBh
Y2tlZCB2aXJ0cXVldWUgd2VsbCB5ZXQsIHNvIGxldCdzIGZpbHRlciB0aGUKPiA+ID4gPiA+PiA+
ID4gPiA+IFZJUlRJT19GX1JJTkdfUEFDS0VEIGZlYXR1cmUgZm9yIG5vdyBpbiB2aG9zdF92ZHBh
X2dldF9mZWF0dXJlcygpLgo+ID4gPiA+ID4+ID4gPiA+ID4KPiA+ID4gPiA+PiA+ID4gPiA+IFRo
aXMgd2F5LCBldmVuIGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaXQsIHdlIGRvbid0IHJpc2sgaXQg
YmVpbmcKPiA+ID4gPiA+PiA+ID4gPiA+IG5lZ290aWF0ZWQsIHRoZW4gdGhlIFZNTSBpcyB1bmFi
bGUgdG8gc2V0IHRoZSB2cmluZyBzdGF0ZSBwcm9wZXJseS4KPiA+ID4gPiA+PiA+ID4gPiA+Cj4g
PiA+ID4gPj4gPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2
RFBBLWJhc2VkIGJhY2tlbmQiKQo+ID4gPiA+ID4+ID4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKPiA+ID4gPiA+PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFy
ZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiA+ID4gPiA+PiA+ID4gPiA+IC0tLQo+ID4gPiA+
ID4+ID4gPiA+ID4KPiA+ID4gPiA+PiA+ID4gPiA+IE5vdGVzOgo+ID4gPiA+ID4+ID4gPiA+ID4g
ICAgIFRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFwcGxpZWQgYmVmb3JlIHRoZSAiW1BBVENIIHYyIDAv
M10gdmhvc3RfdmRwYToKPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBiZXR0ZXIgUEFDS0VEIHN1cHBv
cnQiIHNlcmllcyBbMV0gYW5kIGJhY2twb3J0ZWQgaW4gc3RhYmxlIGJyYW5jaGVzLgo+ID4gPiA+
ID4+ID4gPiA+ID4KPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBXZSBjYW4gcmV2ZXJ0IGl0IHdoZW4g
d2UgYXJlIHN1cmUgdGhhdCBldmVyeXRoaW5nIGlzIHdvcmtpbmcgd2l0aAo+ID4gPiA+ID4+ID4g
PiA+ID4gICAgIHBhY2tlZCB2aXJ0cXVldWVzLgo+ID4gPiA+ID4+ID4gPiA+ID4KPiA+ID4gPiA+
PiA+ID4gPiA+ICAgICBUaGFua3MsCj4gPiA+ID4gPj4gPiA+ID4gPiAgICAgU3RlZmFubwo+ID4g
PiA+ID4+ID4gPiA+ID4KPiA+ID4gPiA+PiA+ID4gPiA+ICAgICBbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMjAyMzA0MjQyMjUwMzEuMTg5NDctMS1zaGFubm9uLm5l
bHNvbkBhbWQuY29tLwo+ID4gPiA+ID4+ID4gPiA+Cj4gPiA+ID4gPj4gPiA+ID4gSSdtIGEgYml0
IGxvc3QgaGVyZS4gU28gd2h5IGFtIEkgbWVyZ2luZyAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiB0
aGVuPwo+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4+ID4gPiBUbyByZWFsbHkgc3VwcG9ydCBwYWNr
ZWQgdmlydHF1ZXVlIHdpdGggdmhvc3QtdmRwYSwgYXQgdGhhdCBwb2ludCB3ZSB3b3VsZAo+ID4g
PiA+ID4+ID4gPiBhbHNvIGhhdmUgdG8gcmV2ZXJ0IHRoaXMgcGF0Y2guCj4gPiA+ID4gPj4gPiA+
Cj4gPiA+ID4gPj4gPiA+IEkgd2Fzbid0IHN1cmUgaWYgeW91IHdhbnRlZCB0byBxdWV1ZSB0aGUg
c2VyaWVzIGZvciB0aGlzIG1lcmdlIHdpbmRvdy4KPiA+ID4gPiA+PiA+ID4gSW4gdGhhdCBjYXNl
IGRvIHlvdSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gc2VuZCB0aGlzIHBhdGNoIG9ubHkgZm9yIHN0
YWJsZQo+ID4gPiA+ID4+ID4gPiBicmFuY2hlcz8KPiA+ID4gPiA+PiA+ID4gPiBEb2VzIHRoaXMg
cGF0Y2ggbWFrZSB0aGVtIGEgTk9QPwo+ID4gPiA+ID4+ID4gPgo+ID4gPiA+ID4+ID4gPiBZZXAs
IGFmdGVyIGFwcGx5aW5nIHRoZSAiYmV0dGVyIFBBQ0tFRCBzdXBwb3J0IiBzZXJpZXMgYW5kIGJl
aW5nCj4gPiA+ID4gPj4gPiA+IHN1cmUgdGhhdAo+ID4gPiA+ID4+ID4gPiB0aGUgSU9DVExzIG9m
IHZob3N0LXZkcGEgc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlLCB3ZSBzaG91bGQgcmV2ZXJ0IHRo
aXMKPiA+ID4gPiA+PiA+ID4gcGF0Y2guCj4gPiA+ID4gPj4gPiA+Cj4gPiA+ID4gPj4gPiA+IExl
dCBtZSBrbm93IGlmIHlvdSBwcmVmZXIgYSBkaWZmZXJlbnQgYXBwcm9hY2guCj4gPiA+ID4gPj4g
PiA+Cj4gPiA+ID4gPj4gPiA+IEknbSBjb25jZXJuZWQgdGhhdCBRRU1VIHVzZXMgdmhvc3QtdmRw
YSBJT0NUTHMgdGhpbmtpbmcgdGhhdCB0aGUga2VybmVsCj4gPiA+ID4gPj4gPiA+IGludGVycHJl
dHMgdGhlbSB0aGUgcmlnaHQgd2F5LCB3aGVuIGl0IGRvZXMgbm90Lgo+ID4gPiA+ID4+ID4gPgo+
ID4gPiA+ID4+ID4gPiBUaGFua3MsCj4gPiA+ID4gPj4gPiA+IFN0ZWZhbm8KPiA+ID4gPiA+PiA+
ID4KPiA+ID4gPiA+PiA+Cj4gPiA+ID4gPj4gPiBJZiB0aGlzIGZpeGVzIGEgYnVnIGNhbiB5b3Ug
YWRkIEZpeGVzIHRhZ3MgdG8gZWFjaCBvZiB0aGVtPyBUaGVuIGl0J3Mgb2sKPiA+ID4gPiA+PiA+
IHRvIG1lcmdlIGluIHRoaXMgd2luZG93LiBQcm9iYWJseSBlYXNpZXIgdGhhbiB0aGUgZWxhYm9y
YXRlCj4gPiA+ID4gPj4gPiBtYXNrL3VubWFzayBkYW5jZS4KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+
IENDaW5nIFNoYW5ub24gKHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhlICJiZXR0ZXIgUEFDS0VE
IHN1cHBvcnQiCj4gPiA+ID4gPj4gc2VyaWVzKS4KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+IElJVUMg
U2hhbm5vbiBpcyBnb2luZyB0byBzZW5kIGEgdjMgb2YgdGhhdCBzZXJpZXMgdG8gZml4IHRoZQo+
ID4gPiA+ID4+IGRvY3VtZW50YXRpb24sIHNvIFNoYW5ub24gY2FuIHlvdSBhbHNvIGFkZCB0aGUg
Rml4ZXMgdGFncz8KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+IFRoYW5rcywKPiA+ID4gPiA+PiBTdGVm
YW5vCj4gPiA+ID4gPgo+ID4gPiA+ID5XZWxsIHRoaXMgaXMgaW4gbXkgdHJlZSBhbHJlYWR5LiBK
dXN0IHJlcGx5IHdpdGgKPiA+ID4gPiA+Rml4ZXM6IDw+Cj4gPiA+ID4gPnRvIGVhY2ggYW5kIEkg
d2lsbCBhZGQgdGhlc2UgdGFncy4KPiA+ID4gPgo+ID4gPiA+IEkgdHJpZWQsIGJ1dCBpdCBpcyBu
b3QgZWFzeSBzaW5jZSB3ZSBhZGRlZCB0aGUgc3VwcG9ydCBmb3IgcGFja2VkCj4gPiA+ID4gdmly
dHF1ZXVlIGluIHZkcGEgYW5kIHZob3N0IGluY3JlbWVudGFsbHkuCj4gPiA+ID4KPiA+ID4gPiBJ
bml0aWFsbHkgSSB3YXMgdGhpbmtpbmcgb2YgYWRkaW5nIHRoZSBzYW1lIHRhZyB1c2VkIGhlcmU6
Cj4gPiA+ID4KPiA+ID4gPiBGaXhlczogNGM4Y2YzMTg4NWY2ICgidmhvc3Q6IGludHJvZHVjZSB2
RFBBLWJhc2VkIGJhY2tlbmQiKQo+ID4gPiA+Cj4gPiA+ID4gVGhlbiBJIGRpc2NvdmVyZWQgdGhh
dCB2cV9zdGF0ZSB3YXNuJ3QgdGhlcmUsIHNvIEkgd2FzIHRoaW5raW5nIG9mCj4gPiA+ID4KPiA+
ID4gPiBGaXhlczogNTMwYTU2NzhiYzAwICgidmRwYTogc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVl
IGZvciBzZXQvZ2V0X3ZxX3N0YXRlKCkiKQo+ID4gPiA+Cj4gPiA+ID4gU28gd2Ugd291bGQgaGF2
ZSB0byBiYWNrcG9ydCBxdWl0ZSBhIGZldyBwYXRjaGVzIGludG8gdGhlIHN0YWJsZSBicmFuY2hl
cy4KPiA+ID4gPiBJIGRvbid0IGtub3cgaWYgaXQncyB3b3J0aCBpdC4uLgo+ID4gPiA+Cj4gPiA+
ID4gSSBzdGlsbCB0aGluayBpdCBpcyBiZXR0ZXIgdG8gZGlzYWJsZSBwYWNrZWQgaW4gdGhlIHN0
YWJsZSBicmFuY2hlcywKPiA+ID4gPiBvdGhlcndpc2UgSSBoYXZlIHRvIG1ha2UgYSBsaXN0IG9m
IGFsbCB0aGUgcGF0Y2hlcyB3ZSBuZWVkLgo+ID4gPiA+Cj4gPiA+ID4gQW55IG90aGVyIGlkZWFz
Pwo+ID4gPgo+ID4gPiBBRkFJSywgZXhjZXB0IGZvciB2cF92ZHBhLCBwZHMgc2VlbXMgdG8gYmUg
dGhlIGZpcnN0IHBhcmVudCB0aGF0Cj4gPiA+IHN1cHBvcnRzIHBhY2tlZCB2aXJ0cXVldWUuIFVz
ZXJzIHNob3VsZCBub3Qgbm90aWNlIGFueXRoaW5nIHdyb25nIGlmCj4gPiA+IHRoZXkgZG9uJ3Qg
dXNlIHBhY2tlZCB2aXJ0cXVldWUuIEFuZCB0aGUgcHJvYmxlbSBvZiB2cF92ZHBhICsgcGFja2Vk
Cj4gPiA+IHZpcnRxdWV1ZSBjYW1lIHNpbmNlIHRoZSBkYXkwIG9mIHZwX3ZkcGEuIEl0IHNlZW1z
IGZpbmUgdG8gZG8gbm90aGluZwo+ID4gPiBJIGd1ZXNzLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+
Cj4gPgo+ID4gSSBoYXZlIGEgcXVlc3Rpb24gdGhvdWdoLCB3aGF0IGlmIGRvd24gdGhlIHJvYWQg
dGhlcmUKPiA+IGlzIGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNoYW5nZXM/IEl0IHdp
bGwgYmUKPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPiA+IFNob3VsZG4ndCB2
ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZlYXR1cmVzIGl0IGtub3dzIGhvdwo+ID4gdG8gc3Vw
cG9ydD8KPiAKPiBJdCBsb29rcyBsaWtlIHdlIGhhZCBpdCwgYnV0IHdlIHRvb2sgaXQgb3V0IChi
eSB0aGUgd2F5LCB3ZSB3ZXJlCj4gZW5hYmxpbmcgcGFja2VkIGV2ZW4gdGhvdWdoIHdlIGRpZG4n
dCBzdXBwb3J0IGl0KToKPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD02MjM0ZjgwNTc0ZDc1Njk0NDRk
ODcxODM1NWZhMjgzOGU5MmIxNThiCj4gCj4gVGhlIG9ubHkgcHJvYmxlbSBJIHNlZSBpcyB0aGF0
IGZvciBlYWNoIG5ldyBmZWF0dXJlIHdlIGhhdmUgdG8gbW9kaWZ5IAo+IHRoZSBrZXJuZWwuCj4g
Q291bGQgd2UgaGF2ZSBuZXcgZmVhdHVyZXMgdGhhdCBkb24ndCByZXF1aXJlIGhhbmRsaW5nIGJ5
IHZob3N0LXZkcGE/Cj4gCj4gVGhhbmtzLAo+IFN0ZWZhbm8KCkphc29uIHdoYXQgZG8geW91IHNh
eSB0byByZXZlcnRpbmcgdGhpcz8KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
