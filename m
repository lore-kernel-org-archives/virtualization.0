From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] virtio_scsi: let host do exception handling
Date: Mon, 26 Jun 2017 13:11:27 -0400
Message-ID: <yq1zicu65ds.fsf__34859.2709437527$1509078620$gmane$org@oracle.com>
References: <20170621143546.5826-1-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170621143546.5826-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 21 Jun 2017 16:35:46 +0200")
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
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Douglas Miller <dougmill@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


Paolo,

> virtio_scsi tries to do exception handling after the default 30
> seconds timeout expires.  However, it's better to let the host control
> the timeout, otherwise with a heavy I/O load it is likely that an
> abort will also timeout.  This leads to fatal errors like filesystems
> going offline.
>
> Disable the 'sd' timeout and allow the host to do exception handling,
> following the precedent of the storvsc driver.

Applied to 4.13/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
