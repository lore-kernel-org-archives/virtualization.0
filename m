From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 virtio-next] remoteproc: Add support for host virtio
	rings (vringh)
Date: Tue, 23 Apr 2013 13:16:13 +0930
Message-ID: <87txmxgb96.fsf@rustcorp.com.au>
References: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
	<CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Cc: Sjur =?utf-8?Q?Br=C3=A6ndela?= =?utf-8?Q?nd?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, mst@redhat.com, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ohad Ben-Cohen <ohad@wizery.com> writes:
> Hi Sjur and Rusty,
> Stuff which will be nice to change along these lines:
>
> - maintain the vrh_callback_t pointer in struct vringh, similarly to
> what struct virtqueue does today for callbacks of regular rings
> - when kicked, just call vring_interrupt, and let it demultiplex the
> event to the appropriate ring (whether it is regular or host ring)
> - try to push code from rproc_create_new_vringh into virtio, following
> the lines of vring_new_virtqueue and regular rings
> - try to merge the regular and host rings versions of the
> find_vqs/del_vqs boilerplate code to avoid duplication
>
> I guess this all depends on how such patches will look like and
> whether we can reach an elegant implementation. I'm also aware that
> host rings are being used by user space too, and we must not break
> anything.

Oh, we can break everything :)

I was concentrating purely on the mechanics of the virtqueue, mainly
because vhost has special needs wrt tracking changes.  vhost doesn't use
vringh yet because my patches are slightly suboptimal (I stick with the
vhost API, just replace the guts with vringh).  Michael has a
simplification of vhost-net pending, which will make altering this much
easier.

But CAIF isn't the right thing to optimize for, either.  It's weird to
have both host and guest rings at the same time, and I don't see other
users doing that (ie. vhost_net and tcm_vhost).  But if we can make it
easier for you without overly uglifying vringh, that'd be great.

And yes, I'd like a core of code which I can license liberally to
include or ship alongside the spec.  But I think we can manage that.

Cheers,
Rusty.
