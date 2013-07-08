From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Mon, 8 Jul 2013 08:44:06 +0300
Message-ID: <20130708054406.GA7387@redhat.com>
References: <20130619082417.GA2558@redhat.com> <51C16BC2.2060302@redhat.com>
	<8761x9mrmk.fsf@rustcorp.com.au> <51C2CABD.70000@redhat.com>
	<87ppv3tb3y.fsf@rustcorp.com.au> <51D16EB8.3050709@redhat.com>
	<87txkdfqg6.fsf@rustcorp.com.au> <20130704074942.GA4777@redhat.com>
	<20130707113138.GA31372@redhat.com>
	<8738rpg82k.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8738rpg82k.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 08, 2013 at 10:51:39AM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, Jul 04, 2013 at 10:49:42AM +0300, Michael S. Tsirkin wrote:
> >> > case).
> >> > 
> >> > Regrettably, initial driver implementations used simple layouts
> >> > and devices came to rely on it, despite this specification 
> >> > wording. It is thus recommended that drivers be conservative in 
> >> > their assumptions, unless specific device features indicate that 
> >> > general layout is permitted using VIRTIO_F_ANY_LAYOUT. In
> >> > addition, some implementations may have large-but-reasonable
> >> > restrictions on total descriptor size (such as based on IOV_MAX
> >> > in the host OS). This has not been a problem in practice: little
> >> > sympathy will be given to drivers which create unreasonably-sized
> >> > descriptors such as dividing a network packet into 1500
> >> > single-byte descriptors!
> >> 
> >> That's fine with me too.
> >> So which bit are we using for this?
> >> I'd like to rebase to latest bits and merge the optimization for 3.11.
> >
> >
> > Rusty, could you please tell me which feature bit do you
> > prefer for ANY_LAYOUT?
> > It would be sad to miss another release of both qemu and kernel with
> > this obvious optimization for the only reason we can't settle on a bit
> > to use to signal it.
> 
> Let's use bit 30.  Here's the kernel patch:
> 
> virtio: VIRTIO_F_ANY_LAYOUT feature
> 
> Also known as the "no really, I read the spec" bit.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This is already used in qemu:
/* A guest should never accept this.  It implies negotiation is broken. */
#define VIRTIO_F_BAD_FEATURE            30



> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b7cda39..4b5da48 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -51,4 +51,7 @@
>   * suppressed them? */
>  #define VIRTIO_F_NOTIFY_ON_EMPTY	24
>  
> +/* Can the device handle any descriptor layout? */
> +#define VIRTIO_F_ANY_LAYOUT		30
> +
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
