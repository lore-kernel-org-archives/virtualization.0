Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4E2C4332F
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 06:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83B1460591;
	Wed, 28 Dec 2022 06:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83B1460591
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MST+jMxm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MbgIegsCkL-m; Wed, 28 Dec 2022 06:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24DDF60592;
	Wed, 28 Dec 2022 06:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24DDF60592
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E924DC0032;
	Wed, 28 Dec 2022 06:34:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84047C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6467760592
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6467760592
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rvpLBPtwsKRr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:34:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74D7260591
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74D7260591
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672209268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKQnx3lqI8J/ywBQvDRlys+9FKkDR0+iinXdJ3yuVUY=;
 b=MST+jMxmAbTPXxkmxmTNUklqACHsml94KWyypx2iAB1BruRWIJR26ohq/t85R6E70OhDJl
 MJ+89FJa0lrHSSh7rJ8QkrAMpsgMN/Zt8EMoQ0vRLXMHVrM4bVwYtngAVFnl87IgwrdR99
 RLxGTGmtJqNs+Za3NVquI4wOd4EQGBs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-toWSUaHNPCOBktIpTU3MRg-1; Wed, 28 Dec 2022 01:34:26 -0500
X-MC-Unique: toWSUaHNPCOBktIpTU3MRg-1
Received: by mail-pg1-f198.google.com with SMTP id
 s76-20020a632c4f000000b0049ceb0f185eso441266pgs.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 22:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BKQnx3lqI8J/ywBQvDRlys+9FKkDR0+iinXdJ3yuVUY=;
 b=Gi5ku7y+AtO1ey9GaKqbKmEGwS3emFVPjcPzctmuVdK5Bd6+Euzclq/3zDrzKCT6EJ
 h0qQTThBFQXotiArdtkzDVWxwhACxVholhX531j4WN4HH2ds6ExEqvFhsIO8ryuhjdx4
 SoNO8+UgSo30kNijXT45O8g5XJCJ5zjn+IL0HB0iL0MHXJTPG4gexNpcbrr4yFvQc2Tl
 3UCOekT7o12YsE5pQHvt+W8Ve6ftMWBfNGlYRNLt+sH96dtLpckY7FCFL6JbzZnqAlDq
 1A+mTkO3LPrmdr4CY5uOm04Q8zT+kR0sqAQloOYR1kt3T6tVoXrJYzb2D/rVnHUkG9DO
 +pVA==
X-Gm-Message-State: AFqh2kp6DWRwUFXrhAwvZgsC7eXCBjDS2ujQGj+ev4K/aRpvsv6kE7HI
 kFkJC8X6usOSRVmoOwXY/FA+QG1Ye0CZ3/GxnE+jHb5gBO9OQeWW+9pHkwkdMaF/Wuu+yycNBml
 mCyXUDuLhe6NUWT6rmdlDFCeb4423/Sei88inseOtWQ==
X-Received: by 2002:a17:903:228a:b0:191:217f:b2ea with SMTP id
 b10-20020a170903228a00b00191217fb2eamr37690883plh.40.1672209265629; 
 Tue, 27 Dec 2022 22:34:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXud3fpQFNYTs/QJAXg2Ef0tfxpHJccTR+K7iu3P9xFUBgkpDkbiPqbWq2R61zV9fAgaEZqMNg==
X-Received: by 2002:a17:903:228a:b0:191:217f:b2ea with SMTP id
 b10-20020a170903228a00b00191217fb2eamr37690862plh.40.1672209265370; 
 Tue, 27 Dec 2022 22:34:25 -0800 (PST)
Received: from [10.72.13.7] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b00188a7bce192sm10157311plg.264.2022.12.27.22.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 22:34:25 -0800 (PST)
Message-ID: <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
Date: Wed, 28 Dec 2022 14:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227043148-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzI3IDE3OjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDI3LCAyMDIyIGF0IDA1OjEyOjU4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IOWcqCAyMDIyLzEyLzI3IDE1OjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+Pj4gT24g
VHVlLCBEZWMgMjcsIDIwMjIgYXQgMTI6MzA6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+Pj4gQnV0IGRldmljZSBpcyBzdGlsbCBnb2luZyBhbmQgd2lsbCBsYXRlciB1c2UgdGhlIGJ1
ZmZlcnMuCj4+Pj4+Cj4+Pj4+IFNhbWUgZm9yIHRpbWVvdXQgcmVhbGx5Lgo+Pj4+IEF2b2lkaW5n
IGluZmluaXRlIHdhaXQvcG9sbCBpcyBvbmUgb2YgdGhlIGdvYWxzLCBhbm90aGVyIGlzIHRvIHNs
ZWVwLgo+Pj4+IElmIHdlIHRoaW5rIHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBm
cm9tIHRoZSB3YWl0Lgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+PiBJZiB0aGUgZ29hbCBpcyB0byBhdm9p
ZCBkaXNydXB0aW5nIHRyYWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPj4+IHRoYXQgc291bmRz
IG1vcmUgcmVhc29uYWJsZS4gRS5nLiBzb21lb25lIGlzIHR1cm5pbmcgb24gcHJvbWlzYywKPj4+
IGEgc3Bpa2UgaW4gQ1BVIHVzYWdlIG1pZ2h0IGJlIHVud2VsY29tZS4KPj4KPj4gWWVzLCB0aGlz
IHdvdWxkIGJlIG1vcmUgb2J2aW91cyBpcyBVUCBpcyB1c2VkLgo+Pgo+Pgo+Pj4gdGhpbmdzIHdl
IHNob3VsZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3MgdGhlbjoKPj4+IDEtIGRlYnVnZ2luZy4gQ3Vy
cmVudGx5IGl0J3MgZWFzeSB0byBzZWUgYSB3YXJuaW5nIGlmIENQVSBpcyBzdHVjawo+Pj4gICAg
ICBpbiBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4KPj4+
ICAgICAgRS5nLiB3aXRoIHRoaXMgLSBob3cgZG8gd2Uga25vdyB3aG8gaGFzIHRoZSBSVE5MPwo+
Pj4gICAgICBXZSBuZWVkIHRvIGludGVncmF0ZSB3aXRoIGtlcm5lbC93YXRjaGRvZy5jIGZvciBn
b29kIHJlc3VsdHMKPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMgY29uc2lzdGVu
dC4KPj4KPj4gVGhhdCdzIGZpbmUsIHdpbGwgY29uc2lkZXIgdGhpcy4KPj4KPj4KPj4+IDItIG92
ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlvIHdoZW4gZGV2aWNlIGlzIGluIGh5cGVy
dmlzb3IsCj4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEgdmVyeSBoaWdoIG92
ZXJoZWFkLCBhdCBib290dXAKPj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1biBh
bmQgc2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4+PiAgICAgIGxldCdzIHBvbGwgZm9y
IGEgYml0IGJlZm9yZSB3YWl0aW5nPwo+Pgo+PiBUaGVuIHdlIGdvIGJhY2sgdG8gdGhlIHF1ZXN0
aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0IGZvciBwb2xsLiBBbmQKPj4gcG9sbCBzZWVt
cyBwcm9ibGVtYXRpYyBpbiB0aGUgY2FzZSBvZiBVUCwgc2NoZWR1bGVyIG1pZ2h0IG5vdCBoYXZl
IHRoZQo+PiBjaGFuY2UgdG8gcnVuLgo+IFBvbGwganVzdCBhIGJpdCA6KSBTZXJpb3VzbHkgSSBk
b24ndCBrbm93LCBidXQgYXQgbGVhc3QgY2hlY2sgb25jZQo+IGFmdGVyIGtpY2suCgoKSSB0aGlu
ayBpdCBpcyB3aGF0IHRoZSBjdXJyZW50IGNvZGUgZGlkIHdoZXJlIHRoZSBjb25kaXRpb24gd2ls
bCBiZSAKY2hlY2sgYmVmb3JlIHRyeWluZyB0byBzbGVlcCBpbiB0aGUgd2FpdF9ldmVudCgpLgoK
Cj4KPj4+IDMtIHN1cHJpc2UgcmVtb3ZhbC4gbmVlZCB0byB3YWtlIHVwIHRocmVhZCBpbiBzb21l
IHdheS4gd2hhdCBhYm91dAo+Pj4gICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWthZ2Ug
LSBpcyB0aGVyZSBhIGNoYW5jZSB0aGlzCj4+PiAgICAgIGludHJvZHVjZXMgbmV3IGJ1Z3MgYXJv
dW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KPj4KPj4gVGhlIGN1cnJl
bnQgY29kZSBkaWQ6Cj4+Cj4+IDEpIGNoZWNrIGZvciB2cS0+YnJva2VuCj4+IDIpIHdha2V1cCBk
dXJpbmcgQkFEX1JJTkcoKQo+Pgo+PiBTbyB3ZSB3b24ndCBlbmQgdXAgd2l0aCBhIG5ldmVyIHdv
a2UgdXAgcHJvY2VzcyB3aGljaCBzaG91bGQgYmUgZmluZS4KPj4KPj4gVGhhbmtzCj4KPiBCVFcg
QkFEX1JJTkcgb24gcmVtb3ZhbCB3aWxsIHRyaWdnZXIgZGV2X2Vyci4gTm90IHN1cmUgdGhhdCBp
cyBhIGdvb2QKPiBpZGVhIC0gY2FuIGNhdXNlIGNyYXNoZXMgaWYga2VybmVsIHBhbmljcyBvbiBl
cnJvci4KCgpZZXMsIGl0J3MgYmV0dGVyIHRvIHVzZSBfX3ZpcnRxdWV1ZV9icmVhaygpIGluc3Rl
YWQuCgpCdXQgY29uc2lkZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEgd2FpdCBmaXJzdCwgSSB3aWxs
IGxpbWl0IHRoZSBjaGFuZ2VzIAppbiB2aXJ0aW8tbmV0IHdpdGhvdXQgYm90aGVyaW5nIHZpcnRp
byBjb3JlLgoKVGhhbmtzCgoKPgo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
