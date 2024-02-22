Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB214B824
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629829; cv=none; b=SA8CFZmYe5v0TmULD83t1aaM4Py2VNFEXfLRfLZYKZ0t1U1pciRnvQkwXx4Dr7ecH4LCMNHcYdKgMKNjGD7VaAJxpRX2HR3K/WBGMrPnuj4YLgF9BWatR79CULGQ6QaM5EnuwFcarX5KJGLxKx9nGg4q2IDx+gqPwRhY97aeUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629829; c=relaxed/simple;
	bh=cq3Cnk+GZrsQGPtsY4OcFojjqqyL9ctq/cxxaE9pID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XCjV41QJyk5/ICDj+exEKvzV3heu7sKF4u+GF7atwPWKgBaWHh/o8EaJY7XF9uvRC6s8TlrGmpweZPVp9lYhWUEJV3z08vNczdwh3TnE1euCMk1CIfpFXB2/K+gncBlY9KfP/TeAgT9TgrYqpHqaZNMVMluCeSZAfkc3ouueHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ax2O9Gv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax2O9Gv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708629826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ+RDIdGnhU5lg6jFGeCqCjJlhqa8k7CnALV244t9Yw=;
	b=ax2O9Gv8ewMecneBzmkgEiLxhHpTlB1RKlkQ0fyhJ0NWCgHSMGO7PvYACFeqhHseMxsqqD
	nyshrknh6I7RdYLs4GvwZxiY8wLwIicqVrToSUKO/C6LhdNNZbYmS1TVC2tsTRiUcG8ZmE
	bS0wlxgWrcOcn8xbbq0C5NxdvXEZ9tE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-LLIsWwRLN0yge0wPNtEcww-1; Thu, 22 Feb 2024 14:23:45 -0500
X-MC-Unique: LLIsWwRLN0yge0wPNtEcww-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41290676819so298545e9.3
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 11:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629824; x=1709234624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ+RDIdGnhU5lg6jFGeCqCjJlhqa8k7CnALV244t9Yw=;
        b=Vi4TMv/jcDixqVk037PqseJJaVtIOTqaIVmbQ8HUxszIXuiqiuo0ia9iwcM3a8nIlC
         1jpNy5HjkRbBihXH+LJkpDJQzqtXh5yuIXso6IITtsFoHOYinuRhGvDF3rkjgzBRqBHu
         Nj9kNQp3qv47YEtPk4OHaX05xb6vpd2H2JH4NuUCck/lr4ShG+NOFAEevS28DbjlzDUH
         UvuuwQFRXXSIE0HX7/xqxx7sCBIHQC1kum7EqhTkQm6Uke+0uffyWslxvBkY9G0/bB+o
         9/C7qh7+9C+JR0RqRPxiMFL06WtS1RMT6Xm3L0qGnATUKpYesAjtvt+wu2Bhcs94hhTP
         QlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNb8Y11EZbdAuicjJN87ElwsSrKmSVMQdJSX/M/X33NiZolQ7EPCMXLauiyzt3WN+RZK3knCTHlTU7Xd4k4fyTg9bN0cc1xPjHdxpEAwA=
X-Gm-Message-State: AOJu0YxeDJPHZ76Xmt/IjpfDNJQa8eYL0V7YSBNd7P0LLgx3+b5QkSZ/
	Dfw57dHN6a+qhJO07d8z0kCSZ1ZM/xqaGhPQKxrSx8ZwRMpOzJYk3C7xCu2e8yuDWA4DNjhv4p6
	/cdzbRvd4oR1TuCSIN4F5wGxezRwZYxck4cEH76e5S+zYYnZPiMkdSA1ZSISLc0/r
X-Received: by 2002:a05:600c:4c99:b0:40e:a569:3555 with SMTP id g25-20020a05600c4c9900b0040ea5693555mr18945735wmp.35.1708629824329;
        Thu, 22 Feb 2024 11:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkfAP3Yd4xKF6bdlzBebTP+hY1tBDnghJRdAmvC+uFZRuB+6mlbezFnXDMpRlAhkJUEHJUQ==
X-Received: by 2002:a05:600c:4c99:b0:40e:a569:3555 with SMTP id g25-20020a05600c4c9900b0040ea5693555mr18945722wmp.35.1708629824024;
        Thu, 22 Feb 2024 11:23:44 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b004127942bcd6sm5410408wmo.7.2024.02.22.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:23:43 -0800 (PST)
Date: Thu, 22 Feb 2024 14:23:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240222142254-mutt-send-email-mst@kernel.org>
References: <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <89460.124020106474400877@us-mta-475.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 12:47:39PM +0100, Tobias Huschle wrote:
> I'll do some more testing with the cond_resched->schedule fix, check the
> cgroup thing and wait for Peter then.
> Will get back if any of the above yields some results.

As I predicted, if you want attention from sched guys you need to
send a patch in their area.

-- 
MST

