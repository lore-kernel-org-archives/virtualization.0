From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Sat, 23 Jun 2018 00:43:24 +0300
Message-ID: <20180623003545-mutt-send-email-mst__5566.29749848998$1529703685$gmane$org@kernel.org>
References: <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180622170955.298900c1.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
> Would it be more helpful to focus on generic
> migration support for vfio instead of going about it device by device?

Just to note this approach is actually device by device *type*.  It's
mostly device agnostic for a given device type so you can migrate
between hosts with very different hardware.

And support for more PV device types has other advantages
such as security and forward compatibility to future hosts.

Finally, it all can happen mostly within QEMU. User is currently
required to enable it but it's pretty lightweight.

OTOH vfio migration generally requires actual device-specific work, and
only works when hosts are mostly identical. When they aren't it's easy
to blame the user, but tools for checking host compatiblity are
currently non-existent. Upper layer management will also have to learn
about host and device compatibility wrt migration. At the moment they
can't even figure it out wrt software versions of vhost in kernel and
dpdk so I won't hold my breath for all of this happening quickly.


-- 
MST
