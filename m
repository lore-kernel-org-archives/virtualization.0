From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Virtio_console usage of early printk
Date: Tue, 23 Mar 2010 14:25:20 +0530
Message-ID: <20100323085520.GF8675__36709.3137153008$1269334658$gmane$org@amit-x200.redhat.com>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Fran=E7ois?= Diakhate <fdiakh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Mar 22 2010 [18:45:47], Fran=E7ois Diakhate wrote:
> Hi all,
> =

> As far as I can see, early_put_chars is not used by virtio_console
> because it checks whether there is a port available before using it.
> If I understand correctly, this makes it useless because once we have
> a port, we can use the regular virtio transport to output things to
> the console. Does the attached patch seem valid ? Feedback from s390
> and powerpc users who use this functionality would be appreciated.
> =

> Thanks,
> Fran=E7ois

> From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
> From: =3D?utf-8?q?Fran=3DC3=3DA7ois=3D20Diakhat=3DC3=3DA9?=3D <fdiakh@gma=
il.com>
> Date: Thu, 18 Mar 2010 14:48:20 +0100
> Subject: virtio: console: Fix early_put_chars usage
> =

> Currently early_put_chars is not used by virtio_console because it can on=
ly be used once a port has been found, at which point it's too late because=
 it is no longer needed. This patch should fix it.

You'll have to give a signed-off-by for the patch.

		Amit
