Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70709208AD;
	Fri, 20 Dec 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707999; cv=none; b=ixEl+b1fyzr03KhbfCnVDCKH+47iYOJxpIvqhW0yihFsqxO6blr0nRkaiuuUR4IsAeB7T63SgmB552fs+OFTMlHbZj8rbzKx3Vvr2WFq8K40JAs3o8D7Rq3mWd3OI/y3tFI/ye6FNL3yShToy86Y6ZhP1f3oEGdNadi0CSSs2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707999; c=relaxed/simple;
	bh=JldQqxDH8mvpeKCYB9thmfmrzuLJ5su27e3JcvWr/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBruBZeR6BrLD0oq55H3N3Co0qXRBnp/LtAV/Yu/Frp3XdULhfJbOHBB9swK81l0pGvm2244Q2dCXhC55Yb6D3FF/aQcu1t74XYLbVJuw9Hsy+xh4B8R6IJFF/JWEj/7Q5pzOgEL67+2hQH50Zx2a1XMDEJY96WeNZWnRXhyLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIn/VKVj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIn/VKVj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1547501a91.0;
        Fri, 20 Dec 2024 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707998; x=1735312798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULv4d5ej0EGbh9z1eT6zvijwptui7/HKQ4JCeBG/fHM=;
        b=dIn/VKVjrgnHrM6b+beJ+AsG/TfAzAgE0oD34JAwgW6eiWRJQRFsOma+34LI64LvMD
         msQGMGb9b/heij7JxkdKegBdDqFqnbjvEbW7EMzvT5xPdAgUG2JyR21EVSsooicD+/Eo
         xd2u+QjO5mZGvEODLt1aG6lXfZ+XOJoW4tnoiTrTxlwZhgBD7h0Vw3cpSNTj2tsG6UAx
         Wd+FeHIs2IIlJfNSLAG9iW2Wp3AD3Eghl+SIFVtiTGK1Xx+RRUMZbnLG8f1jv9AZVvN7
         fqQ6DBkb7t7VtVGr6uie2xfueQ1QFPHfl1dcv0H+XYvWfZHJ5adRcIM34ThhM8iHyWrD
         jhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707998; x=1735312798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULv4d5ej0EGbh9z1eT6zvijwptui7/HKQ4JCeBG/fHM=;
        b=djcLDx8wdZF0hfqW6TgD/n4/uqPx9TGVWXJ63s++ijpL/Ot7lTaf+DjtiWJrxfSbaC
         3Bn1qDQz/0+FJfebJZjq36beaom5GG58Z+PNZaHhQINmR90s4cayMTUxCYkkjl77zxVB
         mQGwAbBqcQzq8AD8yjFz/0C6c9zpdEkzCKUz2JB+K6FhpU9KLzoGe2F6U8LX5mGIuo0f
         TqS9ZWDGz3pRqgT3PH/TBtIaQ2y8cOSpkqTzkY6eBmKFwPFx1Q8LtT5NVM5jbHdKyaF6
         ayC3zEyIZj3Junb5xvF3SYTngWBrOpHiMl4dhBIc23eHPUF+LMv+MsYo7r650u+ItE7D
         WOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoO7PJI2a90SA2dbURKF9Gx3q0sEWTeL8xRXozAML6hW1rXctNldgA1RwfQzcjYgfZOhd3LhpomyOk@lists.linux.dev, AJvYcCXq3h5D4c11itRJqNXv4q5fboVvoEVq8ydVqJOrOuH4ZBzamWevQqwj96hspprkUNNkgTbWv5WLDRop2y04Vm0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzGiqAotNVke9R0vojNroNocLjGbWnqe77jpj1MSjGLV3ccErhN
	MxDuiPfDJxTDDhSOyC/JbcNk6waJUEfl6h5dFfKVIU14Sn+f1aaB
X-Gm-Gg: ASbGncsYhHUe039Krk5kdmC+e/jUuxxM0L0fPl56yDzQlAYJ9J1d6YzIlhA650HcG9y
	j4J11vyL+SxQtQ0G89Ny48RQmYq5JB2Am37qwQ7YCNUrCfQuahSfc5CFcV4e8z3Da06E/sO3l4h
	A2QIxwyJmMzYB/C5eDt+TXR0kjyPWJ87YIhMxzK5LCUH1vMVW9c+eVk9d+iigwBqMbbUd2p7CO5
	sc9uWQjueZnrLJNRC/ebT1jq8pAaruv2xDIiIPrTNdi7dy/vAjn74FVk3GVZk0Qqk2ONKNs7MLI
X-Google-Smtp-Source: AGHT+IEyMqq1xrGIJmgMfuLbdcE1RNg78jfaOb809zKFY/9Vlp9bkY42pZBrpxkTCtBgzJMib9Z2/Q==
X-Received: by 2002:a17:90b:50c3:b0:2ee:6e22:bfd0 with SMTP id 98e67ed59e1d1-2f452e4d5ddmr4359906a91.21.1734707995980;
        Fri, 20 Dec 2024 07:19:55 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm3418138a91.51.2024.12.20.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:19:55 -0800 (PST)
Date: Fri, 20 Dec 2024 07:19:52 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.linux.dev, netdev@vger.kernel.org,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH 1/2] ptp: add PTP_SYS_OFFSET_STAT for xtstamping with
 status
Message-ID: <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219204208.3160-2-quic_philber@quicinc.com>

On Thu, Dec 19, 2024 at 09:42:03PM +0100, Peter Hilber wrote:
> Ioctl PTP_SYS_OFFSET_PRECISE2 provides cross-timestamping of device time
> and system time. This can be used for virtualization where (virtualization)
> host and guest refer to the same clocksource. It may be preferred to
> indicate UTC time, rather than TAI. It is then useful to indicate when and
> how the host processes UTC leap seconds (stepping or smearing on leap
> seconds),

If the VM host provides TAI, then the guest may freely derive UTC and
leap seconds on its own.  Whether to smear leap seconds or not is
properly an administrative configuration choice in the VM guest.

Leap seconds are scheduled to be deleted in 2036.  If, between now and
then, another one occurs, it will be global event, not determined by a
VM host.  The way you find out about leap seconds is through
networking using the NTP (or even just downloading the published list
once in a while).  VM clients typically have networking, and so
they can learn about a leap second all by themselves.

> in particular if the guest is not guaranteed to have an
> up-to-date Time Zone Database or similar.

Time zones are not connected to leap seconds.

> Also, a host may have a notion of how accurate its clock is w.r.t. the
> hosts' reference clocks.

I'm opposed to having device drivers try to claim any kind of clock
quality.  All of the clock control, servos, statistics, etc, are done
in user space, and so only user space software can generate meaningful
clock quality metrics.  Putting some kind of hand wavy values into
kernel drivers is just plain wrong IMO.

Thanks,
Richard
