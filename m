From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Tue, 18 Aug 2009 14:54:23 -0600
Message-ID: <7162ab20908181354g653ecd2ch3b3dc36ca16babff__19868.5705349364$1250629012$gmane$org@mail.gmail.com>
References: <20090817123701.GA10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090817123701.GA10700@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 17, 2009 at 6:37 AM, Michael S. Tsirkin<mst@redhat.com> wrote:
> This adds support for vhost-net virtio kernel backend.
>
> This is RFC, but works without issues for me.

I got this to build by syncing up some headers in kvm/include/linux,
but it doesn't seem to be working quite right.  I have an unused
e1000e nic in my system (eth10,00:17:a4:77:a4:08) that I ifconfig up,
then launch a VM with the option:

-net nic,model=virtio,macaddr=00:17:a4:77:a4:08,vhost=eth10

The virtio nic is functional in the guest, but it gets packet dupes on
ping, which is likely contributing to the poor performance, roughly
1/3rd of virtio-net userspace for tcp_stream and tcp_rr.  I think I
have all the offload option disabled on the nic in the host.  Any idea
what I might be doing wrong?  This seems quite a bit off of the udp_rr
results you posted.  Thanks,

Alex
