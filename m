From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio-spec: set mac address by a new vq command
Date: Wed, 16 Jan 2013 10:13:28 +0100
Message-ID: <20130116091328.GA6931@stefanha-thinkpad.redhat.com>
References: <1358321604-11712-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358321604-11712-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 16, 2013 at 03:33:24PM +0800, akong@redhat.com wrote:
> +\change_inserted -1930653948 1358320004
> +The command VIRTIO_NET_CTRL_MAC_ADDR_SET is used to set 
> +\begin_inset Quotes eld
> +\end_inset
> +
> +physical
> +\begin_inset Quotes erd
> +\end_inset
> +
> + address of the network card.

The "physical" address of the network card?  That term is not defined
anywhere in the specification.

Perhaps it's best to explain that the config space "mac" field and
VIRTIO_NET_CTRL_MAC_ADDR_SET both set the default MAC address which rx
filtering accepts.  (The MAC table is an additional set of MAC addresses
which rx filtering accepts.)

It would also be worth explaining that VIRTIO_NET_CTRL_MAC_ADDR_SET is
atomic whereas the config space "mac" field is not.  Therefore,
VIRTIO_NET_CTRL_MAC_ADDR_SET is preferred, especially while the NIC is
up.

Stefan
