Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E661CAB3
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934538; cv=none; b=Mog2kS8DEk0WqjzDu64ahOHlzi9pFumdoXCqX5is4GO4PjnI5c9WKdD2Xcv+vTjnE2moB6NNtjTK2gWq6qIK21dWuMU7i8VDiRkVGzTX1xQRMhRoQlW1B1pY3qOYo07r17rFUdpE/2iKiaMye0UKcqSJu1eQ047wysozPJtYTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934538; c=relaxed/simple;
	bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPs4ioSbjZs2I+Zh4WtQ6NtaORtuEBSaVMAKXcJuQD0shxV4QSRjZPlrAXXHuTOVlmdifVEUoUpr3PsQ235nPQUXACiZpRQ/Rm7x8/LrHapJb58fHzuBrFJWO8IYgn9sklGva/f0w3sdGbNBSCBljDwbV6WGlnYYjQZp8TkzVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoxgmLa1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoxgmLa1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765934534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
	b=AoxgmLa17vi6xK8SLuVOCiqDhiBK5KzDR+WLkqri3PFf9u1YgK7q18iOe7EpvL9gwuBxP4
	QVWNPJkP4HcPtTkV7vwar2A41CpZeQngica4jk9fTjv+LirdysxmysvN1hmM5kAgDqgoP4
	bBjoJliNCNNMJiTzUDJBGfoWJuRaNX4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467--jFzoRiSNzOZ568DiwL8Zw-1; Tue, 16 Dec 2025 20:22:13 -0500
X-MC-Unique: -jFzoRiSNzOZ568DiwL8Zw-1
X-Mimecast-MFC-AGG-ID: -jFzoRiSNzOZ568DiwL8Zw_1765934532
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c904a1168so5531279a91.1
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 17:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765934532; x=1766539332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
        b=gY/0a3MJrzZcF2aC9G04/TZkysMCsODLFiT9pMh++wsGUM/NZ1UXBAK1MaYyxmPBRv
         QVATWttG34ZyF7ziV8HX9xZfiMEb2ud1ITYt6TxnABNVNBRsgSZCMM+QPd8Zb8DOmjnh
         CVusQMQPydliNo6LKrlacpN4SVCqwa9fHXdfRoU3Jq0eAzcgL60tSm6a4tBJ2TToLUCP
         rsmdlnCSurK7yQHINP0xpe/ZsPScAPVFOfB9gbrex8eFJLTayKQ1cMn004ArrJBnWfdf
         kQZIHK/ZgBDRB8ks3kJdgEpYNfRCW2Gx2jDuXUS8RCMghY8+XUKJ4SyuyVwQY39rEvV9
         qPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8+8zsW2PYwIt7N2GYTIvp/sIMtTusPhsAhC/yaXAk+G+VG30yIwqGFHu4CPfhSwfk+yO3vkP3+9DeL9B/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDzwK8u97Qp2Qz31Cx3gCnGwQdEf81PuvIb16yiVx0tJW08mM6
	FAGFJCOTZos/sL9FEVoVS2xhKPdhrOlGDjMJjG0gQxHQXbk9j5z6p2/+dFRO+x48k5Rh/y/K3hV
	1q2V1mwnolXiqCSTwaWji/rgcCip/CcQzTQsICgk2LGW3djScG81YTp9XdpxEcHqL+cWJ8tbTcz
	eqDHxnVe5/wu3nZHRWlJM+6z6THge9DPUR5tYDY6yWa44=
X-Gm-Gg: AY/fxX4lo65NvSuAyZrqqmAFClhdYNbIVomGZLviUIjmk/Dg6UWx5TIzVsWLvUsCGET
	tGgE/u730XnhREbwfNCETiRyUuLyMqjUxAfvZlZopqdtHFnar9oNk3mq+YhU3e3vWPI9OowqG2i
	I4OEz9/IRk9RN7B1qwToykQk1Giap6UYdMk1rweUiA3w6oLh9JtzOQyhp6WoNSekZPNg==
X-Received: by 2002:a17:90b:1345:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-34cfe5731d8mr891201a91.34.1765934532502;
        Tue, 16 Dec 2025 17:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2Qj1MjAZsaJatY38cVNtUzo65vJvXXqfgYjDc1M1txBuTCxEU1f06oaF/Mba6iW1H5lOe2BX+sqswTaGgyuE=
X-Received: by 2002:a17:90b:1345:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-34cfe5731d8mr891185a91.34.1765934532113; Tue, 16 Dec 2025
 17:22:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251216175918.544641-1-kshankar@marvell.com>
In-Reply-To: <20251216175918.544641-1-kshankar@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Dec 2025 09:22:00 +0800
X-Gm-Features: AQt7F2p59SvA8jqbLDZpsRBclL2mVEfHsYjkaUO7M68_TRk-7vqIcAO9BWf3AVs
Message-ID: <CACGkMEvgA-A=aZc06kc1o68Em8AeXmWPeRa-S=ziqWencpSk3Q@mail.gmail.com>
Subject: Re: [PATCH net-next ] vdpa: fix caching attributes of MMIO regions by
 setting them explicitly
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux.dev, 
	eperezma@redhat.com, kvm@vger.kernel.org, jerinj@marvell.com, 
	ndabilpuram@marvell.com, schalla@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1q1ZjAJkLXQxldGPQUzwLE9BL0udtzfWHQcVPEdlvQI_1765934532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:59=E2=80=AFAM Kommula Shiva Shankar
<kshankar@marvell.com> wrote:
>
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
>
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.
>
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, I think this should go with Michael's vhost tree.

Thanks

