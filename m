From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 14/18] drm/virtio: rework
	virtio_gpu_transfer_from_host_ioctl fencing
Date: Thu, 4 Jul 2019 13:47:56 +0200
Message-ID: <20190704114756.eavkszsgsyymns3m__25119.4116006204$1562240905$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-15-kraxel@redhat.com>
	<CAPaKu7T3GvYVMueYgJFhADFSFEVbHEdaupw8=mq_+i150a1mLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7T3GvYVMueYgJFhADFSFEVbHEdaupw8=mq_+i150a1mLA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 03, 2019 at 01:05:12PM -0700, Chia-I Wu wrote:
> On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Switch to the virtio_gpu_array_* helper workflow.
> (just repeating my question on patch 6)
> 
> Does this fix the obj refcount issue?  When was the issue introduced?

obj refcount should be fine in both old and new code.

old code:
  drm_gem_object_lookup
  drm_gem_object_put_unlocked

new code:
  virtio_gpu_array_from_handles
  virtio_gpu_array_put_free (in virtio_gpu_dequeue_ctrl_func).

Or did I miss something?

cheers,
  Gerd
