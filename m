Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02175C96;
	Wed, 22 Oct 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095029; cv=none; b=seyxEIs8jxwBxOkSGI1EtrlkDFEwPUbJdAIRszE3821YD8W5PMLAVE9DAw+94fyxhpj3Il15GwE2KLnfmXj5QVZvl1av6HjcVhCNJtmcekRpkoUgSvpWI7WeR/y94yWuV0ONdQeODBXni/X2rJeE3KlaiH/zNojvOcSglrMly1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095029; c=relaxed/simple;
	bh=OpMA0/9oAABJIYywTiyokiqjgPxdO7YtYPB8cGTro78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSC6joENYmzIUpDE47rTUvBw1AfGBbkMU193DwQNl9Kds0EJSum2EkFOURVsQzeSFWUfXZ/3UepJ2zQGHf69Y0H7P9/aCVbRbxGrFJvSiYqJAo/T0km3yQPFlHQuCogb4YRRgqUwZaCf5eevlPknAvm4gkSmM/8x9meXSYoZaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSFpifbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSFpifbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4EAC4CEF1;
	Wed, 22 Oct 2025 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761095029;
	bh=OpMA0/9oAABJIYywTiyokiqjgPxdO7YtYPB8cGTro78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSFpifbEasbVizf5V3L+2KexanyFQzbtMZbuq1jID6FIIOpVK3LUZLcwNkdppbUfX
	 KyLZt5A1mWA8+tMC4qhQG3ccj+DqFq5FDiWKnCfw/BqSffd6Q3GcCpQPrWyppEVZgt
	 fEiVydz2yGP/8nXF0gpqrdCtOVVkhFrickGHoNnFGLswugZP26omm9ZPTIGEqSCKnU
	 ySvF5uR+tyclSU2n9Ndn3J8WAcC5FZDL9cXvuGOydUp5f0CyzNs+gy4hcaiFKHL82/
	 j/rZ5EpSy1mOkV5UCVIfXHEUdkQuZBtwfFtQmD7o+ctsQWGS327B4vqY7Kd4p3kWba
	 IeN2GAkgTIwdg==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 01/23] vmw_balloon: adjust BALLOON_DEFLATE when deflating while migrating
Date: Tue, 21 Oct 2025 18:03:44 -0700
Message-ID: <20251022010345.120425-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021125929.377194-2-david@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 14:59:06 +0200 David Hildenbrand <david@redhat.com> wrote:

> When we're effectively deflating the balloon while migrating a page
> because inflating the new page failed, we're not adjusting
> BALLOON_DEFLATE.
> 
> Let's do that. This is a preparation for factoring out this handling to
> the core code, making it work in a similar way first.
> 
> As this (deflating while migrating because of inflation error) is a
> corner case that I don't really expect to happen in practice
> and the stats are not that crucial, this likely doesn't classify as a fix.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
