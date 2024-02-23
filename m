Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC87AE5A
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693797; cv=none; b=cUytUXhQiF5Jt48GjiinmCphcJEi4eoFyazJrn8wCUzRGdCSIOlclh7VhlbkrLn4vYhMAP63Wg3wWHoXQYNi1A7M1LISggwoeDWisaVN5Wbp0Qs3muLdD5VI2ulqYy1XFv7KOKxM+UFFPbSqAzLKTUMpJzBuk6uhgs2nGk7zwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693797; c=relaxed/simple;
	bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EY9kiPFxObYCH4BO1PuIiQMHbBpnpU4C8YknqhExorlugdYxAfpb5UkaqyUHjdsVP4YtINXhaiblJZE4/280Nv477gYCscO8qe30uTu81ut/GB0wjEQ+24fiL+sVynhvK2pXL5NZCe30X69yis8uaQZWzOWqcqOxwgJE6jm7GBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiIzF44f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiIzF44f"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so9032a12.0
        for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708693794; x=1709298594; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
        b=WiIzF44fkyFLh3QFtPMhsR1tfsf1iRgBwDcTxjP5RRaP5H9UYqbFFzkOVaJip8Vn19
         DJDyOsP9Wu7UNi9lEcgoVd35a7N+ou+G42COnVdLI3qIQ2CgS5MHb/FttHHD+UYUD40D
         aLuhWUSJXiq0NVW4ext6c9In7bOUbI9ZlQ6Fc9BiYHw/bXJjtbWpHOL+dSLqBPt5FDJe
         sWmYYOTGgoOe3SYsBf/RhqJ5Nuvyz5q/x+8jmmSmFM7pAQ3VWRDmMXEfb37Hq8nTQcTU
         MoW0nid9oH0c2F8e2ZI+Zfc7KOMGIxvh7oQYMiLc14z5XkJlWXcXXFcAcGsP21tlbiZO
         Xsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693794; x=1709298594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
        b=AZLGruwBQntUeKTJGCVv2eoVhtOyyvSP2ReIYZHo8u0HM2z4URJaXoYZwBMFTMYHAJ
         21EkdaadN0RrpP2G5Rp0MLU5Rw0IcCBUy3POjtcgNAn+UZZbYHqcKDd8vcXtiIguni6J
         ioJp/mUWuAqxdvW6Z/838d0fbQwgi2kn7GVva9tECMKpUWzxaIsr9dZGYxuK02okQ6gB
         buD2FpHqO8nVQoH84sRPE39AThWrqHJqtw41oM2zdNCHYNnQrpDxML2WXjE86wmxVU3d
         TCqPTiM78lRs06kc4JGEbI71EiUWePcTh3WmE6yah3fbD/ri29Q+IhOj+6LN827Oer38
         MWUA==
X-Forwarded-Encrypted: i=1; AJvYcCU6LHVzr0SQsB3q6AJnnvkHSZRZ2jh1w7QKZm9qXbGXqZDWj2cwWiZk9jT+XmvjUA1GRwyx5o9p5qFLRCHUTo+MroA+rTf+tuniSpT4/+M=
X-Gm-Message-State: AOJu0Yxucdk5XtIKDhU6+ag9KPEiK6yrfmW/YZcJrtyyBR3fQHFEmWm0
	v+umqyTKcmH0z9UELqkMI8GYL6QpxeYWUPicBxTvQ3crUYIxMxP8K6b53OGvP/pWFxktraImlun
	j3jrbd4I7Fi3c/FLjkk302v3cSMP8LU07TJi5
X-Google-Smtp-Source: AGHT+IH6kjJDLjYuKL7yGfTJA6p/0TbA8WjpY+04SP7VStAo6HSfyq4kCHf2gmH9rQw+y+17XGFE5QFQvU+JtbNoI5M=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr700849edf.6.1708693794353; Fri, 23 Feb
 2024 05:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 14:09:40 +0100
Message-ID: <CANn89iLcN_EC2A0-3LaPLrevhrApM_RwMynUriGqt33FLORYbw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:58=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
>
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
>
> Remove the allocation in the vsockmon driver and leverage the network
> core allocation instead.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
