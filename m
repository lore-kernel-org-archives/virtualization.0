From: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
Date: Tue, 3 Mar 2020 11:42:22 +0900
Message-ID: <CAD=HUj5-0CE-tm4meQ_Y7KB4Df41v=kBH2GTStYJptTOSp1yVw@mail.gmail.com>
References: <20200302121524.7543-1-stevensd@chromium.org> <20200302121524.7543-5-stevensd@chromium.org>
 <CAAfnVBk46vsP77hx3kUHqVCPG8Eakh7Kgi0kEHZtrHD-0bHzqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <virtio-dev-return-6873-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <CAAfnVBk46vsP77hx3kUHqVCPG8Eakh7Kgi0kEHZtrHD-0bHzqQ@mail.gmail.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

> cmd_p->hdr.ctx_id =
>
> Before this completion of this hypercall, this resource can be
> considered context local, while afterward it can be considered
> "exported".

Maybe I'm misunderstanding render contexts, but exporting a resource
doesn't seem related to render contexts. The other resource management
operations (e.g. creation, attaching a backing) don't take render
contexts, and exporting a resource seems like the same sort of
operation. It's not clear to me why exporting a resource would affect
what render contexts a resource has been attached to, nor why the
render contexts a resource has been attached to would affect exporting
the resource. Also, from an implementation perspective, I don't see
any struct virtio_gpu_fpriv to get the ctx_id from.

-David
