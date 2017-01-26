From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] virtio_scsi: Implement fc_host
Date: Thu, 26 Jan 2017 00:34:54 -0800
Message-ID: <20170126083454.GA21942__30945.1866582551$1485419715$gmane$org@infradead.org>
References: <20170126034109.16144-1-famz@redhat.com>
	<20170126034109.16144-3-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170126034109.16144-3-famz@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Cathy Avery <cavery@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 26, 2017 at 11:41:09AM +0800, Fam Zheng wrote:
> This implements the VIRTIO_SCSI_F_FC_HOST feature by reading the config
> fields and presenting them as sysfs fc_host attributes. The config
> change handler is added here because primary_active will toggle during
> migration.

This needs a way, way better description on why the heck we would
even bother with something odd like this.

Also please coordinate with Cathy's "lightweight" FC attrs for storsvcs
as the code seems to be clearly following the "lead" set by Hyper-V.
