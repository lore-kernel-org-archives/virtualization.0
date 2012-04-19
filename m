From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private
	pointer in struct virtqueue
Date: Thu, 19 Apr 2012 11:51:16 +0530
Message-ID: <20120419061958.GA9980@amit.redhat.com>
References: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 18 Apr 2012 [15:33:33], Paolo Bonzini wrote:
> For virtio-scsi multiqueue support I would like to have an easy and
> fast way to go from a virtqueue to the internal struct for that
> queue.
> 
> It turns out that virtio-serial has the same need, but it gets
> by with a simple list walk.
> 
> This patch adds a pointer to struct virtqueue that is reserved for
> the virtio device, and uses it in virtio-serial.
> 
> Cc: Amit Shah <amit.shah@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Untested; what do you think?  Would this patch be acceptable
> 	as is, or only with a more pressing need in virtio-scsi, or never?

Yes, this is useful.  Saves taking a spin lock and walking the list
each time any data is received from the host.

Acked-by: Amit Shah <amit.shah@redhat.com>

Thanks,

		Amit
