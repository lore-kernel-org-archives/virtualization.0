Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D081D2F67
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782600; cv=none; b=FasqbeRp8r5MoJ2bq+LsBni2M5nYHt7RwPKFbmSCpg+dsnz7Wfb9CS6p7e5NnooWE7wUn0DYL1s5XicNlH/2vGNcfM2lg0K0aiOvtT/IaY5Be7V/2XvAsio0nQwlAhlKIVia6QFk2nrqk3/rb15jJ4DZPYpaEs0St9DHupOMq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782600; c=relaxed/simple;
	bh=X8QcjerdXUVJM0M6K25kjjudFG+vmIr5pWvEHt8N2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Qv5zxYcsdqUu3TvG6+G3XWMiYOwWeFbdR3sA/MD9EG9hCkv1tyK4NwhhkcRJX3VPhfPRFZOAgXexQiaNdExQwDs/yU8plEkbR3uPO5PgEnI3SxmxowzUGKYTj4dMN6k3lIJy3BbcWn82a798/w56jZefiuAhg2Znw6XyofHAfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAWbSply; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAWbSply"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 179E740A15
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 18:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JKQfh3leXxP for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 18:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D3B4540240
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3B4540240
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAWbSply
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D3B4540240
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724782596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
	b=HAWbSplyNrpeIEgf2zP07+t0ix/WDNJlPtOuvgEa5ulDYPiMkT1eTdxCi6eJ8Skp+mpxKa
	ZevXnnUNa5Ejd+701HRM26ylOY466mffgmBTGiXrHQHpVUoYgPnfzb0JrrNih3dw8NY/dZ
	uEUBX7qi0zOw0LdiR8BBLAFN+0/Kqf0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Bv2uB8dVM-mWx2RhHRvWCw-1; Tue, 27 Aug 2024 14:16:35 -0400
X-MC-Unique: Bv2uB8dVM-mWx2RhHRvWCw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7d2d414949so530104566b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782594; x=1725387394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
        b=igoV5ANo8hzrbWhmshuTAGnSDDtr9Na/3PZPYHMDaV8N1DC4oTU9F0X4erOmM+P1CL
         9H6daaXshbXV3A3boglKcBu/eJpjBc67qZgw3RSVTrlbm2+M1K7c5TgoTfb6K4pCgVDb
         7kJ8SpzVYgxMZNnn6CL99gpsxl+VudnlThJxzCR8tof86/4hkiowVBrhcV780NkK0Pf6
         EaMZ83TnycYaFMyDBsIUN72G2aTifg0XEcST1f9aj3q/FC3d/NP3l42D1DCvzvAy2sEx
         dk/gqnLHYpUxiWNEm6rf9cbMfAI1Vq9I08uSCbvMpBvZ0gE3sPeJOPMqilv1Qc/OdKxU
         4TiQ==
X-Gm-Message-State: AOJu0Yz7h8HaLbuz/NeQhOFtlalSP0fW1lYeHyOMy3BzJvGC3QVuTJfB
	EM5V1wOKOVbJjCaUT8K8kQ1nNlp66FpVnpZvNb8Xg2P3AtJQ/yKVe9jguuTn4eVb6/uQklEJyXX
	QYA/3QQA1W2xVlt8EYQ0mJKTkPv+o5E8CNKpjGBbcrXJmVq7n8/Xq1ozYN6Be+lqIG8Rjt40DJV
	4cnAk=
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241758366b.64.1724782593694;
        Tue, 27 Aug 2024 11:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDe3VluilgSG0vcrrqRKifn4o56qtamsjzIVVNpfdjfRpMszxTYEqVcY4D+Wi8k/eikH1ig==
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241756666b.64.1724782592949;
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Received: from redhat.com ([2.55.185.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588b39asm138757166b.159.2024.08.27.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:16:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] vDPA: Trying to make sense of config data
Message-ID: <20240827141529-mutt-send-email-mst@kernel.org>
References: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
 <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 23, 2024 at 09:51:24AM -0500, Carlos Bilbao wrote:
> Hello again, 
> 
> Answering my own question:
> 
> https://elixir.bootlin.com/linux/v6.10.2/source/include/uapi/linux/virtio_net.h#L92
> 
> Thanks, Carlos

Right. kernel.org would be the official source for that header.
Or if you want it in english, that would be the virtio spec.

-- 
MST

