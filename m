From: Glauber Costa <glommer@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 12/13] qemu: virtio save/load bindings
Date: Tue, 9 Jun 2009 14:45:54 -0300
Message-ID: <20090609174554.GD19375__43823.4730893329$1244586445$gmane$org@poweredge.glommer>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102426.GM26770@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090605102426.GM26770@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

duplicated save config.

> diff --git a/hw/virtio.h b/hw/virtio.h
> index 04a3c3d..ce05517 100644
> --- a/hw/virtio.h
> +++ b/hw/virtio.h
> @@ -72,6 +72,10 @@ typedef struct VirtQueueElement
>  
>  typedef struct {
>      void (*notify)(void * opaque, uint16_t vector);
> +    void (*save_config)(void * opaque, QEMUFile *f);
> +    void (*save_queue)(void * opaque, int n, QEMUFile *f);
> +    int (*load_config)(void * opaque, QEMUFile *f);
> +    int (*load_queue)(void * opaque, int n, QEMUFile *f);
>  } VirtIOBindings;
>  
So, what's the overall effect on a virtual machine that gets migrated,
of a certain device not implementing one of those functions? Will it work?
Will it break?
