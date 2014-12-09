From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] virtio_ccw: minor enhancements
Date: Tue, 9 Dec 2014 18:27:53 +0100
Message-ID: <20141209182753.632da537.cornelia.huck@de.ibm.com>
References: <1418133187-12436-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418133187-12436-1-git-send-email-mst@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 9 Dec 2014 15:53:32 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Two enhancements for virtio_ccw, on top of latest 1.0 patchset
> 
> Cornelia Huck (1):
>   virtio_ccw: finalize_features error handling
> 
> Michael S. Tsirkin (1):
>   virtio_ccw: future-proof finalize_features
> 
>  drivers/s390/kvm/virtio_ccw.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 

I tried to run this as a guest kernel with my virtio-1 qemu branch +
your revision patch on top and it at least boots :) More testing
tomorrow.
