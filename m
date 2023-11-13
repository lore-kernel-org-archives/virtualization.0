Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA11C6A8
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+yMbLbJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD25381F8C
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 10:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD25381F8C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A+yMbLbJ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nStu1jw5XK26
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 10:07:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 282C881F5E
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 10:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 282C881F5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699870026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGtWFn3WY/6+Bm2hlCR5qe61nX9MiQpZ4JPVOs9ZJMI=;
	b=A+yMbLbJkZsPKPugxhir55bIhyoSCBVW3w1uF+HWnYsgf2O1kUzYDFOHrDgNW084uWdkMc
	9F+qXmXa3cELP6vz6UntLkKnIFyHMm6/qgQViFteN/6ss5Y4hWCWOrKl6Ylke6NWir9cmc
	OQ+uVKvPzU1e6TUPTgSMInfTVQawj9U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-r1Gzl1kHMQGXQ2LY7ynHOQ-1; Mon, 13 Nov 2023 05:07:04 -0500
X-MC-Unique: r1Gzl1kHMQGXQ2LY7ynHOQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c52cbb64c9so39607961fa.1
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 02:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870023; x=1700474823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGtWFn3WY/6+Bm2hlCR5qe61nX9MiQpZ4JPVOs9ZJMI=;
        b=t20lhv8RKNxlYr1al3gL/8ntuXDzYqd+RvqDbls1UY3ICqlAvW9TImX5s3BfATq9Dh
         MqhGqPJUWWr5RYl0NBcAh7GNaG+/C//sNI7TcofZ6nvlfZFsg9cF1YivJhB0BSwQheL6
         ThRkQrvpkOxD4n3G1qYY6I2+Hg7JlhcgJwf3iUPlm/yYJDj5ZhatnEpRQa+7dC/VxcxL
         HupnMpKpO7QUih80h2JmlDJis/OVFuqMpe+8BOZo7p4BcYAkqxIuCz0a70b9Fq9Rh//R
         ze8OsHcJi5PmJe15P8Su+c7DfFqCH6ktlAau90S0rSJNnjMXndce9CzxUuRIBvuxtD+f
         Mt+A==
X-Gm-Message-State: AOJu0YypfLdaecxQWidWlC74UE7QKDH15Ib007qC1cVTrFq+are5Z6Vd
	CY4Dm/og5E2ZnnRDxqUqyvx4lsN7vZhwPw5zde8CvR6DbqWnVHgGRcvpv7+YzBKhP7FIhlYfeHn
	gWa7QVkxsWH5RMkYi3ZneG20H1c1wQlen9UKXK+6iMw==
X-Received: by 2002:a05:6512:12cf:b0:509:4424:2e0e with SMTP id p15-20020a05651212cf00b0050944242e0emr5426783lfg.0.1699870022989;
        Mon, 13 Nov 2023 02:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQkyfRsuGOMOyI1XpBYg2WZPpBqGjPENYvJNvhkOYdvA7Ab2jsQgIQuAdrm/NfZ1lUinGMg==
X-Received: by 2002:a05:6512:12cf:b0:509:4424:2e0e with SMTP id p15-20020a05651212cf00b0050944242e0emr5426766lfg.0.1699870022651;
        Mon, 13 Nov 2023 02:07:02 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:e100:f288:9238:4f0d:83ab])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b004094d4292aesm7517024wmq.18.2023.11.13.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:07:01 -0800 (PST)
Date: Mon, 13 Nov 2023 05:06:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, jiri@nvidia.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V3 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231113050633-mutt-send-email-mst@kernel.org>
References: <20231113080222.91795-1-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231113080222.91795-1-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2023 at 10:02:13AM +0200, Yishai Hadas wrote:
> This series introduce a vfio driver over virtio devices to support the
> legacy interface functionality for VFs.

Because of LPC, pls allow a bit more time for review. Thanks!

