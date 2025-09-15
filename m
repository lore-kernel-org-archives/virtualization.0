Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F7296BDA
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974840; cv=none; b=V81Fwt5MuNXlsNc+L9B53v7eZASvQ/lDRVMQMoCDxYoQKFNTarQbhJDWS0Vsg7cJK+vbXHPknn2ji9tfH3bz6MZJ5LpF81mau72ZN8cIKUEY6Y/uOC7F3PvEE/Xo1ePqvOherErDrHkgWDstqcqn/9luDoEyjBi4AFD+yXnAWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974840; c=relaxed/simple;
	bh=d1A4ZSLlQNC4zFoOiM/19Q9nc4Ro68qdi9KXC/JTmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ftYU1JH+PFWvjjn12OL5WMI3pwJJ1L7e92FlXzJax+OI5yu8rn97pVu2FTeLnhuOHid5uT5Gl1JtKD3B+PaF6U7AF3wX7MmEZd/xLq3Ka1KPpLvCJs8VAfNAghKJLjpZoYUkhnf42/uW775E6pmQCKwwJc92CicQ20UMeGce04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDiSoLHO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDiSoLHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757974837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNCvg1SlA5uujYmTpj5dnM2XRiOsxEhqFlXcwCOlTYU=;
	b=ZDiSoLHOTqNlgzw/xbxj6lagsSDboUlV8dUy7tFWSfYp7rTZF3XEsYFLqsgl96slLs+s69
	5g1zwavw3DLvwzQInhiNce6m4kTh23eS+E55rYZzK870I2MNTUIQBDASCNZT17XFs1dqsp
	Oyd9Vz2k2MI0rP4fgu4L1AjDReG0tg0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-ax_9U8V6O6ms-iSuIAV90w-1; Mon, 15 Sep 2025 18:20:36 -0400
X-MC-Unique: ax_9U8V6O6ms-iSuIAV90w-1
X-Mimecast-MFC-AGG-ID: ax_9U8V6O6ms-iSuIAV90w_1757974835
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b07cc3f115aso53275866b.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974835; x=1758579635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNCvg1SlA5uujYmTpj5dnM2XRiOsxEhqFlXcwCOlTYU=;
        b=rLo+9iXcV7+icioOPslvfJ39gjzirucUPrLU8W4qdYLuWsu0DlzeUcKnjOtVTOM3tq
         WgAn9taWwMiu52YlybckmozZwjZOxJDsklyHq2a23gArs2zpQRE8CvnSuiV77NI81F+B
         8LrNhx3+FSZPZDG7McZ7nLiky/V9zV1qZdbehhbC3XOvX+soNrLD1qa28+QXnNCIeubw
         cWdUTwCueUy/mnFC7tcoM/68SiUxpErR/sEuRN7oc/23E5jO0lCQ/fppZnrGHDM25z1M
         ySH5+1LsAfT3zOmVBG3Irsd4a3G/jPx00KVoLlDQIJs57rG0IOn5CLwEl/FV9luvt3Kr
         z3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9v6aVbGWNsPNoV5HMRjy7O6OJB0Idd71TwuIBch+03iuf4/tVLlubNrvZMkTuTyqg246ikQxyjbeHd9GOnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaJXkA818PCe6OtR8Y+dRsC3fEorDjhjuL2RXd5EoGcmuFGyJt
	pPksvK+VlyDi8XN+15e6bA6Q5uMpJDIn55rFxQ7WOpHTMyXeziPueBhejKIorXgAJ9hv0MXGZ77
	CT0T8mPgfGO/GLjMur7kHPmthEDGYdt0PL9P3cF32CSSmAQFyYF5FGBjCgBaHpiOH1Aa3
X-Gm-Gg: ASbGncsFssNfDYQWv0aalTtFKd77ES30Ozs+p+VOMyJtmusKyawciTyOrKuxDVq5b4l
	kfgTqBbtNufE5y2ILW9MfWLLjRgWMqQa5wx3+nXuzSdhhd6YaocTTu6ObEoDTbxS0+XjknNReVS
	qHrd5fqiBFRrFYd7igPr7ioZ0CAaL3gxfLQjgfNE8LT3k8WqFqiszy3llIeTJ8sLJGYV/tKxorl
	CsnPWeblYJAegtt3MwtydCzeS6rlp9b2pnRV3PwiGQxBjbidXjD72RXw+rYxWm926qtABSbxfvO
	q4d29QKHwbPy+Mf1SD8jqyS7DTLf
X-Received: by 2002:a17:906:c146:b0:b13:bdf0:3b88 with SMTP id a640c23a62f3a-b13bdf03bc2mr340562066b.43.1757974834813;
        Mon, 15 Sep 2025 15:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDMmlY+A7AncdQvX7lWK2y0LwK1/e2IwXHvw4zMrKcaIUHt6jUeNuT8DB6d4WnPa6JGwjHvQ==
X-Received: by 2002:a17:906:c146:b0:b13:bdf0:3b88 with SMTP id a640c23a62f3a-b13bdf03bc2mr340560366b.43.1757974834411;
        Mon, 15 Sep 2025 15:20:34 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c2d043desm854739366b.40.2025.09.15.15.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:20:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:20:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250915182018-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <aMh_BCLJqVKe-w7-@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aMh_BCLJqVKe-w7-@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FXBHA2uOwCqT5sMfcrgfIZjIjQ1h0oMVECcMfJ1NH_0_1757974835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2025 at 02:03:00PM -0700, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Sean Christopherson wrote:
> > Michael,
> > 
> > Do you want to take this through the vhost tree?  It technically fixes a KVM
> > bug, but this obviously touches far more vhost code than KVM code, and the
> > patch that needs to go into 6.17 doesn't touch KVM at all.
> 
> Can this be squeezed into 6.17?  I know it's very late in the cycle, and that the
> KVM bug is pre-existing, but the increased impact of the bug is new in 6.17 and I
> don't want 6.17 to release without a fix.

To clarify you just mean 1/3, yes?

