From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/8] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date: Tue, 17 Sep 2019 10:18:18 +0200
Message-ID: <20190917081818.4lumcpn4wf6jcuyt__35836.0743661009$1568708313$gmane$org@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
	<20190913122908.784-4-kraxel@redhat.com>
	<CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Thomas Zimmermann <tzimmermann@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Steven Price <steven.price@arm.com>, Hans de Goede <hdegoede@redhat.com>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 16, 2019 at 05:07:14PM -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 7:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> 
> Version? Pretty sure this is not v1.

Yep, was posted as part of a longer series before.

Splitted the long series into multiple smaller ones by cherry-picking
patches into new branches, which re-started the numbering.

Sorry for the confusion,
  Gerd
