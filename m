From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix OOB in virtio_gpu_object_create
Date: Thu, 19 Mar 2020 12:02:30 +0100
Message-ID: <20200319110230.rxezuk3ex5fbov3f@sirius.home.kraxel.org>
References: <20200319100421.16267-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200319100421.16267-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 11:04:21AM +0100, Jiri Slaby wrote:
> After commit f651c8b05542, virtio_gpu_create_object allocates too small
> space to fit everything in. It is because it allocates struct
> virtio_gpu_object, but should allocate a newly added struct
> virtio_gpu_object_shmem which has 2 more members.
> 
> So fix that by using correct type in virtio_gpu_create_object.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>

That was fast.  Yes, exactly this.  Pushed to drm-misc-next.

thanks,
  Gerd
