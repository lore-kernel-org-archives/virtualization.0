From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] rpmsg: fix kconfig dependencies for VIRTIO
Date: Sun, 21 Apr 2013 16:56:15 +0300
Message-ID: <CAK=WgbbM_Cphbvcqh991oEmrFTsbWn4hDkyA4U9P74UrXgq+Xw@mail.gmail.com>
References: <1366133126-5448-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1366133126-5448-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Suman Anna <s-anna@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 16, 2013 at 8:25 PM, Suman Anna <s-anna@ti.com> wrote:
> rpmsg configuration selects VIRTIO, but VIRTIO is now
> subordinate to VIRTUALIZATION. RPMSG is currently selected
> by OMAP_REMOTEPROC, and the dependency warning is not seen
> with the fix in remoteproc config, but the kconfig menu
> hierarchy dependency has to be honored nevertheless.
>
> warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
> warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Applied, thanks!
