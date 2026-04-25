Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD303C87
	for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777133395; cv=none; b=mkAEyxOEyRVx16lcOOY3W3068dvsE6UDsm+cQmP6ENWbkBfTBgwYAKjLou3wQhlqjzHrUW9iLPHZRs8hh9U7GUh/HNaurjDOg9iCXEhAxsnDG6li57vmHGk6ZxnzWKpy6hHE/HEgG97pdDwgBh7Wr71ZOYX61GMLDEWaksj93tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777133395; c=relaxed/simple;
	bh=9kHSMQaE5l6w9t0vlfGjcZ3hUoHUWAPaOc1UavxBppw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMpmnoPzFHDXlO3bQjcd3ozrLzTXZf7mFIIh1anOpLduLSvmEh+3TT/ZASsPBs+HMsGf3gdo9gBm28mDjUzjK7SXUV/+Rz/76Fcg0YykmLwNyr9hJWWu+A2SKbKBej+BHKf6ELXlEVp6ypWJeCf0JNQ9MKdvWCs+cFlUhZ3jQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqChV/DF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqChV/DF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a9296b3926so52040695ad.1
        for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777133393; x=1777738193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kHSMQaE5l6w9t0vlfGjcZ3hUoHUWAPaOc1UavxBppw=;
        b=XqChV/DF5DQpZtJhw97vY5uG2PhfJfhpNXPD4cHan+BFu3WmtKqGh7i2uI+AcCwdhh
         Ppl6DqmNz0FrgSRSUT2QDGjb9SUODwe8RAJCHSCL6E9vvGPGjhZawH3OqiwbBPOudbqe
         XIR+ahoM8WbgO77+urP+v1GAisH87bVfaeNC9NuGpov7bKfrvLX1COXiOte0Tnzlp6ut
         aKtGIkdLzyGxVlkcfLxRj4BeHdiVlB3I7TbqJQbUvqsfjJ29ejgu+NlxuGcMVSzGOR96
         VXfw7cTUfO1lwFGU2tG+qU8JCwLlpyVyuDuLEBsLo9b4p+2/Jep5o1xM6h5LWPnQ3mR+
         z1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777133393; x=1777738193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kHSMQaE5l6w9t0vlfGjcZ3hUoHUWAPaOc1UavxBppw=;
        b=D/EwXaWjk5daRxo5a1SlmilyNRI/QqYS7gwJuDo75GLvPNdHNb1eV5osvHhtbjapaX
         lZefH/No4gUgQYSOaqwXiF80cLPFqorF73tfzjKCZMTPEccjYaH9ZgqRW3fhGrdyHkyG
         zC+dX0TSsc/QwGG6TV9Alnv8Tp/MfSJW84ZTZHicg23kZezPhpeoURDlYua4q2Kt3+LT
         oxVOqRxxojiD8U9STIGrqTu+KhOOlrBX51mwyapcJxCUH5r17PwjGO1yDWEaNZJERv84
         a8d0x+BI+dYPXXMK60lyk1inbRACJ55AZ/OeS7uFfOADOrdQcaYojiyusQPsTBQRO2We
         YvWw==
X-Forwarded-Encrypted: i=1; AFNElJ/1lXnGmN/LWIV6lzJus6g8asq0E8uGQR5bzKNEvwpNzQ9rQ++JSo5NqrE1xMzh6U0heYuTTpJWeZtbXxIGng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0yt9m00TQ+H+Dh37VezZBaPzBwT1QbCqEgFd2FYDq5ek4GHRL
	/30M6DgGdEdl4DwSFhcpGTEXXVvDFRNJnko3kVDrIAM+VkJC8w52x7fs
X-Gm-Gg: AeBDiesJchjKl1jZ3AIh19ASU7wFrW5Sg2a6PVcP+1WcHqKCbi9hsZ6jh9scc2OTGNL
	bvm2DvlgZqiV148LvlReaUJZSSnvETn6gcZ2IhBcZS7ljeAHj+QYWA7xzcl4KmW+RQ0BVtAoSbP
	+33HKoYnI5I8ShIwJIqzCuESs3WwQtD0+4YjHxMRDQmgOc5z71eXWnDt4gO8DIOX/WriUaviXtF
	U9B7lm8KwTx0E5fBzg0/TRO1fWKtVp6A1YmLS1KZINMlgrX9QMq5WZ8q9j67vJcT7fGlHnHe3rN
	9T+SZckFgJ2PuP51EJUd6R3kp8WEDSVwHn9McK9qnyFLJrM+j+OBUE9GvQRBGZVXkB3hepE5/hx
	lHWic+hA8u1MkXpsNGIptFWu9+PgDxdEUgVY25ScdHINTQNsC3BtLzugcuudTyTBumZW7knA6GX
	Ibs0NGwk5BlkiboaTp8EIZdEeTdzzM/CyNyCGknDQd
X-Received: by 2002:a17:903:1b6f:b0:2b2:4cd2:e16c with SMTP id d9443c01a7336-2b5f9f3c58amr348306735ad.20.1777133392435;
        Sat, 25 Apr 2026 09:09:52 -0700 (PDT)
Received: from jia.. ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa4f092sm258631165ad.36.2026.04.25.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 09:09:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Peter Hilber <peter.hilber@oss.qualcomm.com>,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Date: Sun, 26 Apr 2026 00:09:06 +0800
Message-Id: <20260425160906.677660-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425110857-mutt-send-email-mst@kernel.org>
References: <20260425110857-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael,

JiaJia is my full name. My family name is Jia and my given name is also Jia.

I wrote it as "JiaJia", but "Jia Jia" is probably clearer. I will use "Jia Jia"
in future postings.

Thanks,
Jia Jia
