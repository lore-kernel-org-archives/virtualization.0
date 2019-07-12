From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: Use struct_size() helper
Date: Fri, 12 Jul 2019 10:14:23 -0400
Message-ID: <20190712101408-mutt-send-email-mst__33451.793696598$1562941450$gmane$org@kernel.org>
References: <20190619192833.GA825@embeddedor>
 <yq1a7dk9kb5.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <yq1a7dk9kb5.fsf@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 11, 2019 at 08:18:54PM -0400, Martin K. Petersen wrote:
> 
> Gustavo,
> 
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> 
> Applied to 5.4/scsi-queue, thanks!

Oh I put it in the virtio tree already.
Can't hurt I guess :)

> -- 
> Martin K. Petersen	Oracle Linux Engineering
