From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] VSOCK: Don't call vsock_stream_has_data in atomic context
Date: Thu, 23 Nov 2017 10:02:05 +0000
Message-ID: <CAJSP0QXFknaZboxeEwJmxri2Vjo1GfwK5JwDyWPgEKyi5cJp1g__16123.1575570584$1511431385$gmane$org@mail.gmail.com>
References: <1511261184-45913-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511261184-45913-1-git-send-email-jhansen@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jorgen Hansen <jhansen@vmware.com>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 21, 2017 at 10:46 AM, Jorgen Hansen <jhansen@vmware.com> wrote:
> When using the host personality, VMCI will grab a mutex for any
> queue pair access. In the detach callback for the vmci vsock
> transport, we call vsock_stream_has_data while holding a spinlock,
> and vsock_stream_has_data will access a queue pair.
>
> To avoid this, we can simply omit calling vsock_stream_has_data
> for host side queue pairs, since the QPs are empty per default
> when the guest has detached.
>
> This bug affects users of VMware Workstation using kernel version
> 4.4 and later.
>
> Testing: Ran vsock tests between guest and host, and verified that
> with this change, the host isn't calling vsock_stream_has_data
> during detach. Ran mixedTest between guest and host using both
> guest and host as server.
>
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  net/vmw_vsock/vmci_transport.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
