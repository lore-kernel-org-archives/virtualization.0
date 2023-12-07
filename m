Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA0101DE
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LI2U3N8Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BE4C423E2
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BE4C423E2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=LI2U3N8Y
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c9wZZd1f2Y_x
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 14:46:19 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4659D4227B
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4659D4227B
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso2036975e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Dec 2023 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701960377; x=1702565177; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+SZx05QL8DvnaBiqNo+wDKuA3Gr0caBrn6hcV+55hc=;
        b=LI2U3N8YkbJMXSwd5iQSDiOB2b51oq+Ih00QtWdlcOuZfsxl22DW8deiSvr/aK5160
         iloKGVc0ISB4Qd1EQSacImPZmz1j0wFPr6P1iO4zdyHk1vlw9l5Vmlr5LGt6SfJbE/d+
         NxBBNikkRqPgdf8jiCEoTOBcq8AkrtjXJQNrNeA65ejtTnTzTJFEa8abmc9hWO9LPQB1
         j7lCyky6GvxgiAXKh39X5kACB+Fwwl1cGENlzLxB7yC+UW4Ic2ry1Fqhkb+9oQ1reh1e
         xq9TOn2xh6YJ2TYQiFCXCu20i5na2j69DS8ogsfsy2lultpH55c0UvTYLFcSAUriwlh8
         uQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960377; x=1702565177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+SZx05QL8DvnaBiqNo+wDKuA3Gr0caBrn6hcV+55hc=;
        b=btJKeXKfJW9d1pZVQApOQD3IWqqcyPOPxFRQMpUHKiTPOztcEJbJChQKiLazuAMVYe
         E08/rg9hXHNQqGbjVJK3SK8DZj1winkB19wjae/yfF4N5T9NOnvjPU84CcuWufmJBQJ0
         x7MMKkv0EQif5SaWV1hlPktx6p8gaKbP6JVR0aHhV8pdmfmXpXyHRki4BlB7PdslxQHa
         5a1w8hxjqif8UZAyQISpQb61JTXtvFqPqUO5YCRGvt+xNRls5XIp2Dqf8RWIvflmZFR8
         j6jESh2kNwtmXVqc81kPsmBiDVceTkMbAr/7mQOlThqCzlnKVePErZeqj0wNEie+ULyH
         7/7w==
X-Gm-Message-State: AOJu0YzbgezaTXiSF9bQxF2Am5WWl0xSFRd9zOtLGQwcRRYBTbk3qQ4Y
	GDTuY4MptbuIDhy98whbPL8Vfg==
X-Google-Smtp-Source: AGHT+IHVym4Nz6MBkeoRJw8LxZvSVQ6n6JQRhDlWhvCA++GrRUuK2yBbo0vI0w9nDC38Cf7gzYDwog==
X-Received: by 2002:a05:600c:548a:b0:40b:5e4a:2347 with SMTP id iv10-20020a05600c548a00b0040b5e4a2347mr2748346wmb.73.1701960377359;
        Thu, 07 Dec 2023 06:46:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm2182749wmo.16.2023.12.07.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:46:16 -0800 (PST)
Date: Thu, 7 Dec 2023 15:46:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, atishp@atishpatra.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org
Subject: Re: [PATCH v1 04/14] RISC-V: paravirt: Add kconfigs
Message-ID: <20231207-963f31814d2502cbc058647c@orel>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
 <20231205181119.207204-20-ajones@ventanamicro.com>
 <20231207-unsealed-bunkhouse-bd79271b4896@wendy>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-unsealed-bunkhouse-bd79271b4896@wendy>

On Thu, Dec 07, 2023 at 02:07:28PM +0000, Conor Dooley wrote:
> On Tue, Dec 05, 2023 at 07:11:24PM +0100, Andrew Jones wrote:
> > Now that we can support steal-time accounting, add the kconfig
> > knobs allowing it to be enabled.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> In hindsight, should this be squashed with the code actually adding the
> support?

Yeah, this can be squashed, particularly because the configs are off by
default anyway. Will do.

Thanks,
drew
