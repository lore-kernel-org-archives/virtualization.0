From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 2/5] vringfd base/offset
Date: Tue, 8 Apr 2008 07:14:36 +0200
Message-ID: <200804080714.37011.arnd__21925.4609699876$1207631818$gmane$org@arndb.de>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<200804052204.28518.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052204.28518.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 05 April 2008, Rusty Russell wrote:
> =A0static const struct file_operations vring_fops =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0.release=A0=A0=A0=A0=A0=A0=A0=A0=3D vring_release,
> =A0=A0=A0=A0=A0=A0=A0=A0.write=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D vring_wri=
te,
> =A0=A0=A0=A0=A0=A0=A0=A0.poll=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D vring_p=
oll,
> +=A0=A0=A0=A0=A0=A0=A0.ioctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D vring_ioctl,
> =A0};

This should also set the .compat_ioctl pointer. If the argument =

is defined as an actual memory location instead of a pointer,
you also don't need the compat_ptr() conversion for s390x, so
both can point to the same vring_ioctl function.

	Arnd <><
