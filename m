Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C44BC6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E46C6104D;
	Fri, 17 Mar 2023 03:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E46C6104D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eAYrtcnt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_mPevG7jzKx; Fri, 17 Mar 2023 03:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A591F6105C;
	Fri, 17 Mar 2023 03:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A591F6105C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FDADC0035;
	Fri, 17 Mar 2023 03:38:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF1AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE05B8212D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE05B8212D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eAYrtcnt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3pa91JxX0a0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:38:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 328E48212C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 328E48212C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679024295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVsLqk+r1ZOPzZI3ydTPicHIm2HZPqwfTT7+IgUJZ8=;
 b=eAYrtcnt38QKj/b4shU9uCXn3Y8WtMtWOM4IQcM570dP7O/RQrpyc4mDFGa7vaGbP+l46r
 w6DrOYTiPs74E1NtnKq87IZZfcmacTHCNBz0aLivlXJbZ0nFROvCq56AwyMVeE8rhNJR3N
 uJdw5JGjf32/JXQgo778fIrlKwyQhYQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-Hz-IjZlROTSDWmQafL6reA-1; Thu, 16 Mar 2023 23:37:32 -0400
X-MC-Unique: Hz-IjZlROTSDWmQafL6reA-1
Received: by mail-ot1-f71.google.com with SMTP id
 y14-20020a056830208e00b006943ddbfb7eso1677408otq.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679024252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFVsLqk+r1ZOPzZI3ydTPicHIm2HZPqwfTT7+IgUJZ8=;
 b=XKb+fy8RYo/9Hz2VbhAB3wqwSt55kqdrQrm+CpqOIC0nY/+dCga7cPtdar2vfQt0NQ
 Axhzg4KcnAGzi6bYEsAJx6E5A7e4arkA98So/AkN122FckqwoWqWvUSDWgIPqzQU9v5H
 UPLNpW3n4WOrNEhwRBwC3JPvuO5KakEaveHL/kV+7BmE2KezscqaHKm3rm54vaP5nWo4
 cwSbm/AjBKdoL6bRfdpXNo6v+oLJqshvxYnQe2OmU4uvGBGAy2E8y68mF4TAHwd0yrQf
 X2iwIsY5esDRj8bcaqGFxsZWDfEgVYdsyrlkvk2/2OHXpN+bKdEVWOcHJodQ5GIQf6T8
 BdQw==
X-Gm-Message-State: AO0yUKUvlOvibmQL+gCb8TNMlQZx4yTHR6HHrFfSCKc7tUh2jrJ/ce2w
 LNQBgMiXFeh5NSBiZkSldkSArqpWp5v4GpZO/A6D9V1OcyDCXFSMSsORl0MLUEj+zImgpqHyFQk
 /XnFy19EsMATy6OV2rQqD4QttvLTR6XASOtEoVbxv+actCClEQZPBgLUcjQ==
X-Received: by 2002:a54:4481:0:b0:384:c4a:1b49 with SMTP id
 v1-20020a544481000000b003840c4a1b49mr2529108oiv.9.1679024251927; 
 Thu, 16 Mar 2023 20:37:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set/gDvTy3qEnd0t9C0+ygLrhOCbBGSbZavev4c65WFF89C8eZYwKpwwVJnu0eV7eOlDLHKc/783vwv9c3TKTqDg=
X-Received: by 2002:a54:4481:0:b0:384:c4a:1b49 with SMTP id
 v1-20020a544481000000b003840c4a1b49mr2529105oiv.9.1679024251767; Thu, 16 Mar
 2023 20:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230309013046.23523-1-shannon.nelson@amd.com>
 <20230309013046.23523-4-shannon.nelson@amd.com>
 <CACGkMEt5Jbsp=+st8aG_0kXD+OSSp+FX9vYE+gTkywp2ZN4LTw@mail.gmail.com>
 <ee3dd0c5-5e44-634d-7ab7-7a4c9c1cd4f7@amd.com>
In-Reply-To: <ee3dd0c5-5e44-634d-7ab7-7a4c9c1cd4f7@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:37:20 +0800
Message-ID: <CACGkMEsK0YknKS8CWkToJSo3_jY837zyQsaFjOE8h7jOdWMASQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 virtio 3/7] pds_vdpa: virtio bar setup for vdpa
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMTE6MjXigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAzLzE1LzIzIDEyOjA1IEFNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVGh1LCBNYXIgOSwgMjAyMyBhdCA5OjMx4oCvQU0gU2hhbm5vbiBO
ZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gVGhlIFBEUyB2
RFBBIGRldmljZSBoYXMgYSB2aXJ0aW8gQkFSIGZvciBkZXNjcmliaW5nIGl0c2VsZiwgYW5kCj4g
Pj4gdGhlIHBkc192ZHBhIGRyaXZlciBuZWVkcyB0byBhY2Nlc3MgaXQuICBIZXJlIHdlIGNvcHkg
bGliZXJhbGx5Cj4gPj4gZnJvbSB0aGUgZXhpc3RpbmcgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2LmMgYXMgaXQKPiA+PiBoYXMgd2hhdCB3ZSBuZWVkLCBidXQgd2UgbmVlZCB0
byBtb2RpZnkgaXQgc28gdGhhdCBpdCBjYW4gd29yawo+ID4+IHdpdGggb3VyIGRldmljZSBpZCBh
bmQgc28gd2UgY2FuIHVzZSBvdXIgb3duIERNQSBtYXNrLgo+ID4KPiA+IEJ5IHBhc3NpbmcgYSBw
b2ludGVyIHRvIGEgY3VzdG9taXplZCBpZCBwcm9iaW5nIHJvdXRpbmUgdG8gdnBfbW9kZXJuX3By
b2JlKCk/Cj4KPiBUaGUgb25seSByZWFsIGRpZmZlcmVuY2VzIGFyZSB0aGF0IHdlIG5lZWRlZCB0
byBjdXQgb3V0IHRoZSBkZXZpY2UgaWQKPiBjaGVja3MgdG8gdXNlIG91ciB2RFBBIFZGIGRldmlj
ZSBpZCwgYW5kIHJlbW92ZQo+IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoKSBiZWNhdXNlIHdl
IG5lZWQgYSBkaWZmZXJlbnQgRE1BX0JJVF9NQVNLKCkuCj4KPiBNYXliZSBhIGZ1bmN0aW9uIHBv
aW50ZXIgdG8gc29tZXRoaW5nIHRoYXQgY2FuIHZhbGlkYXRlIHRoZSBkZXZpY2UgaWQsCj4gYW5k
IGEgYml0bWFzayBmb3Igc2V0dGluZyBETUEgbWFwcGluZzsgaWYgdGhleSBhcmUgMC9OVUxMLCB1
c2UgdGhlCj4gZGVmYXVsdCBkZXZpY2UgaWQgY2hlY2sgYW5kIERNQSBtYXNrLgo+Cj4gQWRkaW5n
IHRoZW0gYXMgZXh0cmEgYXJndW1lbnRzIHRvIHRoZSBmdW5jdGlvbiBjYWxsIHNlZW1zIGEgYml0
IG1lc3N5LAo+IG1heWJlIGFkZCB0aGVtIHRvIHRoZSBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5f
ZGV2aWNlIGFuZCB0aGUgY2FsbGVyIGNhbgo+IHNldCB0aGVtIGFzIG92ZXJyaWRlcyBpZiBuZWVk
ZWQ/Cj4KPiBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIHsKPgo+ICAgICAgICAgLi4u
Cj4KPiAgICAgICAgIGludCAoKmRldmljZV9pZF9jaGVja19vdmVycmlkZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikpOwo+ICAgICAgICAgdTY0IGRtYV9tYXNrX292ZXJyaWRlOwo+IH0KCkxvb2tzIGZp
bmUuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
