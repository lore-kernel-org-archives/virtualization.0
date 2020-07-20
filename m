From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2] drm/virtio: Fix memory leak in
 virtio_gpu_execbuffer_ioctl()
Date: Mon, 20 Jul 2020 17:29:01 +0200
Message-ID: <4c3fb9c5-b386-64d7-5d3f-d8633b881222@web.de>
References: <20200720144407.13706-1-hexin.op@bytedance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720144407.13706-1-hexin.op@bytedance.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: hexin.op@bytedance.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Liu Qi <liuqi.16@bytedance.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

> =E2=80=A6 To balance the reference
> count initialized when allocating fence, dma_fence_put()
> should not be deleted.

* Would an imperative wording be more appropriate for the change descripti=
on?

* Is the information =E2=80=9Chexin=E2=80=9D sufficient for a real name?

Regards,
Markus
