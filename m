From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Xen-devel] Re: More virtio users
Date: Tue, 12 Jun 2007 14:07:27 +1000
Message-ID: <1181621247.14818.246.camel@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466D04C2.8010403@redhat.com>
	<1181603983.16428.100.camel__36651.2330751449$1181608748$gmane$org@localhost.localdomain>
	<466E14A6.6020400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466E14A6.6020400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> The X fbdev driver is going to make supporting a new fb ioctl pretty 
> fun.  It currently doesn't even support the existing fb ioctls and has a 
> strange abstraction layer.
> 
> I reckon writing a new X driver from scratch (or based on something like 
> the vnc X driver) would be easier in the long run.

Hrm... adding something to X fbdev should be fairly trivial... in fact,
it already have some sort of ShadowFB support which we could use to
track damage though it's less nice than using the damage extension I've
been told.

Ben.
