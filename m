Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DC3B71D6
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697799; cv=none; b=CYa4kA57nbw3qi+hLc5Iyt3Y8aM4B4VvWI1LWgIzee5QbyGdnl/VGeq0XJL8j4gA7R6/oHnVq6wdIwUonxUuhhp4mljd6rydCWUTVZ4C+xS5SiRfE5UwbZjzx8anWNCUkzHX8i+TjG0CT7513YB1crtaLv0sdxXFvD+1wOiBKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697799; c=relaxed/simple;
	bh=mp9iwOcMguzCSNN5DUpE/a/yKBgwTN3XoKduo6Oo7tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQzJv9AqMW6Agm5DrNJURwRJGxvS0yvoj5ayY9TkQsRssARZGSptVXPlmxqYRzymhQRyXpKwtV6ehNiN/I6tl19ETgIQ6excCPK0c+P7l/c9cOc4kOlJe+af5L2qMofcJLRoAE88zVgncjIpmOkCRGs4pLMvlp78rI1QxiZjRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAzbonfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAzbonfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D01F000FF;
	Fri, 18 Sep 2026 02:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697798;
	bh=4CiRMjRojr6ANEBnN2WvoWepwKygnuPyfjcL7kwMGQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAzbonfOcVvIn8Xyi3hzvzz9J80ocRh32ocluXh2IHwj+gM852KP3Bz6YSsOrwMkj
	 VZW8EIVS5h8wy9/9wCjYkXVF5ql9LCUIM5fa1mOJWevMQhJrT3PLlHS95ytuFiym5G
	 p/fG2CPHl7LhqO/PnWBvkdR/9D24XGWnbG8ukSmovtFkoheXo7bzYbCSljKgxK7Bvv
	 2aAZIMuD7smCBxIZQKq9Edb6SycWVff6viwe3D7MBLJGt7Fsx6WQWPF0EAQg2hI7cf
	 JS0zrBG/sECjghIfaUOgTJtcEgpdwiqSVQW3b6FlyPgKbqlov9iIuZO5i3JMqm3SBD
	 feAdHFSqTEOwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918021154.1432154-2-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:16:37 +0000
Message-Id: <20260918021637.C32D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virtio: speculative UAPI capability set ID assignment
--

commit 45781e0bfdae22c4f82ae57badc273b48904b478
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments using ID 8. The commit
message notes that a matching virtio-gpu specification change is currently
in progress.

> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_=
gpu.h
> index 4f530d90058c7..3d4dfadc9d789 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VENUS 4
>  #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>  #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 8

[Severity: Medium]
Is it safe to speculatively assign a UAPI capability set ID while the virtio
specification change is still in progress?

If the virtio technical committee assigns ID 8 to a different capability set
or assigns a different ID to ROCm, the Linux kernel UAPI will permanently
diverge from the official OASIS standard, which could break interoperability
with spec-compliant hypervisors.

Should this UAPI addition wait until the specification assignment is formal=
ly
accepted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D1
