Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB7A32
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824807; cv=none; b=jC66iqBIsW+gzfolBOkubIeh1b5yFKe2kmvFdMvfz7TAHsF4fn8N76oFtppf4ONuKvrrd+4uPZTWwlNdjgIbPDqb7T7L/CpMF9vNF4RzqkJmNn16RsKNTkz/6lMnvEI6Aqf7nUMQx0mQSzfTyvsw78ar6zhjtTbY+i/8B5iDkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824807; c=relaxed/simple;
	bh=muBOoc16C2M4cMYszyiN6GAm+fVjP1NhBVJC8EpxLmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmGB+23YfQHL+uC4H4ZXRzK8T4X8ssRkBnh79ZJj/gfqXwilhqO8enVDedYem++YS9CVAqHXusZkvMVsFul4dWCc4bk/+TIxRivDbV9Y+WoH202Q82RNyZNYyg4r7bu+XWPLUCwCHt4JHX7uRQGxP+G7fOtnf5ChH2KEkAe/iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+46rtyN; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+46rtyN"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 116406124E
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 08:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzGfltsFdDVj for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Apr 2024 08:40:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B6E7160EB7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6E7160EB7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K+46rtyN
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6E7160EB7
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712824803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muBOoc16C2M4cMYszyiN6GAm+fVjP1NhBVJC8EpxLmo=;
	b=K+46rtyNrqz4ejulhnQkWxkfwwMo53Ut2lwxt85TovUVkQ0bFb6oJ0T6ZL3vWga49Ue+7H
	9rVlV1XIxF6RNdagtlulAyHOxG0khLpaCUT1fcGGRHJtYaegQkPEfvkgWM1+2pwZNzNuCh
	oJxT6mJsmi2EEvsAlOd3eieMANJurM0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Nu0k9wVjPM-JOj4HbMp4jA-1; Thu, 11 Apr 2024 04:40:01 -0400
X-MC-Unique: Nu0k9wVjPM-JOj4HbMp4jA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5c5e69461so1488902a91.2
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 01:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824800; x=1713429600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muBOoc16C2M4cMYszyiN6GAm+fVjP1NhBVJC8EpxLmo=;
        b=mzh2sDByFhZatkzQyAsNsm4AMlQJK8W9bg84gusBCnNfBR+5fm5NE9gdLTfzyjLgyf
         aGaFpEtJ0plI8PQgiCsPXxctOSsHMQU9oULCozB8tONFZwYKGGV8kt0Xuc1wUSY/h1/F
         TYhuCVzvV6xgc1+Fa1iQ2YERpkRi5ne/jsHrrrmZ3kACFqrd1U2OfsmBa6+XXXa1Xw2y
         3IWUQsuBCI3cHRcWLqx3FpCs5ZwSEIAJ3/sVNZ7PnNSy9ArxtS0f8FiHzy2QsPTMa+v4
         97M/mV4rMZEG0L89xhYqm6z47xFtje8NORE2bjPCmT8eick4qdDNAg//4mnQLwJCRrJo
         YJmg==
X-Forwarded-Encrypted: i=1; AJvYcCXMKXKNIKqjEkLw536Tw421kAEm3unwyAXGDLW6yM+a0Q1q3i+Fuj7xcmIUInpHAECv0oTOh/G5I4+AQP9cpzcoHiYvZAYwl1h5TxJJa6VXSHDS7wLV963gcg==
X-Gm-Message-State: AOJu0YxV9L54jaNKbXDcROLH324r/HohjMF37QYa/bGMyKPPlfXjxape
	CparSFQkL5QLvdJDBJwPkkgqhYzf22uyP6pqWGzjSRvaOL8uiBBtLllmS1B7RwUGpZFy7gUMM1V
	kCujCPI1E3POFI3a7v7oBVlIpJp5Y97TtIInsvyHhucmm9y1bVaewLtr171I0XQj7St7p1KyY3N
	O2ZEtewcpK/H3PKixs6rTmWYMCwrTyWv4h2f2+SNboH9wFXfdhFXZGJw==
X-Received: by 2002:a17:90a:9102:b0:2a2:c127:5aed with SMTP id k2-20020a17090a910200b002a2c1275aedmr6264858pjo.0.1712824800198;
        Thu, 11 Apr 2024 01:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfm1m00HprmnilIhZs3mCiWEYYsSj4wn12JstZsao3hQUhU6L7QXSHGmnJQ3kk+Uywt19g1EzOVaQiwJrfsXY=
X-Received: by 2002:a17:90a:9102:b0:2a2:c127:5aed with SMTP id
 k2-20020a17090a910200b002a2c1275aedmr6264846pjo.0.1712824799859; Thu, 11 Apr
 2024 01:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240316004707.45557-1-michael.christie@oracle.com>
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 16:39:48 +0800
Message-ID: <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Mike Christie <michael.christie@oracle.com>
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
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

A dumb question.

Is this a user space noticeable change? For example, with this series
a SIGKILL may shutdown the datapath ...

Thanks

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
> task. So patches 1-5 prepares vhost-scsi to handle when the vhost_task
> is killed while we still have commands outstanding. The next patches then
> prepare and convert the vhost and vhost_task layers to handle SIGKILL
> by flushing running works, marking the vhost_task as dead so there's
> no future uses, then exiting.
>
>
>

