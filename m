From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 10/52] drm/cirrus: Use drmm_add_final_kfree
Date: Mon, 24 Feb 2020 09:13:36 +0100
Message-ID: <20200224081336.dhzkrwst4dyuyurq@sirius.home.kraxel.org>
References: <20200219102122.1607365-1-daniel.vetter@ffwll.ch>
 <20200219102122.1607365-11-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200219102122.1607365-11-daniel.vetter@ffwll.ch>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 19, 2020 at 11:20:40AM +0100, Daniel Vetter wrote:
> With this we can drop the final kfree from the release function.
> 
> I also noticed that cirrus forgot to call drm_dev_fini().
> 
> v2: Don't call kfree(cirrus) after we've handed overship of that to
> drm_device and the drmm_ stuff.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
