From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] Virtual Machine Device Queues(VMDq) support on KVM
Date: Tue, 22 Sep 2009 13:38:07 +0300
Message-ID: <20090922103807.GA2555__6455.50542180917$1253616084$gmane$org@redhat.com>
References: <C85CEDA13AB1CF4D9D597824A86D2B9006AEB94861@PDSMSX501.ccr.corp.intel.com>
	<20090901090518.1193e412@nehalam>
	<200909211637.23299.rusty@rustcorp.com.au>
	<20090921092130.30984dbd@s6510>
	<20090921162718.GM26034@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090921162718.GM26034@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Xin, Xiaohui" <xiaohui.xin@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger <shemminger@vyatta.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 21, 2009 at 09:27:18AM -0700, Chris Wright wrote:
> * Stephen Hemminger (shemminger@vyatta.com) wrote:
> > On Mon, 21 Sep 2009 16:37:22 +0930
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > 
> > > > > Actually this framework can apply to traditional network adapters which have
> > > > > just one tx/rx queue pair. And applications using the same user/kernel interface
> > > > > can utilize this framework to send/receive network traffic directly thru a tx/rx
> > > > > queue pair in a network adapter.
> > > > > 
> > 
> > More importantly, when virtualizations is used with multi-queue
> > NIC's the virtio-net NIC is a single CPU bottleneck. The virtio-net
> > NIC should preserve the parallelism (lock free) using multiple
> > receive/transmit queues. The number of queues should equal the
> > number of CPUs.
> 
> Yup, multiqueue virtio is on todo list ;-)
> 
> thanks,
> -chris

Note we'll need multiqueue tap for that to help.

-- 
MST
