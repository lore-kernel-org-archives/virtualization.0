Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1A7D3E3
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693754; cv=none; b=eUGTUHs4ZUJrwWzzw1z5v5eJDSJjOFZitPShKr5clbZrG9dB8fPeGmOiHqkriNES5yBP7FrWK7eJHmbAJ0BKG/29QLspeLyqyt7kkcuB3SUyIOnoAAPtn8JLJR++LdesQbLf9U8qtxIR9woL9NwRPvi3qTlLHCgQ+hQ43RjFrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693754; c=relaxed/simple;
	bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2i0bbV8Gakvz+9mv4bWy4+eK1NnIsJ7fU30CJJRXYzEYYEAIUwyKt5LSEWx8qSD7xKzy2Qz49MUUYuM+PbObXOtxRglCLpKMAtVbcLCO8e+Fpkn3NMTtcu9gvjUxzC1m98x3Kyg1vLodDuFqwMO1deXy278f9dfyFbJ9e28z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBnAzEUE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBnAzEUE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso9959a12.1
        for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708693751; x=1709298551; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=fBnAzEUEbQQ1aBdmA/P2+iZNGqbrw7msYagVJnZXAEgG3T6BBsZQTCSqjALy/ksrFP
         xuZbgVxtM5eg/MBCPJ+HM+HwqGKIQb10YUXSMY3RqW894hvnxbyzrZBiqTLAm1WoQYb0
         ebOsntHb5hRPMlnYh0CzWch+XYku0YWiDG2teifC6GpFDWNgZWJOFCoaecH1+QIh445L
         fZZIf7fghIz+a71lIayem+1AInq6+NqOr8j3Kc11EjlUkJe0jLZc/dbTJq5TS//OKiTG
         i3WyL1FFg4pZqnWGS8CwqOYomweXbOhELX75NVMlpbg2Uy68rdpDn10sponD69+UlDNV
         6zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693751; x=1709298551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=aV4meFu0NmtMKCzLA61rDsISUlhdMNnJ62ZLFOCq5AI3L4sGfrjeG6U63zUzhClLqq
         8A+aOdg9tY7GqXI9I3IQhGUQcroDiQW5I7bffHnT5avATRqSFPDYay1Atw6Yu2/mF2+r
         XGOOTvptm2y6vnI3FBgqgp1pB2JQ+6YVjdsO87SJpKkHcT4u3hf1DyAHjTsoZTtoCFgS
         oM+EtGzhAgCaSPrpg8S+qy473NmxOs0n7iCDodPDLrw1PphEKoa3mvkhIFeEFzzxyyOO
         PszZHxbdt9vUzGUOmrG1sJPn5AD9Zc583LwKfkq5w1VV8MGU+To3Lgj52N/C7VygxU+Y
         2K5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYeR5Wi73CHpeHpNpUo7q/DedRVcv7PTqQsGu4v172qtju4vd2bVSfM1QeYwsVj/KMPkPOdSlyvrFQvgwOIt21UpQkOTMI2+byBUvu9UU=
X-Gm-Message-State: AOJu0YzNAXAUxDbo8mkJ8ppM4VSiJnPTz4xkefy9HQc7LZ856m/6qXlD
	6cV3f+bvSKnh1uzz0IWXtGRALGkJFAwj+DtO1hdpmclDaRPVQ7WQzzyJHnPdLNSJkj01L27j2Rx
	63+G9RmMwmkwy0qrR4oGEEp7dYcVZ2dKV6vPE
X-Google-Smtp-Source: AGHT+IFTFVekIAS/syom6ama+ratNO4vACdmLnCwK3G2sDq+DMZJbrVO0ynz19qzO8cib1qXIYaUCR67YLUqPfbyCLA=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr700687edf.6.1708693751255; Fri, 23 Feb
 2024 05:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org> <20240223115839.3572852-2-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 14:08:57 +0100
Message-ID: <CANn89iLKdX1owfY3w2Bh=E0rb0v8pJVF2Z3ZtXRE0osAVKtuQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
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
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
