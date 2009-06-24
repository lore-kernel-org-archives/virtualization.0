From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
Date: Wed, 24 Jun 2009 13:10:34 +0930
Message-ID: <200906241310.35016.rusty__7046.45052687756$1245814887$gmane$org@rustcorp.com.au>
References: <200906190927.34831.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906190927.34831.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Cc: Tim Hofmann <tim.hofmann@de.ibm.com>, Christian Ehrhardt <ehrhardt@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, Adrian Schneider <adrian.schneider@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 19 Jun 2009 04:57:34 pm Christian Borntr=E4ger wrote:
> Hello Rusty,
>
> this is a result of a two month internship about virtio testing.

Interesting!

> I would like to get feedback on
>
> o  the general idea of a virtio_test module
> o  the user interface ioctls
> o  further ideas and comments

Not mugging real drivers would be a requirement, I think.

> +config VIRTIO_TEST
> +	tristate "Virtio test driver (EXPERIMENTAL)"
> +	select VIRTIO
> +	select VIRTIO_RING

Perhaps these should be depends?  Plus, depends on EXPERIMENTAL.

> +	 If unsure, say M.

That's "N" I think.

> +	case VIOTEST_IOCGETBUF:
> +		ret =3D do_get_buf(vtest, (struct viotest_getbuf __user *) arg);
> +		break;
> +	case VIOTEST_IOCGETCBS:
> +		ret =3D get_callbacks(vtest, (struct viotest_cbinfo __user *) arg);
> +		break;

Generally the point of callbacks is to tell you you have new buffers; in fa=
ct =

you're insulated from callbacks which don't show new buffers.  So I'm not s=
ure =

these two need to be separate?

In which case, a read/write interface starts to make sense (write for addbu=
f =

and kick, read for get_buf).  That fits nicely with O_NONBLOCK and poll().

Cheers,
Rusty.
