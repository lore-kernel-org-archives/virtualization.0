From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
Date: Thu, 4 Apr 2019 23:51:30 -0700
Message-ID: <CAMo8BfL3Y6BZwOR7i9FiUdoRBtdy31_VC0t4FWrUr8L9pKvxJw__48246.6554663674$1555717915$gmane$org@mail.gmail.com>
References: <20190405044602.2334-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405044602.2334-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 4, 2019 at 9:46 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> drm_connector_update_edid_property can sleep, we must not
> call it while holding a spinlock.  Move the callsize.
>
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This change fixes the warning for me, thanks!
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
