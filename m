From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] vhost_net: support for cross endian guests
Date: Sun, 22 Feb 2015 10:53:51 +0100
Message-ID: <20150222095351.GD17529@redhat.com>
References: <20150220100724.18608.74654.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150220100724.18608.74654.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 20, 2015 at 11:07:24AM +0100, Greg Kurz wrote:
> Hi,
> =

> This patchset allows vhost_net to be used with legacy virtio
> when guest and host have a different endianness. It is based
> on previous work by C=E9dric Le Goater:
> =

> https://www.mail-archive.com/kvm-ppc@vger.kernel.org/msg09848.html
> =

> As suggested by MST:
> - the API now asks for a specific format (big endian) instead of the hint
>   whether byteswap is needed or not (patch 1)
> - rebased on top of the virtio-1 accessors (patch 2)
> =

> Patch 3 is a separate fix: I think it is also valid for virtio-1.

I don't think so. See e.g. this code in tun:
                        gso.csum_offset =3D cpu_to_tun16(tun, skb->csum_off=
set);
looks like it has the correct endian-ness for virtio-1.



> Please comment.
> =

> ---
> =

> Greg Kurz (3):
>       vhost: add VHOST_VRING_F_LEGACY_BIG_ENDIAN flag
>       vhost: add support for legacy virtio
>       vhost_net: fix virtio_net header endianness
> =

> =

>  drivers/vhost/net.c        |   32 ++++++++++++++++++++++++++------
>  drivers/vhost/vhost.c      |    6 +++++-
>  drivers/vhost/vhost.h      |   23 +++++++++++++++++------
>  include/uapi/linux/vhost.h |    2 ++
>  4 files changed, 50 insertions(+), 13 deletions(-)
> =

> --
> Greg
