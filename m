From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 0/2] virtio_scsi: Set can_queue based on size of
	virtqueue.
Date: Thu, 10 Aug 2017 20:24:40 -0400
Message-ID: <yq14ltf2bp3.fsf__29212.0642996908$1509079068$gmane$org@oracle.com>
References: <20170810165652.21515-1-rjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170810165652.21515-1-rjones@redhat.com> (Richard W. M. Jones's
	message of "Thu, 10 Aug 2017 17:56:50 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org


Richard,

> v1 was here:
>
>   https://lkml.org/lkml/2017/8/10/689
>
> v1 -> v2:
>
>   Remove .can_queue field from the templates.

Applied to 4.14/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
