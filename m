Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C539346FCF
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597444; cv=none; b=rGoPW0ABMwrf/LxrahQW12ihsvtDejOYdI6C/xUHQ6RUPiy+FYz9DU2wgRX8Y00yWNDK0VX1iPUbX2Vwl4w0Q9WDyLJsmW7jLhv77VDfaia4AVcT8YwnDVaEXM7m5aFqcav73T12FbczbxQrIKwSC/5Zr/EoxYB+dw1qi3jjr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597444; c=relaxed/simple;
	bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi8nbZo6X48WrpiDzWQUe7YbfVzndDQ18+8/0DkxDASsMjZc99leBYi3LF/H5KUqd6N+7Kdc2qAoXFvfalWZZPPlBfCmWJWM8ImKmfn3rB9IuObibo7TZZuYJCad+KFIlGxhMKP7ZOsfUGxRNBCqjridyYeRhIZg19IkdSZtMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNgR6oYB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNgR6oYB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9f316d68so25855075ad.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597442; x=1779202242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
        b=iNgR6oYBfEH06bnpWbtdSpkXtm89NLBlJPSA2rs3wDaYF/db6UcXIXEcnj7BUYFMe7
         WZH+wAVdIk0MhSrtKugGOTuohD1GHXV0i9ZRIqSiNcl00tsvftcS9ysH40j4LlKAWmGP
         5uAyvrbtM/Vl6r3LS3bkpODB+VrKh6fSBP4jqm7upLy5juL/KjGbgAspcVzHpe/j9j9Z
         P81h8Fx4Bfux8XY8M6Lkl4o2VRzX0ZJ1iDVXfKFG3mtz+T6BXETjZD61Pud/QNEEfhWv
         7kYRk6uB9ytxrkjO1e1bwIgLZPyqb9B2lUI4y1MHxCNEOCsqFqcjqSD15Jt0PJX2K+4k
         MWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597442; x=1779202242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
        b=KXysOuu+jfvYUMDUoMHL0LfloNDTcOunNe5HTbNkOFBjbj6TPVS9YTs+bQ57eEp811
         exadm5VjbhmKxWFbes+5leZNtZ59UBBlp9yB6S/Vlrtz4hYHdgzv0WmEAdJbQ7W1uPbs
         1j9CblOUlPCkxArQpPeYPlRMgYY74d7E7QBfWPHXUQsXF4jawshMgFbSOQq9IbRV9Cmr
         eX4g6jZiULkNxlGuBWCVzRMOE1ZpQpiYipCdF+yEr71KNYsgMf1lN+2P5eyD5xU9VOSz
         f3SkJLxpdvt7J5v8FCu1TAWyknPiCJXruL+5wwAewxwFHGDsDSuXt4AW4cjkq24S6bdP
         /e2w==
X-Forwarded-Encrypted: i=1; AFNElJ/pn7XS62kJqYWyLp04Cy8zdB15wyG3G7NrAadS2ZsT71e70bvkmLwfOP+fw4AGUlv4Otj7x49+Kd3+xQ8CWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTZHwDp4lp4jQLGdzsYXUbb7VmPVP7P2HwisVyR1gv/07XBLmx
	88JFXakSyrrLr0G1RuaX56/DDSg/33xiPSrf+/gaa8UENPOiA17dakiF
X-Gm-Gg: Acq92OFuiICZuvkV0WB9FphKjM5pS0D+WxcQirFeF/SwuY79BmXZRtNdf40LvTFJUEX
	G0rBNP9ZOGe9wpfo5Olgv251Qpfx/EZVl2rJ+X6nsYs+8iK09K+KkN+wasHRdd78toVXS83oetv
	9n0mQdFxuCp14pZA3e/IP8YSUi+0sYJlbd8rqVIO6IJemrQcrin85QnrsOMwesz+N2FFREWMmaL
	T5R+p55ulVIhI4rohbfcblgUZng18l3cmL/A/xipQyV7w0UMiStAzBxHHQtU7Ayex+dt1hcCEfF
	tfP6ZlA6IjByAgFD7dydMQZBUG+P0fJjJNnN9Wo+BSW4w3cAiOUbvUPhXKlJmdWMY0CmITi3M2G
	2IuevQUhGKtMhEKpdiQLKcLWjk1QLPR6loZoKugYP9dEdlwAb+7C03xJgH8+UbW03OZddjCb5lP
	5Kjz0Hi2nnSsUXyD1kTy/Q8n1jARKWO+mdu2I1IScyWWmuNBjz
X-Received: by 2002:a17:903:1aae:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2ba795bdee7mr304729035ad.28.1778597441578;
        Tue, 12 May 2026 07:50:41 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ba2sm146193705ad.50.2026.05.12.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:50:41 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: fedorov.nikita@h-partners.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [RFC PATCH v3 3/7] hq-spinlock: add contention detection
Date: Tue, 12 May 2026 14:49:08 +0000
Message-ID: <20260512144908.610907-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260415164459.2904963-4-fedorov.nikita@h-partners.com>
References: <20260415164459.2904963-4-fedorov.nikita@h-partners.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I may be missing something, but this patch adds
`update_counters_qspinlock()` for remote handoff accounting.

I tried commenting it out locally, and the kernel still built successfully
with `CONFIG_HQSPINLOCKS=y` and `CONFIG_HQSPINLOCKS_DEBUG=y`. I also could
not find a call site for it in the series, so it looks like this helper may
currently be unreferenced.

Is it still needed, or was the call site possibly missed in this RFC version?

Cheers,
Hong
