From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [PATCH 01/20] drm/atomic: Fix remaining places where
	!funcs->best_encoder is valid
Date: Thu, 2 Jun 2016 23:40:04 +0100
Message-ID: <20160602224004.GA1819__20888.8725880117$1465252414$gmane$org@nuc-i3427.alporthouse.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
	<1464877907-27723-2-git-send-email-boris.brezillon@free-electrons.com>
	<8671722.LHaiaBNqfE@avalon>
	<CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Re ding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Alexey Brodkin <abrodkin@synopsys.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>in
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 02, 2016 at 11:57:02PM +0200, Daniel Vetter wrote:
> drm_encoder_find is an idr lookup. That should be plenty fast,
> especially for modeset code. Usually what's too expensive even for
> modeset code is linear list walks. But Chris just submitted patches to
> convert most of them into simple lookups.

For the idr_find, I'm tempted to replace the mutex with a rwlock. It
helps pathological cases, but in reality there are more crucial
locks around the hw that limit concurrency. ;-)
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
