Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735A331A4E
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026483; cv=none; b=JEi9KR2hTwkuYYqmIcN0WF7fb9iF2xVSrGVdofcZ4yOjO/yXA/hx3KvHDb2elrU1OfQa2CuyLEMlgXNQVDk/W37gX3N7o9kyESZ6LwudRnW4HAzkn2cHL3j6kPNirjWrx9c3pMY904ygC7ffQyD3RLMpuV0sAer9IomO+NP2h6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026483; c=relaxed/simple;
	bh=tyYSURQXeVxNp/4vyFisyXOs2A6aYVxtncwl6UimOqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RZ2vELgwKhyPexyA4GkWtJBIef9w6b76euVQZq4cZpEp2ioMVQWAD7aQl/DnumyMWTl3/HKbnQr372m8LSRF/Py4GhX8Fug6+p6CCiy3y4tqmmL1liiIXJic7N/MdVkF1XE73eSsNCcA77nGV83ZXNCyqazUzUymdedd/bB9a0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbmpB4pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbmpB4pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/+HLsDOj8lVO2SBlw/DVfzinJavO+RsEnhPif6jD0c=;
	b=HbmpB4pq8uGx1XIKo6k+y8RHxTkl9nZWCG0vfW/0YpaGRvsUDS5J+4cpPlgvUROoPWgDVC
	VYtTtnS0qi3gg/vDnpZ1+xlW2nKCY8449/NMAIbJTt3mdDAPX5iqkP+vQcKCjPne7pbZAX
	olTDbYpBlEj5oC6qWdH5pTfdvaQ3gao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-BdmJOMCONDCpUxz3hWfOWw-1; Thu, 13 Nov 2025 04:34:37 -0500
X-MC-Unique: BdmJOMCONDCpUxz3hWfOWw-1
X-Mimecast-MFC-AGG-ID: BdmJOMCONDCpUxz3hWfOWw_1763026477
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbed2b8fso251071f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026476; x=1763631276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/+HLsDOj8lVO2SBlw/DVfzinJavO+RsEnhPif6jD0c=;
        b=nsEnpo2RzZiJ6XHZ/EhDkgAKiMzJomUGs5YXpr6LKjKq1mmmr4hOERexi6RbMCyTaZ
         /w9knZdMGpWW4muQa4VpxXUh+fysy+NLNhP8J9RqWIfid8RgSTnerkJLzUqvrQyAsRT5
         edi5vyvTQmj+4M0UkJq24NzuNRAdjU4uOMPXbYiMXWH0sn/ngFDckP0B7zKFsuzTAmQ2
         ucA3bd86W/+WOTMjnp12KOCpx8Y+X8FkM+Yiqd59LmzwpfJ8/QIvRHsdgS5G7blpjrtb
         9muWXVQEQmBFVfmwdzywzuGvAz4cnIgwvqnvYgtK8P7CSipSqviAtuLDuJ1lnaNjn1kb
         klcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3YV6p4P/eX6lTGFphy4irPXhzgwd3sBoBsh2dIZAcH9FWy/0ThtPbxq64eFJ1gAaxGdZh4tYn+0VPCSx29Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza8+c4RjGMfPx9RsnYJlhrQPyUSg1hOc9HuxwH1xsgKLqJBiiL
	L3P4RtdQdoC7HILxqe8HIdi0uUSUz4NcVwri6EFSCc6ew3Q8ZHPm+iufMLWMGM2BJeFvrSnKz/T
	0pG9LfCMlUmAwPZ8Lxa2o213ljH+fTov5IP86sWQqd+8M/pXcXW32QU45Bp5YBfVvAFU0
X-Gm-Gg: ASbGncvIiAKWisqyklsff/aEDDRwaWBByOi0VvtB0V19Khau+sn+vUQK/wtbWdBFdmA
	iHNY9Vpy3AJkBptgRBMcTj72qtIfFPSxcY/EkjmPrm5ZaW90jG2v8gevj4W25G+/Emt1k1Vunt/
	k27vZrvffSxgM9YPKQv89sa3lo+FOz4gdjF3ZlC+7zuA+4OdKOW0OFIYMch4xXgT39m/uXZxCEZ
	yOm8UyBQeRIaIBigIXUD8aLWdBoSxigpW8o2mWPMiw5Lr3SBdwS6AFrFngYaLWVgYpYyA26PbEb
	B+hg3vPUSDCDsZjuOWwKcsGz1JWUPnf5LIYvRheOiDCiyHSI+p/MnPgrPIst63UbOkp3/VF8qp1
	xifaz7YBUAW/V3pFYWQg=
X-Received: by 2002:a05:6000:2104:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42b4bb8af8fmr4787374f8f.3.1763026476605;
        Thu, 13 Nov 2025 01:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb0qa2odsCLZpXfvEMIlpyqYfQSp2xbqJIge8MQT27yKgJ09CD50eDjKDkXPnMfyvcv6s79A==
X-Received: by 2002:a05:6000:2104:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42b4bb8af8fmr4787348f8f.3.1763026476194;
        Thu, 13 Nov 2025 01:34:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm2824098f8f.33.2025.11.13.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:35 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
	Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux.dev
Subject: [PATCH 2/8] virtio: fix whitespace in virtio_config_ops
Message-ID: <39d7685c82848dc6a876d175e33a1407f6ab3fc1.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6EfG-4r-72GfVvhIgMqiRyvVudOxe-tL8or9L2SPWdQ_1763026477
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The finalize_features documentation uses a tab between words.
Use space instead.

Fixes: d16c0cd27331 ("docs: driver-api: virtio: virtio on Linux")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1ea5baa62141..dbc7eff1f101 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -86,7 +86,7 @@ struct virtqueue_info {
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
- *	Note that despite the name this	can be called any number of
+ *	Note that despite the name this can be called any number of
  *	times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
-- 
MST

