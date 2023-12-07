Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5D37B;
	Thu,  7 Dec 2023 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSLju+4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10411C433C8;
	Thu,  7 Dec 2023 03:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701918942;
	bh=SRAZz73xZ/wQzq9LmH5D7EgARdnZgItIkeFCCGRI57E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSLju+4eEJeIUkqF6JDwTQfuLhzmDJ3EawX3T13ddxPpFum1+fPbsj9nN606wV3Mq
	 i9fFZsr1jJtPLFJNEBZz4TSt7+0iMaPrlnhPsLXKTaMRuk17aZaO+Xjbh0r7MKa/F4
	 PiIH69Ri+ANuMK62qJSvqZjqDCCS9PtCMGtT8zcdxxb20oB1v5wc/DBO0yiVpeXBst
	 TLQIuVhMPSr0RjbRX8EWaqJCX4ZR0hYyOXcBq2USAcsHg5Nhm8CKxAe04C5MAIt5zP
	 JKlDkDFzKEPewUkcECvkdDBN0H/53XREjVLSBABKEG/VUThI5J8G349GXQk+Z7+6Ce
	 ixELhIZx2p/cw==
Date: Wed, 6 Dec 2023 19:15:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, <kvm@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: Re: [PATCH net-next 2/6] page_frag: unify gfp bit for order 3 page
 allocation
Message-ID: <20231206191539.06d955f3@kernel.org>
In-Reply-To: <20231205113444.63015-3-linyunsheng@huawei.com>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
	<20231205113444.63015-3-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 19:34:40 +0800 Yunsheng Lin wrote:
> __GFP_DIRECT_RECLAIM is xor'd to avoid
> direct reclaim in skb_page_frag_refill(), but it is not
> xor'd in __page_frag_cache_refill().

xor is not the same thing as masking a bit off.
The patch itself LGTM.
