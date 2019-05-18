From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RESEND] vsock/virtio: Initialize core virtio vsock
	before registering the driver
Date: Sat, 18 May 2019 10:51:48 -0700 (PDT)
Message-ID: <20190518.105148.796052200759156053.davem__46482.3015777924$1558201966$gmane$org@davemloft.net>
References: <20190516205107.222003-1-jemoreira@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190516205107.222003-1-jemoreira@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jemoreira@google.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, kernel-team@android.com, sgarzare@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Jorge E. Moreira" <jemoreira@google.com>
Date: Thu, 16 May 2019 13:51:07 -0700

> Avoid a race in which static variables in net/vmw_vsock/af_vsock.c are
> accessed (while handling interrupts) before they are initialized.
 ...
> Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: stable@vger.kernel.org [4.9+]
> Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied and queued up for -stable, thanks.
