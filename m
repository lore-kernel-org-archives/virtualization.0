From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2 virtio-next] remoteproc: Add support for host virtio
	rings (vringh)
Date: Mon, 22 Apr 2013 16:08:02 +0300
Message-ID: <CAK=WgbZoqD5aoLt6nqGW3Y42=e_qK2kH0hf0FTLJr=WGW81Azg@mail.gmail.com>
References: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365543588-5152-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>
Cc: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Sjur and Rusty,

On Wed, Apr 10, 2013 at 12:39 AM, Sjur Br=E6ndeland
<sjur.brandeland@stericsson.com> wrote:
> Implement the vringh callback functions in order
> to manage host virito rings and handle kicks.
> This allows virtio device to request host-virtio-rings.
>
> Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>

Thanks for pushing this.

I have a few observations which I'd like to discuss with Rusty and you.

Rusty - will you be willing to consider a few patches to virtio which
will considerably simplify kernel users of vringh (such as this one) ?

The main motivation is to reduce code duplication and complexity.
Right now the code handling vringh is awfully similar to the one
handling regular vrings, with a few asymmetries:
- We need to call and maintain the vrh_callback_t pointer directly,
instead of relying on vring_interrupt()
- We have some vringh creation boilerplate code of our own very
similar to what vring_new_virtqueue is doing for regular vrings
- It seems that a driver which has both regular rings and host rings
(as caif does) will have to "find_vqs" them twice - once for the
regular rings and one for the host rings - where each of those
invocations will use its own set of indices. To simplify drivers it
might be nice if we had a single find_rings function which would
enumerate both regular and host rings using a single indices axis. It
may presumably take two nvqs params, one for the regular rings and the
other for the host rings, and we can arbitrarily decide it always
creates the regular rings first.

Stuff which will be nice to change along these lines:

- maintain the vrh_callback_t pointer in struct vringh, similarly to
what struct virtqueue does today for callbacks of regular rings
- when kicked, just call vring_interrupt, and let it demultiplex the
event to the appropriate ring (whether it is regular or host ring)
- try to push code from rproc_create_new_vringh into virtio, following
the lines of vring_new_virtqueue and regular rings
- try to merge the regular and host rings versions of the
find_vqs/del_vqs boilerplate code to avoid duplication

I guess this all depends on how such patches will look like and
whether we can reach an elegant implementation. I'm also aware that
host rings are being used by user space too, and we must not break
anything.

Thanks,
Ohad.
