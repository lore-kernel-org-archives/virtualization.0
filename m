Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751739BFE3
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635517; cv=none; b=ky1wBJESmn+9Xmeee6qyV9XCwvVo83qqMWoKQND+flN7sfDaWlIo3VCzHD6k4QWtSPRFvgDg6QpcF1ir+tfNvWCXdM6X8ZFaMAr/VI772lK4UfblkDrClKqHqK8znPLnVDAuGuRBk0d8UVfN4TzmLI1enQow5Y0BMYe8CfKrD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635517; c=relaxed/simple;
	bh=6RLOQdYMY9nOfPi1M3htm+Kjw3fTl7G/eiZvZC/OXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Tu+posIoTXCVAMduZ/pj+QpFYNvnVsIuWt9NL5oHIX3dGFq2PL0pwaz3g1ITtH5EesQs5xXg0cvi3/UY8z3eSglAZXLZV9OrPaUbMesMyUycefIWnz9t+mEVluZxZmwlSIFIjCnmWutrlZzYbu76Flg3v8trU0B5b/hculSpclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1NnDJQu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1NnDJQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krK5N8ZUpkA2tSzYdkTyJTPNIR/Rjakxn7OtZbYaxaw=;
	b=b1NnDJQu9HbwM2w5xqTWoZgpznbuoIvoWQdBvHyf1YixhTaISOr/COmcDusCJJa+P6iaHR
	ZDOI5bmZMbJOK7iTmzl4XdFF1qjirA2B0OGxxtLDrV17/kmlnGWhv8uu2hSJMxXAANL1GU
	a4mnXvZLuqk2XW+aXfWhWik7JsmShzs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-lqrXzzgbOL2p0GOxtPVseg-1; Wed, 08 Apr 2026 04:05:13 -0400
X-MC-Unique: lqrXzzgbOL2p0GOxtPVseg-1
X-Mimecast-MFC-AGG-ID: lqrXzzgbOL2p0GOxtPVseg_1775635513
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so6632315e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 01:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635513; x=1776240313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krK5N8ZUpkA2tSzYdkTyJTPNIR/Rjakxn7OtZbYaxaw=;
        b=RvCKFPugKHoQEmASM7Qp1DoT51a4xkDDeLnx96DCVDvQEVgm76ySp5KCu/wP8DGsOc
         aUgya2LvI+FYF/koi1XDgehLJ0jaCegU9TXAbJ/B+wJBqBJa2L37o7MKbDO37NkXgyei
         zI6lmVF73/dNm6z6FJjLmjjf6a4m/z5cTOQvkODdhSpx17ZW2hDYONQH6yoFogmcAgah
         mObhNvsdf5Rsilq3W9hekXgSfZgTIsTMGyYDWmoiU5630KJ+Il2Y7TFARaSL1Gn5Af7h
         lBhweRid/96tSXdzrY0BapwwjTw3SP3aTKHcqSa1buLYACe31iC6fUm3x7Wyhzws+gsz
         NkyA==
X-Forwarded-Encrypted: i=1; AJvYcCUdnMeLNjiOEe/bwImwhnW3z+7wDpijs80ao+Oh3VV7noRVhkeiXWGsMm+LQjbz14GtO/CMBRcCs96ex5Z/0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrQl9EVrtCkphPuE7KtVNjff+LjXbSORrIB5Ri4UT6RfNcBlyk
	66JNHUnKpcpXAWwpny8FGm6w4SG84+Lz5VKF4SThKIEt1xKF+LXosf/SPjrmUehJEyrvsa98dR4
	PSZIjKbgD4IdXB4/PTSw15efm6X01KBmG7b6c9RCp++6yqPMhYRv9ECA+XekvLPkaKUBA
X-Gm-Gg: AeBDieuEylHGALctSG3Liy9JuY7yw6c4O0GM+WejsHi7lPBZklQ/wgtHC6KpNOjlr4C
	O0erbMTF0Ai7KFvAsNDYBKNmJxQSF0fRioxs3VekNfu7URnEnEiLQYbfrRL4ancSAirC4vNn6HU
	0XcrHUH9p75r3+5xB6wkPFEzl5joglkkH5xRJ3kPPJ6Neq6gg50Q4Y87TnIrP9One5MZF3VFXN4
	Or635lx4lGENsYCpABHxp3LpnajEU5mLrU/mQ/89i7jfR0rbuLS7ixgb1/x5sJswcf3IgMh9ynk
	I83vI/Ob+X2B/rKWEpvqjHI1uFi9V/8UdlodpU6iigfcYBpJRiUps89r2LY6SK1Vj5DIOSLR1YC
	cskXAX0saqPrnpXDbDecBU9qZTZPTutKD0IiSWO6DHONlr4U8X77iNTYMQDehGs+thtk055ymjA
	==
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr265541695e9.4.1775635512669;
        Wed, 08 Apr 2026 01:05:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488996da0e3mr265540995e9.4.1775635512078;
        Wed, 08 Apr 2026 01:05:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm507702835e9.6.2026.04.08.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:05:11 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:05:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, 
	Norbert Szetei <norbert@doyensec.com>
Cc: Norbert Szetei <norbert@doyensec.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Villamil <john@doyensec.com>
Subject: Re: [PATCH v2 net] vsock: fix buffer size clamping order
Message-ID: <adYLmNh0_pT4jd1E@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
 <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
 <69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
 <20260406173702.56239557@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260406173702.56239557@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rDYGn39smJs5c-jPVK3eN6pVb4N4CK5i12J98EF-244_1775635513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Apr 06, 2026 at 05:37:02PM -0700, Jakub Kicinski wrote:
>On Mon, 6 Apr 2026 22:04:26 +0200 Norbert Szetei wrote:
>> v2: fix indentation/whitespace issues in the previous patch.
>
>This is not a correct way to submit a patch, but please wait until
>Stefano responds with any further postings.
>

I just replied to one of the patch inlined in a reply to the bug report 
suggesting some changes.

Please as Jakub suggested, send a new version with at least the Fixes 
tag, but follow the process, see 
https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

Feel free to reach me if you need any clarification.

Thanks,
Stefano

