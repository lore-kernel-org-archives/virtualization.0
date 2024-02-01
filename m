Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E815A495
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776834; cv=none; b=UbQda1N8AF0VOWTWHkE2epVqIB+rag/+bWG3BcJuZ8QwkHxsKOljGjexq/7iHwcbjU6sIhHlHEPuri3cA/y+o2+EEjwtv8K2+pnaY7DZnRZNKYgdWYqp98ByGcp2UCsthJCaZUkNWItytKxc0+q2irnGCvnIhODNukjofe9PKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776834; c=relaxed/simple;
	bh=g/4tx/iCm+9BQCzD37jmIjXm4y79gZgnlOQOTDWikuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LwXUXs2TkS1sgA2eoA/byz9ykcoX73+gzFcIdEMs/MnyWvMuL53CkCyMcupKgNgwoiTckP8HOazjEN2uL3FBBi/Rwq1VOO/epMVwNGnXHMkPqr5IMVOQQzDxV0ovibmBzaRxU0syd885ya6shQOm4c8hpmo902/zwK4yzYq2NTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUPsQ48h; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUPsQ48h"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1B6D84665
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 08:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1B6D84665
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IUPsQ48h
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uaa1ydNP24h
	for <virtualization@lists.linux-foundation.org>;
	Thu,  1 Feb 2024 08:40:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A23784653
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 08:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A23784653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706776829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkCWV8fSLAWGNlqsa3ptZDoOlPO4LQfFc4U980Ufp9o=;
	b=IUPsQ48h61gNADIHaB5tj8Kop7ojkBNQg1V5BOBgIw42ThmchB5usjXZinizFKiVUHbJBo
	wqwy/dUOLJ8+yWlO3GDu1ku2N5tUyCcFjlBQp2RzbLvBnWXxaJw0eQTIZb4kc02blbaCka
	4aDx8OZXDc6xR+Rz2zbFihG3ynrrCso=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-uoMi9gu4NAK0BJK_APSzow-1; Thu, 01 Feb 2024 03:40:28 -0500
X-MC-Unique: uoMi9gu4NAK0BJK_APSzow-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so508523a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 01 Feb 2024 00:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776827; x=1707381627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkCWV8fSLAWGNlqsa3ptZDoOlPO4LQfFc4U980Ufp9o=;
        b=OQYKka4IJyzRvO46OejgQbU/zS9wA/SbgCeeHh/PaZkz6vEUXozD+uCvwQiHTcW0OB
         8P1M6kn5CEWkuAZKY2/6iv+yF873IUGBpqLcSaZUF+MeGj0FUNV489eaAirv2DjrjuKH
         lOkp/boKe4mT3RKrjhiEfT9bFWnuYpx7mfqgfbHXmmVKOK9qqVFlo6KkDMfN/VEyvTZw
         pF74wo1g3NlJ6ckI6bnypRsrBF+hRDWscHEpCn1vJBD+MUjPBktC2Zx/tYRuK3tjfUMw
         UE8gcSQQ+m517emozqxtqiHvoltWpx21SYRkP1+DsCtAfSgmqC30FGCTp1hONoAJ5jhK
         Kt9w==
X-Gm-Message-State: AOJu0YwCcwQJ0iHZNkQldF5Qxo9fRL8l7lmiO5humSNpyefL8syCzW1L
	ir10SFUSkZBHCr66P+CMWyeGucM/nI+mY74A5xtueS67WzkA2V78vmHEet5M6tNkjzpYDdEIrrV
	02Bz6tp2VyOLFXBE6xErju2+FM5gkaP9ehV4iasFXqoeMihbjgU8gssBhh4MCmJBWqnHcuZYvMd
	Zv4zQ=
X-Received: by 2002:a05:6402:78e:b0:55f:b005:57a1 with SMTP id d14-20020a056402078e00b0055fb00557a1mr921726edy.14.1706776827116;
        Thu, 01 Feb 2024 00:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3laig23HZp6DIctLuen5OfD+zRgqhxYlNkBm+KfjgIZsHa9+TW/k+knOlKqs1FFbXTidJIA==
X-Received: by 2002:a05:6402:78e:b0:55f:b005:57a1 with SMTP id d14-20020a056402078e00b0055fb00557a1mr921717edy.14.1706776826783;
        Thu, 01 Feb 2024 00:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcztGWraZMER6rtyXPMrjri/yLOA+nNhAIaQjhxNq4V3DQmtGwQmKvy1Sq3yLWUb9+E452thkCmnJRv7HMyoG7qK0LxCNyEMrfcY7YsTIEey+dTpyzoFAA49rZRad6CxrZY05vhNnUtEueihXszQlw0doocp65I1Wwo14ze40hEbZN3BDYyJAEzOAuFL5n3k5gdfAmJmqx93mHB/d8a1+pTKa4nuHRXiy2aeereNLhCbE+ofeh9BmiWXyFZX4gtWoVsjw3w45sJjn1+4FODuNLa6C/bkN+GFs=
Received: from redhat.com ([2a02:14f:179:3a6d:f252:c632:3893:a2ef])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c791000000b0055f283314e1sm2998692eds.43.2024.02.01.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:40:26 -0800 (PST)
Date: Thu, 1 Feb 2024 03:40:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, david.marchand@redhat.com,
	lulu@redhat.com
Subject: Re: [PATCH v7 0/3] vduse: add support for networking devices
Message-ID: <20240201033944-mutt-send-email-mst@kernel.org>
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
 <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f25f3c31-c793-4743-a587-0e2063dc2d65@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 09:34:11AM +0100, Maxime Coquelin wrote:
> Hi Jason,
> 
> It looks like all patches got acked by you.
> Any blocker to queue the series for next release?
> 
> Thanks,
> Maxime

I think it's good enough at this point. Will put it in
linux-next shortly.

