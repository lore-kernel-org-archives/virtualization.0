Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6A3C2B95
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708598; cv=none; b=XK5eXHsR0F2bsEFzTdhsynQuQ4qWn7/sXbkYwr72k7LZ9cqjRdoOA+tsKgYItrlKj06IxZIZXYm29Tbs/XC7jNK6DfWqNbgZZ9fCt27dPx7LTFy1GO80umWQ4WutUFSo3FwJUVf9HygVsMGZ9Psd0vNgPYzmAqCUBt+LMy1uifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708598; c=relaxed/simple;
	bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrfE7oAuzJiRkN/9LAXNF4mdBenGshJ7yhiH2Ve2MvyQJdJQwgnlOL9pZ3WHNllt1X2HRfZxi6jSFVc0cXMXMLafWJ2sgzc+NR7IG/M66/QOhSDc0wbKHWdb6zI76zX8kQY78GknvLQM20uiOxn2PqJiwZcQ9S0EbKw57AmYa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qun9TCAT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qun9TCAT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso628949b3a.2
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708596; x=1787313396; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=Qun9TCATJcCuXSMU+x3VGwgCIED6TIG4dtd+d47p7qj6B3ISEk9n274agAKvMDbL0P
         gwXO/xu/cQEeF2B+xQfnFpXL3RzZsF9bPcPg0mGtT7fqG1vXWNu1LSNONk51xLzd5liv
         breowB+sogys4DDsSK9O1SIQxCI/0reyAb3UgvMhxP33XUxER4q88Td2QsYwerBW5+8v
         Kdb1Dfct+v+AAhrBix3EKFwzxAxIKiNZ7+y11c1WpUVQY8FlSiWt32BVcZBZMW1FplLp
         q/BqwmrSCvBbulUluKZIFaKX2nCuVkpsvDtmbzDJjdRoBuv9rNW0yh4Q7VFZfS7auxjw
         vH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708596; x=1787313396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrCQV8g4BsbbYSD2zfuevsQMa66d9LMXeb6HvD0DvyA=;
        b=MSS27iYxRx9RHiveS7V72qe9Dvp62HJyrYIFO8QCI+UGRk/bgfMVfEvWlfFVenWqii
         XYXo08aQ5ui4TzLAOuYMhi4qnMdKoi++gXEldQ5GDWs1h19W3ZFYgWZgA5hysq7KHHUr
         NN6yq7qQyBShDp4kMYxBYLVXWRxnjeQL58AgvN61LkWRy9T013YON/n58Ugj8G6BDcSI
         p2umRRZhQ7Ria4RKZ3EgoRr/065m7KIEp3BUU1RJQ+HZ5AHCC1I/lr3Uy2ORmiG68Q63
         cWXFZYDjpP0BL5zQwe5j6rgwPPRx0p/eY2m/QUuthY2S10SzwrvHpiSzY/p0o5qrwx9U
         RLvg==
X-Forwarded-Encrypted: i=1; AHgh+Rog2a/f1kfSIztbkBd9ebqSBAA9x+kzoRJQ0xaKeCSH0n0ZcliSolLChc43xBWGNgWkVqJZoVLqoR3TDbw1qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF18T0/GQPl5Kx6k1Ab6aG3q/17qc8oiGAa4T+PRiAJ6uyRWhY
	QZh/ensSh6RJLtlohD0O3GKbcU3qA2hRwGCcHQCLUXQKCdH9xlIZ2022
X-Gm-Gg: AR+sD13W4DL2e7DEU2x5nx0xPn/Tf61tkgqpo6RZnqR3sZIRehJj//GQt+piWEq1uAT
	YwYkTsydRXMibFbcCdImFVoJoEAB3FHeD9C0xxxPWPfFD1fCV10Nxwjn9tPfe/o/naVsWOz4fAE
	KkYLt/jKZ+XDdSbveKFkqhprryw0ya4h0oGZ6fYxskD0oEYxpwTWQtaxUzI60Tv4K8zrhoJHwYS
	sjtYtAbp70xwBKUaXepgw7RZ3jcOmnBIKS/VKsEHINJbETfHIr630bXhIqmnYh49xwZ9UkN2kWT
	Zqd939Q4W4WDrj8IUb5LTjBvqJQrD+8CKn9EoPO3q2aZswl4IVXHL1pTROQ11x0Dq59hdrVWUyt
	wuFnn07wQJJKE3QUpL6Ad09+ybiaU6HtTfJLM5mwVQllleA4HI1drmkm/O4GuW4ZQ7KXN3Ak9qN
	xni1zHGCP+Ox0zZ5ozCOm/etd3pXgRXAAS1A54gvrE5X3DtjKFCMGu77idpV/a
X-Received: by 2002:a05:6a00:88c:b0:845:e8f3:bdd0 with SMTP id d2e1a72fcca58-84fde2b6841mr5495706b3a.33.1786708595434;
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 19:56:11 +0800
Message-Id: <20260814115612.127842-1-physicalmtea@gmail.com>
In-Reply-To: <an7JAlFpRVOiC4WQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <an7JAlFpRVOiC4WQ@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> In the v3 you mentioned that this could be used also in vhost-net and
> maybe vhost-scsi. Would it be better to include the other patches in
> this series as well, since we're basically fixing the same issues, or
> have they already been merged?

I did not explain this clearly before. vhost-scsi itself does not
negotiate VIRTIO_F_ACCESS_PLATFORM; the fix I referred to addressed a
different issue. See:

20260726144314.1652934-1-physicalmtea@gmail.com

The issue addressed by this series also led me to find corresponding
problems in vhost-net and vhost-vsock. It now appears that these are the
relevant backends here, so I will include the vhost-net changes in this
series as well.

Thanks,
Jia
