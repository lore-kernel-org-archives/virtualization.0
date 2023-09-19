Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2BBCE79A9
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 15:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0989641D9C;
	Tue, 19 Sep 2023 15:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0989641D9C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+1hs4J2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hffmJ5mQ_El2; Tue, 19 Sep 2023 15:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4667E41B97;
	Tue, 19 Sep 2023 15:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4667E41B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B17C0039;
	Tue, 19 Sep 2023 15:52:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B20C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86FD4830A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86FD4830A8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+1hs4J2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4D0WMR-OCQJF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:52:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 373748376E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 373748376E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695138755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbKVtehYcbhibKezgI6pJqBXoaPfzap/QyqXqux7Yww=;
 b=F+1hs4J2w/0nDQbe0FwkcXY4+k4eL1AP/5p4mub6WWandCOiob08cpZiW/Sr9xZByvCoCx
 1esEh1h/bX4Q6J7WSFADhHPy68FAjnKYSKLKTl/k8xYYE9UGwjXRqT6Q8DMp/tVqVknoK1
 33tDdyL8UtPK/akvGbTiVpWGbHPcnAY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-awF1oL_KOzGT64JGa63XHw-1; Tue, 19 Sep 2023 11:52:33 -0400
X-MC-Unique: awF1oL_KOzGT64JGa63XHw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bce272ebdfso73116941fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695138752; x=1695743552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbKVtehYcbhibKezgI6pJqBXoaPfzap/QyqXqux7Yww=;
 b=MuEwYmB202aQLUHdy3LEU/BXzAviVmf3zaOSidfXRwtA5IbE2fKfrMtQhzYMpzPjPh
 Uf3dEruONcMxIHyGLqc7VXnbz/sB9Um33CDIJQzy49q1E8AbVz6OoZ3SUKkjzvrOuQbZ
 zUNDwUpJ1zhU7Jg24s2qkwYPwcQ1LGz/D+Ng+6cUWN0Xkwk6wYPDQL/+oxzaI5hgsybe
 3Rnltxz1zpZVzh8WATPNBjP7ykIJozBSwCP5w+aDPkNdW2enItAwLKhrZZxgKP+XJaBX
 1iRQyamn+ORN/U9ojdtjpqdf2RJOVKVruprhybibm4lLF/WqgJTcSobTM9C4Yu+yboO9
 kniA==
X-Gm-Message-State: AOJu0Yy6Xok5wdBXvEeayZOk5VX8T8NTFHHhquI1ny8kRjzsxkatI6GY
 1NWdn0mUmk+ISVA+/8B40ci0cfEAHl7mlh6dEL8pLqT90Uz+n0fuYC15Kq672aHW9O/NtbvG7at
 gjUSdbnpiYzcOBhrKAHlXS9fNz5zXDGAsqxhjQm2VwA==
X-Received: by 2002:a05:651c:120f:b0:2b6:e958:5700 with SMTP id
 i15-20020a05651c120f00b002b6e9585700mr10727846lja.4.1695138752074; 
 Tue, 19 Sep 2023 08:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFExL0VFTDt27m3v0qN/oTbmVeVCWwmLTwYALUw2zvGNVbTihnRcR/krc3U2LcAu1qft36hhQ==
X-Received: by 2002:a05:651c:120f:b0:2b6:e958:5700 with SMTP id
 i15-20020a05651c120f00b002b6e9585700mr10727829lja.4.1695138751713; 
 Tue, 19 Sep 2023 08:52:31 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 cf20-20020a170906b2d400b0099bd453357esm7931499ejb.41.2023.09.19.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:52:30 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:52:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: Re: virtio-sound linux driver conformance to spec
Message-ID: <20230919102250-mutt-send-email-mst@kernel.org>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org>
 <ZQmt0Z8lbPMuFzR+@fedora>
MIME-Version: 1.0
In-Reply-To: <ZQmt0Z8lbPMuFzR+@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Sep 19, 2023 at 04:18:57PM +0200, Matias Ezequiel Vara Larsen wrote:
> On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
> > > Hello,
> > > 
> > > This email is to report a behavior of the Linux virtio-sound driver that
> > > looks like it is not conforming to the VirtIO specification. The kernel
> > > driver is moving buffers from the used ring to the available ring
> > > without knowing if the content has been updated from the user. If the
> > > device picks up buffers from the available ring just after it is
> > > notified, it happens that the content is old.
> > 
> > Then, what happens, exactly? Do things still work?
> 
> We are currently developing a vhost-user backend for virtio-sound and
> what happens is that if the backend implementation decides to copy the
> content of a buffer from a request that just arrived to the available
> ring, it gets the old content thus reproducing some sections two times.
> For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
> `Front, front left...`. To fix this issue, our current implementation
> delays reading from guest memory just until the audio engine requires.
> However, the first implementation shall also work since it is conforming
> to the specification.
> 
> Matias

Sounds like it. How hard is it to change the behaviour though?
Does it involve changing userspace?
Maybe we need to fix the spec after all...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
