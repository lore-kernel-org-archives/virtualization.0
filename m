From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec include
	file
Date: Thu, 11 Sep 2014 16:15:14 +0100
Message-ID: <CAFEAcA9TZPxJi9V8EYTKvgQ_tj8VgrHTT_CRQ0=O8KhuX7tH7w__27421.5605263182$1410448581$gmane$org@mail.gmail.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410448173-12960-2-git-send-email-kraxel@redhat.com>
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
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, QEMU Developers <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11 September 2014 16:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
> This patch adds the header file with structs and defines for
> the virtio based gpu device.  Covers 2d operations only.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/virtio/virtgpu_hw.h | 158 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 include/hw/virtio/virtgpu_hw.h
>
> diff --git a/include/hw/virtio/virtgpu_hw.h b/include/hw/virtio/virtgpu_hw.h
> new file mode 100644
> index 0000000..461f452
> --- /dev/null
> +++ b/include/hw/virtio/virtgpu_hw.h
> @@ -0,0 +1,158 @@
> +#ifndef VIRTGPU_HW_H
> +#define VIRTGPU_HW_H
> +
> +enum virtgpu_ctrl_type {
> +        VIRTGPU_UNDEFINED = 0,
>

This is clearly all well out of line with our
coding style guide, which isn't a terribly good start...

thanks
-- PMM
