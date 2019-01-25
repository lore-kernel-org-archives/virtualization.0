From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
	drm_irq_(un)install
Date: Fri, 25 Jan 2019 11:40:32 +0100
Message-ID: <20190125104032.GA27214__746.760789637335$1548442290$gmane$org@ravnborg.org>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
	<20190124165831.16427-2-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190124165831.16427-2-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, linux-amlogic@lists.infradead.org, freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel.

On Thu, Jan 24, 2019 at 05:58:06PM +0100, Daniel Vetter wrote:
> If a non-legacy driver calls these it's valid to assume there is
> interrupt support. The flag is really only needed for legacy drivers.
> 
> Also remove all the flag usage from non-legacy drivers.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org

The actual code changes looks good.
But if this is the right thing to do I cannot tell.

On this (limited) basis I provide an:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
