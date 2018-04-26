From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Date: Thu, 26 Apr 2018 15:52:42 +0200
Message-ID: <CAKMK7uEsL7y8QnPhKu8N+-v3XmdPppqD+Z2ywt-P2Kv91Xq6Bw__14368.9572382302$1524750670$gmane$org@mail.gmail.com>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
	<20180426123615.GA12521@phenom.ffwll.local>
	<1556510.Xu6NnhyFGZ@avalon> <20180426131404.GP4813@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426131404.GP4813@piout.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dave Airlie <airlied@linux.ie>, Nouveau Dev <nouveau@lists.freedesktop.org>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Marek Vasut <marex@denx.de>, Chunming Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Xinliang Liu <z.liuxinliang@hisilicon.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Xinwei
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 26, 2018 at 3:14 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Hi,
>
> On 26/04/2018 15:45:44+0300, Laurent Pinchart wrote:
>> Hi Daniel,
>>
>> On Thursday, 26 April 2018 15:36:15 EEST Daniel Vetter wrote:
>> > On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
>> > > It's been a while since we introduced drm_dev{get/put} functions
>> > > to replace reference/unreference in drm subsystem for the
>> > > consistency purpose. So, with this patch, let's just replace
>> > > all current use cases of drm_dev_unref() with drm_dev_put and remove
>> > > the function itself.
>> > >
>> > > Coccinelle was used for mass-patching.
>> > >
>> > > Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>> >
>> > Thanks for doing this. Unfortunately drm moves pretty fast, so already a
>> > conflict when I tried to apply this. Some drivers are also in their own
>> > trees, so this might lead to more fun :-/
>> >
>> > Can you pls split it up per-driver (just the directories under
>> > drivers/gpu/drm/ is enough)? Final patch to remove the function might then
>> > get stalled a bit ofc.
>>
>> I requested a single patch instead of splitting it per driver, you might want
>> to blame me for that.
>>
>
> Doesn't splitting the change per driver break bisectability unless there
> is a guarantee that the change in include/drm/drm_drv.h is applied after
> all the driver trees have been merged?

That's why I said the final patch will likely take a bit longer to get
merged, since we have to wait until all the trees converge again. But
since I have conflicts already looks like we can't take the shortcut
:-(
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
