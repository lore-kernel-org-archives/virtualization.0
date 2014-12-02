From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v5 07/19] virtio: allow virtio-1 queue layout
Date: Tue, 2 Dec 2014 21:03:45 +0200
Message-ID: <20141202190345.GA5185@redhat.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-8-git-send-email-cornelia.huck@de.ibm.com>
	<20141202144628.GA2974@redhat.com>
	<20141202155444.0731c48f.cornelia.huck@de.ibm.com>
	<20141202164136.1a57f358.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141202164136.1a57f358.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 02, 2014 at 04:41:36PM +0100, Cornelia Huck wrote:
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
>  {
> +    /*
> +     * For virtio-1 devices, the number of buffers may only be
> +     * updated if the ring addresses have not yet been set up.

Where does it say that?

> +     */
> +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +        vdev->vq[n].vring.desc) {
> +        error_report("tried to modify buffer num for virtio-1 device");
> +        return;
> +    }
>      /* Don't allow guest to flip queue between existent and
>       * nonexistent states, or to set it to an invalid size.
>       */
