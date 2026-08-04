Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAA33E345
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817632; cv=none; b=MArkTgGqIQjmP2Q4r/bmTed2BQonTVxMpp6p6ZyQGb0cefWnENysz4CZITWEZMBez6Q5raMU8PnmQdecBWWo7lLyT6VKvPfrPR/ert3IwhYkJJ/LSjYwL87y0aZR27GuSuP9lmNP4VVY+UuJiXZGMurNeWm+40Kfm97zq+lD2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817632; c=relaxed/simple;
	bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV/3dBZlWTh/mEOjvLvG7l4FFmhjgpcQ9yxmMaf5CUb9wkfwey0fi1LRud6WoW1uQvsTqyIxbt7MEg/TyiGOYvos5vvmwY/ZHiI9h3MNXc3JXHwBW1QJyjD1ji2zMj2T5hQU+fpMFyezqhteBVPoErLIPbhmOj6j/Cym6Ta6ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOp2Pzj1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOp2Pzj1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a2dcede83so5657477b3a.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817630; x=1786422430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
        b=aOp2Pzj1lchEW5FFB/Uh2z0+SjT9qtfbNDL+SJElK5h/U8gtbDrms5TeaWO7VYr2Wy
         0H09p6HjXf7jS2PjvKSkRMxLgHJ/YCY1gP979fllkJxHgAsBXU3btUb/osLyEdOzi8qc
         HhC/qV/9RpmtU7j16mzvC+bPffeHUmzV9vl/aTT+qMAkC5ibk3+clyi+193cBDz2K7jF
         qSO4rFyB7CXTFteBeC1AnPYS3pjbAhnswBpL3662tf32+1IMuPZUPWOHYihZCXbEqw9S
         PX/NsyRso862I19+4RdAQLirYwWTahEN1eHG+6TKHtSeccmOE/xIqq85Z8G2Rvcqxew+
         7MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817630; x=1786422430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AU0X1WC4BZKI6COQ7N4mxIbffSje1Q0jlS/WBmyJ8DU=;
        b=cYQoAMUclWS/ntzziDlp62gZXaYbchgnGvYq9VoC11Mm4Wvh+kgF5Q3Weyk5RtaZ38
         p0Y8PQ7LaodBUXH8uz4AY5QAawPveqN425VGlPSUEXpqUNtzc5WgTuFWf1rBQCceJGFt
         Z3bj4Mzg7PqyAJdR045oOT998vJFWHPQ/Xr6XD6wPdVZIl0pdB4TnbncOavcSySjhbUl
         lBli3KWLDTCCnNOwkVypfWQxbp86Gob+3Rrib0nCzn5tqmwtTMPDYRreXX6mhOEIUSUL
         n7lK4QfgIVS4xxpiSqSa6ei5WNO4fGdPUII+rG8h1YBn0CYk6Wy/8NnJoUd91y2QO6wb
         r0BQ==
X-Forwarded-Encrypted: i=1; AHgh+RqB50L2jH6eEPbMko658APP7p/N6AZZzIS83yJ4ys4bOGIqHCoMnM/d2opY3DrlbuVMFS7LrCl6vM09b2h2lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+8oofmexLkZoq2Vn76IoDdEnusDDYtEPFFASnV6KQvRmRlP3I
	zyGfOn546LC7y/5E9C8Efv8nWhYT5YEnVXsywbE6Buj+tZuDIuK5jlxN
X-Gm-Gg: AR+sD10OkUaoyBvpppLt59/OG8VB9suPVLVJEtnuqOtog8TkLvXbDOaWyAk7ddxR1bB
	oTVr1cLZBIzima71jdWsipQoBo6RV8Bbu7/1ytuWGjblDiXZWUdAQ83tyMMffqkQ/KESd3XCzX9
	GRL0WNxZmhUQFAv35gqZxaCzEmV8XDjbCzYmjYj/BhdqM5fRa7t0ARgr8CkyzxawoWznx0idWfu
	QXB2EfBdqQbgVlOsEbDwqqIvjti2M27+g4T7XuGfbxEZnRctGYb15mRPSwF/3bj1qfKXB3y49QH
	k2Xr0vUiiOTew8wBZJF8Zdm92Cd/aA9G6k6Kl6c0nPFSCNnpvIeDfKJczTX4rYoRtSuCNhoHD4s
	sbtmWVWI+IcKFQL38Ke8lJZKpN8uQbS24G3RGc6DI17e5wWIGOurQDSoA9njUigayf46dP3M8k/
	wAMtvLLq1oVzAI+WEbkSj/qv7OO1VvSR1xvD+zjUjcipG0ioiMdrTPTEHVi0n+gVM=
X-Received: by 2002:a05:6a00:429a:b0:848:6895:b754 with SMTP id d2e1a72fcca58-84ee482bf19mr11805742b3a.28.1785817629562;
        Mon, 03 Aug 2026 21:27:09 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc41ca4dsm4510051b3a.52.2026.08.03.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:27:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Tue,  4 Aug 2026 12:26:53 +0800
Message-Id: <20260804042653.6014-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803232008-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-3-physicalmtea@gmail.com>
 <20260803232008-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:20:48PM -0400, Michael S. Tsirkin wrote:
> You did not CCc all maintainers and lists with this patchset.
> ./scripts/get_maintainer.pl -f drivers/vhost/vsock.c
> will help find out whom to copy.

Sorry, I overlooked that. I will add the missing maintainers and lists in
the next revision. Thanks for the reminder.
