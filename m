From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] virtio_pmem: fix sparse warning
Date: Tue, 16 Jul 2019 20:02:00 -0700
Message-ID: <CAPcyv4joSgj7ok4DfW3tWQGavRDP8kp7oQRH8DgkG=0eWgNn1g__8657.55486754409$1563332542$gmane$org@mail.gmail.com>
References: <20190712051610.15478-1-pagupta@redhat.com>
	<20190712101021-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190712101021-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Cornelia Huck <cohuck@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yuval shaia <yuval.shaia@oracle.com>, virtualization@lists.linux-foundation.org, lcapitulino@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 12, 2019 at 7:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 10:46:10AM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> >
> > nd_virtio.c:56:28: warning: incorrect type in assignment
> >                                 (different base types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2
> >                                 (different base types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Pls merge - I assume nvdimm tree?

Yes, I'll push this with the rest to Linus tomorrow morning.
