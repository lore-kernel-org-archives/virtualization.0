From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 31/52] drm/cirrus: Fully embrace devm_
Date: Mon, 24 Feb 2020 09:18:14 +0100
Message-ID: <20200224081814.fupiz5lo35vmvma4@sirius.home.kraxel.org>
References: <20200219102122.1607365-1-daniel.vetter@ffwll.ch>
 <20200219102122.1607365-32-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200219102122.1607365-32-daniel.vetter@ffwll.ch>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 19, 2020 at 11:21:01AM +0100, Daniel Vetter wrote:
> With the drm_device lifetime fun cleaned up there's nothing in the way
> anymore to use devm_ for everything hw releated. Do it, and in the
> process, throw out the entire onion unwinding.
> =

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Emil Velikov <emil.velikov@collabora.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
