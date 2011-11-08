From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix use after free
Date: Tue, 8 Nov 2011 11:16:16 +0530
Message-ID: <20111108054616.GC2068@amit-x200.redhat.com>
References: <20111107163703.GA10358@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 07 Nov 2011 [18:37:05], Michael S. Tsirkin wrote:
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

Acked-by: Amit Shah <amit.shah@redhat.com>

(note: Adding CC: stable@kernel.org to the commit log is the way
patches get automatically pulled from upstream when committed; CC'ing
stable on submissions won't help with that.)

		Amit
