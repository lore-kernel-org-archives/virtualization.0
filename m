From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Introduce extended RSC feature
Date: Wed, 30 Jan 2019 11:28:09 -0500
Message-ID: <20190130101618-mutt-send-email-mst__45772.6294336439$1548873467$gmane$org@kernel.org>
References: <20190129125236.12165-1-yuri.benditovich@daynix.com>
	<20190129110636-mutt-send-email-mst@kernel.org>
	<CAOEp5OfBWVcSnVEm2S3VhOYH3uv+vdUvT5z2yss9v8wvriiKtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAOEp5OfBWVcSnVEm2S3VhOYH3uv+vdUvT5z2yss9v8wvriiKtA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 30, 2019 at 09:42:07AM +0200, Yuri Benditovich wrote:
> =

> =

> On Tue, Jan 29, 2019 at 6:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> =

>     On Tue, Jan 29, 2019 at 02:52:36PM +0200, Yuri Benditovich wrote:
>     > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
>     > is able to provide extended RSC information. When the feature
>     > is active and 'gso_type' field in received packet is not GSO_NONE,
>     > the device reports number of coalesced packets in 'csum_start'
>     > field and number of duplicated acks in 'csum_offset' field
>     > and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 include/uapi/linux/virtio_net.h | 15 ++++++++++++++-
>     >=A0 1 file changed, 14 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/
>     virtio_net.h
>     > index a3715a3224c1..93c71d714475 100644
>     > --- a/include/uapi/linux/virtio_net.h
>     > +++ b/include/uapi/linux/virtio_net.h
>     > @@ -56,7 +56,7 @@
>     >=A0 #define VIRTIO_NET_F_MQ=A0 =A0 =A0 22=A0 =A0 =A0 /* Device suppo=
rts Receive Flow
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 * Steering */
>     >=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=A0 =A0 =A0 =A0 /* Set MAC =
address */
>     > -
>     > +#define VIRTIO_NET_F_RSC_EXT=A0 =A061=A0 =A0 /* Provides extended =
RSC info */
>     >=A0 #define VIRTIO_NET_F_STANDBY=A0 =A062=A0 =A0 /* Act as standby f=
or another
>     device
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 * with the same MAC.
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 */
>     > @@ -104,6 +104,7 @@ struct virtio_net_config {
>     >=A0 struct virtio_net_hdr_v1 {
>     >=A0 #define VIRTIO_NET_HDR_F_NEEDS_CSUM=A0 1=A0 =A0 =A0 =A0/* Use cs=
um_start,
>     csum_offset */
>     >=A0 #define VIRTIO_NET_HDR_F_DATA_VALID=A0 2=A0 =A0 =A0 =A0/* Csum i=
s valid */
>     > +#define VIRTIO_NET_HDR_F_RSC_INFO=A0 =A0 4=A0 =A0/* rsc_ext data i=
n csum_ fields
>     */
>     >=A0 =A0 =A0 =A0__u8 flags;
>     >=A0 #define VIRTIO_NET_HDR_GSO_NONE=A0 =A0 =A0 =A0 =A0 =A0 =A0 0=A0 =
=A0 =A0 =A0/* Not a GSO frame
>     */
>     >=A0 #define VIRTIO_NET_HDR_GSO_TCPV4=A0 =A0 =A01=A0 =A0 =A0 =A0/* GS=
O frame, IPv4 TCP
>     (TSO) */
>     > @@ -140,6 +141,18 @@ struct virtio_net_hdr_mrg_rxbuf {
>     >=A0 =A0 =A0 =A0struct virtio_net_hdr hdr;
>     >=A0 =A0 =A0 =A0__virtio16 num_buffers; /* Number of merged rx buffer=
s */
>     >=A0 };
>     > +
>     > +static inline __virtio16 *virtio_net_rsc_ext_num_packets(
>     > +=A0 =A0 =A0struct virtio_net_hdr *hdr)
>     > +{
>     > +=A0 =A0 =A0return &hdr->csum_start;
>     > +}
>     > +
>     > +static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
>     > +=A0 =A0 =A0struct virtio_net_hdr *hdr)
>     > +{
>     > +=A0 =A0 =A0return &hdr->csum_offset;
>     > +}
>     >=A0 #endif /* ...VIRTIO_NET_NO_LEGACY */

I also wonder why do we want to put this code in the legacy section
and use the legacy virtio_net_hdr as opposed to the new virtio_net_hdr_v1.

> =

>     Coding style is off here. But really I don't think these inlines are
>     needed here. Put them in qemu or something.
> =

> =

> =

> The are copied from qemu as is (what exactly is wrong?).


coding style says:

	Descendants are always substantially shorter than the parent and
	are placed substantially to the right.

placing a line to the left of ( doesn't count as substantially to the
right :)
Maybe start a new line at virtio_net_rsc_ext_num_dupacks.

Lack of documentation is also a problem.

> The reason I place these inlines here is following:
> We pull this include sometimes to virtio-win repo exactly as qemu do.
> If I place them into qemu, then we'll have these inlines in virtio-win an=
d in
> qemu and they are not synchronized.
> =

> So, I suggest to keep them in one common header and fix style problems, i=
f they
> present.=A0
> Please respond if you still disagree.

Okay but this assumes specific usage. E.g. someone might want
an offset and not a pointer. Or have a struct instance on stack.

Given all above issues (and also header version issues
described above) I'm inclined to say macros are better:


#define virtio_net_rsc_ext_num_packets csum_start
#define virtio_net_rsc_ext_num_dupacks csum_offset


But please in any case also add documentation same as we have for
fields.

> =

>     >=A0 /*
>     > --
>     > 2.17.1
> =
