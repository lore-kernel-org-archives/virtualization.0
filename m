Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFED1AB6F1
	for <virtualization@lists.linux.dev>; Wed,  1 Oct 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332217; cv=none; b=ss7WjrFUlN77IvDhL5/bxys/Q7JNroeZy4PpDCH76GIn53XJpCi09t/CcW0EJ+gRa13XaMtgb2H6aJGFYAGgLls/bxMQhUjBchTAl0CStpbFLOzeVb0PG3rrf7icRfsCO7+gyLrmiOX9QJFMWkGUWT4dD1ZobLoqO0uzrrBd3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332217; c=relaxed/simple;
	bh=iBktchbTFIkQVIZCHXu3rzcyooPQa8aMp3zZsKHXgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J9B/Z53Ey0sTH41aZug9rudEyxKRZLx5V2YoviejB4giqA9hkwBgy1Xnu0M6zbIYE6NAizJaB8BB/eXcPm4YT6o9+dNWnxCk46j0JhMsJ0rpXpqBTJQ/TxKV540RoqHzeZRl1NiSUrjrhAD7aEjpSh3yKErM1uNH4ZEmyexvJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLQz5Z2Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLQz5Z2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
	b=RLQz5Z2ZmlYt+wLzkAwPydlWigwm6m/9ftAS3s143C3kIG3bYAuRWyTqz4Jso7FzE4iFUr
	AvkTnE7tzOptfTT4NxZVHT/wwmlSOyL+nyv2FwhtFWkCX8uQ5e72vIJ9Hrnubb7UaU0jrX
	kT+8LgvJHqaSNV8Wt6hRGbwkVwSJdOg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-GfH4lJfDNk6HrLNoirsc-A-1; Wed, 01 Oct 2025 11:23:33 -0400
X-MC-Unique: GfH4lJfDNk6HrLNoirsc-A-1
X-Mimecast-MFC-AGG-ID: GfH4lJfDNk6HrLNoirsc-A_1759332212
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so904678f8f.1
        for <virtualization@lists.linux.dev>; Wed, 01 Oct 2025 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332212; x=1759937012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
        b=waXBGkNUDBhKxF8fCSWLN2paqfbJFw2tGsNy4KKD9BZrqtPpOAZn31jaXk7WEgmgzA
         MdCl7cTJ/cIaT6CGUOrYj0OfGkiuXbDLXN/XFvgapRnzZycZSU8b94ghJICXVMpKG+KW
         a+ONRcyyd3MUN+httvlifyrFIkkFugZyweKkR8yzZSDUX+wwTa8rSCLBLSN4cjD10tTE
         T/1Nqtiqxh92BofIGUZCial/6atwLC4rq5lZip59CqKDfLm91saigqYAD28wgguRtydI
         YxOAzGzqUdWA3u7N0sbEggX88IzA2sZNz9A/KEJrpt9YKf/6E4nkyMhf4iq8ZdCJYGhD
         /WCA==
X-Forwarded-Encrypted: i=1; AJvYcCVagFartNSy5owZvQkO+t/7HId3IgWcx+QcGNF0maCMMlYbHl4qVIG/jQpmFMPRUTTP3upUfdd5gAwskAcxcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTbfldGgfCkKPUnGDbskJThLvGsxXAq0V/D8YnlYRKD9fSQ/fy
	rWQkneZjBgW1hY6GyjoBF2hu02T+rkfIIZ4UGrciqvgf6g1K6TYAx0YTVdCntMVSnag/hTF2hRN
	LUC6MoQqLh4wzCGhDeR2LFSFmMoTVs7bEBrRenr7fijC/Z1jzfQ+KGsdG9pKCvN2/3skM
X-Gm-Gg: ASbGncvnv6aANmvyd1v/coWPobNTMDgYh5K+Dovh39vzlbD45msWpk3DsJMEBOCSVks
	0Z2X9+mufOWsBc0cA7o8jsAvfGe5HN3FYqW72q8wexGegfIxPUATreCJLtpRX0Jv+Sn2csTUcB8
	g1zZviI9jWCR9u/jNaUDPlNV4pUaSGfSwJVAoGtEji+aAtSyU7W6Zr17rQ59mlJZ7Nr5q8uqUrz
	NcgLugcGxrUvaOv2Nw8+aqGR0MUbl7RxgP1flr0cGugQuJSMCHknBGBekhUAfUjkc4xc/GFggkX
	qrBXbyj7U4nbNNV3X9X3vMw6vn42ZQOTE8bIsAaUIpYFVXiJRIcHrAjmIa6+RyT2swIBREkqHOF
	g3NTgn69smw==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217860f8f.30.1759332211733;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0F9XwtcVPf6wB/WoKqvKR5BovvccvzXbrj2loiPZ9rqJZd0tUbtbAeri7VVwEh087dav6lw==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217838f8f.30.1759332211348;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm29483495f8f.54.2025.10.01.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Date: Wed, 1 Oct 2025 17:23:29 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me, francesco@valla.it
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aN1HcWZ4Q1lV+FdP@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2243144.yiUUSuA9gR@fedora.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MKuOSfWNiKIONoyaAW5z3u2zsLMpT-LnAaLpYZdpR0Q_1759332212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> Hello Mikhail, Harald,
> 
> hoping there will be a v6 of this patch soon, a few comments:
> 

I am thinking to send a v6 that addresses all the comments soon. 


Matias

