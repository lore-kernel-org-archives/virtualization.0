Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E917B4E2
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999787; cv=none; b=raoS4woKHXYD+PAAvkMwcW8re9QTRRdpIVHDUGa8hacsASd7GqkMNJf4q1KeL9Dhq0/fcLjKelS1MVqiCIkh6kfNArANCoqfzkE6EjUuvk6GMvQx0f6wUQ2C/IaGYbOCbAPxQV8sHE27XLSAI20/ak55NJ7nguIgFrE3ft7jQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999787; c=relaxed/simple;
	bh=xmKf9omwUxucT1oeRkAGbgWNHALpXShtwR2JSwaiBgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hPneRUb3EHZwDh9qrwcS5z5Db0LZ367WctnesLJhCg9w1iCN4I0Zcbje074G5gZV8QAhX0N1BvMgvE7lrSbmF3zi+WwnVXFoLpgzIUNWtuApM3IFwbxdJMCxR5Q1ZySXBB7ntqqpELdObql7rNgFLKT6lKa0nya/8l2G+0GFt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UldgrY9h; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UldgrY9h"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 309F781CA0
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5OaejeocYSQ for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Jul 2024 13:16:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 68BA48144B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68BA48144B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UldgrY9h
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 68BA48144B
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
	b=UldgrY9h4raN3oKBJQ1WArLmBAH9YOgPrXETU15x6/S0SvEzStRrMT2zqxvR4xCzPwkyfb
	WzDupIqjHXzhqr5oC0ZsLKl9lPspwVB0JFgtuTPHf4nMy8gckp7WLWZ/NENWZ652zT7jRz
	bZxoqv8pd5aJl6NmE7q2dRJfjNCdBDs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HgiqDkcRPNyCy1NkglXYIQ-1; Fri, 26 Jul 2024 09:16:22 -0400
X-MC-Unique: HgiqDkcRPNyCy1NkglXYIQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef31dbc770so11868461fa.1
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 06:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999781; x=1722604581;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
        b=po/McQWQxwKWVimssw3W/tVc77rH+xgdP0WYp3JZJbrYJdY/aACjiEd4yv54YN1I1Z
         +Amh5Osc9kKBeSruSbGLJp6x+LC0XdlY4A8vtBB2LdYHEJncZW10qNGAW81WG0Fra/JB
         c1AOPQZiWRF2J4y5GeE2wOqsMfP7CkkjG5bgr4wONJK82WKsTp9XlKsxour+oMhoGS+B
         pvQ+mkOC3hT9TgyD9SNYUwtcz2bhAnk8I0j+F+WvjYIT34A5PThO66Ez07N3vlPHcNl+
         dtCGmPpTOSowaWIexU1ScnbQN75u12/MLVd5keKpzIbnGZB7ZWXJ9YwG9ESP+tpFGz4s
         0Xrg==
X-Forwarded-Encrypted: i=1; AJvYcCUc4dnDju1VrSsVBJCIlfEzmhEvjo7eWiliWkDCvG/1WG9eEiWX+R+ohoQeBnHVP6SsBPIiKJVn+a7SKVz5l1S9kYnzpWFtsnL2tTDGvhChBWyw2SaeA7EEpQ==
X-Gm-Message-State: AOJu0Yw00PEGbsxkK7Y0YI48D0bTWKuvBsOtbLU848KXmVFEFVRxv0kD
	CMRDGjhBe/3zVx28BmRLvQ5PY0qN/ly2fpTR5sy+KmULEkADdkMHFyqI+uQLVz8GrEyDTeqLbID
	UAbl8PI2mR+yp+QwU8n7+cGBFT2+4xytPPC0WoqQXZ0ljBIZlASmxN6WjkjyeaO6l2lkyp3KFDc
	VwRJWs2wdGOBeJNQ36fv42jlm6U8EilDh1FHDjGjZx7OzmxBYYTeH6Tw==
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id 38308e7fff4ca-2f039c9862amr40567671fa.21.1721999780756;
        Fri, 26 Jul 2024 06:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkd152LdcVGYZFsu1bzI6uLueRTD0erDZebrYWI+gUvt514koc5pNhArM6ncFt9ikhIn1ddo0wjWm/mrfZK0=
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id
 38308e7fff4ca-2f039c9862amr40567411fa.21.1721999780306; Fri, 26 Jul 2024
 06:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
In-Reply-To: <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:15:41 +0800
Message-ID: <CACLfguUORsgxmya8v2shsS5mJ3iZpxu6zv-fGsw9ZS2uwFFPWw@mail.gmail.com>
Subject: Re: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:25, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:01AM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
>
> [...]
>
> Nit: the subject line has misspelled PATCH as PATH
>
> I believe net-next is still closed so this code needs to be resent
> when net-next is open again in a few days.
>
sure,will fix  this
thanks
cindy

