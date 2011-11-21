From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-pci: make reset operation safer
Date: Mon, 21 Nov 2011 15:15:50 +1030
Message-ID: <87obw69j7l.fsf@rustcorp.com.au>
References: <20111117154114.GA31281@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111117154114.GA31281@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 17 Nov 2011 17:41:15 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> virtio pci device reset actually just does an I/O
> write, which in PCI is really posted, that is it
> can complete on CPU before the device has received it.

Thanks, applied.  Because it's a theoretical issue, I've not cc'd
stable.

Thanks,
Rusty.
