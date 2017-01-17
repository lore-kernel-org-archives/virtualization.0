From: Fam Zheng <famz@redhat.com>
Subject: Re: [PATCH 0/2] virtio-scsi: Implement FC_HOST feature
Date: Tue, 17 Jan 2017 11:37:14 +0800
Message-ID: <20170117033714.GA21563__32427.455930929$1484624251$gmane$org@lemon.Home>
References: <20170116160430.11815-1-famz@redhat.com>
	<20170116173429.GA3852@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170116173429.GA3852@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 01/16 09:34, Christoph Hellwig wrote:
> On Tue, Jan 17, 2017 at 12:04:28AM +0800, Fam Zheng wrote:
> > This series implements the proposed fc_host feature of virtio-scsi.
> 
> Yikes.  Why?

Hi Christoph, this is mostly to "passthrough" a host NPIV vport (leaving libvirt
doing the heavy lifting to watch and attach all visible LUNs to guest).

Fam

> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
