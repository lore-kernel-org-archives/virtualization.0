From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 0/1] s390/virtio update
Date: Mon, 18 Dec 2017 09:47:16 +0100
Message-ID: <20171218094716.29f85004.cohuck__41019.6728924804$1513586786$gmane$org@redhat.com>
References: <20171214095954.7615-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171214095954.7615-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 14 Dec 2017 10:59:53 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit e073f74a5a39c6dc45f28a5006c21aa94490d9b8:
> 
>   Merge branch 'this' into vhost (2017-12-07 18:39:24 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20171214
> 
> for you to fetch changes up to 619b4b0ba832144d4be899640a2047f9675df849:
> 
>   virtio/s390: implement PM operations for virtio_ccw (2017-12-14 10:32:21 +0100)
> 
> ----------------------------------------------------------------
> Hibernation support for virtio-ccw.
> 
> ----------------------------------------------------------------
> 
> Christian Borntraeger (1):
>   virtio/s390: implement PM operations for virtio_ccw
> 
>  drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Self-NAK; this needs a fixup for !CONFIG_PM.
