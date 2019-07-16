From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v2 2/3] drm: plumb attaching dev thru to prime_pin/unpin
Date: Tue, 16 Jul 2019 20:52:29 +0100
Message-ID: <156330674940.9436.18083089508232951941__9312.59732912935$1563306773$gmane$org@skylake-alporthouse-com>
References: <20190716174331.7371-1-robdclark@gmail.com>
	<20190716174331.7371-2-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190716174331.7371-2-robdclark@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Eric Biggers <ebiggers@google.com>, Maxime Ripard <maxime.ripard@bootlin.com>, nouveau@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>, virtualization@lists.linux-foundation.org, Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>, Laura Abbott <labbott@redhat.com>, Deepak Sharma <deepak.sharma@amd.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, etnaviv@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, spice-devel@list
List-Id: virtualization@lists.linuxfoundation.org

Quoting Rob Clark (2019-07-16 18:43:22)
> From: Rob Clark <robdclark@chromium.org>
> 
> Needed in the following patch for cache operations.

What's the base for this patch? (I'm missing the ancestor for drm_gem.c)
-Chris
