Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BD12D773
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950891; cv=none; b=Gd2bOOIIMn8CLb913ytUREzJAF6oNn2fNgpHnqVhb+pp1hsmE/bRPnT+maVCL837OI4C2HHlR8reQIOiEIIQ9ZEgKk4Gr1a2FSfky4mhjfvuZaOJ0Le/nLvPK3gUrAnlrR10f74KTzyxQy4+oyDDGAnfT7aWuyBKRVAydMH1lMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950891; c=relaxed/simple;
	bh=u57FyeN4yXEi543jN5gw5XXDtHFLHwnOdJ8bk5RideY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1vLlDjZr3NiKXP8IB6OqZ2YRrlddkbQxDdbygQTKNi4zudarWI3BkGUQ2Oo9pUsYKdiTaBBH0SD+IIxLtxOkJm6L9yPUOdwOa8zs56LHxupbUfIXbPDdwiYfSAw5TVOWDAi9XDWvxoEG+8RzSFFHk0CnGnqJ9DEVLnGjdHTLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [????] Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for
 stats fetch
Thread-Topic: [????] Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for
 stats fetch
Thread-Index: AQHawfQooceI1YM1lUOLDiZ4kyQEFrHQLNAAgAGUPLA=
Date: Fri, 21 Jun 2024 06:20:45 +0000
Message-ID: <b9f5b5f86b994729a0c408b84fc01ec2@baidu.com>
References: <20240619025529.5264-1-lirongqing@baidu.com>
 <20240620070908.2efe2048@kernel.org>
In-Reply-To: <20240620070908.2efe2048@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

> Did you by any chance use an automated tool of any sort to find this issu=
e or
> generate the fix?
>=20
> I don't think this is actually necessary here, you're in the same context=
 as the
> updater of the stats, you don't need any protection.
> You can remove u64_stats_update_begin() / end() (in net-next, there's no =
bug).
>=20
> I won't comment on implications of calling dim_update_sample() in a loop.
>=20
> Please make sure you answer my "did you use a tool" question, I'm really
> curious.


I have no tool, I find this when I investigating a DIM related issue.

Thanks


