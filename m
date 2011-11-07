From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-pci: fix use after free
Date: Tue, 08 Nov 2011 09:42:01 +1030
Message-ID: <87fwhzsf26.fsf@rustcorp.com.au>
References: <20111107163703.GA10358@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111107163703.GA10358@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: stable@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 7 Nov 2011 18:37:05 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Commit 31a3ddda166cda86d2b5111e09ba4bda5239fae6 introduced
> a use after free in virtio-pci. The main issue is
> that the release method signals removal of the virtio device,
> while remove signals removal of the pci device.
> 
> For example, on driver removal or hot-unplug,
> virtio_pci_release_dev is called before virtio_pci_remove.
> We then might get a crash as virtio_pci_remove tries to use the
> device freed by virtio_pci_release_dev.
> 
> We allocate/free all resources together with the
> pci device, so we can leave the release method empty.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.  Will push once it's spent a day in linux-next.

Thanks,
Rusty.
