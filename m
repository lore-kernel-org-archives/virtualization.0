Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58520E310;
	Thu, 27 Mar 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072027; cv=none; b=NUsUdTtSWVWpplWM1PumvtxZ1GAkszVCYIJaGHLypumLrTcNrI+E29OAT0TpTIVXmEkd47OQ4ytkRSsqMKT1iQB8OvJfTWvWD9aeCuUiDiPuCRFGgOiRO9E+80m7tIHYCm3W3q5ppNqG9+Gctey2Dx7Mi1XacE46i5/ecxowdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072027; c=relaxed/simple;
	bh=R5uSfPG75bIjjQmDqbEriw6O5j13LyNRualMSzqC5LU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlfgxDCy6WIVCJeSdOl8pcPZTGnz4G6O6JknxXu7wWE3ZVtxCHNG57Ua26F0fdpTI2gWwkuoFSQPtRvHMbat+du6wZKzR05jnwZWG6DbVETivBDgF2jJMfjRmoWRINgGdCZ+xDR9SFZ6gNVnwUEo6jO2CrtN+wrpTW18xPoriPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJXW8xH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJXW8xH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA485C4CEDD;
	Thu, 27 Mar 2025 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743072027;
	bh=R5uSfPG75bIjjQmDqbEriw6O5j13LyNRualMSzqC5LU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=oJXW8xH42Go/WeLzvmT40kHZLbNj0o8lBIx2aA8Sr3GsS1VyXA5kp2xwBdIM2hMOC
	 fXqiX51n2dRqcfk3FFkotexkiU9e8sHc4kPWqP0jTx0dGwESv2O9nIVLowpObhO6A6
	 HoIWnjtFGQgK19TC+S7PoAAwmMO3/j4VC9UIOnCCGXinKa2saZmqauk7xb4or5o/+Z
	 +p/zJ8bhbcn5KoaZr+Yun/7EDfKP7mo2asHU7NkyZyC7Q/91S3TepvX30aCLk/tDYl
	 Fj8q6XFegWuVx7n42FgbrLOp+USJt6BAQXP3BU+odtUMdehSqOu/PuG8rsEXuXi0Ow
	 bDerF265JDl+w==
Message-ID: <7e0faada2dd5576a41509e94bbe49a97af5173dc.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Make resize control event handling
 compliant with spec
From: Amit Shah <amit@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 mst@redhat.com, 	pasic@linux.ibm.com, schnelle@linux.ibm.com
Date: Thu, 27 Mar 2025 11:40:23 +0100
In-Reply-To: <20250320172654.624657-1-maxbr@linux.ibm.com>
References: <20250320172654.624657-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-03-20 at 18:26 +0100, Maximilian Immanuel Brandtner wrote:
> According to section 5.3.6.2 of the virtio spec a control buffer with
> the event VIRITO_CONSOLE_RESIZE is followed by a
> virtio_console_resize
> struct containing 2 little endian 16bit integerts cols,rows. The
> kernel
> implementation assums native endianness (which results in mangled
> values
> on big endian architectures)(a seperate patch by Halil Pasic will
> deal with
> that issue) and swaps the ordering of columns and rows.
> This patch changes the ordering of rows and columns to columns then
> rows.

It's clearer and cleaner to only describe the issue you're solving
here; the other patch will take care of the other issue.

You can add more info here, like: the console resize messages via the
config space (section 5.3.4) are used for resizing, and that works fine
for single-console devices.  However, for multi-console devices
(enabled by multiport) had the spec and Linux implementation out of
sync.  As far as I know, there are no device-side implementations of
mutiport console, so patching Linux is the way to go.  (You can replace
the 'I' with my name as the maintainer there.)

> Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along
> with resize control message")
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> Cc: stable@vger.kernel.org=C2=A0# v2.6.35+
> ---
> =C2=A0drivers/char/virtio_console.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 24442485e73e..9668e89873cf 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> virtio_device *vdev,
> =C2=A0		break;
> =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> =C2=A0		struct {
> -			__u16 rows;
> =C2=A0			__u16 cols;
> +			__u16 rows;
> =C2=A0		} size;
> =C2=A0
> =C2=A0		if (!is_console_port(port))


Thanks,

		Amit
