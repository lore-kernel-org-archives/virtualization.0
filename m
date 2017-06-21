From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 08/11] drm: nouveau: remove dead code and pointless local
	lut storage
Date: Wed, 21 Jun 2017 12:35:02 +0200
Message-ID: <abeaa572-c129-f942-1aa4-ec028da846be__20464.0674325221$1509078348$gmane$org@axentia.se>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
	<1497986735-14418-9-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497986735-14418-9-git-send-email-peda@axentia.se>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Jani Nikula <jani.nikula@linux.intel.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Yannick Fertre <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2017-06-20 21:25, Peter Rosin wrote:
> The redundant fb helpers .load_lut, .gamma_set and .gamma_get are
> no longer used. Remove the dead code and hook up the crtc .gamma_set
> to use the crtc gamma_store directly instead of duplicating that
> info locally.

[...]

> -	for (i = 0; i < 256; i++) {
> -		u16 r = nv_crtc->lut.r[i] >> 2;
> -		u16 g = nv_crtc->lut.g[i] >> 2;
> -		u16 b = nv_crtc->lut.b[i] >> 2;
> +	r = crtc->gamma_store;
> +	g = r + crtc->gamma_size;
> +	b = g + crtc->gamma_size;
>  
> +	for (i = 0; i < 256; i++) {
>  		if (disp->disp->oclass < GF110_DISP) {
> -			writew(r + 0x0000, lut + (i * 0x08) + 0);
> -			writew(g + 0x0000, lut + (i * 0x08) + 2);
> -			writew(b + 0x0000, lut + (i * 0x08) + 4);
> +			writew((*r++ >> 2) + 0x0000, lut + (i * 0x08) + 0);
> +			writew((*g++ >> 2) + 0x0000, lut + (i * 0x08) + 2);
> +			writew((*b++ >> 2) + 0x0000, lut + (i * 0x08) + 4);
>  		} else {
> -			writew(r + 0x6000, lut + (i * 0x20) + 0);
> -			writew(g + 0x6000, lut + (i * 0x20) + 2);
> -			writew(b + 0x6000, lut + (i * 0x20) + 4);
> +			writew((*r++ >> 2) + 0x6000, lut + (i * 0x20) + 0);
> +			writew((*g++ >> 2) + 0x6000, lut + (i * 0x20) + 2);
> +			writew((*b++ >> 2) + 0x6000, lut + (i * 0x20) + 4);
>  		}
>  	}
>  }

I forgot to mention this, but the above is very strange for
disp->disp->oclass >= GF110_DISP because 0x6000 interferes with
the 14 bits that appear to be the lut depth in the registers.

I suspect some other bit-shift should be used for that case?

Someone should probably consult a datasheet...

Cheers,
peda
