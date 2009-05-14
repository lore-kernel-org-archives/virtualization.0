From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCHv5 3/3] virtio_pci: optional MSI-X support
Date: Wed, 13 May 2009 21:16:43 -0500
Message-ID: <4A0B7F0B.8050802__22006.9078765393$1242267473$gmane$org@codemonkey.ws>
References: <cover.1242241196.git.mst@redhat.com>
	<20090513191138.GA4046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513191138.GA4046@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> This implements optional MSI-X support in virtio_pci.
> MSI-X is used whenever the host supports at least 2 MSI-X
> vectors: 1 for configuration changes and 1 for virtqueues.
> Per-virtqueue vectors are allocated if enough vectors
> available.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>   
Acked-by: Anthony Liguori <aliguori@us.ibm.com>

Regards,

Anthony Liguori
