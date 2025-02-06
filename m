Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B48F13C816;
	Thu,  6 Feb 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855052; cv=none; b=RTqdYEC27D4Jaxjwfu5Lhvg/CQ7yK50vw2GVToUOK+7Ag95SaivAFU5NS0yOD9UcSKX06Ja22eGk1xN0bAFFXFPVOqrR1HN+qv0vxx7wN2NpcQ3pujtJgF8SNNOlXsNKtIN/zK/TF3sKix1UXhYF9bTqLvkBqPSUfvm1XwWnUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855052; c=relaxed/simple;
	bh=GLeHLJ4dTP7E8iZuxbVL1Lx//H3fKAthDU+RMMxQi9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4OmmlgWFpjM7wRUlgNUwuO8Slc89mMIzIgk3TqCgVC7OFBOImJ6NIl7nNOUrXzO/xoNeXQ5R3fjjJdRVXHFJt6IStJlq9e03jMO+wWAqjN3hSRE4/YuvrpYjID+KXiXkvLxKQ2TAdfqClcwUlOOVxGrh6MiwOgyQ0N7IXLWRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq5wBN7X; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq5wBN7X"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ac799015so762965276.0;
        Thu, 06 Feb 2025 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738855049; x=1739459849; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLeHLJ4dTP7E8iZuxbVL1Lx//H3fKAthDU+RMMxQi9I=;
        b=Zq5wBN7XfsMSD4lBko+wtP+Ktq+Bn98nLBj02Fo/leu+d55CCype7C2lm5j6kCxXY9
         0Dm/h+5ylpbGR85XRMXEGH2G0lEw3o4RtLzeKLG/Y1G6NxoK2sdM+GvCpRXZmp4FKkMF
         /8FnQS1qCH+zPaJL0ld3vkJNdwQfIdQ08tV45ODBN99m3fHgkJMcCUTj3eAsx20SYnVn
         HL+j9elHeLbVefWslC9NP7MLRExs7VtvvQVcFvLelrN04DkP2su3jnTxFXMWr4ywSmPn
         rKAv0aLl1DFRL5xdZNZSyM3WXw0WCjgPpmynY6A6nbYXIDn3VIcoX+5q+uLFUCCFm0bc
         y9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855049; x=1739459849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLeHLJ4dTP7E8iZuxbVL1Lx//H3fKAthDU+RMMxQi9I=;
        b=JudZr4+tx13k7wndNMn+bgQE/Ws2zA/82ICiSBsaX2GLqO9W/dpposAU/yrP6Lfl72
         9n3jwMytpTNX5PunxexUHnw/mQUwnJzun7fd8yGLgPcGSsEBfaZRtrjTT11ukGu0hhL6
         f0YGqAetvQiTgpDxwiz4jQZfeETm33aNypzXkfIKShZys/RaytnT7crUpA/IdB3bXJdf
         GrOqNxfvnr0Siwb1oB+V2NrjxS5F0YkoY5mOLUhSuTnyiWiOICsWncKbyw/K3LiyGvrz
         ki2neGruyrc/5eIFOn0FOtuajzq+091FulivqEsMktBlIJAa8h2Kuk98sW5VclHYlw/4
         0CHA==
X-Forwarded-Encrypted: i=1; AJvYcCUZRfgpePPSumgl7iFboPxNeyI4isTUWqvk7/0BOAf+VGdV7nwZAwXvUIQoL0bYdihnxaRQGQ==@lists.linux.dev, AJvYcCX1wM2cTZeEdW5Uw7brvLp4+GkmJgjqMiq9ujXcgFJIwmuqa3CbFqfKIu0cPeoa2W7m16PbRKA5Vikj8PivoI0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwV905AoquPRm9k6ufkZte9ZX4CfJpRRJNsB6UVN4L1iGSSDPxk
	ljhAOBk+3wJuY7gS1437B0zBtGto+wY7xpPG7x2ZySSn70CBj+IsyRxCkjmCvVS+0XHT4QTMPCC
	qUOeaYaEjtqDfl7ZL3h07sutAJJ8=
X-Gm-Gg: ASbGnct5anHV2k+/BPF0LCNK1nUf8ZfMNLo4XViWGy9knspaVdS3n5qnRT6ejo3H0cw
	Pv04dUYn3n1rbZdGtBKa3aU4RUBkKJXWsc/95dw2uE3VEE8RKZVYfr6MN93m4zCSkDcHJMKK1VQ
	==
X-Google-Smtp-Source: AGHT+IGMAk7h1l+VLuXpBW9KdulzM/beZO9YobXDgKF7w4a7gcBwfC19sP3jRcJt5I6wjLwOWd9tlWLXouwVhAPTRoo=
X-Received: by 2002:a05:6902:1610:b0:e5a:e6eb:d43f with SMTP id
 3f1490d57ef6-e5b25bd8578mr7254506276.39.1738855049274; Thu, 06 Feb 2025
 07:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250125-virtgpu-mixed-page-size-v2-1-c40c555cf276@gmail.com> <2f3394a5-0c63-49bf-bc85-f43388050ab8@collabora.com>
In-Reply-To: <2f3394a5-0c63-49bf-bc85-f43388050ab8@collabora.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Thu, 6 Feb 2025 16:17:18 +0100
X-Gm-Features: AWEUYZmak8RYbRBdTfGCYVsVD52QCFajpZoD8KmZtk7U4DxgRQTHDHmLd0XqdII
Message-ID: <CAMT+MTQrKWzNfsUqiDawCv=s84XOvUGwsrv34aqmZ6rR482OqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Align host mapping request to maximum
 platform page size
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 15:40, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> Otherwise, the proper solution would be to pass info about host's page
> size to guest using extended virtio protocol.

It is not fully clear to me, as to what exactly is meant by that.
IIUC, virtio is a spec managed externally, so does that mean
that i should write to the virtio people to add the relevant bits
to the specification?
