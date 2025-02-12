Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3660271828;
	Wed, 12 Feb 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362474; cv=none; b=MAcq854jN5kS3Qkimo+cm2z/wHlnaDuxzFJpU+0mNz+kfQbEm2tyhAJVbkWvQzq4cBLw6+VjlOYUKasJJYOlmhd1Rsj9pWNQvlocxYgOiGLlGSzFHb0DM/X6IiBLfXMAaEeNSqGyja40JN7aurYVzGaU+E/agdhdm8Sq4ebSSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362474; c=relaxed/simple;
	bh=8w67IvdnCJouPhy6jKHPyJZ9UV+ATFoPmD/iXb8EI4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upavpt18ZmOChLO0ySndQLPX5X2BIo9Cg8Ergoq6DygE1D3y3zsPi/4ZD8c+60L07BOiXfbIuEYw3ypQ0uxRYwIygp6CfZ3fWhSwov4xDNTSFOrikpZWZyiqGyktlNw7wgR0UxdGb+uFYiGW4DyGBsA3CavpqeZRMX8nsLXlT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIkeIoQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIkeIoQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB01C4CEDF;
	Wed, 12 Feb 2025 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739362473;
	bh=8w67IvdnCJouPhy6jKHPyJZ9UV+ATFoPmD/iXb8EI4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RIkeIoQGL20vye961PFtOAlRnapPOx9l9+9XhKisexERl5daeSaW9hS63jwnCwZvS
	 elDfQtTZzif2s/tAwqSY5OK0Uj7QxOkECAv+E3SE736HPZL7sAgN87xtOOccPYGoKV
	 hBgT4pnPsc3O/12HH37YuawoX+uci7M0TDZoLwpyItTqDKFx3jSN1+EgrUXt7nRhJT
	 DSmQm/sSoEgGlhknP2t9Ju4WrLSlaxbp9sMpzOSFPs3uWcJ+NlEyHi9bflsS1ffp5u
	 Qxk/w4QCiPJFX1/QuWtMeuQvJ0GjOrl7SKiFBd8aoxNzTM12ouBUlYC7frwJ9GPkkp
	 PFjsvhRB5nwzA==
Message-ID: <17ad6782ac79c3ca6b403c220b2794adb6e8ad78.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Use str_yes_no() helper in
 port_debugfs_show()
From: Amit Shah <amit@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 13:14:30 +0100
In-Reply-To: <20250212114841.74650-2-thorsten.blum@linux.dev>
References: <20250212114841.74650-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2025-02-12 at 12:48 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> =C2=A0drivers/char/virtio_console.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Amit Shah <amit@kernel.org>

