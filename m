From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/16] drm: fixes crct set_mode when crtc mode_fixup is
	null.
Date: Tue, 16 Feb 2016 20:39:41 +0100
Message-ID: <20160216193941.GB32705__22163.5332367898$1455651574$gmane$org@phenom.ffwll.local>
References: <cover.1455630967.git.palminha@synopsys.com>
	<9d41105dee6632b4bb50e9555f2196ac249b9fce.1455630967.git.palminha@synopsys.com>
	<56C35E59.8070805@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56C35E59.8070805@cogentembedded.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, airlied@linux.ie, daniel.vetter@ffwll.ch, alison.wang@freescale.com, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, jani.nikula@intel.com, patrik.r.jakobsson@gmail.com, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com, laurent.pinchart@ideasonboard.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 16, 2016 at 08:37:29PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/16/2016 05:10 PM, Carlos Palminha wrote:
> 
> >This patch set nukes all the dummy crtc mode_fixup implementations.
> >(made on top of Daniel topic/drm-misc branch)
> >
> >Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> >---
> >  drivers/gpu/drm/drm_crtc_helper.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> >index e70d064..7539eea 100644
> >--- a/drivers/gpu/drm/drm_crtc_helper.c
> >+++ b/drivers/gpu/drm/drm_crtc_helper.c
> >@@ -343,9 +343,12 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
> >  		}
> >  	}
> >
> >-	if (!(ret = crtc_funcs->mode_fixup(crtc, mode, adjusted_mode))) {
> >-		DRM_DEBUG_KMS("CRTC fixup failed\n");
> >-		goto done;
> >+	if (crtc_funcs->mode_fixup) {
> >+		if (!(ret = crtc_funcs->mode_fixup(crtc, mode,
> >+						adjusted_mode))) {
> 
>    You haven't run the patch thru scripts/checkpatch.pl, have you? :-)
> (It curses on assignment inside the *if* expression.)

pre-existing, so checkpatch.pl doesn't get a vote ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
