From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 0/2] virtio-balloon: tweak config_changed
Date: Thu, 3 Jan 2019 10:26:12 +0100
Message-ID: <20190103102612.0226e6dc.cohuck__11586.9087436751$1546507462$gmane$org@redhat.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  3 Jan 2019 13:31:00 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> Since virtio-ccw doesn't work with accessing to the config registers
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.
> 
> Wei Wang (2):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
> 
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 

A quick test (various 'balloon <num>' in the QEMU monitor) with a
virtio-balloon-ccw device seems to work fine here.
