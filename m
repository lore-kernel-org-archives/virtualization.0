From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Tue, 18 Aug 2009 15:11:04 -0600
Message-ID: <7162ab20908181411q4209d1f7v64b263712fd74852__32848.6593127765$1250629903$gmane$org@mail.gmail.com>
References: <20090817123701.GA10700@redhat.com>
	<7162ab20908181354g653ecd2ch3b3dc36ca16babff@mail.gmail.com>
	<20090818210411.GD20393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090818210411.GD20393@redhat.com>
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

On Tue, Aug 18, 2009 at 3:04 PM, Michael S. Tsirkin<mst@redhat.com> wrote:
> Did you assign ip address in host by any chance? You don't want that.

Nope, just up on the host, no IP:

eth10     Link encap:Ethernet  HWaddr 00:17:a4:77:a4:08
          inet6 addr: fe80::217:a4ff:fe77:a408/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:22446487 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4529008 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1492187453 (1.3 GiB)  TX bytes:2972806236 (2.7 GiB)
          Memory:fbae0000-fbb00000
