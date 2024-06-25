Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07514830E
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304383; cv=none; b=bTwBt3xpm0Q+doDYv4wE8037oBSaSp/gtztpJA34PN9UAyFnkRNYi75v1QvyUfTtuVJCbeqMDiNr6mVWSgq9tDbjTFWcmb6OVjCZw4T0WEWfuEpYN+7m9edXBK1Y8W73G+rR5y1dAIbkkfeFcfVNMX1s+RzFWg3m5XFZRe6dmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304383; c=relaxed/simple;
	bh=RWnZq6/e1o8ODqj7cwxxBBd2E4goPZtqioAyVQQcqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=suzMaRQYnjhFk/LP/H+V3F8HX22kdHzjojfB3Q23UR7m+A42eq5hhtoIgfXvAqkStEGEnpQTvnkQgpuy968E3IvkhOu1aMkjINUVjU+1580z1ftu5j93U7vD9NsJrJZe+1cBTd9mVnhF3GO7YJjIKN0Q4q9vuNDJgHC9qAYYsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBBzqV10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBBzqV10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719304380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
	b=NBBzqV10niWXFNqnRPiEn6Fjl0Mcm1BP9VboLs2p+YpbE6EWn5lHYq/hUFstEjohuuku5B
	sEtYWJDa+xYRTMdK/xD+Dg1005+KQ0kbrH2ROrJO6cuNF+PgVRtsHe8senPwptc4u5bb3C
	jceRSltouw6+axnP/RLS3aDkIRhOTCo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-O2qgbBA2PT6kAPxV8FzuHA-1; Tue, 25 Jun 2024 04:32:52 -0400
X-MC-Unique: O2qgbBA2PT6kAPxV8FzuHA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7251ca4d3dso106164666b.2
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304371; x=1719909171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmuQcBhqdbQliLKyKkeXS3WXDCp2XThxY79yU+S5CmA=;
        b=HpS78JspK4lDo2SJiZz4DzNHp0YIzQnq2S4pnuxNTB2AGG+4dROo6HAQ6CI/1KiZm4
         4YHI8b+TQ03Mu8esps91AIgS/4x5AMyzCUzr5xfgxyu85cjPbJXfeCQX7yHqytRXIAfV
         Kt1cm8uD9gmJBh6QDDBO04y3nShdoWqS/yXPS4JOqHjNFdFgxQow/Vux9SwFqBqnYnZo
         ARX69ek04DVhXbVcRy/B+69q7sJBa95nsNsM4LJ/7ZH8PcT8IxjFnCpKf7w8H8dSANFy
         63Z4DP3LQrC6m9JES3wmjQoFG/0wCcmyKuoFgGTHzhgHwPRi1Z032GFLdPTgoWcG+v3+
         Vk2A==
X-Forwarded-Encrypted: i=1; AJvYcCXdUhPPRtLakl5V83PFlbviHUH/zO5xcTFf/isD6zCP3Snsveo7vt83rqNXzILGXa31tZ4pS2CxZTdE1RrM5CVdftKPnoZ9PSoyagJX+TQ=
X-Gm-Message-State: AOJu0YyzbznNzJ9h9tnYXEWQc2TvMPC5ezt/VPRB1LA0boCrSs3LUG8B
	PLYWREQMcGbpe38/NZOAEtw7szavlsMtVglFbDSGsGD7lNhLM24VoX8+HzNgS5FOMowBTqA3q/F
	ZitNE++BMBNaQUVvosO/1hJv3+QYvusalmJkgAiZkL65bnHU2JVL1QDkweAjjPtb2
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300909266b.10.1719304371440;
        Tue, 25 Jun 2024 01:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGLvgEEpYliYHX2+LzsnrTLSKm1BWp3FNYDFymgqiF0mmHfghVSDUyJ+9zJAMv1pBABF97A==
X-Received: by 2002:a17:907:a4c8:b0:a72:5fd5:ea02 with SMTP id a640c23a62f3a-a725fd5ec00mr300906066b.10.1719304370721;
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe779bc80sm366832266b.174.2024.06.25.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:32:50 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:32:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625043206-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
 <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > Workqueue is used to serialize those so we won't lose any change.
> >
> > So we don't need to re-read then?
> >
> 
> We might have to re-read but I don't get why it is a problem for us.
> 
> Thanks

I don't think each ethtool command should force a full config read,
is what I mean. Only do it if really needed.

-- 
MST

