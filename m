From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2 00/12] Introduce host-side virtio queue and CAIF Virtio.
Date: Fri, 11 Jan 2013 16:02:22 +0100
Message-ID: <CAJK669Zw1kZkJCS_Bs=emWtofj69m4XFDaNRhqY9DMdbi4MwZA@mail.gmail.com>
References: <871ug75vp1.fsf@rustcorp.com.au>
	<1354718230-4486-1-git-send-email-sjur@brendeland.net>
	<20121206102750.GF10837@redhat.com>
	<877goc0wac.fsf@rustcorp.com.au>
	<CAJK669bP41oBhJ=MB64NS21Ag7XO5WswuTiVKCFTb96nvmyBiw@mail.gmail.com>
	<87pq1f2rj0.fsf@rustcorp.com.au> <87wqvl1g9s.fsf@rustcorp.com.au>
	<CAJK669Z-bGTeQe8qJpTJP7simbSvQ8cgFZefs5QRMkmxtFYY4g@mail.gmail.com>
	<87pq1c1uj4.fsf@rustcorp.com.au> <877gnk1ayv.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877gnk1ayv.fsf@rustcorp.com.au>
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
Cc: Linus Walleij <linus.walleij@linaro.org>, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2013 at 7:37 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>virtio_host: host-side implementation of virtio rings (untested!)
>
>Getting use of virtio rings correct is tricky, and a recent patch saw
>an implementation of in-kernel rings (as separate from userspace).

How do you see the in-kernel API for this? I would like to see
something similar to my previous patches, where we extend
the virtqueue API. E.g. something like this:

struct virtqueue *vring_new_virtqueueh(unsigned int index,
				       unsigned int num,
				       unsigned int vring_align,
				       struct virtio_device *vdev,
				       bool weak_barriers,
				       void *pages,
				       void (*notify)(struct virtqueue *),
				       void (*callback)(struct virtqueue *),
				       const char *name);

int virtqueueh_get_iov(struct virtqueue *vqh,
		       struct vringh_iov *riov,
		       struct vringh_iov *wiov,
		       gfp_t gfp);

int virtqueueh_add_iov(struct virtqueue *vqh,
		       struct vringh_iov *riov,
		       struct vringh_iov *wiov);

I guess implementation of the host-virtqueue should stay in drivers/virtio?

Regards,
Sjur
