Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73895382394
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130214; cv=pass; b=Q6XjDa9rucMtC1mfq1dIJgvz75Ot0QY/Is2ys2499iy88ZkId9Rv3tzQ061dBnBZLtCfOIyBqrfgfnWaJJg0rItvLbWaQNVAyulwxUrY5LB66NTimjC5kspVvV6I3zy0bPXdwgihYDE59IAHDsxk8EN1KoDpePl2pehz+VaAiSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130214; c=relaxed/simple;
	bh=ntjLPEYi5GRPAiZuo7cclkhEyY2tz4aKN8Y6WdSUrUE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QplcNSVOkUDviwcs3LDCZvdASbttMqtV9L9/E4uY3ALe2BoQhpoA7frhbnzb8wXkdb25/FxGqmIUqMwwpozl+expI+wHH0QjP5g1KJLxMtX87b58qSqOyWxngHBt6wQhbSXN1UmrnguM07naCibsBnIJxivmd02th/aUezjklkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTC2mDR2; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTC2mDR2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso30453905e9.3
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 11:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130212; cv=none;
        d=google.com; s=arc-20240605;
        b=I+sYfdTmwNfXgOVsp8h+WujluGF4RevePFbG1sS7vfo1rpCuxBWNN3a+CgCriozGBe
         VN5TvEPqNnqsgMtleUddK2Rrw7bZt4n3fB9SLRcfkLekvrtb0Lb+4W8m9jEu/VvAl9F3
         jHfFo4Z3qlGFJA210lmW1EyKOCAmni+77h6p+soWhDlmWUbnZyG7vdjK6JbeaLCNnzCY
         FkqcRnz9SHm9dTfCtKoKaWe4RND2I+Fu9JIYwQt3uS/OKushesw9Qp+h7MVqh9gatgP4
         Wst/w8NUBF/JmdP7BlvjRWvHcTUHZJ7WtP7qvK/22P3E0TMCfENtEffoe/fSPl1lrk/8
         BCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        fh=3hY+3mC8rw9/pOd7uUDO4ZX/uZq30dRc32juj/PyXQk=;
        b=dSAGKZR9dmMwItL3EPiMaPwQXXMLTIrttM9R2lZ38GQMf+i/LCqJIxu8zxzs3TXyCl
         hFEN0Mw0McDjIqaU5gt4+/dy8TeCbhdt+kZiOnV1ZrV7QTjDvMRshOC0RmOKkKW/0EBc
         vntniXb7gn8XJpFHkPZnI5CJdKmvCvru9Fg4iIhwIAPZIIdDgNf59eP1GifZ4p6qlUAy
         b9EwTWiSRtzk5R8r6XSnyHo6hs60+HaEhsOFJMw1PawmirdiMtNdp/ghaM610rouuIVQ
         /Mc7sEbaodJ53l2sNcXaNYX9qlA43Gr3hlkCHUeByRqPwlsH+KQafF08UrkRJFAcAMPx
         oSnQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779130212; x=1779735012; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        b=PTC2mDR24Kj/ogG4JyNXjKCIlz71UcZhD1db2WEBdT1X1PgKeN+nSR0IpIgrynnkAP
         Tu0/fn70LiULoZMKIPjrj7iuV/XObqA3MG4htoawrG6WWsy4u/NJHRvldPX+UXxubO5E
         YEsJT7DMWRFvxAGPz8ds3O6diUE28MnoGFG1h/cq1tngGbZInVV+AFZBsz29FVNb2mD1
         j5AdzNKRuKIUl8E7uYoKu8nWTiSTWqnd5kFLf6sKitQx74q0lFCd2MKJ4loIfWH30CET
         sH9GkartMf8RRx+O0HGhbWrQ7Q4UD2QHkkhVtylWfTeW6Uknsgsy2KwH8ztaAbOqzi7s
         aXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130212; x=1779735012;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqNnxkjBMmJhXWFpK+NCwtLhzLfiA5Rwy9PxwlrjgDo=;
        b=W2g1PFXcGWLnpW0owzvnOK0uM+qzyW4Ee8gmDEyPPefNxn86lIiyaFFyBb6GT3aXBb
         a3EEmlZNsjBBwso6kQGlRT/cSjFRFw82+JVe3lJOYQxIiBRI0jhtNR/vJ2II8Srjfbgi
         GxWnIYZE7lKrLrmXcOi7OLp3GZDdjJTGLrCKNOizyo4zUYyfHXGko9I5ewX8+R7ZJ92K
         OPtwxbFGBlfF36doqCzmil3kJvGBAcRab21VFOLcrkBp+WSwYU0CmePBTqZKITGmThFM
         Lrch4rEc3aeWkLs2qmLHiEHWWdQZV/2XOL6vAxelSc2/dbVdukX7RpuYAGnVWtS1C4+/
         qjSA==
X-Forwarded-Encrypted: i=1; AFNElJ+xEAsZXez7bfmrXvpEzVGXRF1Le+aq1Ynrn3bDEUXZRY9GXvRioylF+DHofKRrl5xHggLe6U5igFr16caJtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrxjCeeh9ZV9HBRanw7VTr4FdyefOAKdnboZkLwypmbOWmI06d
	e6KAnPMEksb8dJ95c0h9165wzZL0Bvg/vnStp92pcKzW+jg+A1OKk1947mQRsaMvk3DYK0r0ZrU
	HnRR+0kQaoUlxihztSPRDjATPOU7IVtI=
X-Gm-Gg: Acq92OGHyLx68n0/h5NJlVtXkSmxfXDDlURxIwIPjhzZMS7aTCzwTkgwT0M6WE0LATz
	6ukdVtXA68DnCAbCxaEvNCtm535jJGYyy3mdXaPv6296cOY9hV5b4Zv+YCJ9KUvDI77b4VmUyTK
	hr/7ZKK4V0RBlL2yvWi4kmV4O9QR5s5jZUa9pto9oxQitfKqk2wQSsCDvonDjwQNI8P8H7qXKKM
	mSu5QjIZzdS47Eu0b+NukTIhYAV5aI+mcvORmKt0iysV33HWXWp/601u1+Mn1umFlpp1Rk5z0gP
	laULYlC52BGEq6WOEqg=
X-Received: by 2002:a05:600c:3506:b0:48f:e44c:e058 with SMTP id
 5b1f17b1804b1-48fe60e13e7mr243263145e9.1.1779130211678; Mon, 18 May 2026
 11:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 02:49:58 +0800
X-Gm-Features: AVHnY4LP4WEjN53zWIvLnqiUH8Ng1-ziqjtJncIzUtEbTdyAtpzVtgYcIetns8s
Message-ID: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
Subject: iommu: iterator used after loop end in resv region insertion?
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jpb@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

While reading drivers/iommu/ I noticed two places that look
like a past the end iterator pattern. I would appreciate it
if you could take a look and let me know whether these are
real issues and whether they are worth fixing.

The first is iommu_insert_resv_region() in drivers/iommu/iommu.c
(linux-7.1-rc1, around line 873):

    list_for_each_entry(iter, regions, list) {
            if (nr->start < iter->start ||
                (nr->start == iter->start && nr->type <= iter->type))
                    break;
    }
    list_add_tail(&nr->list, &iter->list);

The second is viommu_add_resv_mem() in drivers/iommu/virtio-iommu.c
(linux-7.1-rc1, around line 523):

    list_for_each_entry(next, &vdev->resv_regions, list) {
            if (next->start > region->start)
                    break;
    }
    list_add_tail(&region->list, &next->list);

In both cases, when the loop walks all entries without break,
the iterator has gone one step past the last entry. &iter->list
then aliases the list head via container_of offset cancellation,
so the insert lands at the list tail. That is the intended
behaviour, but the access is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use dedicated
list iterator variable) and dc1acd5c946 (dlm: replace usage of
found with dedicated list iterator variable). These two sites
in drivers/iommu/ were not covered.

A candidate fix would track an explicit insert_before pointer
initialised to the list head and overwritten to &iter->list
only when the loop breaks early. The observable behaviour is
unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix to
you. Thank you for your time, and sorry for the noise if this
is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
