Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308482FE32
	for <virtualization@lists.linux-foundation.org>; Tue,  7 Nov 2023 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f90qZmkr"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 851196068B
	for <virtualization@lists.linux-foundation.org>; Tue,  7 Nov 2023 18:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 851196068B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=f90qZmkr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kis7dw2skzRO
	for <virtualization@lists.linux-foundation.org>;
	Tue,  7 Nov 2023 18:10:41 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7FA3960670
	for <virtualization@lists.linux-foundation.org>; Tue,  7 Nov 2023 18:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FA3960670
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49e15724283so2357038e0c.1
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699380640; x=1699985440; darn=lists.linux-foundation.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nu8ajIkTq/g7xASH5GKV3zLuvVnsJ4inhazORBYHxF4=;
        b=f90qZmkrbG7sRlHX67Q03EVBPY2AKUqYxmU/fse8pNqpN/zYxyhwM4jHsQGQCc9v9p
         zlQU+Xe13l4BTn4h1J2Z1HJVyyNnD32Cr/KxzMKIbmzXLMx4PPfCQ/A62Kg1H/0JFD4M
         Wtv3c92lZ/dy3Fa3CX71THe/4Hk1VhqzYdlW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380640; x=1699985440;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu8ajIkTq/g7xASH5GKV3zLuvVnsJ4inhazORBYHxF4=;
        b=hArpaEtBurgm2EFfNalmrK/bK+HJqi68T1hToNjbGvzIUG2bic+8byGMgMGF3EU0Z3
         7Pry05gz1MJJXBr3GzrtATHYGB2efAUMSw2cWJAkmRk4KJThr+skIlvVfTXSKnjoC7U5
         KRfbdKxABPlGARGNi7+DSKMoulF3OaC80uAtQ22jbxLEyzvC3PEBVxfl+Bv4+/9dm85Z
         b7fHY+x9R1BCkHrpwaigNYf7bPBPsHAZWUwTJt4NUenHs/BCnxlLwILPN6SmfEdJ0MLZ
         EfWJDZehcsbnkx4lsMvYGOAhPbb4Y9rGUTEbdZp9WjDaRl/IwdyzIpGb1J4qUpYYeW+h
         Orhw==
X-Gm-Message-State: AOJu0YxNcy/B325gEtSi2akci3qyr+qVT/2C3zvQ3ENsjZ4etQL1UHWh
	DdxLcHWBa4ffBMjU4At5SV/BSw/GiOvj4aFM1GoU7IuSRATKKXZmZB4=
X-Google-Smtp-Source: AGHT+IFQlPq19y/SiLgMKkQmPnRvOMWRb6LPlAr0tzDjSDV9A0dWGgFi6RKOAYSTsrXKrOkNYpeCg8nCJxugholOY5c=
X-Received: by 2002:a1f:ad81:0:b0:4ab:f4e6:7d7 with SMTP id
 w123-20020a1fad81000000b004abf4e607d7mr10671631vke.0.1699380639857; Tue, 07
 Nov 2023 10:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101-camouflaged-screeching-platypus-9577cb@nitro>
In-Reply-To: <20231101-camouflaged-screeching-platypus-9577cb@nitro>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 7 Nov 2023 13:10:29 -0500
Message-ID: <CAMwyc-S8e7ZGzMsMUnprb9kp22JnQJnfa32CawnMk_Nz0pTbWQ@mail.gmail.com>
Subject: Re: PSA: this list is moving to virtualization@lists.linux.dev
To: virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 14:17, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> As stated before [1], this list cannot stay on its current mailman-2 system, so I
> am proceeding with moving this list to lists.linux.dev. The current plan is to
> move it next week on November 7 around 10:30 AM PST (18:30 UTC).

This migration should be complete and this message is acting as part
of the test to make sure delivering to the old address still works.

To remind everyone:

> Here's the impact of this change:
>
> 1. *The old address will continue to work*, so any existing conversations can
>    continue and any new patches sent to the old list address will be properly
>    delivered to list subscribers. The new canonical list address will be
>    virtualization@lists.linux.dev.
>
> 2. All subscribers will be automatically moved to the new system, so no action
>    is required on anyone's part to keep their subscription.
>
> 3. The archive on https://lore.kernel.org/virtualization/ will be
>    automatically updated to track the new list address.
>
> 4. The List-ID header will change, regardless to which address the message is
>    sent:
>
>    before: List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
>     after: List-Id: <virtualization.lists.linux.dev>
>
> 5. The mailman footer will no longer be added to message bodies.
>
> 6. Subscribing and unsubscribing will be done using the mlmmj supported
>    commands, described at https://subspace.kernel.org/subscribing.html

I will follow up with a couple more test messages to ensure that
everything is functioning as expected. The archives on
lore.kernel.org/virtualization may lag a bit until they are repointed
at the new list, but no messages should be lost.

Best regards,
Konstantin
