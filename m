From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v3 11/12] drm/virtio: switch from ttm to gem shmem helpers
Date: Wed, 19 Jun 2019 11:40:14 +0100
Message-ID: <20190619104014.GB1896__1961.95574696816$1560940951$gmane$org@arch-x1c3>
References: <20190619090420.6667-1-kraxel@redhat.com>
	<20190619090420.6667-12-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-12-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd,

On 2019/06/19, Gerd Hoffmann wrote:

> -static void virtio_gpu_init_ttm_placement(struct virtio_gpu_object *vgbo)
> +static const struct drm_gem_object_funcs v3d_gem_funcs = {
s/v3d/virtio/g

Doubt I'll have the time for a proper review - just this and the 1/12 nits :-\

HTH
Emil
