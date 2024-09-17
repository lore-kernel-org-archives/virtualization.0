Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B268158DDF;
	Tue, 17 Sep 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562399; cv=none; b=q6O3G4VpKOuVRpJPzpT/GOFos7t3kA/ieSgxvkc1KRDMHX3IyycEkubQ5mzzlMfDtDv+OJx6wgPMPGypq+vOgW0OvPYwoDDlv7Lf8sDNsOHGohdl62TLzJJBHmHpWoFNjEfbH9m/CoqR38VS8FMEuVKBeFz4kKPfouJLbbI/hd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562399; c=relaxed/simple;
	bh=sA8EtIddwYcbM9QidX3yPbv7FtP5KS1p37I+r9fmU2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6T56QIN85Aye3So/sUfQQ0YVRx4ULvAKCtXn1paMVTarWCdGx6c+89mJx3Tt77PQaO7TOoDOm9R9IZVQc0H2bw+D10TLHy6LnnHUl9L00tG1rHGuRBpU5kE1DkKuaFcf0AoYe8tq1MmLbCEFWKlRVsCC+w3LbHfjYbpX1cvc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msn23qj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msn23qj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1602C4CEE6;
	Tue, 17 Sep 2024 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726562399;
	bh=sA8EtIddwYcbM9QidX3yPbv7FtP5KS1p37I+r9fmU2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=msn23qj0z5WsNE7ouwUDh6Ouw+IFN0cNHR08Ijgw699Ot2RfOWiOfk4pE2zGNqeL3
	 PzVOCuOdhwmcrxcnP0RpWkVcEY2Pqh9iM6MMBrstEUA27FjN+5Jc1gIXQI0duf8Cv6
	 AUpEaZf80jl8d6mv75ZoOcE4sDAAWB931++RxhpQ91mvmmcb6sUl51gCW9ZimA7/P4
	 AZT5BNvTmBIeh7It6J9nXsgXMQeSjJg7ry4RetcpHlev7tbnQ6jE3THPuKMYl5AmM4
	 mtQeEcecg5n0IU6ENsDz8BjM+xD0XWv4tIB0a9eQFGz3iG/lrB/gsY6RDwkvWKQc5g
	 0iwp86fyCLOXw==
Message-ID: <22b91bc1410bf2a9b54b69a56075d368bf3e06d1.camel@kernel.org>
Subject: Re: [PATCH] virtio_console: fix misc probe bugs
From: Amit Shah <amit@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	virtualization@lists.linux.dev
Date: Tue, 17 Sep 2024 10:39:55 +0200
In-Reply-To: <ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>
References: 
	<ad982e975a6160ad110c623c016041311ca15b4f.1726511547.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-16 at 14:32 -0400, Michael S. Tsirkin wrote:
> This fixes the following issue discovered by code review:
>=20
> after vqs have been created, a buggy device can send an interrupt.
>=20
> A control vq callback will then try to schedule control_work which
> has
> not been initialized yet. Similarly for config interrupt.=C2=A0 Further,
> in
> and out vq callbacks invoke find_port_by_vq which attempts to take
> ports_lock which also has not been initialized.
>=20
> To fix, init all locks and work before creating vqs.
>=20
> Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature,
> support for generic ports")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Amit Shah <amit@kernel.org>

