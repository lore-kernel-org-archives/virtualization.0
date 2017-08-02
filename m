From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] repost: af_packet vs virtio (was packed ring layout
	proposal v2)
Date: Wed, 2 Aug 2017 16:50:03 +0300
Message-ID: <20170802164931-mutt-send-email-mst__7150.42353044755$1501681816$gmane$org@kernel.org>
References: <20170414051304-mutt-send-email-mst@kernel.org>
	<20170414054318-mutt-send-email-mst@kernel.org>
	<CAJR92jnV1VgBs567QNjO1fHKDgMX=1j1aJJ2gK-TqMB5E1=fvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJR92jnV1VgBs567QNjO1fHKDgMX=1j1aJJ2gK-TqMB5E1=fvw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Luong <sluong99@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com, virtualization@lists.linux-foundation.org, alexei.starovoitov@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 01, 2017 at 08:54:27PM -0700, Steven Luong wrote:
>     * Descriptor ring:
> =

>     Guest adds descriptors with unique index values and DESC_HW set in fl=
ags.
>     Host overwrites used descriptors with correct len, index, and DESC_HW
>     clear.=A0 Flags are always set/cleared last.
> =

>     #define DESC_HW 0x0080
> =

>     struct desc {
>     =A0 =A0 =A0 =A0 __le64 addr;
>     =A0 =A0 =A0 =A0 __le32 len;
>     =A0 =A0 =A0 =A0 __le16 index;
>     =A0 =A0 =A0 =A0 __le16 flags;
>     };
> =

>     When DESC_HW is set, descriptor belongs to device. When it is clear,
>     it belongs to the driver.
> =

>     We can use 1 bit to set direction
>     /* This marks a buffer as write-only (otherwise read-only). */
>     #define VRING_DESC_F_WRITE=A0 =A0 =A0 2
> =

>     * Scatter/gather support
> =

>     We can use 1 bit to chain s/g entries in a request, same as virtio 1.=
0:
> =

>     /* This marks a buffer as continuing via the next field. */
> =

> =

> This comment here is confusing to me. In 1.0, virtq_desc has the next fie=
ld.
> When the flag VRING_DESC_F_NEXT is set, the next entry to continue is spe=
cified
> in the next field.
> =

> Here in 1.1, struct desc does not have the next field, only addr, len, in=
dex,
> and flags. So when VRING_DESC_F_NEXT is set in struct desc's flags field,=
 where
> is the next entry to continue the current descriptor, the entry immediate=
ly
> following the current entry? ie, if the current entry is at index 10 in t=
he
> descriptor table and its flags is set for VRING_DESC_F_NEXT, is the entry
> continuing the current entry in index 11?
> =

> Steven

Exactly, you got it right.
