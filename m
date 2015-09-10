From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Thu, 10 Sep 2015 10:02:01 -0700
Message-ID: <1441904521.18716.4.camel@ssi>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<alpine.LNX.2.00.1509101356200.23840@localhost.lm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.1509101356200.23840@localhost.lm.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2015-09-10 at 14:02 +0000, Keith Busch wrote:
> On Wed, 9 Sep 2015, Ming Lin wrote:
> > The goal is to have a full NVMe stack from VM guest(virtio-nvme)
> > to host(vhost_nvme) to LIO NVMe-over-fabrics target.
> >
> > Now there are lots of duplicated code with linux/nvme-core.c and qemu/nvme.c.
> > The ideal result is to have a multi level NVMe stack(similar as SCSI).
> > So we can re-use the nvme code, for example
> >
> >                        .-------------------------.
> >                        | NVMe device register    |
> >  Upper level           | NVMe protocol process   |
> >                        |                         |
> >                        '-------------------------'
> >
> >
> >
> >              .-----------.    .-----------.    .------------------.
> > Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
> >              |           |    |           |    |initiator         |
> >              '-----------'    '-----------'    '------------------'
> >
> > todo:
> > - tune performance. Should be as good as virtio-blk/virtio-scsi
> > - support discard/flush/integrity
> > - need Redhat's help for the VIRTIO_ID_NVME pci id
> > - multi level NVMe stack
> 
> Hi Ming,

Hi Keith,

> 
> I'll be out for travel for the next week, so I won't have much time to
> do a proper review till the following week.
> 
> I think it'd be better to get this hierarchy setup to make the most reuse
> possible than to have this much code duplication between the existing
> driver and emulated qemu nvme. For better or worse, I think the generic
> nvme layer is where things are going. Are you signed up with the fabrics
> contributors?

No. How to sign up?
