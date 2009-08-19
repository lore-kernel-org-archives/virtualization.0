From: Or Gerlitz <ogerlitz@voltaire.com>
Subject: Re: [PATCH 0/3] qemu-kvm: vhost net support
Date: Wed, 19 Aug 2009 11:11:38 +0300
Message-ID: <4A8BB3BA.3040806__32710.7696947225$1250669629$gmane$org@Voltaire.com>
References: <20090810192304.GA16781@redhat.com>	<4A808840.70704@codemonkey.ws>
	<20090812173548.GA29981@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090812173548.GA29981@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Well, I definitely see some gain in latency.
> Here's a simple test over a 1G ethernet link (host to guest):

> Native:
> 126976 126976 1        1       10.00    10393.23

> vhost virtio:
> 126976 126976 1        1       10.00    8169.58

> Userspace virtio:
> 126976 126976 1        1       10.00    2029.49

Hi Michael,

Can you provide udp stream numbers for small packets, so we can see the 
packets-per-second gain? e.g -- -m 22 which should account for 64 byte frames.

Or.
