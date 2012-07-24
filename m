From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [RFC 0/2] virtio: provide a way for host to monitor critical
	events in the device
Date: Tue, 24 Jul 2012 10:44:34 +0300
Message-ID: <20120724074434.GE26120@redhat.com>
References: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: wency@cn.fujitsu.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, penberg@kernel.org, avi@redhat.com, anthony@codemonkey.ws
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 23, 2012 at 10:32:39PM +0200, Sasha Levin wrote:
> As it was discussed recently, there's currently no way for the guest to notify
> the host about panics. Further more, there's no reasonable way to notify the
> host of other critical events such as an OOM kill.
> 
> This short patch series introduces a new device named virtio-notifier which
> does two simple things:
> 
>  1. Provide a simple interface for the guest to notify the host of critical
To get early OOPSes virtio will have to be compiled into the kernel. If
your are so keen on using virtio for this though, why not just use
dedicated virtio serial channel?

>  events. This is easily expandible to add support for any events we may find
>  interesting for the host to know about.
> 
>  2. Provide an "echo" interface for the host to ping the guest. This allows
>  the host to ping the guest at intervals chosen by the host, and act
>  accordingly if no response has been received.
> 
> Sasha Levin (2):
>   virtio: Introduce virtio-notifier
>   kvm tools: support virtio-notifier
> 
>  drivers/virtio/Kconfig                  |   11 ++
>  drivers/virtio/Makefile                 |    1 +
>  drivers/virtio/virtio_notifier.c        |  135 ++++++++++++++++++++
>  include/linux/virtio_ids.h              |    1 +
>  include/linux/virtio_notifier.h         |   15 +++
>  tools/kvm/Makefile                      |    1 +
>  tools/kvm/builtin-run.c                 |    6 +
>  tools/kvm/include/kvm/virtio-notifier.h |    9 ++
>  tools/kvm/include/kvm/virtio-pci-dev.h  |    1 +
>  tools/kvm/virtio/notifier.c             |  203 +++++++++++++++++++++++++++++++
>  10 files changed, 383 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/virtio/virtio_notifier.c
>  create mode 100644 include/linux/virtio_notifier.h
>  create mode 100644 tools/kvm/include/kvm/virtio-notifier.h
>  create mode 100644 tools/kvm/virtio/notifier.c
> 
> -- 
> 1.7.8.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
			Gleb.
