Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9F39CCFE;
	Thu,  1 Oct 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857171; cv=none; b=HnSkyu062NPx0kzFXbHgjRpJqrxvqtaUankSzJSiVWMsAKf/xrsnYm7qY4dNHYVsQLfktAuC7F0+2ewDtxhJ+fo1We+MY1qNepOG1wUEnr/Gq+7tRZ7wkcRnkcuNwSyHcPG8v9bS/+p9RnMl4RQgQRYckiztzSMeScxeOq12/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857171; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8mbcjUDH4WM9+SD2NAQI/8h20n04kbzWRRjVBYvaSvqNIyuOBXvnisi8vD4xa6sNB0rEfR5hU/9ZLpTziiXsYZcg3TNPB8u09WHKLILtxgWy/F7Ptr0MZ3dNZBmWHMziZr7J6GyBuQ9THXBSCqVDWWgSpvergMBKZjqqZVKsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyFSZjTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyFSZjTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4881F000FF;
	Thu,  1 Oct 2026 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857169;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EyFSZjTMaC4BT02n5Chn+UwLM3nWI0PM/4h/DxrmAjas47bjROfw4LLbZhDMkZS8W
	 YXUJVR5iICzEqg3+EwbVuLvM5/UbJTfCbfgOtTI82zTOQVX5zTkNo7ljg3ptgR187i
	 fErz8t10wHMvc1dV0rCpvId22sawD88c6sZIfBppa/9WIbUVArJM7O0GuYP0vCUXoF
	 tlmwqEDXtc+8QeI1ZXhgQ1pHRe72tQ8a7Fom4ke2FfB8ZCwIAp7deI6qU2Qj8h6rUZ
	 dHSofLcDMBnQoxhg2oA1FCYwgabhA5i68cNIlypPXZBwDZhpyzV9n1fBAJ3xtBkFSX
	 8TpCW743gm+tQ==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu, 01 Oct 2026 12:19:28 +0000
Message-ID: <179085716831.31693.13222203434770065965@kernel.org>
In-Reply-To: <20261001121541.2983379-1-4ncienth@gmail.com>
References: <20261001121541.2983379-1-4ncienth@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
