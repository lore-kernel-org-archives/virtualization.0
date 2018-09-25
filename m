From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio/s390: fix some races in virtio-ccw
Date: Tue, 25 Sep 2018 17:09:07 +0200
Message-ID: <20180925170907.60750f58.cohuck__862.420714884315$1537888030$gmane$org@redhat.com>
References: <20180925121309.58524-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180925121309.58524-1-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Sep 2018 14:13:07 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The trigger for the series is this bug report:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432
> 
> Changelog:
> v1 -> v2:
> * improve on commit messages, add cc:stable 
> RFC -> v1:
> * do mutual exclusion on a per device basis in ccw_io_helper() 
> 
> Halil Pasic (2):
>   virtio/s390: avoid race on vcdev->config
>   virtio/s390: fix race in ccw_io_helper()
> 
>  drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Thanks, queued.
