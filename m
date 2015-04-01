From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/4] Add virtio-vga bits.
Date: Wed, 1 Apr 2015 15:26:26 +0200
Message-ID: <20150401152535-mutt-send-email-mst__31292.6845196218$1427894805$gmane$org@redhat.com>
References: <1427894130-14228-1-git-send-email-kraxel@redhat.com>
	<1427894130-14228-5-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427894130-14228-5-git-send-email-kraxel@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, airlied@redhat.com, airlied@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2015 at 03:15:30PM +0200, Gerd Hoffmann wrote:
> +static void virtio_pci_kick_out_firmware_fb(struct pci_dev *pci_dev)
> +{
> +	struct apertures_struct *ap;
> +	bool primary;
> +
> +	ap = alloc_apertures(1);
> +	if (!ap)
> +		return;
> +
> +	ap->ranges[0].base = pci_resource_start(pci_dev, 2);
> +	ap->ranges[0].size = pci_resource_len(pci_dev, 2);

I thought you mentioned it's better to switch to a different BAR
to be compatible with stdvga?

-- 
MST
