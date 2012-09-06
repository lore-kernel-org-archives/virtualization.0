From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: support reserved vqs
Date: Thu, 06 Sep 2012 12:11:50 +0930
Message-ID: <874nnbj2j5.fsf__16268.4547053233$1346900516$gmane$org@rustcorp.com.au>
References: <20120905184745.GA15861@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120905184745.GA15861@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>"Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Stratos Psomadakis <psomas@cslab.ece.ntua.gr>, "David S. Miller" <davem@davemloft.net>, lguest@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> virtio network device multiqueue support reserves
> vq 3 for future use (useful both for future extensions and to make it
> pretty - this way receive vqs have even and transmit - odd numbers).
> Make it possible to skip initialization for
> specific vq numbers by specifying NULL for name.
> Document this usage as well as (existing) NULL callback.
>
> Drivers using this not coded up yet, so I simply tested
> with virtio-pci and verified that this patch does
> not break existing drivers.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This seems sane.  Applied.

Thanks,
Rusty.
