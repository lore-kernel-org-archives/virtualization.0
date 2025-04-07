Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1451F7914
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035887; cv=none; b=saJWRiP6DH7AVxc23yvFwTolaI+4bKQ1dOMHS3BGJ82Edt1ER8YDL9nf9QVJxhK9xDDciFjRrGP38wIf/OD3ec9ccwraP08ioNscHL+UAgCEpDr9f2KHFpzfu/cGhdbiH9HwFKnQoZUAIb2DDq2+UchTp1R9I/FEavZZVfQRZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035887; c=relaxed/simple;
	bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0Cwr7Qjakuu1grohat7d6NjgZk6tS+nyJmCAxJmyHk3czhTPheopDVaS04GSkDHRYrTwd5zYvMzXX6UWb163Hgitf6fehs4QQWXgwyUmpwPChq6rJsiFGO+woezuqciAz1NijRzX4UWmhkBT6k+0K8VSkJM9KxmjzEsuiSVFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LTXvdB9/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LTXvdB9/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a1acf61eso40691861cf.1
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744035884; x=1744640684; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
        b=LTXvdB9/OEgOttsrQmy8m/HxIold0HrIXObOO2JVDB4KXR+TRc0N1c+UnIDDN55iNJ
         Rs589NBEJBrzj0MHpD3HcBjE9ZslRUJZnlPBwsXu0NOTzXZvs3HxCbnL+n6M92617uDk
         9IlMfRh4mISip1bt+vL69iXFr4ijeqU8MNDBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035884; x=1744640684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
        b=k2koEgCeqrdqfwAJlFqxDWsWD36Y4BlvxZG0oTGvZGrj3lgaq0VbkDOwLVr5uCtJ2y
         wxlCwE0sN9JruhqISzsCSCLngQBazwQ/71ZC2XzHG4MDEroudmCdoCpKE/TScdJhZuTX
         IX0QO/yxDHnjnppw5qSXC9P1RSG35RlmZpf0wGNvxLjGySjMVnHDLI/YAEE66R+ZTIlt
         18QhMosyqCV8Fn+va7aoD2lltn6vyM+qGnSC6OT5FDIdNqOtkyhLdjFF7AtP3TkUmaH/
         +biptIxF8r0ZMKgO6ce7yztSPcAkyY7XB3VqURZGOOGeTFjz5svqMDESaxbB8r2HmgDd
         Fhnw==
X-Forwarded-Encrypted: i=1; AJvYcCVfnaK4QiK+UhmSNMqvAvKvIam3RvNJSH/5Qh67/ihFm7fJA8ncC6NSCKkmIgQ2LwMaZUz6Y2RpvTqV/WLByw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUgemF7BkA9VPAq0KH3XLdvhIKlOX+C6bsXuu/xEohNLN20c/M
	aPeRuZphQzYJKlm1YxKIe0creRrQNDqafwG+FQTE4EZhbx20k/jxzNeEH42wsjNGRhWvI7xp2yF
	qx7UvXNWD0OsrxypZhtu+kjHvI6FfGtSe6YU8KQ==
X-Gm-Gg: ASbGnctzg6ZCKGgQJ0Yv8j6HBGY48rFQqpCo84DQ4GTRn3Cp2muGQjnvrsB9oHyg3nT
	jtYnJBzSulOUTEUCNXO2q3gipqmtkV9rBineYnDntQfUq0L4FkDKHExgBWF79y6Qz6wASJfAa6l
	l4RaqRqp+gJQsDBOnN8s3aJnD55yc=
X-Google-Smtp-Source: AGHT+IFQd4jHNyMbSuzJ059jvOO/iExVzCO/KphR667EKFZiLjHNp+k+91snAGwPCrKp9DxvzNZfuI0F/c1qQXQ410A=
X-Received: by 2002:a05:622a:199f:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-47930fe7403mr104524641cf.24.1744035883851; Mon, 07 Apr 2025
 07:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
In-Reply-To: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Apr 2025 16:24:32 +0200
X-Gm-Features: ATxdqUEaLGT2M3QdvlukIOwAEuscXulm8_kXjOV6iVYrWf5p1vewCG0W1HdKGiE
Message-ID: <CAJfpegsN47xDbVFsu=-TLW+A2=-33fNY83zt5bhebFqH67LAVA@mail.gmail.com>
Subject: Re: [RESEND] virtiofs: add filesystem context source name check
To: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eperezma@redhat.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	benliang.zhao@mediatek.com, bin.zhang@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 13:51, Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
>
> In certain scenarios, for example, during fuzz testing, the source
> name may be NULL, which could lead to a kernel panic. Therefore, an
> extra check for the source name should be added.
>
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
