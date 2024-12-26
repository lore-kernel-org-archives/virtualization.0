Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BA20EB;
	Thu, 26 Dec 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735173742; cv=none; b=ZolQssxdJPkiSAhZa+K8BnVcwLExNVZxXlTLYo29GfuJDcZhocsQl4H1wbK+AN7Rj4DzyuqmFuB2REj4dSE80/IuytSryX0j9DLKABcqWqOrzsOtuwoVVN53j85phQLz5DVvjwwfTtT2QXNmJuQ8nhkZIs7TZ8cATV9qFylY+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735173742; c=relaxed/simple;
	bh=TMTD3KOO7Bw7eUixgoeGme5wThACykG5nhmVHwj4r24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObmVxSjhaGLQFApFBILj1TtBcGRr6roDRQRY92LmqlA5V4mybjtbyTAHOSx4VA2WI+u7ZGOaud4AvFhzRkUfz9dBo/nfxgaobrQuZDNwpUgTxMoO24ZY84rcJL+KogqdK79rx416ixGP5lFw3fsub2DnfNR4DQUiFo/0TBEN4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS9BigCC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS9BigCC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d6d5765so3732932f8f.3;
        Wed, 25 Dec 2024 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735173739; x=1735778539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+tM814QAYMJ9xpVBh1o3P7ADY//NXbn+HbvIqF1jAY=;
        b=CS9BigCCK5OoTQXIPzcccohPui1lF+MQ38IUupvC2cLN7SOdOeU6A1LWsNzDuy44un
         tcg4CbcnpUJqdJ+z3+5AGqkNy5kCwRIIZ0af3kwhkggkORTLyTzEqZIRaidJNPf5EXRY
         KF67mQboatLSCTOzBiAzfkys7x3r+pkp3rj24qSKK/f6kemfSJY2V9sqb0+1FaJ9YHpH
         HveKv6IF88lx7bdzLelbDWs9H/6QUUCeHAAF/NNXmOxIyJy67NxgT+pKEK6tJqhGTqAI
         u5dX15b8DphABrHyJjHxx3MAMaIf2msFzoJhtUxBGYRDPaaPgzCsdH7kYbzPut/0hDdk
         9DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735173739; x=1735778539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+tM814QAYMJ9xpVBh1o3P7ADY//NXbn+HbvIqF1jAY=;
        b=ST14TAesY/otL70odQZKyOg5EMHrpwlkvmq1dE53XOMFVgXX/AaBydkVLJswPiDaEq
         ku/BrZru4hOPGJi0vVOjSaiBL2brHi7OmLVodu7iQzta2y2ZkvYx5v/WWckMJSN3PR/J
         Bv0VN9uVPbmKWTRmz4gBW6dGzxV2bAStI42ItCb+MZ/1iBYBJU1OmirJ7Ts18YwQNvpt
         wrKgk1Ad67LbN21J3cIxffpZfKRel+bqR9kXczbGxkV8dM30GvzBrFcshpJpNezo0i9E
         9f7wvpfB/VU05DKG3oXK6jVScBYlLt4ts4L6UBh7mq9i6r3GrE53264jnNfpjbmrBOnR
         2A4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJNY39DBZDP9ShTId0ECZs4xhWKOcuPd/5HMiPC0bwXQwi56oe2o+7snxqBqyOj+gPjX+uF3szWQxs@lists.linux.dev, AJvYcCXP8HhF+y0xRVvNcNNeQqsN7wysB8enO0tcb531rzu0UoKkj1klbqF0qlAUfuz7SJ8w27Q1XjVfkpTf6I4UEwE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzRC06kK70RCKpBpJWKkEkXUOEcKNhgUtqeWbFinFTqm9Aessf
	BAEL3TiHv7hKd0jO11oVS6Z++IuqxatV4rk5fhIRawK5dcZRXE8Y
X-Gm-Gg: ASbGncus3R8F7lWSbt6+Z6fV1aYHdDw+X0gcZqUxjYtKriUoyAjnaydl3N4QaQTvEe3
	3jtq+yJSTLmYjybZWzvo/kECNl0zwfqi3xzSTM535yE9ZevVZKvqZ2Yi+CqDqMFVKcVMUZGeC4D
	N6A192gzP5rAPkmcvYn39tbzhkmYYGTKWpBJXBCh9mIlDVHnnFVlaO9YlNp6bpknOXivQxCPtLB
	y45GbQ5mv4iqO9afvq3fJt4brGHtGl7JyQvsUM+PGFduaFxgTKNzAzThkre8tBowQDtJ4PMuwVb
	gry/tInhhuYuAmdH2E9W3hh4yRNM
X-Google-Smtp-Source: AGHT+IF79E7qNVt5omQB4N+mfTI57BdyjPEsWNaWLJn83SOWA5s9pwX8QgXP0UEnoPT1F9Ng0+UaHg==
X-Received: by 2002:a05:6000:184e:b0:385:de67:2269 with SMTP id ffacd0b85a97d-38a223ffaafmr16672215f8f.36.1735173738766;
        Wed, 25 Dec 2024 16:42:18 -0800 (PST)
Received: from hoboy.vegasvil.org (91-133-84-221.stat.cablelink.at. [91.133.84.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm248044245e9.32.2024.12.25.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 16:42:18 -0800 (PST)
Date: Wed, 25 Dec 2024 16:42:14 -0800
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
Message-ID: <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>

On Mon, Dec 23, 2024 at 07:13:46PM +0100, Peter Hilber wrote:

> The precise synchronization of the VM guest with its immediate
> environment can also be important; a VM guest may depend the decision
> about leap second smearing on its environment.

I thought that the whole point of using a VM is to isolate the guests
from each other and the host.  What you describe is a promiscuous
coupling between guest and host, and the kernel shouldn't be in
the business of supporting such behavior.

> Also, the administrative
> configuration choice may change over the lifetime of a system.

Right, which is why we should keep those choices out of kernel space.
Kernel provides mechanism, not policy.
 
> The intent is to also support (embedded) VM clients which are themselves
> not necessarily internetworked, which do not get a lot of maintenance,
> and which are not guaranteed to get an update within the typically less
> than 6 months between leap second announcement and occurrence.

Again, I don't think the kernel should be the solution to guests that
lack networking.  Instead, the place to fix the problem is at the
root, namely in the guests.

> I agree that a device driver should not determine clock quality metrics.
> The intent is that the driver forwards metrics, if such are advertised
> by the device. These metrics should describe the accuracy etc. of the
> device itself.

Overall, I don't trust devices to tell the truth about their
qualities.  But putting that aside, we would need to see some kind of
commonality in hardware implementation to advertise their metrics.
However, AFAICT there is no such industry practice on the market.

> The patch message should document this more clearly. The
> metrics can be determined e.g. by virtualization host user space
> software. The device driver would just expose the device metrics to user
> space.

Again, host user space shouldn't misuse the kernel to share random
metrics with guest user space.  Isn't there another way to share such
info from host to guest?

Thanks,
Richard
