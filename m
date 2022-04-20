Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82000C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 11:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC5983089;
	Wed, 20 Apr 2022 11:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmp95cxXcNVX; Wed, 20 Apr 2022 11:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF286840FA;
	Wed, 20 Apr 2022 11:11:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 947A7C002F;
	Wed, 20 Apr 2022 11:11:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A629C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 11:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 577F484109
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 11:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aEL4gVAG8cX3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 11:10:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 743D683089
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650453058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsnnPIAMkwFjtCukDLHEtbujjWuw4if1rc8O7lEr2po=;
 b=dOcRroY2RZ+pn30fpL5rSL8VqQ5WUBoX+gDFny4eUeZLn5GWB8vIcDUxZ1GCQQX0AL/f5f
 e3eFQDxX612xaeWDvyVAAY7KMoFexlisp7zfLIpbulpTEQAMRBAeiCYfX1PFU5g1UXyQUT
 /l7xAB+A6APCcqNBdn/Yqqw+ztmQ2E4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-0HmVBtO2NJmVAHalX_LP2Q-1; Wed, 20 Apr 2022 07:10:55 -0400
X-MC-Unique: 0HmVBtO2NJmVAHalX_LP2Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 p18-20020adf9592000000b00207bc12decbso297022wrp.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 04:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=YsnnPIAMkwFjtCukDLHEtbujjWuw4if1rc8O7lEr2po=;
 b=YytezVYX6VQzWBZxJUnn9Utug9typ0/x3nB363BE4Mc/sYtR1RcxgLEwg6yYXQnC7w
 BoqfUS2iE1afUhHyxlhO6SBcfZfkgjGFYPtid0qu88z1HryY6Nyb5AGiPBWKPszYe32U
 azaNZh0s6zDa0L71QGyMlCUYIJYYXfhEBASgALhbGvk5oX7OFIoAF6lBXpM5fKRGSzzl
 ILYP7lIjbgji48zW+bw82JrBsHNFw1knWTchhVe+8z3opNUT3UKRbVVBb3kQyKeQMETG
 jeWjyhFUXFZaZprs2jJBKpNg5YVjI8S7RGKyIs6cgGxfMkT8pHeWWC5hEyPUPnC8uRak
 CFJw==
X-Gm-Message-State: AOAM5325jMa4SxSh5sVqsWMQl73DoiL9UmkV3a8N6k7Wq1+5GBSudvit
 lWLfa2TNPb655gg/IMdwDV9beETarEo4wka/51qPeuRCmD6SWMyCb4KlbBqdVn6qxp36HrMtfjZ
 rocVx4X65ieToEaAJUG09r62J1CFUSBwIqSWzI1WJVA==
X-Received: by 2002:a5d:4d83:0:b0:207:b5fb:ecae with SMTP id
 b3-20020a5d4d83000000b00207b5fbecaemr15031444wru.625.1650453053816; 
 Wed, 20 Apr 2022 04:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJbffe+a5JlsW6ZJQS34oageQLYR9yEEgZed/GH7nghNNHUURALq8Q2KE+JOVRYBbvaiQ0vQ==
X-Received: by 2002:a5d:4d83:0:b0:207:b5fb:ecae with SMTP id
 b3-20020a5d4d83000000b00207b5fbecaemr15031428wru.625.1650453053556; 
 Wed, 20 Apr 2022 04:10:53 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 o40-20020a05600c512800b0038ebf2858cbsm24062454wms.16.2022.04.20.04.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 04:10:52 -0700 (PDT)
Date: Wed, 20 Apr 2022 07:10:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maciej =?utf-8?Q?Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
Message-ID: <20220420070944-mutt-send-email-mst@kernel.org>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
 <20220420023511-mutt-send-email-mst@kernel.org>
 <4080d799-b42e-018a-8b14-621295e55a8d@opensynergy.com>
 <b4899534-8c08-ddfc-dea0-460a94b00c32@redhat.com>
 <0a118236-bb98-9183-8be2-84f6b83e2581@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <0a118236-bb98-9183-8be2-84f6b83e2581@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMTA6MTc6MjdBTSArMDIwMCwgTWFjaWVqIFN6eW1hxYRz
a2kgd3JvdGU6Cj4gPiA+ID4gPiA+IEhtbSBzbyB3ZSBoYXZlIHRoaXM6Cj4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gICAgICAgICAgaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVh
dHVyZXMpICYgTkVUSUZfRl9HUk9fSFcpIHsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBp
ZiAodmktPnhkcF9lbmFibGVkKQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FQlVTWTsKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
aWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBvZmZsb2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgIGVsc2UKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgo+ID4gPiA+ID4g
PiB+R1VFU1RfT0ZGTE9BRF9HUk9fSFdfTUFTSzsKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHModmksIG9mZmxv
YWRzKTsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBpZiAoZXJyKQo+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICB2aS0+Z3Vlc3Rfb2ZmbG9hZHMgPSBvZmZsb2FkczsKPiA+ID4gPiA+ID4gICAgICAg
ICAgfQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gd2hpY2ggSSBndWVzcyBzaG91bGQgaGF2ZSBw
cmV2ZW50ZWQgdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMKPiA+ID4gPiA+ID4gZnJvbSBldmVy
IHJ1bm5pbmcuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAgRnJvbSB5b3VyIGRlc2NyaXB0aW9u
IGl0IHNvdW5kcyBsaWtlIHlvdSBoYXZlIG9ic2VydmVkIHRoaXMKPiA+ID4gPiA+ID4gaW4gcHJh
Y3RpY2UsIHJpZ2h0Pwo+ID4gPiA+ID4gPiAKPiA+ID4gWWVzLiBJIGhhdmUgcHJvcHJpZXRhcnkg
dmlydGlvLW5ldCBkZXZpY2Ugd2hpY2ggYWR2ZXJ0aXNlcyBmb2xsb3dpbmcKPiA+ID4gZ3Vlc3Qg
b2ZmbG9hZCBmZWF0dXJlcyA6Cj4gPiA+IC0gVklSVElPX05FVF9GX0dVRVNUX0NTVU0KPiA+ID4g
LSBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNAo+ID4gPiAtIFZJUlRJT19ORVRfRl9HVUVTVF9UU082
Cj4gPiA+IC0gVklSVElPX05FVF9GX0dVRVNUX1VGTwo+ID4gPiAKPiA+ID4gVGhpcyBmZWF0dXJl
IHNldCBwYXNzZXMgdGhlIGNvbmRpdGlvbiBpbiB2aXJ0bmV0X3NldF9mZWF0dXJlcy4KClNvIHdo
eSBpc24ndCBkZXYtPmZlYXR1cmVzIGVxdWFsIHRvIGZlYXR1cmVzPwoKLS0gCk1TVAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
