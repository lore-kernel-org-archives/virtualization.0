Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CA202C48
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878004; cv=none; b=u5kw0qJ5bJ3kyKqcqmn8Zjc4DYMZsmpbhtD7tcTXG+ikvgDT2/yAFKjTvJIqvBWnonETjbypPlq0XMhVUpu0jztRHfv4++dL/NUBllXeRUfxI+4KSeloes9c+BwqGJQm30l34NKlUGF4qA6zYNZX/gU0elbsVIN+MWYn9rcaRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878004; c=relaxed/simple;
	bh=7YEkuFyM7GV9199Q9Cdwe7iIO8q9KIPqtZTf+2Ow1j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClG7e6gr1xVxRkmpox69x4LXwxvJ0zGBMvWWzQLxkPl9DdOAs3F6IG2k5UoEOLoHsGoouYpnraC9VPPztxsO+K4ZY9jnIyjF9IrHnFLMuDfKpbYM0Md9FV7Uxzw+VBU7wNoIAPauZq7RiWX1h19uC30Fej+XEwkKQouwdkEoSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HNXy25l2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HNXy25l2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3402942e79cso2389969a91.2
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761877998; x=1762482798; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbPYQDjulAXBG5F+f0kqq2MBzbj3aqWGdDjqqCk9C80=;
        b=HNXy25l26rdNk+epU156Ysd82oKzhuhZLUQxAa64IvGHeeaFAJylezFvyYi0hQFE4W
         KJ3BGCZGLkOsnIY7SvW6bBJh9KpTcZT5nlx5hozX7865VrRIPtoWEzNG6jJh38pjGk7f
         VhIEdre/d9UGl4Hb2VeSVpxbzigLz50AEh6chJNqzorqYaE6uJUrUNgl0PLnTd+W3ot/
         Lm3m4u51CwkybeduPd4AaEq3bSMwrTThEMemgC3jx5hfXwG0gBx8wOnaWeXfH2CwtGQ7
         5BvTiL9Yt/4arGMPCns+pP8eefOo6PGSjvsBStUrwii5A78wrUv4ST3Bo6ShuxfUNTKR
         YD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877998; x=1762482798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbPYQDjulAXBG5F+f0kqq2MBzbj3aqWGdDjqqCk9C80=;
        b=TEpw2o+nCMjmfutESXSqxbJbx/nvh/OdeHFWQQM5Km0CuX2k0abQOi+ofsQ+9oWADm
         CkVSaBnJ73eCG15IhpQUqbBRNXmAen+w3JOimCPz+GLSkuoBySix1Nf2jC56hi4iszq8
         o+zrX0dbWF2q5o/+GY4WlDj397tz/bEKVyXNRwgUdI7BZ5PhP/unF/pBk47+1VrxDNqK
         09Tl8Y2G9tbcJIdyUE/0FOrs659/ll26vnbg43ArSsFsNp34evQVXBYnKPhjtA9/+tkG
         F9r/espdnSuqOS9Ff/Rud2GeVXchsf29WaqD/E+RsUAzWoonpFSj0J0vVrQEjREyUVLg
         KOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiOmpiMPgETu0OJiiJTeoJrypri7fdiY2Syqa6ZKd+uRrebgD6vkn7z+BR5sqnkLqWb8fbawMCVP2NOWepWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ3T07QqB+DqIpWPw8mInBgrvvSoApQ9HzwwyNvmnFBNBViiMw
	1fY2Xi4HVO+eDEN7Nw1kJcVwFDrdNstHUdSU2ZOcXdY1viyobzmAhcKBZ1Rt/MUjU7gD7NFUZ//
	1nI7L4bXe6D7hmWfkwMLlo2AD309T6daxEW9mqKOA
X-Gm-Gg: ASbGncvlY//JBycOzIKZr8bYiuFsjnkMzziPhv+8OEqAk5O9TTgMaus4xFuZpJmuzR4
	l7WN7cCoIl1I6HUGQK30kcUeSQkk5O3gzK8imRU8Y04V9hdwvZw2w+p9fyq0BcHRx67MNQBx1WI
	UzYiw73cmx1fYesorgqx9u1FOLMhTqPO+v7/v/suNwzSszUxlZLr0SVfQBeS7RUvbROPDzsF34w
	+5/ELM2RZQ+bh4xgmGgP38ksANS2hD1cyn0SNqn/rrgs/75oZVnqUtZ0k4Lr6wppcF56YEnA28R
	Jy7Ix7c=
X-Google-Smtp-Source: AGHT+IGjdANt+fuPlj1u6k03al+PwTeWwPQvya+7WRgxiU0mxbxxM8F4uL4nbN+EmMMgXPpkgs95B3SzwTo2s5qdsy8=
X-Received: by 2002:a17:90b:2b83:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3408309b5d0mr2256670a91.32.1761877998236; Thu, 30 Oct 2025
 19:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-5-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-5-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:33:07 +0800
X-Gm-Features: AWmQ_bktjbZKQJQHAYSDluD2qGdC80xHb84razKBk8_a9ZP6wgNu7U3Zy6qD5y0
Message-ID: <CACycT3ssC87PUdUrGyZqbm76-kNZ99Bcn9D3W1rJ3jfNi9df2w@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] vduse: refactor vdpa_dev_add for goto err handling
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Next patches introduce more error paths in this function.  Refactor it
> so they can be accomodated through gotos.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
