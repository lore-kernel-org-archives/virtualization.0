From: Fam Zheng <famz@redhat.com>
Subject: Re: [PATCH 2/2] virtio_scsi: Implement fc_host
Date: Tue, 17 Jan 2017 01:26:56 +0800
Message-ID: <20170116172656.GB11780__20971.164716366$1484587645$gmane$org@lemon>
References: <20170116160430.11815-1-famz@redhat.com>
	<20170116160430.11815-3-famz@redhat.com>
	<95f96b48-aa75-0094-a634-db9c13035336@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <95f96b48-aa75-0094-a634-db9c13035336@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 01/16 17:45, Paolo Bonzini wrote:
> 
> 
> On 16/01/2017 17:04, Fam Zheng wrote:
> > +		node_name = virtio_cread64(vdev,
> > +			offsetof(struct virtio_scsi_config, primary_wwnn));
> > +		port_name = virtio_cread64(vdev,
> > +			offsetof(struct virtio_scsi_config, primary_wwpn));
> > +	} else {
> > +		node_name = virtio_cread64(vdev,
> > +			offsetof(struct virtio_scsi_config, secondary_wwnn));
> > +		port_name = virtio_cread64(vdev,
> > +			offsetof(struct virtio_scsi_config, secondary_wwpn));
> 
> Is the endianness correct for big-endian host here?

I think so. The fc_host sysfs uses u64 to represent port_name and node_name,
this patch does the same, so using virtio_* helpers for these fields should
handle the endianness correctly.

Maybe we should use u64 in struct virtio_scsi_config as well?

Fam
