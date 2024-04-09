Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D354776
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636218; cv=none; b=p5PYpQA4vDHEL6pLl9IIDmC7rKNj9/WPGG6o6fb6sgKptwCZDy8mrb26Y6n/BwDQdhbQo7FTeV37ET7vdAuouFkK6RzRgxlLIrbYHmPR/xWAwjuuf0b+kyfGE76+2tM64ijtpLJ28Ui9RCW3dsc7cyfyyMy+IfnNYPmrkxDpXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636218; c=relaxed/simple;
	bh=undWhbOHVVyKh+HISuJKwZeZkWTJpaMwIH+vfP96f8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky3qRZpCTi8y9hR1xlqSXZw3jkoYBAKhHfW8BesA26ydDsBBu9UChix+iU7F7j/xeGisEHeAQDmFCq0fzwCIq1SVCpj0vB1r0Lc/GS1HpnzHpdQSybtftkdsYOvaoeOEBpS9nBe/1ydLacqmb9sIkgxxOkgwX2El6Xs7fmMwtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXCTN7cq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXCTN7cq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80EC960B74
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 04:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mu0_FvlYgif9 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 04:16:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CECAD60881
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CECAD60881
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXCTN7cq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CECAD60881
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712636211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=undWhbOHVVyKh+HISuJKwZeZkWTJpaMwIH+vfP96f8Q=;
	b=MXCTN7cqaEOoG4Lsx7N9qFOlKXcWwqJhmjMlul+5Rf1MBFTDYFQ4ADbNDbwxNTF00eberm
	zz6vqd4usy/CcPe06Qm94+w8eMhHTJCSkLt09OVVn0rMzaJ1uLgyDuXPBuHJ/KEn8SW2Kt
	ThBdcxRSaZrP1gU86RvhJ/tHF2Mh/t4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-CeuM1kuMNt2niRYjtnWtpA-1; Tue, 09 Apr 2024 00:16:49 -0400
X-MC-Unique: CeuM1kuMNt2niRYjtnWtpA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a30dc503f3so3384223a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 21:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712636208; x=1713241008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=undWhbOHVVyKh+HISuJKwZeZkWTJpaMwIH+vfP96f8Q=;
        b=cPcwn5Qgs2HYyEhJRsWISyXMVGms+vgFDVhmSvFjyWFe4HXzsyjb9hGEI6Cezdj+KV
         5gjCuT6pL8cSZyJ13HDgef2dogOLehYLOJrCNSCdQydm+kJDaDBA1Olw3YtjwX34GiZy
         p+g0kVnFWpkIgGhFktuvWvOvid8zOXFlbLFYC/JVjKroq9Xi8AagFaeYhLOQt/9wyGVK
         RYRThlLUV3sGtt0T4O5WLMXdbgWEdAWWV49m+i+BPp7t2VtbJPsXbKnhMILEK6xesNiH
         fP2deP+U5wyU2PQfRgVsxFak7rmednCxJAr/Rp3jGUzqIsAuyivJEAiDUxp7y7HpFGho
         VVFA==
X-Forwarded-Encrypted: i=1; AJvYcCXt2VIKIK2WTIymwZIL3uWxH7cZCDoFoPizfYL74gmN1mpcFrbdlE+7Vo+G/QLesmN2xXwAWvBlB2+V5X+qpU+GpPCDlHM4ZuebRt0hY42CeQK8l3zGSwP1sw==
X-Gm-Message-State: AOJu0YxV3wCx08WgU88DpJqvP0qmd9ROI+/QZiRgR6zeOYIiiC32t85z
	WbE2N7jiKOyt44OO11t96jm2ih9lTjTpJugksDk5evv9qkVFvwqh1DX2v4l8WB2LimknM+iPFTC
	J+eL4FMJrVOwLflXkuA3MAGc7TgPp9fTYULqr3hAFg3/jCn0I5aDj1j0n8gw2jYjM021x3k9rB0
	32tTxtdoPYfIjoDrIwW0UdgMs3t+v4sF9qW7IVBT+1+qhfO9jhab66xA==
X-Received: by 2002:a17:90b:1c12:b0:2a5:3f9a:97ae with SMTP id oc18-20020a17090b1c1200b002a53f9a97aemr3096795pjb.38.1712636208306;
        Mon, 08 Apr 2024 21:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIQNAjdrFayTFv6a1MdsXW71wSs+AxDhRdGw9tDuT8VCitDV4Kif02Ccu2xp3SnWv2d4gmpB6Oqk50AgL8zUU=
X-Received: by 2002:a17:90b:1c12:b0:2a5:3f9a:97ae with SMTP id
 oc18-20020a17090b1c1200b002a53f9a97aemr3096786pjb.38.1712636208039; Mon, 08
 Apr 2024 21:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240316004707.45557-1-michael.christie@oracle.com>
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 12:16:36 +0800
Message-ID: <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Mike Christie <michael.christie@oracle.com>
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The following patches were made over Linus's tree and also apply over
> mst's vhost branch. The patches add the ability for vhost_tasks to
> handle SIGKILL by flushing queued works, stop new works from being
> queued, and prepare the task for an early exit.
>
> This removes the need for the signal/coredump hacks added in:
>
> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps reg=
ression")
>
> when the vhost_task patches were initially merged and fix the issue
> in this thread:
>
> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>
> Long Background:
>
> The original vhost worker code didn't support any signals. If the
> userspace application that owned the worker got a SIGKILL, the app/
> process would exit dropping all references to the device and then the
> file operation's release function would be called. From there we would
> wait on running IO then cleanup the device's memory.
>
> When we switched to vhost_tasks being a thread in the owner's process we
> added some hacks to the signal/coredump code so we could continue to
> wait on running IO and process it from the vhost_task. The idea was that
> we would eventually remove the hacks. We recently hit this bug:
>
> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>
> It turns out only vhost-scsi had an issue where it would send a command
> to the block/LIO layer, wait for a response and then process in the vhost
> task.

Vhost-net TX zerocopy code did the same:

It sends zerocopy packets to the under layer and waits for the
underlayer. When the DMA is completed, vhost_zerocopy_callback will be
called to schedule vq work for used ring updating.

> So patches 1-5 prepares vhost-scsi to handle when the vhost_task
> is killed while we still have commands outstanding. The next patches then
> prepare and convert the vhost and vhost_task layers to handle SIGKILL
> by flushing running works, marking the vhost_task as dead so there's
> no future uses, then exiting.

Thanks

>
>
>

