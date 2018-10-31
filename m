From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 5/5] drm/virtio: bump driver version after explicit
	synchronization addition
Date: Wed, 31 Oct 2018 09:39:41 +0000
Message-ID: <CACvgo50szhS2+TMWWYwU2ctKeE6qddx2+AAuKWiL1SYp=XEjKg__33277.2404690788$1540978753$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-6-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-6-robert.foss@collabora.com>
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
Cc: Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>Gustavo Padovan <gustavo.padovan@collabora.co>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> To reflect the (backward compatible) changes in the uabi we are bumping
> the driver's version.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>

Not strictly required, but doesn't hurt either.
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
