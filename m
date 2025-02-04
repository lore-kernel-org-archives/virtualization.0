Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B19215F45
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692463; cv=none; b=ujufY+8eUFtQNR3C+XtK057o1WkxCFUj8Xw4yg9kPGL7kRm6Jy7h/bTJspLPwvAqTTkzo3MdR68RKuW67YATQd++xw68F/zs25ru91kKJ31lAliSDkLsxYc9WLU+MuMgicPr17hY8Fx2tGRt6mytwBoIoaa46Xqnu09SLWkv+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692463; c=relaxed/simple;
	bh=uy2RAO0HREHk9jFjYXKnTRCWdGyyTgpHnGz4Tb6pK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl8CFQ6Sci+jGNOb0MuXmDNl49dJ6rqKE2h4eajXrNDZl+4eJ7bNi0myVnaYg+1BQdqAE6WHCmRg5nuWWZPWIkPrkqCVw1m153uoTzMXwBLEEV4JKlXAjF/LxTvgfKiIwatDc95TjFDLfPMvsJ602Z04TK8WM6qta4RlQrMmDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avRfbrgo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avRfbrgo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb95317so105140005ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692461; x=1739297261; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUWVYRjU/T6AKCeZ6ytji12eJGMYrefQ1/hONpq4u3U=;
        b=avRfbrgo1cnTp6Sb9dC/HbnzHq++iKD2pNmTboQU8q7w62sgApSlvjITb0Q4zCWfOk
         c/t8cbIWLDTlg47xYlLqfkzhG7pvb6XUZUGJ9AzgCpeMJQcBQstUAt04J7NtJUp/+dvX
         icZCZrUNtKroUWJYmtYUJjtKYs0BPqZY5Lp4SaKrtKc84kVLWthVQ9vnBTuR5eY7PN0m
         V8UlakKguRjfEqgpQQQlttH50vlOCG2803KMSrABPDIPN/kfQwlmrIYRNnDKBz3R/PZ3
         BIy4JjKOmRsguLvNUp/qkGDOCVMJomCm6yrvFWwhWbv4Tmie9dU9r7RuX5etiD/QrhQ0
         2A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692461; x=1739297261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUWVYRjU/T6AKCeZ6ytji12eJGMYrefQ1/hONpq4u3U=;
        b=VsoDbojiQ1G0WarThezDk0KOjz5IG7AwWgs+VJyYcNuovxxdqfHIcNsXgAXIG1KlNN
         z7CwKPvj6Ypy5JppCg7xfn+F+sHqLER1W83bGZ2BdhFCJGUAtrViR7KbdYLDHCl47huQ
         Rw2EyRxDNutzpfkxUHfVRgTXGBOLn7hNCZgM3UesGGqlhqhA5ppa3/1CX0/IXFID9sb1
         oHTjtLFWmzSqRQgySuukhZWLawFC0mJdkKEse8hEIZFEgein0/zp04gQ97hrZ9Ph0Xf+
         03iTXOFyj4/T0jrEa9Dy4+yhrkxKKDMoQrNJo6uwp5ihTGbIweLGq4kys0NI7DY8tWqu
         hr+w==
X-Forwarded-Encrypted: i=1; AJvYcCVwf8HZXTwOn1KY0vR0adWypr8bDLAqoBYK7FI7Z9W06AZFDlH+joSyi0w8M9GRHj0S7euO+Pj6xqS2sz578Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcg1m6Y0oJlCOr98vPa4A3jRc/o7Yg5t4JNjjbeegRRqJPW2dy
	DcPZ3JImuSpOtRDttfpo1ppJzH9JbZo8W/aqqS5RZtwCUhNv8Us=
X-Gm-Gg: ASbGnctlmRAucEB+a4BVWzIhnRWcGpVnhFimeaxHAl8Op5CyknQntTztSdhNpdu49fe
	vCUjiYUJLgxuJ3t3XlgFyesg255bNkT0vHV+/rNpSSmEb0Ktu193IogGbiIsPW+zgRIRVn1GSie
	Zgaep83g7n3n+fi1YZZ+rJe/WhMxrp88Z4Ep8BWP5pFYE3VatnTfc1xWJhLzXK1/qVioLVuNuq5
	gCKqJXAnnzdF/fjp2jUCGEpgT8DSeYckec9EMJ4xX8rQDe/T9Y+kzlAdpnv0ZKIdqwNI7wmQQLa
	1lLAqLgGz9rxJHY=
X-Google-Smtp-Source: AGHT+IHqa3+XR4upxc7fln2BlqQH6Kpwtj8kZ27zpZtWrtWOX/qB2ZjoxFzkwLakAGYO1L0PhSn1Ew==
X-Received: by 2002:a05:6a20:9f45:b0:1ea:ddd1:2fcf with SMTP id adf61e73a8af0-1ed7a462e94mr41721024637.4.1738692460711;
        Tue, 04 Feb 2025 10:07:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-acec0a65716sm8720645a12.68.2025.02.04.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:07:40 -0800 (PST)
Date: Tue, 4 Feb 2025 10:07:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z6JXaz1AwMhN1wvL@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
 <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
 <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
 <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 9:56 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 2/4/25 6:35 PM, Mina Almasry wrote:
> > > On Tue, Feb 4, 2025 at 4:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > >>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
> > >>>  1 file changed, 289 insertions(+), 11 deletions(-)
> > >>
> > >> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
> > >> only in server (rx) mode, so the tx path is not actually exercised ?!?
> > >>
> > >
> > > Yeah, to be honest I have a collection of local bash scripts that
> > > invoke ncdevmem in different ways for my testing, and I have docs on
> > > top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> > > to look at adding test cases to devmem.py as a follow up, if it's OK
> > > with you, and Stan offered as well on an earlier revision. If not no
> > > problem, I can address in this series. The only issue is that I have
> > > some legwork to enable devmem.py on my test setup/distro, but the meat
> > > of the tests is already included and passing in this series (when
> > > invoked manually).
> >
> > I think it would be better if you could include at least a very basic
> > test-case for the TX path. More accurate coverage could be a follow-up.
> >
> 
> Thanks; will do.

This is what I've been using to test tx-only and tx-rx modes (shared
previously on the list as well):
https://github.com/fomichev/linux/commit/df5ef094db57f6c49603e6be5730782e379dd237

Feel free to include in the v4.
