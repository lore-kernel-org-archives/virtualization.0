Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9B7C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 11:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C768640385;
	Thu,  3 Mar 2022 11:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EeOSGWelVCed; Thu,  3 Mar 2022 11:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04369401A3;
	Thu,  3 Mar 2022 11:41:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A20C0012;
	Thu,  3 Mar 2022 11:41:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA000C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 11:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA7C584164
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 11:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FxY3Xo0O4lx2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 11:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AAC384162
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646307681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYCeA3p+VobnFI60d/2FCflwd0j6ao0o9uLj1wDT+24=;
 b=fFSU3qdX8cOSSDwhlKHo6wL62L//lffoB1yUX4ktCotARyZN2ECiiGnZgVyczAqog1alGz
 d8huRuGAHgNu0r+OK4NS/WHU+a6O7lFubigpzb0VeYCU+AC5w0edYFwsRBJFArcNaKTI6k
 UfLEG4stDczI1bw8qnxbJcRk5e10J4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-z1JV7c-0N2ac45Zet3A2GA-1; Thu, 03 Mar 2022 06:41:18 -0500
X-MC-Unique: z1JV7c-0N2ac45Zet3A2GA-1
Received: by mail-wr1-f71.google.com with SMTP id
 w2-20020adfbac2000000b001ea99ca4c50so1937469wrg.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 03:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mYCeA3p+VobnFI60d/2FCflwd0j6ao0o9uLj1wDT+24=;
 b=MLaB4sjw0ZAn1W3ENfyqt6abnW8Es+aUBqpVLURSkDFUquNactnhuVdX6yTD9MT6Rs
 3XELpYwLbVLR0WJcR1FiqJPyzHSxRPpR7CgbHkHTw5aHvR7Wf0CYPWb8XZF/ZaJMKKkt
 I3V/Tuiv5Ax0Jz70kL9CQ4nCy+GsxVP0/3Wo9N3pWMcABELkgSh5WokP8A5qDUA2M5j/
 gdEfHc9lf6bqeoauqD9rA6NcG227YOXFT/MPJ8/al+qd807QOIs0McVEHgiIy25Z5hav
 AU7DOfegNZr+7LOu3uwel1qVj8tGHbv+NYMEJcnCz7eiMMXoqvrImQ7XHBiOVek97RVz
 PCoQ==
X-Gm-Message-State: AOAM53089x+g+koQGlVRbiELTxQEULnUES7qsT5LQaxE1VcYmNtgVDzp
 U/meOxzvsFfM9t/cen6QPQ7BFZrbfe4REkQBbiLbP+bzRhRP2zcEUIzkwoQfVAt5Khb/2s2h8hK
 uCQgzlrVZymj7uJFX7XrVhYEgAjjp5oI7/o1sk12JZA==
X-Received: by 2002:adf:fbcf:0:b0:1ef:d5f2:23a5 with SMTP id
 d15-20020adffbcf000000b001efd5f223a5mr13822878wrs.567.1646307677326; 
 Thu, 03 Mar 2022 03:41:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVTJ2w1zlNAb4zw6YFWOthc/iPEKLzYsmwj8AneDhXG2hwWMi6cEkx3DLGuPiyliMN46fNPA==
X-Received: by 2002:adf:fbcf:0:b0:1ef:d5f2:23a5 with SMTP id
 d15-20020adffbcf000000b001efd5f223a5mr13822855wrs.567.1646307677116; 
 Thu, 03 Mar 2022 03:41:17 -0800 (PST)
Received: from redhat.com ([2.55.143.133]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c511200b00352ec3b4c5asm2459177wms.7.2022.03.03.03.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 03:41:15 -0800 (PST)
Date: Thu, 3 Mar 2022 06:41:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <beshleman.devbox@gmail.com>
Subject: Re: [virtio-comment] [PATCH v5 1/2] virtio-vsock: add description
 for datagram type
Message-ID: <20220303063001-mutt-send-email-mst@kernel.org>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20220224221547.2436395-1-beshleman.devbox@gmail.com>
 <20220224221547.2436395-2-beshleman.devbox@gmail.com>
 <20220302160958.62s34i2n2tccsscz@sgarzare-redhat>
 <20220303032801.yvlfu5vqqibu7eyo@ip-10-100-118-60.ec2.internal>
MIME-Version: 1.0
In-Reply-To: <20220303032801.yvlfu5vqqibu7eyo@ip-10-100-118-60.ec2.internal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 arseny.krasnov@kaspersky.com, jhansen@vmware.com
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

On Thu, Mar 03, 2022 at 03:29:31AM +0000, Bobby Eshleman wrote:
> On Wed, Mar 02, 2022 at 05:09:58PM +0100, Stefano Garzarella wrote:
> > Hi Bobby,
> > Sorry for the delay, but I saw these patches today.
> > Please, can you keep me in CC?
> > 
> 
> Hey Stefano, sorry about that. I'm not sure how I lost your CC on this
> one. I'll make sure you are there moving forward.
> 
> I want to mention that I'm taking a look at
> https://gitlab.com/vsock/vsock/-/issues/1 in parallel with my dgram work
> here. After sending out this series we noticed potential overlap between
> the two issues. The additional dgram queues may become redundant if a
> fairness mechanism that solves issue #1 above also applies to
> connection-less protocols (similar to how the TC subsystem works). I've
> just begun sorting out potential solutions so no hard results yet. Just
> putting on your radar that the proposal here in v5 may be impacted if my
> investigation into issue #1 yields something adequate.


With respect to datagram, there is actually another issue which also
exists for stream but is smaller there - per message overhead is not
accounted for.  For stream we can work around that by copying payload
data.  For datagram we can't as we need to preserve message boundaries.
One way to address that is to add config for host/guest per-message
overhead, and have sender decrement fwd counter by that value for
each message sent.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
