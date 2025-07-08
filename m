Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB51401B
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934733; cv=none; b=ZTDiF0AiaSi0QXuSSmd2+C4dJrWNpM3NrZhsn/korJHXJJvnJOIFqQ+X1+ivbz8LIBeJvB9g6Y9Pf401g8bMUgERdBsCvlGy+/O9hgzzmAnhu4G+YGa3jx3wHwEwgptExMKvQhLj6o+L/WdWQoHUQ+t17a7vwURFWcWNLw5fzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934733; c=relaxed/simple;
	bh=lpBAjx+9OIWwohLyRF71S4GHKzadfqw3ME6fZ9/uARg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjgRhsDywaHXQ6qNkLrNu2eq6DX6390CaSd3pWK+IEI0kr5fQCledY80t7ituIy4v+VMuWZft1kdw+X3X+SuZ2AYFrQmrsCDe1It9huaH2iKspPmbb7I1Z12DpmLg57NZe/i6Pq3VhKrqGga5+9i76qVUqOy7xyW9CCrUHttb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Jul 2025 09:31:00 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 34C662069FF1;
	Tue,  8 Jul 2025 09:31:00 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 8 Jul 2025 09:31:00 +0900
Received: from [10.212.247.77] (unknown [10.212.247.77])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 3CC7B10D84B;
	Tue,  8 Jul 2025 09:30:59 +0900 (JST)
Message-ID: <c300d168-797e-4812-b957-1b761e40ea44@socionext.com>
Date: Tue, 8 Jul 2025 09:30:57 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] gpio: uniphier: use new GPIO line value setter
 callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
 <20250707-gpiochip-set-rv-gpio-round4-v1-10-35668aaaf6d2@linaro.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250707-gpiochip-set-rv-gpio-round4-v1-10-35668aaaf6d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bartosz,

On 2025/07/07 16:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/gpio/gpio-uniphier.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Looks good to me.

Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
