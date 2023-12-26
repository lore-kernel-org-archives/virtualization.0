Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873C23C6
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKVRSDu2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d42ed4cdc7so316855ad.0
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703621964; x=1704226764; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy7OBrlPSY6+TWnz2A3BwrQfBm97ETQ3NJPDilJmZtI=;
        b=DKVRSDu2XDvSqZH2o3hmkl54QK7Jjrvh6GWW7d8KVzqvpoQbuKMzdjp9rUhcuA/N70
         P23cNwke4NnjLKW2jGXEWEnpOO3TH66HB19aNdjrI5leEV5FNXdnZY/o0pGjca5fo8Wu
         var2sh+vCoi0mfvNnE03N90wnI+aNUivZQ+bwvqAckCjyo4YeFPJYYN05//g5VqFVffH
         sfq4iH8AOFiGp1UsYOuNeFBDexnQcUg44IopCNARGU7Y/1hP+GclsHgYBQCGDyhnQEmj
         2DeDQWf+mAYcFvQi8iFLPLvG/fqc7To4bl98ZRA7PDNZrENKpVKFjbOphoVWG60t9H0H
         43jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703621964; x=1704226764;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy7OBrlPSY6+TWnz2A3BwrQfBm97ETQ3NJPDilJmZtI=;
        b=wOFxjlLgAKosZxnHisRhEj1Qa0Kh4lMbG7EpK4tiJIRn9lKLIkEMqWta3N+4zOG3ah
         GsLYBt2z8icXhPfeobzsGhAxoH0EIVVvG5Nh10/x3Nkxh8yVhgfctvALWwHS4P4G8JDP
         5fdgzDdPH2cMBxOPYHC9jlH0HaIIrYk8Ig79778Yc51724h/KJ69PbSnaFJ5rSZ0/AUq
         VVttEDbZmPy0tA4S6KTXq1grQCB2Ce83QOobPRlIShlCgxRvYQ4c3oGJeUj6sdVr7jkI
         QF6skzrnm0NHl8kLszTDp5IXVCdBv9eiwraVZxNvjdfcX5ckvnD0OeuUrAv8AVqcbjLI
         q5dQ==
X-Gm-Message-State: AOJu0YzyXb8SsOcbqbf2tknjNJpaaa705RYJHVKw43P7wmahtvz1hVL8
	El6ElA1Z2dmSLz+WRNoo6+CqJbeExQc7
X-Google-Smtp-Source: AGHT+IGb8BUs88EqjDGKSeSrkFRE+ApjMpYa7VzQ0qV38ikOSCyzYuc1Yj/kXHPVV1FhfDw5/Q0rNA==
X-Received: by 2002:a17:902:fd43:b0:1d3:f25c:7d69 with SMTP id mq3-20020a170902fd4300b001d3f25c7d69mr470013plb.12.1703621964106;
        Tue, 26 Dec 2023 12:19:24 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id pg6-20020a17090b1e0600b0028c30430deesm6700117pjb.33.2023.12.26.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:19:23 -0800 (PST)
Date: Tue, 26 Dec 2023 12:19:22 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, 
    jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost-vdpa: account iommu allocations
In-Reply-To: <20231226182827.294158-1-pasha.tatashin@soleen.com>
Message-ID: <a9721920-6a87-8f68-3ff8-6cb691fe9465@google.com>
References: <20231226182827.294158-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
