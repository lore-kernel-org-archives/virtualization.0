From: Jason Wang <jasowang@redhat.com>
Subject: Re: virtio-mmio: Delete an error message in vm_find_vqs()
Date: Thu, 9 Apr 2020 14:20:38 +0800
Message-ID: <6c94db13-ae46-cf8e-f3c4-6f270112ad87@redhat.com>
References: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
 <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
 <96031fc7-dced-95bd-fc57-a5fe890638f4@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <96031fc7-dced-95bd-fc57-a5fe890638f4@web.de>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javierm@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>, Stephen Boyd <swboyd@chromium.org>, Tang Bin <tangbin@cmss.chinamobile.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/9 =E4=B8=8B=E5=8D=882:02, Markus Elfring wrote:
>>> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error alre=
ady.
>>> Thus omit a redundant message for the exception handling in the
>>> calling function.
>> It looks to me that not all error path of platform_get_irq() were logg=
d.
> How do you think about to clarify the handling of the error code =E2=80=
=9C-EPROBE_DEFER=E2=80=9D any more?
> https://elixir.bootlin.com/linux/v5.6.3/source/drivers/base/platform.c#=
L202


Aha, it looks to me that I'm on the wrong branch. Sorry.


>
>
>> And git grep told me there're other users of platform_get_irq() that c=
heck and log by themselves.
> Source code analysis can point further update candidates out, can't it?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/base/platform.c?id=3D7723f4c5ecdb8d832f049f8483beb0d1081cedf6


Yes, it can.


>
> Would you like to achieve collateral evolution?


Yes and it's probably be better to put all the fixes in one series.

For this patch.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> Regards,
> Markus
>
