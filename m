Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF534349CFD
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216433; cv=pass; b=INltsJYM5mckDvaV94Sanrz/aTUrd0qWZQTZXeVQvi6dJKvNIuDWfcruDJppcEJZBebe3DMF8lzhdV7u+xO+3Rid0PnjlnRaW39a9D4QKyqx8Q4tQEMiUyIIP1gVVVRoCb4QjN9ykCalXqFOICOpFajsU9+EJmAg06LOkA4BFe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216433; c=relaxed/simple;
	bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQTsYZESnJv8H/00+8rvA78munQoLztkO2evS86BYgUYEPUu1c4kKLXtXb/gTpn01IRtlJeWY+XTxOtBNZmG8DdjjMjTqZED/x7RV2jMs+VRZ4MA8OUhvCWnLOPYYC04NQqDQbTSnS+/lSaKJ1GDGamw3o9XXbGZRD6F6Emz6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZkYl8LI; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZkYl8LI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f2493c28bso53846985a.0
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792216431; cv=none;
        d=google.com; s=arc-20260327;
        b=TnyTe2doM3tErZsa2m5Q8vA78UAg5kejEho+5hBTUcQli7+/KeWI/ugtThVEX+0RaP
         3GhY7/4HyfSTuSMKk2dI5bmdhsm9xcvBOOEOsvXvD7pjtGl9B9RYGmM2T/5QyRJrkhyH
         XIBb3eDTfo+xYTkU2LKHCYJRyw76azIYsPrrolf1UOxIzAetusAUnPkLPAXhaU4Yk41x
         hzuepdXBEpz4YfUcEzM8D2AcJfmHbTa6ayjB6z2szr4tPTkg1wmvyldXPX/iZ2LDjjz0
         UZ50qM4T3O9O9r7eBoo10uXEoG9kzqikxhW7z0MZFmb9AGkhAJ/D4bkAvGqz7ts621ef
         2N8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        fh=lUWjij2hT7SshZOLVPOcWuIB9Y6KcwcN9F/cnya4KQs=;
        b=UhxP5FHJ/LD+92FbBS06DgqI0Muw/6puDmgUp6oDp0smi54/EboFoMHpWWmlK6rT9X
         PQ8ok/T7GIWyt1lQpgmqfWQABP/voElLF3rDDQYXG6/kdBOtU4QRGailFJvgucbhUj3h
         Tl43Ed38vnlnNkLWIj2h+bDXx7Up6Q6Xcs/7KvA/xQOjIbjwMVtSBqc8fLlEGrvoQ+Qm
         5MOX+uCAWZveNF4rJlUQBaq3+dlUw5y4TK5++Y9xRKxWE0TO7tjC6qRJ6UnprCL4eTeY
         GnWiLyJ5XA8XAGsU9t2O93CMRJsJ3ugC4pFiBZ+tZ64dmviGR52+ZFF1APPNvdxZc2nd
         2cBA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216431; x=1792821231; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        b=OZkYl8LItg1vGuy8FS3SbIQmYE3+9OfmkVp+6XKzV/hHRhZtGg7O3z/GiGgRXTh09W
         ZduJomo5vvSWZyOadHm+V6oaIh6ycQdrcrtzg/xUPXNmloz3IO7sJmBaa5UoFQI3JU3R
         aixTylInv6Feow4NmqlpBhbLeDv+Hurm/GJn5YxI1jAeuvWJC3cUDvGmYeKd6ZQGhc9D
         snUfUQetr/GQqgqhH1wbK77d4T3RMy3rMpFgvlVNP5T7jEcl0rg+8IWGXu1HMk0SqHRK
         AHunNxb86NlzHvtqaAhW9jIxeCJgNnsSWPzuJ7MTLYuYMMUlJRyl4anjutP6ynDX+QPy
         D0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216431; x=1792821231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMjb1DN1c9NYMfTnFwIjU5/59o0CGTCnwIETYQ97m6E=;
        b=DnpmEF4/Z0jVa1i0eTOP2DTeDeLH8XDTsMK7zgCtGYThy8YhlPiykkH90cxNNiOpCK
         EwxUeyQfltk09SfdBxL/yOdmuaJvL6wr3hXDdZEyq1tCqTNpHqZ1x2MoMeZjGxAf6jW9
         u9C7cXI/sgP7BT3JHwc7PLfw/HR+0+zMFuEtdhkkEIO6ufrGSYMP8W0nSsO75CtC3kKY
         sqGdF1KOd1TzSU4KEl+1pT2pbwTu6uR8D33JsJwkNSrLjbfl0w0t2QfeINUuSxAAMybV
         PBqCwJsjMeaAgp3yO0m/XyeUjKOSRdUwg3sMZML0AZFx3Tsry6WEdWLA12npMXJIl6Rt
         YXug==
X-Forwarded-Encrypted: i=1; AKwUvBwsoZWTyK6jC3z5HO/Be3XeGG3a8bA3OI6b2YmZFgHYZXLu9rQrSXeX2MeQ+oMFJ9kOmqXi7mDJqDADDQDOWw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLbL8vJ9ReefbOMhSYcye7gNiaHHov6D3exM4xeSuTipuEtxzFZ
	VrF85/7r/+kmeOuaydlg1C/d2alwZksW7BdWjhwXJB5/hyZEZpUgVfrKu6ZQ7RHGu//Y6qoOD8y
	KNvKpCZEnblEtsK7mAmuE442SiqPlIDk=
X-Gm-Gg: AYBFou3YPpxB1kyPP9CJ1iP51fgrYvjAyPwnd2Ayrx/GVNDe0haqwUM4wJ9MIzXs0x0
	YNj5QV2jeCkedC+p1iaCR20P/UEUwRiwc9yCrYgbwTl7oCWF4x8DsgA9vIuRoUwiZaMG4LLNCh9
	8zHrUI2UmpKoxT2EXUMjkMRlb4JE/NguIC+DDwxuXyYq8bTZsgGq/C1CbVpuknxnz/gDdVBmqLA
	PiRoe2QVuKy+4OTnp5Hq81xxTZ4WNeWoYOsDAp/fWefncGQEWAWIlGskC2YZoCkhT6nVYLpsjNL
	bct4ksZbMfA514wsuHKcBf2M/vVlCF90bcfk8x0tRJUyprLzbeEkk9DPRiIlGq560vcDPlWK6+L
	/2/9mZU2J0G9Ima8zE66wtC52ViRtpXwxQlQSsDFOdj3CqRnVfvvZR6qMzI2SAJp8NPaqR2g/dQ
	9G9cv3vkVnwSeIGT9aPGdnTGbaPmFqqMFegu50HLX0Bpn2W8uT1Q4fyBp89iNPtLwtSs8YY4cle
	lRHwAW+x6IQaxL4QNOBdDcyBb9aJYGzOgZ1vU4=
X-Received: by 2002:a05:620a:172c:b0:93e:4c1b:a06d with SMTP id
 af79cd13be357-93f29ceeee8mr338896485a.20.1792216430650; Fri, 16 Oct 2026
 22:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
 <20261016195543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261016195543-mutt-send-email-mst@kernel.org>
From: Megane Hebo <hebomegane@gmail.com>
Date: Sat, 17 Oct 2026 14:53:39 +0900
X-Gm-Features: AclHuK9NL3_LmZEX0uf5XgY1amfOyPlOtQf6woeYIGrlG47Kw2f7yV0Y8I__kFU
Message-ID: <CAJPVW+kRtMJVtgd2r_1mX_ih5EDruNfYgY5U2j7eXAsrHkJj2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: validate csum_start before
 installing partial state
To: mst@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	willemdebruijn.kernel@gmail.com, habte.yibelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Your objection to my previous patch was right: since the packet was
dropped, the reorder had no observable benefit. I dropped that
approach.

Reading your v2 series, I think the stronger invariant is simpler:
make packet semantics stable at ingress before later protocol
processing can observe two meanings. I wrote a small kselftest
follow-up for the three outcomes and will send it separately.

My broader side idea is just to make repeated reuse of an observed
attack capability progressively more expensive. One speculative
mechanism is a minimal ancestry "scar" that transformations cannot
silently erase. I assume that is too stateful and out of scope here,
so I am not proposing it for your series.

I have also shared that broader defensive idea with a few relevant
organizations because it may be useful beyond this bug; I do not claim
to know the final architecture.Your objection to my previous patch was
right: since the packet was dropped, the reorder had no observable
benefit. I dropped that approach.

Reading your v2 series, I think the stronger invariant is simpler:
make packet semantics stable at ingress before later protocol
processing can observe two meanings. I wrote a small kselftest
follow-up for the three outcomes and will send it separately.

My broader side idea is just to make repeated reuse of an observed
attack capability progressively more expensive. One speculative
mechanism is a minimal ancestry =E2=80=9Cscar=E2=80=9D that transformations=
 cannot
silently erase. I assume that is too stateful and out of scope here,
so I am not proposing it for your series.

I have also shared that broader defensive idea with a few relevant
organizations because it may be useful beyond this bug; I do not claim
to know the final architecture.
