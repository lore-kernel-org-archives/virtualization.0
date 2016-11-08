From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio-net: drop legacy features in virtio 1 mode
Date: Mon, 07 Nov 2016 20:36:08 -0500 (EST)
Message-ID: <20161107.203608.2045895060395892989.davem__25547.992406837$1478569005$gmane$org@davemloft.net>
References: <1478256865-29003-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478256865-29003-1-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 4 Nov 2016 12:55:36 +0200

> Virtio 1.0 spec says VIRTIO_F_ANY_LAYOUT and VIRTIO_NET_F_GSO are
> legacy-only feature bits. Do not negotiate them in virtio 1 mode.  Note
> this is a spec violation so we need to backport it to stable/downstream
> kernels.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied.
