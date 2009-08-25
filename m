From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Mon, 24 Aug 2009 19:38:28 -0600
Message-ID: <7162ab20908241838j47938e74k8b192c31d5b64450__20414.7941586145$1251164372$gmane$org@mail.gmail.com>
References: <20090817123701.GA10700@redhat.com>
	<7162ab20908181354g653ecd2ch3b3dc36ca16babff@mail.gmail.com>
	<20090818210411.GD20393@redhat.com>
	<7162ab20908181411q4209d1f7v64b263712fd74852@mail.gmail.com>
	<20090823192210.GA29928@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090823192210.GA29928@redhat.com>
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

On Sun, Aug 23, 2009 at 1:22 PM, Michael S. Tsirkin<mst@redhat.com> wrote:
>
> Just had a different, but slightly similar problem when the host running
> qemu had forwarding enabled. Is it possible your host is forwarding the
> packets somewhere else, and that's why we get the dupes?
> sysctl -w net.ipv4.conf.all.forwarding=0

Yes!  This seems to be the problem.  As expected, I can just disable
forwarding on eth10 and the duplicates disappear.  Thanks,

Alex
