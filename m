From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Allow userspace to mmap() framebuffer
Date: Fri, 1 Mar 2019 06:51:35 +0100
Message-ID: <20190301055135.qqph6ggypjvhuoan__49465.4948169895$1551420129$gmane$org@sirius.home.kraxel.org>
References: <20190228164741.15590-1-JPEWhacker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190228164741.15590-1-JPEWhacker@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joshua Watt <jpewhacker@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2019 at 10:47:41AM -0600, Joshua Watt wrote:
> Reports the size of the virtgpu framebuffer to userspace and installs
> the deferred I/O handlers so that userspace can mmap() and write to it.

Fixed already, as side effect of switching virtio to the generic fbdev
emulation.  Patches are in the drm-misc-next branch and should land
upstream in the 5.1 merge window.

cheers,
  Gerd
