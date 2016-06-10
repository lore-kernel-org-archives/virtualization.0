From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 06/20] drm: i915: Rely on the default ->best_encoder()
	behavior where appropriate
Date: Fri, 10 Jun 2016 18:41:52 +0200
Message-ID: <20160610164152.GO3363__22303.5452342176$1465576935$gmane$org@phenom.ffwll.local>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
	<1465300095-16971-7-git-send-email-boris.brezillon@free-electrons.com>
	<20160610152412.GL3363@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160610152412.GL3363@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Alexey Brodkin <abrodkin@synopsys.com>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@freescale.com>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mark Yao <mark.yao@rock-chips.com>, Heiko Stuebner <heiko@snte>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 10, 2016 at 05:24:12PM +0200, Daniel Vetter wrote:
> On Tue, Jun 07, 2016 at 01:48:01PM +0200, Boris Brezillon wrote:
> > For all outputs except dp_mst, we have a 1:1 relationship between
> > connectors and encoders and the driver is relying on the atomic helpers:
> > we can drop the custom ->best_encoder() implementation and let the core
> > call drm_atomic_helper_best_encoder() for us.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> You can also drop the best_encoder from intel_dp_mst, we only need the
> atomic_best_encoder. The best_encoder there was needed to help out the
> fbdev emulation. Care to respin?

Boris pointed out on irc that this won't work for the fbdev stuff since
that has a WARN_ON if theres more than 1 possible encoder. Applied this
one here instead.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
