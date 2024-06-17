Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994917B506
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588921; cv=none; b=bcXT4Kr5SN3bJ3mcYt4U6WVT0tKi+N9uAFzsciUGDdwwSFMZMsh09mhGAXMltQ2Vx85XRc/MWmHAL30QfzUhWZurIhIlRVzPxi0SMjEx/ONNa+uQTxMmZmWAyb67YiJYR4zqA5WLV5mG3np+BYeWCZvv1mPjAqwJY+4/gfp+qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588921; c=relaxed/simple;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChAMmkN4gzf7t/it1zjByjAiBr5G+LyB+CjjMNHTko/6WuzLfBnfjG4VGLzSQWaE/O2JsHwvZ7QvZk1kW2YFjTStIfxIapdn8If8cYQ3pM0oXm37+eCChACE7T+1wmks+6zinYCcRw2Q1bRdg1niefJal+XtkB5yiXdB2DeCT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBcqGbFI; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBcqGbFI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7A26605BB
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 01:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NrKP4B9-RJ8 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 01:48:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD082605B3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD082605B3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SBcqGbFI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD082605B3
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	b=SBcqGbFIlwEMZ4mlEycnDZQrWRLdgHUWRWR0+rHgLcaZjWrBqo251yu23ZO1mNwBJd4Ai4
	oO2D2DKyYDJI6OYV6D+FjDgkBlO/8x5xeRUfqRGL7tooD7BLQnxH+ErOtuuV77ArojFPWS
	QyQYE9KjGQSjbmqkmVPiSqzhbPdXK0w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-s7l7UbEOMiC0vn59VxFcCQ-1; Sun, 16 Jun 2024 21:48:30 -0400
X-MC-Unique: s7l7UbEOMiC0vn59VxFcCQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2db3eec8eso4184567a91.3
        for <virtualization@lists.linux-foundation.org>; Sun, 16 Jun 2024 18:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588909; x=1719193709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
        b=nYXKNf2PgqUY2iO/UcG2gA7Hg6oU/ME98d4wHSAJAcBGHPd6Wvmz4UcvePC9qZxlyd
         J170NU0yQv6FJb3fmMykjqfi5O9xOuj3q43Wtzea2phy7A+6cSj9n8z35U9rk9E6nq5j
         pT7P4iEX5rGZer0pjObg48WtbEozaNBHr0u3zfzUM560ycRe2mYLGg25J/58aoCRHNUx
         Lg/FsvPbOpRGIzsG0KWnn/8F4fUZy9bHejggWSOtpCWz0po7vdDEq968STqEWcKh/y+J
         f4witSfSRvNNvwELonIG2lU/+DQsZh+Lx3zwAJhBjnZCiYWjG58OEHZfDgw5cKP/bbvL
         ey2w==
X-Forwarded-Encrypted: i=1; AJvYcCVofQwx8AteECAlHHr8FHJOEDR9A6eHhA8YzhenyvkLW3eLzDa+iQBFcUw/dsJyIacjTNKdySoIuZxGyIc3jOSBM75bysj2bTyGJqy7yOifcf/qdyNw2qK4HQ==
X-Gm-Message-State: AOJu0YyvocgghGuqsG9dY0+GHHLanLNcVf8hO2n/STZXpt/C1khALRRa
	3VLF4ckLvuJ0bhX4dQvU7V8Ai23H1WiraA8p3BGRxkz4FDiPmieVHcdd5VgH8k6JeiQnrtkZCZ4
	0FfK18HdN4T+QZJEFSfCLsydRwTmy0AozGPug2MTQUckx3fZodPZZETpEkL5jAXZY78yiEIGl+m
	plBV8hNwgiuM5SwOKF9NJDpe5UjKOtKQdjSn72v3kgugqP5DEIZHtLSQ==
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id 98e67ed59e1d1-2c4fc646c13mr5027223a91.31.1718588909235;
        Sun, 16 Jun 2024 18:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj+RTz1EYy7hweDAE1ICq45L/lGIK63DQpX9VOBUb8HY2SxFjoa3c8mAZlpi5oGyIBYrcUXdO1Y9miqAIgA9g=
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c4fc646c13mr5027209a91.31.1718588908759; Sun, 16 Jun 2024
 18:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240611053239.516996-1-lulu@redhat.com> <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:48:17 +0800
Message-ID: <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:30=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >>
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
>
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

It came with devlink first actually, but switched to a dedicated uAPI.

Parav(cced) may explain more here.

Thanks
>

