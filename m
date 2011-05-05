From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 07/18] virtio ring: inline function to check for events
Date: Thu, 5 May 2011 09:34:46 +0100
Message-ID: <BANLkTi=eH-iK7L2LBAm0eqidapqXqhSqxw__38924.5471837514$1304584637$gmane$org@mail.gmail.com>
References: <cover.1304541918.git.mst@redhat.com>
	<cc4596a5ecdbf8dd37b5567a36667e3841f18ca3.1304541919.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cc4596a5ecdbf8dd37b5567a36667e3841f18ca3.1304541919.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 4, 2011 at 9:51 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> With the new used_event and avail_event and features, both
> host and guest need similar logic to check whether events are
> enabled, so it helps to put the common code in the header.
>
> Note that Xen has similar logic for notification hold-off
> in include/xen/interface/io/ring.h with req_event and req_prod
> corresponding to event_idx + 1 and new_idx respectively.
> +1 comes from the fact that req_event and req_prod in Xen start at 1,
> while event index in virtio starts at 0.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> =A0include/linux/virtio_ring.h | =A0 14 ++++++++++++++
> =A01 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index f791772..2a3b0ea 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -124,6 +124,20 @@ static inline unsigned vring_size(unsigned int num, =
unsigned long align)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ sizeof(__u16) * 3 + sizeof(struct vring_=
used_elem) * num;
> =A0}
>
> +/* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
> +/* Assuming a given event_idx value from the other size, if

s/other size/other side/ ?

Stefan
