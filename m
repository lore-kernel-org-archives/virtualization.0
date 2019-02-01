From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/6] drm/virtio: params struct for
	virtio_gpu_cmd_create_resource_3d()
Date: Fri, 1 Feb 2019 09:01:13 +0100
Message-ID: <20190201080113.mhlzpyek62cfc5qe__4647.70382256887$1549068727$gmane$org@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-5-kraxel@redhat.com>
	<4d3064ef-9993-106a-74b5-73a29c08975e@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4d3064ef-9993-106a-74b5-73a29c08975e@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 11:47:38AM +0100, Noralf Tr=F8nnes wrote:
> =

> =

> Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> > Add 3d resource parameters to virtio_gpu_object_params struct.  With
> > that in place we can use it for virtio_gpu_cmd_resource_create_3d()
> > calls.
> > =

> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> =

> You don't remove the struct virtio_gpu_resource_create_3d definition,
> but it looks like there's no users left?

virtio_gpu_cmd_resource_create_3d() still uses it (and has to, it is
part of the guest <-> host protocol).

cheers,
  Gerd
