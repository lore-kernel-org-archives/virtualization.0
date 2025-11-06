Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84A2D9EE2
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411182; cv=none; b=Jd5Os1kj0gdnX9bxlnBlJy7KuCdLD2RCvXag+cudG6uFlAqxbLoLKhW+K78ncxQrFWgiVYifC5g30wtzGNAMVtsXYBk+a9Tq/lB/a2wi/4dJS+kXOGWXd19UdsTsREwlGZwN3gcpmlruChglmYT8EEDTdwjV3Y+yQCHBbtFZy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411182; c=relaxed/simple;
	bh=E4x+LJMKyj7QMubHjnE5zCDzy8wXA0k+H3NO2jCye6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSMYcIK4SY8xf1slKjOauNyo2rRQymUlH1GczP3hbZgEX/df/sHvn0dCtukMZ9vSkGqHUKjIiDKchLWF+NUayCuIm3OhAzvMZVJvzMmLlWZ6OgWbFzDOHbjSR3MdZ8AUQdyfexGUUBI+yUSj6B9nIpz0WyYDwf+XwxCbUhJL4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWft4GqT; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWft4GqT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC08361430
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 06:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNAZZ6dmajb8 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 06:39:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D074E61454
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D074E61454
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JWft4GqT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D074E61454
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762411177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4x+LJMKyj7QMubHjnE5zCDzy8wXA0k+H3NO2jCye6g=;
	b=JWft4GqTyti5gFl1CKihEF2dvp7nadrFYGxO++UfheeLrD6iGSNhuEPZUijV/PEd3tuWui
	8M4IVx7mmfnzBFHyth8cxZA3MaXBXNML+RCH4eGndSrpipKiadpdlRcUTGVsnnr0EXnBoZ
	UKmLSRWqE+BWA3aTr90wScG8hiYXsS0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-JeNo_loiN-aPSG1_WPZ5dQ-1; Thu, 06 Nov 2025 01:39:33 -0500
X-MC-Unique: JeNo_loiN-aPSG1_WPZ5dQ-1
X-Mimecast-MFC-AGG-ID: JeNo_loiN-aPSG1_WPZ5dQ_1762411173
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so10083145ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 22:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411172; x=1763015972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4x+LJMKyj7QMubHjnE5zCDzy8wXA0k+H3NO2jCye6g=;
        b=jukPsw1/+XU9g3I/cQJWIe8WH9iJCXJ/3y1eIxuns1zu3fcgLSBBPFk+SSVYXiSsbl
         rENvRtlueKZEIQ/R72ymWrpuDMQSMRi9fPK9aMyVGTsFmCsogi9RyqX2NIRMU1geTKWv
         OrYMCDqYBzO9sVU91KnNuAvZsN5kZz/IVCnpE1F7gDuoUqPO+Hiuf6mn3DM3SxOIE1Od
         yDWhWYQKbAqClkWjYB1Y5uwVivXG9FKUa2OujcCe4JbEQ3NlWBemuIPKMX94AKsLAvAL
         qHeJrXcOu72VE1Uwvz7gXhPxul4rABGPASurMPM2JHcLU8CZKd51hEQ5Sonmph5ixMQT
         oLmA==
X-Gm-Message-State: AOJu0YyYO51S98Aq1vHvnjuFIQPCtk5NNRlryCdCpKajZWCSHObrOT+Q
	y/OAI3WqJWUyLKCOHjZwfZrCKwMdq08zXPxD7P6G+6sBRLC4NDE/AwUQ+FFFpD04qCjEd+2rjWb
	0q671h9sViipJ/GJvHooPsnc5VYv3C1reUdC+JZeG1PLjIfvpC3scIqoY/klYesrsmdXCnkIIlQ
	3D2KRrbfnWzNen4DInnB41HEm8TtR+PDDXOBogj0oKD6SXpg/gS3o56Zekyw==
X-Gm-Gg: ASbGnctf5CH9twdpnNjN/AsL5uox+K+TtMFY4pczFbAIkcjWH+a/cqB0hbL70E1cQXu
	eB0kWOzNaiYYwvI41tmMQguZex0vzpV0gKOAAU2PyfIlWuDgLoWWYQCRtP5oE28puXMU5yqJapn
	mTxjyACx93+5WQyNuaiRsTO7sfiTlriN3/6ZRlmJbhkKcd44HRIEu6RKY1
X-Received: by 2002:a17:903:1a0e:b0:25c:8745:4a58 with SMTP id d9443c01a7336-2962adb2b1amr84975865ad.3.1762411172740;
        Wed, 05 Nov 2025 22:39:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpHCZn4Khbl+18x66176Duo2bWA+Ef3DI8011wII5KrSvRNlnjSB8z+M/Df+pGaeJ/6qZv9XOQ9rhUVXUNA90=
X-Received: by 2002:a17:903:1a0e:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-2962adb2b1amr84975515ad.3.1762411172333; Wed, 05 Nov 2025
 22:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251101194358.13605-1-michael.christie@oracle.com>
In-Reply-To: <20251101194358.13605-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 14:39:21 +0800
X-Gm-Features: AWmQ_bnp2Ane-TtwxK-agPWRTc9zG_WSwacf6sdblQAn0G25oEwwpTPuLhRVfWM
Message-ID: <CACGkMEs+iHO=dXNC1q1+Q7HjtQzZNUsBJ-F9Y6iK0NUV_OrKQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Fix kthread worker cgroup failure handling
To: Mike Christie <michael.christie@oracle.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com, 
	eperezma@redhat.com, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PLQdDN2W8fF8oNdw8AvkqCNjcWrXC-iqczVEPRruRF4_1762411173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 3:45=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> If we fail to attach to a cgroup we are leaking the id. This adds
> a new goto to free the id.
>
> Fixes: 7d9896e9f6d0 ("vhost: Reintroduce kthread API and add mode selecti=
on")
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

