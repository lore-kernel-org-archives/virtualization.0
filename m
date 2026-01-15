Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC03C1FE7;
	Thu, 15 Jan 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502950; cv=none; b=M2EBBz6MUefe5PFTma6iTWvKDlU3sHhZs7mazfIA/UwFZiM666HK1GKk6E9Jc7uzR3xjGiu9OA0NNW/LSPxjeFoqaeqT+nmxtwtEwMyo3lp6WyT7Icqv1Y9GPo7zPhySSLN2kDsWAH69AE0XaspDXxqjltn3vXvqofOBqnRG170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502950; c=relaxed/simple;
	bh=WCyzLTExsBoIYI4mj69MYgmS8ij3mWHLUriLEtCRl4Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stCxqVtnXANq9New9e0Pl4WJUHm3uDKbWRACkvJb/3SnVP1puICMgwvgG4IoR70yxPXcQFiAP59EdNKShilClzjH0Q2q3QInRTECVFlti0a7iHkMiMKs41k8vIMWMyDmwvNKEqpVkb5fIxTt0w2zt6W0CnyG/NV40LXAIStE3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OMPqv3Vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OMPqv3Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B856C16AAE;
	Thu, 15 Jan 2026 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768502948;
	bh=WCyzLTExsBoIYI4mj69MYgmS8ij3mWHLUriLEtCRl4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OMPqv3Vb6igzQ6J6yeedeDADZNmSJcTS/NqTR8QuaY0arE+RdTkkZ/LG6Br1CzeEc
	 Mldf/qb9ciqHrV3QcrtBfcSw8RKoikT5GffwGbIKz9eJUZ4C9P9tbXXEIBzHqM4A/n
	 eT+/3C1vuKZsdshnSo1UGFdGeRhce11EHD9zLCSI=
Date: Thu, 15 Jan 2026 10:49:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Zi Yan
 <ziy@nvidia.com>
Subject: Re: [PATCH v2 00/23] mm: balloon infrastructure cleanups
Message-Id: <20260115104907.96d2aac4de42dce12d6064d9@linux-foundation.org>
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 10:19:50 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> I started with wanting to remove the dependency of the balloon
> infrastructure on the page lock, but ended up performing various other
> cleanups, some of which I had on my todo list for years.
> 
> This series heavily cleans up and simplifies our balloon infrastructure,
> including our balloon page migration functionality.

Thanks, I'll add this.  Again, I'll suppress the ensuing 528 emails.

Sigh, I do worry that the ongoing email deluge is training people to
ignore addition of things to mm.git.  Maybe more emails like this one
is the way to address this.
