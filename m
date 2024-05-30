Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080922EF0
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087405; cv=none; b=pZ+xlQ69SNLGIOxePei8fUrRTHoAzj0AWqofgbqJdA7N5aIgMNWV/CkXSPDbRfaw5oRger/7MAt/3nGNM0tRgFoxKGxSkOwTFxUXHUXWYaHrWsWIbIqDDDATFvf9g44to2ZSvkRXMQsCM+jBS7hw/e1kEMnPFjg4FQgfjJbztSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087405; c=relaxed/simple;
	bh=Dm0nVJ/NcIyMC9lntjlrCWDmfEEPLnVaRBi2b/vdQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q7++IUNKf8WVUPcwiwMCHZ7i6dMarPU/qCUk36bGE+5QtgLj4wz7WoGIvDxmj8s4K36OLPLSXY+D0uyX4aQmZ20LLI6FdTJsJfXMue4uGxvod1/sXSZMF9EX0bqu+djXFzC3YQT951qxdR35abByQBkNUSXp6FKwADx2HJWJnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibo5Okz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibo5Okz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717087402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j3l4Q70fl5RCpvAfo17nzmG43wS4MUrW4QcWGP7XTw=;
	b=Ibo5Okz13OesSNlchVta+FgH6bjcMhaBuOpoXkP3F42ZA878YPeXzoV16qHQ3ooMvRBwlU
	fE/E/QEe4d9ZHuyezI7VrTs7/Oxgd8m1ewOn19yJjS/v4/EGTHaZNQtzB5a2x7TUPLjk09
	O/A3J2VsdBnJfS1vq/E0eh/+g67FFeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-3lkZqVsTMhC1VCUw4B2EYg-1; Thu, 30 May 2024 12:43:21 -0400
X-MC-Unique: 3lkZqVsTMhC1VCUw4B2EYg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354f5f219e7so719724f8f.2
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087399; x=1717692199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j3l4Q70fl5RCpvAfo17nzmG43wS4MUrW4QcWGP7XTw=;
        b=oBJAAjbnbtyL2gLQwYeJ21ypku982uC7HN57uvEsc0UTUuYaW8Hbvd2a3tPmeJ/y2n
         MnpwGd/tz4G/BY3X8WXB2bPaWvQoh/Nqmkm67bObLKVwhp0g95XVGX9VR3OufdFw1rcr
         H4W3+AN4EIi5GV3ZuU/6C2dO6TlZJY94XWtvub5Mletdg++DAjoqrbNl4uwqUkPBjkyg
         5kAf3NwwW4h3ILj+Swmc7XV9IMGC3DgeTSpHzq7my/WKDMu6q3AEbwNXwBdOwiwwaisJ
         NmgAbInPKEG2UP7bDmZJl97yrOuc6FMNj+WEIlwj9d9WOW43SHUovhZCFzLYs2NpXdx4
         gTQg==
X-Forwarded-Encrypted: i=1; AJvYcCV5SM8MC9OgKgz2A3FiQVJ+DrrDMoCjPVk8X6c1iLxHh4GFP8pccJnuzOLccz7C4U6/atKfAHdXiiUe0XBDZuzmMY4PUrQ2bMJGMtv8fwE=
X-Gm-Message-State: AOJu0Yzzzw8qpYWAwYXnGaJcNP59NEZwyYLk5QWp0aqfIuKaRTsXTrye
	XBdwx4dM8vfCH5aZuhvwi2EfBx+5+o1Y4nS791l3DEr5WprgT9YlbcoZ055aHd3OQkTcROB3Hts
	eyJJtNjeOdxR0YEPAyH87P86QWb9ycpSpFZDEWqY9GQo+ylYyjmPTV2EW6k1JVcIv5/ddEPug
X-Received: by 2002:a05:6000:1743:b0:357:9f3f:6f51 with SMTP id ffacd0b85a97d-35dc0091a8cmr1579824f8f.17.1717087399492;
        Thu, 30 May 2024 09:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhfBVZuT7T29BbiPidz23C2EktcMyt/erqpkRz8qyBYxVbr+W7bD02m2L0QdU5JckYeG3Apg==
X-Received: by 2002:a05:6000:1743:b0:357:9f3f:6f51 with SMTP id ffacd0b85a97d-35dc0091a8cmr1579810f8f.17.1717087399023;
        Thu, 30 May 2024 09:43:19 -0700 (PDT)
Received: from redhat.com ([176.12.190.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35aa9d22498sm8909179f8f.0.2024.05.30.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:43:18 -0700 (PDT)
Date: Thu, 30 May 2024 12:43:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240530124132-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240516125913.GC11261@thinkpad>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> We can fix the endpoint framework limitation, but the problem lies with some
> platforms where we cannot write to vendor capability registers and still have
> IOMMU.

What exactly do you mean? Why do you need to write to vendor capability
registers?

-- 
MST

