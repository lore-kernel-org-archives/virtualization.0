From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v10] virtio-net: add Max MTU configuration field
Date: Wed, 14 Sep 2016 08:21:01 +0200
Message-ID: <a79e0939-b0ca-e312-9320-dbfc4a40f2ee@suse.de>
References: <1473779892-6234-1-git-send-email-aconole@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473779892-6234-1-git-send-email-aconole@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Aaron Conole <aconole@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: Victor Kaplansky <vkaplans@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/13/2016 05:18 PM, Aaron Conole wrote:
> It is helpful for a host to indicate it's MTU to be set on guest NICs
> other than the assumed 1500 byte value.  This helps in situations where
> the host network is using Jumbo Frames, or aiding in PMTU discovery by
> configuring a homogenous network.  It is also helpful for sizing receive
> buffers correctly.
> =

> The change adds a new field to configuration area of network
> devices.  It will be used to pass a maximum MTU from the device to
> the driver.  This will be used by the driver as a maximum value for
> packet sizes during transmission, without segmentation offloading.
> =

> In addition, in order to support backward and forward compatibility,
> we introduce a new feature bit called VIRTIO_NET_F_MTU.
> =

> VIRTIO-152
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> Cc: Victor Kaplansky <victork@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
Very good. I'm needing this for my FCoE over virtio work.

Reviewed-by: Hannes Reiencke <hare@suse.de>

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
