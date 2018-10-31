From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 0/5] virgl: fence fd support
Date: Wed, 31 Oct 2018 09:45:05 +0000
Message-ID: <CACvgo50dph07XsrbeNJ_WcL0cTuiPG-viX9oczaVbsP9wKb9xw__8002.86506205357$1540979096$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-1-robert.foss@collabora.com>
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

Hi Rob,

On Thu, 25 Oct 2018 at 19:37, Robert Foss <robert.foss@collabora.com> wrote:
>
> This series implements fence support for drm/virtio and
> has been tested using qemu, kmscube and the below branches.
>
> Rob Herring solved a reference counting issue and
> suggested a context check for the execbuf ioctl, his
> changes have been included in the below commits to
> keep the tree working at all commits.
>
I've put forward some mostly minor suggestions.
The patches look pretty good but there's one piece missing:

>
> The linux series can be found here:
> https://gitlab.collabora.com/robertfoss/linux/commits/virtio_fences_v3
>
> As for mesa, the branch can be found here:
> https://gitlab.collabora.com/robertfoss/mesa/commits/virtio_fences_v3
>
Namely: This should be out for review. The kernel and userspace side
of IOCTLs should happen roughly at the same time.
Otherwise, there's a huge chance of merging one side of the component,
while the other needs architectural changes.

HTH
Emil
