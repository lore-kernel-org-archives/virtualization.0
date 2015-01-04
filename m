From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] virtio_pci: fix DEBUG_KOBJECT_RELEASE
Date: Sun, 4 Jan 2015 18:21:00 +0200
Message-ID: <20150104162100.GA8153@redhat.com>
References: <1420386340-7719-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1420386340-7719-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: sasha.levin@oracle.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 04, 2015 at 06:02:13PM +0200, Michael S. Tsirkin wrote:
> This is based on Sasha's patch, with some tweaks.
> 


Sasha, I would appreciate it if you can send
a Tested-by tag to confirm this + the del_vqs
idempotent patches are sufficient to address
all issues you have with 3.19.



> Michael S. Tsirkin (2):
>   virtio_pci: device-specific release callback
>   virtio_pci: document why we defer kfree
> 
> Sasha Levin (1):
>   virtio_pci: defer kfree until release callback
> 
>  drivers/virtio/virtio_pci_common.h |  1 -
>  drivers/virtio/virtio_pci_common.c |  9 ---------
>  drivers/virtio/virtio_pci_legacy.c | 12 +++++++++++-
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> MST
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
