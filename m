Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8691D5CD1
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784251793; cv=none; b=l6zgVqL5g3V8NijwYYght6d7SoKyveSCP3fYg05PJrSXMchNNVum6zX6bfRE2WEvQhLN7r028tRX7nAJsMWpO17RZ07PHJXIjXCLVhXOxyjrZvBPGuA8HKUGtwCuGRlZ+rEvfC2oIFPGqllnhzNG5TZWW7ntKq4vajq92M8LeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784251793; c=relaxed/simple;
	bh=Cv72BXt2ykCobSfdsv3Sfb3iGb/JNGGKvOHIHvHuBzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKYlchbybwueQwFbNODYNjM+0651R+OuMU+azRvRP4NVjV1Hn0rQZuSd47P25AJZRRxeOJM/3rnSxGJ0d96BTbmKp2H46Gr5giYCnU9jCcKj2EJz5qkXRJBni4ZsDxHhxTPaiXbHfvzyO9pHjdqrxWAcORK8IcUiZQq5/lEZygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eqA6aE98; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eqA6aE98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=Cv72BXt2ykCobSfdsv3Sfb3iGb/JNGGKvOHIHvHuBzY=;
	b=eqA6aE98Z9wQyg9X6/+J+ypdbVMmFLvv5ru7hfHAiogeFK4jOXyIUMvV1qqCPm
	39wJytbef0Ih3o+gBKZDn6cPn5ufh5RrDZVe0C89rDW2vbfi2VPvVZdFZBJG4/oL
	TGrPtZ0TIYL2aH/Y2jXQKhfHr3zqQWJcx5EMbQ3vRkPBg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHovmIhVlqlvwKHA--.3822S2;
	Fri, 17 Jul 2026 09:29:44 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	mst@redhat.com,
	jasowangio@gmail.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
Date: Fri, 17 Jul 2026 09:29:45 +0800
Message-ID: <20260717012945.313018-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJaqyWfW9n5o+ojrEjK-m+6cwH_TSxWckjkvEXowZA8r=vDmdQ@mail.gmail.com>
References: <CAJaqyWfW9n5o+ojrEjK-m+6cwH_TSxWckjkvEXowZA8r=vDmdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDHovmIhVlqlvwKHA--.3822S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxHGQDUUUU
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7wh0BGpZhYhMKwAA3O

From: xiongweimin <xiongweimin@kylinos.cn>

Hi Eugenio,

Thank you for your review and suggestion!

I've updated the patch to v2, moving the check to vhost_chr_write_iter
as you suggested. The existing check for VHOST_IOTLB_UPDATE is now extended
to also cover VHOST_IOTLB_INVALIDATE.

Thanks for your Acked-by!

Best regards,
Weimin Xiong

