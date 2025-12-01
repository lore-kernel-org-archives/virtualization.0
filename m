Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7C1DB356
	for <virtualization@lists.linux.dev>; Mon,  1 Dec 2025 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556906; cv=none; b=uCqkW+wdavZrUKbgeWDGPx2crgtsIG+hSvvZuj8fN+KMHLa/kZWRcPsv3ceK900M7HX1msU+lNL5b/AXKrpt5FBHhRy1CZlOqZRG1SPKoyz08a2Qu7Vj1nXXy4jd2x3R5WIMVjurU0k/+hh3L130K3LzlNK9CGhbU86jh+fpwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556906; c=relaxed/simple;
	bh=bVTMBZipQSey4Fgvkem7K+oGHQCM1N5D+geGZc1LQG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFzVwVrY0pMVH+YKCfo9clP/FsytAyTZkYTSWk98Mz3GYJIknOjZTdLnRk7kK2nABGxvLJm3bde3lKjS3th98+OsMaFX7IHWnv/sxs4NaGwbaGxRqdqK4BCZN7uW9dUYgQ0xAIku8YjDSukcWNTSjykD7uiwTPZFXvKbjvl8Kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVBJb/ZN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVBJb/ZN"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda6c385c0so30849001cf.3
        for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556904; x=1765161704; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=MVBJb/ZNbYpBpPmn+x8rRQWo7uyBfM80KQ568hftL96w5Mocw5ZOzg/eKDIQyvpRS/
         CoTinMdYJsKSARRB9h/QncHaakl76yzdKa6R7h5BrA65vYVHOpam6mcLzAe6AWa3zD/1
         aoL/fQJZNcoueGtm8+a3WvAasVgDJ/DO5dWr1B0Usxbh2NCtHei63cD/uahNZekgInyE
         /7s3Gudt+huMdcyx5eUrpcdCmCD781SWLh3Q8yNbchd5qyFBuFKbI85yJyWaJYtvZ9SS
         C5LWxutDyN3PHmGH3gu2v4kAlBnVu2BVBxs9KQIfd9LbMzs386gAFrlUx67ZMDMurkO/
         MvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556904; x=1765161704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=rwXyiZcLsJPqKEaR5GgWhvjxifpAQ27RW1gnnnreQQSVytYkPtbAz4ejJlv4UUP9Iv
         fmS/O3R3865z0NbcghUgad5CsYOQep9v6Lry8X739m47l8sqbxVXMQhlIZI0Elupx4Ru
         bieJyBL5a4E0reSo/mTWyqalEf4Irb1zLXxCj2Ge05PPLHUuIFSEpQgdw2o3mTQYIu14
         dZbQdbrNv71tJPx5kqS7A+OMlX69D5Z4UQGc9RLgasvT9GHKzYA1XwYXx9X/gSkHZOkw
         JaerqtItSgg9VRXxWSSYtyeCEYtfSry3penExg9J4/lghQxMHIv9qi6vZYuO2S4QLj/7
         FMKg==
X-Forwarded-Encrypted: i=1; AJvYcCVXhx9BlaIL9t+Qg0n4gvmCxMOGRYJXSQYlh1qf3mcngNsDSKS0TiV/XTBvXcWEy00AYmIcS+qqZJHnCnSRHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKw9l4XMDMV0GPF5kr+wr6CnFGEN01/D7VDuNqDUYDoJbrd1SU
	kEhmim7IrjS6JRsFrGxyAihxqsX/hLNZHHt++n8ecC2xl5xYcbN1uoPLKkuDN0Tn1Lg/CU0eDCc
	B8YLSzjBVDToFfjGqC5G8g6h6mr6gjLA=
X-Gm-Gg: ASbGncsbWcOFaS5k5/1HNIR2UtVmNJOePf852gJd7izVRMtUmS/oDjNlohb5QumQ4+k
	cDq3644nia+L3foFKiM6xCWb57xo/Z+YX4LFVXoL3clNPhl54frkVl+u4HFXOhQE0iKql4m0cH8
	9oLdI6d7VgFgR3aQSyYFh7fZaOjLkpHfu/9MtzvaDvfmTaLxoD9IHMXrvCDkMMp5peV1p56KHng
	iedhUSMib3hySTyxkhV7JDHN5z44ab8u2DeIepCW1O1/zcamgucgK62f7wf7+jxqoYvJPU=
X-Google-Smtp-Source: AGHT+IEmvBJytrUYv3PRff54NTqLEiIVWOTOdu8c+jgIKKnb+TW+2xLZqLXPCQhWGcR80rf7EC5pZtRoolK6Jl03Lrg=
X-Received: by 2002:a05:622a:14ce:b0:4ee:ce1:ed8a with SMTP id
 d75a77b69052e-4efbd91573emr353928791cf.16.1764556903722; Sun, 30 Nov 2025
 18:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn> <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
In-Reply-To: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:41:06 +0800
X-Gm-Features: AWmQ_blj_C1mdvu7tNb0hVlGGZGM9DWXbWPpg6J4BwD_02XuZ0ipoM_caXqdy_E
Message-ID: <CANubcdWAk2Mh5b9stjTh8N84jq+XAgaR3n2-VYRinU9ERtJLUw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Andreas Gruenbacher <agruenba@redhat.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>

Hello,

I already dropped this patch in v3:
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/
The reason is that the order of operations is critical. In the original cod=
e::
----------------
...
bio->bi_end_io =3D nvmet_bio_done;

for_each_sg(req->sg, sg, req->sg_cnt, i) {
...
          struct bio *prev =3D bio;
....
          bio_chain(bio, prev);
          submit_bio(prev);
}
----------------

the oldest bio (i.e., prev) retains the real bi_end_io function:

bio -> bio -> ... -> prev
However, using bio_chain_and_submit(prev, bio) would create the reverse cha=
in:

prev -> prev -> ... -> bio

where the newest bio would hold the real bi_end_io function, which does not
match the required behavior in this context.

Thanks,
Shida
