Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268801;
	b=NxxpHUjtxdBzEO0IvrPyP1rNYIDuOlkMLoJd2QeV4Gf32nEITDpo7X9cL6iLUAEU96w/
	 ccFy+fFgIglLIfQOFXK2cesH2dYXWk4+/fo4Fylovx30bt1tdJ8IvaMybO1GMlHbkRVjV
	 3H10glcoFRMFHizRIhnymGP/RT+9UfBRPYrrWyXsM+nkass7Z7FpAxDpU6vgWVLbxBDlm
	 /Twinfy1PUUuRWX3kxsUUPddmbi7jryASKDR3EKwEUY2TtKJHlvTCuzTgmUnydLNF43H4
	 /PMQunlE/j0D/QrDXhwaBhS2f1w2872e0LMIZGrgKxH457hjwQGsaG10rcycLzU9Lxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268801;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
	b=TLl6SeqoStUV3wGF+rdgvRFPNiq5zu6q0+7KQXcbIaPNmBbu5tZ+SwJpVStMX5j4m8Mz
	 ZIthakqch8HrV7b/4Ik5eln2DQqdvrjaocX9QKg3FEM1uBYVfHNPdWi10UiDkeYeeROQQ
	 1/tqjCWhfbcqm0VOdGJbzI1FKx82N+YbO9ItKFiy9gHrtzh0IdehGgYE56A3kia0BiS23
	 cgY6EB0w4ovh0JL6Wkr5RA2j/WmAUKE/jbi3czyJ4kc1kX7VQXKFWOAZp4/ZBgC06veTX
	 L7MzaXlMpohOaVgrJMpS7iFCK9kIcrFMXDUtnElZsRp/UVz+7FOZ8Lb+mIsb29tP9Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="G/XQfEtB";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FF606A321
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 10:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/XQfEtB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793268799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
	b=G/XQfEtBXkndTUnk0epYFPFVwqNLSE5e5gBKnovUGus0JxgrbOoElfR1NenERKnqGOe94W
	yr/YZEo9CiPkZNDfnaQq5qrMpp5Oa6p6M0hwIEvKaXZ5ksLlZZTH+zYKKucZrvibuBkXSO
	5aXESFOquZyuVSTSSS1Ym2POBXfik/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-EzGlchctMTmNfWxWMM7Igw-1; Thu, 29 Oct 2026 06:13:18 -0400
X-MC-Unique: EzGlchctMTmNfWxWMM7Igw-1
X-Mimecast-MFC-AGG-ID: EzGlchctMTmNfWxWMM7Igw_1793268797
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1617493f8f.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 03:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268797; x=1793873597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
        b=WGewCNsZSTXIpoAp9YcpuLL22V+tk6+UMHbBy2pzyodtjpOoBpx6GjDvLf8uJD5RXk
         wo5VQ3OmD3s/6Cp+mu7OgEjzw5uVN+xoxhUwD0mKcU5z4PBbDX/z6q2/AJ7aUo5Ox4IN
         kLK1bmEhr51hO5t9i+AaKDc6fDcvCgfKaeROQ9z7VQx1/0A6UBxf6THr6xAV/NNfQi/r
         YH0NOtZOq0t8rz4TcDGo1ucgFS8X4LHhU8BMGmCLWh+pASTgCFJ3DmOsUEdNMgHa8+rC
         AqAB+k0A5eRTB4pRQCuzM64RFm1BP2KSZRw0ZP9lIDGD3MxatDtVEbMiNAT6UNBwzwf8
         zDig==
X-Forwarded-Encrypted: i=1; AKwUvBwviCtNF6pWNyeqylhSGOAmfol/pzQNTFnDlNzeB0mM8nvsf8FnjD+oe+kBUlKywzBNMrL0AAcLj/E2Lqg6Qw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLiSd3GKWCvTqP/ON9qyQsnMI6IDi+dicLbBuyjGhySbcTPkhO6
	pJjbp6/dWTEgLc+KhtBLzxB+lc1KHxPFA116dRbuMTJtIvEgZImRVjChQ5IDzhvC3CpaAQi/a/R
	sIAmQAQYfcs0Oz/jVdAzB/8Ja2MkaAWajLD4S73shvwrRPtlFIEdeHnBRFHzopEiZAAER
X-Gm-Gg: AYBFou2D03tCjSnALCYBCQk7sgBU1Wmj/Mtxd4ul2W52WcVWuvAnCo0C3Rzmkz7BuoE
	ngE9IE7Fc7nhIqUTStzbZlw5bhxRCMHSzrh4A1IbY9TIK4she+IWdkKpTqelBKzf3b0vNpY+0Ss
	KjGLczPOb/+PUMb2dOogAptcRKCPMgcGwuO43Q+22xYWbUtqSKKBi7ar8eJQLWhcMppWJiRJoQ7
	UVIyxRZp2kPFHPhKJig4iaDiCuToEkiQi8zAuCKmJE/zUVl5Pupu5nSEkOgcBCX1SHkNV7y5oWM
	J1grBvaDFvD4dK1L7RalmRsf8st7NphvwCD8npyPwTVcL51EmpnaBcw7J18Ug9fPxS32o3QjFsn
	yA+8OsyPux5xBIfvGPaX8dWrk01JZ1RYRk4nmmItvmOU=
X-Received: by 2002:a5d:64ee:0:b0:48e:6309:cefd with SMTP id ffacd0b85a97d-48e6309d0fbmr6302510f8f.46.1793268796717;
        Thu, 29 Oct 2026 03:13:16 -0700 (PDT)
X-Received: by 2002:a5d:64ee:0:b0:48e:6309:cefd with SMTP id ffacd0b85a97d-48e6309d0fbmr6302426f8f.46.1793268795997;
        Thu, 29 Oct 2026 03:13:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm33021365f8f.42.2026.10.29.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:13:15 -0700 (PDT)
Date: Thu, 29 Oct 2026 06:13:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Valla <francesco@valla.it>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
Message-ID: <20261029061258-mutt-send-email-mst@kernel.org>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>
 <20261029-lucky-vanilla-spider-f9cefd@quoll>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261029-lucky-vanilla-spider-f9cefd@quoll>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7uD-zhARTiXlrCSMs99wUODobC2gHGiNWToOE_CJu8Y_1793268797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2026 at 09:26:00AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 08:26:34AM +0100, Francesco Valla wrote:
> > Add myself as reviewer for spi-virtio, following the introduction of the
> > devicetree bindings for it.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5724645bf703..45a29ad08096 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -29673,6 +29673,7 @@ F:	sound/virtio/*
> >  
> >  VIRTIO SPI DRIVER
> >  M:	Haixu Cui <quic_haixcui@quicinc.com>
> 
> Please drop this email with reasoning:
> Email bounces and maintainer did not update it after changing
> employerment.
> 
> Best regards,
> Krzysztof

Makes sense, ack that.

