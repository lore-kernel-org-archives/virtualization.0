Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC98C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 17:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A246060B44;
	Mon, 21 Feb 2022 17:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CEoj7dh_ZB6g; Mon, 21 Feb 2022 17:02:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 372CF60D6E;
	Mon, 21 Feb 2022 17:02:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE2C1C0021;
	Mon, 21 Feb 2022 17:02:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6930C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 17:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A87B9408F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 17:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PaSlyS5Q6BJh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 17:02:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C26E2408EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645462944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8jYdftJnmb0zvI4rCaqGXuSppwKQhG6hl6AuRmMuaU=;
 b=M0dA2xZlg+1N8TEEWEv67o8cfmK0GAnQOiKTvMwDCIKuehfg8TXCmsYstoxYHZnqmo6IDi
 MdkPBfXxI2+Hv0Qqk8fw+59NjMBcgDAnSNWxmtmfLZ+FcRC+3BUwt1lDEZTbVIJ7hj1FqH
 pnv0LKCZ/+LFfkhqaa1vaLibkGTN368=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-H9dWKE4TNKS39vmA0Fexww-1; Mon, 21 Feb 2022 12:02:23 -0500
X-MC-Unique: H9dWKE4TNKS39vmA0Fexww-1
Received: by mail-qv1-f71.google.com with SMTP id
 jv14-20020a05621429ee00b004300c413db6so17796347qvb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 09:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a8jYdftJnmb0zvI4rCaqGXuSppwKQhG6hl6AuRmMuaU=;
 b=MCCBL1QRxc37n3gmVCgnFrqlmbBsYWtgzJY+zUh/FrPW7E+qr+2eVJaucbno3LVt2h
 qzxZcku3OkEPZT21bQqSQyT41TGci+TWDgCUrbgW2uxhtHzi8w6eYyv9Tf95FBharBqX
 JYYDF+ORjIKWTNFko6YWpYcVzRjsohsBXcLnJfnOi1QrIZjCrdPBbvvLTVJQei35eGTI
 hobHRPVk8G+U6sbkiLR8WyGWo22AF6HTfkrbjC6Ppo8AHtvBK7OsiN+Pc5tungqmiDC7
 sFtQsaeqI4ndMyxFGeRCsozTUfbrcel5aRdndeo/q4SGCSBz2Ew4jmp+4m9k4S2tUsWV
 09FQ==
X-Gm-Message-State: AOAM532qWWz0hwYKixre9eIH6Z/NRWNRj/cka4w0qOlcxZrMKE2JV95+
 /F/KrctQgTCjou4S1YJlznMYbexP5F0pFF2kbSGwFP1oVuvVlXbGSFwPiFabSb2PCmAgKiMNppa
 IQs+RdRbnz/McW1MxCJOfS6qTLZ2vmJbxxOzJC4uRWw==
X-Received: by 2002:ac8:5950:0:b0:2dc:a139:4f36 with SMTP id
 16-20020ac85950000000b002dca1394f36mr19235717qtz.646.1645462942697; 
 Mon, 21 Feb 2022 09:02:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4IW2ywlrbCp6vvy6jwSlIcSAdtGODJ9+dki3CIZxUMw8weOa4wJ8ZcCtuLx9JhEkSLSVVWA==
X-Received: by 2002:ac8:5950:0:b0:2dc:a139:4f36 with SMTP id
 16-20020ac85950000000b002dca1394f36mr19235682qtz.646.1645462942435; 
 Mon, 21 Feb 2022 09:02:22 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id bk19sm26406528qkb.125.2022.02.21.09.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 09:02:21 -0800 (PST)
Date: Mon, 21 Feb 2022 18:02:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
MIME-Version: 1.0
In-Reply-To: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 21, 2022 at 04:15:22PM +0000, David Woodhouse wrote:
>As things stand, an application which wants to use vhost with a trivial
>1:1 mapping of its virtual address space is forced to jump through hoops
>to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
>helpfully doesn't fail immediately; you only get a failure *later* when
>you attempt to set the backend, if the table *could* map to an address
>which is out of range, even if no out-of-range address is actually
>being referenced.
>
>Since userspace is growing workarounds for this lovely kernel API, let's
>ensure that we have a regression test that does things basically the same
>way as https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
>does.
>
>This is untested as I can't actually get virtio_test to work at all; it
>just seems to deadlock on a spinlock. But it's getting the right answer
>for the virtio range on x86_64 at least.

I had a similar issue with virtio_test and this simple patch [1] should 
fix the deadlock.

[1] 
https://lore.kernel.org/lkml/20220118150631.167015-1-sgarzare@redhat.com/

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
