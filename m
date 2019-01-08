From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Remove incorrect kfree()
Date: Tue, 8 Jan 2019 11:40:51 +0100
Message-ID: <20190108104051.nropnyozq7cvhp6s__21072.4454293542$1546943932$gmane$org@sirius.home.kraxel.org>
References: <20190102175507.4653-1-ezequiel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190102175507.4653-1-ezequiel@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 02, 2019 at 02:55:06PM -0300, Ezequiel Garcia wrote:
> The virtio_gpu_output is a member of struct virtio_gpu_device
> and is not a dynamically-allocated chunk, so it's wrong to kfree() it.
> Removing it fixes a memory corruption BUG() that can be triggered
> when the virtio-gpu driver is removed.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Both patches are queued up.

thanks,
  Gerd
