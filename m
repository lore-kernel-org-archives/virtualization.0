Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221756;
	b=fzrM+CAVsYxezALCecjwqz5syUQzSophylmIAAirt6EWa07BE+qzjt6oT6tqhwHp2g6m
	 IwtrTVpagwMg0u78tcTiMQ8bDniJFsaLa9xpwhPSoMTWx+izyNfLvLhJqb3Vone3Oe6Le
	 HpCvCDx9LTJrtrAVjOdXLfGUonGVa59l4H6ViPkYEiqVf1PlGeBs9bDqO7ydSkz0o3d0z
	 nAh5Dlg3f8F5I+zHHvRZjBnzkPPM86HLqLTAiUJdc/cd/kkx6cYhTE00Z+YikN0YXBvII
	 UR1OS1yMTSeyPIwH1ZbfjQ1MHBgZIJj8+ABsGx8IUWLSLsWuggtvQi+K0OFkYkQrXFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
	b=1ExQyeT4z4k5ODTs6P74qBXWDf8fd0IUOoG73O6Ascnc2iGzkZe/RIcDGMbltFyptcDq
	 S4jYcs3cLr9BQUIdR1eUGY85Zj9+erWncvL4Mn1YXIg9AHR4YhRrrQS7zqTYkPCP+gg6U
	 fUcm7HzAuUNJs18gsGCxQplX/BSjuV/fdkU+bjQlDMhGgCiKaWKvXF1xb/8NCThwj9ryG
	 BWVMNRuRzmFoGr+pcuw0+oicnLRZLK/bVvC5egHY9koZtzN65693NlFZllJY8QgIoPADv
	 TaF/rb0D9QnI0caDXp0LMB9/Oa1zXZaqclh4e1+ItF+H9rnLfs4pbYhtUD++hx5NwsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySQhNaR4;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924F60A2600
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 00:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3924F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySQhNaR4
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3712b6d9843so1456010eec.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 16:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795221754; x=1795826554; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=ySQhNaR4A105sCW4CzRQpBxuV1imNEaCxaFcjXYvqBsH0bqHYFPs115DvfX7Gi2AE4
         8jvaoyo1os+CThX9wM90umr95eKfc1PQszrBCbVdNffHn/Lbj1MkkjW7vfFw2ZYhE9rK
         Yjz6u0FsKFmiHd/DGcxhiBcVtlcbo+41e2Bs1768Hiyn0zYjXalx4zHB67erc4AlE8FL
         iRCPrOBhONGbjKCxlP+AK9Sq4B9Bd0vVSR0ycKigRhJOSxzV2RjPTXk/bheKOxhdHxzF
         3lMfHmmUDHSgZkc79oaPeaSL5m1mZkT3xMPXIAZlA8YxctA0d/Bs4Y54FzuXCUHNwO/N
         qSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795221754; x=1795826554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Js5N6yiXwXXSTzZ4KgFGwIMSCZDX/tKTz1lwaDrh2ys=;
        b=Vd10Q+zzLxIqJTararvozVWU9OG2WtIBhzSXA5JxUp0Ek7p/Y6+xkN5conOgzU9uLM
         Po+UV+ZxMuw+Up4jHMTOZriG1kCUw2EpHVX/56uPDzl032ecoMSEZatZC3lhTkOKS/ys
         PjbuJqNQKnXYS8A4nHPjQNQ1NGXTMVM9bGxdKKPnqOoesUHT5BQOscd87A3uXLzFEcd6
         7votSFHHSN7P63F/tiMQwK+SScNcuZHbB3fGbHI/rQ8/an4XaaJhMMD20zbCIwQwprkb
         FHBELMUZa3dO0AZaNXnNIax1MfIC8dZTGnahu8D1w494wTpPckbhL4IkdRLGPxdOK8o3
         /D3w==
X-Forwarded-Encrypted: i=1; AL+hErEOYFV20RKp91SRmDwZh3307BlQZIPnS9PHFZygUEsCd0Wyc6BShQoQRri6bXS/lJKLyfkZlnr2llVsuknQBw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9S7Gdf4rT5U/cEgMmy9L7WeM7qAc/TKLHZp2V6P2JO5fsXNSH2
	iviwgsYvJrcDJ3EHgm6I/nLiGwEMuGZE/0rdVHzjfbsNeArvSCtwG5kO
X-Gm-Gg: AZFdTZfT6bjIgrZ8x/Q9+hMOQltZJ01CPMvt/IJsdiaa01yE+Ldklf3akBk3TTQ1vOk
	Pz8kXlMPrTLHhH42RCCJZhXDJTVsPFlnKk3x+gLadMgzyOSl7vRhIYyte0x+2JE6iZ7AL0kW9bD
	UxlH2XA3m5YUXSNzVsMOvaHZcW/+9j+EHr9i7NRE8xgNDs7KSdxczA8diap9gxsgO8sekPN6XFO
	qvBqojZjyB5aFgrHtURag1TzTes37f9s9MChhMI65+k+HmGi75XTXK1l34QlzPB6E1vWtZ4BWjF
	7QBtXwGm7ENBS2QFoOmL4h5yGPQPTivWJs0UVS6tXdMb8WtUH1SRKdHxv3HKarOZQ19JhAcwNzF
	WFFOc2pencxhsZuDE99XlX+59Um8JGzxvax/XFE8MG86ORTxhGwO9LSdAupn4MnO1fPpW9NlbY/
	vVKRTqTqcPwU+FLW+LO7MXABSQQY2eNSifE/tzsjG7vW8j2H9X+VHJxXA64umdhGiIjPkFJN4z4
	uF2BUveU30TLd8jVHOuvXDkxqzgf8WqV6+zOPRPwEo+FIp2T2flry36qeEIyv/CGVWwL+6M+Anu
	RU0JaB4DU0bb1z6oAMtWgqScMBxE5JqBeA==
X-Received: by 2002:a05:693c:4091:b0:379:4197:5eef with SMTP id 5a478bee46e88-3856f65b3cfmr5387027eec.8.1795221754060;
        Fri, 20 Nov 2026 16:42:34 -0800 (PST)
Received: from localhost ([2408:840d:6820:1a1b:6def:d896:8796:4938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm12699706eec.27.2026.11.20.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:42:33 -0800 (PST)
Date: Sat, 21 Nov 2026 08:42:28 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Yao Yuan <yaoyuan@linux.alibaba.com>, 
	Alex Williamson <alex@shazbot.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Lechner <dlechner@baylibre.com>, 
	Armin Wolf <W_Armin@gmx.de>, Thierry Reding <thierry.reding@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Marco Elver <elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Longfang Liu <liulongfang@huawei.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <awDok7Sm5Dgp-Ty-@sapienza>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
 <xzp5gljhburzbpol5bgnyyzwdrgpw3fj6ff3j23ein27raiidw@kti7moeuwvb5>
 <awBUG7-QzXplEiUT@monoceros>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awBUG7-QzXplEiUT@monoceros>

On Fri, Nov 20, 2026 at 03:10:38PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 20, 2026 at 10:17:46AM +0800, Yao Yuan wrote:
> > On Wed, Nov 18, 2026 at 04:56:44PM +0800, Alex Williamson wrote:
> > > Driver overrides are the standard mechanism for binding vfio drivers
> > > to devices.  With the introduction of the support_driver_override flag
> > > in the core driver struct, it's now required for drivers to declare
> > > themselves as driver_override compatible, otherwise driver_override
> > > bindings will be denied or generate a kernel taint.
> > >
> >
> > Hi Alex,
> >
> > > Set the support_driver_override flag on the driver struct across all
> > > vfio drivers.
> >
> > LGTM.
> >
> > Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
>

Hi Uwe,

> I missed your reply when I sent the next revision of this patch. I had

Thanks for your reminder, no big deal to me.
Let me follow your link to have a look on v2 there :-)

> to trim the recipients of the v2 because gmail refused to send it with
> everyone on Cc: who was emitted by get_maintainer.pl. So please see
> https://lore.kernel.org/kvm/fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com
>
> But also note, that if v2 is picked up using `b4 am`, your Reviewed-by:
> is considered as the patch didn't change.


>
> Best regards
> Uwe
