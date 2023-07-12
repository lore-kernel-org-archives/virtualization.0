Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C5EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A473E405D9;
	Wed, 12 Jul 2023 14:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A473E405D9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqTxQUYA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuwluDS8xswY; Wed, 12 Jul 2023 14:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E7AC40165;
	Wed, 12 Jul 2023 14:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E7AC40165
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB611C0072;
	Wed, 12 Jul 2023 14:21:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B186BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98B70403BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98B70403BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zayxSvv8OVMw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:21:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93E0640165
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93E0640165
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689171672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EczEn/QZT0UNDQndUq23zxvPioEXkz8LDWAC9w3gIag=;
 b=AqTxQUYAnRmmV7Op/Vf3SUK7kLnkfGynwWaDsuPWZuteoPzVsatulb/UfcjVVnTD7pRMnf
 XSbVwam7atR+qjzdRlKqp+4To0m6GRkM1xHnKtbF6mOlHnLFK2bCH39z9H2d3hzAxPJ1bm
 XA0IegqOH8RQP0bPE2TZTbxkKAn33SA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-qUVlAWYmPue9-_QS_ODtfg-1; Wed, 12 Jul 2023 10:21:10 -0400
X-MC-Unique: qUVlAWYmPue9-_QS_ODtfg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5766e49b802so68744277b3.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689171670; x=1691763670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EczEn/QZT0UNDQndUq23zxvPioEXkz8LDWAC9w3gIag=;
 b=HggGDCRL2NsAv/g6VfIhgAPWYNy6t5ePKySR1x5DU8HjB0HUVLUJYtXuB9ZZVmaAj9
 MJyRFoNZQPddiDndBOtZp4Y8eM0mp3qPmGVSC55NG1I22snNGmBVP5mbmJIssxP579cO
 VXMkaKzYTWayrbAI5fikJwKUfpaiRCWPVaSSaFIXlWZNEnvNju4sdTt8bX7OuzEJAtIr
 ACmj4QRg5dNYq7G9xZmKbdaD3czRArDlIgQDeg2uso7qVRUjNCS9JZPpnKV5uOVTLX9g
 rM7rjFtqGY0HiLISNZFSenZTyziWduB93bB1iplKeVXtvhUfImpilRbCH/eZHk4OgQ50
 LVmA==
X-Gm-Message-State: ABy/qLZ9kChs0wTDIm/9kGQvA0wqsuo8SEQiBPnTN9oO3hoAnV3ulZc4
 TMaj8rkN/7RCGP3jgpULP8GEoRZioYaMAVGQiU22U8mQSzXvh53eXmvq/BSMkgf9mAuQorKlE+H
 gwPISJnkQGF2pK2titxPQRnDluO8egePtvYSxmalu6lSfQgDUbh0BrGnUEg==
X-Received: by 2002:a81:688a:0:b0:576:8a5a:87e5 with SMTP id
 d132-20020a81688a000000b005768a5a87e5mr18516327ywc.26.1689171669949; 
 Wed, 12 Jul 2023 07:21:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/D8pzREiR+H7EZ6lhBKgSiC/r5Yy94lIHpQ+bs5TgxVtyzTF/cpY5WTpaJXgp4dTzmrgLF7qtCXzz23NYTk8=
X-Received: by 2002:a81:688a:0:b0:576:8a5a:87e5 with SMTP id
 d132-20020a81688a000000b005768a5a87e5mr18516308ywc.26.1689171669712; Wed, 12
 Jul 2023 07:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
 <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
 <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
In-Reply-To: <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 12 Jul 2023 16:20:56 +0200
Message-ID: <CAGxU2F4o4cr6jaHypLs_5ma8ZuNQmx4KQVMjs4GrSYd-nnLcUw@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Paolo Bonzini <pbonzini@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBKdWwgMTIsIDIwMjMgYXQgMTI6MTTigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBKdWwgMTIsIDIwMjMgYXQgMTA6
MDY6NTZBTSArMDIwMCwgUGFvbG8gQm9uemluaSB3cm90ZToKPiA+T24gNy8xMS8yMyAyMjoyMSwg
TWlrZSBDaHJpc3RpZSB3cm90ZToKPiA+PldoYXQgd2FzIHRoZSBpc3N1ZSB5b3UgYXJlIHNlZWlu
Zz8KPiA+Pgo+ID4+V2FzIGl0IHNvbWV0aGluZyBsaWtlIHlvdSBnZXQgdGhlIFVBLiBXZSByZXRy
eSB0aGVuIG9uIG9uZSBvZiB0aGUKPiA+PnJldHJpZXMgdGhlIHNlbnNlIGlzIG5vdCBzZXR1cCBj
b3JyZWN0bHksIHNvIHRoZSBzY3NpIGVycm9yIGhhbmRsZXIKPiA+PnJ1bnM/IFRoYXQgZmFpbHMg
YW5kIHRoZSBkZXZpY2UgZ29lcyBvZmZsaW5lPwo+ID4+Cj4gPj5JZiB5b3UgdHVybiBvbiBzY3Np
IGRlYnVnZ2luZyB5b3Ugd291bGQgc2VlOgo+ID4+Cj4gPj4KPiA+PlsgIDMzNS40NDU5MjJdIHNk
IDA6MDowOjA6IFtzZGFdIHRhZyMxNSBBZGQuIFNlbnNlOiBSZXBvcnRlZCBsdW5zIGRhdGEgaGFz
IGNoYW5nZWQKPiA+PlsgIDMzNS40NDU5MjJdIHNkIDA6MDowOjA6IFtzZGFdIHRhZyMxNiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo+ID4+WyAgMzM1LjQ0
NTkyNV0gc2QgMDowOjA6MDogW3NkYV0gdGFnIzE2IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwCj4gPj5bICAzMzUuNDQ1OTI5XSBzZCAwOjA6MDowOiBbc2Rh
XSB0YWcjMTcgRG9uZTogRkFJTEVEIFJlc3VsdDogaG9zdGJ5dGU9RElEX09LIGRyaXZlcmJ5dGU9
RFJJVkVSX09LIGNtZF9hZ2U9MHMKPiA+PlsgIDMzNS40NDU5MzJdIHNkIDA6MDowOjA6IFtzZGFd
IHRhZyMxNyBDREI6IFdyaXRlKDEwKSAyYSAwMCAwMCBkYiA0ZiBjMCAwMCAwMCAyMCAwMAo+ID4+
WyAgMzM1LjQ0NTkzNF0gc2QgMDowOjA6MDogW3NkYV0gdGFnIzE3IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCj4gPj5bICAzMzUuNDQ1OTM2XSBzZCAwOjA6
MDowOiBbc2RhXSB0YWcjMTcgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAKPiA+PlsgIDMzNS40NDU5MzhdIHNkIDA6MDowOjA6IFtzZGFdIHRhZyMxNyAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo+ID4+WyAgMzM1LjQ0
NTk0MF0gc2QgMDowOjA6MDogW3NkYV0gdGFnIzE3IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwCj4gPj5bICAzMzUuNDQ1OTQyXSBzZCAwOjA6MDowOiBbc2Rh
XSB0YWcjMTcgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAK
PiA+PlsgIDMzNS40NDU5NDVdIHNkIDA6MDowOjA6IFtzZGFdIHRhZyMxNyAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo+ID4+WyAgMzM1LjQ1MTQ0N10gc2Nz
aSBob3N0MDogc2NzaV9laF8wOiB3YWtpbmcgdXAgMC8yLzIKPiA+PlsgIDMzNS40NTE0NTNdIHNj
c2kgaG9zdDA6IFRvdGFsIG9mIDIgY29tbWFuZHMgb24gMSBkZXZpY2VzIHJlcXVpcmUgZWggd29y
awo+ID4+WyAgMzM1LjQ1MTQ1N10gc2QgMDowOjA6MDogW3NkYV0gdGFnIzE2IHNjc2lfZWhfMDog
cmVxdWVzdGluZyBzZW5zZQo+ID4KPiA+RG9lcyB0aGlzIGxvZyBjb21lIGZyb20gaW50ZXJuYWwg
ZGlzY3Vzc2lvbnMgd2l0aGluIE9yYWNsZT8KPiA+Cj4gPj5JIGRvbid0IGtub3cgdGhlIHFlbXUg
c2NzaSBjb2RlIHdlbGwsIGJ1dCBJIHNjYW5uZWQgdGhlIGNvZGUgZm9yIG15IGNvLXdvcmtlcgo+
ID4+YW5kIG15IGd1ZXNzIHdhcyBjb21taXQgOGNjNTU4M2FiZTY0MTllN2ZhYWViYzlmYmQxMDlm
MzRmNGM4NTBmMiBoYWQgYSByYWNlIGluIGl0Lgo+ID4+Cj4gPj5Ib3cgaXMgbG9ja2luZyBkb25l
PyB3aGVuIGl0IGlzIGEgYnVzIGxldmVsIFVBIGJ1dCB0aGVyZSBhcmUgbXVsdGlwbGUgZGV2aWNl
cwo+ID4+b24gdGhlIGJ1cz8KPiA+Cj4gPk5vIGxvY2tpbmcgc2hvdWxkIGJlIG5lY2Vzc2FyeSwg
dGhlIGNvZGUgaXMgc2luZ2xlIHRocmVhZGVkLiAgSG93ZXZlciwKPiA+d2hhdCBjYW4gaGFwcGVu
IGlzIHRoYXQgdHdvIGNvbnNlY3V0aXZlIGNhbGxzIHRvCj4gPnZpcnRpb19zY3NpX2hhbmRsZV9j
bWRfcmVxX3ByZXBhcmUgdXNlIHRoZSB1bml0IGF0dGVudGlvbiBSZXFPcHMsIGFuZAo+ID50aGVu
IHRoZSBzZWNvbmQgdmlydGlvX3Njc2lfaGFuZGxlX2NtZF9yZXFfc3VibWl0IGZpbmRzIG5vIHVu
aXQKPiA+YXR0ZW50aW9uIChzZWUgdGhlIGxvb3AgaW4gdmlydGlvX3Njc2lfaGFuZGxlX2NtZF92
cSkuICBUaGF0IGNhbgo+ID5kZWZpbml0ZWx5IGV4cGxhaW4gdGhlIGxvZyBhYm92ZS4KPgo+IFll
cywgdGhpcyBzZWVtcyB0byBiZSB0aGUgY2FzZSEKPiBUaGFuayB5b3UgYm90aCBmb3IgdGhlIGhl
bHAhCj4KPiBGb2xsb3dpbmcgUGFvbG8ncyBhZHZpY2UsIEknbSBwcmVwYXJpbmcgYSBzZXJpZXMg
Zm9yIFFFTVUgdG8gc29sdmUgdGhlCj4gcHJvYmxlbSEKClNlcmllcyBwb3N0ZWQgaGVyZToKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDcxMjEzNDM1Mi4xMTg2NTUtMS1z
Z2FyemFyZUByZWRoYXQuY29tLwoKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
