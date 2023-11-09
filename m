Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DCD289
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaMn6SFY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F5B780C41
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F5B780C41
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YaMn6SFY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id usMdbFLeCXcl
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 06:04:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B4AE80C38
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B4AE80C38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699509895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6wrZg34sE5o38Zaav9BWJ8hWp0kxsaPC0/Swy66yu0=;
	b=YaMn6SFYyq+rNyPMdBMndMOlryiFVUzffVcPxjkFdIVP0Oju+fPt7HI3h/0KPx5zPTQuRW
	F7+9cZhjeg4U75DozVwQ+yI3Ahyhp8yrJJmPMy1F5Soa/7lHN5BnLi4v89x+3YPkxZBpWj
	++gRS9DJ5XIs/U9nZFlcY632XAUPpf8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-L7nCdbHwOj6--jgx3AwDnw-1; Thu, 09 Nov 2023 01:04:52 -0500
X-MC-Unique: L7nCdbHwOj6--jgx3AwDnw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507cafb69e8so450981e87.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 22:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699509891; x=1700114691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6wrZg34sE5o38Zaav9BWJ8hWp0kxsaPC0/Swy66yu0=;
        b=XDC3NTOW5IaeWk9CZVx4073Vwrh8Mj7RXCS7uDn3ZP0xwrIofheKmGWWZm42JhINiD
         PrukTiOlpSb22pr2jtfMKADdeFIi9+uB+am827hJfjbmfb6tKIPto+a1Y7AqJcPvlSkN
         xc55STvRGUn1T6nBoa74ZrBRYfuXadu4PuxMdYyKCxH7nvpzo+1l0sn6kAA65jCMSli4
         OPeMrqOZBLOFFfwIBVnGOV0HRn/Kbw9EIat+tBEGmDg/cVHpnrx0p5QMQyVfx9Duupl2
         lHFo5SdlcYcPMknSbGTnXdEB8yp8rKZS4uuvPhlqOYrBQpmU9lmnw7yFKtKidX09ZIy6
         bXtw==
X-Gm-Message-State: AOJu0Yzq32I6KjE5rn8EdUT2GHwL9VyvnOFdoJnp9Vwc4fEHwIXOh7FO
	ylQAunzrhZWeMS+f7WbnjysVFmGSV9CbHm65LPuCwamwJdq4zAj+Gwbn9AgO9YfgOmBkoUz7su+
	7aIqKFPk/4FoA+3XdNkCndeAwBisakJVOTnJwy4ThbaCr7tT1jOyp7iSQ8g==
X-Received: by 2002:a19:650c:0:b0:509:441d:9bea with SMTP id z12-20020a19650c000000b00509441d9beamr452196lfb.20.1699509891466;
        Wed, 08 Nov 2023 22:04:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzAjRQa0dfmmCDvdNARnAGJRrXV4D+3px8+TEbwSfElPkxyFVVMRozlkpArRetiFj2ltXw02BBEZNBlzFA+Z0=
X-Received: by 2002:a19:650c:0:b0:509:441d:9bea with SMTP id
 z12-20020a19650c000000b00509441d9beamr452182lfb.20.1699509891176; Wed, 08 Nov
 2023 22:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:04:40 +0800
Message-ID: <CACGkMEtUwfkyx-V-h_PjeGoVZz8Wu50yBRXHkDNTPgJQjzmvJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/21] virtio_net: add prefix virtnet to all
 struct inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:13=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> We move some structures to the header file, but these structures do not
> prefixed with virtnet. This patch adds virtnet for these.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

