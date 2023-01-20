Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A319C25B4E
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 12:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC11E40CA2;
	Fri, 20 Jan 2023 12:40:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC11E40CA2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XO9vGQVR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zq4bXz9g7u8Q; Fri, 20 Jan 2023 12:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42587404C9;
	Fri, 20 Jan 2023 12:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42587404C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FD2C0033;
	Fri, 20 Jan 2023 12:40:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62DFEC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4955441CC0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4955441CC0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XO9vGQVR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xOIGpxLNL266
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:40:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49F8141CAC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49F8141CAC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674218442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+HGkphiOiRdEWTLkrkQfvb64ugB3xmQDDmbxz6bl1U=;
 b=XO9vGQVR0MSpPIxL8FRiYafo6WIkD5eC2lJt0czPbcpA2N0FZ7RpdPjm+fIj9Fb7BmmdgW
 1UW9+BDVqN/ZizM16HpFn6q1fOJnmQwhpTGIxr749FbB2Dw5l0MDDhfY0VCHdDjYaj2xZh
 JWVRadPX3PiXFqe7U0LRaw95B30M6qU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-c3568OvmNHuNJDsNnIpHRg-1; Fri, 20 Jan 2023 07:40:33 -0500
X-MC-Unique: c3568OvmNHuNJDsNnIpHRg-1
Received: by mail-wm1-f72.google.com with SMTP id
 o2-20020a05600c378200b003daf780e783so1283406wmr.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 04:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+HGkphiOiRdEWTLkrkQfvb64ugB3xmQDDmbxz6bl1U=;
 b=D2Nt1YSQxt/2QksoO/BftKQDlbfaR9nL2OPcebwgV34rNYsqKg6yo0qAXojqHDrr9g
 dxchQJsAN4DAh8DrV31CrXw6icwTEGcKxNDHz4kMzq7vRw4sYhpCOIMjCYUdZnXd8yj7
 hF4whuFGGl9Oq+bu2WgPE5X+riYaUVKgZL4c68H7j2l1az/0I+qj/KWJ9yqNLQDN8jLR
 AHg0VWhpyFw76DdbFWnwgS/oLPXEBdQn47MyESjdxioKgVn6tcDzm4FrfMV8t1wYqFGc
 FqHgrArnNwv5nJN7gM97Chv7UJYgjo3bv7v+59fv3M1cQ59wfimoldXm7qKm/Vldzd1p
 paGA==
X-Gm-Message-State: AFqh2koKjdX+MIGUmVC4OAYy7zyD4WZslwVqU+NES1R9rEnBsubhLOU3
 v89xyBwQj5dtBt854nMEYN11ZRGuzbeHoDdNFzDDH6Om1Ihukp8wcSwuaHyyNHPi0Kt+YY19TgL
 zcdXtaby+MdLdAB7Jtrl0WZKIFswtnwbAVBrlFyT6wg==
X-Received: by 2002:adf:e991:0:b0:2b9:1a52:4f50 with SMTP id
 h17-20020adfe991000000b002b91a524f50mr21008669wrm.6.1674218432375; 
 Fri, 20 Jan 2023 04:40:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv0Ll2FYH05kUY/tQa/4cTBo62GBhghbxnCbiBnXTO2FiIz9W9LIKQVRJnl9g6oW5vBGFxE0g==
X-Received: by 2002:adf:e991:0:b0:2b9:1a52:4f50 with SMTP id
 h17-20020adfe991000000b002b91a524f50mr21008659wrm.6.1674218432154; 
 Fri, 20 Jan 2023 04:40:32 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 bt19-20020a056000081300b002bdc3f5945dsm23769465wrb.89.2023.01.20.04.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 04:40:31 -0800 (PST)
Date: Fri, 20 Jan 2023 07:40:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 0/6] Harden a few virtio bits
Message-ID: <20230120073942-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230120065402-mutt-send-email-mst@kernel.org>
 <877cxhqtdi.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <877cxhqtdi.fsf@ubik.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
 elena.reshetova@intel.com, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 20, 2023 at 02:32:09PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jan 19, 2023 at 03:57:15PM +0200, Alexander Shishkin wrote:
> >> Hi,
> >> 
> >> Here are 6 patches that harden console, net and 9p drivers against
> >> various malicious host input as well as close a bounds check bypass
> >> in the split virtio ring.
> >
> > Hardening against buggy devices is one thing,
> > Hardening against malicious devices is another.
> > Which is this?
> 
> Well, the big difference is the intent, but buggy input is buggy input,
> they've got that in common and we're trying to deal with it here.
> 
> The motivation for this patchset is protecting against malicious
> devices.
> 
> > If really malicious, aren't there any spectre considerations here?
> > I am for example surprised not to find anything addressing
> > spectre v1 nor any uses of array_index_nospec here.
> 
> That's strange, patch 6/6 is exactly that. There's probably more coming
> in the future as the analysis and audit progress.
> 
> Regards,

Oh I see, didn't get it for some reason. Pulled it from lore now.

> --
> Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
