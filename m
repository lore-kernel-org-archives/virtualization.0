From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
Date: Sun, 1 Mar 2020 07:58:49 -0500
Message-ID: <20200301075729-mutt-send-email-mst@kernel.org>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
 <20200301063121-mutt-send-email-mst@kernel.org>
 <CAOEp5Ofzz2CrkbBoPsOAGDVdVJZ07nzH0Usv5h6a96p8+YknwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAOEp5Ofzz2CrkbBoPsOAGDVdVJZ07nzH0Usv5h6a96p8+YknwA@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 01, 2020 at 02:47:41PM +0200, Yuri Benditovich wrote:
> On Sun, Mar 1, 2020 at 1:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Mar 01, 2020 at 01:07:30PM +0200, Yuri Benditovich wrote:
> > > This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> > > VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> > >
> > > Changes from v1:
> > > __virtio -> __le
> > > maximal -> maximum
> > > minor style fixes
> >
> >
> > Looks good to me - sent a bit of consmetics.
> >
> > But as any virtio UAPI change, please CC virtio-dev as virtio TC maintains the
> > interface. Thanks!
> 
> Probably 'virtio-dev' should be added to maintainers file.

Doesn't work because it's a subscriber only list.
I've been asking to fix that for years ...

> >
> > > Yuri Benditovich (3):
> > >   virtio-net: Introduce extended RSC feature
> > >   virtio-net: Introduce RSS receive steering feature
> > >   virtio-net: Introduce hash report feature
> > >
> > >  include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 86 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.17.1
> >
