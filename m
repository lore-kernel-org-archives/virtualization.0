From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Date: Thu, 23 Apr 2020 12:14:20 +0200
Message-ID: <20200423101420.ityynrorrehjvxrs@sirius.home.kraxel.org>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
 <20200422135215.GA25950@nuc8i5>
 <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
 <20200422152142.GA26943@nuc8i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422152142.GA26943@nuc8i5>
Sender: linux-kernel-owner@vger.kernel.org
To: Dejin Zheng <zhengdejin5@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> I am a newbie, andy gave me some directions to submit the patch, eg: check
> ioremap leak. At this time, I found that the bochs driver may have similar
> problems, so I submitted this patch, then, Andy said the best is to switch
> this driver to use pcim _ * () functions and drop tons of legacy code.
> I think we might be able to fix this issue first, after that, drop tons
> of legacy code by pcim_*() functions. Can you give me some suggestions?
> thank you very much!

drm has drmm_* functions for that.  Daniel Vetter <daniel@ffwll.ch> has
a patch series pending switching lots of drivers over and IIRC it fixes
this bug too.

cheers,
  Gerd
