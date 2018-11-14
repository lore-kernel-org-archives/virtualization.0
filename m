From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 0/4] virgl: fence fd support
Date: Wed, 14 Nov 2018 13:14:12 +0100
Message-ID: <20181114121412.zm24ua4np3yi5gxx__11464.3600456931$1542197535$gmane$org@sirius.home.kraxel.org>
References: <20181112165157.32765-1-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181112165157.32765-1-robert.foss@collabora.com>
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
Cc: Rob Herring <robh@kernel.org>, airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 12, 2018 at 05:51:53PM +0100, Robert Foss wrote:
> 
> This series implements fence support for drm/virtio and
> has been tested using qemu, kmscube and the below branches.
> 
> Rob Herring solved a reference counting issue and
> suggested a context check for the execbuf ioctl, his
> changes have been included in the below commits to
> keep the tree working at all commits.

Patches added to qemu queue, should land in drm-misc-next soon.

thanks,
  Gerd
