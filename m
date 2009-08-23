From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Sun, 23 Aug 2009 22:22:11 +0300
Message-ID: <20090823192210.GA29928__13769.9724561118$1251055666$gmane$org@redhat.com>
References: <20090817123701.GA10700@redhat.com>
	<7162ab20908181354g653ecd2ch3b3dc36ca16babff@mail.gmail.com>
	<20090818210411.GD20393@redhat.com>
	<7162ab20908181411q4209d1f7v64b263712fd74852@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7162ab20908181411q4209d1f7v64b263712fd74852@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 18, 2009 at 03:11:04PM -0600, Alex Williamson wrote:
> On Tue, Aug 18, 2009 at 3:04 PM, Michael S. Tsirkin<mst@redhat.com> wrote:
> > Did you assign ip address in host by any chance? You don't want that.
> 
> Nope, just up on the host, no IP:
> 
> eth10     Link encap:Ethernet  HWaddr 00:17:a4:77:a4:08
>           inet6 addr: fe80::217:a4ff:fe77:a408/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:22446487 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:4529008 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1492187453 (1.3 GiB)  TX bytes:2972806236 (2.7 GiB)
>           Memory:fbae0000-fbb00000


Just had a different, but slightly similar problem when the host running
qemu had forwarding enabled. Is it possible your host is forwarding the
packets somewhere else, and that's why we get the dupes?
sysctl -w net.ipv4.conf.all.forwarding=0

-- 
MST
