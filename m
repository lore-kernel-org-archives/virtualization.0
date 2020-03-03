From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 30/51] drm/cirrus: Fully embrace devm_
Date: Tue, 3 Mar 2020 08:51:57 +0100
Message-ID: <20200303075157.q5fhywk6lvmjbekv@sirius.home.kraxel.org>
References: <20200302222631.3861340-1-daniel.vetter@ffwll.ch>
 <20200302222631.3861340-31-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200302222631.3861340-31-daniel.vetter@ffwll.ch>
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

On Mon, Mar 02, 2020 at 11:26:10PM +0100, Daniel Vetter wrote:
> With the drm_device lifetime fun cleaned up there's nothing in the way
> anymore to use devm_ for everything hw releated. Do it, and in the
> process, throw out the entire onion unwinding.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
