Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A71DE8BB
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032045; cv=none; b=bwiveEmHRVdpW/vbpVyaT7tcWMV4Ol9DpKMCYQ/+jXYGRwvexcv3Vx+iPb+S79z9QS/v4QRRJbsjqfQZDFZIgH4Q3tmnh9aZTYFe/PWhhh+L/fnWPX08MK2+Xwdsj0Hg9Lv3dwwWU2zqpDbMbG16cHFtoZOdiayNslpOKfUfb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032045; c=relaxed/simple;
	bh=/smTJtfyV4jnOqCiO5F5O17FS608/jSCKpjgFAeV7QM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qFnNVFvQHy3vt2hbcXS5YBOr7Q9DW83nQMFzlL/VKFVqoWOqtMY753hm6iNV+v3zg0UDGEoverUv35yu5Zx+MgXwKbZNgIrsKnzMeJXi23IuASrVe9oxYWQtpcuol8UixwaT1ECNn51FxTBzDWGCcqgNuu+uJrfjaUYfPtfFnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/PrivTm; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/PrivTm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCD37610B9
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 12:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kiNHjqD0nbO0 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 12:54:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C589A61054
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C589A61054
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i/PrivTm
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C589A61054
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 12:54:02 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-467a6781bc8so7752061cf.2
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737032041; x=1737636841; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQMffHB5V9jp1w/KCByUeoZ7ulffBvZYTaCL6OedkWM=;
        b=i/PrivTmZRt13NRF2iOijh+3K5C6S2cBSTYSFqfA0W/bB3whsKeEw2VSjj9S/Oq1SU
         SzBus6kpYKcUCFwK4kEIXxRkYQupD/fxfAb3LVS268hyshE65mjvkNB4gfWD4fFpA/3P
         kkY9/Xh+DkjqgvMrdrw7yNaJ4jnL6SbYAh9jOVxrnRwmKUN2qGM6Qqlw5kug7GUlvdfC
         TAQeoPqFeICv7UDcQATcDEberRrEmrWjMSxZTzBcCdG2I/NmTJIT0xvy5lwyVfMd7HME
         2JDS1r4bG+VeC2voqxx1lAcQHNpCzwRu/ymCe0Gz9Y16BSNPuUekcAyVV2qbx18rT/G7
         Qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032041; x=1737636841;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQMffHB5V9jp1w/KCByUeoZ7ulffBvZYTaCL6OedkWM=;
        b=rBXJ84IFSFSLuTKApfgtn/IoEiRI55JMOs5athGbX7IoTX4ZSdBs1BBXpGki/dLGx7
         HcjBkX942nJbBbWGysTNDbbdZCtUCQIOBGmES2soBGsL61R17DvIRRQI8e7HvGrm7Rkl
         iHUn4tFi+KvmFCfzhlMRMssBdPMH6TynEo6YZ8aaXdmPkiSKy4XjDSNxs++UoXwYEraw
         MGfCPdp0PlX15y2qBgsH/w/jAAlm2glKdF2MuWMAKUcFerqRPXtncTTiNOdMO9zlseHW
         P/VD8XbZ4SM7Ev185aNVUZEIofzuaRxY8Axkx2MZ3me//wfIDyH+vJd3/J+0w6LrCYV/
         EJQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJIut6/NFkSKrolYEjw9Myd0izgu9em6uV+wW/i2cMwHnS/1qLCJu6iGWT7T/iIcX2s9z5iKVOE7tN9hJzqQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzO2F5ei5EP+Ye++bkGwpfI9efZGvWKoWI5qYzVcXTFDtB4QHFU
	fEU3D9lJleJcG/WkJS+oAkzzMkWx73+xkZ/+q6jEGqUs0Kt6zqHm
X-Gm-Gg: ASbGncvk4OKNTlrYnzTLjg3buQTHMaiZvT/2pzSNHSpzX9XqkL9gvll9xOGvYTz7Tro
	VjqjyV/pw907TaOodNk5GfadA00pZFxqSBENuGd8OQn5rS0bIFL5AdIss3tOE6RN9okkRtPFH4x
	VM80VwgrA5qN7GSV5YiUedHCLzVN8dsnWzhhxrJHNgelrAbf8zBlDhnbgkcpesk0RvQ8RJdhGxs
	2g0OZhROrpHANlSPlYcGv6SbqwfvCfHCCOmEbDq+NU1E4FA/NucRHE4oFLefpl7GZ20ESs7ei/4
	jRwkMiLPQf1+khWsTvnDGg1XO1Fe
X-Google-Smtp-Source: AGHT+IGAPwHCulVk3YA3srEPPAkpgIxRZlbJrc49E6sk7X4J2EiUFlVkp6rRmzHsvgqlARBJ+pjj/Q==
X-Received: by 2002:ac8:5705:0:b0:466:85eb:6123 with SMTP id d75a77b69052e-46c71003317mr520830751cf.22.1737032041353;
        Thu, 16 Jan 2025 04:54:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade72b59sm75303556d6.87.2025.01.16.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 04:54:00 -0800 (PST)
Date: Thu, 16 Jan 2025 07:54:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116031331-mutt-send-email-mst@kernel.org>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116031331-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
> > When I implemented virtio's hash-related features to tun/tap [1],
> > I found tun/tap does not fill the entire region reserved for the virtio
> > header, leaving some uninitialized hole in the middle of the buffer
> > after read()/recvmesg().
> > 
> > This series fills the uninitialized hole. More concretely, the
> > num_buffers field will be initialized with 1, and the other fields will
> > be inialized with 0. Setting the num_buffers field to 1 is mandated by
> > virtio 1.0 [2].
> > 
> > The change to virtio header is preceded by another change that refactors
> > tun and tap to unify their virtio-related code.
> > 
> > [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> > [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Will review. But this does not look like net material to me.
> Not really a bugfix. More like net-next.

+1. I said basically the same in v2.

Perhaps the field initialization is net material, though not
critical until hashing is merged, so not stable.

The deduplication does not belong in net.

IMHO it should all go to net-next.
