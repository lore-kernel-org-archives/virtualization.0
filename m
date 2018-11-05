From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
	synchronization
Date: Mon, 5 Nov 2018 17:25:05 +0000
Message-ID: <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ__40126.9838483588$1541438670$gmane$org@mail.gmail.com>
References: <20181105114152.2088-1-robert.foss@collabora.com>
	<20181105114152.2088-4-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181105114152.2088-4-robert.foss@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
>
> When the execbuf call receives an in-fence it will get the dma_fence
> related to that fence fd and wait on it before submitting the draw call.
>
> On the out-fence side we get fence returned by the submitted draw call
> and attach it to a sync_file and send the sync_file fd to userspace. On
> error -1 is returned to userspace.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> ---
>
> Changes since v3:
>  - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
Fwiw my suggestion was to explicitly document whether the IOCTL can
support, simultaneously, IN and OUT fence.
Merging the two patches makes things a bit meh. But as before - it's
for Gerd to make the final call.

-Emil
